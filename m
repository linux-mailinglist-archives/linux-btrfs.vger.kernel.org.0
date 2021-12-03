Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7317467FC8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383380AbhLCWVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383375AbhLCWVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:49 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CDC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:25 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id q14so4836523qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RB4t9xLbGDhDjqgUyreo3pRFqHyScWHuy+U4/ANRGJ4=;
        b=WHRMqChA1Q0gLyKweYOM0ukzVqMTQ2p2UUipvqfRFyEEaQjJdHRDartdmTfx9uTTAC
         X67tTdneA/DtyFkwSPkOuRI3Cpqc7tVa00Xo7HZ0A7dpcnHuhN8JZUufqh8lpNXStcb1
         ++u6p+bIGMV986QeHSj1smg74d3EJWlUNX7QRDhbAE6ddXL3YXM4A+2pa55Hf8/Tv0no
         X0ODjebR/55PJ2Dnv5O6hqUHamOnSniRF6XDyuJxNRfRNMnrCxKTs64hw3ELxYOlT9sE
         DbuCODWKyqy/nKl4Ns0jMs5vsGMUZEx88t1Ai0lUXEtC7qZzLLNCEv+iZNwOfxPc8KOL
         O8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RB4t9xLbGDhDjqgUyreo3pRFqHyScWHuy+U4/ANRGJ4=;
        b=TkSWu16GGKcgfKj0798OgTiM9f54p3m8Y6Szzy36UiuNrEblYCroMGiDfpQrtuoD8O
         Hb3gz6o60vpTd+SoFa/o5ipKonc1IIN0xeMqybqVNo2tSkOUQBi4oNfS0FHawbwdTzDd
         MrDaSb/9+YzrhZoMl4p0/MM8gjqcIzcrtHpFXMfMMytzVnJyZWPSKXJU/GFJ8RWofSI+
         D1mwhv9ATchXTpcqFPccDoYDXzXjXLWbyJ36XxNFjWgMUov2w8LlzTVgnS5MRh6pSCtZ
         9DjK2vGGz1r+ztgupsud1QilwIunPFwQCRS57dq2Z8gDwm4KDxvnrrERR4Ib0E+Ov8Fg
         kWtg==
X-Gm-Message-State: AOAM533Smh2zsH+kAmZPIaL6PCmrRJHm6q6/j1L1Iu36fxm84f3s+c5u
        veKgYkhIjD3S9mp8abvU3d+6g3RA6K5z4Q==
X-Google-Smtp-Source: ABdhPJxv0T3gizEicm+0ODZlV+gUoF/UdYZ0Q24pCOneNh3K0DAFBfzgxLW7OkGAnLu+sm7jY6701w==
X-Received: by 2002:ac8:7dcd:: with SMTP id c13mr23920558qte.133.1638569903728;
        Fri, 03 Dec 2021 14:18:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp38sm2896021qkb.66.2021.12.03.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/18] btrfs: move btrfs_truncate_inode_items to inode-item.c
Date:   Fri,  3 Dec 2021 17:18:04 -0500
Message-Id: <036068f03e1d8a9a572e84198464f6de18eb8fe9.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an inode item related manipulation with a few vfs related
adjustments.  I'm going to remove the vfs related code from this helper
and simplify it a lot, but I want those changes to be easily seen via
git blame, so move this function now and then the simplification work
can be done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |   4 -
 fs/btrfs/inode-item.c | 377 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode-item.h |   9 +
 fs/btrfs/inode.c      | 391 +-----------------------------------------
 4 files changed, 390 insertions(+), 391 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f33cae82e7dd..02f06ee02e4e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3185,10 +3185,6 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
 int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			 int front);
-int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct btrfs_inode *inode, u64 new_size,
-			       u32 min_type, u64 *extents_found);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 72593a93c43c..6e4b244ce96c 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -418,3 +418,380 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
 	}
 	return ret;
 }
