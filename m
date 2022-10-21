Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28A607487
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJUJ44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJUJ4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 05:56:54 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA12226E56
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 02:56:48 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so3110061ilv.10
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 02:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKOPYMWoU+pj6DkofKbbNnR/YvcIyy/DI1Wxbd6izEM=;
        b=OfvtitZyUDeG4+d3zQohsGv4eptTWAcFxxrEbVQ5+xzfUDlfxAtwPOr4CTJkNIt8bi
         0hFmIyLdRh2QASj0Y7kesLZJFNxnnHy99vR02nSQJWdmOHZ6w6DLsv2TfMawEQ1qFHsQ
         PZxxb/iMQv+iwXlfD5/5hnfxapjXW7NbuXFWt0e2jQ9MtSQR53lccLfQQ0FZ1xY8jCvu
         93HjWABA45euInZDcl5AUCuM1TeD7HKYWZojcxKe3Wdd8P4NRatg4yjLjKIs+gvfoUXa
         42WQZQgfpuok73e/fJ+d28WTgI7oM/xt+5xWG3PwznPBtFqMOHaSyUc0sK1nDOR8IPpv
         3+jA==
X-Gm-Message-State: ACrzQf0rdE77+SczD73TuyLaCLirDMvGubE+aZ1L5Rh/TsCOoTSDG3zY
        QB3f/rvf5R3eIONGnXLZODX9fD99MyXoYpZ1u8sYbuSpvRL5
X-Google-Smtp-Source: AMsMyM5eHOs/7lFkVSCkihITBx0m6g35gKFh5gtnt0w7ZNWNkyRS7Hr75ZJOBtAiG45QPp/W7KT3bXx4rt5AZVML9Oilic5FfOi8
MIME-Version: 1.0
X-Received: by 2002:a92:c0c9:0:b0:2f9:ae60:164c with SMTP id
 t9-20020a92c0c9000000b002f9ae60164cmr14340758ilf.28.1666346207746; Fri, 21
 Oct 2022 02:56:47 -0700 (PDT)
Date:   Fri, 21 Oct 2022 02:56:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c92d2105eb8875d9@google.com>
Subject: [syzbot] WARNING in btrfs_destroy_inode
From:   syzbot <syzbot+d4d23ca08383875f6956@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=125cfb76880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d23ca08383875f6956
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4d23ca08383875f6956@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
WARNING: CPU: 1 PID: 27221 at fs/btrfs/inode.c:8963 btrfs_destroy_inode+0x274/0x2f8 fs/btrfs/inode.c:8963
Modules linked in:
CPU: 1 PID: 27221 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_destroy_inode+0x274/0x2f8 fs/btrfs/inode.c:8963
lr : btrfs_destroy_inode+0x274/0x2f8 fs/btrfs/inode.c:8963
sp : ffff800020f13a30
x29: ffff800020f13a30 x28: 0000000000000040 x27: ffff000128be1d68
x26: ffff00012a3c0c30 x25: 0000000000000000 x24: ffff00011a6704c0
x23: ffff80000d3480b0 x22: 0000000000000000 x21: ffff80000c1419d0
x20: ffff00011a672a20 x19: ffff00011a672560 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff000128e49a80
x14: 0000000000000010 x13: 0000000000000000 x12: 0000000000040000
x11: 0000000000001bfd x10: ffff800022c9f000 x9 : ffff800009132e4c
x8 : 0000000000001bfe x7 : ffff8000084b15e8 x6 : 0000000000000000
x5 : 0000000000000d40 x4 : 0000000000000038 x3 : 0000000000000038
x2 : ffff0000c001c800 x1 : 00000000fffffff4 x0 : ffff00011a672a20
Call trace:
 btrfs_destroy_inode+0x274/0x2f8 fs/btrfs/inode.c:8963
 alloc_inode+0xb0/0x104 fs/inode.c:269
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x2c/0xc0 fs/inode.c:1047
 btrfs_create+0x34/0xb0 fs/btrfs/inode.c:6690
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 4032
hardirqs last  enabled at (4031): [<ffff8000085633bc>] mod_objcg_state+0x19c/0x204 mm/memcontrol.c:3158
hardirqs last disabled at (4032): [<ffff80000bfb5fbc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:404
softirqs last  enabled at (3900): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (3898): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
