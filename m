Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940D797603
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjIGQBB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjIGP5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 11:57:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA735AD;
        Thu,  7 Sep 2023 08:44:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E4C32796;
        Thu,  7 Sep 2023 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101425;
        bh=559ZihqjyEVehmsMsHSpkcwbAVi7ZKDxQyIjC8evgVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgG6ulClh1uCznNKmTube5EofSWmQn/1cb4ZyODsI8mtGH79j24pB1/hH5VdaU0Ay
         gb16W8MKLGAyec4BEPMmu0sRL5KlVVLq1xtys71bRGSwUJ2+jeYJwV0NquDvhqR3mQ
         N+TmkV1hVJyelEu+OyLbAmtHKcZM/iVy+5NkXA9o0mp8JbqONKc8klW3Wq6RIheRwB
         F2FlKySyq8mtt5mb3BfPM2VSNM9L3rX1GS5W3q5JMVgKUzr8jLkbrVzf9Xei0WsLUr
         PXy9GKxG5YxQj/ngO27gvWkAq6nxw0vZCetc32hCR1orwGyrvd1rGPQPNmQIkrnwN0
         6jFNaBGc/QdiA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 4/6] btrfs: handle errors properly in update_inline_extent_backref()
Date:   Thu,  7 Sep 2023 11:43:35 -0400
Message-Id: <20230907154338.3421582-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154338.3421582-1-sashal@kernel.org>
References: <20230907154338.3421582-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 257614301a5db9f7b0548584ca207ad7785c8b89 ]

[PROBLEM]
Inside function update_inline_extent_backref(), we have several
BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
filesystem.

[ANAYLYSE]
Most of those BUG_ON()s and ASSERT()s are just a way of handling
unexpected on-disk data.

Although we have tree-checker to rule out obviously incorrect extent
tree blocks, it's not enough for these ones.  Thus we need proper error
handling for them.

[FIX]
Thankfully all the callers of update_inline_extent_backref() would
eventually handle the errror by aborting the current transaction.
So this patch would do the proper error handling by:

- Make update_inline_extent_backref() to return int
  The return value would be either 0 or -EUCLEAN.

- Replace BUG_ON()s and ASSERT()s with proper error handling
  This includes:
  * Dump the bad extent tree leaf
  * Output an error message for the cause
    This would include the extent bytenr, num_bytes (if needed), the bad
    values and expected good values.
  * Return -EUCLEAN

  Note here we remove all the WARN_ON()s, as eventually the transaction
  would be aborted, thus a backtrace would be triggered anyway.

- Better comments on why we expect refs == 1 and refs_to_mode == -1 for
  tree blocks

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 73 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f396a9afa4032..21e48c422bc50 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -402,11 +402,11 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 		}
 	}
 
+	WARN_ON(1);
 	btrfs_print_leaf(eb);
 	btrfs_err(eb->fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
-	WARN_ON(1);
 
 	return BTRFS_REF_TYPE_INVALID;
 }
@@ -1079,13 +1079,13 @@ static int lookup_extent_backref(struct btrfs_trans_handle *trans,
 /*
  * helper to update/remove inline back ref
  */
-static noinline_for_stack
-void update_inline_extent_backref(struct btrfs_path *path,
+static noinline_for_stack int update_inline_extent_backref(struct btrfs_path *path,
 				  struct btrfs_extent_inline_ref *iref,
 				  int refs_to_mod,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
 	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_data_ref *dref = NULL;
 	struct btrfs_shared_data_ref *sref = NULL;
@@ -1098,18 +1098,33 @@ void update_inline_extent_backref(struct btrfs_path *path,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
-	WARN_ON(refs_to_mod < 0 && refs + refs_to_mod <= 0);
+	if (unlikely(refs_to_mod < 0 && refs + refs_to_mod <= 0)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+	"invalid refs_to_mod for extent %llu num_bytes %u, has %d expect >= -%llu",
+			  key.objectid, extent_size, refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 	btrfs_set_extent_refs(leaf, ei, refs);
 	if (extent_op)
 		__run_delayed_extent_op(extent_op, leaf, ei);
 
+	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
 	/*
-	 * If type is invalid, we should have bailed out after
-	 * lookup_inline_extent_backref().
+	 * Function btrfs_get_extent_inline_ref_type() has already printed
+	 * error messages.
 	 */
-	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
-	ASSERT(type != BTRFS_REF_TYPE_INVALID);
+	if (unlikely(type == BTRFS_REF_TYPE_INVALID))
+		return -EUCLEAN;
 
 	if (type == BTRFS_EXTENT_DATA_REF_KEY) {
 		dref = (struct btrfs_extent_data_ref *)(&iref->offset);
@@ -1119,10 +1134,43 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		refs = btrfs_shared_data_ref_count(leaf, sref);
 	} else {
 		refs = 1;
-		BUG_ON(refs_to_mod != -1);
+		/*
+		 * For tree blocks we can only drop one ref for it, and tree
+		 * blocks should not have refs > 1.
+		 *
+		 * Furthermore if we're inserting a new inline backref, we
+		 * won't reach this path either. That would be
+		 * setup_inline_extent_backref().
+		 */
+		if (unlikely(refs_to_mod != -1)) {
+			struct btrfs_key key;
+
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+			btrfs_print_leaf(leaf);
+			btrfs_err(fs_info,
+			"invalid refs_to_mod for tree block %llu, has %d expect -1",
+				  key.objectid, refs_to_mod);
+			return -EUCLEAN;
+		}
 	}
 
-	BUG_ON(refs_to_mod < 0 && refs < -refs_to_mod);
+	if (unlikely(refs_to_mod < 0 && refs < -refs_to_mod)) {
+		struct btrfs_key key;
+		u32 extent_size;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+"invalid refs_to_mod for backref entry, iref %lu extent %llu num_bytes %u, has %d expect >= -%llu",
+			  (unsigned long)iref, key.objectid, extent_size,
+			  refs_to_mod, refs);
+		return -EUCLEAN;
+	}
 	refs += refs_to_mod;
 
 	if (refs > 0) {
@@ -1142,6 +1190,7 @@ void update_inline_extent_backref(struct btrfs_path *path,
 		btrfs_truncate_item(path, item_size, 1);
 	}
 	btrfs_mark_buffer_dirty(leaf);
+	return 0;
 }
 
 static noinline_for_stack
@@ -1170,7 +1219,7 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 				   bytenr, num_bytes, root_objectid, path->slots[0]);
 			return -EUCLEAN;
 		}
-		update_inline_extent_backref(path, iref, refs_to_add, extent_op);
+		ret = update_inline_extent_backref(path, iref, refs_to_add, extent_op);
 	} else if (ret == -ENOENT) {
 		setup_inline_extent_backref(trans->fs_info, path, iref, parent,
 					    root_objectid, owner, offset,
@@ -1190,7 +1239,7 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 
 	BUG_ON(!is_data && refs_to_drop != 1);
 	if (iref)
-		update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
+		ret = update_inline_extent_backref(path, iref, -refs_to_drop, NULL);
 	else if (is_data)
 		ret = remove_extent_data_ref(trans, root, path, refs_to_drop);
 	else
-- 
2.40.1

