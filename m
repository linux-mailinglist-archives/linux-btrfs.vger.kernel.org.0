Return-Path: <linux-btrfs+bounces-19554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C75CAB350
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB97305F3B5
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Dec 2025 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC8C27E7DA;
	Sun,  7 Dec 2025 09:53:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A11B6D1A
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765101204; cv=none; b=m+BGcRe2b4Bg9B9LQhRp93i1jfad0uaSbzYveqbB6/u4cCXS8aAAHXrZ1yhWvdEBnFvL7EowH28QFCI6HvsnVmPi7yPC5w4nQ/tlYwCGeUcI1m/W4mRUevscyHB3kIiKwkSrfRjfB2+k3y8eeIM0TyWeMctq6GxfqzrvYRDA+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765101204; c=relaxed/simple;
	bh=92twfPPGt9hxgyNadQAHzPbf7VSSRMNTFSLNnfzSSH0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CVobmBOTbYHngRcUtnekOdsrRc3lqZzf6WcLrtvA2wibp5Br+5Y8KbXswA0hLKVUeUgkk53QfC7t4ze3sIMdn+O6OfHxqEa1Ow3b5pxn5JGqmMb4KXildLLRm5sxF+p+sXhiH5W62M8Rg7SLUb5e4ssIBj7Uc4/FlFNCQ4ZF54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c765a491bdso3423010a34.2
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Dec 2025 01:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765101202; x=1765706002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+lsl8Y/lpJKn5lZjxwPmVx4Ol41hCKi49alrntCicI=;
        b=bPCYKJr3I2Xax4KmmaY83H4AI6M85VcFTDzSJaeq6GXONpwqfwBZN+akcQUXPE+snF
         ek3n3la0XKdVq7kEBkvdygU1teYEthyNhqqiUbB/ywMUQq1y2dieLy8j2jcjlmLorRLx
         JzMEoW6wmtrUfB7GP9XjbNQqjkZfshLrdkDZTulE7N9SbYO4YNuDJiKq1vZjcIJwSKCj
         VwBrGNaZDWMBVVnDisZX2MVJaoIDUk2LTmdFEmmej7vemLwvtJKQn0IDcWOH5nRlxuet
         EbDFpc+lPZOIWf1V/x4tp3oCZeBj48v2FJEgGOGadBGDhlDw2LhZpYqYg4IWhO9FCLYi
         3hrw==
X-Forwarded-Encrypted: i=1; AJvYcCW0UCzFD01PK/N7gkzs319TtZVhKGQtnft0Kfo6xKApf7kssMn0czBl93ZL0XhtVb3H7/vGi4jMgGFDWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJweVdrjjMjHAYrN7trLf9SVJ/B727MJOOQMkROGsPzqOJwHVj
	ynVH88Og3rvhKvk+XCstleDIRERy6d57YmmfJcxG+4eLWyjKd2wvP/ZOV8dA3eNmEyaDhBX+ai9
	+gyo9kDa1B/VuTI7OLcHLMWNBLIrUPIObEhYGxWRvibwHz8dnFfgjQHF7bCs=
X-Google-Smtp-Source: AGHT+IEXTXqnXGKSrZBY/2mJudEfDMiMEKOMScWF2hk2wCHBUv6q2EJ68TgsmcW4xfs1oMOJNAVgLA3brDkvGroasfxCVZ1OFg6o
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2207:b0:659:9a49:8ddd with SMTP id
 006d021491bc7-6599a8eb393mr2119323eaf.31.1765101202015; Sun, 07 Dec 2025
 01:53:22 -0800 (PST)
Date: Sun, 07 Dec 2025 01:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69354e91.a70a0220.38f243.004e.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_run_delayed_items (2)
From: syzbot <syzbot+64c9efba06e7ad505aef@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    44fc84337b6e Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113b1192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e613d5a6bd72b912
dashboard link: https://syzkaller.appspot.com/bug?extid=64c9efba06e7ad505aef
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-44fc8433.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62d35c4f6e28/vmlinux-44fc8433.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8d61aa183d4/bzImage-44fc8433.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64c9efba06e7ad505aef@syzkaller.appspotmail.com

