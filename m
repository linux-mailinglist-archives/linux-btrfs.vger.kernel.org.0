Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC2624CEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 22:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKJVY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 16:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiKJVYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B949B5A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 13:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5A261E41
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 21:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35467C433C1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668115441;
        bh=Cte8IrHiUR8Az7DQcri6R4uvqwGkoYC0D2CDIbVAhIA=;
        h=From:To:Subject:Date:From;
        b=bHl/3tRkGBwNaT/cwa6WSbslbZ8E0ti+yZcHHG64k6dkhAksFwBEZgriuisB0ypYp
         FwaVS3DFEKjCay20Dj+3wUIcpNGUt+aKTb2JKsnvyyAsCBJdvjTEANy/zJEejl90XW
         BfU476iffEXS3ittMKegadzxkRSWFgOgKoq5esj5Bis47CCjxFC/3/ZiI1RZGCwM+K
         vuY+AWygaXvfonVVD5zPPnbx0thklblUL4z6HhlB/1JifX5S0LKQqiL/go7G18M0nH
         vrezhp8IIUzF8PF8E/K/MnRzZd9dwW5cgeCrvenFAxJOKz8n0POjz1fXWXx1X3l+3F
         lLJ5kTWhW7wRw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix assertion failure and blocking during nowait buffered write
Date:   Thu, 10 Nov 2022 21:23:58 +0000
Message-Id: <e5f881a2967503b956d025043815e5189dd5f13b.1668115418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a nowait buffered write we can trigger the following assertion:

[11138.437027] assertion failed: !path->nowait, in fs/btrfs/ctree.c:4658
[11138.438251] ------------[ cut here ]------------
[11138.438254] kernel BUG at fs/btrfs/messages.c:259!
[11138.438762] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
[11138.439450] CPU: 4 PID: 1091021 Comm: fsstress Not tainted 6.1.0-rc4-btrfs-next-128 #1
[11138.440611] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[11138.442553] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
[11138.443583] Code: 5b 41 5a 41 (...)
[11138.446437] RSP: 0018:ffffbaf0cf05b840 EFLAGS: 00010246
[11138.447235] RAX: 0000000000000039 RBX: ffffbaf0cf05b938 RCX: 0000000000000000
[11138.448303] RDX: 0000000000000000 RSI: ffffffffb2ef59f6 RDI: 00000000ffffffff
[11138.449370] RBP: ffff9165f581eb68 R08: 00000000ffffffff R09: 0000000000000001
[11138.450493] R10: ffff9167a88421f8 R11: 0000000000000000 R12: ffff9164981b1000
[11138.451661] R13: 000000008c8f1000 R14: ffff9164991d4000 R15: ffff9164981b1000
[11138.452225] FS:  00007f1438a66440(0000) GS:ffff9167ad600000(0000) knlGS:0000000000000000
[11138.452949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11138.453394] CR2: 00007f1438a64000 CR3: 0000000100c36002 CR4: 0000000000370ee0
[11138.454057] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[11138.454879] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[11138.455779] Call Trace:
[11138.456211]  <TASK>
[11138.456598]  btrfs_next_old_leaf.cold+0x18/0x1d [btrfs]
[11138.457827]  ? kmem_cache_alloc+0x18d/0x2a0
[11138.458516]  btrfs_lookup_csums_range+0x149/0x4d0 [btrfs]
[11138.459407]  csum_exist_in_range+0x56/0x110 [btrfs]
[11138.460271]  can_nocow_file_extent+0x27c/0x310 [btrfs]
[11138.461155]  can_nocow_extent+0x1ec/0x2e0 [btrfs]
[11138.461672]  btrfs_check_nocow_lock+0x114/0x1c0 [btrfs]
[11138.462951]  btrfs_buffered_write+0x44c/0x8e0 [btrfs]
[11138.463482]  btrfs_do_write_iter+0x42b/0x5f0 [btrfs]
[11138.463982]  ? lock_release+0x153/0x4a0
[11138.464347]  io_write+0x11b/0x570
[11138.464660]  ? lock_release+0x153/0x4a0
[11138.465213]  ? lock_is_held_type+0xe8/0x140
[11138.466003]  io_issue_sqe+0x63/0x4a0
[11138.466339]  io_submit_sqes+0x238/0x770
[11138.466741]  __do_sys_io_uring_enter+0x37b/0xb10
[11138.467206]  ? lock_is_held_type+0xe8/0x140
[11138.467879]  ? syscall_enter_from_user_mode+0x1d/0x50
[11138.468688]  do_syscall_64+0x38/0x90
[11138.469265]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[11138.470017] RIP: 0033:0x7f1438c539e6

This is because to check if we can NOCOW, we check that if we can NOCOW
into an extent (it's prealloc extent or the inode has NOCOW attribute),
and then check if there are csums for the extent's range in the csum tree.
The search may leave us beyond the last slot of a leaf, and then when
we call btrfs_next_leaf() we end up at btrfs_next_old_leaf() with a
time_seq of 0.

This triggers a failure of the first assertion at btrfs_next_old_leaf(),
since we have a nowait path. With assertions disabled, we simply don't
respect the NOWAIT semantics, allowing the write to block on locks or
blocking on IO for reading an extent buffer from disk.

Fix this by:

1) Triggering the assertion only if time_seq is not 0, which means that
   search is being done by a tree mod log user, and in the buffered and
   direct IO write paths we don't use the tree mod log;

2) Implementing NOWAIT semantics at btrfs_next_old_leaf(). Any failure to
   lock an extent buffer should return immediately and not retry the
   search if could not read an extent buffer from disk because it requires
   blocking on IO.

Fixes: c922b016f353 ("btrfs: assert nowait mode is not used for some btree search functions")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8443a2e42fd5..1ff8909b84a7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4655,7 +4655,12 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	int ret;
 	int i;
 
-	ASSERT(!path->nowait);
+	/*
+	 * The nowait semantics are used only for write paths, where we don't
+	 * use the tree mod log and sequence numbers.
+	 */
+	if (time_seq)
+		ASSERT(!path->nowait);
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	if (nritems == 0)
@@ -4751,8 +4756,11 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		next = c;
 		ret = read_block_for_search(root, path, &next, level,
 					    slot, &key);
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			if (path->nowait)
+				goto done;
 			goto again;
+		}
 
 		if (ret < 0) {
 			btrfs_release_path(path);
@@ -4761,6 +4769,10 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 
 		if (!path->skip_locking) {
 			ret = btrfs_try_tree_read_lock(next);
+			if (!ret && path->nowait) {
+				ret = -EAGAIN;
+				goto done;
+			}
 			if (!ret && time_seq) {
 				/*
 				 * If we don't get the lock, we may be racing
@@ -4791,8 +4803,11 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 
 		ret = read_block_for_search(root, path, &next, level,
 					    0, &key);
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			if (path->nowait)
+				goto done;
 			goto again;
+		}
 
 		if (ret < 0) {
 			btrfs_release_path(path);
-- 
2.35.1

