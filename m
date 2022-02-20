Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87C64BD0A8
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbiBTS1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Feb 2022 13:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiBTS1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Feb 2022 13:27:46 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955125C75
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Feb 2022 10:27:23 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id c1-20020a928e01000000b002bec519e98fso6421881ild.5
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Feb 2022 10:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pSYYjv4i1WUh1iDAp2nfTxJwhP3uvRN5jOqDLwvohJk=;
        b=cI9AT6opF6Q7F8shdiSyCiouI37hJZS1qj2rOCKx24RNm5ghwO0Ag2twF99q5Vu1vz
         7niqxJBtEvM0BpwHpa0kTlDtF5pyhaqMn9EWbwwJ94q8bucF34Um+n4TyXf3R+eUAc6D
         LpiEFWPjH6WPAQIQXKGgv8MrIbnkQnd50LmFOdOm+Xdw1ZFTVZ8F2qWxP08lPvet9d22
         kkQ0ptnhoFoGxl3lhDpizHXAoNHAdjM0HL94/9qWcPl8HEYueKd+S3mNNt7yJ1xLVilE
         AV5NZpC/9fydqFjZIRqCvER1FyBF15joRoy4lmIHdL2eqSrwACfo8gyeArg2/xkPUncZ
         d9mw==
X-Gm-Message-State: AOAM530aj4i5I9m4O44SoDZfw91EfOAo9uE02JaZtTuAwUq4XXdpsFt0
        soGHe1BXAmTPImKuufzSa9c2BLdEHODspAjMdXTyNBFOK2Uj
X-Google-Smtp-Source: ABdhPJxZQVGnvRHrpY23wkb0dEerpIGEGo9vmaKQQNULR0KelCo7/EZdOOvHDzW1z1BN+EUAuPT8rryPd7I3k//WZtBeDS28/LCJ
MIME-Version: 1.0
X-Received: by 2002:a02:69c2:0:b0:311:b65e:388b with SMTP id
 e185-20020a0269c2000000b00311b65e388bmr12501547jac.123.1645381643183; Sun, 20
 Feb 2022 10:27:23 -0800 (PST)
Date:   Sun, 20 Feb 2022 10:27:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ca92705d877448c@google.com>
Subject: [syzbot] WARNING in kthread_bind_mask
From:   syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11daf74a700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da674567f7b6043d
dashboard link: https://syzkaller.appspot.com/bug?extid=087b7effddeec0697c66
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com

BTRFS info (device loop3): disk space caching is enabled
BTRFS info (device loop3): has skinny extents
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10327 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]
WARNING: CPU: 0 PID: 10327 at kernel/kthread.c:525 kthread_bind_mask+0x35/0xc0 kernel/kthread.c:543
Modules linked in:
CPU: 1 PID: 10327 Comm: syz-executor.3 Not tainted 5.17.0-rc4-syzkaller-00051-gc5d9ae265b10 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__kthread_bind_mask kernel/kthread.c:525 [inline]
RIP: 0010:kthread_bind_mask+0x35/0xc0 kernel/kthread.c:543
Code: fb e8 df 36 2a 00 be 02 00 00 00 48 89 df e8 62 cb 03 00 31 ff 48 89 c5 48 89 c6 e8 d5 38 2a 00 48 85 ed 75 12 e8 bb 36 2a 00 <0f> 0b 5b 5d 41 5c 41 5d e9 ae 36 2a 00 e8 a9 36 2a 00 4c 8d ab 80
RSP: 0018:ffffc90002ca7658 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88802e38e200 RCX: ffffc90004682000
RDX: 0000000000040000 RSI: ffffffff814ddc65 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffc6ab7
R10: ffffffff814ddc5b R11: 0000000000000000 R12: ffffffff8d93cf18
R13: ffff88807b643940 R14: ffff88807a0ea020 R15: ffff88807a0ea000
FS:  00007f0f90de1700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b555fb920 CR3: 0000000021192000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 init_rescuer kernel/workqueue.c:4291 [inline]
 init_rescuer+0x141/0x1d0 kernel/workqueue.c:4270
 alloc_workqueue+0xbf7/0xf00 kernel/workqueue.c:4358
 __btrfs_alloc_workqueue+0x3e9/0x660 fs/btrfs/async-thread.c:112
 btrfs_alloc_workqueue+0x7b/0x460 fs/btrfs/async-thread.c:140
 btrfs_init_workqueues fs/btrfs/disk-io.c:2401 [inline]
 open_ctree+0x196e/0x4817 fs/btrfs/disk-io.c:3574
 btrfs_fill_super fs/btrfs/super.c:1358 [inline]
 btrfs_mount_root.cold+0x15/0x162 fs/btrfs/super.c:1724
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:1000 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1030
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1017
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1784
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2994 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 __se_sys_mount fs/namespace.c:3522 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0f9246d58a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f90de0f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0f9246d58a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0f90de0fe0
RBP: 00007f0f90de1020 R08: 00007f0f90de1020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0f90de0fe0 R15: 0000000020016b00
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
