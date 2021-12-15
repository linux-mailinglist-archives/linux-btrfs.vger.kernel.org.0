Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA61847639E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhLOUoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:44:00 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A50C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i13so21446119qvm.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UxoD/yYgu4YzeEXCVjFF6aLmuXf6ylJRsYmshcH2Btw=;
        b=l+PkMhUjyagVmcRboPm/Vbr0zcF+DPAFCPpx0SXyIJWLVOHryvoYPrictF8M9EGlsu
         Iy41jsWbDvuCxrjnAV1n8WyvdRySp4XwlBpdOFPf205iMSbWDuEW2YDiddfbnbLqhy7V
         E7Il3cqxugU+FSJQ7JJRLc3dSYzL6arseLeUISJaEg2h4gdLj7/zxXuL409htRhf3TKB
         4RpPiPS6m1unuBwodbXYml0BW4mGS2Mz17IoXOyGVlCAMESJnmkuDwVCKv1NPJtVEcOQ
         FnJQh3nHfZ378fctYFa7H2FM3LMvYzrNiJ1dB+9y1x2f5ulu8us1i5Q4VxN7i7OhD1Wt
         6gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxoD/yYgu4YzeEXCVjFF6aLmuXf6ylJRsYmshcH2Btw=;
        b=G/zZPAHI9UeD49oXfU+H7BSdTzp6TB4mkwjS0qfgDFTrVsIKPcCXhxEJfGm2+DPMPi
         30zckATyQyr1a6MRgA8cvILsBciiuaR6JzbrNOmlG9C/hD0c/wG8a01yIYyYJsQxdrn4
         2/tTvET7XARBnomGistMqCeWz9auIu6oRsW4e6JQxjVdX0bdepD3akEsBh3N8+PAjI7r
         DLGzYKqHvps2PatqvkOkfsQ07srTvfgPCdFTh3Ex4bR3yF+s5NixZ4mTmSSssh0Tli+0
         57oXSPO2iAJfhfQsxmPitknYHucaopsRiPVrjvu1zrP7HAbME+8BSqTulYiTLmu5CHMv
         M8mQ==
X-Gm-Message-State: AOAM532ET5w9a5KwgpD4PARGIVvu/kgqzbnPxmmwCFzilHiACAwMUPhR
        tVTgjhGTJHJugu7L156K1RKz4r5gAOVR3w==
X-Google-Smtp-Source: ABdhPJzkiZDiSfU3mRqRK7kHA4j0yt7xfV/AuXXKc73EdPqSpwhFNETWEUZwYQqyAW2k9kt2yfCCNA==
X-Received: by 2002:a05:6214:23ca:: with SMTP id hr10mr13051621qvb.78.1639601038547;
        Wed, 15 Dec 2021 12:43:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl16sm1684907qkb.44.2021.12.15.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: turn evict_refill_and_join into a real helper
Date:   Wed, 15 Dec 2021 15:43:44 -0500
Message-Id: <35a12bfece14759aff2121c60ff110ef878bb893.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to be using this same mechanism for garbage collection as
evict uses.  Rename the flush state to be reflective of the role in GC
it will play from now own, and move the helper to transaction.c, rename
it and make it public.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/inode.c       | 52 ++----------------------------------------
 fs/btrfs/space-info.c  |  4 ++--
 fs/btrfs/transaction.c | 49 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.h |  2 ++
 5 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6bcf112f9872..720ea66e37c1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2830,7 +2830,7 @@ enum btrfs_reserve_flush_enum {
 	 * - Running delalloc and waiting for ordered extents
 	 * - Allocating a new chunk
 	 */
-	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_GC,
 
 	/*
 	 * Flush space by above mentioned methods and by:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3d590a96f5d0..cc4e077686c3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5147,54 +5147,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	spin_unlock(&io_tree->lock);
 }
 
-static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
-							struct btrfs_block_rsv *rsv)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *trans;
-	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
-	int ret;
-
-	/*
-	 * Eviction should be taking place at some place safe because of our
-	 * delayed iputs.  However the normal flushing code will run delayed
-	 * iputs, so we cannot use FLUSH_ALL otherwise we'll deadlock.
-	 *
-	 * We reserve the delayed_refs_extra here again because we can't use
-	 * btrfs_start_transaction(root, 0) for the same deadlocky reason as
-	 * above.  We reserve our extra bit here because we generate a ton of
-	 * delayed refs activity by truncating.
-	 *
-	 * BTRFS_RESERVE_FLUSH_EVICT will steal from the global_rsv if it can,
-	 * if we fail to make this reservation we can re-try without the
-	 * delayed_refs_extra so we can make some forward progress.
-	 */
-	ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size + delayed_refs_extra,
-				     BTRFS_RESERVE_FLUSH_EVICT);
-	if (ret) {
-		ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size,
-					     BTRFS_RESERVE_FLUSH_EVICT);
-		if (ret) {
-			btrfs_warn(fs_info,
-				   "could not allocate space for delete; will truncate on mount");
-			return ERR_PTR(-ENOSPC);
-		}
-		delayed_refs_extra = 0;
-	}
-
-	trans = btrfs_join_transaction(root);
-	if (IS_ERR(trans))
-		return trans;
-
-	if (delayed_refs_extra) {
-		trans->block_rsv = &fs_info->trans_block_rsv;
-		trans->bytes_reserved = delayed_refs_extra;
-		btrfs_block_rsv_migrate(rsv, trans->block_rsv,
-					delayed_refs_extra, 1);
-	}
-	return trans;
-}
-
 void btrfs_evict_inode(struct inode *inode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -5265,7 +5217,7 @@ void btrfs_evict_inode(struct inode *inode)
 			.min_type = 0,
 		};
 
