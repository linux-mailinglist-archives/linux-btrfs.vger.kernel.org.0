Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C145D156D0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 00:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBIXQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 18:16:55 -0500
Received: from mail.rptsys.com ([23.155.224.45]:24266 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgBIXQy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 18:16:54 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Feb 2020 18:16:54 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id BD91714FB8DC58;
        Sun,  9 Feb 2020 17:11:03 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dhOLMTcn0l3D; Sun,  9 Feb 2020 17:11:01 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 9B5D414FB8D97D;
        Sun,  9 Feb 2020 17:11:01 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 9B5D414FB8D97D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1581289861; bh=mJ4fNU7PeUqph4rsbywYMvWqH0IXeGqu9wAzfMnzQfM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=V57pgcjNtACjdnsdh0vqDHqVA2HQvdhyMmR3yRKzz3OJNzlBh5LX7G4L1o//V2Ry0
         SkDt+/8H/Su7KcCz1O2hUl49kUs99Wc2PVKBoT18dlKWU8ISzHx/yrw2ftlU7aidg0
         nsam9Q1eJLHsoCWqvFrgiAUAfgEAYDBfM3x9BDr0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PI4DkfHNcuxm; Sun,  9 Feb 2020 17:11:01 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 73E1D14FB8D936;
        Sun,  9 Feb 2020 17:11:01 -0600 (CST)
Date:   Sun, 9 Feb 2020 17:11:00 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Martin Raiber <martin@urbackup.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <427597294.18207443.1581289860634.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <010201702aecfa9f-9cda3f94-c05f-4fe0-b6b0-5803c086dc65-000000@eu-west-1.amazonses.com>
References: <20200209004307.GG13306@hungrycats.org> <010201702aecfa9f-9cda3f94-c05f-4fe0-b6b0-5803c086dc65-000000@eu-west-1.amazonses.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times,
 watchdog evasion on 5.4.11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: data rolled back 5 hours after crash, long fsync running times, watchdog evasion on 5.4.11
Thread-Index: +cyMgXyRMM4A0P6mYLU0mdb3GmLG/g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Martin Raiber" <martin@urbackup.org>
> To: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>, "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Sunday, February 9, 2020 11:08:58 AM
> Subject: Re: data rolled back 5 hours after crash, long fsync running times, watchdog evasion on 5.4.11

> On 09.02.2020 01:43 Zygo Blaxell wrote:
>> I reproduced a filesystem rollback similar to one reported back in
>> November by Timothy Pearson:
>>
>> 	https://www.spinics.net/lists/linux-btrfs/msg94318.html
>>
>> The timeline is something like this:
>>
>> 1.  System gets loaded, lots of writes, a few processes calling fsync().
>> Fairly normal stuff.
>>
>> 2.  Just enough new data is written continuously to keep a transaction
>> from finishing, but not enough to block new writes (i.e. the filesystem
>> is kept in equilibrium between dirty_background_bytes and dirty_bytes).
>> Typically an application gets stuck in fsync() here, but the rest of
>> the system is unaffected.  Here is one:
>>
>> 	TIMESTAMP: Fri Feb  7 01:03:21 EST 2020
>> 	==> /proc/31872/task/31872/stack <==
>> 	[<0>] wait_on_page_bit+0x172/0x250
>> 	[<0>] read_extent_buffer_pages+0x2e5/0x3a0
>> 	[<0>] btree_read_extent_buffer_pages+0xa3/0x120
>> 	[<0>] read_tree_block+0x4e/0x70
>> 	[<0>] read_block_for_search.isra.34+0x1aa/0x350
>> 	[<0>] btrfs_search_slot+0x20a/0x940
>> 	[<0>] lookup_extent_data_ref+0x7e/0x210
>> 	[<0>] __btrfs_free_extent.isra.45+0x22f/0xa10
>> 	[<0>] __btrfs_run_delayed_refs+0x2d5/0x12d0
>> 	[<0>] btrfs_run_delayed_refs+0x105/0x1b0
>> 	[<0>] btrfs_commit_transaction+0x52/0xa70
>> 	[<0>] btrfs_sync_file+0x248/0x490
>> 	[<0>] vfs_fsync_range+0x48/0x80
>> 	[<0>] do_fsync+0x3d/0x70
>> 	[<0>] __x64_sys_fdatasync+0x17/0x20
>> 	[<0>] do_syscall_64+0x5f/0x1f0
>> 	[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> 3.  The transid of the subvol roots never increases as long as the balance
>> of incoming and outgoing data flows in #2 is maintained.  This can go on
>> for hours or even days on recent kernels (much longer than was possible on
>> 5.0). In this particular case it was 3 hours, in earlier cases I've caught
>> it delayed by 14 hours or more, and been able to recover by pausing write
>> workloads long enough for btrfs to keep up.  Here is an excerpt from bees
>> logs showing this (the filesystem's current transid is the "count" field):
>>
>> 	2020-02-07 00:04:24 10386.10408<7> crawl_transid: Polling 561.882s for next 100
>> 	transid RateEstimator { count = 4441796, raw = 7412.98 / 42429.6, ratio =
>> 	7412.98 / 42440.2, rate = 0.174669, duration(1) = 5.72512, seconds_for(1) = 1 }
>>
>> and 3 hours later the filesystem transid hasn't moved:
>>
>> 	2020-02-07 03:06:53 10386.10408<7> crawl_transid: Polling 719.095s for next 100
>> 	transid RateEstimator { count = 4441796, raw = 6248.72 / 45912.8, ratio =
>> 	6248.72 / 45928.7, rate = 0.136053, duration(1) = 7.35009, seconds_for(1) = 1 }
>>
>> 4.  Most writes continue without incident:  git commits, log files,
>> bees dedupe, kernel builds, rsync all run normally.  Some things block:
>> applications that call fsync() or sync() get stuck.  Snapshot creation
>> blocks.  Maintenance balances, when the maintenance window opens, also
>> block, and snapshot deletes are then blocked waiting for balance.
>>
>> In most cases this is as far as we get:  eventually something breaks
>> the equilibrium from #2, the stalled transaction commit completes,
>> and everything is normal; however, in this case, we never finish the
>> transaction.  fsync (the same one!) is still running some hours later:
>>
>> 	TIMESTAMP: Fri Feb  7 03:47:40 EST 2020
>> 	==> /proc/31872/task/31872/stack <==
>> 	[<0>] btrfs_tree_lock+0x120/0x260
>> 	[<0>] btrfs_lock_root_node+0x34/0x50
>> 	[<0>] btrfs_search_slot+0x4d5/0x940
>> 	[<0>] lookup_inline_extent_backref+0x164/0x5a0
>> 	[<0>] __btrfs_free_extent.isra.45+0x1f0/0xa10
>> 	[<0>] __btrfs_run_delayed_refs+0x2d5/0x12d0
>> 	[<0>] btrfs_run_delayed_refs+0x105/0x1b0
>> 	[<0>] btrfs_commit_transaction+0x52/0xa70
>> 	[<0>] btrfs_sync_file+0x248/0x490
>> 	[<0>] vfs_fsync_range+0x48/0x80
>> 	[<0>] do_fsync+0x3d/0x70
>> 	[<0>] __x64_sys_fdatasync+0x17/0x20
>> 	[<0>] do_syscall_64+0x5f/0x1f0
>> 	[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> We know it's the same fsync call because a supervisor process killed
>> pid 31872 with SIGKILL at around 01:10.  It's not deadlocked here--the
>> stack changes continuously the whole time--but it doesn't finish running.
>>
>> 5.  2 hours later, lstat() in the watchdog daemon blocks:
>>
>> 	TIMESTAMP: Fri Feb  7 05:15:07 EST 2020
>> 	4506 pts/10   DN+    0:00 /bin/bash /root/bin/watchdog-mdtest
>> 	==> /proc/4506/task/4506/stack <==
>> 	[<0>] lookup_slow+0x2c/0x60
>> 	[<0>] walk_component+0x1bf/0x330
>> 	[<0>] path_lookupat.isra.44+0x6d/0x220
>> 	[<0>] filename_lookup.part.59+0xa0/0x170
>> 	[<0>] user_path_at_empty+0x3e/0x50
>> 	[<0>] vfs_statx+0x76/0xe0
>> 	[<0>] __do_sys_newlstat+0x3d/0x70
>> 	[<0>] __x64_sys_newlstat+0x16/0x20
>> 	[<0>] do_syscall_64+0x5f/0x1f0
>> 	[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Up to that point, a few processes have been blocked for up to 5 hours,
>> but this is not unusual on a big filesystem given #1.  Usually processes
>> that read the filesystem (e.g. calling lstat) are not blocked, unless they
>> try to access a directory being modified by a process that is blocked.
>> lstat() being blocked is unusual.
>>
>> 6.  60 seconds later, the system reboots due to watchdog timeout.
>>
>> Upon reboot, the filesystem reverts to its state at the last completed
>> transaction 4441796 at #2, which is 5 hours earlier.  Everything seems to
>> be intact, but there is no trace of any update to the filesystem after
>> the transaction 4441796.  The last 'fi usage' logged before the crash
>> and the first 'fi usage' after show 40GB of data and 25GB of metadata
>> block groups freed in between.
>>
>> I have only observed this on kernel 5.4, but I've seen the commit blocking
>> behavior twice in two days.  I have not observed it so far on 5.0 and
>> earlier (since it was released in March 2019).  I don't have data from
>> kernels in between due to other test-blocking bugs.
>>
>> TBH I can't really say 5.0 _doesn't_ do this--while writing this post,
>> I've seen some transactions on 5.0 running for 5-10 minutes, and I
>> haven't been checking for this specific behavior in earlier testing;
>> however, 5.0 crashes a lot, so if there was a behavior like this in 5.0,
>> I'd expect somebody would have noticed.
>>
>> On kernel 5.4 we see fewer processes blocked under heavy write loads,
>> but the processes that do block are blocked longer.  In particular, our
>> watchdog daemon, which creates and removes a directory every 30 seconds
>> to detect lockups, didn't fire.  The system ran for 3 hours before the
>> watchdog detected a problem in this case, and the previous day the system
>> ran 14 hours without completing a transaction and the watchdog didn't
>> fire at all.  We'll add an fsync to the watchdog too, as the logs for
>> systems running 5.4 are full of processes stuck many hours in fsync.
>>
>> Going forward we will add an alert to our server monitoring to verify that
>> the superblock's generation number field updates at regular intervals
>> (at least once an hour) and apply a workaround if not.  I'll also add
>> to my test workload and start a bisect to see if this is a regression in
>> recent kernels.
>>
>> There is a workaround:  detect when the superblock generation field stops
>> updating, and pause (freeze or SIGSTOP) all writing processes long enough
>> for btrfs to catch up and complete the current transaction.
> 
> I have the same problem. Have a dozen threads with high throughput
> (simply writing data to a single file sequentially) combined with a
> dozen threads doing metadata-heavy workloads and it'll take a long time
> for a sync() to finish. Work-around is the same as well: Throttle the
> application if the sync doesn't finish after a (configurable) amount of
> time.
> I have seen the same problem with ZFS on FreeBSD, though, so it is by no
> means btrfs or even Linux specific. My guess is that since most file
> systems are constrained/throttled by journal (size), there is no
> mechanism for metadata vs. data fairness.
> As for most congestion problems the best solution is to increase
> capacity (storage IOPS) so everything runs below max capacity most of
> the time or to throttle at the source to reach the same goal.
> 
> https://www.spinics.net/lists/linux-btrfs/msg72909.html was my report
> back then, maybe take a look at the number of btrfs_delayed_ref_head in
> slabtop as well?

If I might suggest a stopgap measure, simply firing a warning in the kernel log to the effect of "metadata write bandwidth insufficient, DATA LOSS MAY OCCUR" in this situation would be most helpful.  As it stands right now largest problem isn't so much the reversion effect itself as the silence until the data loss occurs -- the system isn't sending any messages that anything is potentially wrong, so using BTRFS feels like playing Russian Roulette at the moment  Downstream apps don't exactly tend to list their maximum sustained IOPS, so trying to balance array IOPS with application IOPS across a large server cluster is not feasible from a pure calculation standpoint, and is normally done semi-empirically knowing the worst case effect is app stall, not data loss for an indeterminate, relatively large period along with potential data corruption.

This same thought applies to ZFS, assuming it is also silently eating data in the situation mentioned.  Very interesting to know it's a general problem with this class of storage.

Thanks!
