Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C1616B8E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiKBSGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKBSGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 14:06:43 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B942EF64
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 11:06:43 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s15-20020a056e02216f00b00300d14ba82bso1785752ilv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 11:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9DM+dSTltJpPeB5NG0nQSIBurTpKE/AraTlYTnn+p4=;
        b=lIO9G2mqFzSvRZNS0CFcpDSZWYL6UmELem8tUmafMDn6ngCBWn3p6Oyv+nrKDpF24I
         RLe3dVTqDbzI9rrq77CyHp8iGv+CjO+hc2ofcgW+cn6q+VpZ2fmHHAr2j44RUbe2msbH
         +HCpW1/iadQlAqBNiJHXgx1u+tnBwaMTpX4JhjCoSf8WWYP4kHYZXodqdeEnlFX1DVEk
         bwxrfJvdbfigkOq04eIKTUkurt0VJJ1sdDnJF0xWkL+LRsIoJOB+wCYAlW2ZFCv4vSVt
         8tFfJg2n7unAeZ1WEdgIprvJFjvBAn4tEVcBorjGlcUga/LZY8NmQA8WgzeoGAiuf/wt
         Uf+Q==
X-Gm-Message-State: ACrzQf2pmAmxsrqKYhc1E4n92a5MV1CQRk2ZzP9ouHbKdiqzGN3f3ke2
        i6Shi56UpYnsSYamIcOzuJWHVru2m/0WXQmXUagK0CrTMisu
X-Google-Smtp-Source: AMsMyM6cac5Pzrl8neaFAD4OUwhD3WW+pfKknek5X1+KAiHTUuHkumAlpeEgmVpRhCe83NT+X4hz4V/xUc+o8wdTn47Zqxm3W63O
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:2ff:7c9b:3ab5 with SMTP id
 10-20020a056e0216ca00b002ff7c9b3ab5mr15335279ilx.9.1667412402327; Wed, 02 Nov
 2022 11:06:42 -0700 (PDT)
Date:   Wed, 02 Nov 2022 11:06:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef589805ec80b371@google.com>
Subject: [syzbot] kernel BUG in dev_args_match_device
From:   syzbot <syzbot+031687116258450f9853@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1744c1fc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=031687116258450f9853
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+031687116258450f9853@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3710!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 2686 Comm: syz-executor.5 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3710
Code: 00 00 e8 7e 9c 55 f7 eb e3 e8 77 9c 55 f7 eb dc 89 f1 48 89 fe 48 c7 c7 60 c8 db 8a 48 c7 c2 40 ed db 8a 31 c0 e8 27 86 ff ff <0f> 0b e8 54 9c 55 f7 48 c7 c7 60 f9 82 91 e9 e8 f9 e7 f9 89 f1 48
RSP: 0018:ffffc90003a4fd80 EFLAGS: 00010246
RAX: 0000000000000057 RBX: 0000000000000000 RCX: 88ff9485f0ebf200
RDX: ffffc90004609000 RSI: 0000000000003f0f RDI: 0000000000003f10
RBP: ffffc90003a4fe70 R08: ffffffff816b8dfd R09: fffff52000749f69
R10: fffff52000749f69 R11: 1ffff92000749f68 R12: ffffc90003a4fe60
R13: dffffc0000000000 R14: ffff88807f3e4000 R15: ffffc90003a4fe60
FS:  00007f0048a6c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555e09b0b000 CR3: 000000003ba9d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_args_match_device+0x1e6/0x220 fs/btrfs/volumes.c:6921
 btrfs_find_device+0xbb/0x250 fs/btrfs/volumes.c:6950
 btrfs_ioctl_dev_info+0x3f0/0xb20 fs/btrfs/ioctl.c:3740
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0047c8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0048a6c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0047dac050 RCX: 00007f0047c8b5a9
RDX: 0000000020000980 RSI: 00000000d000941e RDI: 0000000000000003
RBP: 00007f0047ce67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc080c58df R14: 00007f0048a6c300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3710
Code: 00 00 e8 7e 9c 55 f7 eb e3 e8 77 9c 55 f7 eb dc 89 f1 48 89 fe 48 c7 c7 60 c8 db 8a 48 c7 c2 40 ed db 8a 31 c0 e8 27 86 ff ff <0f> 0b e8 54 9c 55 f7 48 c7 c7 60 f9 82 91 e9 e8 f9 e7 f9 89 f1 48
RSP: 0018:ffffc90003a4fd80 EFLAGS: 00010246
RAX: 0000000000000057 RBX: 0000000000000000 RCX: 88ff9485f0ebf200
RDX: ffffc90004609000 RSI: 0000000000003f0f RDI: 0000000000003f10
RBP: ffffc90003a4fe70 R08: ffffffff816b8dfd R09: fffff52000749f69
R10: fffff52000749f69 R11: 1ffff92000749f68 R12: ffffc90003a4fe60
R13: dffffc0000000000 R14: ffff88807f3e4000 R15: ffffc90003a4fe60
FS:  00007f0048a6c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000980 CR3: 000000003ba9d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
