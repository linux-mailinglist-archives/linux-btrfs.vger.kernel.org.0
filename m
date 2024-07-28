Return-Path: <linux-btrfs+bounces-6802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115693E2B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BB2B2242B
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BD19415A;
	Sun, 28 Jul 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay8BVW6p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021B194149;
	Sun, 28 Jul 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128071; cv=none; b=GoF21XIVmFinbzLTU4D2wCXHeE/VS12rmZqKnQWqugaMn9dVVDiJLsVB024DyQVzUc70T2xkyseD4BXOg6iKCZtpuF3N5A2Bn8AgcZZKyBkJ3KrTy6q5gckYOAdccdjTFsWzmzARxJCCTRuENlguZ/Mmf8HhXM9F+2mflZiEIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128071; c=relaxed/simple;
	bh=fhsbGbt3TD6usMHXTbqsCGiiqRx7yufr0WIYnqXzu6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6U3uPpRvDNWANW33+vUVaBukn6FSQ1rnSxng5nD6mmhCzYZ5mlOy5hpnXXsZgYGATCSKSdAz8n5U+zlMHP20a64w7SFTl6FbjsHnnzfNgJ8LUnkps0xT05KOgrA2BPs5hj3A85WmcXtc4wfXrNFwNG1d0/gL5lKTsCV9LfEeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay8BVW6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F372C4AF07;
	Sun, 28 Jul 2024 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128070;
	bh=fhsbGbt3TD6usMHXTbqsCGiiqRx7yufr0WIYnqXzu6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ay8BVW6pIlqmWD/w4AcAOarxr7zZ+8pHJ2jN4iW4fuTQUiq7nJ5gxVCGg6ole332z
	 ka01PMHT11Q2Xn+arFYiBUYt7y1mAZyQh52Heyuk3e3eaEiqS/S6DFvvHik1hvNLL3
	 9hVUWfkNW4hnebZg+VUUVIY8QG9eoRGuN55zf4HCm+m0diyhqoAZzDDC+viF3xiQvN
	 Mc3Cpna6A8gnGsh9Fb9FeWVTLUWkJnMiGuGF+aJ/EUVdz0TwVlbv/fHSQfixeARCha
	 cKh2h5rrx9Kab3sZSechMkfH/T305x10YI2xk6OOZEAYcLJP0lq3P0OFCoEV65sU2G
	 Jyxceq2NJZeNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 24/27] btrfs: fix data race when accessing the last_trans field of a root
Date: Sat, 27 Jul 2024 20:53:07 -0400
Message-ID: <20240728005329.1723272-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ca84529a842f3a15a5f17beac6252aa11955923f ]

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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c       |  4 ++--
 fs/btrfs/ctree.h       | 10 ++++++++++
 fs/btrfs/defrag.c      |  2 +-
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/relocation.c  |  8 ++++----
 fs/btrfs/transaction.c |  8 ++++----
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ca372068226d5..8a791b648ac53 100644
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
@@ -551,7 +551,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-		trans->transid != root->last_trans);
+		trans->transid != btrfs_get_root_last_trans(root));
 
 	level = btrfs_header_level(buf);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c03c58246033b..b2e4b30b8fae9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -354,6 +354,16 @@ static inline void btrfs_set_root_last_log_commit(struct btrfs_root *root, int c
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
index 407ccec3e57ed..f664678c71d15 100644
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
index cabb558dbdaa8..3791813dc7b62 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -658,7 +658,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->state = 0;
 	RB_CLEAR_NODE(&root->rb_node);
 
-	root->last_trans = 0;
+	btrfs_set_root_last_trans(root, 0);
 	root->free_objectid = 0;
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
@@ -1010,7 +1010,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	log_root->last_trans = trans->transid;
+	btrfs_set_root_last_trans(log_root, trans->transid);
 	log_root->root_key.offset = btrfs_root_id(root);
 
 	inode_item = &log_root->root_item.inode;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa18..f2935252b981a 100644
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
index 3388c836b9a56..76117bb2c726c 100644
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


