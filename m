Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5EA4469D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhKEUni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhKEUnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA73C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u16so8063611qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h1NeF227byL+FeSrIu8FVFd3clBfFlMtGbhud9NMqlA=;
        b=Hj2pGFmhW7cajSxBVXpZWXEdxeQtVrZYJDImWq6sK1P06fs8SyZkUkXebZTXbbtYSF
         ErYQw9jgWg0ChRBb1KoltYy9eACO+bBmJFzA7tTW0HYxFS2xXBi6nN5yQzh4MdyV9rpm
         8yA6uBHfNeGeH1DxfyFt5at+cJ5UR94H0DUtXgB1/PmL+Ap3PNv7/b/5NGx/S+hzxm+Y
         nhN291m5zbvwA08kmrv5KovFbjeggZW0rG0zqo1hPNv38IYqGtF/BOEKal1pyPS03Rnb
         KQMCLwQn0cYjup1BBfX0IIWfvw0+52yeZ/sFcjgrukzD7q1FHrfYz8EC2s0BaQRMOlrg
         +qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1NeF227byL+FeSrIu8FVFd3clBfFlMtGbhud9NMqlA=;
        b=FCy9laLxh9fchm39H0AjpVuWABnPe+hJ/xGVa4A9cwlvcOwa2PjJTcZVpnJnvm+pel
         nYFr9y64pjyFCwG7WNLxFfRwZS9vC07xhZ6JKrEu9oeFdKI6IheZ6C/NXzET8DUDom0B
         F3Tc1XCjbyzZ/NTJP3d803aDPtdh6utKInOCI2WIItmJnXoC8Insno9ACXChVNSqAijU
         PZKur1QM5HNEHfsLrc6721di89cDCilk8YitEEVXfBfpmL2v4P1mK1d+rFXJIi40FNbm
         iRHLkwTdiB9U7ujxGmUD5VmJMn+i2nTRBl7PqHCjEdNrqZnzMJtdcryp2/L1FNvPQsv8
         QEQA==
X-Gm-Message-State: AOAM532CB5M0FzB5DZ53t8Mb2Wx1Cgpt2WSTLSuZUjn/TsnTXItDJ8fo
        2fZxBIOC7SX8UNJsR9XY/iFbhUn71uSpjw==
X-Google-Smtp-Source: ABdhPJweb7+joCFFCpkYom+F0Qar+6r9zQPSGHvn3bI6LyDIE3r7Avv0xBAeCabfaksVT4bvPdDtYA==
X-Received: by 2002:ad4:4246:: with SMTP id l6mr1433248qvq.65.1636144856140;
        Fri, 05 Nov 2021 13:40:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w22sm6081883qto.15.2021.11.05.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/22] btrfs-progs: add print support for the block group tree
Date:   Fri,  5 Nov 2021 16:40:31 -0400
Message-Id: <9de77d7660cd983627a10767ce5f94c0e8614366.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the appropriate support to the print tree and dump tree code to spit
out the block group tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/inspect-dump-tree.c   | 30 +++++++++++++++++++++++++++++-
 kernel-shared/print-tree.c | 23 +++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 6332b46d..daa7f925 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -83,8 +83,14 @@ out:
 
 static void print_old_roots(struct btrfs_super_block *super)
 {
+	const char *extent_tree_str = "extent root";
 	struct btrfs_root_backup *backup;
 	int i;
+	bool extent_tree_v2 = (btrfs_super_incompat_flags(super) &
+		BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
+
+	if (extent_tree_v2)
+		extent_tree_str = "block group root";
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		backup = super->super_roots + i;
@@ -93,7 +99,7 @@ static void print_old_roots(struct btrfs_super_block *super)
 		       (unsigned long long)btrfs_backup_tree_root_gen(backup),
 		       (unsigned long long)btrfs_backup_tree_root(backup));
 
-		printf("\t\textent root gen %llu block %llu\n",
+		printf("\t\t%s gen %llu block %llu\n", extent_tree_str,
 		       (unsigned long long)btrfs_backup_extent_root_gen(backup),
 		       (unsigned long long)btrfs_backup_extent_root(backup));
 
@@ -510,6 +516,11 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				       info->log_root_tree->node->start,
 					btrfs_header_level(
 						info->log_root_tree->node));
+			if (info->block_group_root)
+				printf("block group tree: %llu level %d\n",
+				       info->block_group_root->node->start,
+					btrfs_header_level(
+						info->block_group_root->node));
 		} else {
 			if (info->tree_root->node) {
 				printf("root tree\n");
@@ -528,6 +539,12 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				btrfs_print_tree(info->log_root_tree->node,
 					BTRFS_PRINT_TREE_FOLLOW | print_mode);
 			}
+
+			if (info->block_group_root) {
+				printf("block group tree\n");
+				btrfs_print_tree(info->block_group_root->node,
+					BTRFS_PRINT_TREE_FOLLOW | print_mode);
+			}
 		}
 	}
 	tree_root_scan = info->tree_root;
