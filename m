Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16AB3249D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 05:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBYEkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 23:40:37 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:48228 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhBYEkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 23:40:35 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id DFEBC455DF5;
        Thu, 25 Feb 2021 06:39:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1614227986; bh=hNOwWB1vx3TnW6HCVr5m9NG3BD9ExlWvrUI5S7bfTuo=;
        h=From:To:Cc:Subject:Date;
        b=kei76oXHjlyaNi8KynXNvpnoU5FMuYrZl87Wz7P2WA7FCUPXAudPI/rXsJXDIda0/
         wIyWdI7bk4cQ4DKb6q63bGNfuSy1JiYBzUtpkvUgW2VMEhzuSWqxM73kkCSv/MVqhh
         1hFxBBsPs9uB6Xt9dhIiGAbQhY3N/Wn6e1QgRyLw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id CB0DE4594A5;
        Thu, 25 Feb 2021 06:39:46 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id D2P5pdsVivof; Thu, 25 Feb 2021 06:39:46 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3A8EF22A68;
        Thu, 25 Feb 2021 06:39:46 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 9E8A41BE009C;
        Thu, 25 Feb 2021 06:39:44 +0200 (EET)
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [report] lockdep warning when mounting seed device
Message-ID: <tuq0pxpx.fsf@damenly.su>
Date:   Thu, 25 Feb 2021 12:39:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSeE2piELYI3baABg/qDRAWfPn+Oamo2NU3CS6LUzwc0kLUBG1lW93SXqk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


While playing with seed device(misc/next and v5.11), lockdep 
complains the following:

To reproduce:

dev1=/dev/sdb1
dev2=/dev/sdb2

umount /mnt

mkfs.btrfs -f $dev1

btrfstune -S 1 $dev1

mount $dev1 /mnt

btrfs device add $dev2 /mnt/ -f

umount /mnt

mount $dev2 /mnt

umount /mnt


Warning:

[  104.348749] BTRFS: device fsid 
9a34d68b-fd18-470c-8cfc-44916c364c76 devid 1 transid 5 /dev/sdb1 
scanned by mkfs.btrfs (627)
[  104.377243] BTRFS info (device sdb1): disk space caching is 
enabled
[  104.378091] BTRFS info (device sdb1): has skinny extents
[  104.378800] BTRFS info (device sdb1): flagging fs with big 
metadata feature
[  104.512522] BTRFS info (device sdb1): relocating block group 
567279616 flags system|dup
[  104.535912] BTRFS info (device sdb1): relocating block group 
22020096 flags system|dup
[  104.571307] BTRFS info (device sdb1): disk added /dev/sdb2
[  104.602831] BTRFS info (device sdb2): disk space caching is 
enabled
[  104.603692] BTRFS info (device sdb2): has skinny extents

[  104.606389] 
======================================================
[  104.607212] WARNING: possible circular locking dependency 
detected
[  104.608025] 5.11.0-rc7-custom+ #55 Tainted: G           O
[  104.608790] 
------------------------------------------------------
[  104.609599] mount/670 is trying to acquire lock:
[  104.610207] ffffa2274d7158e8 
(&fs_devs->device_list_mutex){+.+.}-{3:3}, at: 
clone_fs_devices+0x4f/0x160 [btrfs]
[  104.611585]
               but task is already holding lock:
[  104.612334] ffffa22750e32f20 (btrfs-chunk-00){++++}-{3:3}, at: 
__btrfs_tree_read_lock+0x2d/0x110 [btrfs]
[  104.651264]
               which lock already depends on the new lock.

[  104.708041]
               the existing dependency chain (in reverse order) 
               is:
[  104.743619]
               -> #1 (btrfs-chunk-00){++++}-{3:3}:
[  104.777693]        down_read_nested+0x4b/0x140
[  104.794386]        __btrfs_tree_read_lock+0x2d/0x110 [btrfs]
[  104.811338]        btrfs_read_lock_root_node+0x36/0x50 [btrfs]
[  104.828574]        btrfs_search_slot+0x473/0x900 [btrfs]
[  104.845543]        btrfs_update_device+0x71/0x1a0 [btrfs]
[  104.862164]        btrfs_finish_chunk_alloc+0x121/0x490 [btrfs]
[  104.878474] 
btrfs_create_pending_block_groups+0x151/0x2c0 [btrfs]
[  104.894725]        btrfs_commit_transaction+0x82/0xb30 [btrfs]
[  104.910808]        btrfs_init_new_device+0x1015/0x14d0 [btrfs]
[  104.926879]        btrfs_ioctl+0x1ff/0x2fc0 [btrfs]
[  104.942996]        __x64_sys_ioctl+0x91/0xc0
[  104.958874]        do_syscall_64+0x38/0x50
[  104.974554]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  104.990108]
               -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
[  105.020508]        __lock_acquire+0x11e0/0x1ea0
[  105.035759]        lock_acquire+0xd8/0x3c0
[  105.050434]        __mutex_lock+0x8f/0x870
[  105.064614]        mutex_lock_nested+0x1b/0x20
[  105.078641]        clone_fs_devices+0x4f/0x160 [btrfs]
[  105.092984]        btrfs_read_chunk_tree+0x30e/0x7f0 [btrfs]
[  105.107031]        open_ctree+0xb40/0x176a [btrfs]
[  105.120673]        btrfs_mount_root.cold+0x12/0xeb [btrfs]
[  105.134564]        legacy_get_tree+0x34/0x60
[  105.148347]        vfs_get_tree+0x2d/0xc0
[  105.162053]        vfs_kern_mount.part.0+0x78/0xc0
[  105.176072]        vfs_kern_mount+0x13/0x20
[  105.189844]        btrfs_mount+0x11f/0x3c0 [btrfs]
[  105.203396]        legacy_get_tree+0x34/0x60
[  105.217129]        vfs_get_tree+0x2d/0xc0
[  105.230536]        path_mount+0x48c/0xd30
[  105.243915]        __x64_sys_mount+0x108/0x140
[  105.257030]        do_syscall_64+0x38/0x50
[  105.270084]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  105.283382]
               other info that might help us debug this:

