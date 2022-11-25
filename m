Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D516386B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 10:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKYJtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKYJsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 04:48:15 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A33E0B3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 01:46:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id n8-20020a056e021ba800b00302c73f42d9so2585179ili.8
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oozvbbcqsuDZpplpfBZRUDeUw0G5+ggpfxV0UEudkZ0=;
        b=zqbeaLy7E6JTDjBsOC99tRz4+oEqsM0rvX4mqJzFiS+bsa5kuJ/apuLV79kwz4WC+U
         plq6oDZ0VT6fqkT2eSk8aBmQTvD0wqWq+pRG0LdgYWtSBrC/jEjsr+HB0ITQRchRoBbR
         dN5Cg+mR9lIfcNQ9aXmWSbFoqUGEFYk+3l/A95XO3wXf5WZI1YTbMICKMDsnBq3HHzKt
         PJCC+DkEZ+TSn2UAnc4y07PDoTxW4IgFb5NbiICGgdb+xa4+aMjv4j3mQ+xPeFfLFoNX
         CqMFhDxvgETMBzUxjgbFv7vQyRADsw9QdpHbsCaj/wVALPuc4xUBHRmlVP5GrU+56Dup
         6kvA==
X-Gm-Message-State: ANoB5plhyjtxLWaI67XIoiZEBBbKOrQOaKFzDo0vyzqSnwHrgiG4gvQP
        8COd+yytdQFdGb/1r6g09HER6aTviwShtb3S+80nFo9FGAmB
X-Google-Smtp-Source: AA0mqf760M2FH+IKvxtpfffiXOSmIkKYUlrU0oQJiRnU82CwPkt981LOBti1h6yQtBMVfenn0kEGdKgkYxJehdOHtxiBVL2+ILS1
MIME-Version: 1.0
X-Received: by 2002:a6b:7511:0:b0:6d6:8005:8527 with SMTP id
 l17-20020a6b7511000000b006d680058527mr9716524ioh.166.1669369594234; Fri, 25
 Nov 2022 01:46:34 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:46:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9ccd705ee4865be@google.com>
Subject: [syzbot] kernel BUG in clear_state_bit
From:   syzbot <syzbot+78dbea1c214b5413bdd3@syzkaller.appspotmail.com>
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

HEAD commit:    c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1280f3ed880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d9403880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a0d8e3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f47b682262bc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78dbea1c214b5413bdd3@syzkaller.appspotmail.com

BTRFS: device fsid d552757d-9c39-40e3-95f0-16d819589928 devid 1 transid 8 /dev/loop0 scanned by syz-executor247 (3626)
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:517!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3626 Comm: syz-executor247 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:clear_state_bit+0x325/0x330 fs/btrfs/extent-io-tree.c:517
Code: 2f fe e9 9c fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c c7 fe ff ff 4c 89 ef e8 a5 0f 2f fe e9 ba fe ff ff e8 bb f7 da fd <0f> 0b 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90003cae8d0 EFLAGS: 00010293
RAX: ffffffff83afa0b5 RBX: 00000000fffffff4 RCX: ffff888022add7c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83af9ee2 R09: 00000000ffffffff
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: ffff88807f27c540
R13: ffffc90003caead8 R14: 0000000000001000 R15: dffffc0000000000
FS:  0000555555ca1300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000023ed5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __clear_extent_bit+0x669/0xc60 fs/btrfs/extent-io-tree.c:674
 clear_record_extent_bits+0x4e/0x80 fs/btrfs/extent-io-tree.c:1614
 __btrfs_qgroup_release_data+0x4b9/0x850 fs/btrfs/qgroup.c:3870
 btrfs_add_ordered_extent+0xdf/0xbe0 fs/btrfs/ordered-data.c:188
 cow_file_range+0x73a/0xfa0 fs/btrfs/inode.c:1299
 btrfs_run_delalloc_range+0xed4/0x11a0 fs/btrfs/inode.c:2229
 writepage_delalloc+0x25e/0x540 fs/btrfs/extent_io.c:1968
 __extent_writepage+0x5d6/0x14d0 fs/btrfs/extent_io.c:2272
 extent_write_cache_pages+0x9e7/0x12d0 fs/btrfs/extent_io.c:3186
 extent_writepages+0x228/0x550 fs/btrfs/extent_io.c:3308
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range+0x4b/0x110 fs/btrfs/file.c:4155
 btrfs_wait_ordered_range+0x65/0x270 fs/btrfs/ordered-data.c:774
 btrfs_punch_hole fs/btrfs/file.c:2913 [inline]
 btrfs_fallocate+0x421/0x2020 fs/btrfs/file.c:3367
 vfs_fallocate+0x515/0x670 fs/open.c:323
 do_vfs_ioctl+0x2187/0x29a0 fs/ioctl.c:849
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2e2246aac9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd222883d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2e2246aac9
RDX: 0000000020000100 RSI: 0000000040305829 RDI: 0000000000000005
RBP: 0000000000000006 R08: 0000000000000001 R09: 00007ffd00000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd22288460
R13: 00007f2e224ed780 R14: 0000000000000003 R15: 00007ffd2228842a
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_state_bit+0x325/0x330 fs/btrfs/extent-io-tree.c:517
Code: 2f fe e9 9c fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c c7 fe ff ff 4c 89 ef e8 a5 0f 2f fe e9 ba fe ff ff e8 bb f7 da fd <0f> 0b 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90003cae8d0 EFLAGS: 00010293
RAX: ffffffff83afa0b5 RBX: 00000000fffffff4 RCX: ffff888022add7c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83af9ee2 R09: 00000000ffffffff
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: ffff88807f27c540
R13: ffffc90003caead8 R14: 0000000000001000 R15: dffffc0000000000
FS:  0000555555ca1300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000023ed5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
