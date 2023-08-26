Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95187895FC
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Aug 2023 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjHZK25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Aug 2023 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjHZK2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Aug 2023 06:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BD2102
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 03:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B60462561
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 10:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5F7C433C7
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693045709;
        bh=DQpEtBiKIF6VPHZ6NgeDZrBtd4xFdWEotWTZYrL79J4=;
        h=From:To:Subject:Date:From;
        b=TYB4c8Ds9+STxA3N+auxGIa0jvif3c2GLOyFXNpbB7foRwok03e6NTCZQYjD4aP4e
         dM+B1mLUoBy5+EtkxjS9PMaCV0TC/SXU292lSMpxg/eklIG/i8WIDndAVcvZ8TK45x
         PbAN091/xg/n+DcUUTqKhL1aNo1KdfFm1+wY8q0uCy+WEtPcf/2oWDHoohlwn+s6zf
         XKL9LgSmb5iT69Cyurgm9A2A2zvYRqj6HvAX1fMQS+mqOyLNq8WLNPxYV2QEMpwAT1
         5f3A2WCxdNNtCqteTOHB2bOJCCfxBNfRzHtkMul+zK2KfI3oSdG6uBX8cuXZIzV16U
         y/2kb3rH8N3tQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: release path before inode lookup during the ino lookup ioctl
Date:   Sat, 26 Aug 2023 11:28:20 +0100
Message-Id: <3433395cd3c3c880bf01392d07813d3677fd010e.1693045620.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During the ino lookup ioctl we can end up calling btrfs_iget() to get an
inode reference while we are holding on a root's btree. If btrfs_iget()
needs to lookup the inode from the root's btree, because it's not
currently loaded in memory, then it will need to lock another or the
same path in the same root btree. This may result in a deadlock and
trigger the following lockdep splat:

  WARNING: possible circular locking dependency detected
  6.5.0-rc7-syzkaller-00004-gf7757129e3de #0 Not tainted
  ------------------------------------------------------
  syz-executor277/5012 is trying to acquire lock:
  ffff88802df41710 (btrfs-tree-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  but task is already holding lock:
  ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (btrfs-tree-00){++++}-{3:3}:
         down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
         __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
         btrfs_search_slot+0x13a4/0x2f80 fs/btrfs/ctree.c:2302
         btrfs_init_root_free_objectid+0x148/0x320 fs/btrfs/disk-io.c:4955
         btrfs_init_fs_root fs/btrfs/disk-io.c:1128 [inline]
         btrfs_get_root_ref+0x5ae/0xae0 fs/btrfs/disk-io.c:1338
         btrfs_get_fs_root fs/btrfs/disk-io.c:1390 [inline]
         open_ctree+0x29c8/0x3030 fs/btrfs/disk-io.c:3494
         btrfs_fill_super+0x1c7/0x2f0 fs/btrfs/super.c:1154
         btrfs_mount_root+0x7e0/0x910 fs/btrfs/super.c:1519
         legacy_get_tree+0xef/0x190 fs/fs_context.c:611
         vfs_get_tree+0x8c/0x270 fs/super.c:1519
         fc_mount fs/namespace.c:1112 [inline]
         vfs_kern_mount+0xbc/0x150 fs/namespace.c:1142
         btrfs_mount+0x39f/0xb50 fs/btrfs/super.c:1579
         legacy_get_tree+0xef/0x190 fs/fs_context.c:611
         vfs_get_tree+0x8c/0x270 fs/super.c:1519
         do_new_mount+0x28f/0xae0 fs/namespace.c:3335
         do_mount fs/namespace.c:3675 [inline]
         __do_sys_mount fs/namespace.c:3884 [inline]
         __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
         do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  -> #0 (btrfs-tree-01){++++}-{3:3}:
         check_prev_add kernel/locking/lockdep.c:3142 [inline]
         check_prevs_add kernel/locking/lockdep.c:3261 [inline]
         validate_chain kernel/locking/lockdep.c:3876 [inline]
         __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
         lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
         down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
         __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
         btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
         btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
         btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
         btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
         btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
         btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
         btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
         btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
         btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
         btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
         vfs_ioctl fs/ioctl.c:51 [inline]
         __do_sys_ioctl fs/ioctl.c:870 [inline]
         __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
         do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  other info that might help us debug this:

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(btrfs-tree-00);
                                 lock(btrfs-tree-01);
                                 lock(btrfs-tree-00);
    rlock(btrfs-tree-01);

   *** DEADLOCK ***

  1 lock held by syz-executor277/5012:
   #0: ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

  stack backtrace:
  CPU: 1 PID: 5012 Comm: syz-executor277 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
   check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
   check_prev_add kernel/locking/lockdep.c:3142 [inline]
   check_prevs_add kernel/locking/lockdep.c:3261 [inline]
   validate_chain kernel/locking/lockdep.c:3876 [inline]
   __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
   lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
   down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
   __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
   btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
   btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
   btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
   btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
   btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
   btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
   btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
   btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
   btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
   btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f0bec94ea39

Fix this simply by releasing the path before calling btrfs_iget() as at
point we don't need the path anymore.

Reported-by: syzbot+bf66ad948981797d2f1d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000045fa140603c4a969@google.com/
Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a895d105464b..d27b0d86b8e2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1958,6 +1958,13 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
+			/*
+			 * We don't need the path anymore, so release it and
+			 * avoid deadlocks and lockdep warnings in case
+			 * btrfs_iget() needs to lookup the inode from its root
+			 * btree and lock the same leaf.
+			 */
+			btrfs_release_path(path);
 			temp_inode = btrfs_iget(sb, key2.objectid, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
@@ -1978,7 +1985,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
-			btrfs_release_path(path);
 			key.objectid = key.offset;
 			key.offset = (u64)-1;
 			dirid = key.objectid;
-- 
2.40.1

