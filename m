Return-Path: <linux-btrfs+bounces-10728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB769A01D02
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823913A1F90
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0C41C64;
	Mon,  6 Jan 2025 01:21:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B7647
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736126487; cv=none; b=lhcEEqIQHAHFsA+9WQ6+1fqnhFQ1fI+2nH4lypJ2exe/hU2HjANlKZirYVmN11qPax/dKuFQBuNbLpp2m2aF7Fkv/YvxXyXOO8ltl5P391fXgkT6HaVZF7JNPjJXDXGNMPA/8Ab/VMdOMzMSMUMHF0WbEcuUVlr3t5+BD12XuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736126487; c=relaxed/simple;
	bh=MRrw2JenZWOJ0xBOHpnn7qwu0IVfgEHRsF4LrQjCsjw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A9VCA7Q8cBTXrKAboJwlOkjnCqIGy54ftLwMISHQ/4JGjS3YHob/VUqbvU2paVVviM73EzVFKu2wK0zUCm2yAzxtv3EfgTXJjitvL1XshR9OwCTm7+MKdtrZOTqawIm//JDjW7MjUyjihIp3bRskjsyTxouke2KSXH+GQKoT3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ac005db65eso137970705ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2025 17:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736126484; x=1736731284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iwn7QhY/fBAMS85AZRUPvZvtdTwvwXPKAQlGdQ1se2c=;
        b=jCB5+s86pAxrP4Hxs5PArzQxJSiWHvjJN6Me30HicuJ/XrD0eZzDzgHvS74rl7ifcU
         WmG9bhojihridaELZ8aRoH0A+GMN+imq7iOidO4wypP0wEZlSoIst5/ug4cj4nOfE1nw
         rMGRa/DWQa+c9ATCoH+Iys7vGYWrwWto82iudOPZa42S2SXBue3WsEa8D+DW2kXj+qjm
         cZH+cEDR3FSdT94Zjc6y6TuVyMVrU+EpjBAMyEvlkBEaPsS3sVK5L/3TkjAWME9f/GuF
         LRVKRn2pxcKzmttW+oElscVvvlGhISRmBFkj0Hx0aDWoLO4Bqjb/K31sGfVhqlTnbT1d
         BjWg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlulyG+dC1/zWGrOiGWawJMr9TcremC1OKP83KPq9P88/nbLHX0V1QnTtT9YdYtdzW5H+3ZufiVin2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WE/2HlFIVZjQ/XuN5pFFWwyRNnjQmea5SZr4qh5It5ew7VCZ
	mF1aWQ/d43nVQz5d2ftVtLUJKHLLqQ6/OmLMuGuvJr76ZMyGlWOvkFJI5nOIYakKMWta46WJ+zp
	F+B/tOPsGQFjmW4+6YlGW154owa6cZQAx6eq+pYS7lz9BwiFOUClTOkk=
X-Google-Smtp-Source: AGHT+IGI7OBdKA5qFifCwK3aP2y6SH/iLT2tZfxRTbIDNKi/0iHB6dn91zDrrORfS6gANMtLB/86/Z/63Kz7oGCpI3vS07NsFdH3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3c2d2d50d0dmr490548915ab.12.1736126484544; Sun, 05 Jan 2025
 17:21:24 -0800 (PST)
Date: Sun, 05 Jan 2025 17:21:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b3014.050a0220.3b53b0.0064.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_tree_lock_nested
From: syzbot <syzbot+63913e558c084f7f8fdc@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13652edf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=63913e558c084f7f8fdc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81d0d11be3bd/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f076be686f8/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63913e558c084f7f8fdc@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00163-gab75170520d4 #0 Not tainted
------------------------------------------------------
syz.0.0/5335 is trying to acquire lock:
ffff8880545dbc38 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

but task is already holding lock:
ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (btrfs-treloc-02/1){+.+.}-{4:4}:
       reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5374
       __lock_release kernel/locking/lockdep.c:5563 [inline]
       lock_release+0x396/0xa30 kernel/locking/lockdep.c:5870
       up_write+0x79/0x590 kernel/locking/rwsem.c:1629
       btrfs_force_cow_block+0x14b3/0x1fd0 fs/btrfs/ctree.c:660
       btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
       btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
       replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
       merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
       merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
       relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
       btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
       btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
       __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
       btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
       btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs-tree-01/1){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
       btrfs_init_new_buffer fs/btrfs/extent-tree.c:5052 [inline]
       btrfs_alloc_tree_block+0x41c/0x1440 fs/btrfs/extent-tree.c:5132
       btrfs_force_cow_block+0x526/0x1fd0 fs/btrfs/ctree.c:573
       btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
       btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
       btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4351
       btrfs_insert_empty_item fs/btrfs/ctree.h:688 [inline]
       btrfs_insert_inode_ref+0x2bb/0xf80 fs/btrfs/inode-item.c:330
       btrfs_rename_exchange fs/btrfs/inode.c:7990 [inline]
       btrfs_rename2+0xcb7/0x2b90 fs/btrfs/inode.c:8374
       vfs_rename+0xbdb/0xf00 fs/namei.c:5067
       do_renameat2+0xd94/0x13f0 fs/namei.c:5224
       __do_sys_renameat2 fs/namei.c:5258 [inline]
       __se_sys_renameat2 fs/namei.c:5255 [inline]
       __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5255
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
       btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
       read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
       btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
       replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
       merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
       merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
       relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
       btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
       btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
       __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
       btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
       btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  btrfs-tree-01 --> btrfs-tree-01/1 --> btrfs-treloc-02/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-treloc-02/1);
                               lock(btrfs-tree-01/1);
                               lock(btrfs-treloc-02/1);
  rlock(btrfs-tree-01);

 *** DEADLOCK ***

8 locks held by syz.0.0/5335:
 #0: ffff88801e3ae420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write_file+0x5e/0x200 fs/namespace.c:559
 #1: ffff888052c760d0 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: __btrfs_balance+0x4c2/0x26b0 fs/btrfs/volumes.c:4183
 #2: ffff888052c74850 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_relocate_block_group+0x775/0xd90 fs/btrfs/relocation.c:4086
 #3: ffff88801e3ae610 (sb_internal#2){.+.+}-{0:0}, at: merge_reloc_root+0xf11/0x1ad0 fs/btrfs/relocation.c:1659
 #4: ffff888052c76470 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
 #5: ffff888052c76498 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
 #6: ffff8880545db878 (btrfs-tree-01/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
 #7: ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189

stack backtrace:
CPU: 0 UID: 0 PID: 5335 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
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
 down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
 btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
 btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
 read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
 btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
 replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
 merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
 merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
 relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1ac6985d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1ac63fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1ac6b76160 RCX: 00007f1ac6985d29
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000007
RBP: 00007f1ac6a01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1ac6b76160 R15: 00007fffda145a88
 </TASK>
BTRFS info (device loop0 state E): 1 enospc errors during balance
BTRFS info (device loop0 state E): balance: ended with status: -30


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

