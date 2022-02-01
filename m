Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D274A5C99
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiBAMxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 07:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiBAMxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 07:53:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33477C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 04:53:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c194so3277717pfb.12
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dotEMfFhS/NO8kmwOcyiW0XM+CUOjaSJyaiEO4lrQg=;
        b=dwtx789Wz+AkPTq4D8sJ82Vor76TGUOpDT7cTNzYNpIs1tA+Jp35IZkoS785ey8Wcr
         L8EhFCr/RvoiLHBeP/NIU/mYN7EINftrWCb+EtPjjSDZLzwNVsrZxhqCIc3om4mE3Jk7
         HvwCNfKFxQI9grH0+51Lzq+QZQKw1oqeR0f7jFwTRqZWhy8bKUzfhaTk7QSK2nO39fJP
         HEeogYL+Hs3d57I89JdaD2aPezQXQxLLHJbzFAQsCJm4ZixGcsrQVEQAb68Ceffqgfzs
         BplICsI1ZJ1JrR2VrRR86VB8uyA0kC6V8jXiu6x3diuOxhwDZaF37fyUxfcoq4LB0FMa
         Lb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dotEMfFhS/NO8kmwOcyiW0XM+CUOjaSJyaiEO4lrQg=;
        b=rCNzWRue2lV5vByyUzXCH8f8aD+VmIYwOPgUaj31SzT8AlHtSjmvktLO0GGFIXwlET
         8Hr/toyh3B3gPa6aZ94vqIWgWZaUEWUzQNvsJlX2ZxuMyzzDOs3uw9fA0VnQ1cG/O0oa
         bxwiP2WiyEmEV3FvXqRzW7ir5fXwgqhFATJt6hmNJESHPEbMvBJ7FYJv8R3uFzzs5Uk7
         9/Si5+ZS8SOirfpWJ1MnNZj7O11RjWyuJIquw50QhW/3C92kyg5E8UuvAIST/eMpg28M
         jAkBcYPSnuNOWFFku2O066rTrkU9h1I6P2zIJpVr4S4k3b0w+s1HNAO7a5X39fTMhFxl
         p+mg==
X-Gm-Message-State: AOAM5313o0vOqyJwJYZSWSY4WICu8z//kmuyd/KUWDSNFMiIlPzC9Bo2
        lMHgLSpjeDmasOvKexuMAgPWw1eTJgE+yg==
X-Google-Smtp-Source: ABdhPJyK+aqGuxOikleyiVounmAkLAzbYr4bT9TuaVdeNgAnyBHkzX1VAMG7HbZY/Slg7Fc5Ail3Fg==
X-Received: by 2002:a63:8ac9:: with SMTP id y192mr20251232pgd.409.1643720018551;
        Tue, 01 Feb 2022 04:53:38 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y42sm22969633pfa.5.2022.02.01.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 04:53:38 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: replace modifing qgroup_flags to bitops
Date:   Tue,  1 Feb 2022 12:53:31 +0000
Message-Id: <20220201125331.260482-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch replaces the code modifying or checking qgroup_flags to
bitops like set_bit or test_bit. These bit operations works atomically
that it protects qgroup_flags value.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/ioctl.c  |  2 +-
 fs/btrfs/qgroup.c | 68 ++++++++++++++++++++++-------------------------
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d8..19b0b59abe77 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4435,7 +4435,7 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
 		qsa.flags = 1;
 		qsa.progress = fs_info->qgroup_rescan_progress.objectid;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db680f5be745..9fabc62ff2a5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -499,16 +499,16 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 out:
 	btrfs_free_path(path);
 	fs_info->qgroup_flags |= flags;
-	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
+	if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags))
 		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
+	else if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags) &&
 		 ret >= 0)
 		ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
 
 	if (ret < 0) {
 		ulist_free(fs_info->qgroup_ulist);
 		fs_info->qgroup_ulist = NULL;
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
 		btrfs_sysfs_del_qgroups(fs_info);
 	}
 
