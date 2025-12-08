Return-Path: <linux-btrfs+bounces-19559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B2CAC94A
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 10:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84893053B08
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E3302CD1;
	Mon,  8 Dec 2025 08:58:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70422DF3C6
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184308; cv=none; b=iyQjB1A6DUBXyn3D6B5X6J0uJNXF/58W3XAsVfMarciJonsbjQYaEn37ZIzYVJvkN2LmByXrFEQ9nUutfR0Cxw2UG7p5VLVPKdCxW99GVj2VnBilyulFSRFeTjTIJh0cosDy+7CLs9Tr375Zogn20l5numEADyohkAw+Ll62li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184308; c=relaxed/simple;
	bh=ATjvpf7jUAVzO/oOYrwiMFRM7ayKp32F+uHYaxEWxU0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oImlz2FopcxC0skV6/cOymAV9ksV1JWIh7IxoVeRHPe5Vw2wOY1r6ldfPSPWhr2/jTqOrspz4/ufcr4OEm+RkcvLmqKbQKqEWRm6BXjzfJs9r/ZYZn6aFQWxz4EY7kUURfz9l2ZsNDffgYDssrhUAPqiAbOPLNHFBJGIZ3zKDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656ceb0c967so3246857eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184306; x=1765789106;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQLWj5zA4DDv4iuoBe0cJ9Qj8oaIxbYZFNax7zcjO1I=;
        b=YHixLr0+pznj/VYVYGQEEM+T27qvgpFEu6vU4MOFv+vuYKu38CSxMB8IImwTR/6icx
         tK17CUTvPnPNlk83dTlJKZUHAiY2s0wMTQeuL7yk1LT2/sAAe148k/g2OQ2OG7y/FIiq
         isNh3YYqbj8QUe0fOVA9U7w6ukl6tgakxrH0pq0XEr4nNDpThdEW4WC0h9SZdSe81x6o
         RoI76wNSZ9HpO3gNYxcWOxY8/nRKdgcPHIvqqRl9oWVqvjdv2yFegv3eQMfBcdGR/zT/
         6PYiovAigcUxi4N7Nc4/w05YGMJe6YSzMltpHDscd1duIbsHBpZ7efjdp/SlCh72rjSI
         XXPw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpNWODbO8e4GWAlECQrQHg09N4uhm6jn90iq6d9jWQSO6Hk3CzfS/TpDBwdho8qP6yAxmimSObFIPGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSecQUpPoe1scH4G/yu00U72/8jOkCDSRhekmGXfMBmNUh6zDb
	1IyXcHGTqo1tqKdFI8572DBzFlkT8P1Ok+m7VBhdcgzmFAt8DFityVqRkmeOf9AKUt0dB0Z9o9V
	yRpY8K7TwYKue19ojq3xAqnxMSLcPuXEFzX4gPMb1Y58ePm0eX0TK2UY/aCM=
X-Google-Smtp-Source: AGHT+IFAtYM9zapBxePcpXL6z5asLNkweFQWuapp48qwJMkbD0FWAT/huI4oZz6JD4aaVLdXZEAQgouExVF5etsOOOh0v9cOgfEo
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee98:0:b0:659:9a49:8dda with SMTP id
 006d021491bc7-6599a8e963emr2884687eaf.28.1765184305926; Mon, 08 Dec 2025
 00:58:25 -0800 (PST)
