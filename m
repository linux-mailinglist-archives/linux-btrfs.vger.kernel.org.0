Return-Path: <linux-btrfs+bounces-14542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90348AD0D4D
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B0D17000C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55457221FD3;
	Sat,  7 Jun 2025 12:15:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A021FF41
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749298504; cv=none; b=dwvKDLlRNeFtlGJLUVXTLdjJOQEaQJHtJiBKnsr+6mMByHSpII7+XwmwNDLFpCPe+yY4zR8LEFnDhXb6qQTJ9vxPvnSwyjHmtRTwMo1n09UlIMSjPN7ecrP3UZigk4KBKYO0B302YrprG4j7ZQoUEe6QqHX9VoHUorRjaGjVuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749298504; c=relaxed/simple;
	bh=oLtwGz2om7Uq3VZsgJHxRqVOBLG1WKvnFPqv+epsekE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sAhKDlI3Ncke8CpNJMadjAonYA2+/txzHwghZcEzsRNjodtmpq6hyBvCQfVZhcfkG5nTRSNO1JPG0ClKcwkUUqT/0Vqb5fAbiOC242CGisb7pPReUCELcG6yDvlVC+vHIH5Kpye1mqLSg6CDoG4G3HNjON+85DwK7ok8+5iEnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so64452275ab.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Jun 2025 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749298502; x=1749903302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6khKyuzNrG0UiD6tiQwVZA1S1mtehdI0hb+YyqvtkU=;
        b=dpHEZT5T0uC2VO+QGQAnjHmsMSowFak1QHMxwomQZAdbOpxwu4GkcpK6uOvgr0w/sD
         0tAijrZARB8Ata3AbaMMoeFVivv9Wnp9TtE2BK974d6JsT7iNe8aiYCzCgF3dQEoDN46
         JUfMpQhN55mEZQ0/hINLZAOvEpqbMi3M5pn/BKYEaolvs9Gv4Qhpff1O8KffQ0v5VJMb
         JHBrrg1lAQPQDZfZhuZWHYszu6VhhgY3Ayyd7DSyH9N/vWiBbJqZSa/avdF2SH7J/aB/
         jBzOEbRDfifUj01+fLDxPpDr6rSeA07oabk2WjCe71J7alId2LwjDI4o9vrF/2+Ove07
         n7GA==
X-Forwarded-Encrypted: i=1; AJvYcCWPrD3B4TzmT3rwdikPmpo8vF7L8JwDpBOS9NGkmhbbEGs10eXrwkNDjM/1Br3Pt64oT5rq9Rj60dIBFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpK3bsuQyO9dXmASIUR+YJM8a3IaHaOfcG+nmWcot6viBua6b
	k2yCAq5VDgpyQbXv078w5uuLfyVzsVfuhDZ1MVuYZH+PRbO/gn8Ixo6R3ecGTKw0c8oLGzfG4GC
	ZQkwTvsTbKCrQspfrk1RA9rTMbnItuge302K/1kv9TF9YG1PmxcBLRMEZNxE=
X-Google-Smtp-Source: AGHT+IHmL9BLSnu80DN+JqbFo/KZW5om0NI59h0+mNh5EYW7C17VUc7j20kQei8sTorluQ6q/UGSySzVRqbRuxM686EwmuOHiLb1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3dc:7b3d:6a37 with SMTP id
 e9e14a558f8ab-3ddce423461mr75897805ab.8.1749298502572; Sat, 07 Jun 2025
 05:15:02 -0700 (PDT)
Date: Sat, 07 Jun 2025 05:15:02 -0700
In-Reply-To: <CAJZ91LC2PXK-F8D7br-JKWiREf0hb2BFbEXvugN+=xzuTPdK5Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68442d46.a70a0220.27c366.0045.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in populate_free_space_tree
From: syzbot <syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com>
To: abinashlalotra@gmail.com, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in btrfs_rebuild_free_space_tree

BTRFS warning: 'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead
BTRFS info (device loop2 state M): rebuilding free space tree
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 1 PID: 7626 at fs/btrfs/free-space-tree.c:1341 btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
Modules linked in:
CPU: 1 UID: 0 PID: 7626 Comm: syz.2.25 Not tainted 6.15.0-rc7-syzkaller-00085-gd7fa1af5b33e-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
lr : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
sp : ffff80009c4f7740
x29: ffff80009c4f77b0 x28: ffff0000d4c3f400 x27: 0000000000000000
x26: dfff800000000000 x25: ffff70001389eee8 x24: 0000000000000003
x23: 1fffe000182b6e7b x22: 0000000000000000 x21: ffff0000c15b73d8
x20: 00000000ffffffef x19: ffff0000c15b7378 x18: 1fffe0003386f276
x17: ffff80008f31e000 x16: ffff80008adbe98c x15: 0000000000000001
x14: 1fffe0001b281550 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b281551 x10: 0000000000000003 x9 : 1c8922000a902c00
x8 : 1c8922000a902c00 x7 : ffff800080485878 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008047843c
x2 : 0000000000000001 x1 : ffff80008b3ebc40 x0 : 0000000000000001
Call trace:
 btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341 (P)
 btrfs_start_pre_rw_mount+0xa78/0xe10 fs/btrfs/disk-io.c:3074
 btrfs_remount_rw fs/btrfs/super.c:1319 [inline]
 btrfs_reconfigure+0x828/0x2418 fs/btrfs/super.c:1543
 reconfigure_super+0x1d4/0x6f0 fs/super.c:1083
 do_remount fs/namespace.c:3365 [inline]
 path_mount+0xb34/0xde0 fs/namespace.c:4200
 do_mount fs/namespace.c:4221 [inline]
 __do_sys_mount fs/namespace.c:4432 [inline]
 __se_sys_mount fs/namespace.c:4409 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4409
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 330
hardirqs last  enabled at (329): [<ffff80008048590c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1525 [inline]
hardirqs last  enabled at (329): [<ffff80008048590c>] finish_lock_switch+0xb0/0x1c0 kernel/sched/core.c:5130
hardirqs last disabled at (330): [<ffff80008adb9e60>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (10): [<ffff8000801fbf10>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (8): [<ffff8000801fbedc>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BTRFS: error (device loop2 state MA) in btrfs_rebuild_free_space_tree:1341: errno=-17 Object already exists
BTRFS warning (device loop2 state EMA): failed to rebuild free space tree: -17


Tested on:

commit:         d7fa1af5 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=152cfc0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89c13de706fbf07a
dashboard link: https://syzkaller.appspot.com/bug?extid=36fae25c35159a763a2a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168d7282580000


