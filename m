Return-Path: <linux-btrfs+bounces-16113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158EBB29244
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Aug 2025 10:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB55178309
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Aug 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738B21D3E8;
	Sun, 17 Aug 2025 08:34:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8921CA02
	for <linux-btrfs@vger.kernel.org>; Sun, 17 Aug 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419687; cv=none; b=PXM3/jCBtAUy9on40JGoPBKHX1dphvl2xfDciP65cdcYwmQKDymHp2hPX06koswbxk58zIXm0habqGIVm21wO4OPiENoMVRx3uwxh5pBEJLYnZXsqz6Ga7id9ylViZDNu6wSHMJ8DOg7WcYYFYf+CgDkMqISzikI/9glZSQKW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419687; c=relaxed/simple;
	bh=wH/Ubat2+7BnZ75tSogI77zPUJTcOLjX8OSOefRzHNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KNsg17OKdhIRTr+wSJ0OTrO+eO3qjVF0eq38wkzXRIu2PjXyqJp9LMlLwQbZf+y+orEAY/nJ55/apdLIhNPGlzQyZWabUZJtuAKNS3XwejftyNHj2XRWABR4Z71wdyMiY2l+9c3lj/MGR57dXRE4JID4JIw2PfQoFHTjs6Wy5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e570051e69so40174525ab.2
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Aug 2025 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755419685; x=1756024485;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XbfEN1k/gSsBEABxdcrTawukqj9qiBDPSr2V37dmic=;
        b=jZ0105CYWkgRUth6lS05X2eLdomdublQ6RjVvPg3ycg7akxAqLHfma6llh40eCirOE
         StpgtrVac3QKuhefBytE6q5JyckIRf4ErNytw3LIUrLndbB9fiGAg9mQvZv3AWjXWely
         55/Fd9Hm0z1Q5ZUPDU3X3U23juDBPoQqlYvjXAYcJwwNocGJiNFd3rRyw6YIn/8krGY4
         CS9m6C087foRW7rr5nJBjcKcL/qowOmifYuuvcRlWhrn3198gtEshVSicE+bKsV0Cuzr
         lTvJCT1IBOcR7+mGCIeO5h/XggP0resdK+nMYgxXQmzBdN4SV3jzZnMg+b0Tuy7hQ1zb
         KwEw==
X-Forwarded-Encrypted: i=1; AJvYcCXX9kBCg21BtDL7WzJ4zoW1VG9fyHe9OCI/iPwS5k3C3hOBf4asX4OcxakwG4SKQ0UDxKnbBYn0zVzvOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyivbHH7j6tiO2zs1U8VM3DsB3V0QQYS5+qb9CsVi+gfLUVAjGT
	Ur7CdjYdXz6hrt7fMAsAwXl5E5ZcUShpzMlH/1LIw8N2y9Jh5H6dpCNevkknCPbkQBnEu0I0kVW
	/Nf9FkGXmuFG6+KSHzeciqTCoMVmgVdOTsCjCDOldO3tM3AY6wy12JMiADvE=
X-Google-Smtp-Source: AGHT+IGiWqrm1nJEcVFM1ZVWdN0l9BXcpBE0JAq4jPEYdSb0wjl90ebdKLrv0nt+wJuydm1ouwQt+qpV+rodHXLfAEpOXkVHEmO3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:3e5:66a6:a46a with SMTP id
 e9e14a558f8ab-3e57e9c4a5emr131036615ab.17.1755419684780; Sun, 17 Aug 2025
 01:34:44 -0700 (PDT)
Date: Sun, 17 Aug 2025 01:34:44 -0700
In-Reply-To: <cover.1755300815.git.boris@bur.io>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a19424.050a0220.e29e5.0065.GAE@google.com>
Subject: [syzbot ci] Re: introduce uncharged file mapped folios
From: syzbot ci <syzbot+ciacf14517a343602e@syzkaller.appspotmail.com>
To: boris@bur.io, kernel-team@fb.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	willy@infradead.org, wqu@suse.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] introduce uncharged file mapped folios
https://lore.kernel.org/all/cover.1755300815.git.boris@bur.io
* [PATCH v2 1/3] mm/filemap: add AS_UNCHARGED
* [PATCH v2 2/3] mm: add vmstat for cgroup uncharged pages
* [PATCH v2 3/3] btrfs: set AS_UNCHARGED on the btree_inode

and found the following issue:
WARNING in folio_lruvec_lock_irqsave

Full report is available here:
https://ci.syzbot.org/series/15fd2538-1138-43c0-b4d6-6d7f53b0be69

***

WARNING in folio_lruvec_lock_irqsave

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      dfc0f6373094dd88e1eaf76c44f2ff01b65db851
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/5b3f7bc8-d0c2-4985-8ae6-d51ea4e2baed/config
C repro:   https://ci.syzbot.org/findings/f02552bd-e7e6-4c3f-8cc3-04a5a946771d/c_repro
syz repro: https://ci.syzbot.org/findings/f02552bd-e7e6-4c3f-8cc3-04a5a946771d/syz_repro

 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5951 at ./include/linux/memcontrol.h:734 folio_lruvec include/linux/memcontrol.h:734 [inline]
WARNING: CPU: 0 PID: 5951 at ./include/linux/memcontrol.h:734 folio_lruvec_lock_irqsave+0x184/0x1d0 mm/memcontrol.c:1252
Modules linked in:
CPU: 0 UID: 0 PID: 5951 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-00036-gdfc0f6373094-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:folio_lruvec include/linux/memcontrol.h:734 [inline]
RIP: 0010:folio_lruvec_lock_irqsave+0x184/0x1d0 mm/memcontrol.c:1252
Code: 74 0c 4c 89 f7 e8 cc 53 f8 ff 48 8b 04 24 49 89 06 eb a0 48 89 df 48 c7 c6 60 4e 98 8b e8 a4 36 fd fe c6 05 52 a1 62 0d 01 90 <0f> 0b 90 e9 a5 fe ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 22
RSP: 0018:ffffc9000359f540 EFLAGS: 00010246
RAX: f0f9782cf8520600 RBX: ffffea0000807140 RCX: f0f9782cf8520600
RDX: 0000000000000002 RSI: ffffffff8dba6067 RDI: ffff888020a73980
RBP: ffffc9000359f5e0 R08: ffff88804b024253 R09: 1ffff1100960484a
R10: dffffc0000000000 R11: ffffed100960484b R12: ffff88804b032fe8
R13: ffff88801ba80918 R14: ffff888106950000 R15: 0000000000000000
FS:  0000555587fa3500(0000) GS:ffff8880b861c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00003e720 CR3: 0000000029a9c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 folio_lruvec_relock_irqsave include/linux/memcontrol.h:1544 [inline]
 folio_batch_move_lru+0x20a/0x3a0 mm/swap.c:167
 lru_add_drain_cpu+0x119/0x880 mm/swap.c:647
 lru_add_drain+0x122/0x3e0 mm/swap.c:735
 __folio_batch_release+0x48/0x90 mm/swap.c:1054
 folio_batch_release include/linux/pagevec.h:101 [inline]
 invalidate_inode_pages2_range+0x889/0xa80 mm/truncate.c:707
 close_ctree+0x6ff/0x1380 fs/btrfs/disk-io.c:4408
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_anon_super+0x3b/0x70 fs/super.c:1282
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2114
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1378
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a78b8ff17
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe33fe80a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f4a78c11c05 RCX: 00007f4a78b8ff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe33fe8160
RBP: 00007ffe33fe8160 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe33fe91f0
R13: 00007f4a78c11c05 R14: 000000000000f471 R15: 00007ffe33fe9230
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

