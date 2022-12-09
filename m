Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82F1648007
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLIJTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 04:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLIJTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 04:19:43 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91562E97
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Dec 2022 01:19:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id l22-20020a05660227d600b006dfa191ca8aso1807927ios.20
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Dec 2022 01:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seze8zafSimQFws6rjLDlyArlrppdJnhF3uf7L6dJwk=;
        b=yBgR5H2YAvDtdlPBZBxHo6X6XjhiZ3bq9czKoqMyvizR0103tBInWScyu4gQkuxh7J
         h0h0RFy+RJVWAz0uJxyj7Lh4zN+bW6nqtdlsz4iJNMvl0mn+LTIVVBbf3LKc1KHvialf
         qM7Xh6M2ZhzvFXVkk9iGXnU8a/qzd/yaH4KjH3jOygJpsmIMgnQlUMnhP7VMpFHsG1bB
         O5z5vyer1tqstCpuWbdtJuSAIVi+9ZCBhKDnHt4DDF3FW/1L2xJXlHBGVmsWR8fnnc2e
         0sv9ADR3v3VNI+Aenj9Kxrv+Ukc+Uw1La5z3cWwW7sRKpCqdhtSDC4ekQ/dUsegNFvy/
         BJog==
X-Gm-Message-State: ANoB5pkj1ylQdws9/tj0TOA3aTfT8hGehRfop2SBg8aWuUofa5+BuVzO
        f+v6fy0Y/asH9L3V4e4UNyc1HrpTxmI207msWsvSnXCEv77m
X-Google-Smtp-Source: AA0mqf4/RoUJzMxY7mVXgahQtv4ZtxKoB0Lt9q2yZ+oQ7vVNICa1Lc6ZF3HdZOd8bXbihlasiKbZwHwCNudzbe6K1cJ7IzhkU8fA
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:0:b0:302:58d0:2510 with SMTP id
 u13-20020a92cccd000000b0030258d02510mr37704310ilq.27.1670577581429; Fri, 09
 Dec 2022 01:19:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 01:19:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f995905ef61a764@google.com>
Subject: [syzbot] KMSAN: uninit-value in longest_match
From:   syzbot <syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    30d2727189c5 kmsan: fix memcpy tests
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=117d38f5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2144983ada8b4f3
dashboard link: https://syzkaller.appspot.com/bug?extid=14d9e7602ebdf7ec0a60
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e8c2d419c2e/disk-30d27271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e8a728a72a9/vmlinux-30d27271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89f71c80c707/bzImage-30d27271.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in longest_match+0xc88/0x1220 lib/zlib_deflate/deflate.c:668
 longest_match+0xc88/0x1220 lib/zlib_deflate/deflate.c:668
 deflate_fast+0x1838/0x2280 lib/zlib_deflate/deflate.c:954
 zlib_deflate+0x1783/0x22b0 lib/zlib_deflate/deflate.c:410
 zlib_compress_pages+0xd34/0x1f90 fs/btrfs/zlib.c:178
 compression_compress_pages fs/btrfs/compression.c:77 [inline]
 btrfs_compress_pages+0x325/0x440 fs/btrfs/compression.c:1208
 compress_file_range+0x11ac/0x3510 fs/btrfs/inode.c:730
 async_cow_start+0x33/0xd0 fs/btrfs/inode.c:1458
 btrfs_work_helper+0x55a/0x990 fs/btrfs/async-thread.c:280
 process_one_work+0xb27/0x13e0 kernel/workqueue.c:2289
 worker_thread+0x1076/0x1d60 kernel/workqueue.c:2436
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Uninit was created at:
 __kmalloc_large_node+0x2f7/0x3a0 mm/slab_common.c:1106
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc_node+0x1d2/0x3c0 mm/slab_common.c:962
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0xbc/0x2d0 mm/util.c:581
 kvmalloc include/linux/slab.h:706 [inline]
 zlib_alloc_workspace+0x111/0x5e0 fs/btrfs/zlib.c:66
 alloc_workspace+0x329/0x5a0 fs/btrfs/compression.c:939
 btrfs_init_workspace_manager+0x11f/0x4d0 fs/btrfs/compression.c:982
 btrfs_init_compress+0x1f/0x30 fs/btrfs/compression.c:1249
 init_btrfs_fs+0x94/0x5f2 fs/btrfs/super.c:2736
 do_one_initcall+0x221/0x860 init/main.c:1303
 do_initcall_level+0x146/0x322 init/main.c:1376
 do_initcalls+0x11a/0x201 init/main.c:1392
 do_basic_setup+0x22/0x24 init/main.c:1411
 kernel_init_freeable+0x308/0x4d0 init/main.c:1631
 kernel_init+0x2b/0x7d0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

CPU: 0 PID: 3530 Comm: kworker/u4:7 Not tainted 6.1.0-rc8-syzkaller-64144-g30d2727189c5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: btrfs-delalloc btrfs_work_helper
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
