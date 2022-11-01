Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3876614F06
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiKAQQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKAQQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E51C92A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB046165E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9FBC433D6
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319373;
        bh=GHbBMqokfNgIn3anPdP1PkxCGuJWX50FiVgFWFtH9nI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eKE102pfWrErQijJ2GCk2lXVwtFHCL6VDE8/2d5gQ5Cgmjw6VkSfFSYsPe6N6vw/r
         T/42OY2ribeMkMP+DooNj9ciyngDrIpFRBW7MTRXPc9HBPpb/DQUQOKIR9KwLaFN15
         58rZXjLMvwzbHh84cxacac4h8qo6fmtRbvCy5zP+6zi0GhhTCRYYth9cZbAoj4U6Sk
         KoCZZz10U7sNaD2rUBKW44+srCbLH388dQM5SXQj5pLbPW2aBE/StUaBSciUaUBt1o
         22DAuz5znnyAX1Q6QGI89+XQDNpZCFYkQdnWfDg8WXbgtzYAtpmdFUOSDaxn5jZ7e1
         AUEJP1gE9lViQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/18] btrfs: send: skip resolution of our own backref when finding clone source
Date:   Tue,  1 Nov 2022 16:15:53 +0000
Message-Id: <ed7bdccdecff25c3f57113009be46651c411a136.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing backref walking to determine a source range to clone from, it
is worthless to collect and resolve our own data backref, as we can't
obviously use it as a clone source and it represents the range we want to
clone into. Collecting the backref implies doing the extra work to resolve
it, doing the search for a file extent item in a subvolume tree, etc.
Skipping the data backref is valid as long as we only have the send root
as the single clone root, otherwise the leaf with the file extent item may
be accessible from another clone root due to shared subtrees created by
snapshots, and therefore we have to collect the backref and resolve it.

So add a callback to the backref walking code to guide it to skip data
backrefs.

This change is part of a patchset comprised of the following patches:

  01/17 btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
  02/17 btrfs: fix inode list leak during backref walking at find_parent_nodes()
  03/17 btrfs: fix ulist leaks in error paths of qgroup self tests
  04/17 btrfs: remove pointless and double ulist frees in error paths of qgroup tests
  05/17 btrfs: send: avoid unnecessary path allocations when finding extent clone
  06/17 btrfs: send: update comment at find_extent_clone()
  07/17 btrfs: send: drop unnecessary backref context field initializations
  08/17 btrfs: send: avoid unnecessary backref lookups when finding clone source
  09/17 btrfs: send: optimize clone detection to increase extent sharing
  10/17 btrfs: use a single argument for extent offset in backref walking functions
  11/17 btrfs: use a structure to pass arguments to backref walking functions
  12/17 btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
  13/17 btrfs: constify ulist parameter of ulist_next()
  14/17 btrfs: send: cache leaf to roots mapping during backref walking
  15/17 btrfs: send: skip unnecessary backref iterations
  16/17 btrfs: send: avoid double extent tree search when finding clone source
  17/17 btrfs: send: skip resolution of our own backref when finding clone source

The following test was run on non-debug kernel (Debian's default kernel
config) before and after applying the patchset:

   $ cat test-send-many-shared-extents.sh
   #!/bin/bash

   DEV=/dev/sdh
   MNT=/mnt/sdh

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   num_files=50000
   num_clones_per_file=50

   for ((i = 1; i <= $num_files; i++)); do
       xfs_io -f -c "pwrite 0 64K" $MNT/file_$i > /dev/null
       echo -ne "\r$i files created..."
   done
   echo

   btrfs subvolume snapshot -r $MNT $MNT/snap1

   cloned=0
   for ((i = 1; i <= $num_clones_per_file; i++)); do
       for ((j = 1; j <= $num_files; j++)); do
           cp --reflink=always $MNT/file_$j $MNT/file_${j}_clone_${i}
           cloned=$((cloned + 1))
           echo -ne "\r$cloned / $((num_files * num_clones_per_file)) clone operations"
       done
   done
   echo

   btrfs subvolume snapshot -r $MNT $MNT/snap2

   # Unmount and mount again to clear all cached metadata (and data).
   umount $DEV
   mount $DEV $MNT

   start=$(date +%s%N)
   btrfs send $MNT/snap2 > /dev/null
   end=$(date +%s%N)

   dur=$(( (end - start) / 1000000000 ))
   echo -e "\nFull send took $dur seconds"

   # Unmount and mount again to clear all cached metadata (and data).
   umount $DEV
   mount $DEV $MNT

   start=$(date +%s%N)
   btrfs send -p $MNT/snap1 $MNT/snap2 > /dev/null
   end=$(date +%s%N)

   dur=$(( (end - start) / 1000000000 ))
   echo -e "\nIncremental send took $dur seconds"

   umount $MNT

