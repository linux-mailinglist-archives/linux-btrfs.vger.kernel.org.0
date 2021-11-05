Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC964469AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhKEUbf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhKEUbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F059C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g13so7837855qtk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gT6h9M4/50Qv3jiAIhKH6wJvjA4BEhZUHEGYTHGTtB8=;
        b=L/Zi1o2DlW6vFi14FaCWdWUBglm1SqryMEHF5LGyXTcONRA87xovxwiIcnSHCiefOZ
         8CduXCI38e8NIKu6kAFqkZu6HXxROyE/bFtjnQtP4ywjOIdrW1Fz5yrC6fI9dGCCRRg5
         KKUOY5L2kl4l48iQXoQd6gNH1x/19gThKLfCTs1ExtBMbLPAwGU1fI00uU2XJgEdbqBB
         GnMdRaMj98DThcNQd8KuFQng2N0hTv8nIhAi89bFa6n9rDCz1JIBvrrXZvVIu8KG9hNR
         587ch/3n+TVTI0mDaNzm7NOCCvy1KXryLA8edmZhYBZEdoDfITvS0qJKn3wvZbK6z1j0
         iwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT6h9M4/50Qv3jiAIhKH6wJvjA4BEhZUHEGYTHGTtB8=;
        b=dAf/1sj64P0P613SapYLKeyhubGrqD29IP7+rgZQS++5BW+jbVDAwkscqYVibGGJkD
         WykpHAqmZM4Wbbs471MkrxrTrjNw3NqjhYvSZDb197I+Ah7NTzYKBvwUn2fnTLjGfcML
         gFD9fXxbnT32Ka36IZoaM+wT11FQ4WQ3fhcTc4A2rYft2W0glBk3chxkf1i6Lyslf6Ml
         M4uCvfCMgDdO3tJCwY2x3jNfomiELnsWMQmX2x+f8FuaWXaBDi6ELl2HOiX3MfwfGCEG
         C1VYwfx+519zks4mig/tvjbyAbJ++NNOVXxalKVwp0UoZR1OXsS4NEHwfZZQR0rkHQzu
         BaFA==
X-Gm-Message-State: AOAM530r70Vqix0Rdc+3vfEp6W2jIMwFvx3ExxbA1+bBK9DsEGGxfd3q
        wlrWqdjsiIC/IndDzz/Jz/F5UTOrk+EO+Q==
X-Google-Smtp-Source: ABdhPJwIQ+N31t/Ht3zQHX2yPhRLdG9e/7QMvaTQUIlfXGSlS9tsgv9KzSCXCHgR9oyOGKBtqWR5Dw==
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr65924504qtw.161.1636144133108;
        Fri, 05 Nov 2021 13:28:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u9sm6588916qta.83.2021.11.05.13.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/20] btrfs-progs: add a helper for setting up a root node
Date:   Fri,  5 Nov 2021 16:28:29 -0400
Message-Id: <2719756fd27dd1d4ee0c06f15a40238d26c2e69d.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use this pattern in a few places, and will use it more with different
roots in the future.  Extract out this helper to read the root nodes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 58 +++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3b3c4523..1f940221 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -578,12 +578,23 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->root_key.objectid = objectid;
 }
 
+static int read_root_node(struct btrfs_fs_info *fs_info,
+			  struct btrfs_root *root, u64 bytenr, u64 gen)
+{
+	root->node = read_tree_block(fs_info, bytenr, gen);
+	if (!extent_buffer_uptodate(root->node)) {
+		free_extent_buffer(root->node);
+		root->node = NULL;
+		return -EIO;
+	}
+	return 0;
+}
+
 static int find_and_setup_root(struct btrfs_root *tree_root,
 			       struct btrfs_fs_info *fs_info,
 			       u64 objectid, struct btrfs_root *root)
 {
 	int ret;
-	u64 generation;
 
 	btrfs_setup_root(root, fs_info, objectid);
 	ret = btrfs_find_last_root(tree_root, objectid,
@@ -591,13 +602,9 @@ static int find_and_setup_root(struct btrfs_root *tree_root,
 	if (ret)
 		return ret;
 
-	generation = btrfs_root_generation(&root->root_item);
-	root->node = read_tree_block(fs_info,
-			btrfs_root_bytenr(&root->root_item), generation);
-	if (!extent_buffer_uptodate(root->node))
-		return -EIO;
-
-	return 0;
+	return read_root_node(fs_info, root,
+			      btrfs_root_bytenr(&root->root_item),
+			      btrfs_root_generation(&root->root_item));
 }
 
 static int find_and_setup_log_root(struct btrfs_root *tree_root,
@@ -606,6 +613,7 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 {
 	u64 blocknr = btrfs_super_log_root(disk_super);
 	struct btrfs_root *log_root = malloc(sizeof(struct btrfs_root));
+	int ret;
 
 	if (!log_root)
 		return -ENOMEM;
@@ -615,20 +623,15 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 		return 0;
 	}
 
-	btrfs_setup_root(log_root, fs_info,
-			 BTRFS_TREE_LOG_OBJECTID);
-
-	log_root->node = read_tree_block(fs_info, blocknr,
-				     btrfs_super_generation(disk_super) + 1);
-
-	fs_info->log_root_tree = log_root;
-
-	if (!extent_buffer_uptodate(log_root->node)) {
-		free_extent_buffer(log_root->node);
+	btrfs_setup_root(log_root, fs_info, BTRFS_TREE_LOG_OBJECTID);
+	ret = read_root_node(fs_info, log_root, blocknr,
+			     btrfs_super_generation(disk_super) + 1);
+	if (ret) {
 		free(log_root);
 		fs_info->log_root_tree = NULL;
-		return -EIO;
+		return ret;
 	}
+	fs_info->log_root_tree = log_root;
 
 	return 0;
 }
@@ -704,9 +707,9 @@ out:
 		return ERR_PTR(ret);
 	}
 	generation = btrfs_root_generation(&root->root_item);
-	root->node = read_tree_block(fs_info,
-			btrfs_root_bytenr(&root->root_item), generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root,
+			     btrfs_root_bytenr(&root->root_item), generation);
+	if (ret) {
 		free(root);
 		return ERR_PTR(-EIO);
 	}
@@ -970,8 +973,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		generation = btrfs_backup_tree_root_gen(backup);
 	}
 
-	root->node = read_tree_block(fs_info, root_tree_bytenr, generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root, root_tree_bytenr, generation);
+	if (ret) {
 		fprintf(stderr, "Couldn't read tree root\n");
 		return -EIO;
 	}
@@ -1179,10 +1182,9 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	else
 		generation = 0;
 
-	fs_info->chunk_root->node = read_tree_block(fs_info,
-						    chunk_root_bytenr,
-						    generation);
-	if (!extent_buffer_uptodate(fs_info->chunk_root->node)) {
+	ret = read_root_node(fs_info, fs_info->chunk_root, chunk_root_bytenr,
+			     generation);
+	if (ret) {
 		if (fs_info->ignore_chunk_tree_error) {
 			warning("cannot read chunk root, continue anyway");
 			fs_info->chunk_root = NULL;
-- 
2.26.3

