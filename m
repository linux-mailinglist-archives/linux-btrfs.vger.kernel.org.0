Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549491622EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgBRJBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 04:01:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:54432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgBRJBm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 04:01:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B1AAAE5C;
        Tue, 18 Feb 2020 09:01:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 1/3] btrfs: backref: Introduce the skeleton of btrfs_backref_iter
Date:   Tue, 18 Feb 2020 17:01:27 +0800
Message-Id: <20200218090129.134450-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218090129.134450-1-wqu@suse.com>
References: <20200218090129.134450-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Due to the complex nature of btrfs extent tree, when we want to iterate
all backrefs of one extent, it involves quite a lot of work, like
searching the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
backrefs.

Normally this would result pretty complex code, something like:
  btrfs_search_slot()
  /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
  while (1) {	/* Loop for extent tree items */
	while (ptr < end) { /* Loop for inlined items */
		/* REAL WORK HERE */
	}
  next:
  	ret = btrfs_next_item()
	/* Ensure we're still at keyed item for specified bytenr */
  }

The idea of btrfs_backref_iter is to avoid such complex and hard to
read code structure, but something like the following:

  iter = btrfs_backref_iter_alloc();
  ret = btrfs_backref_iter_start(iter, bytenr);
  if (ret < 0)
	goto out;
  for (; ; ret = btrfs_backref_iter_next(iter)) {
	/* REAL WORK HERE */
  }
  out:
  btrfs_backref_iter_free(iter);

This patch is just the skeleton + btrfs_backref_iter_start() code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/backref.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h | 60 ++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..c78d15bb999d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2252,3 +2252,90 @@ void free_ipath(struct inode_fs_paths *ipath)
 	kvfree(ipath->fspath);
 	kfree(ipath);
 }
+
+int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
+{
+	struct btrfs_fs_info *fs_info = iter->fs_info;
+	struct btrfs_path *path = iter->path;
+	struct btrfs_extent_item *ei;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_METADATA_ITEM_KEY;
+	key.offset = (u64)-1;
+	iter->bytenr = bytenr;
+
+	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		ret = -EUCLEAN;
+		goto release;
+	}
+	if (path->slots[0] == 0) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		ret = -EUCLEAN;
+		goto release;
+	}
+	path->slots[0]--;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (!(key.type == BTRFS_EXTENT_ITEM_KEY ||
+	      key.type == BTRFS_METADATA_ITEM_KEY) || key.objectid != bytenr) {
+		ret = -ENOENT;
+		goto release;
+	}
+	memcpy(&iter->cur_key, &key, sizeof(key));
+	iter->item_ptr = btrfs_item_ptr_offset(path->nodes[0],
+					       path->slots[0]);
+	iter->end_ptr = iter->item_ptr + btrfs_item_size_nr(path->nodes[0],
+							    path->slots[0]);
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_extent_item);
+
+	/*
+	 * Only support iteration on tree backref yet.
+	 *
+	 * This is extra precaustion for non skinny-metadata, where
+	 * EXTENT_ITEM is also used for tree blocks, that we can only use
+	 * extent flags to determine if it's a tree block.
+	 */
+	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA) {
+		ret = -ENOTTY;
+		goto release;
+	}
+	iter->cur_ptr = iter->item_ptr + sizeof(*ei);
+
+	/* If there is no inline backref, go search for keyed backref */
+	if (iter->cur_ptr >= iter->end_ptr) {
+		ret = btrfs_next_item(fs_info->extent_root, path);
+
+		/* No inline nor keyed ref */
+		if (ret > 0) {
+			ret = -ENOENT;
+			goto release;
+		}
+		if (ret < 0)
+			goto release;
+
+		btrfs_item_key_to_cpu(path->nodes[0], &iter->cur_key,
+				path->slots[0]);
+		if (iter->cur_key.objectid != bytenr ||
+		    (iter->cur_key.type != BTRFS_SHARED_BLOCK_REF_KEY &&
+		     iter->cur_key.type != BTRFS_TREE_BLOCK_REF_KEY)) {
+			ret = -ENOENT;
+			goto release;
+		}
+		iter->cur_ptr = btrfs_item_ptr_offset(path->nodes[0],
+						      path->slots[0]);
+		iter->item_ptr = iter->cur_ptr;
+		iter->end_ptr = iter->item_ptr + btrfs_item_size_nr(
+				path->nodes[0], path->slots[0]);
+	}
+
+	return 0;
+release:
+	btrfs_backref_iter_release(iter);
+	return ret;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 777f61dc081e..8b1ec11d4b28 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -74,4 +74,64 @@ struct prelim_ref {
 	u64 wanted_disk_byte;
 };
 
+/*
+ * Helper structure to help iterate backrefs of one extent.
+ *
+ * Now it only supports iteration for tree block in commit root.
+ */
+struct btrfs_backref_iter {
+	u64 bytenr;
+	struct btrfs_path *path;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_key cur_key;
+	unsigned long item_ptr;
+	unsigned long cur_ptr;
+	unsigned long end_ptr;
+};
+
+static inline struct btrfs_backref_iter *
+btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
+{
+	struct btrfs_backref_iter *ret;
+
+	ret = kzalloc(sizeof(*ret), gfp_flag);
+	if (!ret)
+		return NULL;
+
+	ret->path = btrfs_alloc_path();
+	if (!ret) {
+		kfree(ret);
+		return NULL;
+	}
+
+	/* Current backref iterator only supports iteration in commit root */
+	ret->path->search_commit_root = 1;
+	ret->path->skip_locking = 1;
+	ret->path->reada = READA_FORWARD;
+	ret->fs_info = fs_info;
+
+	return ret;
+}
+
+static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
+{
+	if (!iter)
+		return;
+	btrfs_free_path(iter->path);
+	kfree(iter);
+}
+
+int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
+
+static inline void
+btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
+{
+	iter->bytenr = 0;
+	iter->item_ptr = 0;
+	iter->cur_ptr = 0;
+	iter->end_ptr = 0;
+	btrfs_release_path(iter->path);
+	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
+}
+
 #endif
-- 
2.25.0

