Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C321239B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgGBMoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMoJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C61238779;
        Thu,  2 Jul 2020 12:44:06 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/8] btrfs: Make get_state_failrec return failrec directly
Date:   Thu,  2 Jul 2020 15:23:28 +0300
Message-Id: <20200702122335.9117-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only failure that get_state_failrec can get is if there is no failurec
for the given address. There is no reason why the function should return
a status code and use a separate parameter for returning the actual
failure rec (if one is found). Simplify it by making the return type
a pointer and return ERR_PTR value in case of errors.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-io-tree.h |  4 ++--
 fs/btrfs/extent_io.c      | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index b6561455b3c4..62eef5b1dfc6 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -233,8 +233,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       struct extent_state **cached_state);
 
 /* This should be reworked in the future and put elsewhere. */
-int get_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record **failrec);
+struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
+					    u64 start);
 int set_state_failrec(struct extent_io_tree *tree, u64 start,
 		      struct io_failure_record *failrec);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8a7e9da74b87..6f0891ad353b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2121,12 +2121,12 @@ int set_state_failrec(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
-int get_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record **failrec)
+struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
+					    u64 start)
 {
 	struct rb_node *node;
 	struct extent_state *state;
-	int ret = 0;
+	struct io_failure_record *failrec;
 
 	spin_lock(&tree->lock);
 	/*
@@ -2135,18 +2135,19 @@ int get_state_failrec(struct extent_io_tree *tree, u64 start,
 	 */
 	node = tree_search(tree, start);
 	if (!node) {
-		ret = -ENOENT;
+		failrec = ERR_PTR(-ENOENT);
 		goto out;
 	}
 	state = rb_entry(node, struct extent_state, rb_node);
 	if (state->start != start) {
-		ret = -ENOENT;
+		failrec = ERR_PTR(-ENOENT);
 		goto out;
 	}
-	*failrec = state->failrec;
+
+	failrec = state->failrec;
 out:
 	spin_unlock(&tree->lock);
-	return ret;
+	return failrec;
 }
 
 /*
@@ -2376,8 +2377,8 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 	if (!ret)
 		return 0;
 
-	ret = get_state_failrec(failure_tree, start, &failrec);
-	if (ret)
+	failrec = get_state_failrec(failure_tree, start);
+	if (IS_ERR(failrec))
 		return 0;
 
 	BUG_ON(!failrec->this_mirror);
@@ -2461,8 +2462,8 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 	int ret;
 	u64 logical;
 
-	ret = get_state_failrec(failure_tree, start, &failrec);
-	if (ret) {
+	failrec = get_state_failrec(failure_tree, start);
+	if (IS_ERR(failrec)) {
 		failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
 		if (!failrec)
 			return -ENOMEM;
-- 
2.17.1

