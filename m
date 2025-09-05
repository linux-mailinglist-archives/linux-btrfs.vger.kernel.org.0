Return-Path: <linux-btrfs+bounces-16677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C286B45DA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7A1C80BF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A8369331;
	Fri,  5 Sep 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFVm7Ola"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07895306B16
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088671; cv=none; b=OVjnyQwDpx4sgnaCmWyWFCAEnRFM4XQrmF6tilpAOimSiZnbhlJVEvBonSBNLxVh7jNj4v1wN4lChWAlJLtIJyFbkOJLVior2SHmAqVELlSbn3KHqkf0vzyo7JK7PvvHu4jIo0oLhpmm+eb5dM9ktzYjnG8BSW9dHv3uf9KRIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088671; c=relaxed/simple;
	bh=i5Lmyj/Vwj/4IVORiyNHx43tFAy+B/qBcc7+IB27mfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ6AwBxPLjFEvLGbW5NOGFGtoaOnbQaJlc2CzOZcdAwUco3DrZuHq9zES/HXmgNFwbln2k//0Ss/+vQwmg5vrIEYzjuebS4VG/c31V34MEgLY6Z8Fx+cJAkr1iMJnJbbb1iqM9LPzSk0/i6TF6U9RrAN3xgKnTPOmw833Pmtm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFVm7Ola; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61986C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088670;
	bh=i5Lmyj/Vwj/4IVORiyNHx43tFAy+B/qBcc7+IB27mfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sFVm7Ola7HHVBDmhkiaoSKjXq3EEluMbpd3ULKabWQ2f/BeMdjhL9A2y0jVy81Ya0
	 T3tWyC9HF/q8sIf2rIZnNLhm3r9AWKtBIU7+2QFqLZeOhmFotaguHtaIUBAiFhZEyc
	 AoQA0imR+NLgSf6VNHWhfoWIq2hfRgfLDcAFrA1gyXJnLNxhs+s3lHlOIKLBTARnFd
	 NFJ5IueR6rPDtc1lbqthEcVIr+q/paFVNRTalPBI3qSEKefVwuadzVW+HFBOv9YJ13
	 3mwgiCSggwGfif3ymPudy0K2J5+WxgOcHCSNSDKZ2DTwWAdqcDjyxGE69oNckVlj7v
	 FwV2sLL5hu2ZA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 33/33] btrfs: dump detailed info and specific messages on log replay failures
Date: Fri,  5 Sep 2025 17:10:21 +0100
Message-ID: <f0623e4f3a69cd61238551c1e5b44fc31077db16.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently debugging log replay failures can be harder than needed, since
all we do now is abort a transaction, which gives us a line number, a
stack trace and an error code. But that is most of the times not enough
to give some clue about what went wrong. So add a new helper to abort
log replay and provide contextual information:

1) Dump the current leaf of the log tree being processed and print the
   slot we are currently at and the key at that slot;

2) Dump the current subvolume tree leaf if we have any;

3) Print the current stage of log replay;

4) Print the id of the subvolume root associated with the log tree we
   are currently processing (as we can have multiple);

5) Print some error message to mention what we were trying to do when we
   got an error.

