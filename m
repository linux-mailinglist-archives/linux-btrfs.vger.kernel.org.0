Return-Path: <linux-btrfs+bounces-9932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCC9DA187
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 05:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0C5284F3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 04:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759F13BC35;
	Wed, 27 Nov 2024 04:41:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8514F90
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682491; cv=none; b=AyvvAK69yMXJn0ilnzWMIKqfWBOAHcY/SohZY4RuPe39sMU5VJMIuYByJwuK+fu0vrHvdIhphDnaKQUchY2AVediMeGU/Hq5/DcdBlIiHNAnfHG1AIOhPeZR9TRIMommyZpXRKU+8GPyVs9Wmn9nipDBr7AIYSxDAaFpwwV97GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682491; c=relaxed/simple;
	bh=GT/nl1AGpKErtYHJ+X9IZWzidORUpehWetkl1mup8rY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JeRr3Tiu7RBcrT+zS+jMNK8E+E76J0w1kBhVVRjCi7/o3BHyXoBLEwPawOzwGBekwRf5GEuqrgNiRbg6ZRQ2QsFJQmaS45KjxUN0G28QBouooGe36BKnn7YCKGO5AEMRtmPxKUxYib1SZINiU9UpksM6ip2r55KuscVpdcPmLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78589df29so55791315ab.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 20:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732682489; x=1733287289;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fM+Hy8Hr0VEn0/qCKpSvIifMReAzuRgBAAaIkzjf404=;
        b=oRuCmShMUOny1t2VbM7/TBkpgCLZNpCoUJn2kjcS96vv7R4W75/9lvjLRYERKlgz/n
         K7qW/aJNIDMwV3tlGYTcmH1yq5Pk/KUbvIr0ygn0/+/MSGqSbb3yjBsh2hnX9dlnwBNj
         +0xAWslWcUORZbOhGbj+mL05QCQk5QgMeXqX2xEjLEz6Q7REECr5kbyppCNWF18K6HJ7
         RKYGt+Sdlmu7NjKckOOQXL/8Y7r3FRYFqNIFGOZBWLXPVsfvXUduE08UMHracXXlSN0c
         2UMnBAGguX7sD7RTUjVHUPMltwpaBCRZy/BCO1wPbtV7MuIJiCcNkZu/lr3ptQOynwZs
         yIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT+kz0NxKGBDLghYKgyWhTG+dLgoJET2mi3hLpiMJpm29L7wD1bKZfTowS4ywbYWmVIlb5Dyed+/mimQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOpde5tV48DICLeJOvmfNTcpMSd++JKe4A5VBRfx0nc7Jh20L
	WE4lXMQ3pW8bo/VNAwON+sBBuKrJaN1+mNFbGtRv2kg5g5OGG1HuejxlsyIuJmMpgqbz2i8zfps
	htOU2NrdBT+n5nwtLwCDifpuw/r3RoylpfRqKRuoR02K4Cap2evKi8BQ=
X-Google-Smtp-Source: AGHT+IF7JS6O/ppGLz3JPYdk+v176s/+1CmUTZORzj3cCNO74MDeX75CgLQsuibvcuEpVPhM+s2KTZP+xwA6CL+8F19V7x+Wdb95
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3a7c55d9bddmr19621205ab.19.1732682489074; Tue, 26 Nov 2024
 20:41:29 -0800 (PST)
Date: Tue, 26 Nov 2024 20:41:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746a2f9.050a0220.21d33d.001f.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in __btrfs_release_delayed_node (4)
From: syzbot <syzbot+aa35cc34a0cc8c783a7f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e90f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=472032c4f88b28ab
dashboard link: https://syzkaller.appspot.com/bug?extid=aa35cc34a0cc8c783a7f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2c22dc1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edc4991391e8/vmlinux-2c22dc1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ddbf30097ad/bzImage-2c22dc1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa35cc34a0cc8c783a7f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0 Not tainted
------------------------------------------------------
kswapd1/79 is trying to acquire lock:
ffff888052b8b678 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0xa5/0xaf0 fs/btrfs/delayed-inode.c:268

