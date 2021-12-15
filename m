Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF147626B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhLOUAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhLOT77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:59 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DCC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:59 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d21so13895132qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y5pCcCIHgqihEAKf9GAY8gVsSoBwrxGFlyrKMuXvKEE=;
        b=lWcfhpQ+Sgtjwo1fmgkbL/47fAVxPQ3rap6smZU5Fx4znQRHULOTDwXzICZggJPqEI
         oh1zw1bdJN6eTuk7XqovXNTXYGn2ANArRtUfswlrg1rTtJONNDpmeGUyyp4LZHvqR/WM
         nD+r8Rln6c3wfXMqpov1YmKno2T9EoaXX5oXQdTbzTcT48AlHbD8jjuWemJ1bswRucQp
         qUaQ3zJJrmcD6RvLibBfs2vFartg0c6PzeQ5Qh3a8n7zsdSNAFamCn+qxXn1QuitceMC
         8kTrAlS9RVgpyMm2XSNMv00zMzYIJwJnjVh7Gsmr7zZuU9+2J6pfrztYA0u0ktAKBuJZ
         SGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5pCcCIHgqihEAKf9GAY8gVsSoBwrxGFlyrKMuXvKEE=;
        b=HJiih9EN/fDT4gVI3hClFurvouV429i7zP9CrbRJdekgRjHwgSPRkoF9cKdvw8jizB
         UJAopIQl5GVOPohaOMmN75OgiE5Hiqg1x7MtpOgy4zYycQqHAebtnzH24s5PPCIuqwHZ
         buqqHolK5wisN8sM6hYBuKl/QxpG8JwB41NdaXUUEUnsuPWlCChjITtgLPUMZiyJGM3R
         lUAETR1cC3vf808IZALDGMY1M/PazGN8Ms2IrHiFZUT/FqIgF/0tuIznlwjAAZ/T8MKs
         22/7fTG5Ng9VBvepmxVElhv49ahffFHq0JzslzmKU1JXELfaUYx3R239ACV82yumfjap
         3nOQ==
X-Gm-Message-State: AOAM531BNtfH7OV1CcidDCaiBqDIF1Lzbqh79b+t67rqQC8llaa5OSNh
        ndz/Yqnp5imj0TpEV8N7vcGLTbl4LmaPTQ==
X-Google-Smtp-Source: ABdhPJwXl7TZ8iIJh2nbahz/14lDbNg3AD9ohSZeIT+SIA4V40TJd7WsYrGN5qcDZZVcJpzHqt4PIw==
X-Received: by 2002:a37:5f44:: with SMTP id t65mr9990317qkb.32.1639598398455;
        Wed, 15 Dec 2021 11:59:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id br13sm1665543qkb.10.2021.12.15.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 05/22] btrfs-progs: add print support for the block group tree
Date:   Wed, 15 Dec 2021 14:59:31 -0500
Message-Id: <8c38ca90cc4ec4b34a463004057b10346accc912.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index 73f969c3..a612c3d9 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1858,8 +1858,14 @@ static int empty_backup(struct btrfs_root_backup *backup)
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
@@ -1868,7 +1874,8 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_chunk_root(backup),
 			btrfs_backup_chunk_root_gen(backup),
 			btrfs_backup_chunk_root_level(backup));
-	printf("\t\tbackup_extent_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\t%s:\t%llu\tgen: %llu\tlevel: %d\n",
+			extent_tree_str,
 			btrfs_backup_extent_root(backup),
 			btrfs_backup_extent_root_gen(backup),
 			btrfs_backup_extent_root_level(backup));
@@ -1880,7 +1887,7 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_dev_root(backup),
 			btrfs_backup_dev_root_gen(backup),
 			btrfs_backup_dev_root_level(backup));
-	printf("\t\tbackup_csum_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\tcsum_root:\t%llu\tgen: %llu\tlevel: %d\n",
 			btrfs_backup_csum_root(backup),
 			btrfs_backup_csum_root_gen(backup),
 			btrfs_backup_csum_root_level(backup));
@@ -1898,12 +1905,14 @@ static void print_backup_roots(struct btrfs_super_block *sb)
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
@@ -2020,6 +2029,12 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
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

