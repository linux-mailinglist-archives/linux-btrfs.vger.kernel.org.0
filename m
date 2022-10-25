Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4860D6EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiJYWSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJYWSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 18:18:45 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F8BA26C
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 15:18:44 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so9196827iob.9
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 15:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAQ9i+hjvCOennHTwmfxh9I1OJJWWhIoBpgIqYjJvaM=;
        b=kWboleJTM3XlOjtsH3PS9Z3KZeUhwnpB724VaOwEERUbl67lPi9UvpsOB/iJ7qHbJE
         Suq/Zbojt21YXSARnQFyLSh1C9cNApXb4pdgnsprUwlbsZ48BU3dIJvPzEWUmrcvMI7+
         17ibJ72P/LH55Yl1sFIqJlyyVowprG0pT+LH1YV0UAnZG1JIWbgKVejtzYW6qghk40+T
         p/T8Jd3LwjgXWnhBxQ54PeQZx01vQutKC01qvvgK5jC5/iykWNdE1wtvELlXs+6NOvSG
         oHeXUjPFC6xx9RdJ3G1Qnr2usMYAe26DHxOk7ScfoKWn15E8KbLgsugqol3eDlmwd7YL
         K98w==
X-Gm-Message-State: ACrzQf1Ex9nXOqx0bLlGX33WLBHpEkslAIagDhsCtYfAOSAj9Vp+Ytdt
        HimeDe+c3EbodM5Ang8AiKBkpBTFC/3mp899JedYtmg/ZrQT
X-Google-Smtp-Source: AMsMyM5AJoi387nPFTG2JPr4zhNsA32rsPhzw5H7L1TZpYpqI1TFA5g5tIV6Lcvy0GXB4EL+XaIrK5X9PCHNTK+JRG7FiCDK9oOv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2691:b0:363:cc6e:76b7 with SMTP id
 o17-20020a056638269100b00363cc6e76b7mr25233405jat.18.1666736323605; Tue, 25
 Oct 2022 15:18:43 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:18:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080bb5c05ebe34a4d@google.com>
Subject: [syzbot] WARNING in cow_file_range_inline
From:   syzbot <syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, sweettea-kernel@dorminy.me,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    337a0a0b63f1 Merge tag 'net-6.1-rc3-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1090e822880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=858534c396b0cdd291d2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e5a422880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16387a16880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c011f7e4e764/disk-337a0a0b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d019c4ed2ed2/vmlinux-337a0a0b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/be2f474580f9/mount_0.gz

The issue was bisected to:

commit caae78e032343df525b8d05c58b462827f10b2a3
Author: Omar Sandoval <osandov@fb.com>
Date:   Tue Mar 15 01:12:35 2022 +0000

    btrfs: move common inode creation code into btrfs_create_new_inode()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165f10ee880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=155f10ee880000
console output: https://syzkaller.appspot.com/x/log.txt?x=115f10ee880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com
Fixes: caae78e03234 ("btrfs: move common inode creation code into btrfs_create_new_inode()")

BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
BTRFS: Transaction aborted (error -12)
WARNING: CPU: 0 PID: 3604 at fs/btrfs/inode.c:454 cow_file_range_inline+0x87c/0x9a0 fs/btrfs/inode.c:454
Modules linked in:
CPU: 0 PID: 3604 Comm: syz-executor345 Not tainted 6.1.0-rc2-syzkaller-00061-g337a0a0b63f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:cow_file_range_inline+0x87c/0x9a0 fs/btrfs/inode.c:454
Code: 49 8b 3e 48 c7 c6 40 f8 da 8a 89 da 31 c0 e8 dd 97 a6 06 eb 1a e8 34 9c fc fd 48 c7 c7 40 f7 da 8a 89 de 31 c0 e8 84 3a c4 fd <0f> 0b 41 b7 01 4c 8b 64 24 08 4c 8b 2c 24 45 0f b6 c7 4c 8b 7c 24
RSP: 0018:ffffc90003d8ed00 EFLAGS: 00010246
RAX: c935d7c7edbb6300 RBX: 00000000fffffff4 RCX: ffff888077ebba80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d8ee30 R08: ffffffff816b8d3d R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: 1ffff1100e669a5e
R13: ffff88801d524001 R14: ffff88807334d2f0 R15: 00000000fffffff4
FS:  0000555555892300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003180 CR3: 000000001d484000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cow_file_range+0x391/0xfa0 fs/btrfs/inode.c:1219
 btrfs_run_delalloc_range+0xed4/0x11a0 fs/btrfs/inode.c:2229
 writepage_delalloc+0x25e/0x540 fs/btrfs/extent_io.c:1968
 __extent_writepage+0x5d6/0x14d0 fs/btrfs/extent_io.c:2272
 extent_write_cache_pages+0x9e7/0x12d0 fs/btrfs/extent_io.c:3186
 extent_writepages+0x228/0x550 fs/btrfs/extent_io.c:3308
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:4140 [inline]
 start_ordered_ops fs/btrfs/file.c:2026 [inline]
 btrfs_sync_file+0x39e/0x1140 fs/btrfs/file.c:2102
 generic_write_sync include/linux/fs.h:2883 [inline]
 btrfs_do_write_iter+0xa6f/0x1370 fs/btrfs/file.c:1975
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4612b05f79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff76769238 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4612b05f79
RDX: 0000000000000001 RSI: 0000000020003180 RDI: 0000000000000006
RBP: 00007fff76769260 R08: 0000000000000002 R09: 00007fff76769270
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 00007f4612b4e6b8 R14: 00007fff76769280 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
