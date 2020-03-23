Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340201901CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCWXU7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 23 Mar 2020 19:20:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48842 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWXU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 19:20:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EB1D862A6D6; Mon, 23 Mar 2020 19:18:51 -0400 (EDT)
Date:   Mon, 23 Mar 2020 19:18:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200323231851.GT13306@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
 <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 23, 2020 at 09:50:03PM +0100, Goffredo Baroncelli wrote:
> On 3/23/20 12:49 AM, Zygo Blaxell wrote:
> > On Sun, Mar 22, 2020 at 09:38:30AM +0100, Goffredo Baroncelli wrote:
> > > On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:
> > > 
> > > > 
> > > > To me it seems complicated to
> > > [sorry I push the send button too early]
> > > 
> > > To me it seems too complicated (and error prone) to derive the target profile from an analysis of the filesystem.
> > > 
> > > Any thoughts ?
> > 
> > I still don't understand the use case you are trying to support.
> > 
> > There are 3 states for a btrfs filesystem:
> > 
> [...]
> > 
> > 	3.  A conversion is interrupted prior to completion.  Sysadmin is
> > 	expected to proceed immediately back to state #2, possibly after
> > 	taking any necessary recovery actions that triggered entry into
> > 	state #3.  It doesn't really matter what the current allocation
> > 	profile is, since it is likely to change before we allocate
> > 	any more block groups.
> > 
> > You seem to be trying to sustain or support a filesystem in state #3 for
> > a prolonged period of time.  Why would we do that?  If your use case is
> > providing information or guidance to a user, tell them how to get back
> > to state #2 ASAP, so that they can then return to state #1 where they
> > should be.
> 
> Believe me: I *don't want* to sustain #3 at all; btrfs is already too
> complex. Supporting multiple profile is the worst thing that we can do.
> However #3 exists and it could cause unexpected results. I think that on
> this we agree.
> > 
> [...]
> 
> > There could be a warning message in dmesg if we enter state #3.
> > This message would appear after a converting balance is cancelled or
> > aborted, and on mount when we scan block groups (which we would still need
> > to do even after we added a "target profile" field to the superblock).
> > Userspace like 'btrfs fi df' could also put out a warning like "multiple
> > allocation profiles detected, but conversion is not in progress.  Please
> > finish conversion at your earliest convenience to avoid disappointment."
> > I don't see the need to do anything more about it.
> 
> It would help that every btrfs command should warn the users about an
> "un-wanted" state like this.

Patches welcome...

> > been explicitly cancelled at sysadmin request.
> > 
> Not only, you can enter in state #3 if you do something like:
> 
> $ sudo btrfs balance start -dconvert=single,usage=50 t/.
> 
> where you convert some chunk but not other.

Sure, but now you're intentionally doing weird (or sufficiently advanced)
stuff.  Given a combination of balance flags like that (convert + other
restrictions), we should assume the user knows what they're doing, and
stay out of the way.

The existing code that inserts 'usage=90' when resuming a balance,
though highly questionable, still presumes the user knows what they're
doing when a balance has a convert in it, and doesn't modify the usage
filter setting in that case.

It's fairly normal to want to run something like this when changing
RAID profiles on a big array:

	# Make lots of free space quickly
	for x in $(seq 0 100); do
		btrfs balance start -dconvert=single,soft,usage=$x t/.
	done
	# OK now do the full BGs, will be slow
	btrfs balance start -dconvert=single,soft t/.

Should that print 101 warnings as it runs?  What if the user is using
python-btrfs (e.g. to order the block groups by usage) and not the
btrfs-progs tools, or some other UI?  Do we write warnings from inside
the kernel?  Will there be a "--quiet" option that suppresses the warning?
(I suppose if the answer to the last two questions is "yes" then we just
need patches to get it done).

> This is the point: we can consider the "failed automation" an unexpected
> event, however doing "btrfs bal stop" or the command above cannot be
> considered as unexpected event.

Balance cancel is always unexpected.

"balance cancel" is a sysadmin forcing balance to exit using the error
recovery code.  If early termination of a conversion was _expected_,
the sysadmin would have used 'limit' or 'vrange' or 'usage' or 'devid'
or some other filter parameter so that balance does what it was told
to do _without being cancelled_.

> [...]
> 
> > I'd even consider removing the heuristics that are already there for
> > prioritizing profiles.  They are just surprising and undocumented
> > behavior, and it would be better to document it as "random, BTW you
> > should finish your conversion now."
> 
> I agree that we should remove this kind of heuristic.
> Doing so I think that, with moderate effort, btrfs can track what is the
> wanted profile (i.e. the one at the mkfs time or the one specified in last balance
> w/convert [*]) and uses it. To me it seems the natural thing to do. Noting more
> nothing less.

It already kind of does--the balance convert parameters are stored on
disk so it can be resumed after a umount or pause.  "Pause" implies
resuming later, and saving all the state required to do so.  "Cancel"
says something different, "forget what you were doing and wait for new
instructions," so cancel wipes out the conversion target profile.

> We can't prevent a mixed profile filesystem (it has to be allowed the
> possibility to stop a long activity like the balance), but we should
> prevent the unexpected behavior: if we change the profile and something
> goes wrong, the next chunk allocation should be clear. The user don't have
> to read the code to understand what will happen.
>  [*] we can argue which would be the expected profile after an interrupted balance:
> the former one or the latter one ?

If we can argue about it, then there's no right answer, and the status
quo is fine (or we need a more complete solution).

> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
