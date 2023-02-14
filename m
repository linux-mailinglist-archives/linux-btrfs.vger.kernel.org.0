Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA469607E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBNKQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 05:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNKQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 05:16:34 -0500
X-Greylist: delayed 1045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 02:16:33 PST
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910312060
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 02:16:33 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4PGHDY5Ctjz9sQp
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 11:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1676369789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QsLiUl28cuLLoH1ki6cUoOu+HDQ+NLyQh6n/PKzVFrM=;
        b=l6IiRouV0VQuJBr57MwOpIqucIciZ1CnR9+NLpZm6lnedyJWQGWxMYjkCC2IrbvNWamQ2B
        WTc4GAMK+196VBRngJNsyyKAr8V5+V+pSFiJ6IXijAJAyRWpSjKWg6xOS/ow/HfzYbpuBA
        epRr9kqYrCusSYombqBPKt3O/wFg6mTuLtxXDu2ZcrDNWOxTpB6xnUlTDZah18Q+zAAzG1
        f6mHK9BD8+HZ58o5d0piV3VLH5ebt/iIvEzCr0BSG0O79EcyLfktfOMAtp+JUmf9EX77Ih
        EO5zw6JU40QoNA8FHqtspS1pPnWmLJzZtMu/nFJo4flREvetubrb7oUdG8PtdQ==
Message-ID: <35d36015e46a940019b2a2de2adf977e95b02d5e.camel@mailbox.org>
Subject: [RFC PATCH 1/1 v2] Reduce frequencies of entry-relink on free space
 trees
From:   Liu Weifeng <liuwf@mailbox.org>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 14 Feb 2023 05:16:23 -0500
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7szp6z3uky7ihfxt6c699zaz5ciyjg1g
X-MBO-RS-ID: 1a6e77aed543994b9f9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From 1cc21d99b51f8f6cd48087edd32b73354b4fe779 Mon Sep 17 00:00:00 2001
Date: Tue, 14 Feb 2023 15:50:28 -0500
Subject: [RFC PATCH 1/1 v2] Reduce frequencies of entry-relink on free space 
trees.

This patch try to get some perf improvement of tree operating when alloc free 
space in uncluster way, because most of node remove/insert operatings on the 
offset-indexed tree are bypassed. 

The detecting codes of this version(v2) have much less time cost than v1, 
eventhough v1 has less cost than standard source(6.2-rc6).

This patch is based on the logic - there is only ONE case that needs to
remove and re-insert an entry on the offset-indexed tree when free space alloc
is done from the tree:

	An entry is striding the start of a bitmap. When the entry shrinked it's
	start position walks towards higher address and may exceed the bitmap's
	start, if the case occured the entry need removed and reinserted on the
	offset-indexed tree to get a right order.

	A bitmap may be overlapped with many entries, but those entries can not
	change their start position to cross the bitmap's start EXCEPT the one
	above mentioned, so most of them do not need to remove/re-insert on the
	tree when their offset changed

	If there no bitmap existed, all entry do not need to remove and re-insert
	on the offset-index tree in most of cases when their offset changes, as any
	change to an entry's offset can not alter the relative order between two
	neighbour entries.

The standard code always remove and re-insert an entry on the offset-indexed
tree when the entry's offset changed. This patch will bypass most of those
operatings so that performance may be improved obviously when we are in the 
difficulty conditions (such as heavy-fragmented).

As for allocating from the bytes-indexed tree - most of cases need remove and
re-insert an entry when the it's size changed, but there is one thing that may 
be worthy of considering:

	Because we always pick the entry with the largest size to tear free space
	from it, it has the most potentiality for the biggest to keep it's top
	weight in the tree, imaging a Mibs-sized gap between the entry's size and
	the size of the second largest entry, cutting away several-Kibs within the
	gap will not change the largest's size below the second entry's size, so
	the largest entry may resist several or even many times of allocating free
	space from it without remove/re-insert on the bytes-indexed tree every time.

This patch also check the condition and try to avoid those remove/insert on the
bytes-indexed tree.

This patch has been passed through xfstests, and I will do more tests laterly,
any comments are appreciated.

Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <Liuwf@mailbox.org>
---
 fs/btrfs/free-space-cache.c | 101 +++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.h |   3 ++
 2 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d250d052487..0a1302c726f1 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1809,6 +1809,62 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 	return entry;
 }
 
