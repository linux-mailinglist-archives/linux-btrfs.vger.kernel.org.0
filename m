Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3748E2189B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgGHOAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46801C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e11so41615064qkm.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLDtuOZfkhQLfDpyxeUamy76vLbqLUpJJ6K47Azp3Ws=;
        b=LudqmNq+mRcMy9fnxKhBiPkyMOXrIhbEnEczDhTzAU6iaK6la6svf9jYC64CQ2oLd9
         7WFphznUgjdx/4pyhuMpMDNx/sr4vbqdlrd1Ffmg/+1nWLYYE5gKXHWjby/g7sRaNUs8
         iI3EO+XU5/GEDwpB0I3BvSB54lJvraOEE0n98bAC5OXldo1lE7Mq+lQ3um4/XTTc0h2d
         dWuFnv+QJoiHvCZ5VEXd8r6m+OPMhwqLqC8HNUUWoltwqpTj5Ij3j1FN9msf9h8Myq4w
         vX1TQc46RrqtHUe5a9GNor9eLsBczcPH8fhNFVyKvkwXX4jyimYM4LXN75XrvQxGZQyB
         ux+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLDtuOZfkhQLfDpyxeUamy76vLbqLUpJJ6K47Azp3Ws=;
        b=Lqy9ptKbRlAfhvh+OTFSK7dzloWtRAcbcBZmjh4aHC7t9tVtZYDiHc2pKGR1aeh6gB
         23bSBhVzgMUOe3bWL3IHqap5/RGeFPMkK+duApkEXE0GO8YD84hO5cxgaNQWcEDffIi1
         TVzdTW8oGwkXSO89XQ958UGMAHRBrjng/IaNnIWyAXiJMOio+DpPLOz6GorrygM6bVTW
         ZjJM86bOzRdhGcNmHPBTZAZSKGVRHo4EFEkRwVABAdDz9C9FA7T/QCtwpOEuj1UsMh1S
         w5Gx3ngqah6ahkOgRFQfnR+8GMaw0s0rwtRb4tWHOZRg/UBRarne5KdBJWmAqq9N/CiA
         2wow==
X-Gm-Message-State: AOAM531Ai4m2ph5l9hnj8JrqvNEEibiz0GvIhR1LxulLS/81YSmAw6A3
        w3O+xZj0d35212VE0oAV9hZFuEehX+VEcA==
X-Google-Smtp-Source: ABdhPJxDT/r2mrQt553qJePIWOVUBHuNuTZuu2QuDEHQwYb+xVHIKU1dDUicvz/1IL/vSwqkwsQzPw==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr53626505qkd.48.1594216847910;
        Wed, 08 Jul 2020 07:00:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm26676701qka.23.2020.07.08.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 14/23] btrfs: add btrfs_reserve_data_bytes and use it
Date:   Wed,  8 Jul 2020 10:00:04 -0400
Message-Id: <20200708140013.56994-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a new function btrfs_reserve_data_bytes() in order to handle data
reservations.  This uses the new flush types and flush states to handle
making data reservations.

This patch specifically does not change any functionality, and is
purposefully not cleaned up in order to make bisection easier for the
future patches.  The new helper is identical to the old helper in how it
handles data reservations.  We first try to force a chunk allocation,
and then we run through the flush states all at once and in the same
order that they were done with the old helper.

Subsequent patches will clean this up and change the behavior of the
flushing, and it is important to keep those changes separate so we can
easily bisect down to the patch that caused the regression, rather than
the patch that made us start using the new infrastructure.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 119 ++------------------------------------
 fs/btrfs/space-info.c     |  92 +++++++++++++++++++++++++++++
 fs/btrfs/space-info.h     |   2 +
 3 files changed, 98 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 0a41bdcc14d1..bacee09b7bfd 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -115,126 +115,15 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	u64 used;
-	int ret = 0;
-	int need_commit = 2;
-	int have_pinned_space;
+	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_DATA;
 
 	/* Make sure bytes are sectorsize aligned */
 	bytes = ALIGN(bytes, fs_info->sectorsize);
 
