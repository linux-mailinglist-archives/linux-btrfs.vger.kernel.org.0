Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617B160394F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 07:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJSFki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJSFkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 01:40:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043D37199
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 22:40:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso9732313ioo.22
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 22:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk9uXev2dDkAxNITjKYNFzbWMUoL/8S69HV86cMQdjY=;
        b=cf7JgJ7m3n8N0UDQLcjVRQ38rmPGojcXVu/w9eZWaew2R7wStshCe3MpbK+qFn8n+s
         gtKO4fC3wMWbNTD3pG/3KW2qqUJ8COZ0TvMG8C3uxQqWPx1vFPbonGbLtvwwF6xBSOn2
         X3s4MYLcjbFFPgzniyEqiiAHTlwx5NA8DwiLg/1nQ1+kTfmG5WBI8TJOtwJvIW1KJ+le
         rJb+ngIR+884YRpEemv03IeotS/b08s0FbJ1Q9K8glUK2f+/I10Nq4JkPyPVWYXcGcaP
         bW1LonY3vqpc2gN+8Q0k1X6RjSboqMEymV8FTPzdnnfWr+MXd0oKirYMryCQx+a4rDbc
         FlPw==
X-Gm-Message-State: ACrzQf3G1FPD2njn22gGoTSjgDo+zcGcmJTnw0DAVD3zbQCQSWxKoLXu
        aY3K75gnKfWHSG3COtAdhx9P9dafGz5srvjGJmKYj1qajZm9
X-Google-Smtp-Source: AMsMyM7pAAlnc4JjRtqJPmp6Y4InfSfWIAtzQBcAyZsVcFcIIYon0I5QHzHaDUAtMSFqkxCRCoXuLUZlDf0Yxe4fAF28PrwAi3sf
MIME-Version: 1.0
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id
 p6-20020a92d686000000b002fa62266247mr4606940iln.79.1666158035565; Tue, 18 Oct
 2022 22:40:35 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:40:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d984e005eb5ca593@google.com>
Subject: [syzbot] WARNING in cleanup_transaction
From:   syzbot <syzbot+021d10c4d4edc87daa03@syzkaller.appspotmail.com>
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1486ab76880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fcaed6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147d4978880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a826a22c91ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+021d10c4d4edc87daa03@syzkaller.appspotmail.com

BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): checking UUID tree
BTRFS warning (device loop0): Skipping commit of aborted transaction.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3614 at fs/btrfs/transaction.c:1958 cleanup_transaction+0x1e1/0x770 fs/btrfs/transaction.c:1958
Modules linked in:
CPU: 1 PID: 3614 Comm: syz-executor893 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:cleanup_transaction+0x1e1/0x770 fs/btrfs/transaction.c:1958
Code: 24 48 c7 c6 40 d0 da 8a 44 89 f2 31 c0 e8 59 03 a2 06 eb 1a e8 10 62 04 fe 48 c7 c7 60 cf da 8a 44 89 f6 31 c0 e8 6f c6 cc fd <0f> 0b b3 01 44 0f b6 c3 48 8b 7c 24 08 48 c7 c6 40 d3 da 8a ba a6
RSP: 0018:ffffc90003a4fa20 EFLAGS: 00010246
RAX: 3c5edefe8e400a00 RBX: ffff88801cedc001 RCX: ffff888025b19d80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003a4fb50 R08: ffffffff816aa79d R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: ffff88807091f1a0
R13: 1ffff1100e123e34 R14: 00000000fffffff4 R15: dffffc0000000000
FS:  0000555556a50300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7a96d7300 CR3: 000000007c8ab000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x2cd4/0x3760 fs/btrfs/transaction.c:2531
 iterate_supers+0x137/0x1f0 fs/super.c:723
 ksys_sync+0xd5/0x1c0 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a04273e09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff68d2aca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3a04273e09
RDX: 0000000000000cd0 RSI: 000000000000c0c2 RDI: 00007fff68d2acd0
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000034313633
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff68d2adb0
R13: 00007fff68d2acd0 R14: 0000000100000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
