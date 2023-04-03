Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BC6D4666
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjDCOEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjDCOEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 10:04:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA910F2
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a9u13VW9g7YOR35d+NJv8UVCrxKC2gT/CniizTrDvq0=; b=s1is83yqQjbadn0d44cGwgFaTZ
        6+htTGOiSzB19HIj5WxKUzU4fjMTXVEcmpggL5Ly0jmD3xKq1a0vSz1s7DgHSVkik+kPgOHlDPLA1
        E3vm3FqXzfcIiNnUyhlcTum9rW5h3Z5RPy7az64JbxkYJ4KhjlNL4XPN12PIyWcu+crD1BS45A8mF
        IGcwSJW5GAhLJFPPwWFvfla8ngqCYyVsniGvTQ5HgfrRFnF/P4LVPPMFmXTgsnObztMIXYkP3u6ov
        E6NuXHaRZsL4sXwLLi3TeZ/qFNIUqOoeNBEsPEm7g06Wxrn3O9Vj0soM19Jd9yo015j7paFs4E5Rs
        KxvCt3NA==;
Received: from [2001:4bb8:191:a744:529d:286f:e3d8:fddb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjKmv-00FZAY-2U;
        Mon, 03 Apr 2023 14:04:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: factor out a clean_log_buffer helper
Date:   Mon,  3 Apr 2023 16:03:55 +0200
Message-Id: <20230403140355.1858319-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree-log code has three almost identical copies for the accounting on
an extent_buffer that doesn't need to be written any more.  The only
difference is that walk_down_log_tree passed the bytenr used to find the
buffer instead of extent_buffer.start and calculates the length using the
nodesize, while the other two callers look at the extent_buffer.len
field that must always be equivalent to the nodesize.

Factor the code into a common helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/tree-log.c | 92 +++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9ab793b638a7b9..38741b5a3cb57c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2562,6 +2562,28 @@ static void unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
 
 	btrfs_put_block_group(cache);
 }
+	
+static int clean_log_buffer(struct btrfs_trans_handle *trans,
+			    struct extent_buffer *eb)
+{
+	int ret;
+
+	btrfs_tree_lock(eb);
+	btrfs_clear_buffer_dirty(trans, eb);
+	wait_on_extent_buffer_writeback(eb);
+	btrfs_tree_unlock(eb);
+
+	if (trans) {
+		ret = btrfs_pin_reserved_extent(trans, eb->start, eb->len);
+		if (ret)
+			return ret;
+		btrfs_redirty_list_add(trans->transaction, eb);
+	} else {
+		unaccount_log_buffer(eb->fs_info, eb->start);
+	}
+
+	return 0;
+}
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
@@ -2573,7 +2595,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 	u64 ptr_gen;
 	struct extent_buffer *next;
 	struct extent_buffer *cur;
-	u32 blocksize;
 	int ret = 0;
 
 	while (*level > 0) {
@@ -2593,7 +2614,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		check.level = *level - 1;
 		check.has_first_key = true;
 		btrfs_node_key_to_cpu(cur, &check.first_key, path->slots[*level]);
-		blocksize = fs_info->nodesize;
 
 		next = btrfs_find_create_tree_block(fs_info, bytenr,
 						    btrfs_header_owner(cur),
@@ -2617,22 +2637,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					return ret;
 				}
 
-				btrfs_tree_lock(next);
-				btrfs_clear_buffer_dirty(trans, next);
-				wait_on_extent_buffer_writeback(next);
-				btrfs_tree_unlock(next);
-
-				if (trans) {
-					ret = btrfs_pin_reserved_extent(trans,
-							bytenr, blocksize);
-					if (ret) {
-						free_extent_buffer(next);
-						return ret;
-					}
-					btrfs_redirty_list_add(
-						trans->transaction, next);
-				} else {
-					unaccount_log_buffer(fs_info, bytenr);
+				ret = clean_log_buffer(trans, next);
+				if (ret) {
+					free_extent_buffer(next);
+					return ret;
 				}
 			}
 			free_extent_buffer(next);
@@ -2662,7 +2670,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path, int *level,
 				 struct walk_control *wc)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int i;
 	int slot;
 	int ret;
@@ -2682,27 +2689,9 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				return ret;
 
 			if (wc->free) {
-				struct extent_buffer *next;
-
-				next = path->nodes[*level];
-
-				btrfs_tree_lock(next);
-				btrfs_clear_buffer_dirty(trans, next);
-				wait_on_extent_buffer_writeback(next);
-				btrfs_tree_unlock(next);
-
-				if (trans) {
-					ret = btrfs_pin_reserved_extent(trans,
-						     path->nodes[*level]->start,
-						     path->nodes[*level]->len);
-					if (ret)
-						return ret;
-					btrfs_redirty_list_add(trans->transaction,
-							       next);
-				} else {
-					unaccount_log_buffer(fs_info,
-						path->nodes[*level]->start);
-				}
+				ret = clean_log_buffer(trans, path->nodes[*level]);
+				if (ret)
+					return ret;
 			}
 			free_extent_buffer(path->nodes[*level]);
 			path->nodes[*level] = NULL;
@@ -2720,7 +2709,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 static int walk_log_tree(struct btrfs_trans_handle *trans,
 			 struct btrfs_root *log, struct walk_control *wc)
 {
-	struct btrfs_fs_info *fs_info = log->fs_info;
 	int ret = 0;
 	int wret;
 	int level;
@@ -2762,26 +2750,8 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			 orig_level);
 		if (ret)
 			goto out;
-		if (wc->free) {
-			struct extent_buffer *next;
-
-			next = path->nodes[orig_level];
-
-			btrfs_tree_lock(next);
-			btrfs_clear_buffer_dirty(trans, next);
-			wait_on_extent_buffer_writeback(next);
-			btrfs_tree_unlock(next);
-
-			if (trans) {
-				ret = btrfs_pin_reserved_extent(trans,
-						next->start, next->len);
-				if (ret)
-					goto out;
-				btrfs_redirty_list_add(trans->transaction, next);
-			} else {
-				unaccount_log_buffer(fs_info, next->start);
-			}
-		}
+		if (wc->free)
+			ret = clean_log_buffer(trans, path->nodes[orig_level]);
 	}
 
 out:
-- 
2.39.2