Date: Mon, 08 Dec 2025 00:58:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69369331.a70a0220.38f243.009e.GAE@google.com>
Subject: [syzbot] [btrfs?] memory leak in btrfs_read_chunk_tree
From: syzbot <syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1412c01a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bdbe6509b080086
dashboard link: https://syzkaller.appspot.com/bug?extid=eadd98df8bceb15d7fed
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cbd192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1676eab4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75704c8ef83a/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc039c7b45ea/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80c77928126a/bzImage-8f7aa3d3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4340667fac60/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1771dcc2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881092fce00 (size 512):
  comm "syz.0.17", pid 6092, jiffies 4294942574
  hex dump (first 32 bytes):
    00 fe 44 da de 57 40 6a 82 41 57 ec 7d 44 12 cf  ..D..W@j.AW.}D..
    00 fe 44 da de 57 40 6a 82 41 57 ec 7d 44 12 cf  ..D..W@j.AW.}D..
  backtrace (crc d3ac311e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3a6/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    alloc_fs_devices+0x20/0xc0 fs/btrfs/volumes.c:381
    open_seed_devices fs/btrfs/volumes.c:7172 [inline]
    read_one_dev fs/btrfs/volumes.c:7228 [inline]
    btrfs_read_chunk_tree+0xa8f/0xcf0 fs/btrfs/volumes.c:7521
    open_ctree+0xe0a/0x2410 fs/btrfs/disk-io.c:3459
    btrfs_fill_super fs/btrfs/super.c:987 [inline]
    btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
    btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
    btrfs_get_tree+0x735/0xe00 fs/btrfs/super.c:2128
    vfs_get_tree+0x31/0x120 fs/super.c:1759
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5b5/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881251dfc00 (size 1024):
  comm "syz.0.17", pid 6092, jiffies 4294942574
  hex dump (first 32 bytes):
    90 ce 2f 09 81 88 ff ff 90 ce 2f 09 81 88 ff ff  ../......./.....
    10 fc 1d 25 81 88 ff ff 10 fc 1d 25 81 88 ff ff  ...%.......%....
  backtrace (crc 3c4c04f1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3a6/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    btrfs_alloc_device+0x5c/0x1f0 fs/btrfs/volumes.c:6907
    add_missing_dev+0x4b/0xf0 fs/btrfs/volumes.c:6867
    read_one_dev fs/btrfs/volumes.c:7241 [inline]
    btrfs_read_chunk_tree+0x7cf/0xcf0 fs/btrfs/volumes.c:7521
    open_ctree+0xe0a/0x2410 fs/btrfs/disk-io.c:3459
    btrfs_fill_super fs/btrfs/super.c:987 [inline]
    btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
    btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
    btrfs_get_tree+0x735/0xe00 fs/btrfs/super.c:2128
    vfs_get_tree+0x31/0x120 fs/super.c:1759
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5b5/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888126e4a400 (size 512):
  comm "syz.0.18", pid 6135, jiffies 4294942600
  hex dump (first 32 bytes):
    00 fe 44 da de 57 40 6a 82 41 57 ec 7d 44 12 cf  ..D..W@j.AW.}D..
    00 fe 44 da de 57 40 6a 82 41 57 ec 7d 44 12 cf  ..D..W@j.AW.}D..
  backtrace (crc 8b73c9ef):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3a6/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    alloc_fs_devices+0x20/0xc0 fs/btrfs/volumes.c:381
    open_seed_devices fs/btrfs/volumes.c:7172 [inline]
    read_one_dev fs/btrfs/volumes.c:7228 [inline]
    btrfs_read_chunk_tree+0xa8f/0xcf0 fs/btrfs/volumes.c:7521
    open_ctree+0xe0a/0x2410 fs/btrfs/disk-io.c:3459
    btrfs_fill_super fs/btrfs/super.c:987 [inline]
    btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
    btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
    btrfs_get_tree+0x735/0xe00 fs/btrfs/super.c:2128
    vfs_get_tree+0x31/0x120 fs/super.c:1759
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5b5/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810ea93000 (size 1024):
  comm "syz.0.18", pid 6135, jiffies 4294942600
  hex dump (first 32 bytes):
    90 a4 e4 26 81 88 ff ff 90 a4 e4 26 81 88 ff ff  ...&.......&....
    10 30 a9 0e 81 88 ff ff 10 30 a9 0e 81 88 ff ff  .0.......0......
  backtrace (crc 2183446):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3a6/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    btrfs_alloc_device+0x5c/0x1f0 fs/btrfs/volumes.c:6907
    add_missing_dev+0x4b/0xf0 fs/btrfs/volumes.c:6867
    read_one_dev fs/btrfs/volumes.c:7241 [inline]
    btrfs_read_chunk_tree+0x7cf/0xcf0 fs/btrfs/volumes.c:7521
    open_ctree+0xe0a/0x2410 fs/btrfs/disk-io.c:3459
    btrfs_fill_super fs/btrfs/super.c:987 [inline]
    btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
    btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
    btrfs_get_tree+0x735/0xe00 fs/btrfs/super.c:2128
    vfs_get_tree+0x31/0x120 fs/super.c:1759
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5b5/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

