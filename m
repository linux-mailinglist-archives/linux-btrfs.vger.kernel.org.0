Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1912E3FEE32
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbhIBM7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 08:59:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbhIBM7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 08:59:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 17A591FF97;
        Thu,  2 Sep 2021 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630587502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtR/WSv+c64ZdsF7J1nMGklf1ytIHCgOcNZidPvIN3Y=;
        b=L35A4tiekulVgoZ2oNC5h/ZeqXOCe5ICkOt6fENQ3iXf8PG8Fn2gi1TCel2+9mFYINkxMg
        E3hAtfFOSI3lUNCu3BSL1yIncyx4Tq0r2ebDSo2YIf+KMCDX0DQ9ANR84UDfEiXu5sknLe
        wu5GeSDo0/VDvwO9W10cTvAeNHdrPBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630587502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtR/WSv+c64ZdsF7J1nMGklf1ytIHCgOcNZidPvIN3Y=;
        b=H3sXT9ib4qtrOsujHbfu+AncZQckwmpvXt5TUK8wG1HgQM2Xdap/FUKJW/25sQ9LbUgz2J
        H1ecO20YAnMMsDBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 06C14A3B9F;
        Thu,  2 Sep 2021 12:58:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2BB2DA72B; Thu,  2 Sep 2021 14:58:20 +0200 (CEST)
Date:   Thu, 2 Sep 2021 14:58:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
Message-ID: <20210902125820.GR3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 05:01:14PM -0400, Josef Bacik wrote:
> We got the following lockdep splat while running xfstests (specifically
> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
> converted loop to using workqueues, which comes with lockdep
> annotations that don't exist with kworkers.  The lockdep splat is as
> follows
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2-custom+ #34 Not tainted
> ------------------------------------------------------
> losetup/156417 is trying to acquire lock:
> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600
> 
> but task is already holding lock:
> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        lo_open+0x28/0x60 [loop]
>        blkdev_get_whole+0x28/0xf0
>        blkdev_get_by_dev.part.0+0x168/0x3c0
>        blkdev_open+0xd2/0xe0
>        do_dentry_open+0x163/0x3a0
>        path_openat+0x74d/0xa40
>        do_filp_open+0x9c/0x140
>        do_sys_openat2+0xb1/0x170
>        __x64_sys_openat+0x54/0x90
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        blkdev_get_by_dev.part.0+0xd1/0x3c0
>        blkdev_get_by_path+0xc0/0xd0
>        btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>        btrfs_control_ioctl+0xac/0x170 [btrfs]
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (uuid_mutex){+.+.}-{3:3}:
>        __mutex_lock+0xba/0x7c0
>        btrfs_rm_device+0x48/0x6a0 [btrfs]
>        btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#11){.+.+}-{0:0}:
>        lo_write_bvec+0x112/0x290 [loop]
>        loop_process_work+0x25f/0xcb0 [loop]
>        process_one_work+0x28f/0x5d0
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x170
>        ret_from_fork+0x22/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>        process_one_work+0x266/0x5d0
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x170
>        ret_from_fork+0x22/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>        __lock_acquire+0x1130/0x1dc0
>        lock_acquire+0xf5/0x320
>        flush_workqueue+0xae/0x600
>        drain_workqueue+0xa0/0x110
>        destroy_workqueue+0x36/0x250
>        __loop_clr_fd+0x9a/0x650 [loop]
>        lo_ioctl+0x29d/0x780 [loop]
>        block_ioctl+0x3f/0x50
>        __x64_sys_ioctl+0x83/0xb0
>        do_syscall_64+0x3b/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> Chain exists of:
>   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>  Possible unsafe locking scenario:
>        CPU0                    CPU1
>        ----                    ----
>   lock(&lo->lo_mutex);
>                                lock(&disk->open_mutex);
>                                lock(&lo->lo_mutex);
>   lock((wq_completion)loop0);
> 
>  *** DEADLOCK ***
> 1 lock held by losetup/156417:
>  #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> 
> stack backtrace:
> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Call Trace:
>  dump_stack_lvl+0x57/0x72
>  check_noncircular+0x10a/0x120
>  __lock_acquire+0x1130/0x1dc0
>  lock_acquire+0xf5/0x320
>  ? flush_workqueue+0x84/0x600
>  flush_workqueue+0xae/0x600
>  ? flush_workqueue+0x84/0x600
>  drain_workqueue+0xa0/0x110
>  destroy_workqueue+0x36/0x250
>  __loop_clr_fd+0x9a/0x650 [loop]
>  lo_ioctl+0x29d/0x780 [loop]
>  ? __lock_acquire+0x3a0/0x1dc0
>  ? update_dl_rq_load_avg+0x152/0x360
>  ? lock_is_held_type+0xa5/0x120
>  ? find_held_lock.constprop.0+0x2b/0x80
>  block_ioctl+0x3f/0x50
>  __x64_sys_ioctl+0x83/0xb0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f645884de6b
> 
> Usually the uuid_mutex exists to protect the fs_devices that map
> together all of the devices that match a specific uuid.  In rm_device
> we're messing with the uuid of a device, so it makes sense to protect
> that here.
> 
> However in doing that it pulls in a whole host of lockdep dependencies,
> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
> we end up with the dependency chain under the uuid_mutex being added
> under the normal sb write dependency chain, which causes problems with
> loop devices.
> 
> We don't need the uuid mutex here however.  If we call
> btrfs_scan_one_device() before we scratch the super block we will find
> the fs_devices and not find the device itself and return EBUSY because
> the fs_devices is open.  If we call it after the scratch happens it will
> not appear to be a valid btrfs file system.

This is a bit hand wavy but the critical part of the correctness proof,
and it's not explaining it enough IMO. The important piece happens in
device_list_add, the fs_devices lookup and EBUSY, but all that is now
excluded completely by the uuid_mutex from running in parallel with any
part of rm_device.

This means that the state of the device is seen complete by each (scan,
rm device). Without the uuid mutex the scaning can find the signature,
then try to lookup the device in the list, while in parallel the rm
device changes the signature or manipulates the list. But not everything
is covered by the device list mutex so there are combinations of both
tasks with some in-progress state.  Also count in the RCU protection.

From high level it is what you say about ordering scan/scratch, but
otherwise I'm not convinced that the change is not subtly breaking
something.
