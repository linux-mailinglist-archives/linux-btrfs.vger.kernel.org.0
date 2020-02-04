Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC89151E2A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBDQUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:19 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38560 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBDQUS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:18 -0500
Received: by mail-qk1-f176.google.com with SMTP id 21so1398598qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ml4te/Tasr0lZdnFVdndDd9AxLPn2TqpVruec3vXXcQ=;
        b=n5gU8RaJwqYLSJZ9t8YLRBI0D7ff0DAChV+3D9aNh4f64mmMPhCONuNOQMrjXE2qmK
         jm9XwLkYIx1tktLAYQEyElLbmQWw5qxlCjQJtZM3zUvKAgn22R/J/HZhTTslo7t2op6W
         dR6rKbC/K5V1F8UgxsBGDGwpMPR0T85E1FTXHQs/Hkaw6dWxuW5gg7XKeCL6pZt3SSNA
         KQOu8zbC4WrjCV6Cd8ybPEQ9AY91BTb2JLKe+gSYz8wPLL5XoI5i2HpJv2u81DSNibNX
         lIZSGBRs8dOm2CZNWX5u5Asu/XU926qIXk/qklhQ3FnJcfJqjtXN+qWp1/RNMOdMDHHM
         F1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ml4te/Tasr0lZdnFVdndDd9AxLPn2TqpVruec3vXXcQ=;
        b=CKX7X5g0r1nWbsw7O6nDcjeU/eVAItIcWiIB74oBHmuZ+u5VzN46GhXDnMYc+J7F8f
         OH/g+6iMBCVEujywE/NOQhnhZP4eZEtIyydQXIs5Ec6iMBB2Tqz93XKO9Ym2ZwxQUYp3
         Nk/FMwapXpt03XQx0U7RJX4VvPvhzhRdp+DJu90/d716cb0c+mmBef4hJbvV5hY+71dC
         lurdua0bUAolmqOx92qwfyPfRvgpq+ADWzzXQBbbguysdVvTNeMpgCdhTYhMA19UW/p5
         6nSamT4ZTNa2L1UH6oe4775bWdGb2KNc+m52hiYzROfhIzYfXtBHVW34oIcz1UYlXouE
         +d0Q==
X-Gm-Message-State: APjAAAWn1s85XEfFL+crUtfbr1z6gmWDoivvgN5zWJeUvtoDp88zmSPT
        iYzluw+HT426SnjbTMGLx76xsL+d+bmImw==
X-Google-Smtp-Source: APXvYqyZ1xSbFI+fO3VEWfJuul4K0+U7883rn4p4JIng8N7ST+XknzfUwQZgd1mceCGM09TE/+Qzwg==
X-Received: by 2002:a37:a482:: with SMTP id n124mr30016338qke.224.1580833217264;
        Tue, 04 Feb 2020 08:20:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d9sm11594580qtw.32.2020.02.04.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 14/23] btrfs: add btrfs_reserve_data_bytes and use it
Date:   Tue,  4 Feb 2020 11:19:42 -0500
Message-Id: <20200204161951.764935-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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