Replace all transaction abort calls (btrfs_abort_transaction()) with the
new helper btrfs_abort_log_replay(), which besides dumping all that extra
information, it also aborts the current transaction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.h       |   2 +
 fs/btrfs/tree-log.c | 425 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 343 insertions(+), 84 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5f0b185a7f21..28bb52bc33f1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -104,6 +104,8 @@ enum {
 	BTRFS_FS_STATE_RO,
 	/* Track if a transaction abort has been reported on this filesystem */
 	BTRFS_FS_STATE_TRANS_ABORTED,
+	/* Track if log replay has failed. */
+	BTRFS_FS_STATE_LOG_REPLAY_ABORTED,
 	/*
 	 * Bio operations should be blocked on this filesystem because a source
 	 * or target device is being destroyed as part of a device replace
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 83b79023baae..f134f217a755 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -27,6 +27,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "orphan.h"
+#include "print-tree.h"
 #include "tree-checker.h"
 
 #define MAX_CONFLICT_INODES 10
@@ -167,6 +168,62 @@ struct walk_control {
 	struct btrfs_path *subvol_path;
 };
 
+static void do_abort_log_replay(struct walk_control *wc, const char *function,
+				unsigned int line, int error, const char *fmt, ...)
+{
+	struct btrfs_fs_info *fs_info = wc->trans->fs_info;
+	struct va_format vaf;
+	va_list args;
+
+	/*
+	 * Do nothing if we already aborted, to avoid dumping leaves again which
+	 * can be verbose. Further more, only the first call is useful since it
+	 * is where we have a problem. Note that we do not use the flag
+	 * BTRFS_FS_STATE_TRANS_ABORTED because log replay calls functions that
+	 * are outside of tree-log.c that can abort transactions (such as
+	 * btrfs_add_link() for example), so if that happens we still want to
+	 * dump all log replay specific information below.
+	 */
+	if (test_and_set_bit(BTRFS_FS_STATE_LOG_REPLAY_ABORTED, &fs_info->fs_state))
+		return;
+
+	btrfs_abort_transaction(wc->trans, error);
+
+	if (wc->subvol_path->nodes[0]) {
+		btrfs_crit(fs_info,
+			   "subvolume (root %llu) leaf currently being processed:",
+			   btrfs_root_id(wc->root));
+		btrfs_print_leaf(wc->subvol_path->nodes[0]);
+	}
+
+	if (wc->log_leaf) {
+		btrfs_crit(fs_info,
+	  "log tree (for root %llu) leaf currently being processed (slot %d key %llu %u %llu):",
+			   btrfs_root_id(wc->root), wc->log_slot,
+			   wc->log_key.objectid, wc->log_key.type, wc->log_key.offset);
+		btrfs_print_leaf(wc->log_leaf);
+	}
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+	   "log replay failed in %s:%u for root %llu, stage %d, with error %d: %pV",
+		   function, line, btrfs_root_id(wc->root), wc->stage, error, &vaf);
+
+	va_end(args);
+}
+
+/*
+ * Use this for aborting a transaction during log replay while we are down the
+ * call chain of replay_one_buffer(), so that we get a lot more useful
+ * information for debugging issues when compared to a plain call to
+ * btrfs_abort_transaction().
+ */
+#define btrfs_abort_log_replay(wc, error, fmt, args...) \
+	do_abort_log_replay((wc), __func__, __LINE__, (error), fmt, ##args)
+
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode,
 			   int inode_only,
@@ -452,7 +509,10 @@ static int overwrite_item(struct walk_control *wc)
 	/* Look for the key in the destination tree. */
 	ret = btrfs_search_slot(NULL, root, &wc->log_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		"failed to search subvolume tree for key (%llu %u %llu) root %llu",
+				       wc->log_key.objectid, wc->log_key.type,
+				       wc->log_key.offset, btrfs_root_id(root));
 		return ret;
 	}
 
@@ -472,7 +532,8 @@ static int overwrite_item(struct walk_control *wc)
 		}
 		src_copy = kmalloc(item_size, GFP_NOFS);
 		if (!src_copy) {
-			btrfs_abort_transaction(trans, -ENOMEM);
+			btrfs_abort_log_replay(wc, -ENOMEM,
+			       "failed to allocate memory for log leaf item");
 			return -ENOMEM;
 		}
 
@@ -556,7 +617,10 @@ static int overwrite_item(struct walk_control *wc)
 		else if (found_size < item_size)
 			btrfs_extend_item(trans, wc->subvol_path, item_size - found_size);
 	} else if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to insert item for key (%llu %u %llu)",
+				       wc->log_key.objectid, wc->log_key.type,
+				       wc->log_key.offset);
 		return ret;
 	}
 	dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
@@ -691,18 +755,19 @@ static noinline int replay_one_extent(struct walk_control *wc)
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
-		btrfs_abort_transaction(trans, -EUCLEAN);
-		btrfs_err(fs_info,
-		  "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
-			  found_type, btrfs_root_id(root), wc->log_key.objectid,
-			  wc->log_key.offset);
+		btrfs_abort_log_replay(wc, -EUCLEAN,
+		       "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
+				       found_type, btrfs_root_id(root),
+				       wc->log_key.objectid, wc->log_key.offset);
 		return -EUCLEAN;
 	}
 
 	inode = btrfs_iget_logging(wc->log_key.objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to get inode %llu for root %llu",
+				       wc->log_key.objectid, btrfs_root_id(root));
 		return ret;
 	}
 
@@ -743,7 +808,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	drop_args.path = wc->subvol_path;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to drop extents for inode %llu range [%llu, %llu) root %llu",
+				       wc->log_key.objectid, start, extent_end,
+				       btrfs_root_id(root));
 		goto out;
 	}
 
