Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2C4D0A7F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiCGWFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245740AbiCGWFb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:31 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E043ADD
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s15so14566480qtk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KDX8CyomumN1AClXFWUP8VKLLnuQTPwXVNuayBxdF5g=;
        b=h7iUlVAeI6Sz6Zva4nQUF3josXgdWoX4TYQRL9O6gVd/fwxrQS7tKFB6WTqNLqOn/V
         hVVQGcqYz4nIOKQQBMpGwtE1R9hKXGQDpLMNK6BwmwqoMHBlv5tVocAJgyPkPgj8xUsN
         ZVIbfBTPsB9cMf3keCkmtDRZ6reCtefwkiy1YyFkcim4trQLK1cgDn5Yo4RAmBRzp+lw
         hiVSK0lx9zP3KeXlxF6/7NphWHDTooDmPLTEDye4LrR1u9NPdCRmqockvoA+rWPLHSbp
         7I7/t+7aoQPIfjX7aYYCzJYGOYmWrSrKjJMaWPMHzJUK40qv/+8mS6XPQVU3sZEt5HyX
         rbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDX8CyomumN1AClXFWUP8VKLLnuQTPwXVNuayBxdF5g=;
        b=P5IEwHDzLqpZtKR00hW8jte2SzdEWv89luWIIVRhP9hiZNsQWyRTLm2CzxWDIHfotf
         j2N05KQJANoPGLLzHbCvJZ7DpPAQ8UjxMGv9gmGnCz7pz/WVCVN34Lhl+nyboGNKG41t
         krmFDHSMhgMdKuOrrTBEjqJ3nuOXg31WjAO/F97KqIG+J19HSUsCWrQPu80MmapSrCrq
         Ep0v8EAwrVg9Pzcr+88JJJrkBoOkYI+RTshAxUT+GD/7tB4cL+X9F3TE5gCIv/bcodfb
         EvfG4u9je6CA+/CohTrnO3svvj/qQSLb9SUUQlZROW6+pdV4cfaGr1CBQoKcD1x6/utt
         vQ7A==
X-Gm-Message-State: AOAM5331WtZZZs5Xfg5meWVLn6AiaQrYyh5u84zUQiJp+cTnFWBrXdco
        IBVcF+5Ni7VFqjvOmS7a8Lic9y2l3ROGBDBx
X-Google-Smtp-Source: ABdhPJwkzQCgfwAgQuAgbN9K10DeLEjY71FbNTw1u+xPaBTma9ATA0x4EV74B48Lp31vVUPHYgxQnQ==
X-Received: by 2002:ac8:5a01:0:b0:2dd:2de2:58cf with SMTP id n1-20020ac85a01000000b002dd2de258cfmr10949007qta.199.1646690675338;
        Mon, 07 Mar 2022 14:04:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a152800b00648e52be61bsm6626051qkk.37.2022.03.07.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/6] btrfs: turn evict_refill_and_join into a real helper
Date:   Mon,  7 Mar 2022 17:04:26 -0500
Message-Id: <3f9ead1d713db3fafbbd871ddbf18d7ca2e6e2d7.1646690556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690555.git.josef@toxicpanda.com>
References: <cover.1646690555.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 0260c191c014..407ebaa7b48d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2851,7 +2851,7 @@ enum btrfs_reserve_flush_enum {
 	 * - Running delalloc and waiting for ordered extents
 	 * - Allocating a new chunk
 	 */
-	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_GC,
 
 	/*
 	 * Flush space by above mentioned methods and by:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e7143ff5523..80318da765c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5174,54 +5174,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
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
@@ -5292,7 +5244,7 @@ void btrfs_evict_inode(struct inode *inode)
 			.min_type = 0,
 		};
 
-		trans = evict_refill_and_join(root, rsv);
+		trans = btrfs_gc_rsv_refill_and_join(root, rsv);
 		if (IS_ERR(trans))
 			goto free_rsv;
 
@@ -5317,7 +5269,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
-	trans = evict_refill_and_join(root, rsv);
+	trans = btrfs_gc_rsv_refill_and_join(root, rsv);
 	if (!IS_ERR(trans)) {
 		trans->block_rsv = rsv;
 		btrfs_orphan_del(trans, BTRFS_I(inode));
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b87931a458eb..c1ff0f4e97df 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1401,7 +1401,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						priority_flush_states,
 						ARRAY_SIZE(priority_flush_states));
 		break;
-	case BTRFS_RESERVE_FLUSH_EVICT:
+	case BTRFS_RESERVE_FLUSH_GC:
 		priority_reclaim_metadata_space(fs_info, space_info, ticket,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
@@ -1459,7 +1459,7 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
 static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
 {
 	return (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
-		flush == BTRFS_RESERVE_FLUSH_EVICT);
+		flush == BTRFS_RESERVE_FLUSH_GC);
 }
 
 /**
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b008c5110958..d9671a9be696 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -887,6 +887,55 @@ static noinline void wait_for_commit(struct btrfs_transaction *commit,
 	}
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
index 970ff316069d..c28574ea731b 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -235,5 +235,7 @@ void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
+struct btrfs_trans_handle *btrfs_gc_rsv_refill_and_join(struct btrfs_root *root,
+							struct btrfs_block_rsv *rsv);
 
 #endif
-- 
2.26.3

