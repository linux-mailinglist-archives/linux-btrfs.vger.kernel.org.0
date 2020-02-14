Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB115D39C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgBNIOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 03:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgBNION (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 03:14:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5098AAC91
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 08:14:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of btrfs_backref_iterator
Date:   Fri, 14 Feb 2020 16:13:52 +0800
Message-Id: <20200214081354.56605-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214081354.56605-1-wqu@suse.com>
References: <20200214081354.56605-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Due to the complex nature of btrfs extent tree, when we want to iterate
all backrefs of one extent, it involves quite a lot of works, like
search the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
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

The idea of btrfs_backref_iterator is to avoid such complex and hard to
read code structure, but something like the following:

  iterator = btrfs_backref_iterator_alloc();
  ret = btrfs_backref_iterator_start(iterator, bytenr);
  if (ret < 0)
	goto out;
  for (; ; ret = btrfs_backref_iterator_next(iterator)) {
	/* REAL WORK HERE */
  }
  out:
  btrfs_backref_iterator_free(iterator);

This patch is just the skeleton + btrfs_backref_iterator_start() code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c | 58 +++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..73c4829609c9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2252,3 +2252,61 @@ void free_ipath(struct inode_fs_paths *ipath)
 	kvfree(ipath->fspath);
 	kfree(ipath);
 }
+
+int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
+				 u64 bytenr)
+{
+	struct btrfs_fs_info *fs_info = iterator->fs_info;
+	struct btrfs_path *path = iterator->path;
+	struct btrfs_extent_item *ei;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_METADATA_ITEM_KEY;
+	key.offset = (u64)-1;
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
+	memcpy(&iterator->cur_key, &key, sizeof(key));
+	iterator->end_ptr = btrfs_item_end_nr(path->nodes[0], path->slots[0]);
+	iterator->item_ptr = btrfs_item_ptr_offset(path->nodes[0],
+						   path->slots[0]);
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_extent_item);
+
+	/* Only support iteration on tree backref yet */
+	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA) {
+		ret = -ENOTTY;
+		goto release;
+	}
+	iterator->cur_ptr = iterator->item_ptr + sizeof(*ei);
+	return 0;
+release:
+	iterator->end_ptr = 0;
+	iterator->cur_ptr = 0;
+	iterator->item_ptr = 0;
+	iterator->cur_key.objectid = 0;
+	iterator->cur_key.type = 0;
+	iterator->cur_key.offset = 0;
+	btrfs_release_path(path);
+	return ret;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 777f61dc081e..b53301f2147f 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -74,4 +74,80 @@ struct prelim_ref {
 	u64 wanted_disk_byte;
 };
 
+/*
+ * Helper structure to help iterate backrefs of one extent.
+ *
+ * Now it only supports iteration for tree block in commit root.
+ */
+struct btrfs_backref_iterator {
+	u64 bytenr;
+	struct btrfs_path *path;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_key cur_key;
+	unsigned long item_ptr;
+	unsigned long cur_ptr;
+	unsigned long end_ptr;
+};
+
+static inline struct btrfs_backref_iterator *
+btrfs_backref_iterator_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
+{
+	struct btrfs_backref_iterator *ret;
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
+static inline void btrfs_backref_iterator_free(
+		struct btrfs_backref_iterator *iterator)
+{
+	if (!iterator)
+		return;
+	btrfs_free_path(iterator->path);
+	kfree(iterator);
+}
+
+static inline struct extent_buffer *
+btrfs_backref_get_eb(struct btrfs_backref_iterator *iterator)
+{
+	if (!iterator)
+		return NULL;
+	return iterator->path->nodes[0];
+}
+
+/*
+ * For metadata with EXTENT_ITEM key (non-skinny) case, the first inline data
+ * is btrfs_tree_block_info, without a btrfs_extent_inline_ref header.
+ *
+ * This helper is here to determine if that's the case.
+ */
+static inline bool btrfs_backref_has_tree_block_info(
+		struct btrfs_backref_iterator *iterator)
+{
+	if (iterator->cur_key.type == BTRFS_EXTENT_ITEM_KEY &&
+	    iterator->cur_ptr - iterator->item_ptr ==
+	    sizeof(struct btrfs_extent_item))
+		return true;
+	return false;
+}
+
+int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
+				 u64 bytenr);
+int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator);
+
 #endif
-- 
2.25.0

