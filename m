Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73E61E39A
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKFRCr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 12:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKFRCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 12:02:46 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BBDEF4
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 09:02:45 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso5829175iox.12
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 09:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXAvBCK3qUMjvp1QQV3w5/xdfkVFyvaUkRN/wZXG8d0=;
        b=4n/T49+G0/+Q+FnnRj5gr2hUWECaomFgyX78a56w4y0OIyDKnflQ1QLYNdlICyxm0S
         IOS9n5osHnRmBI75qdQvs3svA2f+lOOcgdsJDxjahKmZZORFLlohw641GJWX+rq6ZidJ
         F3HULJW9m7o/gl8wtTCukqhU0RsKaxB4mgsxyn4Nsy8ZI5sHv1tH/J52rq8VbV6oi0MT
         d97SY+ty1CYfldogUzOJbsbBOtjM9BsV/KkvfH6tZ/Xfc3EXRm52b48cgXv5NBFZTa4k
         H5zfb2rwUzxOjVUV9hsxWsDD032TafLtvI9rtMZ9m1re1Tt1RV0KH5zEvt/EotPfvWMJ
         OghQ==
X-Gm-Message-State: ACrzQf1PM//quZ5YvrwcRSvel91uMRoEN5RQIoimhpX+R1hjCBbgObRe
        H4sdLLFXAahHj9Giez51pEa8P1fVGmNGZ8e7pbOe+pQ6fqm7
X-Google-Smtp-Source: AMsMyM6dsdrFnLzH6M1m4W+780ahSIiWPJIsF0Iz1y+tBKPXrYPKAVj3f79wZd/o+1p4Zh1/UCz1orAY/uqocPAu/hNmfpdHziFP
MIME-Version: 1.0
X-Received: by 2002:a92:cacd:0:b0:300:9f3b:af12 with SMTP id
 m13-20020a92cacd000000b003009f3baf12mr23843357ilq.291.1667754164464; Sun, 06
 Nov 2022 09:02:44 -0800 (PST)
Date:   Sun, 06 Nov 2022 09:02:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bb3b905ecd046a7@google.com>
Subject: [syzbot] WARNING in btrfs_replace_file_extents
From:   syzbot <syzbot+2f950aaffb5b5e29e988@syzkaller.appspotmail.com>
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

HEAD commit:    b208b9fbbcba Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15089866880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=2f950aaffb5b5e29e988
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129c6099880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92fde6d92d82/disk-b208b9fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae3dbdb3faf8/vmlinux-b208b9fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbf4da09683c/bzImage-b208b9fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f92112a8392e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f950aaffb5b5e29e988@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3656 at fs/btrfs/file.c:2872 btrfs_replace_file_extents+0x14ae/0x1a60 fs/btrfs/file.c:2872
Modules linked in:
CPU: 0 PID: 3656 Comm: syz-executor.0 Not tainted 6.1.0-rc3-syzkaller-00288-gb208b9fbbcba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:btrfs_replace_file_extents+0x14ae/0x1a60 fs/btrfs/file.c:2872
Code: c6 60 37 db 8a 44 89 e2 31 c0 e8 3f 5f a4 06 e9 66 fd ff ff e8 93 14 fa fd 48 c7 c7 60 36 db 8a 44 89 e6 31 c0 e8 a2 b2 c1 fd <0f> 0b 41 b7 01 45 0f b6 c7 48 89 df 48 c7 c6 a0 38 db 8a ba 38 0b
RSP: 0018:ffffc9000410f540 EFLAGS: 00010246
RAX: 1ebea76ba4070c00 RBX: ffff8880727ec0a8 RCX: ffff88807e459d40
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000410f710 R08: ffffffff816b9e3d R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: 00000000fffffff4
R13: 1ffff1100e4fd81f R14: ffff8880727ec0f8 R15: 0000000000000000
FS:  00007f7bf103c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bf103bff8 CR3: 000000001e5de000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 insert_prealloc_file_extent fs/btrfs/inode.c:9852 [inline]
 __btrfs_prealloc_file_range+0x803/0x14d0 fs/btrfs/inode.c:9919
 btrfs_prealloc_file_range+0x3c/0x50 fs/btrfs/inode.c:9998
 btrfs_zero_range+0xd2a/0x12d0 fs/btrfs/file.c:3308
 btrfs_fallocate+0xc54/0x2020 fs/btrfs/file.c:3418
 vfs_fallocate+0x515/0x670 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xb9/0x100 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7bf028b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bf103c168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f7bf03ac2c0 RCX: 00007f7bf028b5a9
RDX: 0000000000000000 RSI: 0000000100000011 RDI: 0000000000000003
RBP: 00007f7bf103c1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd887b79bf R14: 00007f7bf103c300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
