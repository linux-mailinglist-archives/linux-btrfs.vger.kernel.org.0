Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F17AED1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjIZMpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjIZMpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F111D
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17507C433C9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732329;
        bh=FfhIAnx3tsr3Ht7kssvG76rgsTTJ7qDn9yiCAe3PKAU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FVuATkicRZegHha+ewKq3kjNGj546xS5ouHNGA4Z+bgqbZAGu8tG+Yaf/WQ6yPr9K
         ulhrsUKVTX/OHannuYIFpyaemk09qAthVqwg+Lcboha25mT7k9LZw5vOBqIiYXUf82
         N3Y9yGV82tPGuCpcnbOmynNkUqs/CqvHjFeL280NAizSEe3Aebht1cO8kojA7U3Stn
         cNmN8bzLDR/jVXOUiBkoteHEyd7k72KIJY448w/l2zCNUWM93ZnAf33tSHUYHiPpO6
         kwmkQGjivKkFMLFwDjk/GAQjiegB75VEvaRATpNIVI0QoTA80a4XkzRklP1i+FZUzo
         emurFILNOu74Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: rename and export __btrfs_cow_block()
Date:   Tue, 26 Sep 2023 13:45:18 +0100
Message-Id: <88a692d84cc6a0a58dcb278a272efe5c72f7e821.1695731844.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Rename and export __btrfs_cow_block() as btrfs_force_cow_block(). This is
to allow to move defrag specific code out of ctree.c and into defrag.c in
one of the next patches.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 30 +++++++++++++++---------------
 fs/btrfs/ctree.h |  7 +++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 9849477c5e19..fddf700cc1a7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -507,13 +507,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
  * bytes the allocator should try to find free next to the block it returns.
  * This is just a hint and may be ignored by the allocator.
  */
-static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct extent_buffer *buf,
-			     struct extent_buffer *parent, int parent_slot,
-			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size,
-			     enum btrfs_lock_nesting nest)
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_disk_key disk_key;
@@ -668,7 +668,7 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 }
 
 /*
- * cows a single block, see __btrfs_cow_block for the real work.
+ * COWs a single block, see btrfs_force_cow_block() for the real work.
  * This version of it has extra checks so that a block isn't COWed more than
  * once per transaction, as long as it hasn't been written yet
  */
@@ -721,8 +721,8 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
-	ret = __btrfs_cow_block(trans, root, buf, parent,
-				 parent_slot, cow_ret, search_start, 0, nest);
+	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
+				    cow_ret, search_start, 0, nest);
 
 	trace_btrfs_cow_block(root, buf, *cow_ret);
 
@@ -873,11 +873,11 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			search_start = last_block;
 
 		btrfs_tree_lock(cur);
-		err = __btrfs_cow_block(trans, root, cur, parent, i,
-					&cur, search_start,
-					min(16 * blocksize,
-					    (end_slot - i) * blocksize),
-					BTRFS_NESTING_COW);
+		err = btrfs_force_cow_block(trans, root, cur, parent, i,
+					    &cur, search_start,
+					    min(16 * blocksize,
+						(end_slot - i) * blocksize),
+					    BTRFS_NESTING_COW);
 		if (err) {
 			btrfs_tree_unlock(cur);
 			free_extent_buffer(cur);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0c059f20533d..c685952a544c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -484,6 +484,13 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret,
 		    enum btrfs_lock_nesting nest);
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
-- 
2.40.1

