Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B008D4AA656
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 04:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379290AbiBEDwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBEDwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 22:52:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B88C061346
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 19:51:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m7so7462147pjk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 19:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwfwXl8b5p3A+nMYmoGDfiWWjsJP0SBYfQ73V5C395Q=;
        b=pof2pA8XgV7Efgla3nsPuaGt53vodvR4Ev39+A9zIww5PzQb5cw4TIQiwFodFzW+FA
         1ZwWRHUyyxycwBxPJ91vDQ23h4tY2uRGnGtlZmkF78ARw9tp9hx5RU8lrpGqtMdSWg5r
         IM2WHohREJJkEu/xx4/gxcYUaOPsHG4niRo8q1ewfzAlzHcqjtmoTySwSNlCyiUgSiu5
         7eixlwQl4EvC0qGMbIENrqueyVQ/6JtTD5d3NaJKcBrOG9K0WCrBApL+mQ6q0178rKHZ
         uHO2tLqkVdf9fygbl8TtbcIUEqo0tYDx1uTdViOoZlLPqdh8EEmCC/qSMDWv2Qu6dau2
         TX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwfwXl8b5p3A+nMYmoGDfiWWjsJP0SBYfQ73V5C395Q=;
        b=vourLrnfgpNcPwWDyx7yuOB1M3ZUHgqyf3foyR9SQDo7eF4rpOblxCjwjJQ/4D+WDN
         dWX4R+ngNIR9gnax4zVhPIhQZky+mhTEZEJEKWIPu8GvoX/wMLo3p/Ni1bTSN31bh04F
         2KTtINJIVpNpaoIXWyepVOCwfVgna6YACUaUM2Ixwn/Z9fBuoCOvq1T2ZpDV7IF87lHv
         P8ycZh34jqOeQyYe86hl4NcdEmQ4Cpa8tjzW3pXZigv7l5NOHwiuZszC2m5nW+qgyeMr
         mIx1wWXKchhwCfjNr519qgN3i+17y1M4SeyqF1NsNhkK2vI+qZWgDI8e/PjOc3pY90uh
         NQGw==
X-Gm-Message-State: AOAM531xkuNecWnLBFkwmD7NvYijQSBcPrDVXkKBDglx/M5+yTWzjdj5
        VyEy3v2+0Ji9/y5/RJ2iFUkoMYp90Xinuw==
X-Google-Smtp-Source: ABdhPJxn4W15alFzPvNaISTXOO9DdPAMNawsYbnrVz73RyE8UGNchDPRrAWbSZJEaWT0/KYXea3qmQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr6145199plo.89.1644033118269;
        Fri, 04 Feb 2022 19:51:58 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id p21sm4283384pfh.89.2022.02.04.19.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 19:51:57 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: make qgroup_flags secure with holding qgroup_lock
Date:   Sat,  5 Feb 2022 03:51:49 +0000
Message-Id: <20220205035149.832849-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch make qgroup_flags secure from race condition with holding
qgroup_lock. Before this, qgroup_flags has been accessed without any
protection. It seems that it can make race condition with it. This patch
covers the code acessing qgroup_flags with holding qgroup_lock. But
there is some functions like btrfs_qgroup_rescan_resume() that don't
need to hold the lock because that functions is assured to be executed
in single threaded.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/qgroup.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8928275823a1..1d531004b38b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1033,9 +1033,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				 struct btrfs_qgroup_status_item);
 	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
 	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
+	spin_lock(&fs_info->qgroup_lock);
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON |
 				BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags);
+	spin_unlock(&fs_info->qgroup_lock);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
 	btrfs_mark_buffer_dirty(leaf);
@@ -1675,8 +1677,6 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 	}
 	qgroup->lim_flags |= limit->flags;
 
-	spin_unlock(&fs_info->qgroup_lock);
-
 	ret = update_qgroup_limit_item(trans, qgroup);
 	if (ret) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
@@ -1684,6 +1684,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       qgroupid);
 	}
 
+	spin_unlock(&fs_info->qgroup_lock);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
@@ -1755,7 +1756,9 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
 				   true);
 	if (ret < 0) {
+		spin_lock(&trans->fs_info->qgroup_lock);
 		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&trans->fs_info->qgroup_lock);
 		btrfs_warn(trans->fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
 			ret);
