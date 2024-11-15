Return-Path: <linux-btrfs+bounces-9685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979DC9CDCAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 11:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA6F1F23671
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB61AF0BF;
	Fri, 15 Nov 2024 10:35:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A638DD8
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666926; cv=none; b=sDxzkQfXIDy4dzAP+CpxA1wZ1lOiqZpP40twI9shfYgCdZq3KBw7w0ySg3+WKBDcXekk0C9HU6Q1L+rnKKSYCSGzxOdruSbT4DJMqzJVbIBm9kyRk5z+0oNx+2vpKrLzIsGMmNHOY+v2oV3Hq0DeW7e3eeXMWK1Js7f5Fao32BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666926; c=relaxed/simple;
	bh=KKmX3zPLqu8GcQIi5/bD3fvLtFEdzzQ3PrcUzvrYVXE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZFd3tPrLCSdUAbfoWNjUTlZgzZLrrdavqZvHElSiviZ/Z80/hmtFEKB9d66dEtsuoujxRZqlnAPxUxIxMPyyt67EenM6NYUPHP9I1J+MJHzAUUEjaEfwYqYcq6To2e9U2G0Uzj/Qbm2e3YooauKSfhu/LM72li1KqHNnn5bkoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e07db6451so163517239f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 02:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666924; x=1732271724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lE5ryar0fVqLxzlPOEtRYMo6rfMf17zBcG3/O3u/ybQ=;
        b=bO67FbfmsnBADsbkfrmYCELbhujPCa70NABo3DsKsbAZCXqt81yRqmSSDgkKTx6XnK
         Q/jgAc0+/YqpzWV6U4g00ZxawMkkfeKa9MbmUqJzR8Gb9lF10UMyKlw0MWgrrLH/9PLK
         y/Dl8RUML5fixclQ7g6Ba5g2RvzPrsblTC57qgluIiOVKMbeUJ0169QqIudpP21MXFb1
         7kg5t94akMXrIzl7ItG2ShKXV3L6MHp/N2tMvr25YC+7JmAC5nOWkIl5PtR1MPrdJYAx
         7s/i7jcEK2BCnT8fNE+9eoTYzTp9ebqMUbvUJJt0o0HRWpERJQjPW4dA3xoUkRqblTaO
         0lqw==
X-Forwarded-Encrypted: i=1; AJvYcCWvo9cMss2BcLBa+7s+oc4P5HKR2B6N4mmbPRfgz3ebrJeDTyCpf75sxq9+5tNQwu7pZfOUh7IpYbthZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrSqHXN1prT+vwJOqUIWVK9sWW4ZTTIrybg5Ah8roKtoPCN4Z
	VoO5/+R3sq/AdI4occSmmvfbrc2aAzKsas/MRxL3IlfslFlL6y41mr3W8LtdFUhhhavuWS549/r
	4vvsjVz/27MmdoT7gsE3MIS9tdO68rF2/d0P9xeXCqEvE2NEUmZGPX6o=
X-Google-Smtp-Source: AGHT+IEbkPGcE177W56REAwGOYU+NklAaJRLbRr6EIqQcg0kF6J7D49fZ0iFgKzPw+j04RbsCOeK9fL0BOCJB8EzXZAjZCq+pG0u
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a74807811cmr20358325ab.15.1731666923818; Fri, 15 Nov 2024
 02:35:23 -0800 (PST)
Date: Fri, 15 Nov 2024 02:35:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673723eb.050a0220.1324f8.00a8.GAE@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in free_block_entry
From: syzbot <syzbot+7325f164162e200000c1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141534e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=7325f164162e200000c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c68277f7b0f1/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/161b075483b1/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7325f164162e200000c1@syzkaller.appspotmail.com

