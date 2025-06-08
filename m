Return-Path: <linux-btrfs+bounces-14545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75159AD1505
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301C2168ECB
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD90254B17;
	Sun,  8 Jun 2025 22:10:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EE1FF1D1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749420631; cv=none; b=Zmytjifb2xSAtSCxr2dUjYDw8kHs81Fdnx0e+fEZOilDQqEMdFW1z1+ythDB93RU2sBEV/EKSDhilKhZg4lIuf44LBZe87kjkHd1MEvoprp/nmJzgyjUHvZkm4j9uJwh9i69a8RavGmCjzvVdSNzxbSgVapiZc2vlqQAUp8oU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749420631; c=relaxed/simple;
	bh=lPSB7kzCuFDsyKZcCDyQcY133wGxZ8f2OySUDkXj3Ck=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=km0uJzyRC4hJW5TLH16sYC/MuskACOClcr2+XHkSg+2SPdaikHigMGmEtN4P7TnUoeJM3rU3pyLnPWQ96sCGhRAT+AFfzb1qBHdbbJ4To4iNLA87rMMPi80y1iVNXG+I8sBKP0QHmF6Ni85FRCQ1NCYVwm/8Ucpu1q7RU9nbyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so393014039f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Jun 2025 15:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749420628; x=1750025428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfvDTEqcQRn5tT2CV9k08iD+3Mt7MRIhn+0umO+AibY=;
        b=lhs1Wk6Pf57krP0UBP3zXoQcwGLgH9U4R/PeZPdJ7SoY4ywWxKN1FJ2UppolG3VY7x
         7NxUcdCNgvgbF9NricRi/F+6j7iF3hiIgJ6d2j9mhgylaFvZ9XgjHafpmIf7K6xKOyN0
         uIN4wlmKh/gNgElGpvcFCk7Gws/VceGpyJiaELQ0BD3nV48SjsV3Ez6/am3Rv6vSyQDd
         CNGd8rkSqOmz2piMj1+W09Uttn0a96dD/dCVN29ZcxWycBzh626+wsV2v6DdGMux0XgG
         bMRo5t5oLg62eg+8OFzAzl0FZFCGLfuIr20PO7Nm9cKmJURsj5FtHoh0zvsDbbrfbwZB
         yDJA==
X-Forwarded-Encrypted: i=1; AJvYcCVhb27rhCPD8zFuCauZPwwfgoLreBdp70mdVbRfYbhTKI0u+NNevpbVdDZbA3zV1tV1LUvKY8hUNFTwQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYZ5tV2Gd13F6BpCDYzMrb+8LJNAlAAMkljLAAh2uIg13Oqwh
	zvmWCVBDin6r52dlBn33Bv9L2nheotivWMSN5eKD0xi/euMDyP1Ie5UEZPjDPVJZaXOOIsjPtue
	sizx4lbsG/A5WXacBzrt2khgFulUNxcGnu6Rx5pUC5a3fdYLbbEFGe+h+YFY=
X-Google-Smtp-Source: AGHT+IGJsCHEu/pt7o7yqGhvL24hgEVMtSq2pQsQ/muXg1IsOa11NA8rXFwNdC627zKAFeqiAzKHCiUgy5trS3yHtVseAJV2VCqa
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3dd:c4ed:39ba with SMTP id
 e9e14a558f8ab-3ddce3ce038mr126748085ab.1.1749420628664; Sun, 08 Jun 2025
 15:10:28 -0700 (PDT)
Date: Sun, 08 Jun 2025 15:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68460a54.050a0220.daf97.0af5.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_rebuild_free_space_tree
From: syzbot <syzbot+d0014fb0fc39c5487ae5@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7fa1af5b33e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=143b9282580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89c13de706fbf07a
dashboard link: https://syzkaller.appspot.com/bug?extid=d0014fb0fc39c5487ae5
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1264740c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123b9282580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da97ad659b2c/disk-d7fa1af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/659e123552a8/vmlinux-d7fa1af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ec5dbf4643e/Image-d7fa1af5.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c104fe6fa41d/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16d34c0c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0014fb0fc39c5487ae5@syzkaller.appspotmail.com

btrfs: Deprecated parameter 'usebackuproot'
BTRFS warning: 'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 8268 at fs/btrfs/free-space-tree.c:1339 btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1339
Modules linked in:
CPU: 0 UID: 0 PID: 8268 Comm: syz-executor373 Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1339
lr : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1339
sp : ffff80009c4d7740
x29: ffff80009c4d77b0 x28: ffff0000c1934000 x27: 0000000000000000
x26: dfff800000000000 x25: ffff70001389aee8 x24: 0000000000000003
x23: 1fffe0001bb6ceea x22: 0000000000000000 x21: ffff0000ddb67750
x20: 00000000ffffffef x19: ffff0000ddb676f0 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008adbe9e4 x15: 0000000000000001
x14: 1fffe0003386aae2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60003386aae3 x10: 0000000000ff0100 x9 : c8aea423d56d4800
x8 : c8aea423d56d4800 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c4d7098 x4 : ffff80008f415ba0 x3 : ffff8000807b4b68
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1339 (P)
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
irq event stamp: 230
hardirqs last  enabled at (229): [<ffff80008055041c>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (229): [<ffff80008055041c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (230): [<ffff80008adb9eb8>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (8): [<ffff8000801fbf10>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff8000801fbedc>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BTRFS: error (device loop2 state MA) in btrfs_rebuild_free_space_tree:1339: errno=-17 Object already exists
BTRFS warning (device loop2 state EMA): failed to rebuild free space tree: -17


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

