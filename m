Return-Path: <linux-btrfs+bounces-19639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3308CB4DDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3011F3010CE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D5286418;
	Thu, 11 Dec 2025 06:23:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16122D785
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434204; cv=none; b=MZLB1CPu0IjWVBI3ulMEjBX5j79+eAON6a0mSOpGmg/9v1eJbJggt5m0ZyEovDI5Elzug3+dpbK/BmbaKqsmfMth2a4qpVEHYxt1Lll+vIsCNBrrezZGyPX9KB14+48GhLr9H1mlkR1H/2rSy3FfJVIx7zw4VTtXTEacQCBB1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434204; c=relaxed/simple;
	bh=8+KVcNiJN5JFRlir9aikWtOUKNeAelbQU6uUFJ14MKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HjTMPpYuQB3tMZBrc+8+3lddt47DsRUFlApns6DU98xUwy/RoNbniQQgDu/WVQ3oztZKLi1BsCE5Ey14D2ZD6jZjUSy+kdYqVre2ztG00hfFcxoMnpa5dJVobTUQA27EeGMIDeY5sa41tHWGXLSV+TL3S+EVxk2tstVpPORRse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65b2fb9d54bso997261eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 22:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765434202; x=1766039002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDYt87XHF/+m9DDrKKMEeZN6IhYeBSH3J+MEDa6S870=;
        b=caHcratZ4govZCWwsANcUPLD2Iz9TurL04qfO2XCfXOR4ufl3hHl/HBqDLoQhpVr9O
         3fNOMrds4tqIesOWQ7UVrcQu7b7mTGfvYBtcyK9qwEO0HoaCrX1oEQhXDdOW0oj6UgLq
         SXJWFfIyBbwuETx7kQfMAoQAF2BZ81mA/1THurd2NJh/IIxJ3Tpd1A3dBF7Qt4yJ7JWd
         85+FcI0sZ4QRvyEtYpm0H5BRVA8+gBZ0rWZ9Tg3lKBU1QwRS1fJjS1GKJM6ewRxaC4+Y
         IoavqwRNc7+JqCoZqQy5kDqUoLIqJMjUjyUbc16RwgQww4/a8GpUtrZCMBkXkd/OMcdH
         16gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+HYZo39RWiChkRuz788dDDZswfySuC1EEAlNESSd2v6fVLE3hfXL9nJmunAMK7+DX47mNYLbwX9ysOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyOfkCcnBkNHHRbP/jx0c7fFPDAvGwuvfelj3NEzpRNY8EM+o
	oCWkaS1jYo6nGJ4phvEUovsHhqu4lMuxLbTo1hV9Z9meD3Y+Rr+Uigiuup/KytQTScpMTF9J+IB
	VQYHak3OsGiVv+/2Gzgp2KQo02bBt7KJpCWCrTGVrnyZvPg5WmEQvOioUvVc=
X-Google-Smtp-Source: AGHT+IGxMBJUvZAuzmWjJmInuhi0bv8bDVNIST0Ak1oSHsiVDxG376bpBLFm8vMBtPEHbNcdoFQwkHzElGtMLVzMdhDhIHUEDwm9
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e0d3:0:b0:659:9a49:8e2b with SMTP id
 006d021491bc7-65b37f71c6bmr585207eaf.29.1765434202311; Wed, 10 Dec 2025
 22:23:22 -0800 (PST)
