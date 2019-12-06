Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC61115394
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLFOrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:47:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45910 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfLFOrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:47:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so6612731qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VpvB9HQeJPHUB3XIqn87rZjgGudg427bCdy4jc5TOtA=;
        b=0+GkeW3PaO5K2HdR+ktTj/0jINDS3xTKKU38st+fcJtjPamX4ldPcPtPnxTWUVUFt2
         hLct0UlGmPADuX3iomQaA4kriI0fyiI0QRdVLtcq3NpKvRMxkAsbZXNII+8QbuceNfjH
         kB8m+CjhgE07lcIadwayRSRCNtvvnaVTOZw5l/PuCH61pIL8Vd1W/9K54+qRg9qBT7NF
         zIoSozLr0BhZkhnsIeh3WiiQfSrxmSgsKWv60X+5vCNYZSSZpCHRPM92ISxvRSKzSizb
         XhjJFgWU5TQYPizlsy742aw7bdk5yBix6HIqBNygxsXY3WNlhUJvxdwMzZjdLWr7Ieyb
         +OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpvB9HQeJPHUB3XIqn87rZjgGudg427bCdy4jc5TOtA=;
        b=pobKEK5E60PeEKVBV6lA0DMNcp+m4+V7Xn2fnz/dGBviynLX5pIF6aqEDHGo/Wok1F
         6Bf0681YnYDPMXbZwqejhMcqgE6fNaugYNOg40cZHVjYZGfUAYeXnCv/UG51gSJJgDTM
         uvmj8SXFwYDWWjScHuZ8cSHOqkTyN87t4nTJzWpD1hwx+54VKdOt2j3rgyruBytQvWys
         cMpYie3+htIU+2Sy0AOriIBeCYV7E8Zxvq50DJ8JM+TTg8bR5MVgcTz56DmEsyK/u8e/
         VLrmOXQSs4JXRIGNMW4UFweTU2/3pGY1B1FBbYSA7AQTQFfwz3vf60NhL4D2QNwFfCBv
         t2Eg==
X-Gm-Message-State: APjAAAXKeDfgDPPa8U85dKQpmoqLXmfBaUU8QAhnktqz97Sb1Fqh1aYK
        nilCLmhl4iNTDj58eCkXf1JmdioJr8Fx6A==
X-Google-Smtp-Source: APXvYqznQZ6Ubped81ibYr3CIh2EPdHFd33nH2y29d9f9sTt3ybblfb4FtVRjsiNyVv0NICaWZn6YQ==
X-Received: by 2002:a37:6ec4:: with SMTP id j187mr14044760qkc.193.1575643617809;
        Fri, 06 Dec 2019 06:46:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l7sm6674704qtf.84.2019.12.06.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 44/44] btrfs: rename btrfs_put_fs_root and btrfs_grab_fs_root
Date:   Fri,  6 Dec 2019 09:45:38 -0500
Message-Id: <20191206144538.168112-45-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are now using these for all roots, rename them to btrfs_put_root()
and btrfs_grab_root();

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c         |  2 +-
 fs/btrfs/disk-io.c         | 78 +++++++++++++++++++-------------------
 fs/btrfs/disk-io.h         |  4 +-
 fs/btrfs/export.c          |  2 +-
 fs/btrfs/extent-tree.c     |  2 +-
 fs/btrfs/file.c            |  2 +-
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/inode.c           | 12 +++---
 fs/btrfs/ioctl.c           | 18 ++++-----
 fs/btrfs/ordered-data.c    |  4 +-
 fs/btrfs/qgroup.c          |  4 +-
 fs/btrfs/relocation.c      | 48 +++++++++++------------
 fs/btrfs/root-tree.c       |  2 +-
 fs/btrfs/scrub.c           |  6 +--
 fs/btrfs/send.c            | 12 +++---
 fs/btrfs/super.c           | 10 ++---
 fs/btrfs/tree-log.c        | 10 ++---
 fs/btrfs/volumes.c         |  2 +-
 18 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b69154d72529..ded46efac27d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -577,7 +577,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	ret = add_all_parents(root, path, parents, ref, level, time_seq,
 			      extent_item_pos, total_refs, ignore_offset);
 out:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 out_free:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 143519aea1d0..afcee4ff6be1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1313,7 +1313,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		free_extent_buffer(root->commit_root);
 		free_extent_buffer(leaf);
 	}
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 
 	return ERR_PTR(ret);
 }