-		trans = evict_refill_and_join(root, rsv);
+		trans = btrfs_gc_rsv_refill_and_join(root, rsv);
 		if (IS_ERR(trans))
 			goto free_rsv;
 
@@ -5290,7 +5242,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
-	trans = evict_refill_and_join(root, rsv);
+	trans = btrfs_gc_rsv_refill_and_join(root, rsv);
 	if (!IS_ERR(trans)) {
 		trans->block_rsv = rsv;
 		btrfs_orphan_del(trans, BTRFS_I(inode));
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 79fe0ad17acf..5c4834b591cd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1398,7 +1398,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						priority_flush_states,
 						ARRAY_SIZE(priority_flush_states));
 		break;
-	case BTRFS_RESERVE_FLUSH_EVICT:
+	case BTRFS_RESERVE_FLUSH_GC:
 		priority_reclaim_metadata_space(fs_info, space_info, ticket,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
@@ -1456,7 +1456,7 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
 static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
 {
 	return (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
-		flush == BTRFS_RESERVE_FLUSH_EVICT);
+		flush == BTRFS_RESERVE_FLUSH_GC);
 }
 
 /**
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0b73b3ad1e57..5a5a72a32e76 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -857,6 +857,55 @@ static noinline void wait_for_commit(struct btrfs_transaction *commit,
 	wait_event(commit->commit_wait, commit->state >= min_state);
 }
 
+/**
+ * btrfs_gc_rsv_refill_and_join - refill a block rsv and join transaction for gc
+ * @root: the root we're modifying
+ * @rsv: the rsv we're refilling
+ * @return: trans handle with a refilled block_rsv
+ *
+ * Inode eviction or GC will be taking place somewhere safe because of either
+ * delayed iputs or the GC threads.  However the normal flushing behavior
+ * may want to wait on eviction or GC in order to reclaim some space.
+ *
+ * This refills the rsv, and also adds some extra for the delayed refs that may
+ * be generated by the operation.  If it cannot get the delayed refs reservation
+ * it'll reduce the reservation so we can possibly make progress.
+ *
+ * This will also steal from the global reserve if it needs to.
+ */
+struct btrfs_trans_handle *btrfs_gc_rsv_refill_and_join(struct btrfs_root *root,
+							struct btrfs_block_rsv *rsv)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_trans_handle *trans;
+	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
+	int ret;
+
+	ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size + delayed_refs_extra,
+				     BTRFS_RESERVE_FLUSH_GC);
+	if (ret) {
+		ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size,
+					     BTRFS_RESERVE_FLUSH_GC);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "could not allocate space for delete; will truncate on mount");
+			return ERR_PTR(-ENOSPC);
+		}
+		delayed_refs_extra = 0;
+	}
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return trans;
+
+	if (delayed_refs_extra) {
+		trans->block_rsv = &fs_info->trans_block_rsv;
+		trans->bytes_reserved = delayed_refs_extra;
+		btrfs_block_rsv_migrate(rsv, trans->block_rsv,
+					delayed_refs_extra, 1);
+	}
+	return trans;
+}
 int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 {
 	struct btrfs_transaction *cur_trans = NULL, *t;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 1852ed9de7fd..2aac8aaeddba 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -232,5 +232,7 @@ void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
+struct btrfs_trans_handle *btrfs_gc_rsv_refill_and_join(struct btrfs_root *root,
+							struct btrfs_block_rsv *rsv);
 
 #endif
-- 
2.26.3

