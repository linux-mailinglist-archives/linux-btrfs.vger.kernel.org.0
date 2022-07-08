Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0256B284
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiGHGH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiGHGHz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:07:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A113E94
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:07:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AB1D1FEDD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657260473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz2bEiSwIdIiGaHR7a5bXnsiD1umOCyKtnAjAQcDlKU=;
        b=YndXXZ3Plteu5Z9dJPwHFtTlTcoaKMBNkRt5c/rzMPtci8fIwrUHuc7/rXkaa4Ghh+JgcE
        qhrYu21+cCubqvfapXTBPGxukdIULv0yK9+d6dX95x0HYj9DXyF0R0SGrwYCcRw7k0P5iA
        ePm1BfCwYHpGuFtvETDX5o1G4sXH5CI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B00AF13A80
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8M4dHrjJx2KUcgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 06:07:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/5] btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
Date:   Fri,  8 Jul 2022 14:07:28 +0800
Message-Id: <ef0d66812e6b06f5717d46e21ee221e79ced3c1a.1657260271.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657260271.git.wqu@suse.com>
References: <cover.1657260271.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/btrfs/qgroup.c | 46 +++++++++++++++++++++++++++++-----------------
 fs/btrfs/qgroup.h |  2 ++
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c2d07995516b..57e24a8ebc2a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -333,6 +333,14 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
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
@@ -401,7 +409,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			}
 			if (btrfs_qgroup_status_generation(l, ptr) !=
 			    fs_info->generation) {
-				flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+				qgroup_mark_inconsistent(fs_info);
 				btrfs_err(fs_info,
 					"qgroup generation mismatch, marked as inconsistent");
 			}
@@ -419,7 +427,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		if ((qgroup && found_key.type == BTRFS_QGROUP_INFO_KEY) ||
 		    (!qgroup && found_key.type == BTRFS_QGROUP_LIMIT_KEY)) {
 			btrfs_err(fs_info, "inconsistent qgroup config");
-			flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 		}
 		if (!qgroup) {
 			qgroup = add_qgroup_rb(fs_info, found_key.offset);
@@ -1719,7 +1727,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	ret = update_qgroup_limit_item(trans, qgroup);
 	if (ret) {
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 		btrfs_info(fs_info, "unable to update quota limit for %llu",
 		       qgroupid);
 	}
@@ -1795,7 +1803,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
-		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(trans->fs_info);
 		btrfs_warn(trans->fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
 			ret);
@@ -2271,7 +2279,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(dst_path);
 	if (ret < 0)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -2775,12 +2783,10 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
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
@@ -2791,7 +2797,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 
 	ret = update_qgroup_status_item(trans);
 	if (ret)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 
 	return ret;
 }
@@ -2909,7 +2915,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		ret = update_qgroup_limit_item(trans, dstgroup);
 		if (ret) {
-			fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			qgroup_mark_inconsistent(fs_info);
 			btrfs_info(fs_info,
 				   "unable to update quota limit for %llu",
 				   dstgroup->qgroupid);
@@ -3015,7 +3021,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -3288,7 +3294,8 @@ static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_fs_closing(fs_info) ||
 		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state) ||
-		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+		!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) ||
+		fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 }
 
 static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
@@ -3353,7 +3360,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (!stopped)
+	if (!stopped ||
+	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN)
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 	if (trans) {
 		ret = update_qgroup_status_item(trans);
@@ -3364,6 +3372,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 		}
 	}
 	fs_info->qgroup_rescan_running = false;
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 	complete_all(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
@@ -3374,6 +3383,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	if (stopped) {
 		btrfs_info(fs_info, "qgroup scan paused");
+	} else if (fs_info->qgroup_flags &
+		   BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN) {
+		btrfs_info(fs_info, "qgroup scan cancelled");
 	} else if (err >= 0) {
 		btrfs_info(fs_info, "qgroup scan completed%s",
 			err > 0 ? " (inconsistency flag cleared)" : "");
@@ -3436,6 +3448,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
 		sizeof(fs_info->qgroup_rescan_progress));
+	fs_info->qgroup_flags &= ~BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN;
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -4233,8 +4246,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	spin_unlock(&blocks->lock);
 out:
 	if (ret < 0)
-		fs_info->qgroup_flags |=
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	return ret;
 }
 
@@ -4321,7 +4333,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		btrfs_err_rl(fs_info,
 			     "failed to account subtree at bytenr %llu: %d",
 			     subvol_eb->start, ret);
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		qgroup_mark_inconsistent(fs_info);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 0c4dd2a9af96..90d3632c5524 100644
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
2.36.1

