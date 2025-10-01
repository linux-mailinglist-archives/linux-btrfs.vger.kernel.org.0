Return-Path: <linux-btrfs+bounces-17311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA837BB0321
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757F81884748
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5652D0607;
	Wed,  1 Oct 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2UOKfdA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94D2C3247
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318660; cv=none; b=TiAiuWhNurmBlO3R1hmgKnyUcxG2Webv+Ci7dG2wkqc2fckpKLZvjiYmHTdhfFefU5zMFpT/pbmw4oGVOgv7iWZqDi/x/EqQYZnxN45ZMaHl4IIvROVrRC6bj/OJ2+F9Z3VN/4vsd4w9TGNywZsGQzoaQrPvmyz0z6gDvu8xgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318660; c=relaxed/simple;
	bh=qPTzWn2yMTlMImvKkYxP4tPNKmyqAL225iXtfhxMhWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c0kmGXW4fWaglvYd2DeCLd76RxlRw2fTqplB2CJqnBKfsGw0x6UM8CZbusp5IB3PvE/nfPDGeZpTfBjnhxylYV1GWXCVAZkQgEK+kxCHPC6jnZ41bg63UhRHv9tku4XqA59uno++93M4SEflSF7esWvH9jzCP8hvF8pWbNJe2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2UOKfdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB57EC4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759318660;
	bh=qPTzWn2yMTlMImvKkYxP4tPNKmyqAL225iXtfhxMhWE=;
	h=From:To:Subject:Date:From;
	b=X2UOKfdAYSWajkqFvO9ha1M0kyYGhsuDwKuOLyPbHzGEVl7Z2ApeGF0cbOQmYorlY
	 jJnJLwC+IsE5sk5EPyNBnm+CpsFjF+VwGu9cYZlFMihefDIyz/eocLW6FkMwdQrA1s
	 gMAHXTV1sJRZ3iSH3RX2V6w2zatfLp9O4BEjmkZwg7ZP8k5SeKpTBSjIhqjPNXeyP9
	 asMaGU+uY0LMwOFl92HpQJu0f+3fZ+lPbsg2HV0XnDG6YlzhGbBYoh4UuJ/t2wcOK0
	 KFvuDCxNqOVGD8A35JIHlkQQpukya5/fMN4y0E74Zs0qbnp5gHu5O05AEVm7fnBM3O
	 O/mKMBwuyvoUg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not assert we found block group item when creating free space tree
Date: Wed,  1 Oct 2025 12:37:36 +0100
Message-ID: <b9e4f03c7e13d29156da0b2cbe7c55840e526fa0.1759318478.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently, when building a free space tree at populate_free_space_tree(),
if we are not using the block group tree feature, we always expect to find
block group items (either extent items or a block group item with key type
BTRFS_BLOCK_GROUP_ITEM_KEY) when we search the extent tree with
btrfs_search_slot_for_read(), so we assert that we found an item. However
this expectation is wrong since we can have a new block group created in
the current transaction which is still empty and for which we still have
not added the block group's item to the extent tree, in which case we do
not have any items in the extent tree associated to the block group.

The insertion of a new block group's block group item in the extent tree
happens at btrfs_create_pending_block_groups() when it calls the helper
insert_block_group_item(). This typically is done when a transaction
handle is released, committed or when running delayed refs (either as
part of a transaction commit or when serving tickets for space reservation
if we are low on free space).

So remove the assertion at populate_free_space_tree() even when the block
group tree feature is not enabled and update the comment to mention this
case.

Syzbot reported this with the following stack trace:

  BTRFS info (device loop3 state M): rebuilding free space tree
  assertion failed: ret == 0 :: 0, in fs/btrfs/free-space-tree.c:1115
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/free-space-tree.c:1115!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  CPU: 1 UID: 0 PID: 6352 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
  RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-tree.c:1115
  Code: ff ff e8 d3 (...)
  RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
  RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
  RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
  RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
  R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
  R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
  FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0
  Call Trace:
   <TASK>
   btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.c:1364
   btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
   btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
   btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
   reconfigure_super+0x227/0x890 fs/super.c:1076
   do_remount fs/namespace.c:3279 [inline]
   path_mount+0xd1a/0xfe0 fs/namespace.c:4027
   do_mount fs/namespace.c:4048 [inline]
   __do_sys_mount fs/namespace.c:4236 [inline]
   __se_sys_mount+0x313/0x410 fs/namespace.c:4213
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f424e39066a
  Code: d8 64 89 02 (...)
  RSP: 002b:00007f424d9fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
  RAX: ffffffffffffffda RBX: 00007f424d9fdef0 RCX: 00007f424e39066a
  RDX: 0000200000000180 RSI: 0000200000000380 RDI: 0000000000000000
  RBP: 0000200000000180 R08: 00007f424d9fdef0 R09: 0000000000000020
  R10: 0000000000000020 R11: 0000000000000246 R12: 0000200000000380
  R13: 00007f424d9fdeb0 R14: 0000000000000000 R15: 00002000000002c0
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---

Reported-by: syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/68dc3dab.a00a0220.102ee.004e.GAE@google.com/
Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
Cc: <stable@vger.kernel.org> # 6.1.x: 1961d20f6fa8: btrfs: fix assertion when building free space tree
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index b44e8a736cea..26e23c5b9d0c 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1100,14 +1100,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * If ret is 1 (no key found), it means this is an empty block group,
 	 * without any extents allocated from it and there's no block group
 	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
-	 * because we are using the block group tree feature, so block group
-	 * items are stored in the block group tree. It also means there are no
-	 * extents allocated for block groups with a start offset beyond this
-	 * block group's end offset (this is the last, highest, block group).
+	 * because we are using the block group tree feature (so block group
+	 * items are stored in the in the block group tree) or this is a new
+	 * block group created in the current transaction and its block group
+	 * item was not yet inserted in the extent tree (that happens in
+	 * btrfs_create_pending_block_groups() -> insert_block_group_item()).
+	 * It also means there are no extents allocated for block groups with a
+	 * start offset beyond this block group's end offset (this is the last,
+	 * highest, block group).
 	 */
-	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
-		ASSERT(ret == 0);
-
 	start = block_group->start;
 	end = block_group->start + block_group->length;
 	while (ret == 0) {
-- 
2.47.2


