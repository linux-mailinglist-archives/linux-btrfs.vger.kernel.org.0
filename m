Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8964E7B9FE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJEOan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjJEO3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 10:29:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F197172B7
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 00:10:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF7771F892
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696489822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zp0tl0Mu286By7LH87Frcc2tiB4/60kbnm3ZopMJcQo=;
        b=JE1ujXxqPyVgTccT/MZ+hT6sDBxGjepsW/6ICUtdlrcQRX7WS8Oeo2MDTLG6Lc+RG9DhRa
        Hk5BcNzzXCmABoTDpfpvKL5hUm2ZSfMaL2cuO5tf8b/kq/xKcTU3WmO1t7/zibb8reV59k
        jpE2VJa+EklBxhuqQcTZRobI7SYsn10=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 193D3139C2
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 07:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TU91Ml1hHmXhMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Oct 2023 07:10:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: introduce a basic metadata free space reservation check
Date:   Thu,  5 Oct 2023 17:40:04 +1030
Message-ID: <6081e57fe6f43b3ab44c883814c6a197513c66c0.1696489737.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike kernel, in btrfs-progs btrfs_start_transaction() never checks if
there is enough metadata space.

This can lead to very dangerous situation where there is no metadata
space left at all, deadlocking future tree operations.

This patch introuce a very basic version of metadata/system free space
check by:

- Check if there is enough metadata/system space left
  If there is enough, go as usual.

- If there is not enough space left, try allocating a new chunk

- Recheck if the new space can meet our demand
  If not, return ERR_PTR(-ENOSPC).
  Otherwise, allocate a new trans handle to the caller.

This is possible thanks to the simplified transaction model in
btrfs-progs:

- We don't allow joining a transaction
  This means we don't need to handle complex cases like data ordered
  extents, which needs to reserve space first, then join the current
  transaction and use the reserved blocks.

- We don't allow multiple trans handlers for one transaction
  Since btrfs-progs is single threaded, we always start a transaction
  and then commit it.

However there is a feature that must be an exception for the new
metadata/system free space check:

- btrfs check --init-extent-tree
  As all the meta/system free space check is based on the space info,
  which is loaded from block group items.
  Thus when rebuilding extent tree, we can no longer have an accurate
  view, thus we have to disable the feature for the whole execution if
  we're rebuilding the extent tree.

For now, there is no regression exposed during the self tests, but I
really hope this can be an extra safenet to prevent causing ENOSPC
deadlock from btrfs-progs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                |   9 +++
 kernel-shared/ctree.h       |   6 ++
 kernel-shared/extent-tree.c |  26 +++---
 kernel-shared/transaction.c | 156 ++++++++++++++++++++++++++++++++----
 4 files changed, 169 insertions(+), 28 deletions(-)

