Return-Path: <linux-btrfs+bounces-8690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E62996C9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C880283308
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BF1993AE;
	Wed,  9 Oct 2024 13:48:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BA197A77
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481707; cv=none; b=Witd/hH5erNdUVg2GMkOlO9K1OheY2tiHlshhxVkWBVTPsjg9MsNq7SWPKaqyUZ1si/vzC14Zj84NjoVGilv5cDnMZXNVFpLqECxOST0Ebo/3DNNgN3L5QUFLagSamHTcs0XZuwoNH6fzyTVdfMrNaFU22dLlu93xm8s3346iDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481707; c=relaxed/simple;
	bh=gASEXiZR66bIA/k4cHkwbKLHltIkFeNNC/Gi3e2bsuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HFtExir79zTE5V69p/AFoT0T+DYQvAiKzau+snddJsbbwC64PWaBLAFX5u02BIna6yVdqXjUWaZpjhegsGDOagg9h4d7+6MZyBlwgZm7nn4CUI1OeNeHk/YsXW7G5o07WGSgdvkcD3uer9sehZNvSPcDdLflYjNSL6vZg+juqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a343c444afso78321305ab.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 06:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481705; x=1729086505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW6iitnhrdxBBikdTOFclZWe4/hWRw3Ieoda0j2XAM0=;
        b=Kzmh13D6Tsa7yS5ichCersGNEI8Ql4iUWzc0lh6XbXPpilQwURyzg6Xs5aesyTXgXc
         1usHFLbvlt8KKMBwPaxElcXE+RnyLWGw8RXizEfuhNFDCUK+YQymvRQf4JQAVr79Fgf7
         3hP5M0L6A1gJtFm0pTZly7Ysw2Foz+troy3ZBOsJDWQD3bUaiud/qT7hFyPCn5NfWHly
         Zoa+I05mRj78FTrc411RkftvZc54SMTDK3r12G3BNb2AS6Z7KhMUhcUV9kUQpXlRFELZ
         9WvvZXMdKuHDQQEb5jAwyTs3kcZ7kLRwTT1fnnu6mWELsP9vrkA13Y1b8MW6jlsFMr2W
         FoeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGPJ/+UAqYWG37qtRUUS4IuQlPmLj1O9nuDEmrWCoJV87DaULtXkoHldbCg1YVh0PbwYWRJp0WcgFS/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyiems5hH3H2Y+5oraswoTTCvNdwllu6hMoQYPLC9ViaBpdAJv
	QweE99jPiQV8GYHQIxt/+KVu1dyYIfP545lxzGd/l7BlfSvaP1SDNnW/1vX+yH80cKjpKzIwigB
	/m6z4IBPpqsktm605xta7i4sMSWWn4Yb4vL8XeokFQ7m7MUcRFBTvxck=
X-Google-Smtp-Source: AGHT+IG5JEIuLJwUtyBsinNP2mTDyUISUgPaE2+buwDKV7XSwd97X7JfIR2ztJzlmSDl+maQ+yhTqdB9PWlW9fbHzJwUrBsO2M1J
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:3a0:926a:8d31 with SMTP id
 e9e14a558f8ab-3a397d10f9bmr29600295ab.16.1728481704766; Wed, 09 Oct 2024
 06:48:24 -0700 (PDT)
Date: Wed, 09 Oct 2024 06:48:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670689a8.050a0220.67064.0045.GAE@google.com>
Subject: [syzbot] [btrfs?] BUG: sleeping function called from invalid context
 in getname_kernel
From: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14771780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=02a127be2df04bdc5df0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112f97d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4f9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/disk-33ce2423.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlinux-33ce2423.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/bzImage-33ce2423.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9876580e56ab/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:330
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5233, name: udevd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 5233 Comm: udevd Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8638
 might_alloc include/linux/sched/mm.h:330 [inline]
 slab_pre_alloc_hook mm/slub.c:4062 [inline]
 slab_alloc_node mm/slub.c:4140 [inline]
 kmem_cache_alloc_noprof+0x61/0x380 mm/slub.c:4167
 getname_kernel+0x59/0x2f0 fs/namei.c:234
 kern_path+0x1d/0x50 fs/namei.c:2716
 is_same_device fs/btrfs/volumes.c:812 [inline]
 device_list_add+0xc64/0x1ea0 fs/btrfs/volumes.c:947
 btrfs_scan_one_device+0xab5/0xd90 fs/btrfs/volumes.c:1538
 btrfs_control_ioctl+0x165/0x3e0 fs/btrfs/super.c:2264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa2bb1ad49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffd55ec91e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faa2bb1ad49
RDX: 00007ffd55ec91f8 RSI: 0000000090009427 RDI: 0000000000000009
RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd55eca238 R14: 000055773bb412a0 R15: 00007ffd55ecaf58
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

