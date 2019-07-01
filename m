Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1055A6C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2019 00:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF1WLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 18:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfF1WLb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 18:11:31 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57FB2086D
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 22:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561759889;
        bh=mgpc6Ai0Cs5pVwrJQZI6UGhP5CyF2gcKiu+cs0g9Rms=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T/QkKAl/h/pP86WJEk+cnSlINIjJZ5fkt+P/ZKtVbKU0rT/3MfDvf2h/Cdh7GOYCk
         4yI7h+Q0X+7akNFHQ+QoL8HsikhqaWP3gXbPJKduGns3UwkHIK9kv1NrhZ9q6dqxnh
         LTZyZeunzrWhcjPTrnyHNJKpyRtOj66p3BnYwlh0=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] Btrfs: factor out extent dropping code from hole punch handler
Date:   Fri, 28 Jun 2019 23:11:26 +0100
Message-Id: <20190628221126.31353-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190627170031.6191-1-fdmanana@kernel.org>
References: <20190627170031.6191-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Move the code that is responsible for dropping extents in a range out of
btrfs_punch_hole() into a new helper function, btrfs_punch_hole_range(),
so that later it can be used by the reflinking (extent cloning and dedup)
code to fix a ENOSPC bug.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: No changes from V1, only the second patch in the series changed.

 fs/btrfs/file.c | 308 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 166 insertions(+), 142 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1c7533db16b0..393a6d23b6b0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2448,27 +2448,171 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 	return 0;
 }
 
+/*
+ * The respective range must have been previously locked, as well as the inode.
+ * The end offset is inclusive (last byte of the range).
+ */
+static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+				  const u64 start, const u64 end,
+				  struct btrfs_trans_handle **trans_out)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 min_size = btrfs_calc_trans_metadata_size(fs_info, 1);
+	u64 ino_size = round_up(inode->i_size, fs_info->sectorsize);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_trans_handle *trans = NULL;
+	struct btrfs_block_rsv *rsv;
+	unsigned int rsv_count;
+	u64 cur_offset;
+	u64 drop_end;
+	u64 len = end - start;
+	int ret = 0;
+
+	if (end <= start)
+		return -EINVAL;
+
+	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
+	if (!rsv) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	rsv->size = btrfs_calc_trans_metadata_size(fs_info, 1);
+	rsv->failfast = 1;
+
+	/*
+	 * 1 - update the inode
+	 * 1 - removing the extents in the range
+	 * 1 - adding the hole extent if no_holes isn't set
+	 */
+	rsv_count = btrfs_fs_incompat(fs_info, NO_HOLES) ? 2 : 3;
+	trans = btrfs_start_transaction(root, rsv_count);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		trans = NULL;
+		goto out_free;
+	}
+
+	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
+				      min_size, false);
+	BUG_ON(ret);
+	trans->block_rsv = rsv;
+
+	cur_offset = start;
+	while (cur_offset < end) {
+		ret = __btrfs_drop_extents(trans, root, inode, path,
+					   cur_offset, end + 1, &drop_end,
+					   1, 0, 0, NULL);
+		if (ret != -ENOSPC)
+			break;
+
+		trans->block_rsv = &fs_info->trans_block_rsv;
+
+		if (cur_offset < drop_end && cur_offset < ino_size) {
+			ret = fill_holes(trans, BTRFS_I(inode), path,
+					cur_offset, drop_end);
+			if (ret) {
+				/*
+				 * If we failed then we didn't insert our hole
+				 * entries for the area we dropped, so now the
+				 * fs is corrupted, so we must abort the
+				 * transaction.
+				 */
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
+		}
+
+		cur_offset = drop_end;
+
+		ret = btrfs_update_inode(trans, root, inode);
+		if (ret)
+			break;
+
+		btrfs_end_transaction(trans);
+		btrfs_btree_balance_dirty(fs_info);
+
+		trans = btrfs_start_transaction(root, rsv_count);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			trans = NULL;
+			break;
+		}
+
+		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
+					      rsv, min_size, false);
+		BUG_ON(ret);	/* shouldn't happen */
+		trans->block_rsv = rsv;
+
+		ret = find_first_non_hole(inode, &cur_offset, &len);
+		if (unlikely(ret < 0))
+			break;
+		if (ret && !len) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret)
+		goto out_trans;
+
+	trans->block_rsv = &fs_info->trans_block_rsv;
+	/*
+	 * If we are using the NO_HOLES feature we might have had already an
+	 * hole that overlaps a part of the region [lockstart, lockend] and
+	 * ends at (or beyond) lockend. Since we have no file extent items to
+	 * represent holes, drop_end can be less than lockend and so we must
+	 * make sure we have an extent map representing the existing hole (the
+	 * call to __btrfs_drop_extents() might have dropped the existing extent
+	 * map representing the existing hole), otherwise the fast fsync path
+	 * will not record the existence of the hole region
+	 * [existing_hole_start, lockend].
+	 */
+	if (drop_end <= end)
+		drop_end = end + 1;
+	/*
+	 * Don't insert file hole extent item if it's for a range beyond eof
+	 * (because it's useless) or if it represents a 0 bytes range (when
+	 * cur_offset == drop_end).
+	 */
+	if (cur_offset < ino_size && cur_offset < drop_end) {
+		ret = fill_holes(trans, BTRFS_I(inode), path,
+				cur_offset, drop_end);
+		if (ret) {
+			/* Same comment as above. */
+			btrfs_abort_transaction(trans, ret);
+			goto out_trans;
+		}
+	}
+
+out_trans:
+	if (!trans)
+		goto out_free;
+
+	trans->block_rsv = &fs_info->trans_block_rsv;
+	if (ret)
+		btrfs_end_transaction(trans);
+	else
+		*trans_out = trans;
+out_free:
+	btrfs_free_block_rsv(fs_info, rsv);
+out:
+	return ret;
+}
+
 static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
