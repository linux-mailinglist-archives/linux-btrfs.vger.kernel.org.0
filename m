Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0A6D8D67
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 04:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjDFCYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 22:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDFCYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 22:24:04 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C17ED2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 19:24:02 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id s1-20020a92ae01000000b0032637be81d1so14297017ilh.4
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 19:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747842; x=1683339842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+mKu+ujEdL90lRYA9dnzg2MP3Ci3br+oGe4ZowcyVo=;
        b=zXV5/Gv/uT5Z2d6dpoPFw4OP7p89dRHMIZn7/JYwH0THsmlDI/jBm1F5225D7ZxWSQ
         U7C2ZV6TJjCTYeqNF2ykAOPxDFDgDndHN8njiHI+Q8jFKmKOjDvd/iS0kOhH+LZVPDOS
         w3OkH2oRAHqwBfg7DLNUEYKfJHtDeampdgCdNyE6o1/IgFihEB2L90D3AnnOW88JACMq
         zManWwWHyDqw/KKGdRra5mFTt7z7PQPZnzyoPXuOU4Ml69K5auriLn25tOQK6/8jous1
         IU4V1+qg4YS5r0a/rLGkcGErx2tkyXQxN/LrlQ/qgTh3OehvLBAOzh8YRe6gjWhnKddx
         tzJw==
X-Gm-Message-State: AAQBX9e2+stIuCzsdLdMz8T6kGGHHZhbD56d1ZM650wv13SViU9CDdRN
        29iYluep1XiusLXyRI33+z+q16fKzJJD1VVRH8qIfXVN+LLE
X-Google-Smtp-Source: AKy350ZZRAK/3QQ6Z9pkFGX8KPQ+PFWJNZSoRngGCZmHIgNS0GVtfMhBAaFQO8qMnQ8S1eSqjw2T1sKJGi4i1649CG3xTTfkaIJC
MIME-Version: 1.0
X-Received: by 2002:a02:856f:0:b0:40b:4e80:f37f with SMTP id
 g102-20020a02856f000000b0040b4e80f37fmr4662870jai.3.1680747842184; Wed, 05
 Apr 2023 19:24:02 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000172fc905f8a19ab5@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_commit_transaction (2)
From:   syzbot <syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    00c7b5f4ddc5 Merge tag 'input-for-v6.3-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138b98c9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e626f76ad59b1c14
dashboard link: https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4738db235f4a/disk-00c7b5f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db62da5dcb6b/vmlinux-00c7b5f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e596cad760c/bzImage-00c7b5f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com

BTRFS info (device loop5): auto enabling async discard
BTRFS warning (device loop5: state M): Skipping commit of aborted transaction.
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 28430 at fs/btrfs/transaction.c:1984 cleanup_transaction fs/btrfs/transaction.c:1984 [inline]
WARNING: CPU: 0 PID: 28430 at fs/btrfs/transaction.c:1984 btrfs_commit_transaction+0x34c6/0x4410 fs/btrfs/transaction.c:2558
Modules linked in:
CPU: 0 PID: 28430 Comm: syz-executor.5 Not tainted 6.3.0-rc4-syzkaller-00224-g00c7b5f4ddc5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:cleanup_transaction fs/btrfs/transaction.c:1984 [inline]
RIP: 0010:btrfs_commit_transaction+0x34c6/0x4410 fs/btrfs/transaction.c:2558
Code: c8 fe ff ff be 02 00 00 00 e8 f6 c5 ab 00 e9 7e d0 ff ff e8 4c d1 1e fe 8b b5 20 ff ff ff 48 c7 c7 a0 89 94 8a e8 7a 57 e7 fd <0f> 0b c7 85 00 ff ff ff 01 00 00 00 e9 d0 dc ff ff e8 24 d1 1e fe
RSP: 0018:ffffc900043efa48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000044ea0001 RCX: ffffc90003c0b000
RDX: 0000000000040000 RSI: ffffffff814a8037 RDI: 0000000000000001
RBP: ffffc900043efbc8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888044ea0000
R13: ffff88803479ac60 R14: ffff88803479adc8 R15: ffff888044ea0000
FS:  00007f69217cb700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002024a030 CR3: 0000000047942000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_set_free_space_cache_v1_active+0x1ae/0x2a0 fs/btrfs/free-space-cache.c:4139
 btrfs_remount_cleanup fs/btrfs/super.c:1677 [inline]
 btrfs_remount+0x57b/0x1850 fs/btrfs/super.c:1867
 legacy_reconfigure+0x119/0x180 fs/fs_context.c:633
 reconfigure_super+0x40c/0xa30 fs/super.c:956
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6920a8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f69217cb168 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f6920babf80 RCX: 00007f6920a8c0f9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000004
RBP: 00007f6920ae7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe61745aff R14: 00007f69217cb300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
