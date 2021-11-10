Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6677C44CA23
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKJULD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:03 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD3C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:15 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t83so1287091qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ywRd49RF0MstrK6f5cLCsNUMASHUsZ4Ly6fOCupP39Y=;
        b=NxJg66Hivqxo3q6H+RENeR0g2Phv2OdqVIjYbeRQmvYtAQ/ACDNEexn0ZvvA9Fb2Il
         tuxolE16o5TsSED7tndkc7LX0L/Vc0uiMh9cPAmZIKfccv0EDYiWOIqU+9LvVwy05w/r
         7h7QWXyeVkuRMiMtdykL1iGPPs0Em82ytsh3DQXW5Aos9DUjY1oq+fDGxyBDhWKNYwIp
         /naEJSBK3WPOD56EgIdNAiR7lET27BGc0XgYz2iM16w5Cg80sncm+bkWiY0WH2alBRJA
         CjHkraul6Qd9LNZGcOfrSIn8/i0pYVq9GgYwwYCNHAT913li9MycxF3lu2n7jJdY5xM1
         43IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywRd49RF0MstrK6f5cLCsNUMASHUsZ4Ly6fOCupP39Y=;
        b=rJb+bvIvxi8Ywn8CDuuuxpjkzdrj9On4uzq1EKBTkkcEGWv1yB2LDR4XB/9ESrgwrM
         AdmniqifhJjLrehF6jwpv6dyECR2/Vz4th3Gi6zrD6oJ5DfUI1ntAS1gSb5AdEFdwBaA
         zivGZE31kYG9nvZnuRMGvgBLDjcKMM3rEq0YYbMzdH3DGVDJ2jwxx1CXXJ2Y7EinIeDs
         mno+DoEkOqFt36spG/itCEz0qG2H5Gk3SFlAqAIEWB4SiAoOxf5Tw0zFbjsgQfhEEbvw
         WwsjxqM9tUBk6FZAu1Ulgi3RpKXdk+BKrsv+1JTUxe+GdmxqzWf/lyfoP9fVuHY2I/CE
         iLPw==
X-Gm-Message-State: AOAM530qXU8mLK2PhYOa42DdbRw/iXCjeIpqF3pkIQBCRGxhMUP2kM3M
        FUEiIRgVx6UjvhUpYJLGRI9M53mjLDmaag==
X-Google-Smtp-Source: ABdhPJxJRejVZxg8Bj/2aDl4M0UYJ1+MiI+XWOefNawabajylQVnE6mwfyMZjh9YffCoJut/b5wmWg==
X-Received: by 2002:a05:620a:f0b:: with SMTP id v11mr1626753qkl.429.1636574894227;
        Wed, 10 Nov 2021 12:08:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b5sm355446qka.51.2021.11.10.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/13] btrfs-progs: add a helper for setting up a root node
Date:   Wed, 10 Nov 2021 15:07:56 -0500
Message-Id: <eb0de520f1625f36474ab31ab82ff20e0850939b.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use this pattern in a few places, and will use it more with different
roots in the future.  Extract out this helper to read the root nodes.

There is a behavior change here in that we're now checking the root
levels, whereas before we were not.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 73 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3b3c4523..7a797801 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -578,12 +578,31 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->root_key.objectid = objectid;
 }
 
+static int read_root_node(struct btrfs_fs_info *fs_info,
+			  struct btrfs_root *root, u64 bytenr, u64 gen,
+			  int level)
+{
+	root->node = read_tree_block(fs_info, bytenr, gen);
+	if (!extent_buffer_uptodate(root->node))
+		goto err;
+	if (btrfs_header_level(root->node) != level) {
+		error("root [%llu %llu] level %d does not match %d\n",
+		      root->root_key.objectid, root->root_key.offset,
+		      btrfs_header_level(root->node), level);
+		goto err;
+	}
+	return 0;
+err:
+	free_extent_buffer(root->node);
+	root->node = NULL;
+	return -EIO;
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
@@ -591,13 +610,10 @@ static int find_and_setup_root(struct btrfs_root *tree_root,
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
+			      btrfs_root_generation(&root->root_item),
+			      btrfs_root_level(&root->root_item));
 }
 
 static int find_and_setup_log_root(struct btrfs_root *tree_root,
@@ -606,6 +622,7 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 {
 	u64 blocknr = btrfs_super_log_root(disk_super);
 	struct btrfs_root *log_root = malloc(sizeof(struct btrfs_root));
+	int ret;
 
 	if (!log_root)
 		return -ENOMEM;
@@ -615,20 +632,16 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
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
+			     btrfs_super_generation(disk_super) + 1,
+			     btrfs_super_log_root_level(disk_super));
+	if (ret) {
 		free(log_root);
 		fs_info->log_root_tree = NULL;
-		return -EIO;
+		return ret;
 	}
+	fs_info->log_root_tree = log_root;
 
 	return 0;
 }
@@ -704,9 +717,10 @@ out:
 		return ERR_PTR(ret);
 	}
 	generation = btrfs_root_generation(&root->root_item);
-	root->node = read_tree_block(fs_info,
-			btrfs_root_bytenr(&root->root_item), generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root,
+			     btrfs_root_bytenr(&root->root_item), generation,
+			     btrfs_root_level(&root->root_item));
+	if (ret) {
 		free(root);
 		return ERR_PTR(-EIO);
 	}
@@ -950,11 +964,13 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	u64 generation;
+	int level;
 	int ret;
 
 	root = fs_info->tree_root;
 	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
 	generation = btrfs_super_generation(sb);
+	level = btrfs_super_root_level(sb);
 
 	if (!root_tree_bytenr && !(flags & OPEN_CTREE_BACKUP_ROOT)) {
 		root_tree_bytenr = btrfs_super_root(sb);
@@ -968,10 +984,12 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		backup = fs_info->super_copy->super_roots + index;
 		root_tree_bytenr = btrfs_backup_tree_root(backup);
 		generation = btrfs_backup_tree_root_gen(backup);
+		level = btrfs_backup_tree_root_level(backup);
 	}
 
-	root->node = read_tree_block(fs_info, root_tree_bytenr, generation);
-	if (!extent_buffer_uptodate(root->node)) {
+	ret = read_root_node(fs_info, root, root_tree_bytenr, generation,
+			     level);
+	if (ret) {
 		fprintf(stderr, "Couldn't read tree root\n");
 		return -EIO;
 	}
@@ -1179,10 +1197,9 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	else
 		generation = 0;
 
-	fs_info->chunk_root->node = read_tree_block(fs_info,
-						    chunk_root_bytenr,
-						    generation);
-	if (!extent_buffer_uptodate(fs_info->chunk_root->node)) {
+	ret = read_root_node(fs_info, fs_info->chunk_root, chunk_root_bytenr,
+			     generation, btrfs_super_chunk_root_level(sb));
+	if (ret) {
 		if (fs_info->ignore_chunk_tree_error) {
 			warning("cannot read chunk root, continue anyway");
 			fs_info->chunk_root = NULL;
-- 
2.26.3