@@ -1197,7 +1197,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	spin_lock(&fs_info->qgroup_lock);
 	quota_root = fs_info->quota_root;
 	fs_info->quota_root = NULL;
-	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
+	clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	btrfs_free_qgroup_config(fs_info);
@@ -1353,7 +1353,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 	}
 out:
 	if (ret)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	return ret;
 }
 
@@ -1659,7 +1659,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	ret = update_qgroup_limit_item(trans, qgroup);
 	if (ret) {
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 		btrfs_info(fs_info, "unable to update quota limit for %llu",
 		       qgroupid);
 	}
@@ -1735,7 +1735,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
-		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &trans->fs_info->qgroup_flags);
 		btrfs_warn(trans->fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
 			ret);
@@ -2211,7 +2211,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(dst_path);
 	if (ret < 0)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	return ret;
 }
 
@@ -2581,7 +2581,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
 		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			ret = 0;
@@ -2715,23 +2715,23 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		spin_unlock(&fs_info->qgroup_lock);
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
-			fs_info->qgroup_flags |=
-					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
+					&fs_info->qgroup_flags);
 		ret = update_qgroup_limit_item(trans, qgroup);
 		if (ret)
-			fs_info->qgroup_flags |=
-					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
+					&fs_info->qgroup_flags);
 		spin_lock(&fs_info->qgroup_lock);
 	}
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
 	else
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	ret = update_qgroup_status_item(trans);
 	if (ret)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 
 	return ret;
 }
@@ -2849,7 +2849,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		ret = update_qgroup_limit_item(trans, dstgroup);
 		if (ret) {
-			fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 			btrfs_info(fs_info,
 				   "unable to update quota limit for %llu",
 				   dstgroup->qgroupid);
@@ -2955,7 +2955,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	return ret;
 }
 
@@ -3270,10 +3270,10 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	if (err > 0 &&
-	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		test_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags)) {
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	} else if (err < 0) {
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
@@ -3292,7 +3292,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	if (!stopped)
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
 	if (trans) {
 		ret = update_qgroup_status_item(trans);
 		if (ret < 0) {
@@ -3332,13 +3332,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	if (!init_flags) {
 		/* we're resuming qgroup rescan at mount time */
-		if (!(fs_info->qgroup_flags &
-		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
+		if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
 			btrfs_warn(fs_info,
 			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
-		} else if (!(fs_info->qgroup_flags &
-			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
+		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
 			btrfs_warn(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
@@ -3351,12 +3349,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 
 	if (init_flags) {
-		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+		if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, fs_info->qgroup_flags)) {
 			btrfs_warn(fs_info,
 				   "qgroup rescan is already in progress");
 			ret = -EINPROGRESS;
-		} else if (!(fs_info->qgroup_flags &
-			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
+		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
 			btrfs_warn(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
@@ -3366,7 +3363,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			return ret;
 		}
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
 	}
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
@@ -3422,12 +3419,12 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(fs_info->fs_root);
 	if (IS_ERR(trans)) {
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
 		return PTR_ERR(trans);
 	}
 	ret = btrfs_commit_transaction(trans);
 	if (ret) {
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
 		return ret;
 	}
 
@@ -3471,7 +3468,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 void
 btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
 		mutex_lock(&fs_info->qgroup_rescan_lock);
 		fs_info->qgroup_rescan_running = true;
 		btrfs_queue_work(fs_info->qgroup_rescan_workers,
@@ -4167,8 +4164,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 	spin_unlock(&blocks->lock);
 out:
 	if (ret < 0)
-		fs_info->qgroup_flags |=
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	return ret;
 }
 
@@ -4255,7 +4251,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		btrfs_err_rl(fs_info,
 			     "failed to account subtree at bytenr %llu: %d",
 			     subvol_eb->start, ret);
-		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
 	}
 	return ret;
 }
-- 
2.25.1