@@ -2230,8 +2233,11 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 
 out:
 	btrfs_free_path(dst_path);
-	if (ret < 0)
+	if (ret < 0) {
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&fs_info->qgroup_lock);
+	}
 	return ret;
 }
 
@@ -2599,18 +2605,17 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 		ret = -ENOMEM;
 		goto out_free;
 	}
-
+	spin_lock(&fs_info->qgroup_lock);
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
 		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			ret = 0;
-			goto out_free;
+			goto out;
 		}
 	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	spin_lock(&fs_info->qgroup_lock);
 	seq = fs_info->qgroup_seq;
 
 	/* Update old refcnts using old_roots */
@@ -2732,7 +2737,6 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		qgroup = list_first_entry(&fs_info->dirty_qgroups,
 					  struct btrfs_qgroup, dirty);
 		list_del_init(&qgroup->dirty);
-		spin_unlock(&fs_info->qgroup_lock);
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
 			fs_info->qgroup_flags |=
@@ -2741,18 +2745,17 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		if (ret)
 			fs_info->qgroup_flags |=
 					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-		spin_lock(&fs_info->qgroup_lock);
 	}
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
 	else
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
-	spin_unlock(&fs_info->qgroup_lock);
 
 	ret = update_qgroup_status_item(trans);
 	if (ret)
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 
+	spin_unlock(&fs_info->qgroup_lock);
 	return ret;
 }
 
@@ -2974,8 +2977,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 out:
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	if (need_rescan)
+	if (need_rescan) {
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&fs_info->qgroup_lock);
+	}
 	return ret;
 }
 
@@ -3292,12 +3298,14 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	btrfs_free_path(path);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
+	spin_lock(&fs_info->qgroup_lock);
 	if (err > 0 &&
 	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	} else if (err < 0) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	}
+	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	/*
@@ -3314,6 +3322,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
+	spin_lock(&fs_info->qgroup_lock);
 	if (!stopped)
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 	if (trans) {
@@ -3324,6 +3333,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 				  err);
 		}
 	}
+	spin_unlock(&fs_info->qgroup_lock);
 	fs_info->qgroup_rescan_running = false;
 	complete_all(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -3355,6 +3365,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	if (!init_flags) {
 		/* we're resuming qgroup rescan at mount time */
+		spin_lock(&fs_info->qgroup_lock);
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
 			btrfs_warn(fs_info,
@@ -3366,7 +3377,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
 		}
-
+		spin_unlock(&fs_info->qgroup_lock);
 		if (ret)
 			return ret;
 	}
@@ -3374,6 +3385,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 
 	if (init_flags) {
+		spin_lock(&fs_info->qgroup_lock);
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
 			btrfs_warn(fs_info,
 				   "qgroup rescan is already in progress");
@@ -3386,10 +3398,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		}
 
 		if (ret) {
+			spin_unlock(&fs_info->qgroup_lock);
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			return ret;
 		}
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		spin_unlock(&fs_info->qgroup_lock);
 	}
 
 	memset(&fs_info->qgroup_rescan_progress, 0,
@@ -3445,12 +3459,16 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(fs_info->fs_root);
 	if (IS_ERR(trans)) {
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		spin_unlock(&fs_info->qgroup_lock);
 		return PTR_ERR(trans);
 	}
 	ret = btrfs_commit_transaction(trans);
 	if (ret) {
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		spin_unlock(&fs_info->qgroup_lock);
 		return ret;
 	}
 
@@ -4189,9 +4207,12 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 out_unlock:
 	spin_unlock(&blocks->lock);
 out:
-	if (ret < 0)
+	if (ret < 0) {
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags |=
 			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&fs_info->qgroup_lock);
+	}
 	return ret;
 }
 
@@ -4278,7 +4299,9 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		btrfs_err_rl(fs_info,
 			     "failed to account subtree at bytenr %llu: %d",
 			     subvol_eb->start, ret);
+		spin_lock(&fs_info->qgroup_lock);
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&fs_info->qgroup_lock);
 	}
 	return ret;
 }
-- 
2.25.1