diff --git a/check/main.c b/check/main.c
index 22495452817f..8449c0b5973d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10286,6 +10286,15 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	if (init_extent_tree || init_csum_tree) {
 		struct btrfs_trans_handle *trans;
 
+		/*
+		 * If we're rebuilding extent tree, we must keep the flag
+		 * set for the whole duration of btrfs check.
+		 * As we rely on later extent tree check code to rebuild
+		 * block group items, thus we can no longer trust the
+		 * free space for metadata.
+		 */
+		if (init_extent_tree)
+			gfs_info->rebuilding_extent_tree = 1;
 		trans = btrfs_start_transaction(gfs_info->tree_root, 0);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c1bd7503c865..6a261dcadebd 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -376,6 +376,7 @@ struct btrfs_fs_info {
 	unsigned int hide_names:1;
 	unsigned int allow_transid_mismatch:1;
 	unsigned int skip_leaf_item_checks:1;
+	unsigned int rebuilding_extent_tree:1;
 
 	int transaction_aborted;
 
@@ -936,11 +937,16 @@ int btrfs_update_extent_ref(struct btrfs_trans_handle *trans,
 			    u64 root_objectid, u64 ref_generation,
 			    u64 owner_objectid);
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags);
 int update_space_info(struct btrfs_fs_info *info, u64 flags,
 		      u64 total_bytes, u64 bytes_used,
 		      struct btrfs_space_info **space_info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
+int btrfs_try_chunk_alloc(struct btrfs_trans_handle *trans,
+			  struct btrfs_fs_info *fs_info, u64 alloc_bytes,
+			  u64 flags);
 struct btrfs_block_group *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5f83ff5548e5..21a8a140290c 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1623,8 +1623,8 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
-static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
-						  u64 flags)
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags)
 {
 	struct btrfs_space_info *found;
 
@@ -1648,7 +1648,7 @@ static int free_space_info(struct btrfs_fs_info *fs_info, u64 flags,
 	if (bytes_used)
 		return -ENOTEMPTY;
 
-	found = __find_space_info(fs_info, flags);
+	found = btrfs_find_space_info(fs_info, flags);
 	if (!found)
 		return -ENOENT;
 	if (found->total_bytes < total_bytes) {
@@ -1669,7 +1669,7 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
 {
 	struct btrfs_space_info *found;
 
-	found = __find_space_info(info, flags);
+	found = btrfs_find_space_info(info, flags);
 	if (found) {
 		found->total_bytes += total_bytes;
 		found->bytes_used += bytes_used;
@@ -1715,7 +1715,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	}
 }
 
-static int do_chunk_alloc(struct btrfs_trans_handle *trans,
+int btrfs_try_chunk_alloc(struct btrfs_trans_handle *trans,
 			  struct btrfs_fs_info *fs_info, u64 alloc_bytes,
 			  u64 flags)
 {
@@ -1725,7 +1725,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 	u64 num_bytes;
 	int ret;
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	if (!space_info) {
 		ret = update_space_info(fs_info, flags, 0, 0, &space_info);
 		BUG_ON(ret);
@@ -2375,13 +2375,11 @@ int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID) {
 		if (!(profile & BTRFS_BLOCK_GROUP_METADATA)) {
-			ret = do_chunk_alloc(trans, info,
-					     num_bytes,
-					     BTRFS_BLOCK_GROUP_METADATA);
+			ret = btrfs_try_chunk_alloc(trans, info, num_bytes,
+						    BTRFS_BLOCK_GROUP_METADATA);
 			BUG_ON(ret);
 		}
-		ret = do_chunk_alloc(trans, info,
-				     num_bytes + SZ_2M, profile);
+		ret = btrfs_try_chunk_alloc(trans, info, num_bytes + SZ_2M, profile);
 		BUG_ON(ret);
 	}
 
@@ -2418,7 +2416,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	u64 start, end;
 	int ret;
 
-	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	ASSERT(sinfo);
 
 	ins.objectid = node->bytenr;
@@ -2516,7 +2514,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 	if (!extent_op)
 		return -ENOMEM;
 
-	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	if (!sinfo) {
 		error("Corrupted fs, no valid METADATA block group found");
 		return -EUCLEAN;
@@ -3706,7 +3704,7 @@ int cleanup_ref_head(struct btrfs_trans_handle *trans,
 		if (!head->is_data) {
 			struct btrfs_space_info *sinfo;
 
-			sinfo = __find_space_info(trans->fs_info,
+			sinfo = btrfs_find_space_info(trans->fs_info,
 					BTRFS_BLOCK_GROUP_METADATA);
 			ASSERT(sinfo);
 			sinfo->bytes_reserved -= head->num_bytes;
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index f86e1559e644..26f759b2f7e1 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -29,24 +29,69 @@
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/messages.h"
 
-struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
-						   unsigned int num_items)
+/*
+ * The metadata reservation code is completely different from the kernel by:
+ *
+ * - No need to support reclaim
+ * - No support for transaction join
+ *
+ * This is due to the fact that btrfs-progs is only single thread, thus it
+ * always starts a transaction, do some tree operations, and commit the
+ * transaction.
+ *
+ * So here we only need to make sure we have enough metadata space, and there
+ * will be no metadata over-commit (allowing extra metadata operations as long
+ * as there is unallocated space).
+ *
+ * The only extra step we can really do to increase metadata space is to allocate
+ * new metadata chunks.
+ */
+
+static unsigned int calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
+				     unsigned int num_items)
+{
+	return fs_info->nodesize * BTRFS_MAX_LEVEL * num_items * 2;
+}
+
+static bool meta_has_enough_space(struct btrfs_fs_info *fs_info,
+				  u64 profile, unsigned int size)
+{
+	struct btrfs_space_info *sinfo;
+
+	profile &= BTRFS_BLOCK_GROUP_TYPE_MASK;
+
+	/*
+	 * The fs is temporary (still during mkfs), do not check free space
+	 * as we don't have all meta/sys chunks setup.
+	 */
+	if (btrfs_super_magic(fs_info->super_copy) != BTRFS_MAGIC)
+		return true;
+
+	/*
+	 * The fs is under extent tree rebuilding, do not do any free space check
+	 * as they are not reliable.
+	 */
+	if (fs_info->rebuilding_extent_tree)
+		return true;
+
+	sinfo = btrfs_find_space_info(fs_info, profile);
+	if (!sinfo) {
+		error("unable to find block group for profile 0x%llx", profile);
+		return false;
+	}
+
+	if (sinfo->bytes_used + sinfo->bytes_pinned + sinfo->bytes_reserved +
+	    size < sinfo->total_bytes)
+		return true;
+	return false;
+}
+
+static struct btrfs_trans_handle *alloc_trans_handle(struct btrfs_root *root,
+						     unsigned int num_items)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *h;
 
-	if (fs_info->transaction_aborted)
-		return ERR_PTR(-EROFS);
-
-	if (root->commit_root) {
-		error("commit_root already set when starting transaction");
-		return ERR_PTR(-EINVAL);
-	}
-	if (fs_info->running_transaction) {
-		error("attempt to start transaction over already running one");
-		return ERR_PTR(-EINVAL);
-	}
-
 	h = kzalloc(sizeof(*h), GFP_NOFS);
 	if (!h)
 		return ERR_PTR(-ENOMEM);
@@ -66,6 +111,89 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 	return h;
 }
 
+struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
+						   unsigned int num_items)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_trans_handle *h;
+	unsigned int rsv_bytes;
+	bool need_retry = false;
+	u64 profile;
+
+	if (root->root_key.objectid == BTRFS_CHUNK_TREE_OBJECTID)
+		profile = BTRFS_BLOCK_GROUP_SYSTEM |
+			  (fs_info->avail_system_alloc_bits &
+			   fs_info->system_alloc_profile);
+	else
+		profile = BTRFS_BLOCK_GROUP_METADATA |
+			  (fs_info->avail_metadata_alloc_bits &
+			   fs_info->metadata_alloc_profile);
+
+	if (fs_info->transaction_aborted)
+		return ERR_PTR(-EROFS);
+
+	if (root->commit_root) {
+		error("commit_root already set when starting transaction");
+		return ERR_PTR(-EINVAL);
+	}
+	if (fs_info->running_transaction) {
+		error("attempt to start transaction over already running one");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * For those call sites, they are mostly delete items, in that case
+	 * just change it to 1.
+	 */
+	if (num_items == 0)
+		num_items = 1;
+
+	rsv_bytes = calc_insert_metadata_size(fs_info, num_items);
+
+	/*
+	 * We should not have so many items that it's larger than one metadata
+	 * chunk.
+	 */
+	if (rsv_bytes > SZ_1G) {
+		error("too much metadata space required: num_items %u reserved bytes %u",
+		      num_items, rsv_bytes);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!meta_has_enough_space(fs_info, profile, rsv_bytes))
+		need_retry = true;
+
+	h = alloc_trans_handle(root, num_items);
+	if (IS_ERR(h))
+		return ERR_PTR(PTR_ERR(h));
+
+	if (need_retry) {
+		int ret;
+
+		ret = btrfs_try_chunk_alloc(h, fs_info, rsv_bytes, profile);
+		if (ret < 0) {
+			btrfs_abort_transaction(h, ret);
+			errno = -ret;
+			error("failed to allocate new chunk: %m");
+			return ERR_PTR(ret);
+		}
+		ret = btrfs_commit_transaction(h, root);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to commit transaction for the new chunk: %m");
+			return ERR_PTR(ret);
+		}
+		if (!meta_has_enough_space(fs_info, profile, rsv_bytes)) {
+			errno = -ENOSPC;
+			error("failed to start transaction: %m");
+			return ERR_PTR(-ENOSPC);
+		}
+
+		h = alloc_trans_handle(root, num_items);
+	}
+	return h;
+}
+
 static int update_cowonly_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
-- 
2.42.0