+static bool need_relink_free_space_offset(struct btrfs_free_space_ctl *ctl,
+					  struct btrfs_free_space *info,
+					  u64 bytes)
+{
+	struct rb_node *node = NULL;
+	struct btrfs_free_space *entry = NULL;
+
+	/* the free space will be zero size after alloc, it then needs unlink and release */
+	if (bytes >= info->bytes)
+		return true;
+
+	/*we are not the entry that may stride the start of a bitmap, so no offset changing will cause relink */
+	if (!(info->flags & FREE_SPACE_FLAG_CROSS_BITMAP))
+		return false;
+
+	node = rb_next(&info->offset_index);
+	/* we are the last node, no offset changing will cause relink */
+	if (!node)
+		return false;
+
+	entry = rb_entry(node, struct btrfs_free_space, offset_index);
+
+	/* there is no bitmap existed to be crossed by our info, no offset changing will cause relink */
+	if (!entry->bitmap)
+		return false;
+
+	/* our start will still ahead start of the bitmap after alloc, no need of relink */
+	if (info->offset + bytes <= entry->offset)
+		return false;
+
+	/* our start will cross the start of the bitmap after alloc, that needs a relink */
+	return true;
+}
+
+static bool need_relink_free_space_bytes(struct btrfs_free_space_ctl *ctl,
+					 struct btrfs_free_space *info,
+					 u64 bytes)
+{
+	struct rb_node *node = NULL;
+	struct btrfs_free_space *entry = NULL;
+
+	if (bytes >= info->bytes)
+		return true;
+
+	node = rb_next(&info->bytes_index);
+	if (!node)
+		return false;
+
+	entry = rb_entry(node, struct btrfs_free_space, bytes_index);
+
+	if ((info->bytes - bytes) >= entry->bytes)
+		return false;
+
+	return true;
+}
+
 static inline void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 				     struct btrfs_free_space *info,
 				     bool update_stat)
@@ -1830,8 +1886,18 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info)
 {
 	int ret = 0;
+	u64 b_offset;
 
 	ASSERT(info->bytes || info->bitmap);
+
+	if (info->bitmap == NULL) {
+		b_offset = offset_to_bitmap(ctl, info->offset + info->bytes);
+		if (b_offset >= info->offset)
+			info->flags |= FREE_SPACE_FLAG_CROSS_BITMAP;
+		else
+			info->flags &= ~FREE_SPACE_FLAG_CROSS_BITMAP;
+	}
+
 	ret = tree_insert_offset(&ctl->free_space_offset, info->offset,
 				 &info->offset_index, (info->bitmap != NULL));
 	if (ret)
@@ -3078,6 +3144,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	bool use_bytes_index = (offset == block_group->start);
+	u64 new_offset, new_bytes; 
+	bool need_reln_offset, need_reln_bytes;
 
 	ASSERT(!btrfs_is_zoned(block_group->fs_info));
 
@@ -3098,7 +3166,6 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		if (!entry->bytes)
 			free_bitmap(ctl, entry);
 	} else {
-		unlink_free_space(ctl, entry, true);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
@@ -3106,14 +3173,36 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		if (!btrfs_free_space_trimmed(entry))
 			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
 
-		entry->offset = offset + bytes;
+		new_offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
-		entry->bytes -= bytes + align_gap_len;
-		if (!entry->bytes)
+		new_bytes = entry->bytes - (bytes + align_gap_len);
+
+		if (!new_bytes) {
+			unlink_free_space(ctl, entry, true);
 			kmem_cache_free(btrfs_free_space_cachep, entry);
-		else
-			link_free_space(ctl, entry);
+		} else {
+			need_reln_offset = need_relink_free_space_offset(ctl, entry, bytes);
+
+			if (need_reln_offset)
+				rb_erase(&entry->offset_index, &ctl->free_space_offset);
+
+			need_reln_bytes = need_relink_free_space_bytes(ctl, entry, bytes);
+			
+			if (need_reln_bytes)
+				rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
+
+			entry->offset = new_offset;
+			entry->bytes = new_bytes;
+
+			if (need_reln_offset)
+				tree_insert_offset(&ctl->free_space_offset, entry->offset,
+					&entry->offset_index, (entry->bitmap != NULL));
+
+			if (need_reln_bytes)
+				rb_add_cached(&entry->bytes_index, &ctl->free_space_bytes,
+					entry_less);
+		}
 	}
 out:
 	btrfs_discard_update_discardable(block_group);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index a855e0483e03..2a165df394d6 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -20,6 +20,8 @@ enum btrfs_trim_state {
 	BTRFS_TRIM_STATE_TRIMMING,
 };
 
+#define FREE_SPACE_FLAG_CROSS_BITMAP	(1ULL << 5)
+
 struct btrfs_free_space {
 	struct rb_node offset_index;
 	struct rb_node bytes_index;
@@ -30,6 +32,7 @@ struct btrfs_free_space {
 	struct list_head list;
 	enum btrfs_trim_state trim_state;
 	s32 bitmap_extents;
+	u32 flags;
 };
 
 static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
-- 
2.30.2



