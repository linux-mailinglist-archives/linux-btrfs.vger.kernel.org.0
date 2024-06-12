Return-Path: <linux-btrfs+bounces-5666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E267790561E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995611F23C03
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753F1802D8;
	Wed, 12 Jun 2024 15:00:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117F17F4EE
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204427; cv=none; b=sI+ESkudQKC1FkiNYhMTuwnABudhKktbHYF3Yrqod4/O0M3I3Hx6Dk7MYQSxTFeeD6q4pmwzuirH6m/u/7DZW67sL9/V4AGNanAAvzdte6F72BQuI15mug4Lql/SGuIvOW98HUXh3efMmgyu9+l025QN6P22cNLAI2mOcedB9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204427; c=relaxed/simple;
	bh=3eMaFVhay/i0vo7c+Hz/UuCWshmGXLFqDysYaOiFKVE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WfquAdrSQNk2vP2W1p+6JNiatBRq/l2PgNeEdJ8gMwXbcab+/kJ4jfPojPIzXkwU62gNlMHRuH9fjnoausipu3Stc6zX7jl+B1m1cp9UPXLNOZMSSH6xu6mNoTRHa7HrYTu4k8IjXc8VZBJb9LyDX9cGpdUDDYMJQi8h1C52Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3737ee417baso7946675ab.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204425; x=1718809225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbeKAD+PQktYXehGoaYBo7fgZr7EtmHmdBdx3YMLw+8=;
        b=ilsTceopu8AKd+Qrc2eEmlCsGb4+DhMzdLSy8L/hc+YZB+g3YJqcB68Cg0PNLGtxa/
         6XD1XJibM3FHPLUfiDHKbcFcIh46UU5XPRjsTszcf6dJ5QuuPeMFdNJoX1uFqJ5rZRBY
         TLjziFv849moxcrUyoiLKGw661MO1tzmFcG3qpRplJQUlgU3CHK7GENf3pfIuO7TLJZW
         vJ98BD+X99fJFdABEvWjNCNVmF0omfG1rDuMNbLFGUvnhEY02VsNI0A2NMydmCkSxjO4
         OzODhceDsHuSmyTcj71AIYj5QracHkGNsfZFYlQMb1vEoUXiVQJSdaw7mklRY4lAcBQ9
         FskQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/ME2CQQoYlDecJXO5OaGx5ll5IGX4dsq3vnJpnHBKmTd1I5sagwHf1aInu24rYjjs/rd8hm+oTDodo0lolYeP/2Rizkc7Lh9cI0=
X-Gm-Message-State: AOJu0YyUOU483hJDyONRWhDZHjaEFMwYLetrY4xjGjMq0b+P6EWT8Jqs
	xMuCCOBAiCJ/bO7VvzQBs2oMyg4jrS+Be1N5aUsNS2SclWAglRpPKH2qJ0xoLDjoydfCCq7bs/v
	a0RVdijZMUUhuHvzbiMbaI1oVtTk9BhJzcngaPp2i/hr+6t8+9jVKK50=
X-Google-Smtp-Source: AGHT+IH3R32w1VW7Y2KaLY6PKpWL/Q9c51grIOOxTjW+pjUsEJNpELXxCAVB7ZiQGeyWSoEcdBoZj0tbye8niqMEx6mmZWpU4TE/
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:374:9ea3:a2e with SMTP id
 e9e14a558f8ab-375cc8768b6mr1765605ab.1.1718204424911; Wed, 12 Jun 2024
 08:00:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000660926061ab2a441@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in iov_iter_alignment_iovec
From: syzbot <syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166b7286980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113f7f16980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11698dce980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b8b22127e3de/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in iov_iter_alignment_iovec+0x1a8/0x470 lib/iov_iter.c:788
 iov_iter_alignment_iovec+0x1a8/0x470 lib/iov_iter.c:788
 iov_iter_alignment+0x1aa/0x290 lib/iov_iter.c:833
 check_direct_IO fs/btrfs/file.c:1452 [inline]
 check_direct_read fs/btrfs/file.c:3736 [inline]
 btrfs_direct_read fs/btrfs/file.c:3765 [inline]
 btrfs_file_read_iter+0x46f/0xc70 fs/btrfs/file.c:3826
 call_read_iter include/linux/fs.h:2114 [inline]
 aio_read+0x4b3/0x690 fs/aio.c:1611
 io_submit_one+0x2809/0x3280 fs/aio.c:2061
 __do_sys_io_submit fs/aio.c:2120 [inline]
 __se_sys_io_submit+0x275/0x700 fs/aio.c:2090
 __x64_sys_io_submit+0x96/0xe0 fs/aio.c:2090
 x64_sys_call+0x3620/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:210
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable inline_vecs created at:
 aio_read+0x4c/0x690 fs/aio.c:1592
 io_submit_one+0x2809/0x3280 fs/aio.c:2061

CPU: 1 PID: 5053 Comm: syz-executor335 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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

