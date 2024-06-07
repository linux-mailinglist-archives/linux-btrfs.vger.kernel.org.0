Return-Path: <linux-btrfs+bounces-5519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EC8FFA39
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 05:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60072286328
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C018C3B;
	Fri,  7 Jun 2024 03:40:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CF79DC
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717731629; cv=none; b=CVlv/Dw61eWmGFx7ocNNN06C6tn8zphYAHrMzsnQwg8900GR8BfJDBRPazNKSx6tMS4asfO+opHvxHdxVW51wg1GlGrKPUhiwnPq0SEh4ws3aCHNUqvBXFColgHIxSdQQPaugV/4SgFI4BGUNqGiytitIi348l7Tm9J1fk1rYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717731629; c=relaxed/simple;
	bh=ATrdjV99vrwXnwpb8CC00otkfBEA3CF2mfwankEHGpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mAdEHIfudQLDheVfK+TZIzIXXgKSK1V+GtksWX3xOYBivyTnnGG7z0vleWLSZs5bjkWex4oW0OkwnGzv86f/jOPsODEdNiD66zso1Wzpr7Qe9QFxvlIXd1yhj3krUlgh4QkYh89Fhi2+CIFcvByf+6yup3uda1RUDlIoJLSutF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb5cbe815dso11539139f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 20:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717731627; x=1718336427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A0+kn72RG0NgBZDk5mNh7EkiTRFr9f/55CydiNHQa4=;
        b=osddxkRjFQ2sC6dLDVs+RYxEJrKgrDNndauWxMISBtPd5ZkKXYhma1DpXXWj6rTElK
         ZBtTqlD+zVHqSUi5G98FNGEISS+IUdKTHnP5eGnSUA7SUIXtwwG4NGoBvDCHHTgP+JpM
         10oDZ2zil/3X7WVFlDvnZyLp2eofiyL2Yu7Mc9EVB+acl0KSov3f7suxy9Mc0kagH5ud
         VhJo37HJ+LSDaj5iGykOqb8u4VVTs7/wfqpQKWBcFardaOxIN0iFUz2AiQCxUYqXYkjs
         oL9YeE3EFH5P9QBo5leR8x73tKRjOS5sCbbSfi5eJkr1wFFTDMcxLg/yWG9shX9tkM84
         FatA==
X-Forwarded-Encrypted: i=1; AJvYcCVXCNh9L7QyVHpC2eZetNXFTm+BgisMj3cxzXLAx0ApZTfcSAYq8MNE3mfzgJ12HpkxVLPW/5KCY4pnufpIeHIBiUY/KoQqXNnVDdE=
X-Gm-Message-State: AOJu0Ywc4QRrls+RXFDxQel8ahXBc4btCe1H62+dkiXw4tOMhw0oaNGG
	tdTqz4zIhKv6zFKW0f3/5as/jLE8OfkDGf/EA60CKRrK+LY82c8oiK+lud0gIMQzOB5riSRNgZx
	5csAmIOs93X5fYhrkQcUhbuhHOyC7nwqzy2rNaCCtqjyHPpYnoTgr3wI=
X-Google-Smtp-Source: AGHT+IFEURiAsd73ZKaNCjv7mYXrXLr0nBqA1jHA5dci2Hby/ZpuEZlQAQxOYukcU459onYbAu4gwc3VlopXFFUfxNCSBLUQ+Pjv
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2053:b0:488:59cc:eb4c with SMTP id
 8926c6da1cb9f-4b7b16db4c1mr35511173.3.1717731627449; Thu, 06 Jun 2024
 20:40:27 -0700 (PDT)
