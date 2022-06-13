Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908B549EFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbiFMUZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbiFMUZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:25:48 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E1CFC
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o73so4758808qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5C17YHDDOlBdgTbPe+UE8CEpuhKI0HKSAeXSRRKZWCc=;
        b=38LDr8Ae1KNCSKhXjiqX3g5K2IH+rPSNjIx6rGBrG+o0D7OaTyMm5v+JoFZ8gDZbeh
         gFHvQP5GBnpmP78Qcca0RSSIoQGDFR9JFDsH33jCt/VaxgsqQ33mxjkKMAGVZVCdFySN
         Xtq/5fCEuQEsfvl+FbK4x+nmjnmWd8dNmU2HAAa3zDDGfwULQyL/UCq6PMd9K0bxPYEV
         pgm6PWbdMRVAGuNB6BP2zT5oBZCHyvyoBxlY57ExQLmWQzbTgTZqSlQv6ycHRXKqNjGp
         bi4VB6fpuLDB4Kzlhyru+gJ9GtWrma3Vu8olGzRpA48KMy1zZdrWVC0n6YLYNtWFIzQI
         DOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5C17YHDDOlBdgTbPe+UE8CEpuhKI0HKSAeXSRRKZWCc=;
        b=Xu9va4eWGPKs0pk46uNDYvSYZliuEbl8uvo8+VkCGWbZlp0156xAYnCKze8ddV3mTk
         D/5mNyARktBP+V0ruzIrwvNoubx8dwYgTJuNU+ALhLvjeK3d7FP9M3CDgZ6fpU36TIX9
         +L6sBoDw9WOTZFKYQIdCQOHp11gQJlJZHHWQK8C4Bxe1ANINPjnYzmEBhXI/hGzRmDuD
         I8PP/qLBEkT2pHME+Qf4iecBJewbvsFA1SUEsePQaeAEF8Z6uKcxNI8p6wT0GM1ZqsCb
         JVHa9C3dqRNZdfCJ7XlLJvwmPYR1bV+ek5HnbXCYPxNsXiq8bhhZJYP4D7GbVS0RL8iK
         Hx9g==
X-Gm-Message-State: AOAM530PNLluI5b9BDXRL4jZiA1uxUavGWzl97gHePhIPPAQuz+Dvsw6
        wVnSlroiAJeluHm9Zg9JOsjfnFHtwmZXAg==
X-Google-Smtp-Source: ABdhPJxig+4audLfYVy3uege3QerlJPaazoWUm/b1QDJwv1H79ZF7ev6Bbn7tyyryW545m++WPOwaw==
X-Received: by 2002:a05:620a:884:b0:6a7:347:386 with SMTP id b4-20020a05620a088400b006a703470386mr1208600qka.7.1655147392750;
        Mon, 13 Jun 2022 12:09:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 135-20020a37068d000000b0069fc13ce1e9sm7097330qkg.26.2022.06.13.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:09:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: make the return value for log syncing consistent
Date:   Mon, 13 Jun 2022 15:09:48 -0400
Message-Id: <5f9201d7f591776b089c4d1333b29f4199fc110f.1655147296.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1655147296.git.josef@toxicpanda.com>
References: <cover.1655147296.git.josef@toxicpanda.com>
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
 fs/btrfs/file.c     |  2 +-
 fs/btrfs/tree-log.c | 18 +++++++++---------
 fs/btrfs/tree-log.h |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1fd827b99c1b..157cf60b635a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2308,7 +2308,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	btrfs_release_log_ctx_extents(&ctx);
 	if (ret < 0) {
 		/* Fallthrough and commit/free transaction. */
-		ret = 1;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 	}
 
 	/* we've logged all the items and now have a consistent
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

