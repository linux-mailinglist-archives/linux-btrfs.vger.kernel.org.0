Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD59638B56
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKYNgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 08:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYNgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 08:36:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86B275D6
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 05:36:40 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso2896011ili.21
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 05:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rg7zvfJJUkX6xAT/F8BXtC/IVqqsd55S66taMC514rE=;
        b=O0p0AEIKiklcEwKK/zJZ+L6Nb7PcrS1VkKFcYqQNZmrFcDUIfW/xKGKe78YK0o2GAy
         P4HYYybob1lekDCjSmzi+yvOwfvLcxChzNUpd6mQLPGE52LaoLMJU2glqrANJ8I/416j
         dF72XQugUvukONOAzg507/SAqivaYYtCFsfdoIhmCTDA2JyW4zM+0kN6aJDD//wszoI/
         jKt27qVj7IC1w9/ryslm3uVh5dZK9pxpCx/5xBAOdbZDz/oqNFjUxBl0byfP0diQyt9m
         jf9gJje30lvmU3meW2EU6u8LH2KrENvknHs8g91jeJkSHri9GIQoDiPHxU4c1GrUG5hC
         C1wA==
X-Gm-Message-State: ANoB5pmVdtBLfor5xiYBGEc+XVNZKoZYpaSMaLsr03m3YL2FPSWvWUrR
        hi2XnA1Ya1rSUVb7Ad34aEsT2A7GKZzrry4Wi0//fJLyAXiZ
X-Google-Smtp-Source: AA0mqf6LtL7u7NfaAYY63kFvybp1q1L4JFqnw2SzK8R18S9lIl7PApzpNu8xgR5CkX5JIhZrE5O8OK8hLu72QPrOyCc2My963rb4
MIME-Version: 1.0
X-Received: by 2002:a92:b70a:0:b0:302:e38e:7620 with SMTP id
 k10-20020a92b70a000000b00302e38e7620mr5102987ili.63.1669383399763; Fri, 25
 Nov 2022 05:36:39 -0800 (PST)
Date:   Fri, 25 Nov 2022 05:36:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089773e05ee4b9cb4@google.com>
Subject: [syzbot] kernel BUG in btrfs_drop_extents
From:   syzbot <syzbot+0b1fb6b0108c27419f9f@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15f07a05880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1fb6b0108c27419f9f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171a3f2d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17338b55880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/272c7f0998ac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b1fb6b0108c27419f9f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/file.c:786!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3625 Comm: syz-executor242 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_drop_extents+0x3527/0x3550 fs/btrfs/file.c:786
Code: 00 48 8b 7c 24 48 e8 e8 9c 52 fe e9 85 fb ff ff e8 2e 84 fe fd 0f 0b e8 27 84 fe fd 0f 0b e8 20 84 fe fd 0f 0b e8 19 84 fe fd <0f> 0b e8 12 84 fe fd 0f 0b e8 0b 84 fe fd 0f 0b e8 04 84 fe fd 0f
RSP: 0018:ffffc90003afe000 EFLAGS: 00010293
RAX: ffffffff838c1457 RBX: 00000000fffffff4 RCX: ffff888077a657c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc90003afe390 R08: ffffffff838bfeb7 R09: ffffffff8381b3b2
R10: 0000000000000002 R11: ffff888077a657c0 R12: dffffc0000000000
R13: ffff888077829360 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555556f703c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f199b878250 CR3: 0000000021698000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cow_file_range_inline+0x41b/0x920 fs/btrfs/inode.c:434
 cow_file_range+0x391/0xfa0 fs/btrfs/inode.c:1219
 fallback_to_cow+0x47a/0x530 fs/btrfs/inode.c:1754
 run_delalloc_nocow+0x1249/0x14a0 fs/btrfs/inode.c:2161
 btrfs_run_delalloc_range+0x380/0x11a0 fs/btrfs/inode.c:2221
 writepage_delalloc+0x25e/0x540 fs/btrfs/extent_io.c:1968
 __extent_writepage+0x5d6/0x14d0 fs/btrfs/extent_io.c:2272
 extent_write_cache_pages+0x9e7/0x12d0 fs/btrfs/extent_io.c:3186
 extent_writepages+0x228/0x550 fs/btrfs/extent_io.c:3308
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:4155 [inline]
 start_ordered_ops fs/btrfs/file.c:2041 [inline]
 btrfs_sync_file+0x39e/0x1140 fs/btrfs/file.c:2117
 generic_write_sync include/linux/fs.h:2883 [inline]
 btrfs_do_write_iter+0xcf2/0x1260 fs/btrfs/file.c:1990
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd4bb0747e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1c3b5eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4bb0747e9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000005
RBP: 00007ffd1c3b5f00 R08: 0000000000000002 R09: aaaaaaaaaaaa0102
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000007
R13: 00007fd4bb0ee7bc R14: 0000000000000003 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_drop_extents+0x3527/0x3550 fs/btrfs/file.c:786
Code: 00 48 8b 7c 24 48 e8 e8 9c 52 fe e9 85 fb ff ff e8 2e 84 fe fd 0f 0b e8 27 84 fe fd 0f 0b e8 20 84 fe fd 0f 0b e8 19 84 fe fd <0f> 0b e8 12 84 fe fd 0f 0b e8 0b 84 fe fd 0f 0b e8 04 84 fe fd 0f
RSP: 0018:ffffc90003afe000 EFLAGS: 00010293
RAX: ffffffff838c1457 RBX: 00000000fffffff4 RCX: ffff888077a657c0
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc90003afe390 R08: ffffffff838bfeb7 R09: ffffffff8381b3b2
R10: 0000000000000002 R11: ffff888077a657c0 R12: dffffc0000000000
R13: ffff888077829360 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555556f703c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f4cf139900 CR3: 0000000021698000 CR4: 00000000003506f0
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
