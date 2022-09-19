Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0705BCE0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiISOGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiISOGw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117C31DEE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE8CAB81BE9
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D97AC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596408;
        bh=Or5t1DM/0Ku1bi6/XvyKX9lOJFyrB4O7Rcc1POQ0slk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YgDwfdzX3x+NL8m6uVpa+KJ93aes7D90UKCqScVmg3DphJz2bFSSb+g6AI7cws3cc
         wGbeh5Yp3kZALe5ReQw6kR+x1+OU+467DdqCKHCAhH1IQMhpGG7TOyB2ueiEfX+bGf
         Z9sUgr4np+5TJqcKp2pH29pgcKeMXgRUCeXKXbwMuF5fDahuaOdOas9C79rhSvnhAb
         VvC8Ts7LsmuuZLIAvyNrRxyXyuI+fBIQdKfZn2ELLlnu0LJgQ29no/Y1UMYU1gXrYn
         zOf9U8ry4fZFIxvXXR7ff4rllsT2XTdhnSu5Uqduzw+8v+cC33xwq/cLrOdsk2IG1M
         jt5PE07QRNZsA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/13] btrfs: move open coded extent map tree deletion out of inode eviction
Date:   Mon, 19 Sep 2022 15:06:32 +0100
Message-Id: <4cd54cc2de8d14b3ed23ea51fe80acafe09302fd.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Move the loop that removes all the extent maps from the inode's extent
map tree during inode eviction out of inode.c and into extent_map.c, to
btrfs_drop_extent_map_range(). Anything manipulating extent maps or the
extent map tree should be in extent_map.c.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 27 +++++++++++++++++++++++++++
 fs/btrfs/inode.c      | 15 +--------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 28c5e0243adc..7376c0aa2bca 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -660,6 +660,29 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * Drop all extent maps from a tree in the fastest possible way, rescheduling
+ * if needed. This avoids searching the tree, from the root down to the first
+ * extent map, before each deletion.
+ */
+static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
+{
+	write_lock(&tree->lock);
+	while (!RB_EMPTY_ROOT(&tree->map.rb_root)) {
+		struct extent_map *em;
+		struct rb_node *node;
+
+		node = rb_first_cached(&tree->map);
+		em = rb_entry(node, struct extent_map, rb_node);
+		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
+		remove_extent_mapping(tree, em);
+		free_extent_map(em);
+		cond_resched_rwlock_write(&tree->lock);
+	}
+	write_unlock(&tree->lock);
+}
+
 /*
  * Drop all extent maps in a given range.
  *
@@ -685,6 +708,10 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 	WARN_ON(end < start);
 	if (end == (u64)-1) {
+		if (start == 0 && !skip_pinned) {
+			drop_all_extent_maps_fast(em_tree);
+			return;
+		}
 		len = (u64)-1;
 		testend = false;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 32755e2977af..f0cfa9ff5ebd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5279,25 +5279,12 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 static void evict_inode_truncate_pages(struct inode *inode)
 {
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map_tree *map_tree = &BTRFS_I(inode)->extent_tree;
 	struct rb_node *node;
 
 	ASSERT(inode->i_state & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
-	write_lock(&map_tree->lock);
-	while (!RB_EMPTY_ROOT(&map_tree->map.rb_root)) {
-		struct extent_map *em;
-
-		node = rb_first_cached(&map_tree->map);
-		em = rb_entry(node, struct extent_map, rb_node);
-		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
-		remove_extent_mapping(map_tree, em);
-		free_extent_map(em);
-		cond_resched_rwlock_write(&map_tree->lock);
-	}
-	write_unlock(&map_tree->lock);
+	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 
 	/*
 	 * Keep looping until we have no more ranges in the io tree.
-- 
2.35.1

