Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270E84BC0BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiBRT4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 14:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiBRT4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 14:56:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9C0D7E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:17 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id n6so16793888qvk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JwxEovG76+orZGYK8Ub6ovQQfu1w91EyzAMBIlIaM1g=;
        b=fYvUE6RHmhU2ze58UhKh0GhzJmJFszTnGPYIHilyl2XFrBPPGoNf5QT0gLMu/VR4Qg
         V9LEZM5mYewxAiALcxruaBVBTkaEQ1WiExpIi6BtUOK5Af6/5QRuT1nA98Wy3RX6ujDb
         LYHWIhNXsNig3YVgxN7cHpO4NRLf/cNZEC7NL9zAvV2SracZ4p809Hu0oCiJc7Ga9C6h
         7T2YJBx00Z5F+k7S7z07jHW756s89ft5GqYVi0Q8ldhmqugoeUJKrNSWJKom+datjTTM
         yPy+M+uVpWHTqLRrxWeh8n/NDldpMx737/mJ6ot9SUFGbmVpzyQR3LhAYB0cdzZ9AAJT
         Ok4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwxEovG76+orZGYK8Ub6ovQQfu1w91EyzAMBIlIaM1g=;
        b=dwLV26DQq1GEOzPjPvTPxcEhyK38gpApsTgVHOLB4L4hSWRUMuuEdESi9RcnV2rChk
         3LSjP+bFJJ7GDDz3HSFsp7R9WbCZc4jDlXvFpjpTdqy3TvWVJGJK/GwAD0qFlxkqP9TE
         cFMYoiTbUeL6V19eUxNWKqmDnrZFLZ9u6+ihYKmLH/+gPYqtULhhCvnWTDul/7x3Iqyl
         c7Ox7fY7Y3CClqDELfN3dfrNsMfip1Y3SXbOpJnpbZA4DySZw3+zdHDB4eHNpuebDThR
         xj4Ch8vMBBX2RAJhUzXU8yOEGCjCET3eSrZW2ZZNyJobZvgsjMPHfB3yWE0bF3hzFP96
         zWqw==
X-Gm-Message-State: AOAM530DJxQJY3J6xpWwGZ+nyoRtzL5mwSjlAITSQvUnZXi5nJNOPFs1
        MhnfMfDRpYKMxqPxdPdVBftpNpaMUs17NIJr
X-Google-Smtp-Source: ABdhPJy+mnuOPbI7LkTic3PexLtbRM0miDxOTzREUhu6a+SnnMlLkc0AmDDAecfS+fjV0zvVf6dEEQ==
X-Received: by 2002:a05:622a:310:b0:2d4:a70a:a885 with SMTP id q16-20020a05622a031000b002d4a70aa885mr8299688qtw.608.1645214176345;
        Fri, 18 Feb 2022 11:56:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21sm862072qtk.60.2022.02.18.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:56:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: use btrfs_fs_info for deleting snapshots and cleaner
Date:   Fri, 18 Feb 2022 14:56:11 -0500
Message-Id: <62d358e74de3ac1393c1e3e8d35d048b3d9861f2.1645214059.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645214059.git.josef@toxicpanda.com>
References: <cover.1645214059.git.josef@toxicpanda.com>
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

We're passing a root around here, but we only really need the fs_info,
so fix up btrfs_clean_one_deleted_snapshot() to take an fs_info instead,
and then fix up all the callers appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 7 +++----
 fs/btrfs/transaction.c | 4 ++--
 fs/btrfs/transaction.h | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ed62e81c0b66..183baeffd9c9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1947,8 +1947,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
 
 static int cleaner_kthread(void *arg)
 {
-	struct btrfs_root *root = arg;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)arg;
 	int again;
 
 	while (1) {
@@ -1981,7 +1980,7 @@ static int cleaner_kthread(void *arg)
 
 		btrfs_run_delayed_iputs(fs_info);
 
-		again = btrfs_clean_one_deleted_snapshot(root);
+		again = btrfs_clean_one_deleted_snapshot(fs_info);
 		mutex_unlock(&fs_info->cleaner_mutex);
 
 		/*
@@ -3806,7 +3805,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
+	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
 		goto fail_sysfs;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index dfceee28a149..385c909f0db8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2475,10 +2475,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
  * because btrfs_commit_super will poke cleaner thread and it will process it a
  * few seconds later.
  */
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 {
+	struct btrfs_root *root;
 	int ret;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
 	if (list_empty(&fs_info->dead_roots)) {
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index ba8a9826eb37..970ff316069d 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -217,7 +217,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
 void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
-- 
2.26.3