@@ -573,6 +590,17 @@ again:
 		goto close_root;
 	}
 
+	if (tree_id && tree_id == BTRFS_BLOCK_GROUP_TREE_OBJECTID) {
+		if (!info->block_group_root) {
+			error("cannot print block group tree, invalid pointer");
+			goto close_root;
+		}
+		printf("block group tree\n");
+		btrfs_print_tree(info->block_group_root->node,
+					BTRFS_PRINT_TREE_FOLLOW | print_mode);
+		goto close_root;
+	}
+
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6748c33f..d2699e6c 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1860,8 +1860,14 @@ static int empty_backup(struct btrfs_root_backup *backup)
 	return 0;
 }
 
-static void print_root_backup(struct btrfs_root_backup *backup)
+static void print_root_backup(struct btrfs_root_backup *backup,
+			      bool extent_tree_v2)
 {
+	const char *extent_tree_str = "backup_extent_root";
+
+	if (extent_tree_v2)
+		extent_tree_str = "backup_block_group_root";
+
 	printf("\t\tbackup_tree_root:\t%llu\tgen: %llu\tlevel: %d\n",
 			btrfs_backup_tree_root(backup),
 			btrfs_backup_tree_root_gen(backup),
@@ -1870,7 +1876,8 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_chunk_root(backup),
 			btrfs_backup_chunk_root_gen(backup),
 			btrfs_backup_chunk_root_level(backup));
-	printf("\t\tbackup_extent_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\t%s:\t%llu\tgen: %llu\tlevel: %d\n",
+			extent_tree_str,
 			btrfs_backup_extent_root(backup),
 			btrfs_backup_extent_root_gen(backup),
 			btrfs_backup_extent_root_level(backup));
@@ -1882,7 +1889,7 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_dev_root(backup),
 			btrfs_backup_dev_root_gen(backup),
 			btrfs_backup_dev_root_level(backup));
-	printf("\t\tbackup_csum_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\tcsum_root:\t%llu\tgen: %llu\tlevel: %d\n",
 			btrfs_backup_csum_root(backup),
 			btrfs_backup_csum_root_gen(backup),
 			btrfs_backup_csum_root_level(backup));
@@ -1900,12 +1907,14 @@ static void print_backup_roots(struct btrfs_super_block *sb)
 {
 	struct btrfs_root_backup *backup;
 	int i;
+	bool extent_tree_v2 = (btrfs_super_incompat_flags(sb) &
+		BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		backup = sb->super_roots + i;
 		if (!empty_backup(backup)) {
 			printf("\tbackup %d:\n", i);
-			print_root_backup(backup);
+			print_root_backup(backup, extent_tree_v2);
 		}
 	}
 }
@@ -2022,6 +2031,12 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       (unsigned long long)btrfs_super_cache_generation(sb));
 	printf("uuid_tree_generation\t%llu\n",
 	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
+	printf("block_group_root\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root(sb));
+	printf("block_group_root_generation\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root_generation(sb));
+	printf("block_group_root_level\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root_level(sb));
 
 	uuid_unparse(sb->dev_item.uuid, buf);
 	printf("dev_item.uuid\t\t%s\n", buf);
-- 
2.26.3

