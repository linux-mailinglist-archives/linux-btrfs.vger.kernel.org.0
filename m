Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C22160A71
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBQGbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:31:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQGbb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:31:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 53A8EAD21
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:31:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: backref: Implement btrfs_backref_iterator_next()
Date:   Mon, 17 Feb 2020 14:31:10 +0800
Message-Id: <20200217063111.65941-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217063111.65941-1-wqu@suse.com>
References: <20200217063111.65941-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function will go next inline/keyed backref for
btrfs_backref_iterator infrastructure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8bd5e067831c..fb0abe344851 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2310,3 +2310,50 @@ int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
 	btrfs_backref_iterator_release(iterator);
 	return ret;
 }
+
+int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator)
+{
+	struct extent_buffer *eb = btrfs_backref_get_eb(iterator);
+	struct btrfs_path *path = iterator->path;
+	struct btrfs_extent_inline_ref *iref;
+	int ret;
+	u32 size;
+
+	if (btrfs_backref_iterator_is_inline_ref(iterator)) {
+		/* We're still inside the inline refs */
+		if (btrfs_backref_has_tree_block_info(iterator)) {
+			/* First tree block info */
+			size = sizeof(struct btrfs_tree_block_info);
+		} else {
+			/* Use inline ref type to determine the size */
+			int type;
+
+			iref = (struct btrfs_extent_inline_ref *)
+				(iterator->cur_ptr);
+			type = btrfs_extent_inline_ref_type(eb, iref);
+
+			size = btrfs_extent_inline_ref_size(type);
+		}
+		iterator->cur_ptr += size;
+		if (iterator->cur_ptr < iterator->end_ptr)
+			return 0;
+
+		/* All inline items iterated, fall through */
+	}
+	/* We're at keyed items, there is no inline item, just go next item */
+	ret = btrfs_next_item(iterator->fs_info->extent_root, iterator->path);
+	if (ret > 0 || ret < 0)
+		return ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &iterator->cur_key,
+			      path->slots[0]);
+	if (iterator->cur_key.objectid != iterator->bytenr ||
+	    (iterator->cur_key.type != BTRFS_TREE_BLOCK_REF_KEY &&
+	     iterator->cur_key.type != BTRFS_SHARED_BLOCK_REF_KEY))
+		return 1;
+	iterator->item_ptr = btrfs_item_ptr_offset(path->nodes[0],
+						   path->slots[0]);
+	iterator->cur_ptr = iterator->item_ptr;
+	iterator->end_ptr = btrfs_item_end_nr(path->nodes[0], path->slots[0]);
+	return 0;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index fa73f02f14f6..016999339be1 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -122,8 +122,42 @@ static inline void btrfs_backref_iterator_free(
 	kfree(iterator);
 }
 
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
 int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
 				 u64 bytenr);
+int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator);
+
+static inline bool
+btrfs_backref_iterator_is_inline_ref(struct btrfs_backref_iterator *iterator)
+{
+	if (iterator->cur_key.type == BTRFS_EXTENT_ITEM_KEY ||
+	    iterator->cur_key.type == BTRFS_METADATA_ITEM_KEY)
+		return true;
+	return false;
+}
 
 static inline void
 btrfs_backref_iterator_release(struct btrfs_backref_iterator *iterator)
-- 
2.25.0

