Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3DB140B84
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAQNtF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34541 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgAQNtF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:49:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so21799284qtz.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+W6y+qNSHlwOuNr0mSixpgp6V7d0DhqN89Qc2lqUmes=;
        b=t6GddcUKKPMa5OMBqPKkhnosUpuQqzcg33D/ELsEbA4doaFd2Bfj2ROX0F+VrPAi/Y
         yqjuxk7/i0Id0yLV9eAR06Gsm8KQyqfAp7jrsbVDpM/J7l7tEPpeZzgKkxXNX6e/VFd5
         47UaaU7nHGKIYw2XAdsBacV67qa0s9J55czJ3UM4HfN+EaexKFcs87rP9bLT+AGUhW65
         OFwaLKWEdH1XQQcOjLoPUza24/he2HGDRfBEBoKC74u4kiZOQKQ15oisAESeovP6bjcm
         EwNI525mhD7NmtnvBrkoo5x8BUlsA4k3HVnd/JZ8x1I/3T9vwQ2KZpH9keXvnnbay+oL
         UUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W6y+qNSHlwOuNr0mSixpgp6V7d0DhqN89Qc2lqUmes=;
        b=L/Sd9qvrKfz5T00AWICrLOby1huLmykTsC1ANtZxgUNXUZvk8BdDJpSHI7sk3Zqojs
         lFG9LnLBPBIZ/4FZxwoqrSLVUtAgXad+yN2pzUw6JW/c45krb9cSm5L7xELM4W34i2+1
         Vrt25NzO7GGGOuQC0bXH4YvQtZyOHNDnx6S5Qrskh31yd9H4JR6VbPbogK0NodzCUPWV
         3cNQREgbsXJfJ1E0+boS9DesT7ck/a6tGbPabJ6oSdH9R2a6XRQChPt0kZS6a+qLOB/3
         WtsRwNoRIimqCbO9Nw4jJBKoGhSyxAFeYSgxuh/uI0Bl4zzGtP/owJiRAmVlKwy75JNr
         82/A==
X-Gm-Message-State: APjAAAUFz7z0HhjmJk81gsf45bFr1BmNcIy4O6P8751D+pzrafRjoo6r
        gsbyvwSvH/gqLfXHRnvFZt/ntoqyk23Rxw==
X-Google-Smtp-Source: APXvYqx8rqpfLW/g19fY5ZNnG38DdzYnyheIZmyYAmx6uHRMzRjQ4tIC9YOqam9vj+XatUqwBqzo9g==
X-Received: by 2002:ac8:408c:: with SMTP id p12mr7721585qtl.336.1579268943677;
        Fri, 17 Jan 2020 05:49:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v2sm11778439qkj.29.2020.01.17.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:49:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/43] btrfs: use btrfs_put_fs_root to free roots always
Date:   Fri, 17 Jan 2020 08:47:52 -0500
Message-Id: <20200117134758.41494-38-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are going to track leaked roots we need to free them all the same
way, so don't kfree() roots directly, use btrfs_put_fs_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           | 30 +++++++++++++++---------------
 fs/btrfs/free-space-tree.c   |  2 +-
 fs/btrfs/qgroup.c            |  4 ++--
 fs/btrfs/tests/btrfs-tests.c |  2 +-
 fs/btrfs/tree-log.c          |  8 ++++----
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 433c29ddfca7..fa721ca1e732 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1297,7 +1297,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		free_extent_buffer(root->commit_root);
 		free_extent_buffer(leaf);
 	}
-	kfree(root);
+	btrfs_put_fs_root(root);
 
 	return ERR_PTR(ret);
 }
@@ -1328,7 +1328,7 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
 			NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
-		kfree(root);
+		btrfs_put_fs_root(root);
 		return ERR_CAST(leaf);
 	}
 
@@ -1431,7 +1431,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	return root;
 
 find_fail:
-	kfree(root);
+	btrfs_put_fs_root(root);
 alloc_fail:
 	root = ERR_PTR(ret);
 	goto out;
