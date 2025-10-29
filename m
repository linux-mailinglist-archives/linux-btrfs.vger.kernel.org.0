Return-Path: <linux-btrfs+bounces-18397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44BC1A994
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6444F584C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AE1AF0AF;
	Wed, 29 Oct 2025 13:01:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6A70830
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742895; cv=none; b=Jzka93GQUnAea19R7HDa2AHRBSZZbj5xFzYlAjuixqaHsVIQ7hkSRbDOPJw7+3bFEWcGLsJnLQs71KYuw9iHKY603zk/oTaWe4uzPZVhPWOMF7s1XKffXQT7sbusRhbjkbugvLZPLXZaGeTSo8b7bo8SsBsZS3+GkdiPgCkHFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742895; c=relaxed/simple;
	bh=zhINIyNBIxbSz6z5BgTMThjlPu5ih/7UFryr1xO89+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OiFAQa5DsxfnaqI5+pJVbMddCuZ+7nFFI7jahj2Ht2FX87jIcZWMyLrjyvOuQPngSPTID5ccMMRFvbW0e80d/RB3OpFuOwFXC1o2r2YCmn1SFSWi4GAgKdq8JuvKxO/SxAZXIKnwONtSAkvOmmx85qNO+CymVBw6XDZZfhMXBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-940f98b0d42so1940118739f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 06:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742893; x=1762347693;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhc9/9BSZcBCT2PDLCFj4u2QQurrcg6m9v9HE8ceWrU=;
        b=SB918POtfycpfTal+2icBxBuHaNSEr7OnGVI9SSiQ4WHtFUaW2m2JQQ/KQF249r8Cr
         5HW4/iB6VyqRjMAUG+S4WyhxZhGvLCmW59P7uXbpLX3fCTwtAQ+bcFX9OHfy1zk7dc68
         IFumcfb0FlLPJ/ZkEZCSAt/F2EnBlHp0XPMYsWra1l2zvtMPUXuNIG0VEL5G8wD8/ED5
         qsxSYbYvbN9A2FwmT+LAKNdUZIC3IEFMd3fTfPqojGui0NJn+rgOhoo0vYpZ28FNY1YG
         W9vGjSzSwCfxPdoIy79CCHb4KueqZ3523k5NCcTwTzDQ40tsukLNxHhDFJE9RHjHZXTK
         W6yA==
X-Forwarded-Encrypted: i=1; AJvYcCU/SIqT+7L035OMrfY2B1hm3hS4Zshi9gLK1ggM8LGPMwg7gq2bJoSFHXAVXlNuZf2o36U4KBesWWLWow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrMVq1lu9YygBdycmDtrvWFGIpSamLdJOY8NVOzpzPHoZxqPu
	eQ+5i7GFz5Ci7oyg9uj7Nb1oQ7ie0pIask8uHlzS7DKvxy9/3adQTlTGiBJBaMZZZIOQYtfu2NP
	HaGOdf4Ec/SRlEZOma383pQxFt491jnoACEhkgQeWO/SUVIzs+Aya9cfHLwA=
X-Google-Smtp-Source: AGHT+IGzZTTmtszlDZr4cDI5oEOBxJawItxGytprSH4d+qDgm7CDcD5qG6EYsPc4lL7/xyarsuozxoVfMNIeB8DF/qoZ+pDKatBk
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c8:b0:430:ab94:4223 with SMTP id
 e9e14a558f8ab-432f8fac79cmr31652505ab.8.1761742889715; Wed, 29 Oct 2025
 06:01:29 -0700 (PDT)
