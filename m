Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C780C11538F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLFOqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44716 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfLFOqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id i18so6626102qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KWMI/KNd0IXdEae8b+O4R9ELWAjIt9CPcrtySioh2io=;
        b=ztmpzZifl7jdeCgs3a/DASXEiAxY1wLkEcZrIwn5TrJ7uXGGDUmPiW4Timy4qqCaP9
         sFP+z3MFlwvOWJZRxZi1EJ/tyfGCLLzxxx0wnaBXs/LH4tzhlHWIcIio7NMVwD+YfsSP
         tKq3Jc7TQup/KWPFkq2N8DgcLRbcdMiAb1vsRnBy9ob6jmGiT4qebXBmpA+ahSrMQIeN
         iq0yqmC4iaNLAZNq9UqTxCSsxOme592mV/rt11tcis/qpi2LTNE2C8uBH+LzA4KxgcT8
         4USwzXH0my1L9BQJ7J204aNajvP88jO77DqYC1f4hpMyvYzYXCaoz/Ede5FwUXPVoCuX
         yGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWMI/KNd0IXdEae8b+O4R9ELWAjIt9CPcrtySioh2io=;
        b=om0magGqUfLbBgFy7Jp3Qa6VdQWbCxGPL6bVYwKgOnvkoGf+LkzW41O1xWq8ECmxZd
         4ugHyLaIhXRfgeNXEvwj6EFG1w9bIviaf+GTg4/vUnKAztxIB21rt47BBnR9aG+Qx+IN
         k+NzKgoxgBLf/1WSiM85jjgMSehxBkqIHK106sQNNc5tUV6AW0xseoI4xioDsph5HqyD
         1aBNXBdbQaOn72bHkzHwhxlBS9wYGjhrosPiKrM/n7UXMJvDQUdmVrcrca1FfcPhiiP0
         2Gq93sA5wF22zRLVSCbIYGbeBH94QgtyquY0S9+BF/rzFpaVmRYVmx+Dy2enYxueZbPR
         twKg==
X-Gm-Message-State: APjAAAVX87XH1YQvluYB8W+Qtwt273WY1RHe1YHVPWwyYH7DsmXysSGh
        QDR3M6JFLkJCtZ+FEx1wAqSyr0vmiD89PA==
X-Google-Smtp-Source: APXvYqx/XeMqTMDrzL7HRqx9wiK7SHpE6ykFVJvrMz5q6UmkZV7fxY5gK4oeuIvhGzVdV6JaJcfUzQ==
X-Received: by 2002:a37:5f43:: with SMTP id t64mr14201481qkb.68.1575643608977;
        Fri, 06 Dec 2019 06:46:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u124sm861837qkc.41.2019.12.06.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 39/44] btrfs: use btrfs_put_fs_root to free roots always
Date:   Fri,  6 Dec 2019 09:45:33 -0500
Message-Id: <20191206144538.168112-40-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
 fs/btrfs/disk-io.c         | 30 +++++++++++++++---------------
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/qgroup.c          |  4 ++--
 fs/btrfs/tree-log.c        |  8 ++++----
 4 files changed, 22 insertions(+), 22 deletions(-)

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

