Return-Path: <linux-btrfs+bounces-6067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D991DBF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0941C229EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31685956;
	Mon,  1 Jul 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuxkB/4U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2646436
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828117; cv=none; b=GSbrG/TXACRzhnldiTlDyv0GI1cVQjjfdX4jKUFav6fuVW0GzaegkP9ZcHVrgKEGoeRsFcn0jWvIy0UmEeqf+TlKdQEUmh80Q9xy1ARJL1IZSi1EUjDVxSvvxam5GYcsioMKXMt577uPl+ibP4DaaF0mjLZWqIJkfz/+YcqMA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828117; c=relaxed/simple;
	bh=FXU9IeiWu0y20dTG9XbxLZXW/gYnmKlHHgUd2R4+g+g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FD1U8mNK2TqOFfivGg8Q7Tnxk3q2FkXwlEkprWg168lw4+GyDeR8WgW4IWc+TDDjLXboeXxMADntB8F36xXcku10YEot27tu1s//AW99l2csFRTp9K3sA775F8yt7O2KqDVeuXOXnw3wu2tt5fA6196nP6kR33UlQYv1OFY+888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuxkB/4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497CCC116B1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719828116;
	bh=FXU9IeiWu0y20dTG9XbxLZXW/gYnmKlHHgUd2R4+g+g=;
	h=From:To:Subject:Date:From;
	b=RuxkB/4UNqIFtKPnPczsNVQVPkhgYcztTeDUoKlnH0HHpuwTfCpEHiOH5CSTntVfh
	 shXGCbeonLrP8u3ThAFl4xgrVinzFwgiQu1DlqcIcqE7e7pKi2sQvZ0SFK+6vTXjIQ
	 XvYqb10Puy9Lpv4oryxrwrsOsViHtxR20MayPXDv3x3tEvFwmobbllSOLP8Vi1hnIo
	 nd4CnD4ePchFDy/C4sia7X3kSwGFj3bJ6M13bC0K5IYjy/z0VqNolYTZH1xJguq1U9
	 69RJhWqFY7bjoYD1xEuqN1zfXi3cZX4z7gNxY/+rS8rH7r3CbQBUnGBDOeUx4DpfnF
	 4nySo9COoqFBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix data race when accessing the last_trans field of a root
Date: Mon,  1 Jul 2024 11:01:53 +0100
Message-Id: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

KCSAN complains about a data race when accessing the last_trans field of a
root:

  [  199.553628] BUG: KCSAN: data-race in btrfs_record_root_in_trans [btrfs] / record_root_in_trans [btrfs]

  [  199.555186] read to 0x000000008801e308 of 8 bytes by task 2812 on cpu 1:
  [  199.555210]  btrfs_record_root_in_trans+0x9a/0x128 [btrfs]
  [  199.555999]  start_transaction+0x154/0xcd8 [btrfs]
  [  199.556780]  btrfs_join_transaction+0x44/0x60 [btrfs]
  [  199.557559]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
  [  199.558339]  btrfs_update_time+0x8c/0xb0 [btrfs]
  [  199.559123]  touch_atime+0x16c/0x1e0
  [  199.559151]  pipe_read+0x6a8/0x7d0
  [  199.559179]  vfs_read+0x466/0x498
  [  199.559204]  ksys_read+0x108/0x150
  [  199.559230]  __s390x_sys_read+0x68/0x88
  [  199.559257]  do_syscall+0x1c6/0x210
  [  199.559286]  __do_syscall+0xc8/0xf0
  [  199.559318]  system_call+0x70/0x98

  [  199.559431] write to 0x000000008801e308 of 8 bytes by task 2808 on cpu 0:
  [  199.559464]  record_root_in_trans+0x196/0x228 [btrfs]
  [  199.560236]  btrfs_record_root_in_trans+0xfe/0x128 [btrfs]
  [  199.561097]  start_transaction+0x154/0xcd8 [btrfs]
  [  199.561927]  btrfs_join_transaction+0x44/0x60 [btrfs]
  [  199.562700]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
  [  199.563493]  btrfs_update_time+0x8c/0xb0 [btrfs]
  [  199.564277]  file_update_time+0xb8/0xf0
  [  199.564301]  pipe_write+0x8ac/0xab8
  [  199.564326]  vfs_write+0x33c/0x588
  [  199.564349]  ksys_write+0x108/0x150
  [  199.564372]  __s390x_sys_write+0x68/0x88
  [  199.564397]  do_syscall+0x1c6/0x210
  [  199.564424]  __do_syscall+0xc8/0xf0
  [  199.564452]  system_call+0x70/0x98

This is because we update and read last_trans concurrently without any
type of synchronization. This should be generally harmless and in the
worst case it can make us do extra locking (btrfs_record_root_in_trans())
trigger some warnings at ctree.c or do extra work during relocation - this
would probably only happen in case of load or store tearing.

