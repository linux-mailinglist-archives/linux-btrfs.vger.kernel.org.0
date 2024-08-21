Return-Path: <linux-btrfs+bounces-7377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E798795A563
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 21:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2744F1C220E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFE16F0CB;
	Wed, 21 Aug 2024 19:45:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4C136352
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269527; cv=none; b=TOBbM1EDovay7XBEm8v5TDquoXPRj46aJjfxcdljgJ0EFpnWufRRNPqU1IaH6AC+qm/DRMJAW++guqmWwbBUCa09DLKmADHumw7L3QZW8tw3w+lsKZUQgBaS0uh7aqOXhILviee59O0YA33x0C52+OQJgNUrGfwNjE4X8rVNVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269527; c=relaxed/simple;
	bh=Xbh2IDk8CQzJBqLV0qUdcsKypBnfwPCGDgLgVfvmoog=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bwB3Bof4Lt7smLgE58GJvloy9dXw4oI7Uq7ofsLYJI9uGe9UNgVc9TgA2TkWyKnINYEj+PcXyQm0+u53xTiLU7XfyV+ru9aCcNnvBxaxtszmePCUcP6fpqTwJwBZkSkd9eK82uP2uwx+/m9oOo3zLjC3d3ct1ixAe/4ljTuSFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d10b6da2dso346695ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 12:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724269525; x=1724874325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoAyvLICTdN5ZkejhKcALLA7I88asnEwXKB5c+YRjho=;
        b=vQ3PlstLhM/XONY6nDQzATUApVxTJ787fkZNe8ijT6kl0FMhp7D4qb12iIx/zIfWtq
         keoGtkOrGjfC+W+lJUXE9gcGtURogN6JuiuZWA/ERAn/jWQJG29LBx6An5Sy5JrWzWQF
         kE0C880z4X8n321237PJPLgmE1bhA4/zOm/UPmUZ05MYdslI2sBwkC+H+4x1mJ38loZe
         ddAYeHy3pLbqx2HiXPuIjvplsdCpeWYPYAD7vRzop+qrvFiXfLNlfXpvlEX5PjqWgKKd
         MTzL7XGE48OgvbICqFX19D/LDvkxF4krc8dyv2pZf88ZWQ8CwqK/YqVL2NBX8+Wdrb1y
         pg/A==
X-Forwarded-Encrypted: i=1; AJvYcCVUzqM/fthEVPcLNIm4MTCcAPj0q837eu13xYJjkdKvPjpyebh5CUe+Book31tBImYFJUn7Gqcujr47pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFY+LhPos6DLX0qhYabdbR0xIR6tS/GD7FM5vMheEACVtRfze
	yUcfHU5Ole2k+AisUh54bXokgu5ByiSDKwjCApsSe3K1+bqoKg0Dm6bM1SizzyAEeN+UNOvou9a
	xeByOQy+ObIlbDH1qPCLPN2Fpizdx2kdGT/ugXEkFYUQWqR6DWtAgkVg=
X-Google-Smtp-Source: AGHT+IHa9XQV+mQ9Wu9HX3LY+GRuH6TSqZfP1xH8nhvn3S2dxaSvHJWphFQxwJgBSdEkdLk9+jh0QGQV9cWyAw70o0wYQFFfPnKn
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:39d:1236:a9c0 with SMTP id
 e9e14a558f8ab-39d6c358632mr2669205ab.1.1724269525419; Wed, 21 Aug 2024
 12:45:25 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f55e4062036c827@google.com>
Subject: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
From: syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5c43d43bad35 Merge branches 'for-next/acpi', 'for-next/mis..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13471a05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c91f83ae59feaa1f
dashboard link: https://syzkaller.appspot.com/bug?extid=dfb6eff2a68b42d557d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10efded5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e94093980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc2dd4be620e/disk-5c43d43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81d40d99ddbf/vmlinux-5c43d43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc6aed0f2bc5/Image-5c43d43b.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d55321fffedc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 2037 Comm: kworker/u8:8 Not tainted 6.11.0-rc3-syzkaller-g5c43d43bad35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: btrfs-endio-write btrfs_work_helper
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 lookup_chain_cache_add kernel/locking/lockdep.c:3815 [inline]
 validate_chain kernel/locking/lockdep.c:3836 [inline]
 __lock_acquire+0x1fa0/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 free_extent_buffer_stale+0x2c/0x1ec fs/btrfs/extent_io.c:3333
 btrfs_force_cow_block+0xf2c/0x1c9c fs/btrfs/ctree.c:659
 btrfs_cow_block+0x318/0xa28 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xba0/0x2a08
 btrfs_lookup_file_extent+0x124/0x1bc fs/btrfs/file-item.c:267
 btrfs_drop_extents+0x370/0x2ad8 fs/btrfs/file.c:251
 insert_reserved_file_extent+0x2b4/0xa6c fs/btrfs/inode.c:2911
 insert_ordered_extent_file_extent+0x348/0x508 fs/btrfs/inode.c:3016
 btrfs_finish_one_ordered+0x6a0/0x129c fs/btrfs/inode.c:3124
 btrfs_finish_ordered_io+0x120/0x134 fs/btrfs/inode.c:3266
 finish_ordered_fn+0x20/0x30 fs/btrfs/ordered-data.c:331
 btrfs_work_helper+0x340/0xd28 fs/btrfs/async-thread.c:314
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x938/0xebc kernel/workqueue.c:3390
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


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