Date: Wed, 10 Dec 2025 22:23:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a635a.a70a0220.33cd7b.0029.GAE@google.com>
Subject: [syzbot] [btrfs?] memory leak in qgroup_reserve_data
From: syzbot <syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba65a4e7120a Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149a1992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69400c231dedfdcf
dashboard link: https://syzkaller.appspot.com/bug?extid=2f8aa76e6acc9fce6638
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17674ec2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129a1992580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35dd946c3f76/disk-ba65a4e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4279760dbda5/vmlinux-ba65a4e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66920d2c9825/bzImage-ba65a4e7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a1009b9f463a/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=15666eb4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888108c93440 (size 64):
  comm "syz.0.25", pid 6287, jiffies 4294945820
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    50 36 c9 08 81 88 ff ff 50 36 c9 08 81 88 ff ff  P6......P6......
  backtrace (crc 5115bfd6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    extent_changeset_alloc fs/btrfs/extent_io.h:203 [inline]
    qgroup_reserve_data+0x42c/0x4d0 fs/btrfs/qgroup.c:4199
    btrfs_qgroup_reserve_data+0x9a/0xb0 fs/btrfs/qgroup.c:4257
    btrfs_check_data_free_space+0x101/0x200 fs/btrfs/delalloc-space.c:164
    btrfs_page_mkwrite+0x180/0xd30 fs/btrfs/file.c:1888
    do_page_mkwrite+0x6c/0x100 mm/memory.c:3528
    wp_page_shared mm/memory.c:3929 [inline]
    do_wp_page+0x4fe/0x1d50 mm/memory.c:4148
    handle_pte_fault mm/memory.c:6289 [inline]
    __handle_mm_fault+0x125f/0x1e50 mm/memory.c:6411
    handle_mm_fault+0x31c/0x630 mm/memory.c:6580
    do_user_addr_fault+0x34f/0xba0 arch/x86/mm/fault.c:1336
    handle_page_fault arch/x86/mm/fault.c:1476 [inline]
    exc_page_fault+0x64/0xb0 arch/x86/mm/fault.c:1532
    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

BUG: memory leak
unreferenced object 0xffff888108c93640 (size 64):
  comm "syz.0.25", pid 6287, jiffies 4294945820
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff 0f 00 00 00 00 00 00  ................
    50 34 c9 08 81 88 ff ff 50 34 c9 08 81 88 ff ff  P4......P4......
  backtrace (crc d90ae07a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ulist_prealloc+0x7a/0xd0 fs/btrfs/ulist.c:114
    extent_changeset_prealloc fs/btrfs/extent_io.h:213 [inline]
    set_extent_bit+0x104/0xc40 fs/btrfs/extent-io-tree.c:1083
    btrfs_set_record_extent_bits+0x56/0xa0 fs/btrfs/extent-io-tree.c:1868
    qgroup_reserve_data+0x116/0x4d0 fs/btrfs/qgroup.c:4206
    btrfs_qgroup_reserve_data+0x9a/0xb0 fs/btrfs/qgroup.c:4257
    btrfs_check_data_free_space+0x101/0x200 fs/btrfs/delalloc-space.c:164
    btrfs_page_mkwrite+0x180/0xd30 fs/btrfs/file.c:1888
    do_page_mkwrite+0x6c/0x100 mm/memory.c:3528
    wp_page_shared mm/memory.c:3929 [inline]
    do_wp_page+0x4fe/0x1d50 mm/memory.c:4148
    handle_pte_fault mm/memory.c:6289 [inline]
    __handle_mm_fault+0x125f/0x1e50 mm/memory.c:6411
    handle_mm_fault+0x31c/0x630 mm/memory.c:6580
    do_user_addr_fault+0x34f/0xba0 arch/x86/mm/fault.c:1336
    handle_page_fault arch/x86/mm/fault.c:1476 [inline]
    exc_page_fault+0x64/0xb0 arch/x86/mm/fault.c:1532
    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

BUG: memory leak
unreferenced object 0xffff8881294d0cc0 (size 64):
  comm "syz.0.25", pid 6288, jiffies 4294945820
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    d0 03 4d 29 81 88 ff ff d0 03 4d 29 81 88 ff ff  ..M)......M)....
  backtrace (crc 99a57742):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    extent_changeset_alloc fs/btrfs/extent_io.h:203 [inline]
    qgroup_reserve_data+0x42c/0x4d0 fs/btrfs/qgroup.c:4199
    btrfs_qgroup_reserve_data+0x9a/0xb0 fs/btrfs/qgroup.c:4257
    btrfs_check_data_free_space+0x101/0x200 fs/btrfs/delalloc-space.c:164
    btrfs_page_mkwrite+0x180/0xd30 fs/btrfs/file.c:1888
    do_page_mkwrite+0x6c/0x100 mm/memory.c:3528
    wp_page_shared mm/memory.c:3929 [inline]
    do_wp_page+0x4fe/0x1d50 mm/memory.c:4148
    handle_pte_fault mm/memory.c:6289 [inline]
    __handle_mm_fault+0x125f/0x1e50 mm/memory.c:6411
    handle_mm_fault+0x31c/0x630 mm/memory.c:6580
    do_user_addr_fault+0x239/0xba0 arch/x86/mm/fault.c:1387
    handle_page_fault arch/x86/mm/fault.c:1476 [inline]
    exc_page_fault+0x64/0xb0 arch/x86/mm/fault.c:1532
    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

