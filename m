Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499A3FC518
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHaJuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 05:50:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhHaJuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 05:50:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 143C52013A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pS2c28nIrOPIrZDykBJuvWp9yl056jK1Is+JSVjHEM=;
        b=Ro9PFmCYx9bvOEpSnNYTEWi7LiPRLFfOS6i2kQKVS9qpuScEhmcalymqv5BPcX524KQjKq
        RpfY3oSFrAJes9G5imoMVlp9Nx2hbKL5RJ2+0EaHyIL+P3hobykIbdtJeGslGf+WW8j7cN
        un/zYEWAXi4Xjxks6VqmFN8arly6BHI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3E271136DF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UMSDOhX7LWGMcgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
Date:   Tue, 31 Aug 2021 17:49:01 +0800
Message-Id: <20210831094903.111432-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831094903.111432-1-wqu@suse.com>
References: <20210831094903.111432-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here we introduce a new runtime flag,
BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN, which will inform qgroup rescan
to cancel its work asynchronously.

This is to address the window when an operation makes qgroup numbers
inconsistent (like qgroup inheriting) while a qgroup rescan is running.

In that case, qgroup inconsistent flag will be cleared when qgroup
rescan finishes.
But we changed the ownership of some extents, which means the rescan is
already meaningless, and the qgroup inconsistent flag should not be
cleared.

With the new flag, each time we set INCONSISTENT flag, we also set this
new flag to inform any running qgroup rescan to exit immediately, and
leaving the INCONSISTENT flag there.

The new runtime flag can only be cleared when a new rescan is started.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 49 ++++++++++++++++++++++++++++++-----------------
 fs/btrfs/qgroup.h |  2 ++
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9babf925bd59..91657ba1ebd1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -322,6 +322,14 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 }
 #endif
 
+static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
+{
+	BUILD_BUG_ON(BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN &
+		     BTRFS_QGROUP_STATUS_FLAGS_MASK);
+	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
+				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN);
+}
+
 /*
  * The full config is read in one go, only called from open_ctree()
  * It doesn't use any locking, as at this point we're still single-threaded
@@ -390,7 +398,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			}
 			if (btrfs_qgroup_status_generation(l, ptr) !=
 			    fs_info->generation) {
-				flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+				qgroup_mark_inconsistent(fs_info);
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
 			}
@@ -408,7 +416,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		if ((qgroup && found_key.type == BTRFS_QGROUP_INFO_KEY) ||
 		    (!qgroup && found_key.type == BTRFS_QGROUP_LIMIT_KEY)) {
 			btrfs_err(fs_info, "inconsistent qgroup config");
-			flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 		}
 		if (!qgroup) {
 			qgroup = add_qgroup_rb(fs_info, found_key.offset);
@@ -1661,7 +1669,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	ret = update_qgroup_limit_item(trans, qgroup);
 	if (ret) {
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 		btrfs_info(fs_info, "unable to update quota limit for %llu",
 		       qgroupid);
 	}
@@ -1737,7 +1745,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
-		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(trans->fs_info);
 		btrfs_warn(trans->fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
 			ret);
@@ -2213,7 +2221,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(dst_path);
 	if (ret < 0)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -2717,12 +2725,10 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		spin_unlock(&fs_info->qgroup_lock);
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
-			fs_info->qgroup_flags |=
-					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 		ret = update_qgroup_limit_item(trans, qgroup);
 		if (ret)
-			fs_info->qgroup_flags |=
-					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 		spin_lock(&fs_info->qgroup_lock);
 	}
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
@@ -2733,7 +2739,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 
 	ret = update_qgroup_status_item(trans);
 	if (ret)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 
 	return ret;
 }
@@ -2851,7 +2857,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		ret = update_qgroup_limit_item(trans, dstgroup);
 		if (ret) {
-			fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 			btrfs_info(fs_info,
 				   "unable to update quota limit for %llu",
 				   dstgroup->qgroupid);
@@ -2957,7 +2963,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -3226,7 +3232,8 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_fs_closing(fs_info) ||
-		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
+		fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 }
 
 static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
@@ -3274,7 +3281,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	if (err > 0 &&
 	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	} else if (err < 0) {
+	} else if (err < 0 ||
+		   fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -3293,7 +3301,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (!stopped)
+	if (!stopped ||
+	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN)
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 	if (trans) {
 		ret = update_qgroup_status_item(trans);
@@ -3304,6 +3313,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 		}
 	}
 	fs_info->qgroup_rescan_running = false;
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 	complete_all(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
@@ -3314,6 +3324,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	if (stopped) {
 		btrfs_info(fs_info, "qgroup scan paused");
+	} else if (fs_info->qgroup_flags &
+		   BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN) {
+		btrfs_info(fs_info, "qgroup scan cancelled");
 	} else if (err >= 0) {
 		btrfs_info(fs_info, "qgroup scan completed%s",
 			err > 0 ? " (inconsistency flag cleared)" : "");
@@ -3373,6 +3386,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
 		sizeof(fs_info->qgroup_rescan_progress));
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -4169,8 +4183,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	spin_unlock(&blocks->lock);
 out:
 	if (ret < 0)
-		fs_info->qgroup_flags |=
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -4257,7 +4270,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		btrfs_err_rl(fs_info,
 			     "failed to account subtree at bytenr %llu: %d",
 			     subvol_eb->start, ret);
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 880e9df0dac1..f92e635bfb69 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -100,6 +100,8 @@
  *     subtree rescan for them.
  */
 
+#define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1UL << 3)
+
 /*
  * Record a dirty extent, and info qgroup to update quota on it
  * TODO: Use kmem cache to alloc it.
-- 
2.33.0

