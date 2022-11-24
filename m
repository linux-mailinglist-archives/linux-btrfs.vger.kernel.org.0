Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CB637258
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 07:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiKXG2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 01:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXG2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 01:28:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23656942DC
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 22:28:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id m11-20020a056e021c2b00b00302c7ea7e16so671397ilh.22
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 22:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVFhraT0Cf3glhkVlBQ0Voc0oFhm9H40BSuFll0WGGA=;
        b=vv/GIV7SnwNfnaVb0dszCD79EEBXuO8gsPB6mk6q3DnaD4ulacRuwrDwwg9tP7x1bk
         mc/YA+qjuH3h6BO/5adwtKMiOjQ5xYzmutdZNyvZdbvUQz99EBvC/cKfpFVcnXf/Rv+v
         eTQn3Z4RwEnxXSoNIVR5A1orfyQTocsk0D4PGEBqXedzd7a83gc187Poz+PdFB8yrVr4
         m5YgVwENxKad9XCVwZeumRPrpR3WViMIYYqOn4pt5/DDUMGlg1YcyXvK+oInZiItIUZh
         ZoX+wnf6UjrL+OT/wjpKzFBuKj5mio504igRVNDrjlCuNIJoReswApCNHnooZbP8f3tV
         Wtzg==
X-Gm-Message-State: ANoB5pnfvCc+UZZigrumG/w7qbcIBv2t0l7B9TGad/GI+5vbvd6z+guG
        Ys0Di0SPNxyEI5AFiCR50sWwgwOfIU4eDvkHZFhkBA660i4k
X-Google-Smtp-Source: AA0mqf7qrDGPX1h42NChqLiGBPuCQwYhvOxbAEtPstHIEXETI3tcRnE0OU2nQb92r1Be+1CxBFh+mUNmo+j0d0PrRYMQsMdOR0oe
MIME-Version: 1.0
X-Received: by 2002:a6b:e004:0:b0:6d3:c9df:bc7d with SMTP id
 z4-20020a6be004000000b006d3c9dfbc7dmr6009328iog.142.1669271326075; Wed, 23
 Nov 2022 22:28:46 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:28:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cb13705ee3184f9@google.com>
Subject: [syzbot] kernel BUG in create_pending_snapshot
From:   syzbot <syzbot+d56e0d33caf7d1a02821@syzkaller.appspotmail.com>
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

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ba30e3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=d56e0d33caf7d1a02821
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1562844b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137a668d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/815bacde9ae6/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce54e3220860/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52a8ac111c19/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a9f8cb5ade27/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d56e0d33caf7d1a02821@syzkaller.appspotmail.com

BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
kernel BUG at fs/btrfs/transaction.c:1672!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3638 Comm: syz-executor237 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:create_pending_snapshot+0x250a/0x2560 fs/btrfs/transaction.c:1672
Code: ff e8 da c7 02 fe 48 c7 c7 60 16 39 8b 44 89 ee 31 c0 e8 c9 65 ca fd 0f 0b b3 01 e9 18 fa ff ff e8 3b 63 0a 07 e8 b6 c7 02 fe <0f> 0b e8 af c7 02 fe 0f 0b e8 a8 c7 02 fe 0f 0b e8 a1 c7 02 fe 48
RSP: 0018:ffffc90003aff6e0 EFLAGS: 00010293
RAX: ffffffff8387d0ba RBX: 00000000fffffff4 RCX: ffff88802722ba80
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc90003aff970 R08: ffffffff8387b1f0 R09: fffffbfff1a42e97
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: ffff888076ce1780
R13: ffff8880731717d0 R14: ffff888027dea000 R15: ffff8880708b8178
FS:  0000555555bce300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005626964b1000 CR3: 000000007955e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 create_pending_snapshots+0x1a8/0x1e0 fs/btrfs/transaction.c:1868
 btrfs_commit_transaction+0x13f0/0x3760 fs/btrfs/transaction.c:2323
 create_snapshot+0x4aa/0x7e0 fs/btrfs/ioctl.c:833
 btrfs_mksubvol+0x62e/0x760 fs/btrfs/ioctl.c:983
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1029
 __btrfs_ioctl_snap_create+0x339/0x450 fs/btrfs/ioctl.c:2184
 btrfs_ioctl_snap_create+0x134/0x190 fs/btrfs/ioctl.c:2211
 btrfs_ioctl+0x15c/0xc10
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efd25d6d2a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe43e29638 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd25d6d2a9
RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000003
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffe43e29670 R14: 0000000000000003 R15: 00007ffe43e2966a
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:create_pending_snapshot+0x250a/0x2560 fs/btrfs/transaction.c:1672
Code: ff e8 da c7 02 fe 48 c7 c7 60 16 39 8b 44 89 ee 31 c0 e8 c9 65 ca fd 0f 0b b3 01 e9 18 fa ff ff e8 3b 63 0a 07 e8 b6 c7 02 fe <0f> 0b e8 af c7 02 fe 0f 0b e8 a8 c7 02 fe 0f 0b e8 a1 c7 02 fe 48
RSP: 0018:ffffc90003aff6e0 EFLAGS: 00010293
RAX: ffffffff8387d0ba RBX: 00000000fffffff4 RCX: ffff88802722ba80
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc90003aff970 R08: ffffffff8387b1f0 R09: fffffbfff1a42e97
R10: fffffbfff1a42e97 R11: 1ffffffff1a42e96 R12: ffff888076ce1780
R13: ffff8880731717d0 R14: ffff888027dea000 R15: ffff8880708b8178
FS:  0000555555bce300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005626963c87d8 CR3: 000000007955e000 CR4: 00000000003506f0
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