@@ -768,7 +836,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path,
 				      &wc->log_key, sizeof(*item));
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to insert item with key (%llu %u %llu) root %llu",
+				       wc->log_key.objectid, wc->log_key.type,
+				       wc->log_key.offset, btrfs_root_id(root));
 		goto out;
 	}
 	dest_offset = btrfs_item_ptr_offset(wc->subvol_path->nodes[0],
@@ -801,7 +872,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	 */
 	ret = btrfs_qgroup_trace_extent(trans, ins.objectid, ins.offset);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to trace extent for bytenr %llu disk_num_bytes %llu inode %llu root %llu",
+				       ins.objectid, ins.offset,
+				       wc->log_key.objectid, btrfs_root_id(root));
 		goto out;
 	}
 
@@ -811,7 +885,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	 */
 	ret = btrfs_lookup_data_extent(fs_info, ins.objectid, ins.offset);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to lookup data extent for bytenr %llu disk_num_bytes %llu inode %llu root %llu",
+				       ins.objectid, ins.offset,
+				       wc->log_key.objectid, btrfs_root_id(root));
 		goto out;
 	} else if (ret == 0) {
 		struct btrfs_ref ref = {
@@ -825,7 +902,11 @@ static noinline int replay_one_extent(struct walk_control *wc)
 		btrfs_init_data_ref(&ref, wc->log_key.objectid, offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+"failed to increment data extent for bytenr %llu disk_num_bytes %llu inode %llu root %llu",
+					       ins.objectid, ins.offset,
+					       wc->log_key.objectid,
+					       btrfs_root_id(root));
 			goto out;
 		}
 	} else {
@@ -833,7 +914,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 		ret = btrfs_alloc_logged_file_extent(trans, btrfs_root_id(root),
 						     wc->log_key.objectid, offset, &ins);
 		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+"failed to allocate logged data extent for bytenr %llu disk_num_bytes %llu offset %llu inode %llu root %llu",
+					       ins.objectid, ins.offset, offset,
+					       wc->log_key.objectid, btrfs_root_id(root));
 			goto out;
 		}
 	}
@@ -851,7 +935,10 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
 				      &ordered_sums, false);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to lookups csums for range [%llu, %llu) inode %llu root %llu",
+				       csum_start, csum_end, wc->log_key.objectid,
+				       btrfs_root_id(root));
 		goto out;
 	}
 	ret = 0;
@@ -909,12 +996,22 @@ static noinline int replay_one_extent(struct walk_control *wc)
 			ret = btrfs_del_csums(trans, csum_root, sums->logical,
 					      sums->len);
 			if (ret)
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+	       "failed to delete csums for range [%llu, %llu) inode %llu root %llu",
+						       sums->logical,
+						       sums->logical + sums->len,
+						       wc->log_key.objectid,
+						       btrfs_root_id(root));
 		}
 		if (!ret) {
 			ret = btrfs_csum_file_blocks(trans, csum_root, sums);
 			if (ret)
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+	       "failed to add csums for range [%llu, %llu) inode %llu root %llu",
+						       sums->logical,
+						       sums->logical + sums->len,
+						       wc->log_key.objectid,
+						       btrfs_root_id(root));
 		}
 		list_del(&sums->list);
 		kfree(sums);
@@ -925,14 +1022,19 @@ static noinline int replay_one_extent(struct walk_control *wc)
 update_inode:
 	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to set file extent range [%llu, %llu) inode %llu root %llu",
+				       start, extent_end, wc->log_key.objectid,
+				       btrfs_root_id(root));
 		goto out;
 	}
 
 	btrfs_update_inode_bytes(inode, nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret)
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to update inode %llu root %llu",
+				       wc->log_key.objectid, btrfs_root_id(root));
 out:
 	iput(&inode->vfs_inode);
 	return ret;
@@ -948,7 +1050,10 @@ static int unlink_inode_for_log_replay(struct walk_control *wc,
 
 	ret = btrfs_unlink_inode(trans, dir, inode, name);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to unlink inode %llu parent dir %llu name %.*s root %llu",
+				       btrfs_ino(inode), btrfs_ino(dir), name->len,
+				       name->name, btrfs_root_id(inode->root));
 		return ret;
 	}
 	/*
@@ -959,7 +1064,11 @@ static int unlink_inode_for_log_replay(struct walk_control *wc,
 	 */
 	ret = btrfs_run_delayed_items(trans);
 	if (ret)
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to run delayed items current inode %llu parent dir %llu name %.*s root %llu",
+				       btrfs_ino(inode), btrfs_ino(dir), name->len,
+				       name->name, btrfs_root_id(inode->root));
+
 	return ret;
 }
 
