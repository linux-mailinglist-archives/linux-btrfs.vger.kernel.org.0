Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4953C4828BF
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiAAXM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 18:12:58 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:47182 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbiAAXM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 18:12:57 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6087612FC08; Sat,  1 Jan 2022 18:12:56 -0500 (EST)
Date:   Sat, 1 Jan 2022 18:12:55 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: 'btrfs replace' hangs at end of replacing a device (v5.10.82)
Message-ID: <YdDf9xTbdRwgE9JS@hungrycats.org>
References: <20211129214647.GH17148@hungrycats.org>
 <cfceba98-f925-8a95-5b09-caec932efc42@suse.com>
 <eb5804bc-10d0-ab12-73c4-bcaa08b297e0@suse.com>
 <YdDB0PSBKa2GMAPV@hungrycats.org>
 <ac3a3216-2beb-3365-0430-38865faccc83@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3a3216-2beb-3365-0430-38865faccc83@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 01, 2022 at 11:07:24PM +0200, Nikolay Borisov wrote:
> >>> I have a working hypothesis what might be going wrong, however without a
> >>> crash dump to investigate I can't really confirm it. Basically I think
> >>> btrfs_rm_dev_replace_blocked is not seeing the decrement aka the store
> >>> to running bios count since it's using cond_wake_up_nomb. If I'm right
> >>> then the following should fix it:
> >>>
> >>> @@ -1122,7 +1123,8 @@ void btrfs_bio_counter_inc_noblocked(struct
> >>> btrfs_fs_info *fs_info)
> >>>  void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
> >>>  {
> >>>         percpu_counter_sub(&fs_info->dev_replace.bio_counter, amount);
> >>> -       cond_wake_up_nomb(&fs_info->dev_replace.replace_wait);
> >>> +       /* paired with the wait_event barrier in replace_blocked */
> >>> +       cond_wake_up(&fs_info->dev_replace.replace_wait);
> >>>  }
> >>
> >> Ping, any feedback on this patch?
> > 
> > I've had a VM running 37 replaces completed without hanging.  In the
> > 2 failing cases, I hit the KASAN bug[1] and the dedupe/logical_ino/bees
> > lockup bug[2].
> 
> How does that compare vs without the patch? The KASAN thing looks like
> raid56-related so I'd discount it. The logical_ino lockup also isn't
> directly related to this patch.

I added the device replace loop to my existing regression test workload
(with a kernel that has KASAN enabled) and left it since the beginning
of December.  So it's testing for all the currently known and active
bugs at once (the ghost dirents bug, the logical_ino bug, and the dev
replace hang, as well as general regressions affecting our workload)
and counting how often each kind of failure event occurs.

The KASAN thing would probably disrupt bio counters during a replace?
It wouldn't explain replace hangs on RAID1, but maybe there are multiple
separate bugs here.  KASAN isn't enabled on our baremetal hosts where
the majority of device replace operations are running, so any previous
UAF bugs would have been invisible.  We are replacing drives in RAID1
and RAID5 profiles.

Note these test results are for 5.10.  On kernels starting with 5.11,
the logical_ino bug hits every few hours so replace never gets a chance
to finish running.  All the hangs do make it easier to test for ghost
dirents though.  We use every part of the buffalo.

> So without the patch you should have had
> some incident rate greater than 0 of the replace lock up ?

Under the same conditions without the patch, there would be between 10
and 30 replace hangs by now.

> > [1] https://lore.kernel.org/linux-btrfs/Ycqu1Wr8p3aJNcaf@hungrycats.org/
> > [2] https://lore.kernel.org/linux-btrfs/Ybz4JI+Kl2J7Py3z@hungrycats.org/
> > 
> >>> Can you apply it and see if it can reproduce, I don't know what's the
> >>> incident rate of this bug so you have to decide at what point it should
> >>> be fixed. In any case this patch can't have any negative functional
> >>> impact, it just makes the ordering slightly stronger to ensure the write
> >>> happens before possibly waking up someone on the queue.
> >>>
> >>>
> >>
> > 
> 