-	struct btrfs_block_rsv *rsv;
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	u64 lockstart;
 	u64 lockend;
 	u64 tail_start;
 	u64 tail_len;
 	u64 orig_start = offset;
-	u64 cur_offset;
-	u64 min_size = btrfs_calc_trans_metadata_size(fs_info, 1);
-	u64 drop_end;
 	int ret = 0;
-	int err = 0;
-	unsigned int rsv_count;
 	bool same_block;
-	bool no_holes = btrfs_fs_incompat(fs_info, NO_HOLES);
 	u64 ino_size;
 	bool truncated_block = false;
 	bool updated_inode = false;
@@ -2575,145 +2719,23 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out;
 	}
 
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	rsv->size = btrfs_calc_trans_metadata_size(fs_info, 1);
-	rsv->failfast = 1;
-
-	/*
-	 * 1 - update the inode
-	 * 1 - removing the extents in the range
-	 * 1 - adding the hole extent if no_holes isn't set
-	 */
-	rsv_count = no_holes ? 2 : 3;
-	trans = btrfs_start_transaction(root, rsv_count);
-	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
-		goto out_free;
-	}
-
-	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
-				      min_size, false);
-	BUG_ON(ret);
-	trans->block_rsv = rsv;
-
-	cur_offset = lockstart;
-	len = lockend - cur_offset;
-	while (cur_offset < lockend) {
-		ret = __btrfs_drop_extents(trans, root, inode, path,
-					   cur_offset, lockend + 1,
-					   &drop_end, 1, 0, 0, NULL);
-		if (ret != -ENOSPC)
-			break;
-
-		trans->block_rsv = &fs_info->trans_block_rsv;
-
-		if (cur_offset < drop_end && cur_offset < ino_size) {
-			ret = fill_holes(trans, BTRFS_I(inode), path,
-					cur_offset, drop_end);
-			if (ret) {
-				/*
-				 * If we failed then we didn't insert our hole
-				 * entries for the area we dropped, so now the
-				 * fs is corrupted, so we must abort the
-				 * transaction.
-				 */
-				btrfs_abort_transaction(trans, ret);
-				err = ret;
-				break;
-			}
-		}
-
-		cur_offset = drop_end;
-
-		ret = btrfs_update_inode(trans, root, inode);
-		if (ret) {
-			err = ret;
-			break;
-		}
-
-		btrfs_end_transaction(trans);
-		btrfs_btree_balance_dirty(fs_info);
-
-		trans = btrfs_start_transaction(root, rsv_count);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			trans = NULL;
-			break;
-		}
-
-		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
-					      rsv, min_size, false);
-		BUG_ON(ret);	/* shouldn't happen */
-		trans->block_rsv = rsv;
-
-		ret = find_first_non_hole(inode, &cur_offset, &len);
-		if (unlikely(ret < 0))
-			break;
-		if (ret && !len) {
-			ret = 0;
-			break;
-		}
-	}
-
-	if (ret) {
-		err = ret;
-		goto out_trans;
-	}
-
-	trans->block_rsv = &fs_info->trans_block_rsv;
-	/*
-	 * If we are using the NO_HOLES feature we might have had already an
-	 * hole that overlaps a part of the region [lockstart, lockend] and
-	 * ends at (or beyond) lockend. Since we have no file extent items to
-	 * represent holes, drop_end can be less than lockend and so we must
-	 * make sure we have an extent map representing the existing hole (the
-	 * call to __btrfs_drop_extents() might have dropped the existing extent
-	 * map representing the existing hole), otherwise the fast fsync path
-	 * will not record the existence of the hole region
-	 * [existing_hole_start, lockend].
-	 */
-	if (drop_end <= lockend)
-		drop_end = lockend + 1;
-	/*
-	 * Don't insert file hole extent item if it's for a range beyond eof
-	 * (because it's useless) or if it represents a 0 bytes range (when
-	 * cur_offset == drop_end).
-	 */
-	if (cur_offset < ino_size && cur_offset < drop_end) {
-		ret = fill_holes(trans, BTRFS_I(inode), path,
-				cur_offset, drop_end);
-		if (ret) {
-			/* Same comment as above. */
-			btrfs_abort_transaction(trans, ret);
-			err = ret;
-			goto out_trans;
-		}
-	}
-
-out_trans:
-	if (!trans)
-		goto out_free;
+	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, &trans);
+	btrfs_free_path(path);
+	if (ret)
+		goto out;
 
+	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
-
-	trans->block_rsv = &fs_info->trans_block_rsv;
 	ret = btrfs_update_inode(trans, root, inode);
 	updated_inode = true;
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
-out_free:
-	btrfs_free_path(path);
-	btrfs_free_block_rsv(fs_info, rsv);
 out:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 out_only_mutex:
-	if (!updated_inode && truncated_block && !ret && !err) {
+	if (!updated_inode && truncated_block && !ret) {
 		/*
 		 * If we only end up zeroing part of a page, we still need to
 		 * update the inode item, so that all the time fields are
@@ -2728,16 +2750,18 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		inode->i_ctime = now;
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
-			err = PTR_ERR(trans);
+			ret = PTR_ERR(trans);
 		} else {
-			err = btrfs_update_inode(trans, root, inode);
-			ret = btrfs_end_transaction(trans);
+			int ret2;
+
+			ret = btrfs_update_inode(trans, root, inode);
+			ret2 = btrfs_end_transaction(trans);
+			if (!ret)
+				ret = ret2;
 		}
 	}
 	inode_unlock(inode);
-	if (ret && !err)
-		err = ret;
-	return err;
+	return ret;
 }
 
 /* Helper structure to record which range is already reserved */
-- 
2.11.0

