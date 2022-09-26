Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86875EAF1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIZSFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIZSFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 14:05:15 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3DF357C5
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h205-20020a6bb7d6000000b006a1e6bef9c7so4264628iof.17
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aSqeNf4LhEA8TUZMzAIvuoZm+XmnGf16kPWmmowhvVk=;
        b=CqlB7d6JaGIY07gWl6y0mmCGJnSf6cZjM2gKaJUSVC2i4mFn4Spp7BxgQbLlZ09Ikt
         UPaZDlxHGwlZdqwl98M6Uze+w2+C7mfnXfScs/S8sTJ979nrsn3b5ZRQwFVG8qEte89j
         1F04Hesr7M9eXMmEhTh/YQ13VRpPaAlhAUJnqPpMyx1drNWoq6FcPMHXe1Z28TbRR1l/
         0+iRdmItNb1GzeQi9zP4THuQF93pDhxFp/QwTklA28N/4YADOKJl4Ru9zxvOK4wtw69w
         Jgdo4Eb0kcmpaTZoP39g3UD3HPfK9GqtNGWjZkVTz+oswUK0ZQEI2b47AOkxPhdQsCtE
         nd1w==
X-Gm-Message-State: ACrzQf2ydr72EB8pHkfc11lUItZ0YVF4AvFq/ffi6GyQxP2Ln1oHQ7xB
        XzfDhqnSLZJ6dHu453G05lid10yiuU1pX/vlnpb5RwePF6vc
X-Google-Smtp-Source: AMsMyM7nRlroEBE2DhnRHQk6zveArj8fPn8Bgm3PvGh8WgJLMRCjUcrUH3yfC4BGumMzc8QrDrxL1LvA7761gorvShL/ojJF6MP3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c82:b0:2f1:b5e0:2584 with SMTP id
 w2-20020a056e021c8200b002f1b5e02584mr10535323ill.302.1664214581620; Mon, 26
 Sep 2022 10:49:41 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:49:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7b82505e9982685@google.com>
Subject: [syzbot] kernel BUG in assertfail (2)
From:   syzbot <syzbot+c4614eae20a166c25bf0@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17e158d4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f9ca8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1174a66c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4614eae20a166c25bf0@syzkaller.appspotmail.com

BTRFS error (device loop0: state C): failed to load root csum
assertion failed: !tmp, in fs/btrfs/disk-io.c:1103
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3664!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3035 Comm: syz-executor102 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : assertfail+0x28/0x2c fs/btrfs/ctree.h:3663
lr : assertfail+0x28/0x2c fs/btrfs/ctree.h:3663
sp : ffff800012723650
x29: ffff800012723650 x28: 0000000000000000 x27: 000000000000000a
x26: 0000000000000000 x25: ffff0000c5f5c000 x24: ffff0000c5f59000
x23: 0000000000000000 x22: ffff0000c5f5c1f7 x21: ffff0000c9fa40a0
x20: ffff0000c5f5c000 x19: ffff0000c9fa4060 x18: 0000000000000111
x17: 0000000000000008 x16: ffff80000db49158 x15: ffff0000c94d8000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c94d8000
x11: ff808000081c1630 x10: 0000000000000000 x9 : b905ec291b4e1600
x8 : b905ec291b4e1600 x7 : ffff800008195d30 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000032
Call trace:
 assertfail+0x28/0x2c fs/btrfs/ctree.h:3663
 btrfs_global_root_delete+0x0/0x54 fs/btrfs/disk-io.c:1103
 load_global_roots_objectid+0x20c/0x460 fs/btrfs/disk-io.c:2467
 load_global_roots fs/btrfs/disk-io.c:2501 [inline]
 btrfs_read_roots+0x60/0x44c fs/btrfs/disk-io.c:2528
 init_tree_roots+0x310/0x474 fs/btrfs/disk-io.c:2939
 open_ctree+0x824/0xf84 fs/btrfs/disk-io.c:3574
 btrfs_fill_super+0xc0/0x174 fs/btrfs/super.c:1456
 btrfs_mount_root+0x4a4/0x558 fs/btrfs/super.c:1824
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 fc_mount fs/namespace.c:1043 [inline]
 vfs_kern_mount+0xe0/0x140 fs/namespace.c:1073
 btrfs_mount+0x20c/0x5e8 fs/btrfs/super.c:1884
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: f00063e2 911a0000 91147842 97fffbfd (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
