Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA53E6DF20A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDLKdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 06:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30176AD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 03:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B867632D9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B182C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681295596;
        bh=8R0levlHT19UunjBT3yyLqZS6H8MJdkR5Y4CQClQo3M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pgvCzz+EjmKm1Jvnkix1PE+KKzJUVupL9l+AlNMvYW5HpwNaSeH7PdnXBPJMGwXLw
         6HE+MmFREAUP0uNhfSPIYF3Wkfrpp+zN4IRZLK4FYs3+dNivLjt8nsIj+0KcOgvcho
         L71FXEPNcZAmSCfk8HyuDcOLXOYuXjERi6blJ4+/ymemTX3oZEN/t88vQD0HhkcZ00
         7S5QWRuzH4qGV8miv73dvr38cUYCp5FpHax3zusTdSPp5r0QPRzYykIZZLOC4LU+gp
         REtREAiIGmCuzqw1JXucmF6TlyTIfR4irqXxuFAR8ndIO5WJHWwtcCwxChQ1xYGeOY
         8AXEwzvxeD/XQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix btrfs_prev_leaf() to not return the same key twice
Date:   Wed, 12 Apr 2023 11:33:09 +0100
Message-Id: <e6eaa082d536fc5223eae4627bc7dc6369e257d9.1681295111.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1681295111.git.fdmanana@suse.com>
References: <cover.1681295111.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A call to btrfs_prev_leaf() may end up returning a path that points to the
same item (key) again. This happens if while btrfs_prev_leaf(), after we
release the path, a concurrent insertion happens, which moves items off
from a sibbling into the front of the previous leaf, and an item with the
computed previous key does not exists.

For example, suppose we have the two following leaves:

  Leaf A

  -------------------------------------------------------------
  | ...   key (300 96 10)   key (300 96 15)   key (300 96 16) |
  -------------------------------------------------------------
              slot 20             slot 21             slot 22

  Leaf B

  -------------------------------------------------------------
  | key (300 96 20)   key (300 96 21)   key (300 96 22)   ... |
  -------------------------------------------------------------
      slot 0             slot 1             slot 2

If we call btrfs_prev_leaf(), from btrfs_previous_item() for example, with
a path pointing to leaf B and slot 0 and the following happens:

1) At btrfs_prev_leaf() we compute the previous key to search as:
   (300 96 19), which is a key that does not exists in the tree;

2) Then we call btrfs_release_path() at btrfs_prev_leaf();

3) Some other task inserts a key at leaf A, that sorts before the key at
   slot 20, for example it has an objectid of 299. In order to make room
   for the new key, the key at slot 22 is moved to the front of leaf B.
   This happens at push_leaf_right(), called from split_leaf().

   After this leaf B now looks like:

  --------------------------------------------------------------------------------
  | key (300 96 16)    key (300 96 20)   key (300 96 21)   key (300 96 22)   ... |
  --------------------------------------------------------------------------------
       slot 0              slot 1             slot 2             slot 3

4) At btrfs_prev_leaf() we call btrfs_search_slot() for the computed
   previous key: (300 96 19). Since the key does not exists,
   btrfs_search_slot() returns 1 and with a path pointing to leaf B
   and slot 1, the item with key (300 96 20);

5) This makes btrfs_prev_leaf() return a path that points to slot 1 of
   leaf B, the same key as before it was called, since the key at slot 0
   of leaf B (300 96 16) is less than the computed previous key, which is
   (300 96 19);

6) As a consequence btrfs_previous_item() returns a path that points again
   to the item with key (300 96 20).

For some users of btrfs_prev_leaf() or btrfs_previous_item() this may not
be functional a problem, despite not making sense to return a new path
pointing again to the same item/key. However for a caller such as
tree-log.c:log_dir_items(), this has a bad consequence, as it can result
in not logging some dir index deletions in case the directory is being
logged without holding the inode's VFS lock (logging triggered while
logging a child inode for example) - for the example scenario above, in
case the dir index keys 17, 18 and 19 were deleted in the current
transaction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3c983c70028a..6bdd8e42c95e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4478,10 +4478,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
+	struct btrfs_key orig_key;
 	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -4498,8 +4500,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibbling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
 	btrfs_item_key(path->nodes[0], &found_key, 0);
 	ret = comp_keys(&found_key, &key);
 	/*
-- 
2.34.1

