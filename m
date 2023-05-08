Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEC6FB353
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjEHO6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjEHO6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 10:58:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2BE7C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wHBhvGVG9jN44yYyV8NXmIC95zvBJDHWkTSOv66VRx4=; b=cmjANCr3VE6I2yjKTUklpjPv9t
        lP8h6t6Zvy3Z6eoffviH/W7rtT9R8k/w4pRuMej7NhAPdpgFoiFKkVINHldBmmfsjIw4P8yRrCHN2
        JUUbUMn/GeH1D5id9fA2nNudA5v5Iw6TgQjOnEN91Lgs+aVI85ruPEldkuJpXPoGZNCrxPGQ8V5an
        l491Ol/qDDONRQZ/3vLVMiETl97RVbI7zHu+v7GGlATz1OG7wKi9L04Ic4tTNdTCR38h1NWqA4DDE
        vaSJGkk5Qs4qG9EeqOC4uVAUtBeGmA6yClJslB9hPYFNvjbwGnW9eYxDBwQfhjPrFGife1xwcw8Kj
        IaT2GG3Q==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw2K2-000oge-16;
        Mon, 08 May 2023 14:58:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied buffers
Date:   Mon,  8 May 2023 07:58:39 -0700
Message-Id: <20230508145839.43725-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508145839.43725-1-hch@lst.de>
References: <20230508145839.43725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs_redirty_list_add redirties a buffer, it also acquires
an extra reference that is released on transaction commit.  But
this is not required as buffers that are dirty or under writeback
are never freed (look for calls to extent_buffer_under_io())).

Remove the extra reference and the infrastructure used to drop it
again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c     |  2 --
 fs/btrfs/extent_io.c   |  1 -
 fs/btrfs/extent_io.h   |  1 -
 fs/btrfs/transaction.c |  9 ---------
 fs/btrfs/transaction.h |  3 ---
 fs/btrfs/zoned.c       | 28 ++++------------------------
 fs/btrfs/zoned.h       |  2 --
 7 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index acd8ebf2824d18..ae81a3b586eaed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -5106,8 +5106,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
-	btrfs_free_redirty_list(cur_trans);
-
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a829390632a538..d8becf1cdbc09e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3557,7 +3557,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_rwsem(&eb->lock);
 
 	btrfs_leak_debug_add_eb(eb);
-	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f937654230d3c5..6f3cfadd232c95 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -89,7 +89,6 @@ struct extent_buffer {
 	struct rw_semaphore lock;
 
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
-	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 27c616fdfae274..fe0f00e717a834 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -374,8 +374,6 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
-	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
-	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES);
@@ -2482,13 +2480,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
-	/*
-	 * At this point, we should have written all the tree blocks allocated
-	 * in this transaction. So it's now safe to free the redirtyied extent
-	 * buffers.
-	 */
-	btrfs_free_redirty_list(cur_trans);
-
 	ret = write_all_supers(fs_info, 0);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index fa728ab8082614..8e9fa23bd7fed7 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -94,9 +94,6 @@ struct btrfs_transaction {
 	 */
 	atomic_t pending_ordered;
 	wait_queue_head_t pending_wait;
-
-	spinlock_t releasing_ebs_lock;
-	struct list_head releasing_ebs;
 };
 
 enum {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7095cfca2fdde1..5612731fc00d78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1603,37 +1603,17 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb)
 {
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-
-	if (!btrfs_is_zoned(fs_info) ||
-	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN) ||
-	    !list_empty(&eb->release_list))
+	if (!btrfs_is_zoned(eb->fs_info) ||
+	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN))
 		return;
 
+	ASSERT(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+
 	memzero_extent_buffer(eb, 0, eb->len);
 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-
-	spin_lock(&trans->releasing_ebs_lock);
-	list_add_tail(&eb->release_list, &trans->releasing_ebs);
-	spin_unlock(&trans->releasing_ebs_lock);
-	atomic_inc(&eb->refs);
-}
-
-void btrfs_free_redirty_list(struct btrfs_transaction *trans)
-{
-	spin_lock(&trans->releasing_ebs_lock);
-	while (!list_empty(&trans->releasing_ebs)) {
-		struct extent_buffer *eb;
-
-		eb = list_first_entry(&trans->releasing_ebs,
-				      struct extent_buffer, release_list);
-		list_del_init(&eb->release_list);
-		free_extent_buffer(eb);
-	}
-	spin_unlock(&trans->releasing_ebs_lock);
 }
 
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c0570d35fea291..3058ef559c9813 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -54,7 +54,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
-void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
@@ -179,7 +178,6 @@ static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 
 static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
-static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
 static inline bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
-- 
2.39.2

