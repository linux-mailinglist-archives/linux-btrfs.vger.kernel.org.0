Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D502E6FC55F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEILuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjEILuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7A40F8;
        Tue,  9 May 2023 04:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F6360C61;
        Tue,  9 May 2023 11:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55FEC433D2;
        Tue,  9 May 2023 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633013;
        bh=Ku2ERc6eDr1c2rGAt/FE/EWl/+gqtTgpfRku/7PY4nU=;
        h=From:To:Cc:Subject:Date:From;
        b=EHhTbOB8awNqdRM+DyEyP8Ah4bZrQ0PZteaNoOCwAExX7szSFBLR6JCH2rM4qOkbA
         UUrpa2StYbrsA5r6kdlYqACrfZR4C4qq1vd0t/jULu89V0HbQcwe+n2rwGXiPM4hJl
         rv5uzenP628XWi5c4weKHA+gA4XhlbRh4TZAZaGIC//JziIyVQay6ttfMnFVjU21rA
         YTn7be/VBU6BXK6gw+eDOTOluaKMb/EqU1hQavkzu9XuxzpEO0ygUhp4DneFJ+LNRC
         Ki69LD8UZ7qZr/JFX8eRwnwvYarIwylfaS6/NmgRJ4D5v8UkL2/9YlVCGFIBjXrZ2e
         NKiDiSnn4/xgA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     git@vladimir.panteleev.md, Filipe Manana <fdmanana@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] btrfs: fix backref walking not returning all inode refs
Date:   Tue,  9 May 2023 12:50:02 +0100
Message-Id: <e58fb16de072382873edcc02c74366cbcb202499.1683632777.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the logical to ino ioctl v2, if the flag to ignore offsets of
file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
backref walking code ends up not returning references for all file offsets
of an inode that point to the given logical bytenr. This happens since
kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
offset in backref walking functions") because:

1) It mistakenly skipped the search for file extent items in a leaf that
   point to the target extent if that flag is given. Instead it should
   only skip the filtering done by check_extent_in_eb() - that is, it
   should not avoid the calls to that function (or find_extent_in_eb(),
   which uses it).

2) It was also not building a list of inode extent elements (struct
   extent_inode_elem) if we have multiple inode references for an extent
   when the ignore offset flag is given to the logical to ino ioctl - it
   would leave a single element, only the last one that was found.

These stem from the confusing old interface for backref walking functions
where we had an extent item offset argument that was a pointer to a u64
and another boolean argument that indicated if the offset should be
ignored, but the pointer could be NULL. That NULL case is used by
relocation, qgroup extent accounting and fiemap, simply to avoid building
the inode extent list for each reference, as it's not necessary for those
use cases and therefore avoids memory allocations and some computations.

Fix this by adding a boolean argument to the backref walk context
structure to indicate that the inode extent list should not be built,
make relocation set that argument to true and fix the backref walking
logic to skip the calls to check_extent_in_eb() and find_extent_in_eb()
only if this new argument is true, instead of 'ignore_extent_item_pos'
being true.

A test case for fstests will be added soon, to provide cover not only
for these cases but to the logical to ino ioctl in general as well, as
currently we do not have a test case for it.

Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Remove wrong check for a non-zero extent item offset.
    Apply the same logic at find_parent_nodes(), that is, search for file
    extent items on a leaf if the ignore flag is given - the filtering
    will be done later at check_extent_in_eb(). Spotted by Vladimir Panteleev
    in the thread mentioned above.

V3: Also fix the condition to decide if we should add an inode element to the
    list of inode elements built before. Also rework the fix based on that
    missing part.

 fs/btrfs/backref.c    | 19 ++++++++++---------
 fs/btrfs/backref.h    |  6 ++++++
 fs/btrfs/relocation.c |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e54f0884802a..79336fa853db 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,8 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	int root_count;
 	bool cached;
 
-	if (!btrfs_file_extent_compression(eb, fi) &&
+	if (!ctx->ignore_extent_item_pos &&
+	    !btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -552,7 +553,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 				count++;
 			else
 				goto next;
-			if (!ctx->ignore_extent_item_pos) {
+			if (!ctx->skip_inode_ref_list) {
 				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
 				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
 				    ret < 0)
@@ -564,7 +565,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 						  eie, (void **)&old, GFP_NOFS);
 			if (ret < 0)
 				break;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				while (old->next)
 					old = old->next;
 				old->next = eie;
@@ -1606,7 +1607,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
+			if (!ctx->skip_inode_ref_list && !ref->inode_list &&
 			    ref->level == 0) {
 				struct btrfs_tree_parent_check check = { 0 };
 				struct extent_buffer *eb;
@@ -1647,7 +1648,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 						  (void **)&eie, GFP_NOFS);
 			if (ret < 0)
 				goto out;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				/*
 				 * We've recorded that parent, so we must extend
 				 * its inode list here.
@@ -1743,7 +1744,7 @@ int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx)
 static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 {
 	const u64 orig_bytenr = ctx->bytenr;
-	const bool orig_ignore_extent_item_pos = ctx->ignore_extent_item_pos;
+	const bool orig_skip_inode_ref_list = ctx->skip_inode_ref_list;
 	bool roots_ulist_allocated = false;
 	struct ulist_iterator uiter;
 	int ret = 0;
@@ -1764,7 +1765,7 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 		roots_ulist_allocated = true;
 	}
 
-	ctx->ignore_extent_item_pos = true;
+	ctx->skip_inode_ref_list = true;
 
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
@@ -1789,7 +1790,7 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 	ulist_free(ctx->refs);
 	ctx->refs = NULL;
 	ctx->bytenr = orig_bytenr;
-	ctx->ignore_extent_item_pos = orig_ignore_extent_item_pos;
+	ctx->skip_inode_ref_list = orig_skip_inode_ref_list;
 
 	return ret;
 }
@@ -1912,7 +1913,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		goto out_trans;
 	}
 
-	walk_ctx.ignore_extent_item_pos = true;
+	walk_ctx.skip_inode_ref_list = true;
 	walk_ctx.trans = trans;
 	walk_ctx.fs_info = fs_info;
 	walk_ctx.refs = &ctx->refs;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ef6bbea3f456..1616e3e3f1e4 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -60,6 +60,12 @@ struct btrfs_backref_walk_ctx {
 	 * @extent_item_pos is ignored.
 	 */
 	bool ignore_extent_item_pos;
+	/*
+	 * If true and bytenr corresponds to a data extent, then the inode list
+	 * (each member describing inode number, file offset and root) is not
+	 * added to each reference added to the @refs ulist.
+	 */
+	bool skip_inode_ref_list;
 	/* A valid transaction handle or NULL. */
 	struct btrfs_trans_handle *trans;
 	/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 09b1988d1791..59a06499c647 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3422,7 +3422,7 @@ int add_data_references(struct reloc_control *rc,
 	btrfs_release_path(path);
 
 	ctx.bytenr = extent_key->objectid;
-	ctx.ignore_extent_item_pos = true;
+	ctx.skip_inode_ref_list = true;
 	ctx.fs_info = rc->extent_root->fs_info;
 
 	ret = btrfs_find_all_leafs(&ctx);
-- 
2.35.1

