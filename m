Return-Path: <linux-btrfs+bounces-16066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F88B24C35
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4A3AE8AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE6307494;
	Wed, 13 Aug 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="BSziSiE6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4E2FFDD7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095731; cv=none; b=gjlgoUX8mdISVB7XgIFjE2eKfICG18urigF8M1h5Tw5jDBxIxVIouPRqiZobcn9eXAjVg7p+Yyyjz/+u8SSCLpw2OMJ0JqU+fmi8p4D7TaRNXwAW0KhYcDxCbB8/DrX3SnvFvFGqC85g3NtL/Cz8xfn68zMcFTYoEz0jWB3gNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095731; c=relaxed/simple;
	bh=WEgjnLJCyy6FNP3B1BgILgEM7wmvgXA+pKMWmfTbPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=J9ewsCpGsl+Ic/Z+Uy8UiNXtQTv4IJoaAWZH0rq5/ndvSnLoaJVEe9dY+OVGyO8yV3rYQs3UvO+BvGcveiA/iYmhsh0dYoz5EXwtexAXqI0vMZRjC1r2cDcCoMAgRa/qmZ749cNLjJUrIIJMRchqOdYqph/bi/elVApp6bwIk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=BSziSiE6; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 9849D2A759E;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=y/wj2i9sX2+Ulrvf9M9Jq2jJySmWXswM0q52LI2gEuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSziSiE6OKtgdHUKZdPs04ijUpvrddayGS8ZargasdxZ06jYHwwsJCsWfp+1nKnEo
	 p1Hnm+1DSpwVGbFCMptUryPGWu6xTdAeiSmJLGqe34ol0CkpRuECRotH0iNPHv2Iwc
	 zfmg50sIRg+5favQtm9geiEO+w5Qe7xVy08TMGFM=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 15/16] btrfs: add fully_remapped_bgs list
Date: Wed, 13 Aug 2025 15:34:57 +0100
Message-ID: <20250813143509.31073-16-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fully_remapped_bgs list to struct btrfs_transaction, which holds
block groups which have just had their last identity remap removed.

In btrfs_finish_extent_commit() we can then discard their full dev
extents, as we're also setting their num_stripes to 0. Finally if the BG
is now empty, i.e. there's neither identity remaps nor normal remaps,
add it to the unused_bgs list to be taken care of there.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/extent-tree.c | 37 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.c  |  2 ++
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/transaction.h |  1 +
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7a0524138235..7f8707dfd62c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1803,6 +1803,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
 	spin_lock(&fs_info->unused_bgs_lock);
+
+	/* Leave fully remapped block groups on the fully_remapped_bgs list. */
+	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    bg->identity_remap_count == 0) {
+		spin_unlock(&fs_info->unused_bgs_lock);
+		return;
+	}
+
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
 		trace_btrfs_add_unused_block_group(bg);
@@ -4792,3 +4800,21 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
 		return false;
 	return true;
 }
+
+void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
+				  struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+
+	if (!list_empty(&bg->bg_list))
+		list_del(&bg->bg_list);
+	else
+		btrfs_get_block_group(bg);
+
+	list_add_tail(&bg->bg_list, &trans->transaction->fully_remapped_bgs);
+
+	spin_unlock(&fs_info->unused_bgs_lock);
+
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 0433b0127ed8..025ea2c6f8a8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -408,5 +408,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
+void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
+				  struct btrfs_trans_handle *trans);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b02e99b41553..157a032df128 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2853,7 +2853,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *block_group, *tmp;
-	struct list_head *deleted_bgs;
+	struct list_head *deleted_bgs, *fully_remapped_bgs;
 	struct extent_io_tree *unpin = &trans->transaction->pinned_extents;
 	struct extent_state *cached_state = NULL;
 	u64 start;
@@ -2951,6 +2951,41 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		}
 	}
 
+	fully_remapped_bgs = &trans->transaction->fully_remapped_bgs;
+	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
+		struct btrfs_chunk_map *map;
+
+		if (!TRANS_ABORTED(trans))
+			ret = btrfs_discard_extent(fs_info, block_group->start,
+						   block_group->length, NULL,
+						   false);
+
+		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
+
+		/*
+		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
+		 * won't run a second time.
+		 */
+		map->num_stripes = 0;
+
+		btrfs_free_chunk_map(map);
+
+		if (block_group->used == 0 && block_group->remap_bytes == 0) {
+			spin_lock(&fs_info->unused_bgs_lock);
+			list_move_tail(&block_group->bg_list,
+				       &fs_info->unused_bgs);
+			spin_unlock(&fs_info->unused_bgs_lock);
+		} else {
+			spin_lock(&fs_info->unused_bgs_lock);
+			list_del_init(&block_group->bg_list);
+			spin_unlock(&fs_info->unused_bgs_lock);
+
+			btrfs_put_block_group(block_group);
+		}
+	}
+
 	return unpin_error;
 }
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 84ff59866e96..0745a3d1c867 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4819,6 +4819,8 @@ static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
+	btrfs_mark_bg_fully_remapped(bg, trans);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 64b9c427af6a..7c308d33e767 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -381,6 +381,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	mutex_init(&cur_trans->cache_write_mutex);
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
+	INIT_LIST_HEAD(&cur_trans->fully_remapped_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	btrfs_extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 9f7c777af635..b362915288b5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -109,6 +109,7 @@ struct btrfs_transaction {
 	spinlock_t dirty_bgs_lock;
 	/* Protected by spin lock fs_info->unused_bgs_lock. */
 	struct list_head deleted_bgs;
+	struct list_head fully_remapped_bgs;
 	spinlock_t dropped_roots_lock;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct btrfs_fs_info *fs_info;
-- 
2.49.1