@@ -1527,17 +1527,17 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
-	kfree(fs_info->extent_root);
-	kfree(fs_info->tree_root);
-	kfree(fs_info->chunk_root);
-	kfree(fs_info->dev_root);
-	kfree(fs_info->csum_root);
-	kfree(fs_info->quota_root);
-	kfree(fs_info->uuid_root);
-	kfree(fs_info->free_space_root);
+	btrfs_put_fs_root(fs_info->extent_root);
+	btrfs_put_fs_root(fs_info->tree_root);
+	btrfs_put_fs_root(fs_info->chunk_root);
+	btrfs_put_fs_root(fs_info->dev_root);
+	btrfs_put_fs_root(fs_info->csum_root);
+	btrfs_put_fs_root(fs_info->quota_root);
+	btrfs_put_fs_root(fs_info->uuid_root);
+	btrfs_put_fs_root(fs_info->free_space_root);
+	btrfs_put_fs_root(fs_info->fs_root);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
-	btrfs_put_fs_root(fs_info->fs_root);
 	kvfree(fs_info);
 }
 
@@ -2223,12 +2223,12 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(log_tree_root->node)) {
 		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
-		kfree(log_tree_root);
+		btrfs_put_fs_root(log_tree_root);
 		return ret;
 	} else if (!extent_buffer_uptodate(log_tree_root->node)) {
 		btrfs_err(fs_info, "failed to read log tree");
 		free_extent_buffer(log_tree_root->node);
-		kfree(log_tree_root);
+		btrfs_put_fs_root(log_tree_root);
 		return -EIO;
 	}
 	/* returns with log_tree_root freed on success */
@@ -2237,7 +2237,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Failed to recover log tree");
 		free_extent_buffer(log_tree_root->node);
-		kfree(log_tree_root);
+		btrfs_put_fs_root(log_tree_root);
 		return ret;
 	}
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 258cb3fae17a..c79804c30b17 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1253,7 +1253,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	free_extent_buffer(free_space_root->node);
 	free_extent_buffer(free_space_root->commit_root);
-	kfree(free_space_root);
+	btrfs_put_fs_root(free_space_root);
 
 	return btrfs_commit_transaction(trans);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 98d9a50352d6..0845e56a1672 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1040,7 +1040,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	if (ret) {
 		free_extent_buffer(quota_root->node);
 		free_extent_buffer(quota_root->commit_root);
-		kfree(quota_root);
+		btrfs_put_fs_root(quota_root);
 	}
 out:
 	if (ret) {
@@ -1106,7 +1106,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 
 	free_extent_buffer(quota_root->node);
 	free_extent_buffer(quota_root->commit_root);
-	kfree(quota_root);
+	btrfs_put_fs_root(quota_root);
 
 end_trans:
 	ret = btrfs_end_transaction(trans);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index c12b91ff5f56..27f5b662d2cb 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -228,7 +228,7 @@ void btrfs_free_dummy_root(struct btrfs_root *root)
 		/* One for allocate_extent_buffer */
 		free_extent_buffer(root->node);
 	}
-	kfree(root);
+	btrfs_put_fs_root(root);
 }
 
 struct btrfs_block_group *
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5b05419a0f4c..f06ad415faf8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3284,7 +3284,7 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	free_extent_buffer(log->node);
-	kfree(log);
+	btrfs_put_fs_root(log);
 }
 
 /*
@@ -6138,7 +6138,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 							log->node->len);
 			free_extent_buffer(log->node);
 			free_extent_buffer(log->commit_root);
-			kfree(log);
+			btrfs_put_fs_root(log);
 
 			if (!ret)
 				goto next;
@@ -6177,7 +6177,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
-		kfree(log);
+		btrfs_put_fs_root(log);
 
 		if (ret)
 			goto error;
@@ -6211,7 +6211,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	free_extent_buffer(log_root_tree->node);
 	log_root_tree->log_root = NULL;
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	kfree(log_root_tree);
+	btrfs_put_fs_root(log_root_tree);
 
 	return 0;
 error:
-- 
2.24.1

