Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE963A24A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 08:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiK1Hur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 02:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiK1Hup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 02:50:45 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5B15819
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 23:50:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so8208649ilv.16
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 23:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ivh2xXELoiAfJgRZzdEP1NE6OlZmZZPsfCq/KWACjZk=;
        b=w5gIIOO3yoQHwJeywK05+Fi5pEU2MaVmSEolfE8lV2MJDTuWPSiNSTUXpjoYTUxCo2
         BFnYAIAG2sEybIkLCedN5CM27veeU8m3HXDXIJmaHdRRSj9w5LZPrXVf1TY2f67VPJhA
         eSKqEeISX/L1vrJI1VbQGFIVhTgIz+qBkEZ146I8ohB+0wYISthXybfU4mcCi1y/Kv9v
         sb/E1qAsjeFNiKQJSiX493T30vAn0CJJx5F6aII7GGaXvTxP179bIJbkzyYLPxhYqT9G
         9ZYS7cCk39cWqfdPMFheL8D5ujxIRrWxKbx+LLU8Jy+h+JDY/j92+xJ747G78Kw9Kt1+
         wNpQ==
X-Gm-Message-State: ANoB5pksknDZoKDib1DmeuSv5e+i/nc9gxTkb25sPlR+T6+2g5LnOH4N
        JbNp3UtWdGH7ogsFRCKypIozJkgKWb9KJkIXXN12NQ90E/1A
X-Google-Smtp-Source: AA0mqf7XO1UhY7apncf+gy5RWPiK1zPHeMRgkZNshk66IA5+t7lUsHrHhJW0pnwUEdvYtm6GPOMotUdiXoR8rKagGCBThsx/FAle
MIME-Version: 1.0
X-Received: by 2002:a92:3209:0:b0:303:814:f79c with SMTP id
 z9-20020a923209000000b003030814f79cmr3345750ile.50.1669621843598; Sun, 27 Nov
 2022 23:50:43 -0800 (PST)
Date:   Sun, 27 Nov 2022 23:50:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5a65c05ee832054@google.com>
Subject: [syzbot] memory leak in add_tree_block
From:   syzbot <syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1642d68d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=522dbc1ab43c9303
dashboard link: https://syzkaller.appspot.com/bug?extid=be14ed7728594dc8bd42
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bfbac3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120cff21880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76a03ca3d4a9/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5de00a38b596/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9499f7779db5/bzImage-4312098b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/42f50e809c7e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810f8ea480 (size 64):
  comm "syz-executor193", pid 3787, jiffies 4294971495 (age 12.820s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ed790>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
    [<ffffffff820869aa>] kmalloc include/linux/slab.h:553 [inline]
    [<ffffffff820869aa>] add_tree_block+0x3a/0x210 fs/btrfs/ref-verify.c:316
    [<ffffffff82087e7c>] btrfs_build_ref_tree+0x50c/0x750 fs/btrfs/ref-verify.c:471
    [<ffffffff846b818d>] open_ctree+0x19af/0x1fcb fs/btrfs/disk-io.c:3767
    [<ffffffff846b17d6>] btrfs_fill_super fs/btrfs/super.c:1461 [inline]
    [<ffffffff846b17d6>] btrfs_mount_root.cold+0x13/0xf5 fs/btrfs/super.c:1829
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81638b61>] fc_mount fs/namespace.c:1043 [inline]
    [<ffffffff81638b61>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1073
    [<ffffffff81638bec>] vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
    [<ffffffff81f54029>] btrfs_mount+0x199/0x590 fs/btrfs/super.c:1889
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81640487>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81640487>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8164106e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8164106e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8164106e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8164106e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff8485b285>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485b285>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c91f040 (size 64):
  comm "syz-executor193", pid 3787, jiffies 4294971495 (age 12.820s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ed790>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
    [<ffffffff82086355>] kmalloc include/linux/slab.h:553 [inline]
    [<ffffffff82086355>] kzalloc include/linux/slab.h:689 [inline]
    [<ffffffff82086355>] add_block_entry+0x35/0x320 fs/btrfs/ref-verify.c:267
    [<ffffffff82086a0e>] add_tree_block+0x9e/0x210 fs/btrfs/ref-verify.c:329
    [<ffffffff82087e7c>] btrfs_build_ref_tree+0x50c/0x750 fs/btrfs/ref-verify.c:471
    [<ffffffff846b818d>] open_ctree+0x19af/0x1fcb fs/btrfs/disk-io.c:3767
    [<ffffffff846b17d6>] btrfs_fill_super fs/btrfs/super.c:1461 [inline]
    [<ffffffff846b17d6>] btrfs_mount_root.cold+0x13/0xf5 fs/btrfs/super.c:1829
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81638b61>] fc_mount fs/namespace.c:1043 [inline]
    [<ffffffff81638b61>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1073
    [<ffffffff81638bec>] vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
    [<ffffffff81f54029>] btrfs_mount+0x199/0x590 fs/btrfs/super.c:1889
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81640487>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81640487>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8164106e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8164106e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8164106e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8164106e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff8485b285>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485b285>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff88810caab580 (size 96):
  comm "syz-executor193", pid 3787, jiffies 4294971495 (age 12.820s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff814ed790>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1045
    [<ffffffff8208636e>] kmalloc include/linux/slab.h:553 [inline]
    [<ffffffff8208636e>] kzalloc include/linux/slab.h:689 [inline]
    [<ffffffff8208636e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:268
    [<ffffffff82086a0e>] add_tree_block+0x9e/0x210 fs/btrfs/ref-verify.c:329
    [<ffffffff82087e7c>] btrfs_build_ref_tree+0x50c/0x750 fs/btrfs/ref-verify.c:471
    [<ffffffff846b818d>] open_ctree+0x19af/0x1fcb fs/btrfs/disk-io.c:3767
    [<ffffffff846b17d6>] btrfs_fill_super fs/btrfs/super.c:1461 [inline]
    [<ffffffff846b17d6>] btrfs_mount_root.cold+0x13/0xf5 fs/btrfs/super.c:1829
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81638b61>] fc_mount fs/namespace.c:1043 [inline]
    [<ffffffff81638b61>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1073
    [<ffffffff81638bec>] vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
    [<ffffffff81f54029>] btrfs_mount+0x199/0x590 fs/btrfs/super.c:1889
    [<ffffffff81662b0b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815fc948>] vfs_get_tree+0x28/0x100 fs/super.c:1531
    [<ffffffff81640487>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81640487>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8164106e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8164106e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8164106e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8164106e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff8485b285>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485b285>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
