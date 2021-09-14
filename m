Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5E40A38E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhINC3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhINC3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:29:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7AC061574;
        Mon, 13 Sep 2021 19:28:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o8so4082324pll.1;
        Mon, 13 Sep 2021 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RKM6jJlu6aA9c6ac8wxI5pPuFXQbEQE3MlTWtSMVcps=;
        b=qxCZFwzSDlENlkDINDDJy4mgA/T9C/lA/Sd2ZFaM64PK92NBpfOfoaOvIecdmS8ojo
         5e3bShAbFaT5ouAlVbGMW95URahCQNOnuUGo2f+puajOV38/Nm/nvt6XWd4wzky55qYo
         Yf46NUQavh4/5LPgAxnX3lygEGSOrrJvahaKdnqSZ5m5gBpDz0yIfPq4JTTtaPuMjoOi
         OmgyuXlh9e42OCIHmTD4If91GRPSj62wY+0+hy3xXioZYdq1HrDZsATp+hmmN/lOuZVA
         KXm70oTsI8S0yHNscYW8QpSCBKcJaqXrAs29SJD4wVhiB8JhK66vkYInwMlxXTOT7SPq
         +uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RKM6jJlu6aA9c6ac8wxI5pPuFXQbEQE3MlTWtSMVcps=;
        b=yEHH9+FjbSIs93i+CW8ohqRoGQnFE/MPRvF4VK9K4qyGT5+kFPUqOj4jQkOS+M9oOQ
         CXEG/QwCWffeSXaGa8TllWWuSc028mmVx9eQgf7yCOkkpWr2iueye4mmRP3hv45XCW74
         +Mqb8lKNekz3Cf8QDJUAwimrL6QniLgO505c4BRjnjkvRnim6RQdi5564WvvWvIsd8fD
         nfsxNzyqs0x/9U7N2gIniN54ZI5BLNIHMIyIq4TKb/Ailf9BpSFxtLWhphJ3KUVLq2jC
         Ll/dbjKURww7r967Hv5mJuzJLf6tdaIK3vyXJAvU9scgLriSVdW7KJe9cFIldOklaCcL
         kPVw==
X-Gm-Message-State: AOAM532q6wKhUYNxZaeKjo3UakGEXVl1Nvhz3ly5PwJb0mFkHG25tuPm
        ATdb9dZ4ydvQ+DFxOdtN7qqXvnMeTygfYd+g0g==
X-Google-Smtp-Source: ABdhPJwl8rB2vV2NsVi5uzIr+GEbWC8nSczEjLHeIivYEBuDBy4Zzxh/zfzYbkTCfkkomUoJd4LHfFUHM8FaQ96n5KE=
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr2905615pjb.106.1631586500491;
 Mon, 13 Sep 2021 19:28:20 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:28:09 +0800
Message-ID: <CACkBjsZ9O6Zr0KK1yGn=1rQi6Crh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com>
Subject: WARNING: lock held when returning to user space in __btrfs_tree_lock
To:     clm@fb.com, dsahern@kernel.org, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/1BfaOcSWIkWUpQAgEj9p2zYVWsQxxacVl/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1HOZwnXJ42eEmVFS7n85zRcpXCFRHTFxi/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1-OULR4sFWY4qF4KvdLpehrlsZn9mMO7V/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop0: detected capacity change from 0 to 32768
BTRFS info (device loop0): disk space caching is enabled
BTRFS info (device loop0): has skinny extents
BTRFS info (device loop0): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x13c/0x160 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
 btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
 btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
 __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
 btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
 btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
 lookup_open+0x660/0x780 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x465/0xe20 fs/namei.c:3557
 do_filp_open+0xe3/0x170 fs/namei.c:3588
 do_sys_openat2+0x357/0x4a0 fs/open.c:1200
 do_sys_open+0x87/0xd0 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0

================================================
WARNING: lock held when returning to user space!
5.15.0-rc1 #16 Not tainted
------------------------------------------------
syz-executor/7579 is leaving the kernel with locks still held!
1 lock held by syz-executor/7579:
 #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
