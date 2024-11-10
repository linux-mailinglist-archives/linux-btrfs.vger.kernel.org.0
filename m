Return-Path: <linux-btrfs+bounces-9402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A999C316F
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 10:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6881F215C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7415350B;
	Sun, 10 Nov 2024 09:16:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6B14264A
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731230191; cv=none; b=RYLNDDbX7Q5YAJFbXKl1snu6V7/24jU3b+y4KIaq/KVZnyMPGtLCjI0aCfwacRla1mHD4M3fHNcz2W8C8jyAv1vEHZiI1FbrgsA18XTrSE/BSU/pCpIORcsI3zon3HH2/QdfodXLpkuO1sK5Zm0uwVJfinUAu3Nu3qOe26woc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731230191; c=relaxed/simple;
	bh=OsnUAXyHg+P42BTDDEOJFFaWKvYbAmVUmWLPyXpWq6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IGLN1kdvmIC2WZyaN4AbQJpidhO5piMJdg8+C0LI0T4kfxQIPkaRyQbKbZl35DUsrD9HzQBLH6+Zm38JTCFPDycaziGMv0ENoGAMhcsLOUUSu2JaH4YErv6JXcuRXqUxpJoTBS7y2eekVsrBxUzetlM0fCS1Z5KdZYyA46vtf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so40383085ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 01:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731230188; x=1731834988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09hinxszG83YGxaOH0ls20KaKRhsqmXtiSWPoMI9v48=;
        b=Q3+X5ta4zK8oU6e1If3rOfcWzPRR7cxEHvW3tMf+KM4nHnHMP4Ie9IeRhKlzQ39cA+
         LFWQ5+9iV/BI3/dx678cTzb+9YxqJ5fQwMovaCQPoIpg6lyt2adA1yOzJf7kS8YOYkrE
         YnaBjXWDFKnPY/pVPy85trgiNc4f1MqFCSshCmahual/osxZkfjvGvSyxwN22VjqeY1i
         stEjM2KqDzMp/7V91W3nfrt6PIpTDxAICgm950f5Ry+eaI100aTsUdbBiN+ymiNElvXv
         Vx/zVJ/qJjuIc6HEKcDwweweiiP3aRfkjIYw3pP+pn07Yb/lm3zGNOYQX0v2v07xocVb
         tHgg==
X-Forwarded-Encrypted: i=1; AJvYcCWwj/bcQqEyktO/7JO21mV3pqzh04+IIvBNuqmYvET7X0aUoG5+08g9uA0v7Xexjmb0bqHLvSaBE94Q3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbk7tkTo8XuNvuIO6BRn+CdiVy/khWu1IV491Tkqn0jhpaRUl
	/S9TAiWTQxseSBlwpFD9eCocpUNkLwt7Vmb0kGJ6VQQ48vyOmxQlOHtLzBWzbjYK8Jjgp26PlXo
	cNZBUEaEASrOiZy9wChBDbWCt3R5YDpSbJkhBIYw1/wVM7C0Cr+sSo+s=
X-Google-Smtp-Source: AGHT+IE5YmaR/OwFXrAmdG4CYFHsTFF88FojUVoMzaTVqr1ZHtHE4yIQwFplJ7dJPQO8H37QXtO6ncJVXFEV6HErWMCGOHvjCKyo
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6f19a0126mr112940285ab.2.1731230188557; Sun, 10 Nov 2024
 01:16:28 -0800 (PST)
Date: Sun, 10 Nov 2024 01:16:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673079ec.050a0220.138bd5.004b.GAE@google.com>
Subject: [syzbot] [btrfs?] BUG: MAX_LOCK_DEPTH too low! (5)
From: syzbot <syzbot+c589dd1d06df2d690925@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d0b6a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=c589dd1d06df2d690925
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bcce30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1755cf40580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f2588b04ae9/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c9324cf16df/bzImage-2e1b3cc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a39c54e6dbd4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c589dd1d06df2d690925@syzkaller.appspotmail.com

 </TASK>
BTRFS error (device loop0): failed to run delayed ref for logical 5365760 num_bytes 4096 type 176 action 2 ref_mod 1: -12
BTRFS error (device loop0 state A): Transaction aborted (error -12)
BTRFS: error (device loop0 state A) in btrfs_run_delayed_refs:2215: errno=-12 Out of memory
BTRFS info (device loop0 state EA): forced readonly
BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by syz-executor281/5311:
 #0: ffff8880346b4420 (sb_writers#10){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880346b4420 (sb_writers#10){.+.+}-{0:0}, at: vfs_writev+0x2d1/0xba0 fs/read_write.c:1062
 #1: ffff888045ee1638 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:835 [inline]
 #1: ffff888045ee1638 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: btrfs_inode_lock+0x87/0xe0 fs/btrfs/inode.c:357
 #2: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #3: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #4: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #5: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #6: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #7: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #8: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #9: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #10: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #11: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #12: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #13: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #14: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #15: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #16: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #17: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #18: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #19: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #20: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #21: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #22: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #23: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #24: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #25: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #26: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #27: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #28: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #29: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #30: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #31: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #32: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #33: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #34: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #35: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #36: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #37: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #38: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #39: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #40: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #41: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #42: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #43: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #44: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #45: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #46: ffff888043cebe18 (btrfs-tree-01){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x1c/0x240 fs/btrfs/locking.c:157
 #47: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #47: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #47: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: find_extent_buffer_nolock+0x21/0x320 fs/btrfs/extent_io.c:1615
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 5311 Comm: syz-executor281 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __lock_acquire+0x10ee/0x2050
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 find_extent_buffer_nolock+0x3e/0x320 fs/btrfs/extent_io.c:1615
 find_extent_buffer+0x24/0x340 fs/btrfs/extent_io.c:2710
 read_block_for_search+0x348/0x920 fs/btrfs/ctree.c:1540
 btrfs_search_slot+0x120d/0x30d0 fs/btrfs/ctree.c:2200
 btrfs_lookup_file_extent+0x14c/0x210 fs/btrfs/file-item.c:267
 can_nocow_extent+0x1c5/0x940 fs/btrfs/inode.c:7055
 btrfs_check_nocow_lock+0x274/0x400 fs/btrfs/file.c:1106
 btrfs_buffered_write+0x63f/0x1360 fs/btrfs/file.c:1280
 btrfs_do_write_iter+0x279/0x760 fs/btrfs/file.c:1508
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1215
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7effcb021b49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc8a399f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007ffcc8a39a30 RCX: 00007effcb021b49
RDX: 0000000000000001 RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000009 R09: 0000000000000008
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffcc8a39a60
R13: 00007ffcc8a39b40 R14: 431bde82d7b634db R15: 00007effcb06301d
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