@@ -1344,7 +1344,7 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
 			NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		return ERR_CAST(leaf);
 	}
 
@@ -1448,7 +1448,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	return root;
 
 find_fail:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 alloc_fail:
 	root = ERR_PTR(ret);
 	goto out;
@@ -1514,7 +1514,7 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 	root = radix_tree_lookup(&fs_info->fs_roots_radix,
 				 (unsigned long)root_id);
 	if (root)
-		root = btrfs_grab_fs_root(root);
+		root = btrfs_grab_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	return root;
 }
@@ -1533,7 +1533,7 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 				(unsigned long)root->root_key.objectid,
 				root);
 	if (ret == 0) {
-		btrfs_grab_fs_root(root);
+		btrfs_grab_root(root);
 		set_bit(BTRFS_ROOT_IN_RADIX, &root->state);
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
@@ -1561,8 +1561,8 @@ static void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 			  root->root_key.objectid, root->root_key.offset,
 			  refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
-			btrfs_put_fs_root(root);
-		btrfs_put_fs_root(root);
+			btrfs_put_root(root);
+		btrfs_put_root(root);
 	}
 #endif
 }
@@ -1578,15 +1578,15 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
-	btrfs_put_fs_root(fs_info->extent_root);
-	btrfs_put_fs_root(fs_info->tree_root);
-	btrfs_put_fs_root(fs_info->chunk_root);
-	btrfs_put_fs_root(fs_info->dev_root);
-	btrfs_put_fs_root(fs_info->csum_root);
-	btrfs_put_fs_root(fs_info->quota_root);
-	btrfs_put_fs_root(fs_info->uuid_root);
-	btrfs_put_fs_root(fs_info->free_space_root);
-	btrfs_put_fs_root(fs_info->fs_root);
+	btrfs_put_root(fs_info->extent_root);
+	btrfs_put_root(fs_info->tree_root);
+	btrfs_put_root(fs_info->chunk_root);
+	btrfs_put_root(fs_info->dev_root);
+	btrfs_put_root(fs_info->csum_root);
+	btrfs_put_root(fs_info->quota_root);
+	btrfs_put_root(fs_info->uuid_root);
+	btrfs_put_root(fs_info->free_space_root);
+	btrfs_put_root(fs_info->fs_root);
 	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
@@ -1604,32 +1604,32 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
-		return btrfs_grab_fs_root(fs_info->tree_root);
+		return btrfs_grab_root(fs_info->tree_root);
 	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return btrfs_grab_fs_root(fs_info->extent_root);
+		return btrfs_grab_root(fs_info->extent_root);
 	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
-		return btrfs_grab_fs_root(fs_info->chunk_root);
+		return btrfs_grab_root(fs_info->chunk_root);
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
-		return btrfs_grab_fs_root(fs_info->dev_root);
+		return btrfs_grab_root(fs_info->dev_root);
 	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return btrfs_grab_fs_root(fs_info->csum_root);
+		return btrfs_grab_root(fs_info->csum_root);
 	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
 		return fs_info->quota_root ?
-			btrfs_grab_fs_root(fs_info->quota_root) :
+			btrfs_grab_root(fs_info->quota_root) :
 			ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
 		return fs_info->uuid_root ?
-			btrfs_grab_fs_root(fs_info->uuid_root) :
+			btrfs_grab_root(fs_info->uuid_root) :
 			ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return fs_info->free_space_root ?
-			btrfs_grab_fs_root(fs_info->free_space_root) :
+			btrfs_grab_root(fs_info->free_space_root) :
 			ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
-			btrfs_put_fs_root(root);
+			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
 		}
 		return root;
