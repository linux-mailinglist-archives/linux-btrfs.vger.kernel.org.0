Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B84D60BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbiCKLgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCKLgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C52184B71
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0BE7B82B1E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B7DC340EE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998539;
        bh=+gMvT4ciYARcTkD2RIXlY0/jv4s8bZfW2qcYtaP5dGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l72EDZV/hxiSmjnSqGy2yVmd+nseVSqNs/R0TLCRpPn939oqXXEaq6+lHOyiXFOqD
         CumJiA3wDtNSd1oCa933InMjH88/2apRw57NYJimcDb6/aUq2jX7mzFhkJMgZd7Mm9
         P+UhjLAmaPOxbJqnfpwlx9tvcIki1vsfbrLvQDijl0R1gIUny9YRUMi/DYECIIICUm
         klXPZtwLUeWdTQ28jvI2QQOevWMASlS4MWzASPAT0lhXMjFq19xdJYGfZFz9e5+oZX
         Fenw+kelKWbI6iEQVAxcZ4r4oZkDzKqxuQYk7sqdW3cNL0I/VNWGuqHb0xsY+eYa6i
         cquaS4dltJA/Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: avoid unnecessary btree search restarts when reading node
Date:   Fri, 11 Mar 2022 11:35:31 +0000
Message-Id: <0bbfc6eda99988c222320628e237a8e66f22ace5.1646998177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reading a btree node, at read_block_for_search(), if we don't find
the node's (or leaf) extent buffer in the cache, we will read it from
disk. Since that requires waiting on IO, we release all upper level nodes
from our path before reading the target node/leaf, and then return -EAGAIN
to the caller, which will make the caller restart the while btree search.

However we are causing the restart of btree search even for cases where
it is not necessary:

1) We have a path with ->skip_locking set to true, typically when doing
   a search on a commit root, so we are never holding locks on any node;

2) We are doing a read search (the "ins_len" argument passed to
   btrfs_search_slot() is 0), or we are doing a search to modify an
   existing key (the "cow" argument passed to btrfs_search_slot() has
   a value of 1 and "ins_len" is 0), in which case we never hold locks
   for upper level nodes;

3) We are doing a search to insert or delete a key, in which case we may
   or may not have upper level nodes locked. That depends on the current
   minimum write lock levels at btrfs_search_slot(), if we had to split
   or merge parent nodes, if we had to COW upper level nodes and if
   we ever visited slot 0 of an upper level node. It's still common to
   not have upper level nodes locked, but our current node must be at
   least at level 1, for insertions, or at least at level 2 for deletions.
   In these cases when we have locks on upper level nodes, they are always
   write locks.

These cases where we are not holding locks on upper level nodes far
outweigh the cases where we are holding locks, so it's completely wasteful
to retry the whole search when we have no upper nodes locked.

So change the logic to not return -EAGAIN, and make the caller retry the
search, when we don't have the parent node locked - when it's not locked
it means no other upper level nodes are locked as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0eecf98d0abb..8396079709c4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1447,19 +1447,22 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		return 0;
 	}
 
-	/*
-	 * reduce lock contention at high levels
-	 * of the btree by dropping locks before
-	 * we read.  Don't release the lock on the current
-	 * level because we need to walk this node to figure
-	 * out which blocks to read.
-	 */
-	btrfs_unlock_up_safe(p, level + 1);
+	if ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]) {
+		/*
+		 * Reduce lock contention at high levels of the btree by
+		 * dropping locks before we read.  Don't release the lock
+		 * on the current level because we need to walk this node
+		 * to figure out which blocks to read.
+		 */
+		btrfs_unlock_up_safe(p, level + 1);
+		ret = -EAGAIN;
+	} else {
+		ret = 0;
+	}
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
-	ret = -EAGAIN;
 	tmp = read_tree_block(fs_info, blocknr, root->root_key.objectid,
 			      gen, parent_level - 1, &first_key);
 	if (IS_ERR(tmp)) {
@@ -1474,9 +1477,14 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 */
 	if (!extent_buffer_uptodate(tmp))
 		ret = -EIO;
-	free_extent_buffer(tmp);
 
-	btrfs_release_path(p);
+	if (ret == 0) {
+		*eb_ret = tmp;
+	} else {
+		free_extent_buffer(tmp);
+		btrfs_release_path(p);
+	}
+
 	return ret;
 }
 
-- 
2.33.0

