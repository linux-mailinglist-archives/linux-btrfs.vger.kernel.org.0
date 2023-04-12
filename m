Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220656DF20B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDLKdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 06:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCB72BE
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 03:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17761632D5
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481EC433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681295597;
        bh=oSb1cQ2r2UDGTp37RvQC8OZpQhR5xHtCsFVZfsM3VR0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cvo1123vLFh64pYsUsHbIECkx9lsARR5BNvOkt4cFAMyT0iY91wgpKkZAjdNm98eR
         V1POlbZQ/WJlXfaD8+r0KoYxqBiwVwaWCt4bVi0CbDKH0DOA7w6aGFAls/5PV+B1wj
         rEqvHsThYRW4uidKhYkZHjgZr0/cL4B6V1lomUFhguTEwKyy7BYE7ZsGli4gQcZJxW
         GH1hUURKQbX425NGzxGI6qteMClJrBg59VWj/w+ROsQurlSx5H87gkF1MYBJziDoJ5
         oxPepEls53ved2I2k6l8NFw2ECuD77zwyCSf26QK7OfGMvDFc2UcBuVYWOCZziBFsS
         3pqavdxkph3fQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: unexport btrfs_prev_leaf()
Date:   Wed, 12 Apr 2023 11:33:10 +0100
Message-Id: <87089d229e731ab99a0f830ebbfe923dff06e2c3.1681295111.git.fdmanana@suse.com>
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

btrfs_prev_leaf() is not used outside ctree.c, so there's no need to
export it at ctree.h - just make it static at ctree.c and move its
definition above btrfs_search_slot_for_read(), since that function
calls it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 161 ++++++++++++++++++++++++-----------------------
 fs/btrfs/ctree.h |   1 -
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6bdd8e42c95e..d94429e0f16a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2378,6 +2378,87 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	return ret;
 }
 
+/*
+ * Search the tree again to find a leaf with smaller keys.
+ * Returns 0 if it found something.
+ * Returns 1 if there are no smaller keys.
+ * Returns < 0 on error.
+ *
+ * This may release the path, and so you may lose any locks held at the
+ * time you call it.
+ */
+static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
+{
+	struct btrfs_key key;
+	struct btrfs_key orig_key;
+	struct btrfs_disk_key found_key;
+	int ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
+
+	if (key.offset > 0) {
+		key.offset--;
+	} else if (key.type > 0) {
+		key.type--;
+		key.offset = (u64)-1;
+	} else if (key.objectid > 0) {
+		key.objectid--;
+		key.type = (u8)-1;
+		key.offset = (u64)-1;
+	} else {
+		return 1;
+	}
+
+	btrfs_release_path(path);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret <= 0)
+		return ret;
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
+	btrfs_item_key(path->nodes[0], &found_key, 0);
+	ret = comp_keys(&found_key, &key);
+	/*
+	 * We might have had an item with the previous key in the tree right
+	 * before we released our path. And after we released our path, that
+	 * item might have been pushed to the first slot (0) of the leaf we
+	 * were holding due to a tree balance. Alternatively, an item with the
+	 * previous key can exist as the only element of a leaf (big fat item).
+	 * Therefore account for these 2 cases, so that our callers (like
+	 * btrfs_previous_item) don't miss an existing item with a key matching
+	 * the previous key we computed above.
+	 */
+	if (ret <= 0)
+		return 0;
+	return 1;
+}
+
 /*
  * helper to use instead of search slot if no exact match is needed but
  * instead the next or previous item should be returned.
@@ -4467,86 +4548,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return ret;
 }
 
-/*
- * search the tree again to find a leaf with lesser keys
- * returns 0 if it found something or 1 if there are no lesser leaves.
- * returns < 0 on io errors.
- *
- * This may release the path, and so you may lose any locks held at the
- * time you call it.
- */
-int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
-{
-	struct btrfs_key key;
-	struct btrfs_key orig_key;
-	struct btrfs_disk_key found_key;
-	int ret;
-
-	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
-	orig_key = key;
-
-	if (key.offset > 0) {
-		key.offset--;
-	} else if (key.type > 0) {
-		key.type--;
-		key.offset = (u64)-1;
-	} else if (key.objectid > 0) {
-		key.objectid--;
-		key.type = (u8)-1;
-		key.offset = (u64)-1;
-	} else {
-		return 1;
-	}
-
-	btrfs_release_path(path);
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret <= 0)
-		return ret;
-
-	/*
-	 * Previous key not found. Even if we were at slot 0 of the leaf we had
-	 * before releasing the path and calling btrfs_search_slot(), we now may
-	 * be in a slot pointing to the same original key - this can happen if
-	 * after we released the path, one of more items were moved from a
-	 * sibbling leaf into the front of the leaf we had due to an insertion
-	 * (see push_leaf_right()).
-	 * If we hit this case and our slot is > 0 and just decrement the slot
-	 * so that the caller does not process the same key again, which may or
-	 * may not break the caller, depending on its logic.
-	 */
-	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
-		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
-		ret = comp_keys(&found_key, &orig_key);
-		if (ret == 0) {
-			if (path->slots[0] > 0) {
-				path->slots[0]--;
-				return 0;
-			}
-			/*
-			 * At slot 0, same key as before, it means orig_key is
-			 * the lowest, leftmost, key in the tree. We're done.
-			 */
-			return 1;
-		}
-	}
-
-	btrfs_item_key(path->nodes[0], &found_key, 0);
-	ret = comp_keys(&found_key, &key);
-	/*
-	 * We might have had an item with the previous key in the tree right
-	 * before we released our path. And after we released our path, that
-	 * item might have been pushed to the first slot (0) of the leaf we
-	 * were holding due to a tree balance. Alternatively, an item with the
-	 * previous key can exist as the only element of a leaf (big fat item).
-	 * Therefore account for these 2 cases, so that our callers (like
-	 * btrfs_previous_item) don't miss an existing item with a key matching
-	 * the previous key we computed above.
-	 */
-	if (ret <= 0)
-		return 0;
-	return 1;
-}
-
 /*
  * A helper function to walk down the tree starting at min_key, and looking
  * for nodes or leaves that are have a minimum transaction id.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4c1986cd5bed..e81f10e12867 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -633,7 +633,6 @@ static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_empty_items(trans, root, path, &batch);
 }
 
-int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			u64 time_seq);
 
-- 
2.34.1