@@ -975,7 +1084,6 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 				      struct btrfs_inode *dir,
 				      struct btrfs_dir_item *di)
 {
-	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = dir->root;
 	struct btrfs_inode *inode;
 	struct fscrypt_str name;
@@ -986,7 +1094,9 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 	btrfs_dir_item_key_to_cpu(leaf, di, &location);
 	ret = read_alloc_one_name(leaf, di + 1, btrfs_dir_name_len(leaf, di), &name);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to allocate name for dir %llu root %llu",
+				       btrfs_ino(dir), btrfs_root_id(root));
 		return ret;
 	}
 
@@ -995,7 +1105,10 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 	inode = btrfs_iget_logging(location.objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to open inode %llu parent dir %llu name %.*s root %llu",
+				       location.objectid, btrfs_ino(dir),
+				       name.len, name.name, btrfs_root_id(root));
 		inode = NULL;
 		goto out;
 	}
@@ -1115,7 +1228,6 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 	ptr = btrfs_item_ptr_offset(leaf, wc->subvol_path->slots[0]);
 	ptr_end = ptr + btrfs_item_size(leaf, wc->subvol_path->slots[0]);
 	while (ptr < ptr_end) {
-		struct btrfs_trans_handle *trans = wc->trans;
 		struct fscrypt_str victim_name;
 		struct btrfs_inode_ref *victim_ref;
 		int ret;
@@ -1125,17 +1237,25 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 					  btrfs_inode_ref_name_len(leaf, victim_ref),
 					  &victim_name);
 		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+	       "failed to allocate name for inode %llu parent dir %llu root %llu",
+					       btrfs_ino(inode), btrfs_ino(dir),
+					       btrfs_root_id(inode->root));
 			return ret;
 		}
 
 		ret = backref_in_log(wc->log, search_key, btrfs_ino(dir), &victim_name);
 		if (ret) {
-			kfree(victim_name.name);
 			if (ret < 0) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+"failed to check if backref is in log tree for inode %llu parent dir %llu name %.*s root %llu",
+						       btrfs_ino(inode), btrfs_ino(dir),
+						       victim_name.len, victim_name.name,
+						       btrfs_root_id(inode->root));
+				kfree(victim_name.name);
 				return ret;
 			}
+			kfree(victim_name.name);
 			ptr = (unsigned long)(victim_ref + 1) + victim_name.len;
 			continue;
 		}
@@ -1164,7 +1284,6 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 	u32 cur_offset = 0;
 
 	while (cur_offset < item_size) {
-		struct btrfs_trans_handle *trans = wc->trans;
 		struct btrfs_root *log_root = wc->log;
 		struct btrfs_inode_extref *extref;
 		struct fscrypt_str victim_name;
@@ -1179,7 +1298,10 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 		ret = read_alloc_one_name(leaf, &extref->name, victim_name.len,
 					  &victim_name);
 		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+	       "failed to allocate name for inode %llu parent dir %llu root %llu",
+					       btrfs_ino(inode), btrfs_ino(dir),
+					       btrfs_root_id(inode->root));
 			return ret;
 		}
 
@@ -1190,11 +1312,16 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 						       victim_name.len);
 		ret = backref_in_log(log_root, search_key, btrfs_ino(dir), &victim_name);
 		if (ret) {
-			kfree(victim_name.name);
 			if (ret < 0) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+"failed to check if backref is in log tree for inode %llu parent dir %llu name %.*s root %llu",
+						       btrfs_ino(inode), btrfs_ino(dir),
+						       victim_name.len, victim_name.name,
+						       btrfs_root_id(inode->root));
+				kfree(victim_name.name);
 				return ret;
 			}
+			kfree(victim_name.name);
 next:
 			cur_offset += victim_name.len + sizeof(*extref);
 			continue;
@@ -1232,7 +1359,10 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	search_key.offset = btrfs_ino(dir);
 	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to search subvolume tree for key (%llu %u %llu) root %llu",