BTRFS error (device loop0): allocation failed flags 4, wanted 4096 tree-log 0, relocation: 0
BTRFS info (device loop0): space_info DATA+METADATA (sub-group id 0) has -1544192 free, is full
BTRFS info (device loop0): space_info total=11534336, used=3231744, pinned=45056, reserved=8257536, may_use=1544192, readonly=0 zone_unusable=0
BTRFS info (device loop0): global_block_rsv: size 1441792 reserved 1441792
BTRFS info (device loop0): trans_block_rsv: size 0 reserved 0
BTRFS info (device loop0): chunk_block_rsv: size 0 reserved 0
BTRFS info (device loop0): delayed_block_rsv: size 98304 reserved 94208
BTRFS info (device loop0): delayed_refs_rsv: size 0 reserved 0
BTRFS info (device loop0): block group 5242880 has 1638400 bytes, 1593344 used 45056 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (0 bytes available) 
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 0 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): block group 6881280 has 1638400 bytes, 1638400 used 0 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (0 bytes available) 
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 0 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): block group 8519680 has 8257536 bytes, 0 used 0 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (8257536 bytes available) 
BTRFS critical (device loop0): entry offset 8519680, bytes 8257536, bitmap no
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 1 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): 8257536 bytes available across all block groups
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: fs/btrfs/delayed-inode.c:1179 at 0x0, CPU#0: kworker/u4:24/4375
Modules linked in:
CPU: 0 UID: 0 PID: 4375 Comm: kworker/u4:24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound btrfs_async_reclaim_data_space
RIP: 0010:__btrfs_run_delayed_items+0x46c/0x540 fs/btrfs/delayed-inode.c:1179
Code: 85 f6 75 07 e8 d5 c4 da fd eb 7a e8 ee b4 c0 fd 84 c0 74 20 e8 c5 c4 da fd eb 6a e8 be c4 da fd 48 8d 3d 97 0f a3 0b 44 89 e6 <67> 48 0f b9 3a e9 da fe ff ff e8 75 1e 62 07 41 89 c6 31 ff 89 c6
RSP: 0018:ffffc9000e887470 EFLAGS: 00010293
RAX: ffffffff83e64972 RBX: ffff888053d72630 RCX: ffff888033358000
RDX: 0000000000000000 RSI: 00000000ffffffe4 RDI: ffffffff8f895910
RBP: 0000000000000000 R08: ffff888033358000 R09: 0000000000000003
R10: 00000000fffffffb R11: 0000000000000000 R12: 00000000ffffffe4
R13: ffff888053c953d0 R14: ffff888052b70001 R15: 1ffff1100a7ae4c6
FS:  0000000000000000(0000) GS:ffff88808d6b7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000037d000 CR3: 0000000042677000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x865/0x3950 fs/btrfs/transaction.c:2325
 flush_space+0x48b/0xcb0 fs/btrfs/space-info.c:888
 do_async_reclaim_data_space+0x2a6/0x520 fs/btrfs/space-info.c:1410
 btrfs_async_reclaim_data_space+0x41/0x90 fs/btrfs/space-info.c:1458
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess):
   0:	85 f6                	test   %esi,%esi
   2:	75 07                	jne    0xb
   4:	e8 d5 c4 da fd       	call   0xfddac4de
   9:	eb 7a                	jmp    0x85
   b:	e8 ee b4 c0 fd       	call   0xfdc0b4fe
  10:	84 c0                	test   %al,%al
  12:	74 20                	je     0x34
  14:	e8 c5 c4 da fd       	call   0xfddac4de
  19:	eb 6a                	jmp    0x85
  1b:	e8 be c4 da fd       	call   0xfddac4de
  20:	48 8d 3d 97 0f a3 0b 	lea    0xba30f97(%rip),%rdi        # 0xba30fbe
  27:	44 89 e6             	mov    %r12d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 da fe ff ff       	jmp    0xffffff0e
  34:	e8 75 1e 62 07       	call   0x7621eae
  39:	41 89 c6             	mov    %eax,%r14d
  3c:	31 ff                	xor    %edi,%edi
  3e:	89 c6                	mov    %eax,%esi


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