+
+/*
+ * Remove inode items from a given root.
+ *
+ * @trans:		A transaction handle.
+ * @root:		The root from which to remove items.
+ * @inode:		The inode whose items we want to remove.
+ * @new_size:		The new i_size for the inode. This is only applicable when
+ *			@min_type is BTRFS_EXTENT_DATA_KEY, must be 0 otherwise.
+ * @min_type:		The minimum key type to remove. All keys with a type
+ *			greater than this value are removed and all keys with
+ *			this type are removed only if their offset is >= @new_size.
+ * @extents_found:	Output parameter that will contain the number of file
+ *			extent items that were removed or adjusted to the new
+ *			inode i_size. The caller is responsible for initializing
+ *			the counter. Also, it can be NULL if the caller does not
+ *			need this counter.
+ *
+ * Remove all keys associated with the inode from the given root that have a key
+ * with a type greater than or equals to @min_type. When @min_type has a value of
+ * BTRFS_EXTENT_DATA_KEY, only remove file extent items that have an offset value
+ * greater than or equals to @new_size. If a file extent item that starts before
+ * @new_size and ends after it is found, its length is adjusted.
+ *
+ * Returns: 0 on success, < 0 on error and NEED_TRUNCATE_BLOCK when @min_type is
+ * BTRFS_EXTENT_DATA_KEY and the caller must truncate the last block.
+ */
+int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root,
+			       struct btrfs_inode *inode,
+			       u64 new_size, u32 min_type,
+			       u64 *extents_found)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	u64 extent_start = 0;
+	u64 extent_num_bytes = 0;
+	u64 extent_offset = 0;
+	u64 item_end = 0;
+	u64 last_size = new_size;
+	u32 found_type = (u8)-1;
+	int found_extent;
+	int del_item;
+	int pending_del_nr = 0;
+	int pending_del_slot = 0;
+	int extent_type = -1;
+	int ret;
+	u64 ino = btrfs_ino(inode);
+	u64 bytes_deleted = 0;
+	bool be_nice = false;
+	bool should_throttle = false;
+	const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
+	struct extent_state *cached_state = NULL;
+
+	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
+
+	/*
+	 * For non-free space inodes and non-shareable roots, we want to back
+	 * off from time to time.  This means all inodes in subvolume roots,
+	 * reloc roots, and data reloc roots.
+	 */
+	if (!btrfs_is_free_space_inode(inode) &&
+	    test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
+		be_nice = true;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+	path->reada = READA_BACK;
+
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		lock_extent_bits(&inode->io_tree, lock_start, (u64)-1,
+				 &cached_state);
+
+		/*
+		 * We want to drop from the next block forward in case this
+		 * new size is not block aligned since we will be keeping the
+		 * last block of the extent just the way it is.
+		 */
+		btrfs_drop_extent_cache(inode, ALIGN(new_size,
+					fs_info->sectorsize),
+					(u64)-1, 0);
+	}
+
+	/*
+	 * This function is also used to drop the items in the log tree before
+	 * we relog the inode, so if root != BTRFS_I(inode)->root, it means
+	 * it is used to drop the logged items. So we shouldn't kill the delayed
+	 * items.
+	 */
+	if (min_type == 0 && root == inode->root)
+		btrfs_kill_delayed_inode_items(inode);
+
+	key.objectid = ino;
+	key.offset = (u64)-1;
+	key.type = (u8)-1;
+
+search_again:
+	/*
+	 * with a 16K leaf size and 128MB extents, you can actually queue
+	 * up a huge file in a single leaf.  Most of the time that
+	 * bytes_deleted is > 0, it will be huge by the time we get here
+	 */
+	if (be_nice && bytes_deleted > SZ_32M &&
+	    btrfs_should_end_transaction(trans)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+
+	if (ret > 0) {
+		ret = 0;
+		/* there are no items in the tree for us to truncate, we're
+		 * done
+		 */
+		if (path->slots[0] == 0)
+			goto out;
+		path->slots[0]--;
+	}
+
+	while (1) {
+		u64 clear_start = 0, clear_len = 0;
+
+		fi = NULL;
+		leaf = path->nodes[0];
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		found_type = found_key.type;
+
+		if (found_key.objectid != ino)
+			break;
+
+		if (found_type < min_type)
+			break;
+
+		item_end = found_key.offset;
+		if (found_type == BTRFS_EXTENT_DATA_KEY) {
+			fi = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_extent_item);
+			extent_type = btrfs_file_extent_type(leaf, fi);
+			if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
+				item_end +=
+				    btrfs_file_extent_num_bytes(leaf, fi);
+
+				trace_btrfs_truncate_show_fi_regular(
+					inode, leaf, fi, found_key.offset);
+			} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+				item_end += btrfs_file_extent_ram_bytes(leaf,
+									fi);
+
+				trace_btrfs_truncate_show_fi_inline(
+					inode, leaf, fi, path->slots[0],
+					found_key.offset);
+			}
+			item_end--;
+		}
+		if (found_type > min_type) {
+			del_item = 1;
+		} else {
+			if (item_end < new_size)
+				break;
+			if (found_key.offset >= new_size)
+				del_item = 1;
+			else
+				del_item = 0;
+		}
+		found_extent = 0;
+		/* FIXME, shrink the extent if the ref count is only 1 */
+		if (found_type != BTRFS_EXTENT_DATA_KEY)
+			goto delete;
+
+		if (extents_found != NULL)
+			(*extents_found)++;
+
+		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
+			u64 num_dec;
+
+			clear_start = found_key.offset;
+			extent_start = btrfs_file_extent_disk_bytenr(leaf, fi);
+			if (!del_item) {
+				u64 orig_num_bytes =
+					btrfs_file_extent_num_bytes(leaf, fi);
+				extent_num_bytes = ALIGN(new_size -
+						found_key.offset,
+						fs_info->sectorsize);
+				clear_start = ALIGN(new_size, fs_info->sectorsize);
+				btrfs_set_file_extent_num_bytes(leaf, fi,
+							 extent_num_bytes);
+				num_dec = (orig_num_bytes -
+					   extent_num_bytes);
+				if (test_bit(BTRFS_ROOT_SHAREABLE,
+					     &root->state) &&
+				    extent_start != 0)
+					inode_sub_bytes(&inode->vfs_inode,
+							num_dec);
+				btrfs_mark_buffer_dirty(leaf);
+			} else {
+				extent_num_bytes =
+					btrfs_file_extent_disk_num_bytes(leaf,
+									 fi);
+				extent_offset = found_key.offset -
+					btrfs_file_extent_offset(leaf, fi);
+
+				/* FIXME blocksize != 4096 */
+				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
+				if (extent_start != 0) {
+					found_extent = 1;
+					if (test_bit(BTRFS_ROOT_SHAREABLE,
+						     &root->state))
+						inode_sub_bytes(&inode->vfs_inode,
+								num_dec);
+				}
+			}
+			clear_len = num_dec;
+		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+			/*
+			 * we can't truncate inline items that have had
+			 * special encodings
+			 */
+			if (!del_item &&
+			    btrfs_file_extent_encryption(leaf, fi) == 0 &&
+			    btrfs_file_extent_other_encoding(leaf, fi) == 0 &&
+			    btrfs_file_extent_compression(leaf, fi) == 0) {
+				u32 size = (u32)(new_size - found_key.offset);
+
+				btrfs_set_file_extent_ram_bytes(leaf, fi, size);
+				size = btrfs_file_extent_calc_inline_size(size);
+				btrfs_truncate_item(path, size, 1);
+			} else if (!del_item) {
+				/*
+				 * We have to bail so the last_size is set to
+				 * just before this extent.
+				 */
+				ret = BTRFS_NEED_TRUNCATE_BLOCK;
+				break;
+			} else {
+				/*
+				 * Inline extents are special, we just treat
+				 * them as a full sector worth in the file
+				 * extent tree just for simplicity sake.
+				 */
+				clear_len = fs_info->sectorsize;
+			}
+
+			if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
+				inode_sub_bytes(&inode->vfs_inode,
+						item_end + 1 - new_size);
+		}
+delete:
+		/*
+		 * We use btrfs_truncate_inode_items() to clean up log trees for
+		 * multiple fsyncs, and in this case we don't want to clear the
+		 * file extent range because it's just the log.
+		 */
+		if (root == inode->root) {
+			ret = btrfs_inode_clear_file_extent_range(inode,
+						  clear_start, clear_len);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
+		}
+
+		if (del_item)
+			last_size = found_key.offset;
+		else
+			last_size = new_size;
+		if (del_item) {
+			if (!pending_del_nr) {
+				/* no pending yet, add ourselves */
+				pending_del_slot = path->slots[0];
+				pending_del_nr = 1;
+			} else if (pending_del_nr &&
+				   path->slots[0] + 1 == pending_del_slot) {
+				/* hop on the pending chunk */
+				pending_del_nr++;
+				pending_del_slot = path->slots[0];
+			} else {
+				BUG();
+			}
+		} else {
+			break;
+		}
+		should_throttle = false;
+
+		if (found_extent &&
+		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+			struct btrfs_ref ref = { 0 };
+
+			bytes_deleted += extent_num_bytes;
+
+			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
+					extent_start, extent_num_bytes, 0);
+			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
+					ino, extent_offset,
+					root->root_key.objectid, false);
+			ret = btrfs_free_extent(trans, &ref);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
+			if (be_nice) {
+				if (btrfs_should_throttle_delayed_refs(trans))
+					should_throttle = true;
+			}
+		}
+
+		if (found_type == BTRFS_INODE_ITEM_KEY)
+			break;
+
+		if (path->slots[0] == 0 ||
+		    path->slots[0] != pending_del_slot ||
+		    should_throttle) {
+			if (pending_del_nr) {
+				ret = btrfs_del_items(trans, root, path,
+						pending_del_slot,
+						pending_del_nr);
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+					break;
+				}
+				pending_del_nr = 0;
+			}
+			btrfs_release_path(path);
+
+			/*
+			 * We can generate a lot of delayed refs, so we need to
+			 * throttle every once and a while and make sure we're
+			 * adding enough space to keep up with the work we are
+			 * generating.  Since we hold a transaction here we
+			 * can't flush, and we don't want to FLUSH_LIMIT because
+			 * we could have generated too many delayed refs to
+			 * actually allocate, so just bail if we're short and
+			 * let the normal reservation dance happen higher up.
+			 */
+			if (should_throttle) {
+				ret = btrfs_delayed_refs_rsv_refill(fs_info,
+							BTRFS_RESERVE_NO_FLUSH);
+				if (ret) {
+					ret = -EAGAIN;
+					break;
+				}
+			}
+			goto search_again;
+		} else {
+			path->slots[0]--;
+		}
+	}
+out:
+	if (ret >= 0 && pending_del_nr) {
+		int err;
+
+		err = btrfs_del_items(trans, root, path, pending_del_slot,
+				      pending_del_nr);
+		if (err) {
+			btrfs_abort_transaction(trans, err);
+			ret = err;
+		}
+	}
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		ASSERT(last_size >= new_size);
+		if (!ret && last_size > new_size)
+			last_size = new_size;
+		btrfs_inode_safe_disk_i_size_write(inode, last_size);
+		unlock_extent_cached(&inode->io_tree, lock_start, (u64)-1,
+				     &cached_state);
+	}
+
+	btrfs_free_path(path);
+	return ret;
+}
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index cb4b140e3b7d..63e8f45f110f 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -3,7 +3,16 @@
 #ifndef BTRFS_INODE_ITEM_H
 #define BTRFS_INODE_ITEM_H
 