@@ -1672,10 +1672,10 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	 * we have the third for returning it, and the caller will put it when
 	 * it's done with the root.
 	 */
-	btrfs_grab_fs_root(root);
+	btrfs_grab_root(root);
 	ret = btrfs_insert_fs_root(fs_info, root);
 	if (ret) {
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		if (ret == -EEXIST) {
 			btrfs_free_fs_root(root);
 			goto again;
@@ -2075,7 +2075,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 		} else {
 			free_extent_buffer(gang[0]->node);
 			free_extent_buffer(gang[0]->commit_root);
-			btrfs_put_fs_root(gang[0]);
+			btrfs_put_root(gang[0]);
 		}
 	}
 
@@ -2280,12 +2280,12 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(log_tree_root->node)) {
 		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
-		btrfs_put_fs_root(log_tree_root);
+		btrfs_put_root(log_tree_root);
 		return ret;
 	} else if (!extent_buffer_uptodate(log_tree_root->node)) {
 		btrfs_err(fs_info, "failed to read log tree");
 		free_extent_buffer(log_tree_root->node);
-		btrfs_put_fs_root(log_tree_root);
+		btrfs_put_root(log_tree_root);
 		return -EIO;
 	}
 	/* returns with log_tree_root freed on success */
@@ -2294,7 +2294,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Failed to recover log tree");
 		free_extent_buffer(log_tree_root->node);
-		btrfs_put_fs_root(log_tree_root);
+		btrfs_put_root(log_tree_root);
 		return ret;
 	}
 
@@ -3892,7 +3892,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
 	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
@@ -3903,7 +3903,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		if (root->reloc_root) {
 			free_extent_buffer(root->reloc_root->node);
 			free_extent_buffer(root->reloc_root->commit_root);
-			btrfs_put_fs_root(root->reloc_root);
+			btrfs_put_root(root->reloc_root);
 			root->reloc_root = NULL;
 		}
 	}
@@ -3927,7 +3927,7 @@ void btrfs_free_fs_root(struct btrfs_root *root)
 	free_extent_buffer(root->commit_root);
 	kfree(root->free_ino_ctl);
 	kfree(root->free_ino_pinned);
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 }
 
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
@@ -3957,7 +3957,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 				continue;
 			}
 			/* grab all the search result for later use */
-			gang[i] = btrfs_grab_fs_root(gang[i]);
+			gang[i] = btrfs_grab_root(gang[i]);
 		}
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 
@@ -3968,7 +3968,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			err = btrfs_orphan_cleanup(gang[i]);
 			if (err)
 				break;
-			btrfs_put_fs_root(gang[i]);
+			btrfs_put_root(gang[i]);
 		}
 		root_objectid++;
 	}
@@ -3976,7 +3976,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	/* release the uncleaned roots due to error */
 	for (; i < ret; i++) {
 		if (gang[i])
-			btrfs_put_fs_root(gang[i]);
+			btrfs_put_root(gang[i]);
 	}
 	return err;
 }
@@ -4365,12 +4365,12 @@ static void btrfs_destroy_all_delalloc_inodes(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&splice)) {
 		root = list_first_entry(&splice, struct btrfs_root,
 					 delalloc_root);
-		root = btrfs_grab_fs_root(root);
+		root = btrfs_grab_root(root);
 		BUG_ON(!root);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
 		btrfs_destroy_delalloc_inodes(root);
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 
 		spin_lock(&fs_info->delalloc_root_lock);
 	}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 3178849ee82d..955d7826b6af 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -87,14 +87,14 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
  * If you want to ensure the whole tree is safe, you should use
  * 	fs_info->subvol_srcu
  */
-static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
+static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 {
 	if (refcount_inc_not_zero(&root->refs))
 		return root;
 	return NULL;
 }
 
