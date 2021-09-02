Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A503FED9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbhIBMRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 08:17:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbhIBMRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 08:17:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25782224E2;
        Thu,  2 Sep 2021 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630584971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0EVUqXFS4oU7iASyyvdR8qPI/KCt1kgoy2iXLtiH6k=;
        b=0soAUQSWHzU9GQfIyTNcTbO4803KsbJmqKtdGrz5nMlbYbmywd48dM+PViZ7+Csf5+qHsp
        5/yoCcCwHgjCokNmthbw1zg9jdCnQT5zeB/fmV2odUdowWdORodfZQqqIfa1W7Bv29Qtj8
        pZ5SU2gmJtnl4Tlz4t9xGdhFJTpo2WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630584971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0EVUqXFS4oU7iASyyvdR8qPI/KCt1kgoy2iXLtiH6k=;
        b=4a8pmLlDHYJJ/QjdXI8c+0b/TK4HJsi4CREs1UMMTI816n8INpFLwLC5vc64Gbr3b9uMb0
        2zzXEinLMywERkCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DF30CA3BA3;
        Thu,  2 Sep 2021 12:16:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8FCA5DA72B; Thu,  2 Sep 2021 14:16:09 +0200 (CEST)
Date:   Thu, 2 Sep 2021 14:16:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 4/7] btrfs: update the bdev time directly when closing
Message-ID: <20210902121608.GP3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <7a02499fac5a53031b333ce58d84089c8ce9e329.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a02499fac5a53031b333ce58d84089c8ce9e329.1627419595.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 05:01:16PM -0400, Josef Bacik wrote:
> We update the ctime/mtime of a block device when we remove it so that
> blkid knows the device changed.  However we do this by re-opening the
> block device and calling filp_update_time.  This is more correct because
> it'll call the inode->i_op->update_time if it exists, but the block dev
> inodes do not do this.  Instead call generic_update_time() on the
> bd_inode in order to avoid the blkdev_open path and get rid of the
> following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #406 Not tainted
> ------------------------------------------------------
> losetup/11596 is trying to acquire lock:
> ffff939640d2f538 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0
> 
> but task is already holding lock:
> ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&lo->lo_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x7d/0x750
>        lo_open+0x28/0x60 [loop]
>        blkdev_get_whole+0x25/0xf0
>        blkdev_get_by_dev.part.0+0x168/0x3c0
>        blkdev_open+0xd2/0xe0
>        do_dentry_open+0x161/0x390
>        path_openat+0x3cc/0xa20
>        do_filp_open+0x96/0x120
>        do_sys_openat2+0x7b/0x130
>        __x64_sys_openat+0x46/0x70
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (&disk->open_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x7d/0x750
>        blkdev_get_by_dev.part.0+0x56/0x3c0
>        blkdev_open+0xd2/0xe0
>        do_dentry_open+0x161/0x390
>        path_openat+0x3cc/0xa20
>        do_filp_open+0x96/0x120
>        file_open_name+0xc7/0x170
>        filp_open+0x2c/0x50
>        btrfs_scratch_superblocks.part.0+0x10f/0x170
>        btrfs_rm_device.cold+0xe8/0xed
>        btrfs_ioctl+0x2a31/0x2e70
>        __x64_sys_ioctl+0x80/0xb0
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#12){.+.+}-{0:0}:
>        lo_write_bvec+0xc2/0x240 [loop]
>        loop_process_work+0x238/0xd00 [loop]
>        process_one_work+0x26b/0x560
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x160
>        ret_from_fork+0x1f/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>        process_one_work+0x245/0x560
>        worker_thread+0x55/0x3c0
>        kthread+0x140/0x160
>        ret_from_fork+0x1f/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>        __lock_acquire+0x10ea/0x1d90
>        lock_acquire+0xb5/0x2b0
>        flush_workqueue+0x91/0x5e0
>        drain_workqueue+0xa0/0x110
>        destroy_workqueue+0x36/0x250
>        __loop_clr_fd+0x9a/0x660 [loop]
>        block_ioctl+0x3f/0x50
>        __x64_sys_ioctl+0x80/0xb0
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&lo->lo_mutex);
>                                lock(&disk->open_mutex);
>                                lock(&lo->lo_mutex);
>   lock((wq_completion)loop0);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by losetup/11596:
>  #0: ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> stack backtrace:
> CPU: 1 PID: 11596 Comm: losetup Not tainted 5.14.0-rc2+ #406
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>  dump_stack_lvl+0x57/0x72
>  check_noncircular+0xcf/0xf0
>  ? stack_trace_save+0x3b/0x50
>  __lock_acquire+0x10ea/0x1d90
>  lock_acquire+0xb5/0x2b0
>  ? flush_workqueue+0x67/0x5e0
>  ? lockdep_init_map_type+0x47/0x220
>  flush_workqueue+0x91/0x5e0
>  ? flush_workqueue+0x67/0x5e0
>  ? verify_cpu+0xf0/0x100
>  drain_workqueue+0xa0/0x110
>  destroy_workqueue+0x36/0x250
>  __loop_clr_fd+0x9a/0x660 [loop]
>  ? blkdev_ioctl+0x8d/0x2a0
>  block_ioctl+0x3f/0x50
>  __x64_sys_ioctl+0x80/0xb0
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
