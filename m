Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41B4C147
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfFSTMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 15:12:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36209 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 15:12:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so276969qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5l/qHz9lNG4mJl/PtRSgGrk4FUiOdhdPJzoGKBUG9/I=;
        b=wjolao6jVqhmt7/YE+R6EBEB8HnZF0Lc+tMGBu3tKSLI8UNWabJbpTe6vT464NrAHF
         q1MwYCQ33B06kOl1ra3ENut8mPbnoqFFGyXXtpM4SDvqB3VXHygjY7AYwdmUGDr2QwGP
         yVENntlbdugAiSZalxIbWIzVDEdkWc0ogEl3ya2MeB/hcx90AFGi961gVK8HV0XWOr81
         S7UgNMx6r28vrzNwbTF14WvLLXi9Y8tLVrLfI6vrPEBDgFJfQfTSvpKr6deu10A8kUt3
         7WT1NaC/IRhDpwtOY57K4w4qgv/2dMt6SLPBf3/ovr3N9vwii7gf+kYutUWAebImhofl
         /IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=5l/qHz9lNG4mJl/PtRSgGrk4FUiOdhdPJzoGKBUG9/I=;
        b=i1ytNqkp5uCeg1seQ/P9pbqT0gAjKNmWqVT/kkKX41uXEOReIxkHR1onM/t43TkF2R
         9wpkE6tgVVugPUrfFhTAOcg7asUfRYaQiyRDUO6J+hL+f7ylQFmG0tdfMw+4WbKj8eEN
         HqK5AojpC12wLmCXCwTrUuD03r3rt+2bexbwI0s1OvZwg0UAjGfJPCy9Ts+ESlISJS27
         wXdPJlVM0CPTsn6I+LANiZunJDJu5qd7EEc+/wqQv3FKJRbv8etKfdcVUkQGas4+iWSW
         sxU1f+vPuTVSTZyMNXQL1War6VSEQvNd9qieS9jn0PwktNJzdreP1a0gPqJ6RMK/JPIx
         u3ow==
X-Gm-Message-State: APjAAAWnRSHrShnpmzlO5sJttq24Fw3kVAde4V3CWownIVKTsWgZNDum
        0KkrQTCmZCIVjIVZHhQAf/uoUaQOzDRkbw==
X-Google-Smtp-Source: APXvYqxEAXFyjdoXKzafqGEkrIy9z3rC+Rrm/F27mcsDXVsp4eQhlpm0Un4xkj/uMQaBbTWbiQ2AnQ==
X-Received: by 2002:ae9:e40f:: with SMTP id q15mr33657121qkc.241.1560971525444;
        Wed, 19 Jun 2019 12:12:05 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p64sm11955573qkf.60.2019.06.19.12.12.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:12:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: migrate the delayed refs rsv code
Date:   Wed, 19 Jun 2019 15:11:58 -0400
Message-Id: <20190619191201.16689-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619191201.16689-1-josef@toxicpanda.com>
References: <20190619191201.16689-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These belong with the delayed refs related code, not in extent-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |   9 ---
 fs/btrfs/delayed-ref.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  10 +++
 fs/btrfs/extent-tree.c | 175 ------------------------------------------------
 4 files changed, 187 insertions(+), 184 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9b8b8d07e66f..f6ba024cd273 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2606,8 +2606,6 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
 }
 
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
-bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
 					 const u64 start);
 void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg);
@@ -2768,13 +2766,6 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr);
-void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
-int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
-				  enum btrfs_reserve_flush_enum flush);
-void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *src,
-				       u64 num_bytes);
 int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a94fae897b3f..e24b3a7f9932 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -10,6 +10,7 @@
 #include "delayed-ref.h"
 #include "transaction.h"
 #include "qgroup.h"
+#include "space-info.h"
 
 struct kmem_cache *btrfs_delayed_ref_head_cachep;
 struct kmem_cache *btrfs_delayed_tree_ref_cachep;
