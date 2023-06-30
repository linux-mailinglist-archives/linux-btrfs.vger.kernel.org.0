Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03745743223
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 03:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF3BMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjF3BMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 21:12:52 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F0268F
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 18:12:49 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1b7dec879e6so8718985ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 18:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688087569; x=1690679569;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh9/ysT8WBXK2W6r2YSF4w2p4ZCI9O/CJf6g9+IlI4Y=;
        b=XXAl1wB0IMltzpOevVKig8mY3hXXjat8UEEP63sgnBGFM0/2VLoO51jur9UfXArWIj
         oYEl+9LvjuuP+YImPQpQhsMediCRrUyeJNIufGqA2rmlxXDd7G9cO9QY8cX5f2QQvJxe
         Bo5GynD6LfiEosWgtBWRhqCIXQYu5ua57x0cA3Uyj8rCis+a7T+EOBOdO7h27rT9Jx9q
         XwGcBrd1cahCCsnT+lYqARJ2NGPLwWQCsd0ZoKoAIvGAQkTZRfYY7QCo0zdN09cWGCbg
         FcCkPdSdn58Vb2ae4Sbqfp62mEiHXHzCFaJ+eDHjsRNcPLjA1lRAICEmSf8hLU+Z0ZgC
         7uBw==
X-Gm-Message-State: ABy/qLZQ6eJbcCPl4bDUW4P+5ecCf82lgVuR11JqRfISAMMdmwt21ZtP
        YjaaPUMDQEHuBWYC3wT7gP0vA0/OD56PmAmi6+yclqAnKDPi
X-Google-Smtp-Source: APBJJlHyDTRvjHTT3LjuTgzwmJmwSN53wbtn43XKF5qJs89OS8p4COy2sIr0xPZNQGz2FlRxKFHfMNKfzRW132vutD4Wytv1v7kk
MIME-Version: 1.0
X-Received: by 2002:a17:902:ecd0:b0:1b8:3fbd:9aed with SMTP id
 a16-20020a170902ecd000b001b83fbd9aedmr557439plh.3.1688087569220; Thu, 29 Jun
 2023 18:12:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 18:12:49 -0700
In-Reply-To: <00000000000053541905f9eb3439@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9cb8305ff4e8327@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in add_new_free_space
From:   syzbot <syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1434d99f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e95897d034d60fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba856e07b7127889d8c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f13920a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177d9efb280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53d4a5f0770f/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e95bdd1a8a6/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8890839e5fd6/Image-e40939bb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/512ce39b94e9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com

 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
------------[ cut here ]------------
kernel BUG at fs/btrfs/block-group.c:528!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6029 Comm: syz-executor128 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:528
lr : add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:528
sp : ffff800096f17440
x29: ffff800096f174e0 x28: 1ffff00012de2e94 x27: dfff800000000000
x26: 0000000000000001 x25: ffff0000de3c0190 x24: ffff800096f174a0
x23: 0000000000820000 x22: ffff800096f17480 x21: 0000000000000000
x20: 00000000007e0000 x19: 00000000fffffff4 x18: 1fffe000368447c6
x17: 0000000000000000 x16: ffff80008a443320 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c74f3780 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096f16978 x4 : ffff80008df9ee80 x3 : ffff800082cfd768
x2 : 0000000000000001 x1 : 00000000fffffff4 x0 : 0000000000000000
Call trace:
 add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:528
 btrfs_make_block_group+0x32c/0x858 fs/btrfs/block-group.c:2700
 create_chunk fs/btrfs/volumes.c:5440 [inline]
 btrfs_create_chunk+0x13a0/0x1e5c fs/btrfs/volumes.c:5526
 reserve_chunk_space+0x148/0x2a0 fs/btrfs/block-group.c:4083
 check_system_chunk fs/btrfs/block-group.c:4132 [inline]
 btrfs_inc_block_group_ro+0x4e8/0x570 fs/btrfs/block-group.c:2854
 scrub_enumerate_chunks+0x79c/0x1330 fs/btrfs/scrub.c:2536
 btrfs_scrub_dev+0x5f0/0xb84 fs/btrfs/scrub.c:2928
 btrfs_ioctl_scrub+0x1f4/0x3e8 fs/btrfs/ioctl.c:3177
 btrfs_ioctl+0x6a4/0xb08 fs/btrfs/ioctl.c:4626
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 956f741e 97875f26 d4210000 97875f24 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
