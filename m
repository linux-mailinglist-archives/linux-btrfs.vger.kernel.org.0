Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083375EAF1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIZSFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIZSFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 14:05:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D412080
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id n4-20020a056e02100400b002f09be72a53so5697748ilj.18
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=J77Qaam8rH+K8wi2pFa5VgGQyyM0pPLWg47wXEbzR0I=;
        b=5zXjiRGUlKogspwkg/nOs4HzRKHcvm3VsKomPCUJvWRONzlmBSkgcaiB8BHKh+ohYk
         1pz+fLVlQlfss5z1npl3q1VhulQIZqbZZKs6gPWJ9PlnrudeH/mAiTny9tUh4RKnym0j
         RKIXfaCWQIpFYmlvCx6xOKnP3WZxDCQU+GlhE7kgXPeOSiJYOeKJDMtqGnv0xG74iCFP
         voWzE+mYmFq684+rYY80xZrsCSdfEHsMGJuUDiBMtb+CJc1m2tPyuXlFxKNkhWSTwH0V
         LcsvAagXeL5YKlaN/bXpjgS1MDf1eEHB/aI2JJypmVMuDsJ9ZJGQ57Mlet2fcyVrxz2U
         4nGg==
X-Gm-Message-State: ACrzQf3Xj4slp3Yq5vNtoaE3jG1sikyfpNRnvTxWdcOLoVoFTcnXIjzz
        4pUGQcl9IUkbif+If8fVy63jLOxk0E60QYJapIK76cBaOMtY
X-Google-Smtp-Source: AMsMyM55IW17S+4c3nTxO+4/rx2V2C7ylB4KArBYyA/AK/iTWuShQjciF6HR8MRbDk1q9XmfhnagYNfDCAwFEuzrvf33FezrRFi7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2169:b0:35b:333b:fdeb with SMTP id
 p9-20020a056638216900b0035b333bfdebmr10462318jak.25.1664214581949; Mon, 26
 Sep 2022 10:49:41 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:49:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcba1e05e998263c@google.com>
Subject: [syzbot] kernel BUG in btrfs_free_tree_block
From:   syzbot <syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com>
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1664ce88880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112dc2a8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112cb7f8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com

BTRFS info (device loop0): using crc32c (crc32c-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-tree.c:3273!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3114 Comm: syz-executor276 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_free_tree_block+0x400/0x43c fs/btrfs/extent-tree.c:3273
lr : btrfs_free_tree_block+0x400/0x43c fs/btrfs/extent-tree.c:3273
sp : ffff800012743670
x29: ffff8000127436c0 x28: 0000000000503000 x27: 0000000000000002
x26: ffff80000cf00000 x25: ffff0000cc66c000 x24: fffffc0000000000
x23: 00000000fffffff4 x22: 0000000000000001 x21: ffff0000ca5b7000
x20: 0000000000000000 x19: ffff0000c9478d80 x18: fffffffffffffff5
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff0000c8a2cf80
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c8a2cf80
x11: ff808000090f8124 x10: 0000000000000000 x9 : ffff8000090f8124
x8 : ffff0000c8a2cf80 x7 : ffff8000084b1e88 x6 : 0000000000000000
x5 : 0000000000000c40 x4 : 0000000000000068 x3 : 0000000000000068
x2 : ffff0000c3461800 x1 : 00000000fffffff4 x0 : 0000000000000000
Call trace:
 btrfs_free_tree_block+0x400/0x43c fs/btrfs/extent-tree.c:3273
 __btrfs_cow_block+0x688/0xa88 fs/btrfs/ctree.c:467
 btrfs_cow_block+0x1d0/0x258 fs/btrfs/ctree.c:572
 btrfs_search_slot+0x458/0xfd8
 btrfs_insert_empty_items+0x4c/0xd0 fs/btrfs/ctree.c:4069
 btrfs_create_new_inode+0x610/0xd18 fs/btrfs/inode.c:6428
 btrfs_create_common+0x114/0x1b4 fs/btrfs/inode.c:6657
 btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6697
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 94bb0eb0 97c6a0e9 d4210000 97c6a0e7 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
