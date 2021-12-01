Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C9465526
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbhLASVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbhLASU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:59 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B1C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:38 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bu11so22587419qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WIYv919bF2sxsTp8hgqPuuZCHRSwanWy/d5wVXN/PCs=;
        b=NegPROj+CUzCHFrokgUCRB3IAmjImG+1KCAk4plMkoU2J+wWcxkYsSxBLcOl1i72m5
         mwlJLE0FMHqymENqSFBSHJOTV8WxuBswaWfGhWBetUXoHAx4pj8LOzSHZUF/sIqpfYUk
         greSCCxPOpIPjAP5co31Nwlj2pnQwy9vDOa5h+9yIh3A8EprL9eetROsREG8lyY7p6uU
         HPEhxiGhS+RUx9M2c3cLwqBlhDcznOyymWOHdHTSIHXl7IgMuR52f30b68TUfVzto+Iv
         OijIDagPu6zjTW2jkSVekw+ujJRYHOwfsk/4N4kvLr+QsPGekPlQI3/YliAgE9iBQIHz
         WTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIYv919bF2sxsTp8hgqPuuZCHRSwanWy/d5wVXN/PCs=;
        b=4XRgXv0RNTPPA2n557WcGg4fK7leGi6Vsh24K3um1+JCJY0c4g9s3sb6VwYOB/Lj6u
         mfAVsHw24MYf3JA9J57uNjeJVKyx8eAx7E/sCwE6CEnRL/TkRRZJb4jMAwgKadoIPH4s
         AXizVxqbaDrnzzYVvllrwWHePGpYFcP/FqVLheKZgA625xeq8sH8pOmAF0C4V/qjh5S+
         dndf0IldM236nRaWy8GulRXVJpgMI3WHq/sEvY/eYqPlFvZEYbS/F3B94WpUaCSZb7nH
         f/xriI7xL/bjj95en78uywb109KM/qIwnJGBg2fx4V5CFzDO23CEq9bPayvff+PdI0tG
         w2nQ==
X-Gm-Message-State: AOAM531jZ49eclaGo++TO0ZryXJYmooK7XJvE2rdzn/tSb3sgVjqF6ot
        OaAJAtoesAR5Oq8yA91KXHZTQL2ATs5u8Q==
X-Google-Smtp-Source: ABdhPJwr4txGNCSUVMxO6un0MNyTsbzxjdAF1BL94ZLbIqU2/epQQa8szZdf6BO4UaFsd4N0taLf6A==
X-Received: by 2002:ad4:54f2:: with SMTP id k18mr8078369qvx.63.1638382657380;
        Wed, 01 Dec 2021 10:17:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l2sm273447qtk.41.2021.12.01.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/22] btrfs-progs: check: handle the block group tree properly
Date:   Wed,  1 Dec 2021 13:17:08 -0500
Message-Id: <59cdd0bd10cded5bccf4692b2c9587ae532c9ff4.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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
index 97cd3249..6be22d77 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8921,6 +8921,18 @@ out:
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
@@ -8939,9 +8951,7 @@ static int check_chunks_and_extents(void)
 	int bits_nr;
 	struct list_head dropping_trees;
 	struct list_head normal_trees;
-	struct btrfs_root *root1;
 	struct btrfs_root *root;
-	u8 level;
 
 	root = gfs_info->fs_root;
 	dev_cache = RB_ROOT;
@@ -8974,16 +8984,13 @@ static int check_chunks_and_extents(void)
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

