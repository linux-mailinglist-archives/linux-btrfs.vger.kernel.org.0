Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D2600350
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Oct 2022 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJPUgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Oct 2022 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJPUgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Oct 2022 16:36:44 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FC36DFD
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 13:36:43 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k4-20020a056e02156400b002fcfa0da521so6899398ilu.12
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 13:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH7dR4BzkTTqgkSy/nnKXnU8b30BbGbpigBEn+WNcv4=;
        b=w2iMbKVNpzfol5S+Z6/yzwFW0VSeKgQ1P0fcimyxJjY3VyGVDSENfKj0rzykeIh3Fi
         qtEn+noL8n+IXsU9chO96tUVaLdruDlLtBl+2kvOsVRdrLlOnPqjmwq3JE+5FXLUzllz
         WaAsTB8Ea/PGQUKj/L8XPQCFTJ3rTwSIB/bpLlAq+L8OEqcIFICxpC7Kd61qnQr4m8Zh
         AJZk9A+gReVuaPost7RT3/yL+lbzBuJAq6veNYyg3wnzidLMPJmRb/0PT+LbwetTHzdq
         wG7QjDeqv3xwnng9/BR4Uc7BuKzNdbNxGtutJIWMHTb2OtY5qVbzTzQMQhG+xxFuGSBY
         zIHA==
X-Gm-Message-State: ACrzQf0iQynqH0Cazbc+j+/64XLuaDRFz9IkkNULsihDikh8WcbHMhT+
        je4Hg7sluBDFM2xItUIZ/Sr11+4nPnJ9ZV2U87Hc57lSddiu
X-Google-Smtp-Source: AMsMyM58EZ5vnGEImsLM3Y0p4FJ8dZi9UaUgGWA2C27sy9URTMhK1CAwZuzCXIQprBHMI7awD+FNdJKKtsHTm7BiZr2Ab1UJLoO2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a15:b0:363:ecaf:2a53 with SMTP id
 cn21-20020a0566383a1500b00363ecaf2a53mr3789977jab.66.1665952602679; Sun, 16
 Oct 2022 13:36:42 -0700 (PDT)
Date:   Sun, 16 Oct 2022 13:36:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000186e6c05eb2cd12e@google.com>
Subject: [syzbot] WARNING in btrfs_sync_log
From:   syzbot <syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12c65b84880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=4406ed3884d139266b67
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
WARNING: CPU: 0 PID: 30197 at fs/btrfs/tree-log.c:3081 btrfs_sync_log+0x1ebd/0x2d40 fs/btrfs/tree-log.c:3081
Modules linked in:
CPU: 0 PID: 30197 Comm: syz-executor.0 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btrfs_sync_log+0x1ebd/0x2d40 fs/btrfs/tree-log.c:3081
Code: 2b 42 92 06 49 be 00 00 00 00 00 fc ff df 4c 8b 64 24 40 eb 19 e8 d3 a0 f4 fd 48 c7 c7 60 f5 db 8a 89 de 31 c0 e8 33 05 bd fd <0f> 0b b3 01 44 0f b6 c3 4c 89 e7 48 c7 c6 e0 f5 db 8a ba 09 0c 00
RSP: 0018:ffffc90004ed74a0 EFLAGS: 00010246
RAX: db16f372e186ad00 RBX: 00000000fffffff4 RCX: 0000000000040000
RDX: ffffc90004022000 RSI: 000000000000385b RDI: 000000000000385c
RBP: ffffc90004ed7930 R08: ffffffff816aa79d R09: ffffed1017344f13
R10: ffffed1017344f13 R11: 1ffff11017344f12 R12: ffff88808a1dd540
R13: 00000000fffffff4 R14: dffffc0000000000 R15: ffff88808a1dd590
FS:  00007f7877fdd700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3761c46000 CR3: 0000000079795000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_sync_file+0xdf4/0x1140 fs/btrfs/file.c:2242
 generic_write_sync include/linux/fs.h:2873 [inline]
 btrfs_do_write_iter+0xa6f/0x1370 fs/btrfs/file.c:1975
 call_write_iter include/linux/fs.h:2190 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7876e8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7877fdd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7876fabf80 RCX: 00007f7876e8b5a9
RDX: 0000000000000010 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f7877fdd1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffca3e1f08f R14: 00007f7877fdd300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