BTRFS error (device loop0 state EA):   Ref action 2, root 5, ref_root 0, parent 8564736, owner 0, offset 0, num_refs 18446744073709551615
   __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
   update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
   btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
   btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
   btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
   btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
   btrfs_insert_empty_item fs/btrfs/ctree.h:669 [inline]
   btrfs_insert_orphan_item+0x1f1/0x320 fs/btrfs/orphan.c:23
   btrfs_orphan_add+0x6d/0x1a0 fs/btrfs/inode.c:3482
   btrfs_unlink+0x267/0x350 fs/btrfs/inode.c:4293
   vfs_unlink+0x365/0x650 fs/namei.c:4469
   do_unlinkat+0x4ae/0x830 fs/namei.c:4533
   __do_sys_unlinkat fs/namei.c:4576 [inline]
   __se_sys_unlinkat fs/namei.c:4569 [inline]
   __x64_sys_unlinkat+0xcc/0xf0 fs/namei.c:4569
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
BTRFS error (device loop0 state EA):   Ref action 1, root 5, ref_root 5, parent 0, owner 260, offset 0, num_refs 1
   __btrfs_mod_ref+0x76b/0xac0 fs/btrfs/extent-tree.c:2521
   update_ref_for_cow+0x96a/0x11f0
   btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
   btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
   btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
   btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
   __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
   btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
   __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
   __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
   btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
   prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
   relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
   btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
   btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
   __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
   btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
BTRFS error (device loop0 state EA):   Ref action 2, root 5, ref_root 0, parent 8564736, owner 0, offset 0, num_refs 18446744073709551615
   __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
   update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
   btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
   btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
   btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
   btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
   __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
   btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
   __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
   __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
   btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
   prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
   relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
   btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
   btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
   __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
   btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
==================================================================
BUG: KASAN: slab-use-after-free in rb_first+0x69/0x70 lib/rbtree.c:473
Read of size 8 at addr ffff888042d1af38 by task syz.0.0/5329

CPU: 0 UID: 0 PID: 5329 Comm: syz.0.0 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 rb_first+0x69/0x70 lib/rbtree.c:473
 free_block_entry+0x78/0x230 fs/btrfs/ref-verify.c:248
 btrfs_free_ref_cache+0xa3/0x100 fs/btrfs/ref-verify.c:917
 btrfs_ref_tree_mod+0x139f/0x15e0 fs/btrfs/ref-verify.c:898
 btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
 __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
 update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
 btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
 __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
 __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
 __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
 btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
 prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
 relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f996df7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f996ede7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f996e135f80 RCX: 00007f996df7e719
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f996dff139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f996e135f80 R15: 00007fff79f32e68
 </TASK>

Allocated by task 5329:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 btrfs_ref_tree_mod+0x264/0x15e0 fs/btrfs/ref-verify.c:701
 btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
 __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
 update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
 btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
 __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
 __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
 __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
 btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
 prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
 relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5329:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 btrfs_ref_tree_mod+0x136c/0x15e0
 btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
 __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
 update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
 btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
 __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
 __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
 __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
 btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
 prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
 relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888042d1af00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 56 bytes inside of
 freed 64-byte region [ffff888042d1af00, ffff888042d1af40)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42d1a
anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac418c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5055, tgid 5055 (dhcpcd-run-hook), ts 40377240074, free_ts 40376848335
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
 prep_new_page mm/page_alloc.c:1549 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3459
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4735
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x777/0x990 security/security.c:3109
 do_dentry_open+0x369/0x1460 fs/open.c:945
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
page last free pid 5055 tgid 5055 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1112 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2642
 free_pipe_info+0x300/0x390 fs/pipe.c:860
 put_pipe_info fs/pipe.c:719 [inline]
 pipe_release+0x245/0x320 fs/pipe.c:742
 __fput+0x23f/0x880 fs/file_table.c:431
 __do_sys_close fs/open.c:1567 [inline]
 __se_sys_close fs/open.c:1552 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1552
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888042d1ae00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888042d1ae80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff888042d1af00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff888042d1af80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff888042d1b000: 00 00 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00
==================================================================


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