+				       search_key.objectid, search_key.type,
+				       search_key.offset, btrfs_root_id(root));
 		return ret;
 	} else if (ret == 0) {
 		/*
@@ -1269,7 +1399,10 @@ static inline int __add_inode_ref(struct walk_control *wc,
 					 ref_index, name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to lookup dir index item for dir %llu ref_index %llu name %.*s root %llu",
+				       btrfs_ino(dir), ref_index, name->len,
+				       name->name, btrfs_root_id(root));
 		return ret;
 	} else if (di) {
 		ret = drop_one_dir_item(wc, dir, di);
@@ -1282,7 +1415,10 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	di = btrfs_lookup_dir_item(trans, root, wc->subvol_path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	"failed to lookup dir item for dir %llu name %.*s root %llu",
+				       btrfs_ino(dir), name->len, name->name,
+				       btrfs_root_id(root));
 		return ret;
 	} else if (di) {
 		ret = drop_one_dir_item(wc, dir, di);
@@ -1344,7 +1480,6 @@ static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
  */
 static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *inode)
 {
-	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
 	int ret;
 	unsigned long ref_ptr;
@@ -1359,7 +1494,10 @@ static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *in
 		goto out;
 	}
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to search subvolume tree for key (%llu %u %llu) root %llu",
+				       wc->log_key.objectid, wc->log_key.type,
+				       wc->log_key.offset, btrfs_root_id(root));
 		goto out;
 	}
 
@@ -1374,14 +1512,20 @@ static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *in
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						NULL, &parent_id);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+			       "failed to get extref details for inode %llu root %llu",
+						       btrfs_ino(inode),
+						       btrfs_root_id(root));
 				goto out;
 			}
 		} else {
 			parent_id = wc->log_key.offset;
 			ret = ref_get_fields(eb, ref_ptr, &name, NULL);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+	       "failed to get ref details for inode %llu parent_id %llu root %llu",
+						       btrfs_ino(inode), parent_id,
+						       btrfs_root_id(root));
 				goto out;
 			}
 		}
@@ -1401,7 +1545,9 @@ static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *in
 			if (IS_ERR(dir)) {
 				ret = PTR_ERR(dir);
 				kfree(name.name);
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup dir inode %llu root %llu",
+						       parent_id, btrfs_root_id(root));
 				goto out;
 			}
 			ret = unlink_inode_for_log_replay(wc, dir, inode, &name);
@@ -1472,7 +1618,9 @@ static noinline int add_inode_ref(struct walk_control *wc)
 		if (ret == -ENOENT)
 			ret = 0;
 		else
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+			       "failed to lookup dir inode %llu root %llu",
+					       parent_objectid, btrfs_root_id(root));
 		dir = NULL;
 		goto out;
 	}
@@ -1480,7 +1628,9 @@ static noinline int add_inode_ref(struct walk_control *wc)
 	inode = btrfs_iget_logging(inode_objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup inode %llu root %llu",
+				       inode_objectid, btrfs_root_id(root));
 		inode = NULL;
 		goto out;
 	}
@@ -1490,7 +1640,10 @@ static noinline int add_inode_ref(struct walk_control *wc)
 			ret = extref_get_fields(wc->log_leaf, ref_ptr, &name,
 						&ref_index, &parent_objectid);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+			       "failed to get extref details for inode %llu root %llu",
+						       btrfs_ino(inode),
+						       btrfs_root_id(root));
 				goto out;
 			}
 			/*
@@ -1518,7 +1671,10 @@ static noinline int add_inode_ref(struct walk_control *wc)
 						ret = 0;
 						goto next;
 					} else {
-						btrfs_abort_transaction(trans, ret);
+						btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup dir inode %llu root %llu",
+								       parent_objectid,
+								       btrfs_root_id(root));
 					}
 					goto out;
 				}
@@ -1526,7 +1682,11 @@ static noinline int add_inode_ref(struct walk_control *wc)
 		} else {
 			ret = ref_get_fields(wc->log_leaf, ref_ptr, &name, &ref_index);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+	"failed to get ref details for inode %llu parent_objectid %llu root %llu",
+						       btrfs_ino(inode),
+						       parent_objectid,
+						       btrfs_root_id(root));
 				goto out;
 			}
 		}
@@ -1534,7 +1694,11 @@ static noinline int add_inode_ref(struct walk_control *wc)
 		ret = inode_in_dir(root, wc->subvol_path, btrfs_ino(dir),
 				   btrfs_ino(inode), ref_index, &name);
 		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+"failed to check if inode %llu is in dir %llu ref_index %llu name %.*s root %llu",
+					       btrfs_ino(inode), btrfs_ino(dir),
+					       ref_index, name.len, name.name,
+					       btrfs_root_id(root));
 			goto out;
 		} else if (ret == 0) {
 			/*
@@ -1554,13 +1718,21 @@ static noinline int add_inode_ref(struct walk_control *wc)
 			/* insert our name */
 			ret = btrfs_add_link(trans, dir, inode, &name, 0, ref_index);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+"failed to add link for inode %llu in dir %llu ref_index %llu name %.*s root %llu",