BUG: memory leak
unreferenced object 0xffff8881294d03c0 (size 64):
  comm "syz.0.25", pid 6288, jiffies 4294945820
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff 0f 00 00 00 00 00 00  ................
    d0 0c 4d 29 81 88 ff ff d0 0c 4d 29 81 88 ff ff  ..M)......M)....
  backtrace (crc edd2342):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ulist_prealloc+0x7a/0xd0 fs/btrfs/ulist.c:114
    extent_changeset_prealloc fs/btrfs/extent_io.h:213 [inline]
    set_extent_bit+0x104/0xc40 fs/btrfs/extent-io-tree.c:1083
    btrfs_set_record_extent_bits+0x56/0xa0 fs/btrfs/extent-io-tree.c:1868
    qgroup_reserve_data+0x116/0x4d0 fs/btrfs/qgroup.c:4206
    btrfs_qgroup_reserve_data+0x9a/0xb0 fs/btrfs/qgroup.c:4257
    btrfs_check_data_free_space+0x101/0x200 fs/btrfs/delalloc-space.c:164
    btrfs_page_mkwrite+0x180/0xd30 fs/btrfs/file.c:1888
    do_page_mkwrite+0x6c/0x100 mm/memory.c:3528
    wp_page_shared mm/memory.c:3929 [inline]
    do_wp_page+0x4fe/0x1d50 mm/memory.c:4148
    handle_pte_fault mm/memory.c:6289 [inline]
    __handle_mm_fault+0x125f/0x1e50 mm/memory.c:6411
    handle_mm_fault+0x31c/0x630 mm/memory.c:6580
    do_user_addr_fault+0x239/0xba0 arch/x86/mm/fault.c:1387
    handle_page_fault arch/x86/mm/fault.c:1476 [inline]
    exc_page_fault+0x64/0xb0 arch/x86/mm/fault.c:1532
    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

BUG: memory leak
unreferenced object 0xffff888108c93600 (size 64):
  comm "syz.0.25", pid 6287, jiffies 4294945820
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 36 c9 08 81 88 ff ff 10 36 c9 08 81 88 ff ff  .6.......6......
  backtrace (crc cafc2d90):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    extent_changeset_alloc fs/btrfs/extent_io.h:203 [inline]
    qgroup_reserve_data+0x42c/0x4d0 fs/btrfs/qgroup.c:4199
    btrfs_qgroup_reserve_data+0x2e/0xb0 fs/btrfs/qgroup.c:4250
    btrfs_check_data_free_space+0x101/0x200 fs/btrfs/delalloc-space.c:164
    btrfs_page_mkwrite+0x180/0xd30 fs/btrfs/file.c:1888
    do_page_mkwrite+0x6c/0x100 mm/memory.c:3528
    wp_page_shared mm/memory.c:3929 [inline]
    do_wp_page+0x4fe/0x1d50 mm/memory.c:4148
    handle_pte_fault mm/memory.c:6289 [inline]
    __handle_mm_fault+0x125f/0x1e50 mm/memory.c:6411
    handle_mm_fault+0x31c/0x630 mm/memory.c:6580
    do_user_addr_fault+0x34f/0xba0 arch/x86/mm/fault.c:1336
    handle_page_fault arch/x86/mm/fault.c:1476 [inline]
    exc_page_fault+0x64/0xb0 arch/x86/mm/fault.c:1532
    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

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