Before applying the patchset:

   (...)
   Full send took 1108 seconds
   (...)
   Incremental send took 1135 seconds

After applying the whole patchset:

   (...)
   Full send took 268 seconds            (-75.8%)
   (...)
   Incremental send took 316 seconds     (-72.2%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 35 +++++++++++++++++++++--------------
 fs/btrfs/backref.h |  9 +++++++++
 fs/btrfs/send.c    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 33056c4c0528..430974cf3b96 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1111,10 +1111,12 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
 
 			root = btrfs_extent_data_ref_root(leaf, dref);
 
-			ret = add_indirect_ref(ctx->fs_info, preftrees, root,
-					       &key, 0, ctx->bytenr, count,
-					       sc, GFP_NOFS);
-
+			if (!ctx->skip_data_ref ||
+			    !ctx->skip_data_ref(root, key.objectid, key.offset,
+						ctx->user_ctx))
+				ret = add_indirect_ref(ctx->fs_info, preftrees,
+						       root, &key, 0, ctx->bytenr,
+						       count, sc, GFP_NOFS);
 			break;
 		}
 		default:
@@ -1133,8 +1135,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
  *
  * Returns 0 on success, <0 on error, or BACKREF_FOUND_SHARED.
  */
-static int add_keyed_refs(struct btrfs_root *extent_root,
-			  struct btrfs_path *path, u64 bytenr,
+static int add_keyed_refs(struct btrfs_backref_walk_ctx *ctx,
+			  struct btrfs_root *extent_root,
+			  struct btrfs_path *path,
 			  int info_level, struct preftrees *preftrees,
 			  struct share_check *sc)
 {
@@ -1157,7 +1160,7 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
-		if (key.objectid != bytenr)
+		if (key.objectid != ctx->bytenr)
 			break;
 		if (key.type < BTRFS_TREE_BLOCK_REF_KEY)
 			continue;
@@ -1169,7 +1172,7 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 			/* SHARED DIRECT METADATA backref */
 			ret = add_direct_ref(fs_info, preftrees,
 					     info_level + 1, key.offset,
-					     bytenr, 1, NULL, GFP_NOFS);
+					     ctx->bytenr, 1, NULL, GFP_NOFS);
 			break;
 		case BTRFS_SHARED_DATA_REF_KEY: {
 			/* SHARED DIRECT FULL backref */
@@ -1180,14 +1183,14 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 					      struct btrfs_shared_data_ref);
 			count = btrfs_shared_data_ref_count(leaf, sdref);
 			ret = add_direct_ref(fs_info, preftrees, 0,
-					     key.offset, bytenr, count,
+					     key.offset, ctx->bytenr, count,
 					     sc, GFP_NOFS);
 			break;
 		}
 		case BTRFS_TREE_BLOCK_REF_KEY:
 			/* NORMAL INDIRECT METADATA backref */
 			ret = add_indirect_ref(fs_info, preftrees, key.offset,
-					       NULL, info_level + 1, bytenr,
+					       NULL, info_level + 1, ctx->bytenr,
 					       1, NULL, GFP_NOFS);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY: {
@@ -1211,9 +1214,13 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 			}
 
 			root = btrfs_extent_data_ref_root(leaf, dref);