@@ -24,6 +25,182 @@ struct kmem_cache *btrfs_delayed_extent_op_cachep;
  * of hammering updates on the extent allocation tree.
  */
 
+
+bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	bool ret = false;
+	u64 reserved;
+
+	spin_lock(&global_rsv->lock);
+	reserved = global_rsv->reserved;
+	spin_unlock(&global_rsv->lock);
+
+	/*
+	 * Since the global reserve is just kind of magic we don't really want
+	 * to rely on it to save our bacon, so if our size is more than the
+	 * delayed_refs_rsv and the global rsv then it's time to think about
+	 * bailing.
+	 */
+	spin_lock(&delayed_refs_rsv->lock);
+	reserved += delayed_refs_rsv->reserved;
+	if (delayed_refs_rsv->size >= reserved)
+		ret = true;
+	spin_unlock(&delayed_refs_rsv->lock);
+	return ret;
+}
+
+int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
+{
+	u64 num_entries =
+		atomic_read(&trans->transaction->delayed_refs.num_entries);
+	u64 avg_runtime;
+	u64 val;
+
+	smp_mb();
+	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
+	val = num_entries * avg_runtime;
+	if (val >= NSEC_PER_SEC)
+		return 1;
+	if (val >= NSEC_PER_SEC / 2)
+		return 2;
+
+	return btrfs_check_space_for_delayed_refs(trans->fs_info);
+}
+
+/**
+ * btrfs_delayed_refs_rsv_release - release a ref head's reservation.
+ * @fs_info - the fs_info for our fs.
+ * @nr - the number of items to drop.
+ *
+ * This drops the delayed ref head's count from the delayed refs rsv and frees
+ * any excess reservation we had.
+ */
+void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
+{
+	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
+	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, nr);
+	u64 released = 0;
+
+	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
+					     NULL);
+	if (released)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
+					      0, released, 0);
+}
+
+
+/*
+ * btrfs_update_delayed_refs_rsv - adjust the size of the delayed refs rsv
+ * @trans - the trans that may have generated delayed refs
+ *
+ * This is to be called anytime we may have adjusted trans->delayed_ref_updates,
+ * it'll calculate the additional size and add it to the delayed_refs_rsv.
+ */
+void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+	u64 num_bytes;
+
+	if (!trans->delayed_ref_updates)
+		return;
+
+	num_bytes = btrfs_calc_trans_metadata_size(fs_info,
+						   trans->delayed_ref_updates);
+	spin_lock(&delayed_rsv->lock);
+	delayed_rsv->size += num_bytes;
+	delayed_rsv->full = 0;
+	spin_unlock(&delayed_rsv->lock);
+	trans->delayed_ref_updates = 0;
+}
+
+/**
+ * btrfs_migrate_to_delayed_refs_rsv - transfer bytes to our delayed refs rsv.
+ * @fs_info - the fs info for our fs.
+ * @src - the source block rsv to transfer from.
+ * @num_bytes - the number of bytes to transfer.
+ *
+ * This transfers up to the num_bytes amount from the src rsv to the
+ * delayed_refs_rsv.  Any extra bytes are returned to the space info.
+ */
+void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
+				       struct btrfs_block_rsv *src,
+				       u64 num_bytes)
+{
+	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	u64 to_free = 0;
+
+	spin_lock(&src->lock);
+	src->reserved -= num_bytes;
+	src->size -= num_bytes;
+	spin_unlock(&src->lock);
+
+	spin_lock(&delayed_refs_rsv->lock);
+	if (delayed_refs_rsv->size > delayed_refs_rsv->reserved) {
+		u64 delta = delayed_refs_rsv->size -
+			delayed_refs_rsv->reserved;
+		if (num_bytes > delta) {
+			to_free = num_bytes - delta;
+			num_bytes = delta;
+		}
+	} else {
+		to_free = num_bytes;
+		num_bytes = 0;
+	}
+
+	if (num_bytes)
+		delayed_refs_rsv->reserved += num_bytes;
+	if (delayed_refs_rsv->reserved >= delayed_refs_rsv->size)
+		delayed_refs_rsv->full = 1;
+	spin_unlock(&delayed_refs_rsv->lock);
+
+	if (num_bytes)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
+					      0, num_bytes, 1);
+	if (to_free)
+		btrfs_space_info_add_old_bytes(fs_info,
+					       delayed_refs_rsv->space_info,
+					       to_free);
+}
+
+/**
+ * btrfs_delayed_refs_rsv_refill - refill based on our delayed refs usage.
+ * @fs_info - the fs_info for our fs.
+ * @flush - control how we can flush for this reservation.
+ *
+ * This will refill the delayed block_rsv up to 1 items size worth of space and
+ * will return -ENOSPC if we can't make the reservation.
+ */
+int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
+				  enum btrfs_reserve_flush_enum flush)
+{
+	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
+	u64 limit = btrfs_calc_trans_metadata_size(fs_info, 1);
+	u64 num_bytes = 0;
+	int ret = -ENOSPC;
+
+	spin_lock(&block_rsv->lock);
+	if (block_rsv->reserved < block_rsv->size) {
+		num_bytes = block_rsv->size - block_rsv->reserved;
+		num_bytes = min(num_bytes, limit);
+	}
+	spin_unlock(&block_rsv->lock);
+
+	if (!num_bytes)
+		return 0;
+
+	ret = btrfs_reserve_metadata_bytes(fs_info->extent_root, block_rsv,
+					   num_bytes, flush);
+	if (ret)
+		return ret;
+	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, 0);
+	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
+				      0, num_bytes, 1);
+	return 0;
+}
+
 /*
  * compare two delayed tree backrefs with same bytenr and type
  */
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index c18f93ea88ed..1c977e6d45dc 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -364,6 +364,16 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
+void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr);
+void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
+int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
+				  enum btrfs_reserve_flush_enum flush);
+void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
+				       struct btrfs_block_rsv *src,
+				       u64 num_bytes);
+int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
+bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
+
 /*
  * helper functions to cast a node into its container
  */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dffd338b01fc..0b94f17fa751 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2753,49 +2753,6 @@ u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes)
 	return num_csums;
 }
 
-bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	bool ret = false;
-	u64 reserved;
-
-	spin_lock(&global_rsv->lock);
-	reserved = global_rsv->reserved;
-	spin_unlock(&global_rsv->lock);
-
-	/*
-	 * Since the global reserve is just kind of magic we don't really want
-	 * to rely on it to save our bacon, so if our size is more than the
-	 * delayed_refs_rsv and the global rsv then it's time to think about
-	 * bailing.
-	 */
-	spin_lock(&delayed_refs_rsv->lock);
-	reserved += delayed_refs_rsv->reserved;
-	if (delayed_refs_rsv->size >= reserved)
-		ret = true;
-	spin_unlock(&delayed_refs_rsv->lock);
-	return ret;
-}
-
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
-{
-	u64 num_entries =
-		atomic_read(&trans->transaction->delayed_refs.num_entries);
-	u64 avg_runtime;
-	u64 val;
-
-	smp_mb();
-	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
-	val = num_entries * avg_runtime;
-	if (val >= NSEC_PER_SEC)
-		return 1;
-	if (val >= NSEC_PER_SEC / 2)
-		return 2;
-
-	return btrfs_check_space_for_delayed_refs(trans->fs_info);
-}
-
 /*
  * this starts processing the delayed reference count updates and
  * extent insertions we have queued up so far.  count can be
@@ -4349,91 +4306,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-/**
- * btrfs_migrate_to_delayed_refs_rsv - transfer bytes to our delayed refs rsv.
- * @fs_info - the fs info for our fs.
- * @src - the source block rsv to transfer from.
- * @num_bytes - the number of bytes to transfer.
- *
- * This transfers up to the num_bytes amount from the src rsv to the
- * delayed_refs_rsv.  Any extra bytes are returned to the space info.
- */
-void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *src,
-				       u64 num_bytes)
-{
-	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
-	u64 to_free = 0;
-
-	spin_lock(&src->lock);
-	src->reserved -= num_bytes;
-	src->size -= num_bytes;
-	spin_unlock(&src->lock);
-
-	spin_lock(&delayed_refs_rsv->lock);
-	if (delayed_refs_rsv->size > delayed_refs_rsv->reserved) {
-		u64 delta = delayed_refs_rsv->size -
-			delayed_refs_rsv->reserved;
-		if (num_bytes > delta) {
-			to_free = num_bytes - delta;
-			num_bytes = delta;
-		}
-	} else {
-		to_free = num_bytes;
-		num_bytes = 0;
-	}
-
-	if (num_bytes)
-		delayed_refs_rsv->reserved += num_bytes;
-	if (delayed_refs_rsv->reserved >= delayed_refs_rsv->size)
-		delayed_refs_rsv->full = 1;
-	spin_unlock(&delayed_refs_rsv->lock);
-
-	if (num_bytes)
-		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-					      0, num_bytes, 1);
-	if (to_free)
-		btrfs_space_info_add_old_bytes(fs_info,
-					       delayed_refs_rsv->space_info,
-					       to_free);
-}
-
-/**
- * btrfs_delayed_refs_rsv_refill - refill based on our delayed refs usage.
- * @fs_info - the fs_info for our fs.
- * @flush - control how we can flush for this reservation.
- *
- * This will refill the delayed block_rsv up to 1 items size worth of space and
- * will return -ENOSPC if we can't make the reservation.
- */
-int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
-				  enum btrfs_reserve_flush_enum flush)
-{
-	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 limit = btrfs_calc_trans_metadata_size(fs_info, 1);
-	u64 num_bytes = 0;
-	int ret = -ENOSPC;
-
-	spin_lock(&block_rsv->lock);
-	if (block_rsv->reserved < block_rsv->size) {
-		num_bytes = block_rsv->size - block_rsv->reserved;
-		num_bytes = min(num_bytes, limit);
-	}
-	spin_unlock(&block_rsv->lock);
-
-	if (!num_bytes)
-		return 0;
-
-	ret = btrfs_reserve_metadata_bytes(fs_info->extent_root, block_rsv,
-					   num_bytes, flush);
-	if (ret)
-		return ret;
-	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, 0);
-	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-				      0, num_bytes, 1);
-	return 0;
-}
-
 /**
  * btrfs_inode_rsv_release - release any excessive reservation.
  * @inode - the inode we need to release from.
@@ -4469,53 +4341,6 @@ static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
 						   qgroup_to_release);
 }
 
-/**
- * btrfs_delayed_refs_rsv_release - release a ref head's reservation.
- * @fs_info - the fs_info for our fs.
- * @nr - the number of items to drop.
- *
- * This drops the delayed ref head's count from the delayed refs rsv and frees
- * any excess reservation we had.
- */
-void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
-{
-	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, nr);
-	u64 released = 0;
-
-	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
-					     NULL);
-	if (released)
-		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-					      0, released, 0);
-}
-
-
-/*
- * btrfs_update_delayed_refs_rsv - adjust the size of the delayed refs rsv
- * @trans - the trans that may have generated delayed refs
- *
- * This is to be called anytime we may have adjusted trans->delayed_ref_updates,
- * it'll calculate the additional size and add it to the delayed_refs_rsv.
- */
-void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
-	u64 num_bytes;
-
-	if (!trans->delayed_ref_updates)
-		return;
-
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info,
-						   trans->delayed_ref_updates);
-	spin_lock(&delayed_rsv->lock);
-	delayed_rsv->size += num_bytes;
-	delayed_rsv->full = 0;
-	spin_unlock(&delayed_rsv->lock);
-	trans->delayed_ref_updates = 0;
-}
-
 /*
  * To be called after all the new block groups attached to the transaction
  * handle have been created (btrfs_create_pending_block_groups()).
-- 
2.14.3

