Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E312B0FF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKLVTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:23 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4DBC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:16 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so6917881qkf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7AyPt0fuetiXPMpbv4d2uI/rd1RqVjuAuaFFwdpDoaQ=;
        b=xyt0baioL/dHcHXwJ21efmg7kqkoTozWmlKzGBGeDCxRvizG5rO5bo+/DWhEq8Q8wQ
         aDPP6fVMWGJ6zesEdqF5sA8rUJdkuG6EykQKksGAiwk50A3ytaBccHQyhF1poe3PqmLe
         pZzIH8b9qK4UMI6LGYpAprU+2nCWt/9VGJwgwp5EH8ejwJnAWaDxqCPCRg6ZSLDqZ/IJ
         CscoWpBadl+2U8tFcu2wpgED1HyepHLdeUxatATKCObJYsNGrrGoJf32RzRuONAgZY3v
         FHAaBUYDyHFuTw5bd8Xok/O4VB1m4WR0wnlpYdxZCis9DGFle7+zBgQe84rYQgXeqiYj
         2TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AyPt0fuetiXPMpbv4d2uI/rd1RqVjuAuaFFwdpDoaQ=;
        b=O6UD1jCSxVa3xuUuxEbJZbYSSkSm/B+o2LS/A9fs8PMjnR5ITZnH25nSehao24dIwe
         BwGDYc/1i8Zi4SN3M9lPRxyOpV56tSLVE/nBQZVxWNhV1exJ1Hz5qhIxnNMTiQmEP9HG
         E0FPcMO+uXIjDR9++HuoX6qgueVkTQ3qE/oe2R7lVdoh5BEOi0zwGyhbVseWhCcDI++k
         yqnePFX1/N0L8U/coS57DJhD0oOGQoXAiyJLpgPaRJWYoXfnMcyBBV9AXeeo1OON70Gg
         2LOhM5S3tWbnMP2imp7i/2hyjn3XKMKpgEC5GgtLxMHQWuvR8ntKrhRW9sUJ0CHzV9D+
         xk5w==
X-Gm-Message-State: AOAM530ZdkXbidriqbg6SJ/xNooFAqxcrp+rlMn6Yw1qv5w27gSgFScL
        0f5+TIX10ytxBdlY3heoZ3McCvz/7EH5FQ==
X-Google-Smtp-Source: ABdhPJwnez2FbxIuXyHeiDIj72Hwponbhjo51PavESXttbziS0xHEv5eLZv2up99wuKwoB2qt7rU8w==
X-Received: by 2002:a37:7201:: with SMTP id n1mr1825342qkc.148.1605215955197;
        Thu, 12 Nov 2020 13:19:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k31sm5369549qtd.40.2020.11.12.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/42] btrfs: fix lockdep splat in btrfs_recover_relocation
Date:   Thu, 12 Nov 2020 16:18:29 -0500
Message-Id: <762a13cbf13687cbe23058c2fb37720da6b511bb.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing the error paths of relocation I hit the following lockdep
splat

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc2-btrfs-next-71 #1 Not tainted
------------------------------------------------------
find/324157 is trying to acquire lock:
ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

but task is already holding lock:
ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{3:3}:
       lock_acquire+0xd8/0x490
       down_write_nested+0x44/0x120
       __btrfs_tree_lock+0x27/0x120 [btrfs]
       btrfs_search_slot+0x2a3/0xc50 [btrfs]
       btrfs_insert_empty_items+0x58/0xa0 [btrfs]
       insert_with_overflow+0x44/0x110 [btrfs]
       btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
       btrfs_setxattr+0xd6/0x4c0 [btrfs]
       btrfs_setxattr_trans+0x68/0x100 [btrfs]
       __vfs_setxattr+0x66/0x80
       __vfs_setxattr_noperm+0x70/0x200
       vfs_setxattr+0x6b/0x120
       setxattr+0x125/0x240
       path_setxattr+0xba/0xd0
       __x64_sys_setxattr+0x27/0x30
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
       check_prev_add+0x91/0xc60
       __lock_acquire+0x1689/0x3130
       lock_acquire+0xd8/0x490
       down_read_nested+0x45/0x220
       __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
       btrfs_next_old_leaf+0x27d/0x580 [btrfs]
       btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
       iterate_dir+0x170/0x1c0
       __x64_sys_getdents64+0x83/0x140
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-00);
                               lock(btrfs-tree-01#2/3);
                               lock(btrfs-tree-00);
  lock(btrfs-tree-01#2/3);

 *** DEADLOCK ***

5 locks held by find/324157:
 #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
 #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterate_dir+0x52/0x1c0
 #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

stack backtrace:
CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack+0x8d/0xb5
 check_noncircular+0xff/0x110
 ? mark_lock.part.0+0x468/0xe90
 check_prev_add+0x91/0xc60
 __lock_acquire+0x1689/0x3130
 ? kvm_clock_read+0x14/0x30
 ? kvm_sched_clock_read+0x5/0x10
 lock_acquire+0xd8/0x490
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 down_read_nested+0x45/0x220
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 btrfs_next_old_leaf+0x27d/0x580 [btrfs]
 btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
 iterate_dir+0x170/0x1c0
 __x64_sys_getdents64+0x83/0x140
 ? filldir+0x1d0/0x1d0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is thankfully straightforward to fix, simply release the path
before we setup the reloc_ctl.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c927dc597550..a364d37d972e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4283,6 +4283,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
+	btrfs_release_path(path);
+
 	mutex_lock(&fs_info->balance_mutex);
 	BUG_ON(fs_info->balance_ctl);
 	spin_lock(&fs_info->balance_lock);
-- 
2.26.2