-static inline void btrfs_put_fs_root(struct btrfs_root *root)
+static inline void btrfs_put_root(struct btrfs_root *root)
 {
 	if (!root)
 		return;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index f07c2300ade2..657fd6ad6e18 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -88,7 +88,7 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	key.offset = 0;
 
 	inode = btrfs_iget(sb, &key, root);
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 18df434bfe52..04ad2100ecc1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5415,7 +5415,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	} else {
 		free_extent_buffer(root->node);
 		free_extent_buffer(root->commit_root);
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 	}
 	root_dropped = true;
 out_end_trans:
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 062580a1721f..254fa3cc1ba7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -297,7 +297,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
-	btrfs_put_fs_root(inode_root);
+	btrfs_put_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c79804c30b17..bc43950eb32f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1253,7 +1253,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	free_extent_buffer(free_space_root->node);
 	free_extent_buffer(free_space_root->commit_root);
-	btrfs_put_fs_root(free_space_root);
+	btrfs_put_root(free_space_root);
 
 	return btrfs_commit_transaction(trans);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bc961ca6995f..bbb8a9641a6d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2533,7 +2533,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (WARN_ON(ret < 0)) {
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		return ret;
 	}
 	ret = 0;
@@ -2605,7 +2605,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 	backref_insert(&new->root, backref);
 	old->count++;
 out:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	btrfs_release_path(path);
 	WARN_ON(ret);
 	return ret;
