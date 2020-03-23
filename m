Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7518F2A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgCWKYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:24:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgCWKYd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DD75ADF1;
        Mon, 23 Mar 2020 10:24:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 02/40] btrfs: backref: Implement btrfs_backref_iter_next()
Date:   Mon, 23 Mar 2020 18:23:38 +0800
Message-Id: <20200323102416.112862-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function will go next inline/keyed backref for
btrfs_backref_iter infrastructure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8de80ae76008..aee06eff3a04 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2409,3 +2409,61 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	btrfs_backref_iter_release(iter);
 	return ret;
 }
+
+/*
+ * Go to next backref item of current bytenr, can be either inlined or keyed.
+ *
+ * Caller need to check whether it's inline ref or not by iter->cur_key.
+ *
+ * Return 0 if we get next backref without problem.
+ * Return >0 if there is no extra backref for this bytenr.
+ * Return <0 if there is something wrong happened.
+ */
+int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
+{
+	struct extent_buffer *eb = btrfs_backref_get_eb(iter);
+	struct btrfs_path *path = iter->path;
+	struct btrfs_extent_inline_ref *iref;
+	int ret;
+	u32 size;
+
+	if (btrfs_backref_iter_is_inline_ref(iter)) {
+		/* We're still inside the inline refs */
+		ASSERT(iter->cur_ptr < iter->end_ptr);
+
+		if (btrfs_backref_has_tree_block_info(iter)) {
+			/* First tree block info */
+			size = sizeof(struct btrfs_tree_block_info);
+		} else {
+			/* Use inline ref type to determine the size */
+			int type;
+
+			iref = (struct btrfs_extent_inline_ref *)
+				((unsigned long)iter->cur_ptr);
+			type = btrfs_extent_inline_ref_type(eb, iref);
+
+			size = btrfs_extent_inline_ref_size(type);
+		}
+		iter->cur_ptr += size;
+		if (iter->cur_ptr < iter->end_ptr)
+			return 0;
+
+		/* All inline items iterated, fall through */
+	}
+	/* We're at keyed items, there is no inline item, just go next item */
+	ret = btrfs_next_item(iter->fs_info->extent_root, iter->path);
+	if (ret)
+		return ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &iter->cur_key, path->slots[0]);
+	if (iter->cur_key.objectid != iter->bytenr ||
+	    (iter->cur_key.type != BTRFS_TREE_BLOCK_REF_KEY &&
+	     iter->cur_key.type != BTRFS_SHARED_BLOCK_REF_KEY))
+		return 1;
+	iter->item_ptr = (u32)btrfs_item_ptr_offset(path->nodes[0],
+					path->slots[0]);
+	iter->cur_ptr = iter->item_ptr;
+	iter->end_ptr = iter->item_ptr + (u32)btrfs_item_size_nr(path->nodes[0],
+						path->slots[0]);
+	return 0;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 3ca9604981f8..29cc74eabda3 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -100,8 +100,42 @@ static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
 	kfree(iter);
 }
 
+static inline struct extent_buffer *
+btrfs_backref_get_eb(struct btrfs_backref_iter *iter)
+{
+	if (!iter)
+		return NULL;
+	return iter->path->nodes[0];
+}
+
+/*
+ * For metadata with EXTENT_ITEM key (non-skinny) case, the first inline data
+ * is btrfs_tree_block_info, without a btrfs_extent_inline_ref header.
+ *
+ * This helper is here to determine if that's the case.
+ */
+static inline bool btrfs_backref_has_tree_block_info(
+		struct btrfs_backref_iter *iter)
+{
+	if (iter->cur_key.type == BTRFS_EXTENT_ITEM_KEY &&
+	    iter->cur_ptr - iter->item_ptr == sizeof(struct btrfs_extent_item))
+		return true;
+	return false;
+}
+
 int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
 
+int btrfs_backref_iter_next(struct btrfs_backref_iter *iter);
+
+static inline bool
+btrfs_backref_iter_is_inline_ref(struct btrfs_backref_iter *iter)
+{
+	if (iter->cur_key.type == BTRFS_EXTENT_ITEM_KEY ||
+	    iter->cur_key.type == BTRFS_METADATA_ITEM_KEY)
+		return true;
+	return false;
+}
+
 static inline void
 btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
 {
-- 
2.25.2

