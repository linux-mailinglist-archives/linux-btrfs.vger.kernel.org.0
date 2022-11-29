Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12C63BB65
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Nov 2022 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiK2IVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Nov 2022 03:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiK2IVm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Nov 2022 03:21:42 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B957B40
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 00:21:41 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id w9-20020a056e021c8900b0030247910269so11212953ill.4
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 00:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpQYMLpt/bycVlWC6U8JGOQTt/3IYzJ8U4wO7awntLY=;
        b=bqEZoUyJ2q39HKUhKloDBp82L6keesDJC0ohgneSmnSsg/85suoQ2BSY63LLsmrOK+
         2XJFl80mcAWaBauP9tT3ftoIVmzQojuFLP+6fmVJi9nwQJGVHLGBvNBskxB4yLhOSp+P
         1yk1yr9/Brg+Epx4wss7jPddC7EhujWoTntu9m70RYq2BAw3ispLGGnBnqAoTq/ilkr9
         eB2nxhNVROnyveI2Px7R7DWkG3tedWNKSmRqQ5Q7Tfjleq0GKR1OXDSyFcKtD6EfEWOx
         91JoS/wnHiq2DF9A4bBwoNwTQ664/30JmbhkhND2XASxeau8g8VIQTxvA9da1+QLRNdp
         Ukpg==
X-Gm-Message-State: ANoB5pm4ve3Y+TrKlBDVdIfsp0ljHoJl+VDRCqNiBSiuQ+KxEw+TaZ5T
        eb/ieYHngOuBvrt7Q7EspJ+kKp+bA1k7vzasWY0B/7A0ghUj
X-Google-Smtp-Source: AA0mqf7WLmXhj9IqbhUs6n8OcuccA/0NgC495qCxcagg8ZLcYU0WaYL1mRbrkgoU0K/APVJHXa01Bj8Os0xBuPxHa64xB2fw6S2J
MIME-Version: 1.0
X-Received: by 2002:a92:db4b:0:b0:302:5575:9e46 with SMTP id
 w11-20020a92db4b000000b0030255759e46mr24667075ilq.41.1669710101191; Tue, 29
 Nov 2022 00:21:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 00:21:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075a52e05ee97ad74@google.com>
Subject: [syzbot] WARNING: kmalloc bug in btrfs_ioctl_send
From:   syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=176a733d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=4376a9a073770c173269
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c3d03880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13237ca1880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/aa0da055eccb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com

BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
BTRFS info (device loop0): checking UUID tree
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3072 at mm/util.c:596 kvmalloc_node+0x19c/0x1a4
Modules linked in:
CPU: 1 PID: 3072 Comm: syz-executor189 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvmalloc_node+0x19c/0x1a4
lr : kvmalloc_node+0x198/0x1a4 mm/util.c:596
sp : ffff800012f13c40
x29: ffff800012f13c50 x28: ffff0000cbb01000 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0000c97a8a10 x24: ffff0000c6fa6400
x23: 0000000000000000 x22: ffff8000091f72d8 x21: 000caf0ca5eccda0
x20: 00000000ffffffff x19: 0000000000000dc0 x18: 0000000000000010
x17: ffff80000c0f0b68 x16: ffff80000dbe6158 x15: ffff0000c43a1a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c43a1a40
x11: ff808000084361e8 x10: 0000000000000000 x9 : ffff8000084361e8
x8 : ffff0000c43a1a40 x7 : ffff800008578874 x6 : 0000000000000000
x5 : 00000000ffffffff x4 : 0000000000012dc0 x3 : 0010000000000000
x2 : 000caf0ca5eccda0 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 kvmalloc_node+0x19c/0x1a4
 kvmalloc include/linux/slab.h:706 [inline]
 kvmalloc_array include/linux/slab.h:724 [inline]
 kvcalloc include/linux/slab.h:729 [inline]
 btrfs_ioctl_send+0x64c/0xed0 fs/btrfs/send.c:7915
 _btrfs_ioctl_send+0x188/0x218 fs/btrfs/ioctl.c:5233
 btrfs_ioctl+0x5c0/0xa64
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 82706
hardirqs last  enabled at (82705): [<ffff80000844b028>] mod_lruvec_page_state include/linux/vmstat.h:563 [inline]
hardirqs last  enabled at (82705): [<ffff80000844b028>] __kmalloc_large_node+0x108/0x188 mm/slab_common.c:1099
hardirqs last disabled at (82706): [<ffff80000c07d8b4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (82616): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (82614): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
