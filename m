Return-Path: <linux-btrfs+bounces-14913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EEAAE65E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BC3AD8D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108029B206;
	Tue, 24 Jun 2025 13:11:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECA27BF85
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770692; cv=none; b=ElKkPIYWcvKN3z4dtyre9Pao6pRHAnYHlgagQ9KtQd2WOUTl6pOafDStx8vFS9l5//Jn76dej5PO6xQJ3u68yXS39mKB0GxdxFclruNvou8rbfFIJaT4Ca/2KuKX8qEHkITkrQCjYQigS8OhgCUT0iZW2m8qfeEqchc/4BFrTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770692; c=relaxed/simple;
	bh=LLGHMaHKLUWgBIyDbkeOmSN5zTVKs+yiY4ALxfvdaa0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eYKLi9TS3NxbLbw1EvrbnYtpRZrVv1zzfzujbyeSP1hi2xxQgIFrBxbjjCsHs3lbY7QnUWyER6ksP38l4v69BAun76BtplNyQFwReG4RiZ7a8M+8nZVAWW3gUlx5i7KcZ05TLW2QNSm0yzoBMmTyGffYVuAZp37JB4Rd8XJhEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso9474425ab.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 06:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770689; x=1751375489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efuL7pErHodLAbgNfNe9zKZWjg3gCsPkt4hZ4ceiNeA=;
        b=ciDWMD7uWn/z3oZgiU72qzLa1YgN0TTADEHr1tuvZzum3b0P6MTXkQnPXVgCkiPWzw
         lVGaEj6TgzoP/MOelTw8HACrlAuRs4XwvX3ELVa4iKioMN9b2rm+iAyFHXzFwFx3NcHU
         T5/tYkSgZpTVFiwzFQ52XpLJSkHDaqIeHh1b3Ckfzhgk3EK4ltfAezVUqZ1ONHzgoFkP
         OCcJGauV66tMD6chvi3Cyxvc1ZJhQMm5+43oCLvXQu1CzEk0xJ0HBE+uXxrImxZJZ8Ne
         rZ1XWAh+Pfqa9cFINkg5Ocdcr6dd2bmAXuMVWT+EIgVIP4fRmyKMLZKCUCThB/YNy0DS
         AZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX23n8OrfOEclBOy+UWMHkveWe1/HCWN2AyV15WG5lb6e8Jpk48DSixpIDP8RCnNufyubzzkyWA2G2W9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFw9l+Lp2YdbK6A22GFUt0Hi1OMGuscnYVdnDpBsRN3xx8sdvX
	50lUrVgxJd/pBbsf2waOSanN0xglDgpUdK/qv8N/t2cfWZLS4kQ96hIIFJnYHR+TMtae0StiLna
	e7Csc3uL430w/qgb9UuG/vG2bGpRlBDtCuK3CDglckykVW2C2sJraSvxsL1w=
X-Google-Smtp-Source: AGHT+IEFbL5qdo1kY3P3wh/BOtfBUynCmb32EzYcIS9W51cyGLy5KonDEPygweSnSFW7Jfbz8rHiAzCRfUmPmqwimbJ3brkCNyTm
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:3dd:edef:894c with SMTP id
 e9e14a558f8ab-3de38cc04cfmr151157765ab.14.1750770689505; Tue, 24 Jun 2025
 06:11:29 -0700 (PDT)
Date: Tue, 24 Jun 2025 06:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685aa401.050a0220.2303ee.0009.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
From: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1421b370580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f1cb0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aff30c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/disk-5d4809e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlinux-5d4809e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/bzImage-5d4809e2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a74fbfa0b0f/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1030cdd4580000)

The issue was bisected to:

commit 7aacdf6feed1ca882339ebd3895a233373b40a1e
Author: Qu Wenruo <wqu@suse.com>
Date:   Tue Jun 17 05:19:38 2025 +0000

    btrfs: delay btrfs_open_devices() until super block is created

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d29b0c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d29b0c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d29b0c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super block is created")

BTRFS info (device loop0): using sha256 (sha256-x86_64) checksum algorithm
BTRFS info (device loop0): disk space caching is enabled
BTRFS warning (device loop0): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc2-next-20250620-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor123/5843 is trying to acquire lock:
ffffffff8e6e9fe8 (uuid_mutex){+.+.}-{4:4}, at: btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462

but task is already holding lock:
ffff8880328ea0e0 (&type->s_umount_key#41/1){+.+.}-{4:4}, at: alloc_super+0x204/0x970 fs/super.c:345

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
       alloc_super+0x204/0x970 fs/super.c:345
       sget_fc+0x329/0xa40 fs/super.c:761
       btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
       btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
       do_new_mount+0x24a/0xa40 fs/namespace.c:3902
       do_mount fs/namespace.c:4239 [inline]
       __do_sys_mount fs/namespace.c:4450 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4427
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (uuid_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
       open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
       btrfs_fill_super fs/btrfs/super.c:984 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
       btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
       do_new_mount+0x24a/0xa40 fs/namespace.c:3902
       do_mount fs/namespace.c:4239 [inline]
       __do_sys_mount fs/namespace.c:4450 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4427
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->s_umount_key#41/1);
                               lock(uuid_mutex);
                               lock(&type->s_umount_key#41/1);
  lock(uuid_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor123/5843:
 #0: ffff8880328ea0e0 (&type->s_umount_key#41/1){+.+.}-{4:4}, at: alloc_super+0x204/0x970 fs/super.c:345

stack backtrace:
CPU: 1 UID: 0 PID: 5843 Comm: syz-executor123 Not tainted 6.16.0-rc2-next-20250620-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
 open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
 btrfs_fill_super fs/btrfs/super.c:984 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
 btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda63124f3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd76f19cb8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd76f19cd0 RCX: 00007fda63124f3a
RDX: 00002000000004c0 RSI: 00002000000015c0 RDI: 00007ffd76f19cd0
RBP: 00002000000004c0 R08: 00007ffd76f19d10 R09: 0000000000005598
R10: 0000000002000000 R11: 0000000000000282 R12: 00002000000015c0
R13: 00007ffd76f19d10 R14: 0000000000000003 R15: 0000000002000000
 </TASK>
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