@@ -2720,7 +2720,7 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	key.offset = 0;
 
 	inode = btrfs_iget(fs_info->sb, &key, root);
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	if (IS_ERR(inode)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		return 0;
@@ -5923,7 +5923,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
 	if (root != sub_root)
-		btrfs_put_fs_root(sub_root);
+		btrfs_put_root(sub_root);
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
@@ -10257,14 +10257,14 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
 	while (!list_empty(&splice) && nr) {
 		root = list_first_entry(&splice, struct btrfs_root,
 					delalloc_root);
-		root = btrfs_grab_fs_root(root);
+		root = btrfs_grab_root(root);
 		BUG_ON(!root);
 		list_move_tail(&root->delalloc_root,
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
 		ret = start_delalloc_inodes(root, nr, false);
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		if (ret < 0)
 			goto out;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7df2576aa2e3..8ec61f3f0291 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -676,7 +676,7 @@ static noinline int create_subvol(struct inode *dir,
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
-	btrfs_put_fs_root(new_root);
+	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
@@ -870,7 +870,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	d_instantiate(dentry, inode);
 	ret = 0;
 fail:
-	btrfs_put_fs_root(pending_snapshot->snap);
+	btrfs_put_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (snapshot_force_cow)
@@ -2176,7 +2176,7 @@ static noinline int search_ioctl(struct inode *inode,
 
 	if (sk->tree_id == 0) {
 		/* search the root of the inode that was passed */
-		root = btrfs_grab_fs_root(BTRFS_I(inode)->root);
+		root = btrfs_grab_root(BTRFS_I(inode)->root);
 	} else {
 		key.objectid = sk->tree_id;
 		key.type = BTRFS_ROOT_ITEM_KEY;
@@ -2210,7 +2210,7 @@ static noinline int search_ioctl(struct inode *inode,
 		ret = 0;
 err:
 	sk->nr_items = num_found;
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -2372,7 +2372,7 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	ret = 0;
 out:
 	if (root)
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -2500,7 +2500,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 
 		memmove(args->path, ptr, total_len);
 		args->path[total_len] = '\0';
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		btrfs_release_path(path);
 	}
 
@@ -2540,7 +2540,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 	btrfs_free_path(path);
 	return ret;
 out_put:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	goto out;
 }
 
@@ -2743,7 +2743,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = -EFAULT;
 
 out:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
 	kzfree(subvol_info);
@@ -4041,7 +4041,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
 	btrfs_end_transaction(trans);
 out_free:
-	btrfs_put_fs_root(new_root);
+	btrfs_put_root(new_root);
 	btrfs_free_path(path);
 out:
 	mnt_drop_write_file(file);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6240a5a1f2c0..3a3c648bb9d3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -588,7 +588,7 @@ u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 	while (!list_empty(&splice) && nr) {
 		root = list_first_entry(&splice, struct btrfs_root,
 					ordered_root);
-		root = btrfs_grab_fs_root(root);
+		root = btrfs_grab_root(root);
 		BUG_ON(!root);
 		list_move_tail(&root->ordered_root,
 			       &fs_info->ordered_roots);
@@ -596,7 +596,7 @@ u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 
 		done = btrfs_wait_ordered_extents(root, nr,
 						  range_start, range_len);
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		total_done += done;
 
 		spin_lock(&fs_info->ordered_root_lock);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 762f254b4b38..8fb576495be9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1040,7 +1040,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	if (ret) {
 		free_extent_buffer(quota_root->node);
 		free_extent_buffer(quota_root->commit_root);
-		btrfs_put_fs_root(quota_root);
+		btrfs_put_root(quota_root);
 	}
 out:
 	if (ret) {
@@ -1106,7 +1106,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 
 	free_extent_buffer(quota_root->node);
 	free_extent_buffer(quota_root->commit_root);
-	btrfs_put_fs_root(quota_root);
+	btrfs_put_root(quota_root);
 
 end_trans:
 	ret = btrfs_end_transaction(trans);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f6d63d6cf22d..754f18e8019b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -257,7 +257,7 @@ static void free_backref_node(struct backref_cache *cache,
 	if (node) {
 		cache->nr_nodes--;
 		if (node->root)
-			btrfs_put_fs_root(node->root);
+			btrfs_put_root(node->root);
 		kfree(node);
 	}
 }
@@ -870,7 +870,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       cur->bytenr);
 			if (should_ignore_root(root)) {
-				btrfs_put_fs_root(root);
+				btrfs_put_root(root);
 				list_add(&cur->list, &useless);
 			} else {
 				cur->root = root;
@@ -887,7 +887,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
 		path2->lowest_level = 0;
 		if (ret < 0) {
-			btrfs_put_fs_root(root);
+			btrfs_put_root(root);
 			err = ret;
 			goto out;
 		}
@@ -903,7 +903,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				  root->root_key.objectid,
 				  node_key->objectid, node_key->type,
 				  node_key->offset);
-			btrfs_put_fs_root(root);
+			btrfs_put_root(root);
 			err = -ENOENT;
 			goto out;
 		}
@@ -916,7 +916,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				ASSERT(btrfs_root_bytenr(&root->root_item) ==
 				       lower->bytenr);
 				if (should_ignore_root(root)) {
-					btrfs_put_fs_root(root);
+					btrfs_put_root(root);
 					list_add(&lower->list, &useless);
 				} else {
 					lower->root = root;
@@ -926,7 +926,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 			edge = alloc_backref_edge(cache);
 			if (!edge) {
-				btrfs_put_fs_root(root);
+				btrfs_put_root(root);
 				err = -ENOMEM;
 				goto out;
 			}
@@ -936,7 +936,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			if (!rb_node) {
 				upper = alloc_backref_node(cache);
 				if (!upper) {
-					btrfs_put_fs_root(root);
+					btrfs_put_root(root);
 					free_backref_edge(cache, edge);
 					err = -ENOMEM;
 					goto out;
@@ -985,7 +985,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			edge->node[UPPER] = upper;
 
 			if (rb_node) {
-				btrfs_put_fs_root(root);
+				btrfs_put_root(root);
 				break;
 			}
 			lower = upper;
@@ -1224,7 +1224,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	new_node->level = node->level;
 	new_node->lowest = node->lowest;
 	new_node->checked = 1;
-	new_node->root = btrfs_grab_fs_root(dest);
+	new_node->root = btrfs_grab_root(dest);
 	ASSERT(new_node->root);
 
 	if (!node->lowest) {
@@ -2189,7 +2189,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 	btrfs_update_reloc_root(trans, root);
 
 	if (list_empty(&root->reloc_dirty_list)) {
-		btrfs_grab_fs_root(root);
+		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
 }
@@ -2216,7 +2216,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 					ret = ret2;
 			}
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
-			btrfs_put_fs_root(root);
+			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
 			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
@@ -2441,7 +2441,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
@@ -2503,7 +2503,7 @@ void merge_reloc_roots(struct reloc_control *rc)
 			BUG_ON(root->reloc_root != reloc_root);
 
 			ret = merge_reloc_root(rc, root);
-			btrfs_put_fs_root(root);
+			btrfs_put_root(root);
 			if (ret) {
 				if (list_empty(&reloc_root->root_list))
 					list_add_tail(&reloc_root->root_list,
@@ -2564,7 +2564,7 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
 	ret = btrfs_record_root_in_trans(trans, root);
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 
 	return ret;
 }
@@ -2599,8 +2599,8 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			BUG_ON(next->new_bytenr);
 			BUG_ON(!list_empty(&next->list));
 			next->new_bytenr = root->node->start;
-			btrfs_put_fs_root(next->root);
-			next->root = btrfs_grab_fs_root(root);
+			btrfs_put_root(next->root);
+			next->root = btrfs_grab_root(root);
 			ASSERT(next->root);
 			list_add_tail(&next->list,
 				      &rc->backref_cache.changed);
@@ -3073,8 +3073,8 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-			btrfs_put_fs_root(node->root);
-			node->root = btrfs_grab_fs_root(root);
+			btrfs_put_root(node->root);
+			node->root = btrfs_grab_root(root);
 			ASSERT(node->root);
 			list_add_tail(&node->list, &rc->backref_cache.changed);
 		} else {
@@ -3772,7 +3772,7 @@ static int find_data_references(struct reloc_control *rc,
 
 	}
 out:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
 	return err;
@@ -4258,7 +4258,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 
 	trans = btrfs_start_transaction(root, 6);
 	if (IS_ERR(trans)) {
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 		return ERR_CAST(trans);
 	}
 
@@ -4278,7 +4278,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
-	btrfs_put_fs_root(root);
+	btrfs_put_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
@@ -4538,7 +4538,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 					goto out;
 				}
 			} else {
-				btrfs_put_fs_root(fs_root);
+				btrfs_put_root(fs_root);
 			}
 		}
 
@@ -4592,7 +4592,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
 		fs_root->reloc_root = reloc_root;
-		btrfs_put_fs_root(fs_root);
+		btrfs_put_root(fs_root);
 	}
 
 	err = btrfs_commit_transaction(trans);
@@ -4628,7 +4628,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			err = PTR_ERR(fs_root);
 		} else {
 			err = btrfs_orphan_cleanup(fs_root);
-			btrfs_put_fs_root(fs_root);
+			btrfs_put_root(fs_root);
 		}
 	}
 	return err;
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 2c94b5318b40..0a455f116666 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -288,7 +288,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
-		btrfs_put_fs_root(root);
+		btrfs_put_root(root);
 	}
 
 	btrfs_free_path(path);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0c8b60055c2e..53261bf04c11 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -667,7 +667,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 
 	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
 	if (ret) {
-		btrfs_put_fs_root(local_root);
+		btrfs_put_root(local_root);
 		btrfs_release_path(swarn->path);
 		goto err;
 	}
@@ -688,7 +688,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	ipath = init_ipath(4096, local_root, swarn->path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(ipath)) {
-		btrfs_put_fs_root(local_root);
+		btrfs_put_root(local_root);
 		ret = PTR_ERR(ipath);
 		ipath = NULL;
 		goto err;
@@ -712,7 +712,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				  min(isize - offset, (u64)PAGE_SIZE), nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
-	btrfs_put_fs_root(local_root);
+	btrfs_put_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6520ad8f4e81..a7041f270140 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7211,7 +7211,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			    btrfs_root_dead(clone_root)) {
 				spin_unlock(&clone_root->root_item_lock);
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
-				btrfs_put_fs_root(clone_root);
+				btrfs_put_root(clone_root);
 				ret = -EPERM;
 				goto out;
 			}
@@ -7219,7 +7219,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				dedupe_in_progress_warn(clone_root);
 				spin_unlock(&clone_root->root_item_lock);
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
-				btrfs_put_fs_root(clone_root);
+				btrfs_put_root(clone_root);
 				ret = -EAGAIN;
 				goto out;
 			}
@@ -7275,7 +7275,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	 * for possible clone sources.
 	 */
 	sctx->clone_roots[sctx->clone_roots_cnt++].root =
-		btrfs_grab_fs_root(sctx->send_root);
+		btrfs_grab_root(sctx->send_root);
 
 	/* We do a bsearch later */
 	sort(sctx->clone_roots, sctx->clone_roots_cnt,
@@ -7363,20 +7363,20 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		for (i = 0; i < sctx->clone_roots_cnt; i++) {
 			btrfs_root_dec_send_in_progress(
 					sctx->clone_roots[i].root);
-			btrfs_put_fs_root(sctx->clone_roots[i].root);
+			btrfs_put_root(sctx->clone_roots[i].root);
 		}
 	} else {
 		for (i = 0; sctx && i < clone_sources_to_rollback; i++) {
 			btrfs_root_dec_send_in_progress(
 					sctx->clone_roots[i].root);
-			btrfs_put_fs_root(sctx->clone_roots[i].root);
+			btrfs_put_root(sctx->clone_roots[i].root);
 		}
 
 		btrfs_root_dec_send_in_progress(send_root);
 	}
 	if (sctx && !IS_ERR_OR_NULL(sctx->parent_root)) {
 		btrfs_root_dec_send_in_progress(sctx->parent_root);
-		btrfs_put_fs_root(sctx->parent_root);
+		btrfs_put_root(sctx->parent_root);
 	}
 
 	kvfree(clone_sources_tmp);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 80fea16cf34c..476c93a238eb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1094,16 +1094,16 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
 			ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
 			if (ret < 0) {
-				btrfs_put_fs_root(fs_root);
+				btrfs_put_root(fs_root);
 				goto err;
 			} else if (ret > 0) {
 				ret = btrfs_previous_item(fs_root, path, dirid,
 							  BTRFS_INODE_REF_KEY);
 				if (ret < 0) {
-					btrfs_put_fs_root(fs_root);
+					btrfs_put_root(fs_root);
 					goto err;
 				} else if (ret > 0) {
-					btrfs_put_fs_root(fs_root);
+					btrfs_put_root(fs_root);
 					ret = -ENOENT;
 					goto err;
 				}
@@ -1120,7 +1120,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr -= len + 1;
 			if (ptr < name) {
 				ret = -ENAMETOOLONG;
-				btrfs_put_fs_root(fs_root);
+				btrfs_put_root(fs_root);
 				goto err;
 			}
 			read_extent_buffer(path->nodes[0], ptr + 1,
@@ -1128,7 +1128,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr[0] = '/';
 			btrfs_release_path(path);
 		}
-		btrfs_put_fs_root(fs_root);
+		btrfs_put_root(fs_root);
 	}
 
 	btrfs_free_path(path);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 32ee8698a87f..968605b901ed 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3296,7 +3296,7 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	free_extent_buffer(log->node);
-	btrfs_put_fs_root(log);
+	btrfs_put_root(log);
 }
 
 /*
@@ -6312,7 +6312,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 							log->node->len);
 			free_extent_buffer(log->node);
 			free_extent_buffer(log->commit_root);
-			btrfs_put_fs_root(log);
+			btrfs_put_root(log);
 
 			if (!ret)
 				goto next;
@@ -6348,10 +6348,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
-		btrfs_put_fs_root(wc.replay_dest);
+		btrfs_put_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
-		btrfs_put_fs_root(log);
+		btrfs_put_root(log);
 
 		if (ret)
 			goto error;
@@ -6385,7 +6385,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	free_extent_buffer(log_root_tree->node);
 	log_root_tree->log_root = NULL;
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	btrfs_put_fs_root(log_root_tree);
+	btrfs_put_root(log_root_tree);
 
 	return 0;
 error:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d261a39b7aa6..7483521a928b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4391,7 +4391,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		break;
 	}
-	btrfs_put_fs_root(subvol_root);
+	btrfs_put_root(subvol_root);
 out:
 	return ret;
 }
-- 
2.23.0