-	if (btrfs_is_free_space_inode(inode)) {
-		need_commit = 0;
-		ASSERT(current->journal_info);
-	}
-
-again:
-	/* Make sure we have enough space to handle the data first */
-	spin_lock(&data_sinfo->lock);
-	used = btrfs_space_info_used(data_sinfo, true);
-
-	if (used + bytes > data_sinfo->total_bytes) {
-		struct btrfs_trans_handle *trans;
-
-		/*
-		 * If we don't have enough free bytes in this space then we need
-		 * to alloc a new chunk.
-		 */
-		if (!data_sinfo->full) {
-			u64 alloc_target;
-
-			data_sinfo->force_alloc = CHUNK_ALLOC_FORCE;
-			spin_unlock(&data_sinfo->lock);
-
-			alloc_target = btrfs_data_alloc_profile(fs_info);
-			/*
-			 * It is ugly that we don't call nolock join
-			 * transaction for the free space inode case here.
-			 * But it is safe because we only do the data space
-			 * reservation for the free space cache in the
-			 * transaction context, the common join transaction
-			 * just increase the counter of the current transaction
-			 * handler, doesn't try to acquire the trans_lock of
-			 * the fs.
-			 */
-			trans = btrfs_join_transaction(root);
-			if (IS_ERR(trans))
-				return PTR_ERR(trans);
-
-			ret = btrfs_chunk_alloc(trans, alloc_target,
-						CHUNK_ALLOC_NO_FORCE);
-			btrfs_end_transaction(trans);
-			if (ret < 0) {
-				if (ret != -ENOSPC)
-					return ret;
-				else {
-					have_pinned_space = 1;
-					goto commit_trans;
-				}
-			}
-
-			goto again;
-		}
-
-		/*
-		 * If we don't have enough pinned space to deal with this
-		 * allocation, and no removed chunk in current transaction,
-		 * don't bother committing the transaction.
-		 */
-		have_pinned_space = __percpu_counter_compare(
-			&data_sinfo->total_bytes_pinned,
-			used + bytes - data_sinfo->total_bytes,
-			BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		spin_unlock(&data_sinfo->lock);
-
-		/* Commit the current transaction and try again */
-commit_trans:
-		if (need_commit) {
-			need_commit--;
-
-			if (need_commit > 0) {
-				btrfs_start_delalloc_roots(fs_info, -1);
-				btrfs_wait_ordered_roots(fs_info, U64_MAX, 0,
-							 (u64)-1);
-			}
-
-			trans = btrfs_join_transaction(root);
-			if (IS_ERR(trans))
-				return PTR_ERR(trans);
-			if (have_pinned_space >= 0 ||
-			    test_bit(BTRFS_TRANS_HAVE_FREE_BGS,
-				     &trans->transaction->flags) ||
-			    need_commit > 0) {
-				ret = btrfs_commit_transaction(trans);
-				if (ret)
-					return ret;
-				/*
-				 * The cleaner kthread might still be doing iput
-				 * operations. Wait for it to finish so that
-				 * more space is released.  We don't need to
-				 * explicitly run the delayed iputs here because
-				 * the commit_transaction would have woken up
-				 * the cleaner.
-				 */
-				ret = btrfs_wait_on_delayed_iputs(fs_info);
-				if (ret)
-					return ret;
-				goto again;
-			} else {
-				btrfs_end_transaction(trans);
-			}
-		}
-
-		trace_btrfs_space_reservation(fs_info,
-					      "space_info:enospc",
-					      data_sinfo->flags, bytes, 1);
-		return -ENOSPC;
-	}
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-	spin_unlock(&data_sinfo->lock);
+	if (btrfs_is_free_space_inode(inode))
+		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	return 0;
+	return btrfs_reserve_data_bytes(fs_info, bytes, flush);
 }
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index be0f117d4ccf..3a61cdfe4b21 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1329,3 +1329,95 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	}
 	return ret;
 }
+
+/**
+ * btrfs_reserve_data_bytes - try to reserve data bytes for an allocation
+ * @root - the root we are allocating for
+ * @bytes - the number of bytes we need
+ * @flush - how we are allowed to flush
+ *
+ * This will reserve bytes from the data space info.  If there is not enough
+ * space then we will attempt to flush space as specified ty flush.
+ */
+int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+			     enum btrfs_reserve_flush_enum flush)
+{
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	const enum btrfs_flush_state *states = NULL;
+	u64 used;
+	int states_nr = 0;
+	int commit_cycles = 2;
+	int ret = -ENOSPC;
+
+	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
+
+	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
+		states = data_flush_states;
+		states_nr = ARRAY_SIZE(data_flush_states);
+	}
+
+	spin_lock(&data_sinfo->lock);
+again:
+	used = btrfs_space_info_used(data_sinfo, true);
+
+	if (used + bytes > data_sinfo->total_bytes) {
+		u64 prev_total_bytes = data_sinfo->total_bytes;
+		int flush_state = 0;
+
+		spin_unlock(&data_sinfo->lock);
+
+		/*
+		 * Everybody can force chunk allocation, so try this first to
+		 * see if we can just bail here and make our reservation.
+		 */
+		flush_space(fs_info, data_sinfo, bytes, ALLOC_CHUNK_FORCE);
+		spin_lock(&data_sinfo->lock);
+		if (prev_total_bytes < data_sinfo->total_bytes)
+			goto again;
+		spin_unlock(&data_sinfo->lock);
+
+		/*
+		 * Cycle through the rest of the flushing options for our flush
+		 * type, then try again.
+		 */
+		while (flush_state < states_nr) {
+			u64 flush_bytes = U64_MAX;
+
+			/*
+			 * Previously we unconditionally committed the
+			 * transaction twice before finally checking against
+			 * pinned space before committing the final time.  We
+			 * also skipped flushing delalloc the final pass
+			 * through.
+			 */
+			if (!commit_cycles) {
+				if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
+					flush_state++;
+					continue;
+				}
+				if (states[flush_state] == COMMIT_TRANS)
+					flush_bytes = bytes;
+			}
+
+			flush_space(fs_info, data_sinfo, flush_bytes,
+				    states[flush_state]);
+			flush_state++;
+		}
+
+		if (!commit_cycles)
+			goto out;
+
+		commit_cycles--;
+		spin_lock(&data_sinfo->lock);
+		goto again;
+	}
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
+	ret = 0;
+	spin_unlock(&data_sinfo->lock);
+out:
+	if (ret)
+		trace_btrfs_space_reservation(fs_info,
+					      "space_info:enospc",
+					      data_sinfo->flags, bytes, 1);
+	return ret;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c3c64019950a..5646393b928c 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -149,5 +149,7 @@ static inline void btrfs_space_info_free_bytes_may_use(
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
+int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+			     enum btrfs_reserve_flush_enum flush);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.24.1

