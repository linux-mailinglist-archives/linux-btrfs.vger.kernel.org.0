Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA838C091
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhEUHTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 03:19:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40384 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEUHTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 03:19:34 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8A7B7A6DA3F; Fri, 21 May 2021 03:18:10 -0400 (EDT)
Date:   Fri, 21 May 2021 03:18:10 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210521071810.GA11733@hungrycats.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
 <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 05:20:50PM +0100, Graham Cobb wrote:
> On 19/05/2021 16:32, Johannes Thumshirn wrote:
> > On 19/05/2021 16:28, David Sterba wrote:
> >> On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:
> >>> On 18/05/2021 16:52, David Sterba wrote:
> >>> I wonder if this interface would make sense for limiting balance
> >>> bandwidth as well?
> >>
> >> Balance is not contained to one device, so this makes the scrub case
> >> easy. For balance there are data and metadata involved, both read and
> >> write accross several threads so this is really something that the
> >> cgroups io controler is supposed to do.
> >>
> > 
> > For a user initiated balance a cgroups io controller would work well, yes.

Don't throttle balance.  You can only make _everything_ slower with
throttling.  You can't be selective, e.g. making balance slower than
the mail server.

> Hmmm. I might give this a try. On my main mail server balance takes a
> long time and a lot of IO, which is why I created my "balance_slowly"
> script which shuts down mail (and some other services) then runs balance
> for 20 mins, then cancels the balance and allows mail to run for 10
> minutes, then resumes the balance for 20 mins, etc. 
> Using this each month, a balance takes over 24 hours

My question here is:  wait?  What?  Are you running full balances
every...ever?  Why?

If you have unallocated space and are not in danger of running out,
you don't need to balance anything.  Even if you are running low on
unallocated space, balance -dlimit=1 will usually suffice to get a single
GB of unallocated space--the minimum required to avoid metadata ENOSPC
gotchas.

Never balance metadata.  Maintenance metadata balances are extremely slow,
do nothing useful, and can exacerbate ENOSPC gotchas.

Metadata balance must be used to convert a different raid profile, or
permanently remove a drive from a filesystem--but only because there
is no better way to do those things in btrfs.

> but at least the only problem is
> short mail delays for 1 day a month, not timeouts, users seeing mail
> error reports, etc.

I run btrfs on some mail servers with crappy spinning drives.

One balance block group every day--on days when balance runs at all--only
introduces a one-time 90-second latency.  Not enough to kill a SMTP
transaction.

Backup snapshot deletes generate more latency (2-4 minutes once a day).
That is long enough to kill a SMTP transaction, but pretty much every
non-spammer sender will retry sooner than the next backup.

> Before I did this, the impact was horrible: btrfs spent all its time
> doing backref searches and any process which touched the filesystem (for
> example to deliver a tiny email) could be stuck for over an hour.
> 
> I am wondering whether the cgroups io controller would help, or whether
> it would cause a priority inversion because the backrefs couldn't do the
> IO they needed so the delays to other processes locked out would get
> even **longer**. Any thoughts?

Yes that is pretty much exactly what happens.

Balance spends a tiny fraction of its IO cost moving data blocks around.
Each data extent that is relocated triggers a reference update,
which goes into a queue for the current btrfs transaction.  On its
way through that queue, each ref update cascades into updates on other
tree pages for parent nodes, csum tree items, extent tree items, and
(if using space_cache=v2) free space tree items.  These are all small
random writes that have performance costs even on non-rotating media,
much more expensive than the data reads and writes which are mostly
sequential and consecutive.  Worst-case write multipliers are 3-digit
numbers for each of the trees.  It is not impossible for one block group
relocation--balance less than 1GB of data--to run for _days_.

On a filesystem with lots of tiny extents (like a mail server), the
data blocks will be less than 1% of the balance IO.  The other 99%+ are
metadata updates.  If there is throttling on those, any thread trying
to write to the filesystem stops dead in the next transaction commit,
and stays blocked until the throttled IO completes.

If other threads are writing to the filesystem, it gets even worse:
the running time of delayed ref flushes is bounded only by available
disk space, because only running out of disk space can make btrfs stop
queueing up more work for itself in transaction commit.

Even threads that aren't writing to the throttled filesystem can get
blocked on malloc() because Linux MM shares the same pool of pages for
malloc() and disk writes, and will block memory allocations when dirty
limits are exceeded anywhere.  This causes most applications (i.e. those
which call malloc()) to stop dead until IO bandwidth becomes available
to btrfs, even if the processes never touch any btrfs filesystem.
Add in VFS locks, and even reading threads block.

The best currently available approach is to minimize balancing.  Don't do
it at all if you can avoid it, and do only the bare minimum if you can't.

On the other hand, a lot of these problems can maybe be reduced or
eliminated by limiting the number of extents balance processes each time
it goes through its extent iteration loop.  Right now, balance tries to
relocate an entire block group in one shot, but maybe that's too much.
Instead, balance could move a maximum of 100 extents (or some number
chosen to generate about a second's worth of IO), then do a transaction
commit to flush out the delayed refs queue while it's still relatively
small, then repeat.  This would be very crude throttling since we'd have
to guess how many backrefs each extent has, but it will work far better
for reducing latency than any throttling based on block IO.