but task is already holding lock:
ffffffff8ea3f520 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
ffffffff8ea3f520 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7246

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4055 [inline]
       slab_alloc_node mm/slub.c:4133 [inline]
       __kmalloc_cache_noprof+0x41/0x390 mm/slub.c:4309
       kmalloc_noprof include/linux/slab.h:901 [inline]
       kzalloc_noprof include/linux/slab.h:1037 [inline]
       kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:540
       loop_set_size drivers/block/loop.c:233 [inline]
       loop_set_status+0x5f0/0x8f0 drivers/block/loop.c:1285
       lo_ioctl+0xcbc/0x1f50
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       btrfs_submit_chunk fs/btrfs/bio.c:745 [inline]
       btrfs_submit_bbio+0xf93/0x18e0 fs/btrfs/bio.c:773
       read_extent_buffer_pages+0x65a/0x910 fs/btrfs/extent_io.c:3558
       btrfs_read_extent_buffer+0xd9/0x770 fs/btrfs/disk-io.c:229
       read_block_for_search+0x79e/0xbb0 fs/btrfs/ctree.c:1619
       btrfs_search_slot+0x121b/0x3150 fs/btrfs/ctree.c:2236
       btrfs_init_root_free_objectid+0x148/0x330 fs/btrfs/disk-io.c:4837
       btrfs_init_fs_root fs/btrfs/disk-io.c:1137 [inline]
       btrfs_get_root_ref+0x5d7/0xc30 fs/btrfs/disk-io.c:1364
       btrfs_get_fs_root fs/btrfs/disk-io.c:1416 [inline]
       open_ctree+0x2470/0x2a30 fs/btrfs/disk-io.c:3532
       btrfs_fill_super fs/btrfs/super.c:972 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1894 [inline]
       btrfs_get_tree+0x1274/0x1a10 fs/btrfs/super.c:2105
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       fc_mount+0x1b/0xb0 fs/namespace.c:1231
       btrfs_get_tree_subvol fs/btrfs/super.c:2068 [inline]
       btrfs_get_tree+0x65b/0x1a10 fs/btrfs/super.c:2106
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs-tree-00){++++}-{4:4}:
       reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5374
       __lock_release kernel/locking/lockdep.c:5563 [inline]
       lock_release+0x396/0xa30 kernel/locking/lockdep.c:5870
       up_write+0x79/0x590 kernel/locking/rwsem.c:1629
       btrfs_tree_unlock_rw fs/btrfs/locking.h:201 [inline]
       btrfs_unlock_up_safe+0x179/0x3b0 fs/btrfs/locking.c:225
       search_leaf fs/btrfs/ctree.c:1944 [inline]
       btrfs_search_slot+0x2748/0x3150 fs/btrfs/ctree.c:2188
       btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4350
       btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:758 [inline]
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:836 [inline]
       __btrfs_commit_inode_delayed_items+0xd5d/0x24a0 fs/btrfs/delayed-inode.c:1126
       __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
       flush_space+0x24a/0xd00 fs/btrfs/space-info.c:775
       btrfs_async_reclaim_metadata_space+0x113/0x350 fs/btrfs/space-info.c:1105
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&delayed_node->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       __btrfs_release_delayed_node+0xa5/0xaf0 fs/btrfs/delayed-inode.c:268
       btrfs_evict_inode+0x73d/0x1070 fs/btrfs/inode.c:5374
       evict+0x4e8/0x9a0 fs/inode.c:796
       dispose_list fs/inode.c:845 [inline]
       prune_icache_sb+0x239/0x2f0 fs/inode.c:1033
       super_cache_scan+0x38c/0x4b0 fs/super.c:223
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:437
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
       shrink_one+0x43b/0x850 mm/vmscan.c:4836
       shrink_many mm/vmscan.c:4897 [inline]
       lru_gen_shrink_node mm/vmscan.c:4975 [inline]
       shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
       kswapd_shrink_node mm/vmscan.c:6785 [inline]
       balance_pgdat mm/vmscan.c:6977 [inline]
       kswapd+0x1ca9/0x3700 mm/vmscan.c:7246
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> &q->q_usage_counter(io)#17 --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#17);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

2 locks held by kswapd1/79:
 #0: ffffffff8ea3f520 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
 #0: ffffffff8ea3f520 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7246
 #1: ffff8880436800e0 (&type->s_umount_key#45){++++}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880436800e0 (&type->s_umount_key#45){++++}-{4:4}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 79 Comm: kswapd1 Not tainted 6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 __btrfs_release_delayed_node+0xa5/0xaf0 fs/btrfs/delayed-inode.c:268
 btrfs_evict_inode+0x73d/0x1070 fs/btrfs/inode.c:5374
 evict+0x4e8/0x9a0 fs/inode.c:796
 dispose_list fs/inode.c:845 [inline]
 prune_icache_sb+0x239/0x2f0 fs/inode.c:1033
 super_cache_scan+0x38c/0x4b0 fs/super.c:223
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:437
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
 shrink_one+0x43b/0x850 mm/vmscan.c:4836
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x3700 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