+/*
+ * Return this if we need to call truncate_block for the last bit of the
+ * truncate.
+ */
+#define BTRFS_NEED_TRUNCATE_BLOCK 1
 
+int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root,
+			       struct btrfs_inode *inode, u64 new_size,
+			       u32 min_type, u64 *extents_found);
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   const char *name, int name_len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6ccdcf76b02f..c29e7c87ff27 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4616,389 +4616,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-/*
- * Return this if we need to call truncate_block for the last bit of the
- * truncate.
- */
-#define NEED_TRUNCATE_BLOCK 1
-
-/*
- * Remove inode items from a given root.
- *
- * @trans:		A transaction handle.
- * @root:		The root from which to remove items.
- * @inode:		The inode whose items we want to remove.
- * @new_size:		The new i_size for the inode. This is only applicable when
- *			@min_type is BTRFS_EXTENT_DATA_KEY, must be 0 otherwise.
- * @min_type:		The minimum key type to remove. All keys with a type
- *			greater than this value are removed and all keys with
- *			this type are removed only if their offset is >= @new_size.
- * @extents_found:	Output parameter that will contain the number of file
- *			extent items that were removed or adjusted to the new
- *			inode i_size. The caller is responsible for initializing
- *			the counter. Also, it can be NULL if the caller does not
- *			need this counter.
- *
- * Remove all keys associated with the inode from the given root that have a key
- * with a type greater than or equals to @min_type. When @min_type has a value of
- * BTRFS_EXTENT_DATA_KEY, only remove file extent items that have an offset value
- * greater than or equals to @new_size. If a file extent item that starts before
- * @new_size and ends after it is found, its length is adjusted.
- *
- * Returns: 0 on success, < 0 on error and NEED_TRUNCATE_BLOCK when @min_type is
- * BTRFS_EXTENT_DATA_KEY and the caller must truncate the last block.
- */
-int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct btrfs_inode *inode,
-			       u64 new_size, u32 min_type,
-			       u64 *extents_found)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
-	struct btrfs_key key;
-	struct btrfs_key found_key;
-	u64 extent_start = 0;
-	u64 extent_num_bytes = 0;
-	u64 extent_offset = 0;
-	u64 item_end = 0;
-	u64 last_size = new_size;
-	u32 found_type = (u8)-1;
-	int found_extent;
-	int del_item;
-	int pending_del_nr = 0;
-	int pending_del_slot = 0;
-	int extent_type = -1;
-	int ret;
-	u64 ino = btrfs_ino(inode);
-	u64 bytes_deleted = 0;
-	bool be_nice = false;
-	bool should_throttle = false;
-	const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
-	struct extent_state *cached_state = NULL;
-
-	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
-
-	/*
-	 * For non-free space inodes and non-shareable roots, we want to back
-	 * off from time to time.  This means all inodes in subvolume roots,
-	 * reloc roots, and data reloc roots.
-	 */
-	if (!btrfs_is_free_space_inode(inode) &&
-	    test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-		be_nice = true;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-	path->reada = READA_BACK;
-
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		lock_extent_bits(&inode->io_tree, lock_start, (u64)-1,
-				 &cached_state);
-
-		/*
-		 * We want to drop from the next block forward in case this
-		 * new size is not block aligned since we will be keeping the
-		 * last block of the extent just the way it is.
-		 */
-		btrfs_drop_extent_cache(inode, ALIGN(new_size,
-					fs_info->sectorsize),
-					(u64)-1, 0);
-	}
-
-	/*
-	 * This function is also used to drop the items in the log tree before
-	 * we relog the inode, so if root != BTRFS_I(inode)->root, it means
-	 * it is used to drop the logged items. So we shouldn't kill the delayed
-	 * items.
-	 */
-	if (min_type == 0 && root == inode->root)
-		btrfs_kill_delayed_inode_items(inode);
-
-	key.objectid = ino;
-	key.offset = (u64)-1;
-	key.type = (u8)-1;
-
-search_again:
-	/*
-	 * with a 16K leaf size and 128MB extents, you can actually queue
-	 * up a huge file in a single leaf.  Most of the time that
-	 * bytes_deleted is > 0, it will be huge by the time we get here
-	 */
-	if (be_nice && bytes_deleted > SZ_32M &&
-	    btrfs_should_end_transaction(trans)) {
-		ret = -EAGAIN;
-		goto out;
-	}
-
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret < 0)
-		goto out;
-
-	if (ret > 0) {
-		ret = 0;
-		/* there are no items in the tree for us to truncate, we're
-		 * done
-		 */
-		if (path->slots[0] == 0)
-			goto out;
-		path->slots[0]--;
-	}
-
-	while (1) {
-		u64 clear_start = 0, clear_len = 0;
-
-		fi = NULL;
-		leaf = path->nodes[0];
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-		found_type = found_key.type;
-
-		if (found_key.objectid != ino)
-			break;
-
-		if (found_type < min_type)
-			break;
-
-		item_end = found_key.offset;
-		if (found_type == BTRFS_EXTENT_DATA_KEY) {
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
-			extent_type = btrfs_file_extent_type(leaf, fi);
-			if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
-				item_end +=
-				    btrfs_file_extent_num_bytes(leaf, fi);
-
-				trace_btrfs_truncate_show_fi_regular(
-					inode, leaf, fi, found_key.offset);
-			} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-				item_end += btrfs_file_extent_ram_bytes(leaf,
-									fi);
-
-				trace_btrfs_truncate_show_fi_inline(
-					inode, leaf, fi, path->slots[0],
-					found_key.offset);
-			}
-			item_end--;
-		}
-		if (found_type > min_type) {
-			del_item = 1;
-		} else {
-			if (item_end < new_size)
-				break;
-			if (found_key.offset >= new_size)
-				del_item = 1;
-			else
-				del_item = 0;
-		}
-		found_extent = 0;
-		/* FIXME, shrink the extent if the ref count is only 1 */
-		if (found_type != BTRFS_EXTENT_DATA_KEY)
-			goto delete;
-
-		if (extents_found != NULL)
-			(*extents_found)++;
-
-		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
-			u64 num_dec;
-
-			clear_start = found_key.offset;
-			extent_start = btrfs_file_extent_disk_bytenr(leaf, fi);
-			if (!del_item) {
-				u64 orig_num_bytes =
-					btrfs_file_extent_num_bytes(leaf, fi);
-				extent_num_bytes = ALIGN(new_size -
-						found_key.offset,
-						fs_info->sectorsize);
-				clear_start = ALIGN(new_size, fs_info->sectorsize);
-				btrfs_set_file_extent_num_bytes(leaf, fi,
-							 extent_num_bytes);
-				num_dec = (orig_num_bytes -
-					   extent_num_bytes);
-				if (test_bit(BTRFS_ROOT_SHAREABLE,
-					     &root->state) &&
-				    extent_start != 0)
-					inode_sub_bytes(&inode->vfs_inode,
-							num_dec);
-				btrfs_mark_buffer_dirty(leaf);
-			} else {
-				extent_num_bytes =
-					btrfs_file_extent_disk_num_bytes(leaf,
-									 fi);
-				extent_offset = found_key.offset -
-					btrfs_file_extent_offset(leaf, fi);
-
-				/* FIXME blocksize != 4096 */
-				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
-				if (extent_start != 0) {
-					found_extent = 1;
-					if (test_bit(BTRFS_ROOT_SHAREABLE,
-						     &root->state))
-						inode_sub_bytes(&inode->vfs_inode,
-								num_dec);
-				}
-			}
-			clear_len = num_dec;
-		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-			/*
-			 * we can't truncate inline items that have had
-			 * special encodings
-			 */
-			if (!del_item &&
-			    btrfs_file_extent_encryption(leaf, fi) == 0 &&
-			    btrfs_file_extent_other_encoding(leaf, fi) == 0 &&
-			    btrfs_file_extent_compression(leaf, fi) == 0) {
-				u32 size = (u32)(new_size - found_key.offset);
-
-				btrfs_set_file_extent_ram_bytes(leaf, fi, size);
-				size = btrfs_file_extent_calc_inline_size(size);
-				btrfs_truncate_item(path, size, 1);
-			} else if (!del_item) {
-				/*
-				 * We have to bail so the last_size is set to
-				 * just before this extent.
-				 */
-				ret = NEED_TRUNCATE_BLOCK;
-				break;
-			} else {
-				/*
-				 * Inline extents are special, we just treat
-				 * them as a full sector worth in the file
-				 * extent tree just for simplicity sake.
-				 */
-				clear_len = fs_info->sectorsize;
-			}
-
-			if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-				inode_sub_bytes(&inode->vfs_inode,
-						item_end + 1 - new_size);
-		}
-delete:
-		/*
-		 * We use btrfs_truncate_inode_items() to clean up log trees for
-		 * multiple fsyncs, and in this case we don't want to clear the
-		 * file extent range because it's just the log.
-		 */
-		if (root == inode->root) {
-			ret = btrfs_inode_clear_file_extent_range(inode,
-						  clear_start, clear_len);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				break;
-			}
-		}
-
-		if (del_item)
-			last_size = found_key.offset;
-		else
-			last_size = new_size;
-		if (del_item) {
-			if (!pending_del_nr) {
-				/* no pending yet, add ourselves */
-				pending_del_slot = path->slots[0];
-				pending_del_nr = 1;
-			} else if (pending_del_nr &&
-				   path->slots[0] + 1 == pending_del_slot) {
-				/* hop on the pending chunk */
-				pending_del_nr++;
-				pending_del_slot = path->slots[0];
-			} else {
-				BUG();
-			}
-		} else {
-			break;
-		}
-		should_throttle = false;
-
-		if (found_extent &&
-		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-			struct btrfs_ref ref = { 0 };
-
-			bytes_deleted += extent_num_bytes;
-
-			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
-					extent_start, extent_num_bytes, 0);
-			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-					ino, extent_offset,
-					root->root_key.objectid, false);
-			ret = btrfs_free_extent(trans, &ref);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				break;
-			}
-			if (be_nice) {
-				if (btrfs_should_throttle_delayed_refs(trans))
-					should_throttle = true;
-			}
-		}
-
-		if (found_type == BTRFS_INODE_ITEM_KEY)
-			break;
-
-		if (path->slots[0] == 0 ||
-		    path->slots[0] != pending_del_slot ||
-		    should_throttle) {
-			if (pending_del_nr) {
-				ret = btrfs_del_items(trans, root, path,
-						pending_del_slot,
-						pending_del_nr);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					break;
-				}
-				pending_del_nr = 0;
-			}
-			btrfs_release_path(path);
-
-			/*
-			 * We can generate a lot of delayed refs, so we need to
-			 * throttle every once and a while and make sure we're
-			 * adding enough space to keep up with the work we are
-			 * generating.  Since we hold a transaction here we
-			 * can't flush, and we don't want to FLUSH_LIMIT because
-			 * we could have generated too many delayed refs to
-			 * actually allocate, so just bail if we're short and
-			 * let the normal reservation dance happen higher up.
-			 */
-			if (should_throttle) {
-				ret = btrfs_delayed_refs_rsv_refill(fs_info,
-							BTRFS_RESERVE_NO_FLUSH);
-				if (ret) {
-					ret = -EAGAIN;
-					break;
-				}
-			}
-			goto search_again;
-		} else {
-			path->slots[0]--;
-		}
-	}
-out:
-	if (ret >= 0 && pending_del_nr) {
-		int err;
-
-		err = btrfs_del_items(trans, root, path, pending_del_slot,
-				      pending_del_nr);
-		if (err) {
-			btrfs_abort_transaction(trans, err);
-			ret = err;
-		}
-	}
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		ASSERT(last_size >= new_size);
-		if (!ret && last_size > new_size)
-			last_size = new_size;
-		btrfs_inode_safe_disk_i_size_write(inode, last_size);
-		unlock_extent_cached(&inode->io_tree, lock_start, (u64)-1,
-				     &cached_state);
-	}
-
-	btrfs_free_path(path);
-	return ret;
-}
-
 /*
  * btrfs_truncate_block - read, zero a chunk and write a block
  * @inode - inode that we're zeroing
@@ -8997,11 +8614,11 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 
 	/*
 	 * We can't call btrfs_truncate_block inside a trans handle as we could
-	 * deadlock with freeze, if we got NEED_TRUNCATE_BLOCK then we know
-	 * we've truncated everything except the last little bit, and can do
-	 * btrfs_truncate_block and then update the disk_i_size.
+	 * deadlock with freeze, if we got BTRFS_NEED_TRUNCATE_BLOCK then we
+	 * know we've truncated everything except the last little bit, and can
+	 * do btrfs_truncate_block and then update the disk_i_size.
 	 */
-	if (ret == NEED_TRUNCATE_BLOCK) {
+	if (ret == BTRFS_NEED_TRUNCATE_BLOCK) {
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
 
-- 
2.26.3