Date: Thu, 06 Jun 2024 20:40:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000794dc0061a448fc0@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in ZSTD_compressBlock_doubleFast
From: syzbot <syzbot+c86c7974966b98aab23d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164aa5f2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=c86c7974966b98aab23d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c86c7974966b98aab23d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ZSTD_count lib/zstd/compress/zstd_compress_internal.h:752 [inline]
BUG: KMSAN: uninit-value in ZSTD_compressBlock_doubleFast_noDict_generic lib/zstd/compress/zstd_double_fast.c:143 [inline]
BUG: KMSAN: uninit-value in ZSTD_compressBlock_doubleFast_noDict_4 lib/zstd/compress/zstd_double_fast.c:479 [inline]
BUG: KMSAN: uninit-value in ZSTD_compressBlock_doubleFast+0xf04d/0x19160 lib/zstd/compress/zstd_double_fast.c:499
 ZSTD_count lib/zstd/compress/zstd_compress_internal.h:752 [inline]
 ZSTD_compressBlock_doubleFast_noDict_generic lib/zstd/compress/zstd_double_fast.c:143 [inline]
 ZSTD_compressBlock_doubleFast_noDict_4 lib/zstd/compress/zstd_double_fast.c:479 [inline]
 ZSTD_compressBlock_doubleFast+0xf04d/0x19160 lib/zstd/compress/zstd_double_fast.c:499
 ZSTD_buildSeqStore+0xc68/0xe00 lib/zstd/compress/zstd_compress.c:2796
 ZSTD_compressBlock_internal+0x5c/0x8c0 lib/zstd/compress/zstd_compress.c:3688
 ZSTD_compress_frameChunk lib/zstd/compress/zstd_compress.c:3887 [inline]
 ZSTD_compressContinue_internal+0x1ff3/0x5560 lib/zstd/compress/zstd_compress.c:4062
 ZSTD_compressEnd+0x69/0x960 lib/zstd/compress/zstd_compress.c:4545
 ZSTD_compressStream_generic lib/zstd/compress/zstd_compress.c:5294 [inline]
 ZSTD_compressStream2+0x1380/0x2770 lib/zstd/compress/zstd_compress.c:5501
 ZSTD_endStream+0x6e/0x270 lib/zstd/compress/zstd_compress.c:5970
 zstd_end_stream+0x36/0x50 lib/zstd/zstd_compress_module.c:159
 zstd_compress_pages+0x1381/0x1ef0 fs/btrfs/zstd.c:494
 compression_compress_pages fs/btrfs/compression.c:105 [inline]
 btrfs_compress_pages+0x34e/0x460 fs/btrfs/compression.c:1010
 compress_file_range+0xf50/0x25d0 fs/btrfs/inode.c:948
 btrfs_work_helper+0x52f/0x18d0 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ZSTD_limitCopy lib/zstd/compress/../common/zstd_internal.h:251 [inline]
 ZSTD_compressStream_generic lib/zstd/compress/zstd_compress.c:5261 [inline]
 ZSTD_compressStream2+0xd3f/0x2770 lib/zstd/compress/zstd_compress.c:5501
 ZSTD_compressStream+0x42/0x180 lib/zstd/compress/zstd_compress.c:5384
 zstd_compress_stream+0x3e/0x50 lib/zstd/zstd_compress_module.c:147
 zstd_compress_pages+0xed6/0x1ef0 fs/btrfs/zstd.c:428
 compression_compress_pages fs/btrfs/compression.c:105 [inline]
 btrfs_compress_pages+0x34e/0x460 fs/btrfs/compression.c:1010
 compress_file_range+0xf50/0x25d0 fs/btrfs/inode.c:948
 btrfs_work_helper+0x52f/0x18d0 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
 btrfs_copy_from_user+0x176/0x4c0 fs/btrfs/file.c:59
 btrfs_buffered_write+0x119a/0x2ab0 fs/btrfs/file.c:1339
 btrfs_do_write_iter+0x395/0x2270 fs/btrfs/file.c:1688
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 __kernel_write_iter+0x64d/0xc80 fs/read_write.c:523
 dump_emit_page fs/coredump.c:895 [inline]
 dump_user_range+0x8dc/0xee0 fs/coredump.c:956
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 dump_user_range+0x4a/0xee0 fs/coredump.c:940
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 3475 Comm: kworker/u8:18 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: btrfs-delalloc btrfs_work_helper
=====================================================


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