-			ret = add_indirect_ref(fs_info, preftrees, root,
-					       &key, 0, bytenr, count,
-					       sc, GFP_NOFS);
+
+			if (!ctx->skip_data_ref ||
+			    !ctx->skip_data_ref(root, key.objectid, key.offset,
+						ctx->user_ctx))
+				ret = add_indirect_ref(fs_info, preftrees, root,
+						       &key, 0, ctx->bytenr,
+						       count, sc, GFP_NOFS);
 			break;
 		}
 		default:
@@ -1466,7 +1473,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 					      &preftrees, sc);
 			if (ret)
 				goto out;
-			ret = add_keyed_refs(root, path, ctx->bytenr, info_level,
+			ret = add_keyed_refs(ctx, root, path, info_level,
 					     &preftrees, sc);
 			if (ret)
 				goto out;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 1bd5a15c7f9e..ef6bbea3f456 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -116,6 +116,15 @@ struct btrfs_backref_walk_ctx {
 	 */
 	int (*check_extent_item)(u64 bytenr, const struct btrfs_extent_item *ei,
 				 const struct extent_buffer *leaf, void *user_ctx);
+	/*
+	 * If this is not NULL, then the backref walking code will call this for
+	 * each extent data ref it finds (BTRFS_EXTENT_DATA_REF_KEY keys) before
+	 * processing that data ref. If this callback return false, then it will
+	 * ignore this data ref and it will never resolve the indirect data ref,
+	 * saving time searching for leaves in a fs tree with file extent items
+	 * matching the data ref.
+	 */
+	bool (*skip_data_ref)(u64 root, u64 ino, u64 offset, void *user_ctx);
 	/* Context object to pass to the callbacks defined above. */
 	void *user_ctx;
 };
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f91cc95a0a3b..1bcbe386a24b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1284,6 +1284,10 @@ struct backref_ctx {
 
 	/* The bytenr the file extent item we are processing refers to. */
 	u64 bytenr;
+	/* The owner (root id) of the data backref for the current extent. */
+	u64 backref_owner;
+	/* The offset of the data backref for the current extent. */
+	u64 backref_offset;
 };
 
 static int __clone_root_cmp_bsearch(const void *key, const void *elt)
@@ -1558,6 +1562,18 @@ static int check_extent_item(u64 bytenr, const struct btrfs_extent_item *ei,
 	return 0;
 }
 
+static bool skip_self_data_ref(u64 root, u64 ino, u64 offset, void *ctx)
+{
+	const struct backref_ctx *bctx = ctx;
+
+	if (ino == bctx->cur_objectid &&
+	    root == bctx->backref_owner &&
+	    offset == bctx->backref_offset)
+		return true;
+
+	return false;
+}
+
 /*
  * Given an inode, offset and extent item, it finds a good clone for a clone
  * instruction. Returns -ENOENT when none could be found. The function makes
@@ -1624,6 +1640,12 @@ static int find_extent_clone(struct send_ctx *sctx,
 	backref_ctx.cur_objectid = ino;
 	backref_ctx.cur_offset = data_offset;
 	backref_ctx.bytenr = disk_byte;
+	/*
+	 * Use the header owner and not the send root's id, because in case of a
+	 * snapshot we can have shared subtrees.
+	 */
+	backref_ctx.backref_owner = btrfs_header_owner(eb);
+	backref_ctx.backref_offset = data_offset - btrfs_file_extent_offset(eb, fi);
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
@@ -1648,6 +1670,17 @@ static int find_extent_clone(struct send_ctx *sctx,
 	backref_walk_ctx.check_extent_item = check_extent_item;
 	backref_walk_ctx.user_ctx = &backref_ctx;
 
+	/*
+	 * If have a single clone root, then it's the send root and we can tell
+	 * the backref walking code to skip our own backref and not resolve it,
+	 * since we can not use it for cloning - the source and destination
+	 * ranges can't overlap and in case the leaf is shared through a subtree
+	 * due to snapshots, we can't use those other roots since they are not
+	 * in the list of clone roots.
+	 */
+	if (sctx->clone_roots_cnt == 1)
+		backref_walk_ctx.skip_data_ref = skip_self_data_ref;
+
 	ret = iterate_extent_inodes(&backref_walk_ctx, true, iterate_backrefs,
 				    &backref_ctx);
 	if (ret < 0)
-- 
2.35.1

