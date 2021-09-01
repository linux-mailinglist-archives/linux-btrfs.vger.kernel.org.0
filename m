Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36B3FE0EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbhIARJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:09:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbhIARJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:09:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F20402244D;
        Wed,  1 Sep 2021 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630516108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6U3ZBfhSbNKQ0pny0fz/02o+gUqEhmhnJq0oBwj5kk=;
        b=eKL6CzuQHxC6qGilsP8UwJE8uG2MTCQHsIXkL4XfXlM08F0T/NXGdqCiJivWXKomlMGf3k
        ZwSJfXwZgZUlOqFNekg/KBoc7JPutyl0eFo8OJlpHjkilKuq9a2YqL1H2GoRn0gTv9e3Uz
        Z8EwcT3BynzQJaz4ZwSwo9BkFlO2sb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630516108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6U3ZBfhSbNKQ0pny0fz/02o+gUqEhmhnJq0oBwj5kk=;
        b=PMm4/Znxcne3zdiwSPJUMqxExpNTsqNKEGtAAzWRm4EoV7ATG85FZHHJsBIaI7KRD0K8vk
        WprV01bTba3N3dCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CE607A3B85;
        Wed,  1 Sep 2021 17:08:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96061DA835; Wed,  1 Sep 2021 19:08:27 +0200 (CEST)
