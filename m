Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0B654F60
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiLWK6h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Dec 2022 05:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiLWK6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Dec 2022 05:58:35 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADEF389FB
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 02:58:34 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a9-20020a921a09000000b0030bda27ddcbso2524145ila.18
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 02:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpRfc9myrRtLZbAhtYKQUfGx7AvxeJybhN9iGZKvqqk=;
        b=UJEqmMjUTL/ZxJECv3FDv7FSna35/i/ZUjIM6FMIMCNzwX3bVm+zbaG7XeugQT7UZ+
         iS0aewr44TlpeSuvIDNPFacX/xsM4l6JT992DM/7sDW+7gSVD2bu4PdLchQoiW3ZGZS/
         BPgv88zeaBevj/DriQ6uT1x40pFPSUHjMHkI4T0jYBClDf3QHfXJfvX64ruV/vCNnYPu
         mtDtHFeKgt/15Xx7C8ohO70Ikh3dtePlrX6KH4R2bvPQatZQt65j26k+1DGnB5ewO83N
         npRWmZCb/GyS9Dx+gdvg+gyDp1d2HpHWpbsYzcZUQk38/Kxe0nOZaGjbdY3WI7tVm2JY
         TB1A==
X-Gm-Message-State: AFqh2koD/ktvXDocE1gz9wc7D8OPC0owTFI5BpEUnbVm9SYmUs2z66WQ
        4jEmIGX5KdJEqhLmdPLS4gWfvTUQ67xykwcG8DsP6qIXnYhG
X-Google-Smtp-Source: AMrXdXtijusQp38lPCtOMRGD5s4+WEgUnAfeuys0koQqvxqs7Tgp/B4cj7f7G00ppMtc+M2PQqm+tIX22dNwcCzgr7ks6kyUrSvX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4918:b0:38c:8ef9:c68b with SMTP id
 cx24-20020a056638491800b0038c8ef9c68bmr828122jab.298.1671793113760; Fri, 23
 Dec 2022 02:58:33 -0800 (PST)
Date:   Fri, 23 Dec 2022 02:58:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af090905f07caa86@google.com>
Subject: [syzbot] [btrfs?] BUG: unable to handle kernel paging request in btrfs_is_subpage
From:   syzbot <syzbot+24c9c27b31ab0c22173b@syzkaller.appspotmail.com>
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=166ff01b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=24c9c27b31ab0c22173b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24c9c27b31ab0c22173b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 0000000000002074
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000168eff000
[0000000000002074] pgd=0800000157b7a003, p4d=0800000157b7a003, pud=08000001576b7003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 23070 Comm: syz-executor.5 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_is_subpage+0x20/0xb8 fs/btrfs/subpage.c:68
lr : btrfs_is_subpage+0x20/0xb8 fs/btrfs/subpage.c:67
sp : ffff800014153540
x29: ffff800014153540 x28: 0000000000000001 x27: dead000000000100
x26: fffffc0004d5c9c8 x25: ffff000118d6bda8 x24: ffff800014153a78
x23: 0000000000000001 x22: 05ffc00000002005 x21: 05ffc00000002005
x20: fffffc0004d5c9c0 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff00011bf91a40
x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000040000
x11: 000000000003ffff x10: ffff800013105000 x9 : ffff80000923be40
x8 : 0000000000040000 x7 : ffff8000095d6cf4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : fffffbffeffe3910 x3 : 0000000000005651
x2 : ffff00011700cb00 x1 : fffffc0004d5c9c0 x0 : 0000000000000000
Call trace:
 btrfs_is_subpage+0x20/0xb8 fs/btrfs/subpage.c:67
 wait_subpage_spinlock+0x30/0xd4 fs/btrfs/inode.c:8152
 __btrfs_release_folio fs/btrfs/inode.c:8178 [inline]
 btrfs_release_folio+0xc8/0x228 fs/btrfs/inode.c:8188
 filemap_release_folio+0xc0/0x238 mm/filemap.c:3948
 shrink_folio_list+0xdbc/0x337c mm/vmscan.c:1982
 shrink_inactive_list+0x30c/0x54c mm/vmscan.c:2489
 shrink_list mm/vmscan.c:2728 [inline]
 shrink_lruvec+0x218/0x5b4 mm/vmscan.c:5923
 shrink_node_memcgs+0x13c/0x2c4 mm/vmscan.c:6110
 shrink_node+0xb4/0x600 mm/vmscan.c:6141
 shrink_zones+0x1bc/0x408 mm/vmscan.c:6379
 do_try_to_free_pages+0xd0/0x42c mm/vmscan.c:6441
 try_to_free_mem_cgroup_pages+0x174/0x244 mm/vmscan.c:6756
 try_charge_memcg+0x1a8/0x650 mm/memcontrol.c:2681
 try_charge mm/memcontrol.c:2823 [inline]
 mem_cgroup_charge_skmem+0x50/0x150 mm/memcontrol.c:7209
 sock_reserve_memory+0x88/0x144 net/core/sock.c:1018
 sk_setsockopt+0xb54/0x1694 net/core/sock.c:1518
 sock_setsockopt+0x48/0x60 net/core/sock.c:1542
 __sys_setsockopt+0x21c/0x31c net/socket.c:2248
 __do_sys_setsockopt net/socket.c:2263 [inline]
 __se_sys_setsockopt net/socket.c:2260 [inline]
 __arm64_sys_setsockopt+0x30/0x44 net/socket.c:2260
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 910003fd aa0103f4 aa0003f3 97c1aafa (b9607675) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	aa0103f4 	mov	x20, x1
   8:	aa0003f3 	mov	x19, x0
   c:	97c1aafa 	bl	0xffffffffff06abf4
* 10:	b9607675 	ldr	w21, [x19, #8308] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