+						       btrfs_ino(inode),
+						       btrfs_ino(dir), ref_index,
+						       name.len, name.name,
+						       btrfs_root_id(root));
 				goto out;
 			}
 
 			ret = btrfs_update_inode(trans, inode);
 			if (ret) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+				       "failed to update inode %llu root %llu",
+						       btrfs_ino(inode),
+						       btrfs_root_id(root));
 				goto out;
 			}
 		}
@@ -1831,7 +2003,9 @@ static noinline int link_to_fixup_dir(struct walk_control *wc, u64 objectid)
 	inode = btrfs_iget_logging(objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup inode %llu root %llu",
+				       objectid, btrfs_root_id(root));
 		return ret;
 	}
 
@@ -1850,11 +2024,15 @@ static noinline int link_to_fixup_dir(struct walk_control *wc, u64 objectid)
 			inc_nlink(vfs_inode);
 		ret = btrfs_update_inode(trans, inode);
 		if (ret)
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+				       "failed to update inode %llu root %llu",
+					       objectid, btrfs_root_id(root));
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	} else {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to insert fixup item for inode %llu root %llu",
+				       objectid, btrfs_root_id(root));
 	}
 	iput(vfs_inode);
 
@@ -1959,14 +2137,18 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 	dir = btrfs_iget_logging(wc->log_key.objectid, root);
 	if (IS_ERR(dir)) {
 		ret = PTR_ERR(dir);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup dir inode %llu root %llu",
+				       wc->log_key.objectid, btrfs_root_id(root));
 		return ret;
 	}
 
 	ret = read_alloc_one_name(wc->log_leaf, di + 1,
 				  btrfs_dir_name_len(wc->log_leaf, di), &name);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+			       "failed to allocate name for dir %llu root %llu",
+				       btrfs_ino(dir), btrfs_root_id(root));
 		goto out;
 	}
 
@@ -1975,7 +2157,9 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 	ret = btrfs_lookup_inode(trans, root, wc->subvol_path, &log_key, 0);
 	btrfs_release_path(wc->subvol_path);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup inode %llu root %llu",
+				       log_key.objectid, btrfs_root_id(root));
 		goto out;
 	}
 	exists = (ret == 0);
@@ -1985,13 +2169,19 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 					   wc->log_key.objectid, &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to lookup dir item for dir %llu name %.*s root %llu",
+				       wc->log_key.objectid, name.len, name.name,
+				       btrfs_root_id(root));
 		goto out;
 	} else if (dir_dst_di) {
 		ret = delete_conflicting_dir_entry(wc, dir, dir_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+	       "failed to delete conflicting entry for dir %llu name %.*s root %llu",
+					       btrfs_ino(dir), name.len, name.name,
+					       btrfs_root_id(root));
 			goto out;
 		}
 		dir_dst_matches = (ret == 1);
@@ -2004,13 +2194,19 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 						   wc->log_key.offset, &name, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+	       "failed to lookup dir index item for dir %llu name %.*s root %llu",
+				       wc->log_key.objectid, name.len, name.name,
+				       btrfs_root_id(root));
 		goto out;
 	} else if (index_dst_di) {
 		ret = delete_conflicting_dir_entry(wc, dir, index_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+	       "failed to delete conflicting entry for dir %llu name %.*s root %llu",
+					       btrfs_ino(dir), name.len, name.name,
+					       btrfs_root_id(root));
 			goto out;
 		}
 		index_dst_matches = (ret == 1);
@@ -2033,7 +2229,10 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 	search_key.offset = wc->log_key.objectid;
 	ret = backref_in_log(root->log_root, &search_key, 0, &name);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to check if ref item is logged for inode %llu dir %llu name %.*s root %llu",
+				       search_key.objectid, btrfs_ino(dir),
+				       name.len, name.name, btrfs_root_id(root));
 	        goto out;
 	} else if (ret) {
 	        /* The dentry will be added later. */
@@ -2047,7 +2246,10 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 	search_key.offset = btrfs_extref_hash(wc->log_key.objectid, name.name, name.len);
 	ret = backref_in_log(root->log_root, &search_key, wc->log_key.objectid, &name);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+"failed to check if extref item is logged for inode %llu dir %llu name %.*s root %llu",
+				       search_key.objectid, btrfs_ino(dir),
+				       name.len, name.name, btrfs_root_id(root));
 		goto out;
 	} else if (ret) {
 		/* The dentry will be added later. */
@@ -2058,7 +2260,10 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 	ret = insert_one_name(trans, root, wc->log_key.objectid, wc->log_key.offset,
 			      &name, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to insert name %.*s for inode %llu dir %llu root %llu",
+				       name.len, name.name, log_key.objectid,
+				       btrfs_ino(dir), btrfs_root_id(root));
 		goto out;
 	}
 	if (!ret)