[  105.321699]  Possible unsafe locking scenario:

[  105.347053]        CPU0                    CPU1
[  105.359640]        ----                    ----
[  105.372004]   lock(btrfs-chunk-00);
[  105.384023] 
lock(&fs_devs->device_list_mutex);
[  105.396858] 
lock(btrfs-chunk-00);
[  105.409215]   lock(&fs_devs->device_list_mutex);
[  105.421625]
                *** DEADLOCK ***

[  105.457447] 3 locks held by mount/670:
[  105.469302]  #0: ffffa2270932e0e8 
(&type->s_umount_key#54/1){+.+.}-{3:3}, at: alloc_super+0xdf/0x3c0
[  105.494413]  #1: ffffffffc0bdfdd0 (uuid_mutex){+.+.}-{3:3}, at: 
btrfs_read_chunk_tree+0x5c/0x7f0 [btrfs]
[  105.521072]  #2: ffffa22750e32f20 (btrfs-chunk-00){++++}-{3:3}, 
at: __btrfs_tree_read_lock+0x2d/0x110 [btrfs]
[  105.549753]
               stack backtrace:
[  105.578187] CPU: 6 PID: 670 Comm: mount Tainted: G           O 
5.11.0-rc7-custom+ #55
[  105.607477] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS ArchLinux 1.14.0-1 04/01/2014
[  105.638608] Call Trace:
[  105.653967]  dump_stack+0x90/0xb8
[  105.669419]  print_circular_bug.cold+0x13d/0x142
[  105.684814]  check_noncircular+0xf2/0x110
[  105.700322]  ? check_path.constprop.0+0x26/0x40
[  105.715821]  __lock_acquire+0x11e0/0x1ea0
[  105.731388]  ? __this_cpu_preempt_check+0x13/0x20
[  105.747097]  ? lockdep_unlock+0x33/0xd0
[  105.763012]  lock_acquire+0xd8/0x3c0
[  105.779043]  ? clone_fs_devices+0x4f/0x160 [btrfs]
[  105.795343]  __mutex_lock+0x8f/0x870
[  105.811251]  ? clone_fs_devices+0x4f/0x160 [btrfs]
[  105.827385]  ? lockdep_init_map_waits+0x51/0x250
[  105.843343]  ? clone_fs_devices+0x4f/0x160 [btrfs]
[  105.859264]  ? debug_mutex_init+0x36/0x50
[  105.875378]  ? __mutex_init+0x62/0x70
[  105.891493]  mutex_lock_nested+0x1b/0x20
[  105.907847]  clone_fs_devices+0x4f/0x160 [btrfs]
[  105.923756]  ? btrfs_get_64+0x63/0x110 [btrfs]
[  105.939389]  btrfs_read_chunk_tree+0x30e/0x7f0 [btrfs]
[  105.954580]  open_ctree+0xb40/0x176a [btrfs]
[  105.969477]  ? bdi_register_va+0x1b/0x20
[  105.983674]  ? super_setup_bdi_name+0x79/0xd0
[  105.997611]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
[  106.011564]  ? __kmalloc_track_caller+0x217/0x3b0
[  106.026013]  legacy_get_tree+0x34/0x60
[  106.040045]  vfs_get_tree+0x2d/0xc0
[  106.053904]  vfs_kern_mount.part.0+0x78/0xc0
[  106.067296]  vfs_kern_mount+0x13/0x20
[  106.080125]  btrfs_mount+0x11f/0x3c0 [btrfs]
[  106.093144]  ? kfree+0x5ff/0x670
[  106.106064]  ? __kmalloc_track_caller+0x217/0x3b0
[  106.119249]  legacy_get_tree+0x34/0x60
[  106.132216]  vfs_get_tree+0x2d/0xc0
[  106.145225]  path_mount+0x48c/0xd30
[  106.157899]  __x64_sys_mount+0x108/0x140
[  106.170654]  do_syscall_64+0x38/0x50
[  106.183208]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  106.196111] RIP: 0033:0x7fafa8869ebe
[  106.208994] Code: 48 8b 0d b5 0f 0c 00 f7 d8 64 89 01 48 83 c8 
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 82 0f 0c 00 
f7 d8 64 89 01 48
[  106.250073] RSP: 002b:00007ffc04365b98 EFLAGS: 00000246 
ORIG_RAX: 00000000000000a5
[  106.278571] RAX: ffffffffffffffda RBX: 00007fafa8994264 RCX: 
00007fafa8869ebe
[  106.294048] RDX: 0000556726a02e00 RSI: 00005567269fc690 RDI: 
00005567269fc670
[  106.309646] RBP: 00005567269fc440 R08: 0000000000000000 R09: 
00007fafa892ba60
[  106.325336] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[  106.340847] R13: 00005567269fc670 R14: 0000556726a02e00 R15: 
00005567269fc440
[  106.357929] BTRFS info (device sdb2): checking UUID tree
