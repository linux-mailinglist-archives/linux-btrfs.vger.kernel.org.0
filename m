Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63AD62425F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 13:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKJM2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 07:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKJM2q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 07:28:46 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251CC101CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:28:45 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id h8-20020a05660224c800b006d8de87e192so954524ioe.6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypzVRHPTcs90FUJ3UgA7uD7nFeCIYVGINSM0KWMebS0=;
        b=z1odhvcXhiAbQuwJFfhBpxdRG7Qwubboy26yAr+0iTTDm52g2bWaLvObIWSj35YleD
         dgmrpxfJM4UE6vla2ocXqKuhpCfknFiGScoR0DJ+1aiEz1nBqkqzsx/DbZ2wU8tfVMij
         Lg+9wPkGEV/P7WUxyyJZ+r4b1J/psbFP5HadHPQv/ozSP8l7HamVft8YrgZ5r41ATUFe
         iy6DtwgPGST2cwD67tXKmDr7+vTfc/F2p300G68X1ZlldFJXEO/Tz8JH82usJbS8C2dH
         dDvckE6DaCtBucjpy0mes2Al3Vso05JNP2GurVZaonqiS+fUkWJNE5iBS4XQ39yT3aYf
         t9SQ==
X-Gm-Message-State: ACrzQf1PJ2r8VH0q/Yxjaz5rFmvWvBfFE7uZeniGE6BhQMdLWqTOjJMy
        kxd0hyr5eDwzLjzIK1jX+I0/IEIse3/yhx8jZBQt9fc1LJPz
X-Google-Smtp-Source: AMsMyM7ocd8vhOdrsm/cN7HW7rAGZmJTWXVTxxnKGpPt5Ynjz2veoPUxPnoQ9NUHafNuBJz6MeDgmO2fC6qRdcCCYE1cztxapy+e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:300:e216:15ab with SMTP id
 q2-20020a056e0220e200b00300e21615abmr17031777ilv.93.1668083324435; Thu, 10
 Nov 2022 04:28:44 -0800 (PST)
Date:   Thu, 10 Nov 2022 04:28:44 -0800
In-Reply-To: <00000000000016a4a905ecd06e88@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000244d705ed1cea17@google.com>
Subject: Re: [syzbot] WARNING in btrfs_create_new_inode
From:   syzbot <syzbot+56e0adfbcf0bafbf4f53@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a54f51880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=56e0adfbcf0bafbf4f53
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102ef615880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11239c15880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e79573f852e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56e0adfbcf0bafbf4f53@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3054 at fs/btrfs/inode.c:6489 btrfs_create_new_inode+0xc34/0xd38 fs/btrfs/inode.c:6489
Modules linked in:
CPU: 0 PID: 3054 Comm: syz-executor178 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_create_new_inode+0xc34/0xd38 fs/btrfs/inode.c:6489
lr : btrfs_create_new_inode+0xc34/0xd38 fs/btrfs/inode.c:6489
sp : ffff800012c53b30
x29: ffff800012c53bd0 x28: 00000000fffffff4 x27: ffff0000ca9b6000
x26: ffff0000c98da000 x25: 0000000000000000 x24: 0000000000000000
x23: ffff0000cab18928 x22: ffff800012c53c38 x21: ffff0000cab30490
x20: 0000000000000000 x19: ffff0000cab18db8 x18: 00000000000000c0
x17: ffff80000dcdc198 x16: ffff80000db1a158 x15: ffff0000c6e81a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6e81a40
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 8e47232f63068100
x8 : 8e47232f63068100 x7 : ffff80000c01775c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000026
Call trace:
 btrfs_create_new_inode+0xc34/0xd38 fs/btrfs/inode.c:6489
 btrfs_create_common+0x114/0x1b4 fs/btrfs/inode.c:6639
 btrfs_mknod+0x84/0xa8 fs/btrfs/inode.c:6664
 vfs_mknod+0x2e8/0x318 fs/namei.c:3914
 do_mknodat+0x248/0x3e8
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3989
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 386
hardirqs last  enabled at (385): [<ffff8000081be9ac>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:261
hardirqs last disabled at (386): [<ffff80000c009b8c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (214): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (212): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BTRFS: error (device loop0: state A) in btrfs_create_new_inode:6489: errno=-12 Out of memory
BTRFS info (device loop0: state EA): forced readonly