@@ -2071,7 +2276,9 @@ static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_it
 		btrfs_i_size_write(dir, dir->vfs_inode.i_size + name.len * 2);
 		ret = btrfs_update_inode(trans, dir);
 		if (ret)
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+				       "failed to update dir inode %llu root %llu",
+					       btrfs_ino(dir), btrfs_root_id(root));
 	}
 	kfree(name.name);
 	iput(&dir->vfs_inode);
@@ -2246,7 +2453,10 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to allocate name for dir %llu index %llu root %llu",
+				       btrfs_ino(dir), dir_key->offset,
+				       btrfs_root_id(root));
 		goto out;
 	}
 
@@ -2258,7 +2468,11 @@ static noinline int check_item_in_log(struct walk_control *wc,
 						     dir_key->offset, &name, 0);
 		if (IS_ERR(log_di)) {
 			ret = PTR_ERR(log_di);
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+	"failed to lookup dir index item for dir %llu index %llu name %.*s root %llu",
+					       btrfs_ino(dir), dir_key->offset,
+					       name.len, name.name,
+					       btrfs_root_id(root));
 			goto out;
 		} else if (log_di) {
 			/* The dentry exists in the log, we have nothing to do. */
@@ -2274,7 +2488,9 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		inode = NULL;
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+				       "failed to lookup inode %llu root %llu",
+				       location.objectid, btrfs_root_id(root));
 		goto out;
 	}
 
@@ -2311,7 +2527,7 @@ static int replay_xattr_deletes(struct walk_control *wc)
 
 	log_path = btrfs_alloc_path();
 	if (!log_path) {
-		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_abort_log_replay(wc, -ENOMEM, "failed to allocate path");
 		return -ENOMEM;
 	}
 
@@ -2321,7 +2537,9 @@ static int replay_xattr_deletes(struct walk_control *wc)
 again:
 	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+			       "failed to search xattrs for inode %llu root %llu",
+				       ino, btrfs_root_id(root));
 		goto out;
 	}
 process_leaf:
@@ -2351,7 +2569,9 @@ static int replay_xattr_deletes(struct walk_control *wc)
 			name = kmalloc(name_len, GFP_NOFS);
 			if (!name) {
 				ret = -ENOMEM;
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+				       "failed to allocate memory for name of length %u",
+						       name_len);
 				goto out;
 			}
 			read_extent_buffer(wc->subvol_path->nodes[0], name,
@@ -2368,14 +2588,20 @@ static int replay_xattr_deletes(struct walk_control *wc)
 				kfree(name);
 				if (IS_ERR(di)) {
 					ret = PTR_ERR(di);
-					btrfs_abort_transaction(trans, ret);
+					btrfs_abort_log_replay(wc, ret,
+		       "failed to lookup xattr with name %.*s for inode %llu root %llu",
+							       name_len, name, ino,
+							       btrfs_root_id(root));
 					goto out;
 				}
 				ASSERT(di);
 				ret = btrfs_delete_one_dir_name(trans, root,
 								wc->subvol_path, di);
 				if (ret) {
-					btrfs_abort_transaction(trans, ret);
+					btrfs_abort_log_replay(wc, ret,
+		       "failed to delete xattr with name %.*s for inode %llu root %llu",
+							       name_len, name, ino,
+							       btrfs_root_id(root));
 					goto out;
 				}
 				btrfs_release_path(wc->subvol_path);
@@ -2385,7 +2611,10 @@ static int replay_xattr_deletes(struct walk_control *wc)
 			kfree(name);
 			if (IS_ERR(log_di)) {
 				ret = PTR_ERR(log_di);
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+	"failed to lookup xattr in log tree with name %.*s for inode %llu root %llu",
+						       name_len, name, ino,
+						       btrfs_root_id(root));
 				goto out;
 			}
 			cur += this_len;
@@ -2398,7 +2627,9 @@ static int replay_xattr_deletes(struct walk_control *wc)
 	else if (ret == 0)
 		goto process_leaf;
 	else
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+			       "failed to get next leaf in subvolume root %llu",
+				       btrfs_root_id(root));
 out:
 	btrfs_free_path(log_path);
 	btrfs_release_path(wc->subvol_path);
