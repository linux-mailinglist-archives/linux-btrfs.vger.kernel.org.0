Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA854151158
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBCUuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:21 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:34799 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBCUuV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:21 -0500
Received: by mail-qt1-f178.google.com with SMTP id h12so12623723qtu.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPfUXCXzYP+P0uyVc7SQNfQlXWegRc9z8ogz9yCEgjA=;
        b=Ijbz9fXOZfJNy8rOUvUdvD/GTN/7O68+GKdzQMS5IJmQbscPfwfLY5xE5AiA+pGsKg
         EvhfWOupcgzzvIWXkg260R6SpgS2/npCU+lW/82OMxeLSXeJ6CTmKQkFc9xqPZ8b3FQU
         Am+T+BYOqnI59aZPSkCjVId5sHYrob9FqgJwQ9Kx8BccfhnjnH/Th8B34mEPO3vjOTJp
         So8GRevsmz33WHEGkgaIGCCfFUhWvvvl/s5VzFkYV1qmdYhIsXsILDiU6ersZLWXKcaV
         MD4EH+bLdNvfi5obt9KXHuSlqqzKlaRlbj4L1+WANhgLD2qdx9CsZrbOfYVdWjR3S2cy
         i3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPfUXCXzYP+P0uyVc7SQNfQlXWegRc9z8ogz9yCEgjA=;
        b=uZR1ybtkVAOjIyUUlJ7VE5okOImD9WklS2PkLsz1lhEX112Z/2tQJMmpXAHa6tGq+H
         div48gSd/+wVej5L1Gdv/o56dzdy5nIryp0kmWs2GYHoF77q2AzWMgxeuKzbvSYsPYtg
         74xpiquZ3idoiOAbajAiVr9Ou5oPet75KVaxyPJa0g8yLC6//VrPA+n7DxfuFsvT/LIO
         ynHBlNtZxommgw9qE2bRgb44Ej7tdrClDbYqAuJ2iEzIxz7IlGcOSjtSRxEUPDD6Wlc0
         7kUXMT9BTyHZIfrf8M2dFj2A01k/W5sFziirQyqsFcKeRW4/5oHZc/S3Syeh6f8R0dTT
         kNBg==
X-Gm-Message-State: APjAAAUg75Akpto3BoAwe5UmMDq51p9hOQbSiqGKFHVzkqx95GSUj7GX
        Mwr6EFjp3cZfN4xSHUNkFvCeYoOaVajh0g==
X-Google-Smtp-Source: APXvYqyleybyAZPmUrj/IcotahPMUYvtr/GrVPSuWH4Zf/FPtcEoY98UNw00a/PsH933Afv3taz47Q==
X-Received: by 2002:aed:3022:: with SMTP id 31mr25071925qte.282.1580763017369;
        Mon, 03 Feb 2020 12:50:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o187sm10042366qkf.26.2020.02.03.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 14/24] btrfs: add btrfs_reserve_data_bytes and use it
Date:   Mon,  3 Feb 2020 15:49:41 -0500
Message-Id: <20200203204951.517751-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 119 ++------------------------------------
 fs/btrfs/space-info.c     |  92 +++++++++++++++++++++++++++++
 fs/btrfs/space-info.h     |   2 +
 3 files changed, 98 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 08cfef49f88b..c13d8609cc99 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -13,126 +13,15 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
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
 
 int btrfs_check_data_free_space(struct inode *inode,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ad203717269c..6b71f6d3a348 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1082,3 +1082,95 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
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
index 24514cd2c6c1..179f757c4a6b 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -141,5 +141,7 @@ static inline void btrfs_space_info_free_bytes_may_use(
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
+int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+			     enum btrfs_reserve_flush_enum flush);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.24.1

