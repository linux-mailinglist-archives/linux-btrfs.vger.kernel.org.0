Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6C19434B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgCZPgG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 26 Mar 2020 11:36:06 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35986 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZPgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 11:36:05 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 96BA66375E7; Thu, 26 Mar 2020 11:36:04 -0400 (EDT)
Date:   Thu, 26 Mar 2020 11:36:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] Fix up some stupid delayed ref flushing behaviors
Message-ID: <20200326153603.GY13306@hungrycats.org>
References: <20200313211220.148772-1-josef@toxicpanda.com>
 <20200325135146.GA5920@twin.jikos.cz>
 <e28e8818-bd8e-707f-c749-d00f7a5c913a@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e28e8818-bd8e-707f-c749-d00f7a5c913a@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 25, 2020 at 10:12:30AM -0400, Josef Bacik wrote:
> On 3/25/20 9:51 AM, David Sterba wrote:
> > On Fri, Mar 13, 2020 at 05:12:15PM -0400, Josef Bacik wrote:
> > > While debugging Zygo's delayed ref problems it was clear there were a bunch of
> > > cases that we're running delayed refs when we don't need to be, and they result
> > > in a lot of weird latencies.
> > > 
> > > Each patch has their individual explanations.  But the gist of it is we run
> > > delayed refs in a lot of arbitrary ways that have just accumulated throughout
> > > the years, so clean up all of these so we can have more consistent performance.
> > 
> > It would be fine to remove the delayed refs being run from so many
> > places but I vaguely remember some patches adding them with "we have to
> > run delayed refs here or we will miss something and that would be a
> > corruption". The changelogs in patches from 3 on don't point out any
> > specific problems and I miss some reasoning about correctness, ideally
> > for each line of btrfs_run_delayed_refs removed.
> > 
> > As a worst case I really don't want to get to a situation where we start
> > getting reports that something broke because of the missing delayed
> > refs, followed by series of "oh yeah I forgot we need it here, add it
> > back".
> 
> Yeah I went through and checked each of these spots to see why we had them.
> A lot of it had to do with how poorly delayed refs were run previously.  You
> could end up with weird ordering cases and missing our flags.
> 
> These problems are all gone now, we no longer have to run delayed refs to
> work around ordering weirdness because I fixed all of those problems.  Now
> these are just old relics of the past that need to die.  The only case where
> I didn't touch them is for qgroups, likely because it still matters for the
> before/after lookups there.
> 
> But everywhere else it was working around some deficiency in how we ran
> delayed refs, either in the ordering issues or space related.  Both those
> problems no longer exist, so we can drop these workarounds.
> 
> > 
> > The branch with this patchset is in for-next but I'm still not
> > comfortable with adding it to misc-next as I can't convince myself it's
> > safe, so more reviews are welcome.
> > 
> 
> Yeah I'm targeting the merge window after the upcoming one with these,
> there's still a lot more testing I want to get done.  I mostly threw them up
> because they were no longer blowing up constantly for Zygo, and I wanted
> Filipe to get an early look at them.  Thanks,

No longer blowing up _constantly_, but there was definitely a 2-3 day
cadence between blowups last time I rebased.  Test runs were ending in
splats due to KASAN UAF bugs and bad unlock balances.  It doesn't seem
to be corrupting on-disk metadata, but my test VMs can't get anywhere
close to a week uptime under the full stress load yet.

I'd like to keep a test VM pointed at this as it makes it way upstream.
It's an important set of changes, but it has a high regression risk.
There are some big changes here, and that's going to expose all the gaps
in developers' knowledge of how stuff really works.

Do I just keep rebasing on for-next-<date>?

> Josef