@@ -2419,7 +2650,6 @@ static int replay_xattr_deletes(struct walk_control *wc)
 static noinline int replay_dir_deletes(struct walk_control *wc,
 				       u64 dirid, bool del_all)
 {
-	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
 	struct btrfs_root *log = (del_all ? NULL : wc->log);
 	u64 range_start;
@@ -2434,7 +2664,7 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 	dir_key.type = BTRFS_DIR_INDEX_KEY;
 	log_path = btrfs_alloc_path();
 	if (!log_path) {
-		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_abort_log_replay(wc, -ENOMEM, "failed to allocate path");
 		return -ENOMEM;
 	}
 
@@ -2449,7 +2679,9 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 		if (ret == -ENOENT)
 			ret = 0;
 		else
-			btrfs_abort_transaction(trans, ret);
+			btrfs_abort_log_replay(wc, ret,
+			       "failed to lookup dir inode %llu root %llu",
+					       dirid, btrfs_root_id(root));
 		return ret;
 	}
 
@@ -2462,7 +2694,9 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 			ret = find_dir_range(log, wc->subvol_path, dirid,
 					     &range_start, &range_end);
 			if (ret < 0) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+			       "failed to find range for dir %llu in log tree root %llu",
+						       dirid, btrfs_root_id(root));
 				goto out;
 			} else if (ret > 0) {
 				break;
@@ -2475,7 +2709,11 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 			ret = btrfs_search_slot(NULL, root, &dir_key,
 						wc->subvol_path, 0, 0);
 			if (ret < 0) {
-				btrfs_abort_transaction(trans, ret);
+				btrfs_abort_log_replay(wc, ret,
+			       "failed to search root %llu for key (%llu %u %llu)",
+						       btrfs_root_id(root),
+						       dir_key.objectid, dir_key.type,
+						       dir_key.offset);
 				goto out;
 			}
 
@@ -2485,7 +2723,9 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 				if (ret == 1) {
 					break;
 				} else if (ret < 0) {
-					btrfs_abort_transaction(trans, ret);
+					btrfs_abort_log_replay(wc, ret,
+				       "failed to get next leaf in subvolume root %llu",
+							       btrfs_root_id(root));
 					goto out;
 				}
 			}
@@ -2546,16 +2786,23 @@ static int replay_one_buffer(struct extent_buffer *eb,
 	if (level != 0)
 		return 0;
 
+	/*
+	 * Set to NULL since it was not yet read and in case we abort log replay
+	 * on error, we have no valid log tree leaf to dump.
+	 */
+	wc->log_leaf = NULL;
 	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret) {
-		btrfs_abort_transaction(trans, ret);
+		btrfs_abort_log_replay(wc, ret,
+		       "failed to read log tree leaf %llu for root %llu",
+				       eb->start, btrfs_root_id(root));
 		return ret;
 	}
 
 	ASSERT(wc->subvol_path == NULL);
 	wc->subvol_path = btrfs_alloc_path();
 	if (!wc->subvol_path) {
-		btrfs_abort_transaction(trans, -ENOMEM);
+		btrfs_abort_log_replay(wc, -ENOMEM, "failed to allocate path");
 		return -ENOMEM;
 	}
 
@@ -2631,7 +2878,10 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				inode = btrfs_iget_logging(wc->log_key.objectid, root);
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
-					btrfs_abort_transaction(trans, ret);
+					btrfs_abort_log_replay(wc, ret,
+					       "failed to lookup inode %llu root %llu",
+							       wc->log_key.objectid,
+							       btrfs_root_id(root));
 					break;
 				}
 				from = ALIGN(i_size_read(&inode->vfs_inode),
@@ -2642,14 +2892,21 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				drop_args.path = wc->subvol_path;
 				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
 				if (ret) {
-					btrfs_abort_transaction(trans, ret);
+					btrfs_abort_log_replay(wc, ret,
+		       "failed to drop extents for inode %llu root %llu offset %llu",
+							       btrfs_ino(inode),
+							       btrfs_root_id(root),
+							       from);
 				} else {
 					inode_sub_bytes(&inode->vfs_inode,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
 					ret = btrfs_update_inode(trans, inode);
 					if (ret)
-						btrfs_abort_transaction(trans, ret);
+						btrfs_abort_log_replay(wc, ret,
+					       "failed to update inode %llu root %llu",
+								       btrfs_ino(inode),
+								       btrfs_root_id(root));
 				}
 				iput(&inode->vfs_inode);
 				if (ret)
-- 
2.47.2


