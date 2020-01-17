Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633E81412F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAQV1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43623 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgAQV1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so22895940qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+W6y+qNSHlwOuNr0mSixpgp6V7d0DhqN89Qc2lqUmes=;
        b=tSfU+crW4mb5EI+n3VEUCtLrcF6ZF824HU3w8GixHgRTUkdBLurEJEzrKs6W2/xvxK
         vlRzM7J//hgIymV6TvVoyQHJiRP6u2dIn3McfbI7VCwboQZ95546x+RPfUb9xSIbyCML
         nGiosgfbmVpXnlFRBSgHMnLia7/M1vwOsrGNlBH7CTHOnTY7j2qjeQ+pnCuvY4XRnFSj
         e4uoReqEsDHUVh33Ty+YLGksqBXC+Dmtq/Tw6MzdJeNa5cmm5ar9/aXS1gWSaOfFYGti
         Rrzanf0eeS0bRmflWpusN7Szh80I6f7nVpAsUqGOiP3YRm6iSG0LqfuL9/jKz/z6u/7r
         SozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W6y+qNSHlwOuNr0mSixpgp6V7d0DhqN89Qc2lqUmes=;
        b=JC21Fuy2bFPv/Tpys2FJqE11PXZrKqLGvvHjWho7LH4BBFEr+ShRYbw89cDIaPYx0t
         oJuguYx+pLoc5e310aeyBWuKGbHIBZ44oeKeDes00ml2hV+/AmfSaQFuhgthoqWvcqsZ
         ecTZbY62QaWPWoYJLymcaybCclUtsRU1yvBChY280rgkiX4ue43CHRxBZ82nY1KLTDfM
         tbYVVRwPqtEyap1+j2jsepoXRGn9iK1eKpeQYMuASfKgYAy05kcELmxk1dKTWMWTxDPc
         YanCjTtgk45ZfKXSzz2sf6vjHHXGYlEafdg5c97EQnnLOmAzTfpjR6611fraALiaqlSe
         Xj7A==
X-Gm-Message-State: APjAAAX0Oh2l8rUJ4KrS44jPHpIAxnLloxptBuMzoPxbUSVnvt0GRXNQ
        t/RPbMvea7JhJLvn0mlK+8rxD/3nyB+W/w==
X-Google-Smtp-Source: APXvYqyNPtkXruvoa9sELEPufyhqKxaEGUoBOww25b5WKeepeUE30OAemGnaVX1BcaSfac99ThaY9Q==
X-Received: by 2002:ac8:41c1:: with SMTP id o1mr9518837qtm.229.1579296429389;
        Fri, 17 Jan 2020 13:27:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s33sm14001456qtb.52.2020.01.17.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/43] btrfs: use btrfs_put_fs_root to free roots always
Date:   Fri, 17 Jan 2020 16:25:56 -0500
Message-Id: <20200117212602.6737-38-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