So fix this by always reading and updating the field using READ_ONCE()
and WRITE_ONCE(), this silences KCSAN and prevents load and store tearing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       |  4 ++--
 fs/btrfs/ctree.h       | 10 ++++++++++
 fs/btrfs/defrag.c      |  2 +-
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/relocation.c  |  8 ++++----
 fs/btrfs/transaction.c |  8 ++++----
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e33f9f5a228d..451203055bbf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -321,7 +321,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-		trans->transid != root->last_trans);
+		trans->transid != btrfs_get_root_last_trans(root));
 
 	level = btrfs_header_level(buf);
 	if (level == 0)
@@ -556,7 +556,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-		trans->transid != root->last_trans);
+		trans->transid != btrfs_get_root_last_trans(root));
 
 	level = btrfs_header_level(buf);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1004cb934b4a..c8568b1a61c4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -356,6 +356,16 @@ static inline void btrfs_set_root_last_log_commit(struct btrfs_root *root, int c
 	WRITE_ONCE(root->last_log_commit, commit_id);
 }
 
+static inline u64 btrfs_get_root_last_trans(const struct btrfs_root *root)
+{
+	return READ_ONCE(root->last_trans);
+}
+
+static inline void btrfs_set_root_last_trans(struct btrfs_root *root, u64 transid)
+{
+	WRITE_ONCE(root->last_trans, transid);
+}
+
 /*
  * Structure that conveys information about an extent that is going to replace
  * all the extents in a file range.
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index e7a24f096cb6..f6dbda37a361 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -139,7 +139,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	if (trans)
 		transid = trans->transid;
 	else
-		transid = inode->root->last_trans;
+		transid = btrfs_get_root_last_trans(root);
 
 	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
 	if (!defrag)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5870e76d20e2..4f5c1ff72a7d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -654,7 +654,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->state = 0;
 	RB_CLEAR_NODE(&root->rb_node);
 
-	root->last_trans = 0;
+	btrfs_set_root_last_trans(root, 0);
 	root->free_objectid = 0;
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
@@ -998,7 +998,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	log_root->last_trans = trans->transid;
+	btrfs_set_root_last_trans(log_root, trans->transid);
 	log_root->root_key.offset = btrfs_root_id(root);
 
 	inode_item = &log_root->root_item.inode;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6ea407255a30..865e37b5354f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -817,7 +817,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		goto abort;
 	}
 	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
-	reloc_root->last_trans = trans->transid;
+	btrfs_set_root_last_trans(reloc_root, trans->transid);
 	return reloc_root;
 fail:
 	kfree(root_item);
@@ -864,7 +864,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	 */
 	if (root->reloc_root) {
 		reloc_root = root->reloc_root;
-		reloc_root->last_trans = trans->transid;
+		btrfs_set_root_last_trans(reloc_root, trans->transid);
 		return 0;
 	}
 
@@ -1739,7 +1739,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		 * btrfs_update_reloc_root() and update our root item
 		 * appropriately.
 		 */
-		reloc_root->last_trans = trans->transid;
+		btrfs_set_root_last_trans(reloc_root, trans->transid);
 		trans->block_rsv = rc->block_rsv;
 
 		replaced = 0;
@@ -2082,7 +2082,7 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root;
 	int ret;
 
-	if (reloc_root->last_trans == trans->transid)
+	if (btrfs_get_root_last_trans(reloc_root) == trans->transid)
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9590a1899b9d..e0490a6f068e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -405,7 +405,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-	    root->last_trans < trans->transid) || force) {
+	    btrfs_get_root_last_trans(root) < trans->transid) || force) {
 		WARN_ON(!force && root->commit_root != root->node);
 
 		/*
@@ -421,7 +421,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		smp_wmb();
 
 		spin_lock(&fs_info->fs_roots_radix_lock);
-		if (root->last_trans == trans->transid && !force) {
+		if (btrfs_get_root_last_trans(root) == trans->transid && !force) {
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			return 0;
 		}
@@ -429,7 +429,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 				   (unsigned long)btrfs_root_id(root),
 				   BTRFS_ROOT_TRANS_TAG);
 		spin_unlock(&fs_info->fs_roots_radix_lock);
-		root->last_trans = trans->transid;
+		btrfs_set_root_last_trans(root, trans->transid);
 
 		/* this is pretty tricky.  We don't want to
 		 * take the relocation lock in btrfs_record_root_in_trans
@@ -491,7 +491,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 	 * and barriers
 	 */
 	smp_rmb();
-	if (root->last_trans == trans->transid &&
+	if (btrfs_get_root_last_trans(root) == trans->transid &&
 	    !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
 		return 0;
 
-- 
2.43.0


