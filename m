Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06193123099
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfLQPhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40897 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQPhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so7787399qkg.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CpkIdnka7113uYw7hGpT9+v+GHmPQyHPW/F9LAvAwc0=;
        b=AHcR0OutjxTPrGduVlVzvwY6nqc0ZIXf8Tq1eQdmhj9HBMMjEMDG+mtBn3HSDoNLMj
         fD/gHbHvHCCm0mf7TEoOgaCWyUZsGWEz7UqL/0dyCjJYsoD2ajx3F6ybi2x6Y1evdaUB
         kXNGr393HLf0iqZ5pK1mowSy08CbgJySWe2ePnXm6OH57LDq6YQLOr6PCbkGPv1pFL6j
         +0zKRdrchqZIgNwKyjYLIvAsjqMTdtNnb6Jtc7E8i8txNNiPtrKU5G5Yg1taN/rJq/Yw
         E/5U3xd0NIL4/tsd86NEAAVdJGpQEfnYmGAjozkoOqNg2tHhEKE6d0xMKIakK1dHU+Ek
         rv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpkIdnka7113uYw7hGpT9+v+GHmPQyHPW/F9LAvAwc0=;
        b=AN52wURna7F0/LY8CNvV1F7I1nujre+7MDtG17PqfDWk9Ex/XJ0DrEt+6tQaaaq4LE
         KOq1xFzsgVdFxUhI0iYymB8gxu1/uvREV2M/+J6RV2wyMquoLJ25WnAxlzmiCWz4ocWT
         JbWIXnQnidN2yz030QwvJeEO7W/Pze+yTO/Por8DgUK5b5K5mNPuS+jd0BYuSYBVJB3I
         5093FYX89Jr3ez6mn2tJuVg/RMjN6uIsdOcSX7Tbxqx8aB9el8iWjK/vm0CsshjfYgy7
         CMRyhrJMAHySE3Dnpdip83lBtjVpSTy/8+KW+U7nn0HUGini052HuqTrVaLT4c2t5a/v
         8/BQ==
X-Gm-Message-State: APjAAAWA7ME6YVuyFLlctqfcQgAp2hLfzjHglfTyGExtuuxftNcqs+3X
        aC4otTaTk+btrAEePtAhpun0OdDq0jnmnQ==
X-Google-Smtp-Source: APXvYqwD/ThYVm3TgNywIxwyENznMd1EhpkLdqDAojD80ZN+4WPpSMGuQAOA5D7RJbR489Z9GxcSnQ==
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr5575987qke.14.1576597068489;
        Tue, 17 Dec 2019 07:37:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm7226833qkj.24.2019.12.17.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 39/45] btrfs: use btrfs_put_fs_root to free roots always
Date:   Tue, 17 Dec 2019 10:36:29 -0500
Message-Id: <20191217153635.44733-40-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
index 9435d4aa1668..b7a2c570c438 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1299,7 +1299,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		free_extent_buffer(root->commit_root);
 		free_extent_buffer(leaf);
 	}
-	kfree(root);
+	btrfs_put_fs_root(root);
 
 	return ERR_PTR(ret);
 }
@@ -1330,7 +1330,7 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
 			NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
-		kfree(root);
+		btrfs_put_fs_root(root);
 		return ERR_CAST(leaf);
 	}
 
@@ -1433,7 +1433,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	return root;
 
 find_fail:
-	kfree(root);
+	btrfs_put_fs_root(root);
 alloc_fail:
 	root = ERR_PTR(ret);
 	goto out;
@@ -1529,17 +1529,17 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
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
 
@@ -2220,12 +2220,12 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
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
@@ -2234,7 +2234,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
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
index 93aeb2e539a4..762f254b4b38 100644
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
index a7aca4141788..e96321a20646 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -199,7 +199,7 @@ void btrfs_free_dummy_root(struct btrfs_root *root)
 		/* One for allocate_extent_buffer */
 		free_extent_buffer(root->node);
 	}
-	kfree(root);
+	btrfs_put_fs_root(root);
 }
 
 struct btrfs_block_group *
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 07e7fd508213..f2c26e07eedb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3296,7 +3296,7 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	free_extent_buffer(log->node);
-	kfree(log);
+	btrfs_put_fs_root(log);
 }
 
 /*
@@ -6316,7 +6316,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 							log->node->len);
 			free_extent_buffer(log->node);
 			free_extent_buffer(log->commit_root);
-			kfree(log);
+			btrfs_put_fs_root(log);
 
 			if (!ret)
 				goto next;
@@ -6355,7 +6355,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
-		kfree(log);
+		btrfs_put_fs_root(log);
 
 		if (ret)
 			goto error;
@@ -6389,7 +6389,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	free_extent_buffer(log_root_tree->node);
 	log_root_tree->log_root = NULL;
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
-	kfree(log_root_tree);
+	btrfs_put_fs_root(log_root_tree);
 
 	return 0;
 error:
-- 
2.23.0

