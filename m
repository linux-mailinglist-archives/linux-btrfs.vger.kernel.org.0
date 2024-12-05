Return-Path: <linux-btrfs+bounces-10065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16B9E4CF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 05:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8413287775
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 04:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BA192B96;
	Thu,  5 Dec 2024 04:03:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A7224D7
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371410; cv=none; b=Mnx2gm2h/H6hdM2f0+tMl0HY4PTMRvlMj4tzkPeXIfe2gjor2UpVr+/3WjHFwKTlKu981K71v2w1CHqnoezbdBEET6GAiNolJFkolm9xx0KnF8WXIclooJ8ke6+A75EMyWgAH9ASixxLFj2iCnlIFqdF3UGP1Sj6nweLnS3J0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371410; c=relaxed/simple;
	bh=B0UPE7YGd7Ngfk7Yvttlp5aIzUFGcYLfdxETEY4G5qU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mpY7yHSznmDDVvco4l/5wkvT8aypjeGnZgWyrh0tWN9IRPK5335+iP1kYeOwdvReci5hUfTJ7Ahavh+3zBUKBiEQQwyBrakFBN+xLH7zJfIDDG6uMywwsa44WEgslUHxwesFkCGkhyC2Sr9uPRV1gXGOIa3alBIUQMrj18IqSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a77a808c27so4923575ab.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 20:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371406; x=1733976206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmPMIvGUcaEEXWOl+xY0Ue7t7j0C3yIAMWikuEG04iQ=;
        b=ZPFduCIODpJ2P6wuhisBrckpBKrXQtvlvFGZFUyAUokSWP9wYPrMNiZROX4nS8A8M8
         twAmmNOgVK2q4IJ+5e8BmmtFf1R/13ScQDTIi2tOYNBlqdJz/YT4KmUXRZPUiyBT6GDY
         Ax/6UtcPqvSSxNJtKZy7l2VZD30Dgxmqz1qwjyAaGl+ah5HGilXTK+woosrzK0aUUQhO
         enDSoaSGTrOjHMdkUP2dwnxCPLI7cjsuV/E63CRoCJ0jEDn41eJDp38FVSY0QyMJqdKT
         0DdhQjtSQWh/Ame98ScCQlTk2yNzDpjLgCdcuBu0ohu1beMfP0tqVXkKfDeK76OG2jOv
         vFHg==
X-Forwarded-Encrypted: i=1; AJvYcCXvqFRxR/pCgDV/FQhxtqzCy7DOknY6KuVhXDPcBm65mdBnKEjSi8Z4jRN2faWNvrEgaeeQOn9xbr1xRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mMOScjCR2QcXdGvOytxkpqqbTX0tm/9Sul4SziA7rbPVyppG
	IA65Tt5bJvJX4AO5+tOG3Kosdl//bzegoyqQN+51DeHJ40kIjqgD8phAPx75ONx+IEuj5XXXFuk
	lGKUv83QF/6ftihh313TDf21ScCPgkSfz79V52O5ohadqYNFhKTRx7RI=
X-Google-Smtp-Source: AGHT+IEHaBQ9uVYQVaRC9NA1c6zszP4aXA22I2iVLzc0Ijn+UzAEB3i1kiiODas+CHvIuip6LvsP5CmdDuldtIkcH3lLl9xqBsFh
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3a7:c5ff:e5e2 with SMTP id
 e9e14a558f8ab-3a7f99b1233mr119494585ab.0.1733371405925; Wed, 04 Dec 2024
 20:03:25 -0800 (PST)
Date: Wed, 04 Dec 2024 20:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751260d.050a0220.17bd51.0085.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in __btrfs_commit_inode_delayed_items
From: syzbot <syzbot+71d80f05e434f9bfaaec@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111705e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=71d80f05e434f9bfaaec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71d80f05e434f9bfaaec@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-next-20241128-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:12/6861 is trying to acquire lock:
ffff88803171b3b8 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

but task is already holding lock:
ffff888071adc860 (&delayed_node->mutex){+.+.}-{4:4}, at: btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:830 [inline]
ffff888071adc860 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_commit_inode_delayed_items+0x1c4/0x24a0 fs/btrfs/delayed-inode.c:1126

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&delayed_node->mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       __btrfs_release_delayed_node+0xa5/0xaf0 fs/btrfs/delayed-inode.c:268
       btrfs_evict_inode+0x752/0x1080 fs/btrfs/inode.c:5374
       evict+0x4e8/0x9a0 fs/inode.c:796
       dispose_list fs/inode.c:845 [inline]
       prune_icache_sb+0x239/0x2f0 fs/inode.c:1033
       super_cache_scan+0x38c/0x4b0 fs/super.c:223
       do_shrink_slab+0x72d/0x1160 mm/shrinker.c:437
       shrink_slab_memcg mm/shrinker.c:550 [inline]
       shrink_slab+0x878/0x14d0 mm/shrinker.c:628
       shrink_one+0x43b/0x850 mm/vmscan.c:4836
       shrink_many mm/vmscan.c:4897 [inline]
       lru_gen_shrink_node mm/vmscan.c:4975 [inline]
       shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
       kswapd_shrink_node mm/vmscan.c:6785 [inline]
       balance_pgdat mm/vmscan.c:6977 [inline]
       kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3887 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3901
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
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
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
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
       btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
       btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
       read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1613
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

-> #0 (btrfs-tree-01){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
       btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
       btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
       btrfs_read_lock_root_node+0x3f/0xd0 fs/btrfs/locking.c:267
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1790 [inline]
       btrfs_search_slot+0x4f7/0x3150 fs/btrfs/ctree.c:2112
       btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4350
       btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:758 [inline]
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:836 [inline]
       __btrfs_commit_inode_delayed_items+0xd5d/0x24a0 fs/btrfs/delayed-inode.c:1126
       __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
       flush_space+0x24a/0xcf0 fs/btrfs/space-info.c:775
       btrfs_async_reclaim_metadata_space+0x113/0x350 fs/btrfs/space-info.c:1105
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  btrfs-tree-01 --> fs_reclaim --> &delayed_node->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&delayed_node->mutex);
                               lock(fs_reclaim);
                               lock(&delayed_node->mutex);
  rlock(btrfs-tree-01);

 *** DEADLOCK ***

5 locks held by kworker/u8:12/6861:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000369fd00 ((work_completion)(&fs_info->async_reclaim_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000369fd00 ((work_completion)(&fs_info->async_reclaim_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888034ba2470 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
 #3: ffff888034ba2498 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
 #4: ffff888071adc860 (&delayed_node->mutex){+.+.}-{4:4}, at: btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:830 [inline]
 #4: ffff888071adc860 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_commit_inode_delayed_items+0x1c4/0x24a0 fs/btrfs/delayed-inode.c:1126

stack backtrace:
CPU: 0 UID: 0 PID: 6861 Comm: kworker/u8:12 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
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
 down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
 btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
 btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
 btrfs_read_lock_root_node+0x3f/0xd0 fs/btrfs/locking.c:267
 btrfs_search_slot_get_root fs/btrfs/ctree.c:1790 [inline]
 btrfs_search_slot+0x4f7/0x3150 fs/btrfs/ctree.c:2112
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4350
 btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:758 [inline]
 btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:836 [inline]
 __btrfs_commit_inode_delayed_items+0xd5d/0x24a0 fs/btrfs/delayed-inode.c:1126
 __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
 flush_space+0x24a/0xcf0 fs/btrfs/space-info.c:775
 btrfs_async_reclaim_metadata_space+0x113/0x350 fs/btrfs/space-info.c:1105
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

