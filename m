Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74A5446A06
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhKEUtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhKEUs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:59 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14979C06120A
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x23so3214540qkf.7
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MiPE6lCcwo0QHebkl4glhY6h9GVgzjKFtg/m5HDE0VI=;
        b=XYZDcp15aek708wmlqrCG9p3UZYxxOYqsNmqdG0KhuyCCyhGLcNjKL3m17W4vszmmD
         SKV4605EEOuqFqXyxucvpurZlNhl54W0wr9DTyT3oQEBGnsqSQkKJeW3LYPs/4jrnhmx
         NH07yg3undfzIwyNcaBfr766ODetPKTKf2PGUoaemYaDxiGtc21kTndQOX6J88rEq3t3
         TOQtPjdzJhqcQUMaD17aCOkr2Uerr2zDA9ipg5DFcAgrD5/7Y+ai6xwDpDjiMx5H1pBU
         XZ1XyhRutlogTFZOrJLv9Wl0VWJTeoSIFowuzTrRYxebnz89VfshnkwaTlPdyLPdYweU
         UG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiPE6lCcwo0QHebkl4glhY6h9GVgzjKFtg/m5HDE0VI=;
        b=UVf7I1jMr4tu1SXX6zOI49LvFicOzQhUVCYem6QFa5t8qb1SueIHWMszMVHiSnA2/x
         91f+y5n2vkazqZUHfLR21xggbmpCJG5z5nPSX2LFOqrQl+rhDdlasZa+HA7lkR5eynNj
         B06KWvV84fBb9xgu/tCo9LQW26tDlpOJNv3beRqI7FzcfqA6oNTvyUmEon2Xs0TKD8pg
         hnjI2T+uAOP/KLjuukITw66objMX1pgUEqNBe+wmKH8pNq5RmTSBgwKLN84RoIl9SMYd
         fFHMXzkorNKKuqbmNADBg/finwy1mING5A4CC06xx9g4Sk+UO/v+EIu6eW6cSRSViMIt
         HrcQ==
X-Gm-Message-State: AOAM530GcqQXxP00iMup+EHCoOu1K9Y4CTjlla3EcpTzGdUO8x1wxw8P
        TE7EQx0HCOz74PT4J0cxHQKOU52uI1vSnA==
X-Google-Smtp-Source: ABdhPJz+8eYllNzQDXuYZRPPxtmkjGcWiypbes/UiCV4MwaoAqNTwOSBHJK5r5wIXN/R591WK6JmDg==
X-Received: by 2002:a05:620a:b4c:: with SMTP id x12mr42329235qkg.324.1636145177993;
        Fri, 05 Nov 2021 13:46:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e10sm6416731qtx.66.2021.11.05.13.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/25] btrfs: init root block_rsv at init root time
Date:   Fri,  5 Nov 2021 16:45:44 -0400
Message-Id: <282080bb71b5386dd398a51d776db8a23ab92e56.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the future we're going to have multiple csum and extent root trees,
so init the roots block_rsv at setup_root time based on their root key
objectid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 39 +++++++++++++++++++++++----------------
 fs/btrfs/block-rsv.h |  1 +
 fs/btrfs/disk-io.c   | 15 ++++++++-------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ac6fbe75cace..166f6c74c943 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -414,6 +414,29 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	spin_unlock(&sinfo->lock);
 }
 
+void btrfs_init_root_block_rsv(struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+
+	switch (root->root_key.objectid) {
+	case BTRFS_CSUM_TREE_OBJECTID:
+	case BTRFS_EXTENT_TREE_OBJECTID:
+		root->block_rsv = &fs_info->delayed_refs_rsv;
+		break;
+	case BTRFS_ROOT_TREE_OBJECTID:
+	case BTRFS_DEV_TREE_OBJECTID:
+	case BTRFS_QUOTA_TREE_OBJECTID:
+		root->block_rsv = &fs_info->global_block_rsv;
+		break;
+	case BTRFS_CHUNK_TREE_OBJECTID:
+		root->block_rsv = &fs_info->chunk_block_rsv;
+		break;
+	default:
+		root->block_rsv = NULL;
+		break;
+	}
+}
+
 void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_space_info *space_info;
@@ -428,22 +451,6 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->delayed_block_rsv.space_info = space_info;
 	fs_info->delayed_refs_rsv.space_info = space_info;
 
-	/*
-	 * Our various recovery options can leave us with NULL roots, so check
-	 * here and just bail before we go dereferencing NULLs everywhere.
-	 */
-	if (!fs_info->extent_root || !fs_info->csum_root ||
-	    !fs_info->dev_root || !fs_info->chunk_root || !fs_info->tree_root)
-		return;
-
-	fs_info->extent_root->block_rsv = &fs_info->delayed_refs_rsv;
-	fs_info->csum_root->block_rsv = &fs_info->delayed_refs_rsv;
-	fs_info->dev_root->block_rsv = &fs_info->global_block_rsv;
-	fs_info->tree_root->block_rsv = &fs_info->global_block_rsv;
-	if (fs_info->quota_root)
-		fs_info->quota_root->block_rsv = &fs_info->global_block_rsv;
-	fs_info->chunk_root->block_rsv = &fs_info->chunk_block_rsv;
-
 	btrfs_update_global_block_rsv(fs_info);
 }
 
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 07d61c2c5d28..3b67ff08d434 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -50,6 +50,7 @@ struct btrfs_block_rsv {
 };
 
 void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type);
+void btrfs_init_root_block_rsv(struct btrfs_root *root);
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
 					      unsigned short type);
 void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3bd3a06a9627..372adb8ec20f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1140,7 +1140,12 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
 	bool dummy = test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+
+	memset(&root->root_key, 0, sizeof(root->root_key));
+	memset(&root->root_item, 0, sizeof(root->root_item));
+	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
 	root->fs_info = fs_info;
+	root->root_key.objectid = objectid;
 	root->node = NULL;
 	root->commit_root = NULL;
 	root->state = 0;
@@ -1151,7 +1156,8 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
 	INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
-	root->block_rsv = NULL;
+
+	btrfs_init_root_block_rsv(root);
 
 	INIT_LIST_HEAD(&root->dirty_list);
 	INIT_LIST_HEAD(&root->root_list);
@@ -1189,6 +1195,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->log_transid = 0;
 	root->log_transid_committed = -1;
 	root->last_log_commit = 0;
+	root->anon_dev = 0;
 	if (!dummy) {
 		extent_io_tree_init(fs_info, &root->dirty_log_pages,
 				    IO_TREE_ROOT_DIRTY_LOG_PAGES, NULL);
@@ -1196,12 +1203,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 				    IO_TREE_LOG_CSUM_RANGE, NULL);
 	}
 
-	memset(&root->root_key, 0, sizeof(root->root_key));
-	memset(&root->root_item, 0, sizeof(root->root_item));
-	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
-	root->root_key.objectid = objectid;
-	root->anon_dev = 0;
-
 	spin_lock_init(&root->root_item_lock);
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
 #ifdef CONFIG_BTRFS_DEBUG
-- 
2.26.3

