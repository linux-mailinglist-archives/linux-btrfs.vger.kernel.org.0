Return-Path: <linux-btrfs+bounces-7431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623795CC16
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6876C1C218DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EFB185937;
	Fri, 23 Aug 2024 12:08:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907D184527
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414908; cv=none; b=lOdLKvvXKWW+PMCaTUGpw5/thIKzcmumMPPmuDvO+216LeURU/IuNt4edfZ486xMDOkeHWK2hYpsMyWISNAXn+yJT/+M51RbN9sikfLwZDYs5gsj1Dtbv054AfkSXK4Mh3aQfOtbXsUxamq3sZNwiBQ/zo0ZRgXHYhSPZ1uO564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414908; c=relaxed/simple;
	bh=r7Eaj7mXMQh/8IZ/Yain6tLyUeeQgzb3/lHMv5XHTPA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skipoM3BbHByUm53y33hCdtoTKwncuiuoc8/EnuwAG0J+Cgyq55TsWSRa3FeRjefeZrKQsDI4yjui7q2rglamVCUg0vWb3elbPh82NkYWsbCbg5umVQeXoBhpLubd0ijISoavyxh2Eh2NtLjhEwOOipT8QV9Fku2E80MU4hGU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f99189f5fso195855839f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414905; x=1725019705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4O5L+ilAgDzsI5IhzVZvpzqMTBK9NlRE2lQLmMfk14=;
        b=pLS4zGDLZlq5if9W+NvY9FFBCvYuaokjB+dCgUmu++i6+o6XNItbYXHA4schwxS8Xb
         Z4CkvkmiS95rXVia+Gx6AGrlplW1OAsgrkfBoJW/fEgSSBU7OLVxnylQj+tTggCe5DRD
         XAbPlEhZR/39lyPHkBHiE9EcDI74y7aZFnDXIJD2TEv9Z3NHJEG4KU87ATnYyWkELeLW
         bvZ0YxRgE+LqorRkazBxEqkoPN66onuKzqAbEXzA5F2mMNyKKXWVU55Yf7IOjmne9u7u
         5XJaH1r9wC1mfG34ZclzgNRkHPd9NNh30sLSVMdMFzCEkUaK7Urzt3NQ9ELbWSvluGrP
         z/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXFFsjWE6xdvDeT7/ItaRMSAwsoq9iZzwSaI+U6oFEb5TzGKOZ1H7uh5x3xFhxHNUGbAtbvpDXreRyuMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZbImCD7k98As6itj+C0DK6LvEryzLNiwG4uftvJbfKRk37SJ
	zGdV7CgFTEOwvOtQYxPlXRsP68y3AarFrJXqLgXR2d4IPGx0vW1AjtHYKxIMnIUEcJyl7BUgajW
	pOkm42HPeDm+mtlIAKsisLLNBGyvE5CUa/J1N+jdkl02RPA5SGuW6dIg=
X-Google-Smtp-Source: AGHT+IFp7kspfNFjkAdXoqTJTcMkeqktTRlt+Zs9MC8OOufjfjOjolR/GHJjo8RuowPP4PnqE752sLrc1E6JP3fmGUTrcX6nrF75
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:4c8:d4a7:898d with SMTP id
 8926c6da1cb9f-4ce826fd9f8mr70223173.0.1724414905037; Fri, 23 Aug 2024
 05:08:25 -0700 (PDT)
Date: Fri, 23 Aug 2024 05:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc4656062058a165@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_check_leaf
From: syzbot <syzbot+d7d1fc7e21835ca19219@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154c5825980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=d7d1fc7e21835ca19219
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c63409516c62/disk-872cf28b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79b2b8c52d3a/vmlinux-872cf28b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27cb9df9c339/bzImage-872cf28b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7d1fc7e21835ca19219@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6069 at fs/btrfs/tree-checker.c:1545 check_extent_item fs/btrfs/tree-checker.c:1545 [inline]
WARNING: CPU: 0 PID: 6069 at fs/btrfs/tree-checker.c:1545 check_leaf_item fs/btrfs/tree-checker.c:1880 [inline]
WARNING: CPU: 0 PID: 6069 at fs/btrfs/tree-checker.c:1545 __btrfs_check_leaf+0x3544/0x6410 fs/btrfs/tree-checker.c:2039
Modules linked in:
CPU: 0 UID: 0 PID: 6069 Comm: syz-executor Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:check_extent_item fs/btrfs/tree-checker.c:1545 [inline]
RIP: 0010:check_leaf_item fs/btrfs/tree-checker.c:1880 [inline]
RIP: 0010:__btrfs_check_leaf+0x3544/0x6410 fs/btrfs/tree-checker.c:2039
Code: 83 d4 00 00 00 e8 cc ba c4 fd 48 8b 44 24 58 48 89 84 24 f8 00 00 00 0f b6 44 24 68 41 89 c6 e9 2a fa ff ff e8 ad ba c4 fd 90 <0f> 0b 90 e9 d6 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 8a fb
RSP: 0018:ffffc900043467c0 EFLAGS: 00010293
RAX: ffffffff83ced003 RBX: 0000000000000000 RCX: ffff88802a168000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004346dd8 R08: ffffffff83cecc97 R09: ffffffff83cecb50
R10: 0000000000000005 R11: ffff88802a168000 R12: dffffc0000000000
R13: 0000000000000fc7 R14: ffff888068f640bc R15: 0000000000000005
FS:  000055557e0c7500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94d9b15f40 CR3: 00000000655da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_check_leaf+0x16/0x40 fs/btrfs/tree-checker.c:2055
 btree_csum_one_bio+0x41a/0x890 fs/btrfs/disk-io.c:299
 btrfs_bio_csum fs/btrfs/bio.c:538 [inline]
 btrfs_submit_chunk fs/btrfs/bio.c:741 [inline]
 btrfs_submit_bio+0x1140/0x1920 fs/btrfs/bio.c:772
 submit_eb_page fs/btrfs/extent_io.c:2008 [inline]
 btree_write_cache_pages+0x1200/0x1b10 fs/btrfs/extent_io.c:2058
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
 btrfs_write_marked_extents+0x27d/0x450 fs/btrfs/transaction.c:1152
 btrfs_write_and_wait_transaction fs/btrfs/transaction.c:1260 [inline]
 btrfs_commit_transaction+0x1de1/0x3740 fs/btrfs/transaction.c:2522
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08f8b7b1a7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe63317018 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f08f8b7b1a7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe633170d0
RBP: 00007ffe633170d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe63318150
R13: 00007f08f8be77b4 R14: 0000000000022fcb R15: 00007ffe63318190
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

