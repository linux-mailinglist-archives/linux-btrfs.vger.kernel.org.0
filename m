Return-Path: <linux-btrfs+bounces-12112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506BA57DDC
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Mar 2025 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2599D16D699
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Mar 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03A1FF1B4;
	Sat,  8 Mar 2025 19:48:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8A1392
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Mar 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463311; cv=none; b=GrqWRxjIuwAgFW/B9zYz7J4XOjUHN9wjEzBzXLn9s5G1fJ/E+ubiGFTuko4ABGLjs6u07OC8ElUeBEHSPznXI+SLM5kmBLB3L/nGOcI9uZdy+nRRBzLMdxaQ5bosxFKrRaVcXCjjN1496jok9/0e8xe5o+X5rjJD4JMlk18bKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463311; c=relaxed/simple;
	bh=/5WWxSf8LBpQx8K8lp+pJVwAGjgJTD/bO+VcFtfoito=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DMcUi4bAl3HhVhDBNkAHtisDxI1m14ZEuL/GiK01exV7Hi4BooC8d/Ane5m+wm/2IkjSIGUSDvHC8uD9vhJKN81iC9d/JcAZeafr3u6eTt9aJIq0M1w5J0lnsvD2GWoWbzB4+XXJjC7Vc3C2Z/I8zoqUVIX1ZXxTp3KU1xo7s4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2a6102c1aso62997775ab.0
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Mar 2025 11:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741463309; x=1742068109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0kUnKJ/Hbb5rDIh+tNr9gyaBINNXokpFjGp9x/PF8M=;
        b=Kw4QOg6OAlLPMuyr5vDSXeVlHnb5nIp561THr/7S2hOGDzhwWekTYT1Lc5RlRcEJVM
         eAc0GfHu8gyVUigIdFABC2OqAaLrDFzpok3ksobMAGqNQA3+h5/8NvdwEqZm2rOdyIaN
         WtHdE2v3qRpL1+L6V8LnOgRCM0s4nsGgFjUO1gDgIcI0rZdg4Oe4yU3QL0cSrZRRN4ot
         3qSocDtaWCifvKG/2/BOwDv2tbOAqlginr8aXXOARJXgXES64liP2mOg/bfuXjRjGCiW
         QogPoUGzczYXBwhwZSnkqJbrQCgccORSMNe7ITwLIIphiColBwypmJ2NXVd+CAXG8cAU
         uOIg==
X-Forwarded-Encrypted: i=1; AJvYcCVil1JNpzGlKkRRHs4K1BfdadnavN3yZuVTAegiJkE0gOVzc9YXm1iGir1/LSvKnEp8Hh9E3IX12v0b3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WkX1UDasIRsFztDGxFbJBvOPbpZ5GfbK9qxQvAVq65LFszb3
	rgd5x2OUg9yQ4Eck6xWD/ofViR34zyySztgaH9ska3dPRvM1rsdcoDpj89Cz7MEFRgeQH59PJuQ
	g/kmXHxXbDzeFWVD4M40i3qVIQKePqvq+15v7mwIYUViuuNRsDWKdlV8=
X-Google-Smtp-Source: AGHT+IEqcZbX5J85DTBCue0PG8qnSzRG01E+SQFqUCUZBh1LtXPyygujlM2Y6neUvt2/k9DuW8z1Nk7meMsRREAOhWorl9BY6WwZ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d44195797bmr95723035ab.18.1741463309517; Sat, 08 Mar 2025
 11:48:29 -0800 (PST)
Date: Sat, 08 Mar 2025 11:48:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc9f0d.050a0220.14db68.0046.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_create_new_inode (2)
From: syzbot <syzbot+35244a1be5611b840ab2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99fa936e8e4f Merge tag 'affs-6.14-rc5-tag' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1079b5a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=35244a1be5611b840ab2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b40ecb8ed597/disk-99fa936e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16348198506c/vmlinux-99fa936e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65fc34c1d4d6/bzImage-99fa936e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35244a1be5611b840ab2@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 7341 at fs/btrfs/inode.c:6384 btrfs_create_new_inode+0x1c10/0x1fa0 fs/btrfs/inode.c:6384
Modules linked in:
CPU: 1 UID: 0 PID: 7341 Comm: syz.4.132 Not tainted 6.14.0-rc5-syzkaller-00013-g99fa936e8e4f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:btrfs_create_new_inode+0x1c10/0x1fa0 fs/btrfs/inode.c:6384
Code: 49 8b 3e 48 c7 c6 a0 8c 6c 8c 44 89 e2 e8 78 ea 3e fd eb 1a e8 91 f3 d8 fd 90 48 c7 c7 40 8c 6c 8c 44 89 e6 e8 71 af 98 fd 90 <0f> 0b 90 90 4c 8b 7c 24 38 e9 43 f8 ff ff e8 6d f3 d8 fd eb 05 e8
RSP: 0000:ffffc90005447a20 EFLAGS: 00010246
RAX: b537982dfbea0300 RBX: 0000000000000000 RCX: ffff88807c24da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90005447c50 R08: ffffffff81817d42 R09: 1ffff92000a88ee0
R10: dffffc0000000000 R11: fffff52000a88ee1 R12: 00000000ffffffe4
R13: 1ffff1100b55d70f R14: ffff88805aaeb878 R15: ffff888028651f20
FS:  00007f7bffc1a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f664e111000 CR3: 0000000076f6e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_create_common+0x1d4/0x2e0 fs/btrfs/inode.c:6615
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4313
 do_mkdirat+0x264/0x3a0 fs/namei.c:4336
 __do_sys_mkdirat fs/namei.c:4351 [inline]
 __se_sys_mkdirat fs/namei.c:4349 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4349
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bfed8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bffc1a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f7bfefa6080 RCX: 00007f7bfed8d169
RDX: 0000000000000008 RSI: 0000400000000100 RDI: 0000000000000003
RBP: 00007f7bfee0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7bfefa6080 R15: 00007ffe1988f628
 </TASK>


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

