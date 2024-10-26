Return-Path: <linux-btrfs+bounces-9187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCC9B1525
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 07:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896071C21295
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 05:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451D16EB76;
	Sat, 26 Oct 2024 05:29:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F9217F2E
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729920572; cv=none; b=N+mTifHW3rqVodt6E7WNbme+NgUxY0mlDkDnrYgSyjdvfSyc9jdaGALBOzJ3WAd3TyhuetZ+I8TWtpOFXqRVzrSSFz/+wm6FNJT9XGg/paO9tNJ3z5lnbX4MK8X9Fyzi6NaOr/lSyM7aM4NqgmZzHQWuPwpnnjoHnUOfUKLE4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729920572; c=relaxed/simple;
	bh=ExpI5H7qpl/7akmGXG2H673MdQwvxqQ4zKOTDwHEE2g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=chfhN0B57u6eZnQ8n7W7Tn9THbk7j+4DFwAuLbOpD6bkGOOTDQ2/hsE+//Ki7t1jq0cGHbbLmlSopiexOjAMSuxqaqdODv8WrdlsRtNqC+CX+vWdcwN0XcBQ1TKgpYVhtGvjxZM6laH07v+d4UUdaj9lkOBntj4OzrH3dZqftik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4ed20b313so4234535ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 22:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729920569; x=1730525369;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Sje68ti6khqDF2RafWzMOuEveUK+HD4XzCLqUDH3E=;
        b=mKMlusXnWuAHo3WBfg0x2t6MGlSbnAy/SuMPEhH8L6XfyStucNExzmCv/6fCNZ3Acq
         hcKVamRFC7OHGAQtH5mmDMfiTm5M5jjHYdjWwlhCUn9FAVg5xLFxwlfZjgfoBtZX+NaR
         CKJ6VwXdwpAjJmb5KLsjfNb2kvuYBNp+A++ao1Uib82SCQGgBUdaOmiv5qwdoLfRQCWM
         9w2aRy9mOPhxpxVmb06oQ+newZyFPJRnnXpezDOVRwSFVEsPUMVWB1EQn7PTWfqEfxrG
         CZH7NJgA093X0u14tW4Tvs/Wyj7+Yp/+I26Pw6uU8ODYBZfOrR/a7zROf1t+rT+d5Cj9
         y9YA==
X-Forwarded-Encrypted: i=1; AJvYcCW0QLAGCGLil3UxNmrpEBkLMtB38c+L4DifS+Rhrbq3/oMJ1EtCI4Jhaqru8aNi43Zbpaqu1cl266oDsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfsw0CZ0eAT3RUt/d3xFX69J7A+ICJJTBevLF8dy81S4rgVvvi
	cZsWciwSDsMqLiNNzU41NcNQQG2VsUgfzLEOFr0KXq1eOrRGjb1Yvcy832wAvgfOQznfYg7zjLT
	0wHbcg8twab0dfGTljOKoH26Fs/w/XWD75tVamBbvoW3wUYOu2qAGF4Y=
X-Google-Smtp-Source: AGHT+IFgZq3hlaklTm4R8KyUayNK5t0pCS1JkjN42CyFSrfBaRwoVRPBpv5jLuLVuAoDJ2tiF2E+TOJdazPXbJcZfrlh1F7sobHg
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a4ed2de146mr15091405ab.16.1729920569483; Fri, 25 Oct 2024
 22:29:29 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:29:29 -0700
In-Reply-To: <6717b381.050a0220.1e4b4d.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c7e39.050a0220.2fdf0c.0223.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_free_reserved_data_space_noquota
 (3)
From: syzbot <syzbot+9064acebb06685edb243@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c71f8fb4dc91 Merge tag 'v6.12-rc4-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b4be40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=9064acebb06685edb243
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1583565f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14364230580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c71f8fb4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a47500c947a2/vmlinux-c71f8fb4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8ce30ea9c33/bzImage-c71f8fb4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4295a6e8b13/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9064acebb06685edb243@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007faed37be5ad
R13: 0000000000000048 R14: 0000000000050012 R15: 0000000000000003
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5313 at fs/btrfs/space-info.h:250 btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:250 [inline]
WARNING: CPU: 0 PID: 5313 at fs/btrfs/space-info.h:250 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:283 [inline]
WARNING: CPU: 0 PID: 5313 at fs/btrfs/space-info.h:250 btrfs_free_reserved_data_space_noquota+0x287/0x4f0 fs/btrfs/delalloc-space.c:179
Modules linked in:
CPU: 0 UID: 0 PID: 5313 Comm: syz-executor192 Not tainted 6.12.0-rc4-syzkaller-00256-gc71f8fb4dc91 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:250 [inline]
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:283 [inline]
RIP: 0010:btrfs_free_reserved_data_space_noquota+0x287/0x4f0 fs/btrfs/delalloc-space.c:179
Code: 00 74 08 4c 89 e7 e8 d8 d8 23 fe 4d 8b 2c 24 4c 89 ef 48 8b 5c 24 20 48 89 de e8 54 1d ba fd 49 39 dd 73 19 e8 ea 1a ba fd 90 <0f> 0b 90 31 db 4c 8b 6c 24 10 41 80 3c 2f 00 75 2b eb 31 e8 d1 1a
RSP: 0018:ffffc9000cf87200 EFLAGS: 00010293
RAX: ffffffff83dacf86 RBX: 0000000000800000 RCX: ffff88801f67c880
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 000000000064d000
RBP: dffffc0000000000 R08: ffffffff83dacf7c R09: 1ffffffff203a055
R10: dffffc0000000000 R11: fffffbfff203a056 R12: ffff888039a35868
R13: 000000000064d000 R14: ffff888043280000 R15: 1ffff11007346b0d
FS:  0000555570aa2480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564b95a54fa0 CR3: 0000000042d7c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_reserved_data_space+0xa2/0xe0 fs/btrfs/delalloc-space.c:199
 btrfs_dio_iomap_begin+0x7c6/0x1180 fs/btrfs/direct-io.c:598
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdea/0x2370 fs/iomap/direct-io.c:677
 btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
 btrfs_direct_write+0x61b/0xa70 fs/btrfs/direct-io.c:880
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1505
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x179/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faed37710f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec7fd94e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007faed37710f9
RDX: 0000000020000540 RSI: 000000000000003b RDI: 00007faed3712000
RBP: 0000000000000002 R08: 00007ffec7fd9286 R09: 00007faed3003632
R10: 0000000000000000 R11: 0000000000000246 R12: 00007faed37be5ad
R13: 0000000000000048 R14: 0000000000050012 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

