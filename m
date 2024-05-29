Return-Path: <linux-btrfs+bounces-5350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6D8D35AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583391C236BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAE180A67;
	Wed, 29 May 2024 11:37:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217381802D6
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982642; cv=none; b=f3aI78nIf1k7UJLHsue1pTZP1SDVcWEvMZwB8OVaRvU/N/MCYuNzWxVJnTHP3lvrAuXpfmvwSSKZMy7wLBvzuxTkBU42o3GkFfJvLosF0KAPZXaA0ZLHFo7z90GLDaYIfgfPKzTTSr7Z7FU0WQKGuwcjO2B/xq50/SaffEgeOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982642; c=relaxed/simple;
	bh=oAG1h0r+hnSIGhHxm+D/VLfwSXAZLi5hh6ALXv7pu/Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qGZ/2a/acUlG7AAiyxyAPoYYAGzbcRLsq6E11eKWlGMuu9vUqgu5UdNWTYkEldR/7zd/ByUBnqr7zRxKP1Gigg3SMoogt94UhwbaU+XFURTZ2u9Xq+3Z32qDwc1P7FxbKMKPhwOo19i1HWK+c1bBc6ZXpoz4GatDNNu0XulLBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e92491e750so80286939f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982640; x=1717587440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guInrQclf5fwu1l7pfAp9j5yGk+WubFjiJRZ6ShZ0ww=;
        b=qNopnidxuFz74yW5Ye4PxkDZFisXc+QCiYnxQjfr+j2eUFYAaRKtrCNeA47VlOFaQ6
         QNmpJqwPZ/z3mGBe/eSL/ycVy4+dy22Be9ANbR2O/nkmklyA2Zo6teu6ztg+em6W/ZIM
         b78pj1hjlXX0KsfvC7nWswAOPgdiE7wAxDJnsiXXgNDQamhJXnE/7pvCNByC6QPAEXGM
         qukqwE203BzEodidz/XuA2xRPr8WG6tBYof5ZbjfHlq3GyKscbRJJangj04cCJSJX7cs
         aTFdEt03QqNS0bGDnPPfdAycJT6ND9m+LT2NDgHv/vItV++Ja6vpCQhRzFJ1yRsAdx8g
         sjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx9RVC6bGqqCIN47vC+DhtikaRjbo5rWgFijeg4BVpmaDxNBfDvYK8INKEmAm0wDdo0KTaXP6qmnCIwYktd0BZJx+hkOAfnCCPgI8=
X-Gm-Message-State: AOJu0YzuVrc8p/EZw8oUSR6sLyJOXrb5K077tgO1G0BaTKBGH+cYfQLy
	sFAL5lpVKPsy9WQNEDSoUAyu9s/CvR80eriCYAoz/CT+44RgZUUd3kjn/IZjMbIKovDiYkzJstj
	aoIKCFJUtgWdQAxqs7hdpg3WH9d8kxZyNyqll7labM9+ln+MMstgqpeE=
X-Google-Smtp-Source: AGHT+IE6cbWOqYPtOGW353usc29WtMxEid9kOPAacp74u7Zl3dHWClyaCxJW0IjKFfqr+2fmDSW9KzL+jyf20Bhex7ZRzqBGoqi/
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:808c:b0:4af:ed6c:d8d7 with SMTP id
 8926c6da1cb9f-4b11cd84d43mr33605173.0.1716982640304; Wed, 29 May 2024
 04:37:20 -0700 (PDT)
Date: Wed, 29 May 2024 04:37:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c792d0619962ca1@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in btrfs_compress_heuristic
From: syzbot <syzbot+ca895d3f00092ebf1408@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14573014980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=ca895d3f00092ebf1408
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca895d3f00092ebf1408@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in btrfs_compress_heuristic+0xb34/0x31f0 fs/btrfs/compression.c:1507
 btrfs_compress_heuristic+0xb34/0x31f0 fs/btrfs/compression.c:1507
 inode_need_compress fs/btrfs/inode.c:812 [inline]
 btrfs_run_delalloc_range+0x158f/0x16e0 fs/btrfs/inode.c:2281
 writepage_delalloc+0x244/0x6b0 fs/btrfs/extent_io.c:1213
 __extent_writepage fs/btrfs/extent_io.c:1465 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2142 [inline]
 extent_writepages+0x1c01/0x3850 fs/btrfs/extent_io.c:2264
 btrfs_writepages+0x35/0x40 fs/btrfs/inode.c:7929
 do_writepages+0x427/0xc30 mm/page-writeback.c:2613
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 start_delalloc_inodes+0xb02/0x17c0 fs/btrfs/inode.c:9404
 btrfs_start_delalloc_roots+0x89e/0x1030 fs/btrfs/inode.c:9481
 shrink_delalloc fs/btrfs/space-info.c:648 [inline]
 flush_space+0xbd6/0x16d0 fs/btrfs/space-info.c:758
 btrfs_async_reclaim_metadata_space+0x76d/0x9c0 fs/btrfs/space-info.c:1088
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 heuristic_collect_sample fs/btrfs/compression.c:1461 [inline]
 btrfs_compress_heuristic+0x303/0x31f0 fs/btrfs/compression.c:1496
 inode_need_compress fs/btrfs/inode.c:812 [inline]
 btrfs_run_delalloc_range+0x158f/0x16e0 fs/btrfs/inode.c:2281
 writepage_delalloc+0x244/0x6b0 fs/btrfs/extent_io.c:1213
 __extent_writepage fs/btrfs/extent_io.c:1465 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2142 [inline]
 extent_writepages+0x1c01/0x3850 fs/btrfs/extent_io.c:2264
 btrfs_writepages+0x35/0x40 fs/btrfs/inode.c:7929
 do_writepages+0x427/0xc30 mm/page-writeback.c:2613
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 start_delalloc_inodes+0xb02/0x17c0 fs/btrfs/inode.c:9404
 btrfs_start_delalloc_roots+0x89e/0x1030 fs/btrfs/inode.c:9481
 shrink_delalloc fs/btrfs/space-info.c:648 [inline]
 flush_space+0xbd6/0x16d0 fs/btrfs/space-info.c:758
 btrfs_async_reclaim_metadata_space+0x76d/0x9c0 fs/btrfs/space-info.c:1088
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

CPU: 1 PID: 3751 Comm: kworker/u8:28 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
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

