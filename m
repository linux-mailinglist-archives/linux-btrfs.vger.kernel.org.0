Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234A5F990F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiJJHGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 03:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiJJHFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 03:05:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCCD5F73
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 00:04:39 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i21-20020a056e021d1500b002f9e4f8eab7so8085739ila.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 00:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0X1SP32dQ7IVi48NKuPgJ/r/8mWAp5JP0WnIefznseA=;
        b=VYbsHpn+4eBSjw7ThZyymWrHAYUVrJWxLi1KUio2HG6vGf5DRgCAn6aMQHydMqcyvD
         IGup+faZxzd8Omzy7g1wo7/bwvjS9VIzccE9GFOwNNFh0vKLB5/ADN2qMkgPC8kh+bGG
         zsao/6jsRUBYWF15XISLhX99iDFoeDVvj5QVlnwVytwpVk1uFxzlbu4uu32BQtCglgQU
         BzEQzYSxvdKImftizmWRSElp5XgQ73502APcNxyUU90vbBRzzSg7gsIaSRLnQ8KPDt69
         sAPuPdo7rKZiu8lcOt2dp+Pw80rRyE+L2Qlvh556Zs711jF2piX3zkeHv4cHu6oAxDSY
         uW3g==
X-Gm-Message-State: ACrzQf3Y3uNf0MH3YIK8rr2TwI6Yi0QFmJ/c7zVao1skGoag4UGln2a7
        iRyLQub/3vY7aUbYWw+XbpY86VlFUjjWccVhzVEO/JLm00Tl
X-Google-Smtp-Source: AMsMyM5QbuEzWkmxmDs+r1bbA9DaTR6NIW0gno1Tobys1elgtZI3gJYUCUvZekWeVeI+VU8cjpbP2UAUugrQ4EOQk1cuqqIoyCqi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1396:b0:357:148d:8705 with SMTP id
 w22-20020a056638139600b00357148d8705mr8558185jad.61.1665385477671; Mon, 10
 Oct 2022 00:04:37 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:04:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf908705eaa8c5a7@google.com>
Subject: [syzbot] WARNING in __kernel_write_iter
From:   syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
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

HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110f6f0a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/disk-a6afa419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinux-a6afa419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter+0x639/0x740
Modules linked in:
CPU: 1 PID: 20347 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__kernel_write_iter+0x639/0x740 fs/read_write.c:504
Code: 25 28 00 00 00 48 3b 84 24 e0 00 00 00 0f 85 17 01 00 00 4c 89 f0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 07 b0 9e ff <0f> 0b 49 c7 c6 f7 ff ff ff eb a5 e8 f7 af 9e ff 4c 8b 74 24 18 eb
RSP: 0018:ffffc90015997740 EFLAGS: 00010287
RAX: ffffffff81e81fe9 RBX: 00000000000a801d RCX: 0000000000040000
RDX: ffffc90004875000 RSI: 0000000000000c05 RDI: 0000000000000c06
RBP: ffffc90015997870 R08: ffffffff81e81a5d R09: fffffbfff1c19fd6
R10: fffffbfff1c19fd6 R11: 1ffffffff1c19fd5 R12: 1ffff92002b32ef4
R13: 1ffff1100f3c659f R14: ffff888079e32c80 R15: dffffc0000000000
FS:  00007f320c219700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c023d85000 CR3: 000000007765a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kernel_write fs/read_write.c:537 [inline]
 kernel_write+0x1c5/0x340 fs/read_write.c:558
 write_buf fs/btrfs/send.c:590 [inline]
 send_header fs/btrfs/send.c:708 [inline]
 send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
 btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
 _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
 btrfs_ioctl+0x5eb/0xc10
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f320b08a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f320c219168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f320b1abf80 RCX: 00007f320b08a5a9
RDX: 0000000020000040 RSI: 0000000040489426 RDI: 0000000000000003
RBP: 00007f320b0e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffca50575cf R14: 00007f320c219300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