Date:   Wed, 1 Sep 2021 19:08:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
Message-ID: <20210901170826.GO3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <495dbc7e-dd93-e43a-3af1-6597f35d38e8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495dbc7e-dd93-e43a-3af1-6597f35d38e8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 01, 2021 at 08:01:24PM +0800, Anand Jain wrote:
> On 28/07/2021 05:01, Josef Bacik wrote:
> > We got the following lockdep splat while running xfstests (specifically
> > btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
> > by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
> > converted loop to using workqueues, which comes with lockdep
> > annotations that don't exist with kworkers.  The lockdep splat is as
> > follows
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.14.0-rc2-custom+ #34 Not tainted
> > ------------------------------------------------------
> > losetup/156417 is trying to acquire lock:
> > ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600
> > 
> > but task is already holding lock:
> > ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> > 
> > which lock already depends on the new lock.
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
> >         __mutex_lock+0xba/0x7c0
> >         lo_open+0x28/0x60 [loop]
> >         blkdev_get_whole+0x28/0xf0
> >         blkdev_get_by_dev.part.0+0x168/0x3c0
> >         blkdev_open+0xd2/0xe0
> >         do_dentry_open+0x163/0x3a0
> >         path_openat+0x74d/0xa40
> >         do_filp_open+0x9c/0x140
> >         do_sys_openat2+0xb1/0x170
> >         __x64_sys_openat+0x54/0x90
> >         do_syscall_64+0x3b/0x90
> >         entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #4 (&disk->open_mutex){+.+.}-{3:3}:
> >         __mutex_lock+0xba/0x7c0
> >         blkdev_get_by_dev.part.0+0xd1/0x3c0
> >         blkdev_get_by_path+0xc0/0xd0
> >         btrfs_scan_one_device+0x52/0x1f0 [btrfs]
> >         btrfs_control_ioctl+0xac/0x170 [btrfs]
> >         __x64_sys_ioctl+0x83/0xb0
> >         do_syscall_64+0x3b/0x90
> >         entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #3 (uuid_mutex){+.+.}-{3:3}:
> >         __mutex_lock+0xba/0x7c0
> >         btrfs_rm_device+0x48/0x6a0 [btrfs]
> >         btrfs_ioctl+0x2d1c/0x3110 [btrfs]
> >         __x64_sys_ioctl+0x83/0xb0
> >         do_syscall_64+0x3b/0x90
> >         entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #2 (sb_writers#11){.+.+}-{0:0}:
> >         lo_write_bvec+0x112/0x290 [loop]
> >         loop_process_work+0x25f/0xcb0 [loop]
> >         process_one_work+0x28f/0x5d0
> >         worker_thread+0x55/0x3c0
> >         kthread+0x140/0x170
> >         ret_from_fork+0x22/0x30
> > 
> > -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
> >         process_one_work+0x266/0x5d0
> >         worker_thread+0x55/0x3c0
> >         kthread+0x140/0x170
> >         ret_from_fork+0x22/0x30
> > 
> > -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
> >         __lock_acquire+0x1130/0x1dc0
> >         lock_acquire+0xf5/0x320
> >         flush_workqueue+0xae/0x600
> >         drain_workqueue+0xa0/0x110
> >         destroy_workqueue+0x36/0x250
> >         __loop_clr_fd+0x9a/0x650 [loop]
> >         lo_ioctl+0x29d/0x780 [loop]
> >         block_ioctl+0x3f/0x50
> >         __x64_sys_ioctl+0x83/0xb0
> >         do_syscall_64+0x3b/0x90
> >         entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > other info that might help us debug this:
> > Chain exists of:
> >    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> >   Possible unsafe locking scenario:
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&lo->lo_mutex);
> >                                 lock(&disk->open_mutex);
> >                                 lock(&lo->lo_mutex);
> >    lock((wq_completion)loop0);
> > 
> >   *** DEADLOCK ***
> > 1 lock held by losetup/156417:
> >   #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
> > 
> > stack backtrace:
> > CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > Call Trace:
> >   dump_stack_lvl+0x57/0x72
> >   check_noncircular+0x10a/0x120
> >   __lock_acquire+0x1130/0x1dc0
> >   lock_acquire+0xf5/0x320
> >   ? flush_workqueue+0x84/0x600
> >   flush_workqueue+0xae/0x600
> >   ? flush_workqueue+0x84/0x600
> >   drain_workqueue+0xa0/0x110
> >   destroy_workqueue+0x36/0x250
> >   __loop_clr_fd+0x9a/0x650 [loop]
> >   lo_ioctl+0x29d/0x780 [loop]
> >   ? __lock_acquire+0x3a0/0x1dc0
> >   ? update_dl_rq_load_avg+0x152/0x360
> >   ? lock_is_held_type+0xa5/0x120
> >   ? find_held_lock.constprop.0+0x2b/0x80
> >   block_ioctl+0x3f/0x50
> >   __x64_sys_ioctl+0x83/0xb0
> >   do_syscall_64+0x3b/0x90
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f645884de6b
> > 
> > Usually the uuid_mutex exists to protect the fs_devices that map
> > together all of the devices that match a specific uuid.  In rm_device
> > we're messing with the uuid of a device, so it makes sense to protect
> > that here.
> > 
> > However in doing that it pulls in a whole host of lockdep dependencies,
> > as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
> > we end up with the dependency chain under the uuid_mutex being added
> > under the normal sb write dependency chain, which causes problems with
> > loop devices.
> > 
> > We don't need the uuid mutex here however.  If we call
> > btrfs_scan_one_device() before we scratch the super block we will find
> > the fs_devices and not find the device itself and return EBUSY because
> > the fs_devices is open.  If we call it after the scratch happens it will
> > not appear to be a valid btrfs file system.
> > 
> > We do not need to worry about other fs_devices modifying operations here
> > because we're protected by the exclusive operations locking.
> > 
> > So drop the uuid_mutex here in order to fix the lockdep splat.
> 
> I think uuid_mutex should stay. Here is why.
> 
>   While thread A takes %device at line 816 and deref at line 880.
>   Thread B can completely remove and free that %device.
>   As of now these threads are mutual exclusive using uuid_mutex.
> 
> Thread A
> 
> btrfs_control_ioctl()
>    mutex_lock(&uuid_mutex);
>      btrfs_scan_one_device()
>        device_list_add()
>        {
>   815                 mutex_lock(&fs_devices->device_list_mutex);
> 
>   816                 device = btrfs_find_device(fs_devices, devid,
>   817                                 disk_super->dev_item.uuid, NULL);
> 
>   880         } else if (!device->name || strcmp(device->name->str, path)) {
> 
>   933                         if (device->bdev->bd_dev != path_dev) {
> 
>   982         mutex_unlock(&fs_devices->device_list_mutex);
>         }
> 
> 
> Thread B
> 
> btrfs_rm_device()
> 
> 2069         mutex_lock(&uuid_mutex);  <-- proposed to remove
> 
> 2150         mutex_lock(&fs_devices->device_list_mutex);
> 
> 2172         mutex_unlock(&fs_devices->device_list_mutex);
> 
> 2180                 btrfs_scratch_superblocks(fs_info, device->bdev,
> 2181                                           device->name->str);
> 
> 2183         btrfs_close_bdev(device);
> 2184         synchronize_rcu();
> 2185         btrfs_free_device(device);
> 
> 2194         mutex_unlock(&uuid_mutex);  <-- proposed to remove

Yeah, I think this is the reason why uuid mutex exists at all, serialize
scanning (mounted or unmounted) with device list operations on mounted
filesystems (eg. removing).

> Well, I don't have a better option to fix this issue as of now.

Me neither. In general removing a lock allows sections to compete for
the resources and given that we've had some weird interactions of
mount/scan triggered by syzkaller I'm reluctant to just drop uuid mutex.

The reasoning of this patch concerns mounted filesystems AFAICS, not
scanning triggered by the control ioctl.
