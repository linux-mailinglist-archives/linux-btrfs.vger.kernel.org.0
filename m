Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637753A9D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355111AbiFAPQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355145AbiFAPQa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 11:16:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D191552
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 08:16:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v11so1553382qkf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NMMp0+WQchapYSNNB57xa+670KAL/IFtcYg4r8ZqDTc=;
        b=OoMwpBI5FH7sgjYxoDo0mtC1xqbdoJ55Iop0aDdcSvfUMU8Rg45s7pSa2cIUOXtVy2
         ZUN3k3aVuLdDm5pg5SfbB1HUvAuiLC3OA2PITgRiR/uL4D+iloOUi6NxJO28ph06vDIP
         VTmhibfNzI33GK9FO6Hqbcrw8DOZh6z26g8WB6WlTx2GKwSmGCWDX4SfiecntpjoyXEY
         5OoEEjhkO0nxCkqwHAG1mtxVSSndqeyXl4cVAzzGhXTAZj/HTqnwrKJxT0feCDIYGiIL
         qS6UUgCovrs1s4WF1NUSFF5V4954E/+iPuzfV7jYTKsgf/4RAjpiz480wLEp6RcCxMRl
         o4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMMp0+WQchapYSNNB57xa+670KAL/IFtcYg4r8ZqDTc=;
        b=Ilo3vkpDTq7T5XnHRZPIG0jsXbKGWDt2iIqycnctUNEkFwycxzQSMFe5C+t+iuYfW2
         Mfl4wkVvyQDbCMl6XE2HacPJ8IcxmhQ/EOI2fn3QnjWcoCFCs9fmtdEFv6zuVCkMZN5b
         yakVUftZYj4uDwseaTowTIP9WrgN0wSqgNnENpcTCZGn4Lx8cfMQkqW20DRUQa7SLS8t
         NL8WhZHvDOGqd8L+Zru5XTaWtyuWxcnNC06n7aVCdlrrXyathy4xqzEwp9rYt7aiyb4U
         TE5WclPoJTqjSosJM2cjXi46R9iZTGu5+s9gz8146XfV+0J21Gbub84ASBgR3OmQJbM3
         LGQg==
X-Gm-Message-State: AOAM531Qxrp547323cw2gbF5xN+CszemPV9/phXr2G4bOTsdmyDJKUD5
        I6S5eShh59Rx1WgRAHmTg71uyC9xQvywVw==
X-Google-Smtp-Source: ABdhPJyv9xJViDpdxEY8ZKhutTOlQzxzaFDXr/4V/ttnVPuAZg34HWh1Sw5Pjv/6enu1aroepQC8uA==
X-Received: by 2002:a05:620a:2226:b0:6a5:a73c:411e with SMTP id n6-20020a05620a222600b006a5a73c411emr416467qkh.555.1654096588611;
        Wed, 01 Jun 2022 08:16:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k15-20020ac8140f000000b00304b5eef8aasm1277043qtj.32.2022.06.01.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:16:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: make the return value for log syncing consistent
Date:   Wed,  1 Jun 2022 11:16:24 -0400
Message-Id: <249998ea8b056e9d69d85f32c1996a34a305c4c3.1654096526.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1654096526.git.josef@toxicpanda.com>
References: <cover.1654096526.git.josef@toxicpanda.com>
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

Currently we will return 1 or -EAGAIN if we decide we need to commit
the transaction rather than sync the log.  In practice this doesn't
really matter, we interpret any !0 and !BTRFS_NO_LOG_SYNC as needing to
commit the transaction.  However this makes it hard to figure out what
the correct thing to do is.  Fix this up by defining
BTRFS_LOG_FORCE_COMMIT and using this in all the places where we want to
force the transaction to be committed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 18 +++++++++---------
 fs/btrfs/tree-log.h |  3 +++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1201f083d4db..d898ba13285f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -171,7 +171,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		int index = (root->log_transid + 1) % 2;
 
 		if (btrfs_need_log_full_commit(trans)) {
-			ret = -EAGAIN;
+			ret = BTRFS_LOG_FORCE_COMMIT;
 			goto out;
 		}
 
@@ -194,7 +194,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		 * writing.
 		 */
 		if (zoned && !created) {
-			ret = -EAGAIN;
+			ret = BTRFS_LOG_FORCE_COMMIT;
 			goto out;
 		}
 
@@ -3121,7 +3121,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	/* bail out if we need to do a full commit */
 	if (btrfs_need_log_full_commit(trans)) {
-		ret = -EAGAIN;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		mutex_unlock(&root->log_mutex);
 		goto out;
 	}
@@ -3222,7 +3222,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		}
 		btrfs_wait_tree_log_extents(log, mark);
 		mutex_unlock(&log_root_tree->log_mutex);
-		ret = -EAGAIN;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto out;
 	}
 
@@ -3261,7 +3261,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		blk_finish_plug(&plug);
 		btrfs_wait_tree_log_extents(log, mark);
 		mutex_unlock(&log_root_tree->log_mutex);
-		ret = -EAGAIN;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto out_wake_log_root;
 	}
 
@@ -5848,7 +5848,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	    inode_only == LOG_INODE_ALL &&
 	    inode->last_unlink_trans >= trans->transid) {
 		btrfs_set_log_full_commit(trans);
-		ret = 1;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto out_unlock;
 	}
 
@@ -6562,12 +6562,12 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	bool log_dentries = false;
 
 	if (btrfs_test_opt(fs_info, NOTREELOG)) {
-		ret = 1;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto end_no_trans;
 	}
 
 	if (btrfs_root_refs(&root->root_item) == 0) {
-		ret = 1;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto end_no_trans;
 	}
 
@@ -6665,7 +6665,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 end_trans:
 	if (ret < 0) {
 		btrfs_set_log_full_commit(trans);
-		ret = 1;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 	}
 
 	if (ret)
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 1620f8170629..c3baa9d979a9 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -12,6 +12,9 @@
 /* return value for btrfs_log_dentry_safe that means we don't need to log it at all */
 #define BTRFS_NO_LOG_SYNC 256
 
+/* we can't use the tree log for whatever reason, force a transaction commit */
+#define BTRFS_LOG_FORCE_COMMIT 1
+
 struct btrfs_log_ctx {
 	int log_ret;
 	int log_transid;
-- 
2.26.3

