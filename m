Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70889476274
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhLOUAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:13 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EAC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:13 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b67so21225634qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wtSJTrMgsTE+Bd2bXz1uWjqvbb8+JQ0c86AKGiv95N0=;
        b=kFxwJh3+dmqhxKd9JjVPpuhPcg1O4ZzT7F+uAxSn/xh/rQjZKRD7xNErpwoI8T8yGx
         NrK94X2ppsTWi/bmf5GpkeR5V7AUjbuRJcJ6izjvJbbPDXlRXNxu8TUK4D0ErkAtIjjl
         /Ai9EyE2YzDoa7yTxCzTjhGfg8sHOWp2dQaGRiW2kWvNmqYYtAPqGpXUQT/9zVfzlLTN
         ZT86bGdqlqq+8I0KQUnvpj8gQeYiUAtfri51MyXFDotfKxsSrob8NwoIRXJqYXBEPKzi
         RRJX8tj0yI+TmVRgtxnbT1ssKlAQ75n6203hVrxHAcqDFM9FPqhZB4CEzc7N8pc2bMo6
         X6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtSJTrMgsTE+Bd2bXz1uWjqvbb8+JQ0c86AKGiv95N0=;
        b=BMpp4ueTD2zY3hVzvhhfbD4jpeAisMtYVu6wajev74SHQZdqjyRIazcFCN/2+mXhld
         jWUJdKobGETsXnDZDOnGupvymvOBDwJVMtLdqZKdKYLIRfU3XutX5fdFbSi8HmrljTOo
         VOIpyO4S7r2Yn94tKKfjOh/OH3yVRIeS50E5/X3B5hX1Kq7EO6p3KAzitj5ha7IqLqqs
         Uc77iG2CMj0vlHg+Wkx0DklI02Sjgp3W5lvmqnkqkmLRVJbAmankXxCHoZMWri1ZfORV
         qTBtx7hC2SoN6m8ICYUJUyR4rjsVR7IXU5Wn9pyYx8XKdgP7C7cG4HPUwNvSudlRDvvp
         AonA==
X-Gm-Message-State: AOAM532qBAGtmEmQ3iW02V36Yp1Pw0BHvToMVkMPBPnkANMvhbVZUK2R
        hc0Q5vcMQ0FeOnW1AXrnEx7cf6ne4q92Cw==
X-Google-Smtp-Source: ABdhPJxbTRPxtAeaqkIZaV1YchOZdt5a49ZfNvgk3vExPtLzKlXP4zwtV7JkeqnCqfqXirwDg9RySA==
X-Received: by 2002:a05:620a:28cc:: with SMTP id l12mr7360553qkp.48.1639598412124;
        Wed, 15 Dec 2021 12:00:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bj32sm1604801qkb.75.2021.12.15.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 14/22] btrfs-progs: check: handle the block group tree properly
Date:   Wed, 15 Dec 2021 14:59:40 -0500
Message-Id: <dfa11b1bd7dca5105e8e2e10e6c2d20cdad627e2.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to make sure we process the block group root, and mark its
blocks as used for the free space tree checking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c    | 27 +++++++++++++++++----------
 common/repair.c |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/check/main.c b/check/main.c
index cf3c6af2..36352543 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8934,6 +8934,18 @@ out:
 	return ret;
 }
 
+static int load_super_root(struct list_head *head, struct btrfs_root *root)
+{
+	u8 level;
+
+	if (!root)
+		return 0;
+
+	level = btrfs_header_level(root->node);
+	return add_root_item_to_list(head, root->root_key.objectid,
+				     root->node->start, 0, level, 0, NULL);
+}
+
 static int check_chunks_and_extents(void)
 {
 	struct rb_root dev_cache;
@@ -8952,9 +8964,7 @@ static int check_chunks_and_extents(void)
 	int bits_nr;
 	struct list_head dropping_trees;
 	struct list_head normal_trees;
-	struct btrfs_root *root1;
 	struct btrfs_root *root;
-	u8 level;
 
 	root = gfs_info->fs_root;
 	dev_cache = RB_ROOT;
@@ -8987,16 +8997,13 @@ static int check_chunks_and_extents(void)
 	}
 
 again:
-	root1 = gfs_info->tree_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->tree_root);
+	if (ret < 0)
+		goto out;
+	ret = load_super_root(&normal_trees, gfs_info->chunk_root);
 	if (ret < 0)
 		goto out;
-	root1 = gfs_info->chunk_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->block_group_root);
 	if (ret < 0)
 		goto out;
 
diff --git a/common/repair.c b/common/repair.c
index f8c3f89c..9071e627 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -149,6 +149,9 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
 	if (!ret)
 		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
+	if (!ret && fs_info->block_group_root)
+		ret = traverse_tree_blocks(tree,
+					   fs_info->block_group_root->node, 0);
 	return ret;
 }
 
-- 
2.26.3