Date: Wed, 29 Oct 2025 06:01:29 -0700
In-Reply-To: <68fe7262.050a0220.3344a1.0145.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69021029.050a0220.3344a1.041e.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_destroy_inode (3)
From: syzbot <syzbot+25df068cd8509f8c0fe1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b98c94eed4a9 arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15febd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=25df068cd8509f8c0fe1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13febd42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ca0e14580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c82e514449b/disk-b98c94ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a322ed38c368/vmlinux-b98c94ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/059db7d7114e/Image-b98c94ee.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7af3d5d4bd72/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=174a0e14580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25df068cd8509f8c0fe1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6657 at fs/btrfs/inode.c:7942 btrfs_destroy_inode+0x258/0x798 fs/btrfs/inode.c:7942
Modules linked in:
CPU: 1 UID: 0 PID: 6657 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : btrfs_destroy_inode+0x258/0x798 fs/btrfs/inode.c:7942
lr : btrfs_destroy_inode+0x258/0x798 fs/btrfs/inode.c:7942
sp : ffff8000a6067900
x29: ffff8000a6067920 x28: dfff800000000000 x27: 1fffe0001e3721a3
x26: ffff700014c0cf38 x25: dfff800000000000 x24: 1fffe0001e372114
x23: ffff0000cb81c000 x22: 0000000000010000 x21: ffff0000f1b90b10
x20: ffff0000f1b90c48 x19: ffff0000f1b908a0 x18: 00000000ffffffff
x17: ffff800093305000 x16: ffff800082de95c8 x15: 0000000000000001
x14: 1fffe0001e3721cc x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e3721cd x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d166dc40 x7 : ffff800080e995c0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080f03e80
x2 : 0000000000000000 x1 : 0000000000010000 x0 : 0000000000000000
Call trace:
 btrfs_destroy_inode+0x258/0x798 fs/btrfs/inode.c:7942 (P)
 destroy_inode fs/inode.c:396 [inline]
 evict+0x6e4/0x928 fs/inode.c:834
 dispose_list fs/inode.c:852 [inline]
 evict_inodes+0x638/0x6d0 fs/inode.c:906
 generic_shutdown_super+0xa0/0x2b8 fs/super.c:627
 kill_anon_super+0x4c/0x7c fs/super.c:1281
 btrfs_kill_super+0x40/0x58 fs/btrfs/super.c:2129
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1327
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1334
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 140212
hardirqs last  enabled at (140211): [<ffff8000805b8d70>] __call_rcu_common kernel/rcu/tree.c:3148 [inline]
hardirqs last  enabled at (140211): [<ffff8000805b8d70>] call_rcu+0x65c/0x978 kernel/rcu/tree.c:3243
hardirqs last disabled at (140212): [<ffff80008ade9670>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (138874): [<ffff8000803d7488>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (138874): [<ffff8000803d7488>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (138851): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6657 at fs/btrfs/inode.c:7943 btrfs_destroy_inode+0x264/0x798 fs/btrfs/inode.c:7943
Modules linked in:
CPU: 1 UID: 0 PID: 6657 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : btrfs_destroy_inode+0x264/0x798 fs/btrfs/inode.c:7943
lr : btrfs_destroy_inode+0x264/0x798 fs/btrfs/inode.c:7943
sp : ffff8000a6067900
x29: ffff8000a6067920 x28: dfff800000000000 x27: 1fffe0001e3721a3
x26: ffff700014c0cf38 x25: dfff800000000000 x24: 1fffe0001e372114
x23: ffff0000cb81c000 x22: 0000000000010000 x21: 0000000000010000
x20: ffff0000f1b90c48 x19: ffff0000f1b908a0 x18: 00000000ffffffff
x17: ffff800093305000 x16: ffff800082de95c8 x15: 0000000000000001
x14: 1fffe0001e3721cc x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e3721cd x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d166dc40 x7 : ffff800080e995c0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080f03e80
x2 : 0000000000000000 x1 : 0000000000010000 x0 : 0000000000000000
Call trace:
 btrfs_destroy_inode+0x264/0x798 fs/btrfs/inode.c:7943 (P)
 destroy_inode fs/inode.c:396 [inline]
 evict+0x6e4/0x928 fs/inode.c:834
 dispose_list fs/inode.c:852 [inline]
 evict_inodes+0x638/0x6d0 fs/inode.c:906
 generic_shutdown_super+0xa0/0x2b8 fs/super.c:627
 kill_anon_super+0x4c/0x7c fs/super.c:1281
 btrfs_kill_super+0x40/0x58 fs/btrfs/super.c:2129
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1327
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1334
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 140270
hardirqs last  enabled at (140269): [<ffff80008adef224>] irqentry_exit+0xd8/0x108 kernel/entry/common.c:214
hardirqs last disabled at (140270): [<ffff80008ade9670>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (140254): [<ffff8000803d7488>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (140254): [<ffff8000803d7488>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (140215): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6657 at fs/btrfs/inode.c:7948 btrfs_destroy_inode+0x294/0x798 fs/btrfs/inode.c:7948
Modules linked in:
CPU: 1 UID: 0 PID: 6657 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : btrfs_destroy_inode+0x294/0x798 fs/btrfs/inode.c:7948
lr : btrfs_destroy_inode+0x294/0x798 fs/btrfs/inode.c:7948
sp : ffff8000a6067900
x29: ffff8000a6067920 x28: dfff800000000000 x27: 1fffe0001e3721a3
x26: ffff700014c0cf38 x25: dfff800000000000 x24: 1fffe0001e372114
x23: ffff0000cb81c000 x22: 0000000000010000 x21: 0000000000001000
x20: ffff0000f1b90c48 x19: ffff0000f1b908a0 x18: 00000000ffffffff
x17: ffff800093305000 x16: ffff800082de95c8 x15: 0000000000000001
x14: 1fffe0001e3721cc x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e3721cd x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d166dc40 x7 : ffff800080e995c0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080f03e80
x2 : 0000000000000000 x1 : 0000000000001000 x0 : 0000000000000000
Call trace:
 btrfs_destroy_inode+0x294/0x798 fs/btrfs/inode.c:7948 (P)
 destroy_inode fs/inode.c:396 [inline]
 evict+0x6e4/0x928 fs/inode.c:834
 dispose_list fs/inode.c:852 [inline]
 evict_inodes+0x638/0x6d0 fs/inode.c:906
 generic_shutdown_super+0xa0/0x2b8 fs/super.c:627
 kill_anon_super+0x4c/0x7c fs/super.c:1281
 btrfs_kill_super+0x40/0x58 fs/btrfs/super.c:2129
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1327
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1334
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 140312
hardirqs last  enabled at (140311): [<ffff80008adef224>] irqentry_exit+0xd8/0x108 kernel/entry/common.c:214
hardirqs last disabled at (140312): [<ffff80008ade9670>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (140306): [<ffff8000803d7488>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (140306): [<ffff8000803d7488>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (140273): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
BTRFS info (device loop0): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6657 at fs/btrfs/block-group.c:4462 check_removing_space_info+0x10c/0x280 fs/btrfs/block-group.c:4463
Modules linked in:
CPU: 1 UID: 0 PID: 6657 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : check_removing_space_info+0x10c/0x280 fs/btrfs/block-group.c:4463
lr : check_removing_space_info+0x260/0x280 fs/btrfs/block-group.c:4462
sp : ffff8000a6067930
x29: ffff8000a6067930 x28: 1fffe0001bc4a12c x27: dfff800000000000
x26: ffff0000ca5681c0 x25: 0000000000000001 x24: 1fffe0001bc4a002
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000010000
x20: ffff0000cb314000 x19: ffff0000de250000 x18: 00000000ffffffff
x17: ffff800093305000 x16: ffff800080536230 x15: 0000000000000001
x14: 1fffe0001bc4a004 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001bc4a005 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d166dc40 x7 : ffff800082594440 x6 : 0000000000000000
x5 : ffff8000934e52c0 x4 : 0000000000000008 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff0000de250000 x0 : ffff0000cb314000
Call trace:
 check_removing_space_info+0x10c/0x280 fs/btrfs/block-group.c:4463 (P)
 btrfs_free_block_groups+0xa80/0xd10 fs/btrfs/block-group.c:4580
 close_ctree+0x650/0x113c fs/btrfs/disk-io.c:4426
 btrfs_put_super+0x1ac/0x1c0 fs/btrfs/super.c:74


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

