Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA35FB242
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKMRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJKMRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03565665
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 045ABB815B8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37874C433B5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490648;
        bh=MCKoi632MKVdvYeJmUbF8g0OX055YKNRQptgjqV3oNs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GYYL/xoGk3uNCoVjO7iz5XRUhr4D0HN1y5NjvtasHvk/voZW/vl6gai1U7uoe1R3D
         KjAHNiXSlbsxyVSlH/537uKkYsgcs6NEI8oqj7a14vprHlZz4hNhPaY6/SRKXftJe1
         uO5siKuOIUwLBZssJbGod57dYfXZAjJYoKvzGLLEHKocsJolKTbmWtN9D090Mlflng
         L3jCxKe9Cy15YZA+fGISODxMGjRcQMol4QbJhUvnZF7Vnz+g1b4xp0AXN3PZvpnFbT
         VASVnQ1P2P1sME5/W1x5StgXDGYZGajBd3NikaOC4IR1UMAS6s1yuKmwyMDjQD4gVt
         yVA/iaO7jVSRQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/19] btrfs: avoid duplicated resolution of indirect backrefs during fiemap
Date:   Tue, 11 Oct 2022 13:17:08 +0100
Message-Id: <68efa89bd86900f1cee4b1cca82e5280a33e91cf.1665490019.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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

During fiemap, when determining if a data extent is shared or not, if we
don't find the extent is directly shared, then we need to determine if
it's shared through subtrees. For that we need to resolve the indirect
reference we found in order to figure out the path in the inode's fs tree,
which is a path starting at the fs tree's root node and going down to the
leaf that contains the file extent item that points to the data extent.
We then proceed to determine if any extent buffer in that path is shared
with other trees or not.

Currently whenever we find the data extent that a file extent item points
to is not directly shared, we always resolve the path in the fs tree, and
then check if any extent buffer in the path is shared. This is a lot of
work and when we have file extent items that belong to the same leaf, we
have the same path, so we only need to calculate it once.

This change does that, it keeps track of the current and previous leaf,
and when we find that a data extent is not directly shared, we try to
compute the fs tree path only once and then use it for every other file
extent item in the same leaf, using the existing cached path result for
the leaf as long as the cache results are valid.

This saves us from doing expensive b+tree searches in the fs tree of our
target inode, as well as other minor work.

The following test was run on a non-debug kernel (Debian's default kernel
config):

   $ cat test-with-snapshots.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   # Use compression to quickly create files with a lot of extents
   # (each with a size of 128K).
   mount -o compress=lzo $DEV $MNT

   # 40G gives 327680 extents, each with a size of 128K.
   xfs_io -f -c "pwrite -S 0xab -b 1M 0 40G" $MNT/foobar

   # Add some more files to increase the size of the fs and extent
   # trees (in the real world there's a lot of files and extents
   # from other files).
   xfs_io -f -c "pwrite -S 0xcd -b 1M 0 20G" $MNT/file1
   xfs_io -f -c "pwrite -S 0xef -b 1M 0 20G" $MNT/file2
   xfs_io -f -c "pwrite -S 0x73 -b 1M 0 20G" $MNT/file3

   # Create a snapshot so all the extents become indirectly shared
   # through subtrees, with a generation less than or equals to the
   # generation used to create the snapshot.
   btrfs subvolume snapshot -r $MNT $MNT/snap1

   umount $MNT
   mount -o compress=lzo $DEV $MNT

   start=$(date +%s%N)
   filefrag $MNT/foobar
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "fiemap took $dur milliseconds (metadata not cached)"
   echo

   start=$(date +%s%N)
   filefrag $MNT/foobar
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "fiemap took $dur milliseconds (metadata cached)"

   umount $MNT

Result before applying this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 1204 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 729 milliseconds (metadata cached)

Result after applying this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 732 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 421 milliseconds (metadata cached)

That's a -46.1% total reduction for the metadata not cached case, and
a -42.2% reduction for the cached metadata case.

The test is somewhat limited in the sense the gains may be higher in
practice, because in the test the filesystem is small, so we have small
fs and extent trees, plus there's no concurrent access to the trees as
well, therefore no lock contention there.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   | 64 +++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/backref.h   | 13 +++++++++
 fs/btrfs/extent_io.c |  2 ++
 3 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 19d5f8869ddf..f200c3945aa4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -16,8 +16,9 @@
 #include "misc.h"
 #include "tree-mod-log.h"
 
-/* Just an arbitrary number so we can be sure this happened */
-#define BACKREF_FOUND_SHARED 6
+/* Just arbitrary numbers so we can be sure one of these happened. */
+#define BACKREF_FOUND_SHARED     6
+#define BACKREF_FOUND_NOT_SHARED 7
 
 struct extent_inode_elem {
 	u64 inum;
@@ -135,7 +136,8 @@ struct preftrees {
  *  - decremented when a ref->count transitions to <1
  */
 struct share_check {
-	u64 root_objectid;
+	struct btrfs_backref_share_check_ctx *ctx;
+	struct btrfs_root *root;
 	u64 inum;
 	u64 data_bytenr;
 	/*
@@ -235,7 +237,7 @@ static void update_share_count(struct share_check *sc, int oldcount,
 	else if (oldcount < 1 && newcount > 0)
 		sc->share_count++;
 
-	if (newref->root_id == sc->root_objectid &&
+	if (newref->root_id == sc->root->root_key.objectid &&
 	    newref->wanted_disk_byte == sc->data_bytenr &&
 	    newref->key_for_search.objectid == sc->inum)
 		sc->self_ref_count += newref->count;
@@ -728,7 +730,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		if (sc && ref->root_id != sc->root_objectid) {
+		if (sc && ref->root_id != sc->root->root_key.objectid) {
 			free_pref(ref);
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
@@ -1451,6 +1453,44 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	 */
 	ASSERT(extent_is_shared(sc) == 0);
 
+	/*
+	 * If we are here for a data extent and we have a share_check structure
+	 * it means the data extent is not directly shared (does not have
+	 * multiple reference items), so we have to check if a path in the fs
+	 * tree (going from the root node down to the leaf that has the file
+	 * extent item pointing to the data extent) is shared, that is, if any
+	 * of the extent buffers in the path is referenced by other trees.
+	 */
+	if (sc && bytenr == sc->data_bytenr) {
+		/*
+		 * If we are only determining if a data extent is shared or not
+		 * and the corresponding file extent item is located in the same
+		 * leaf as the previous file extent item, we can skip resolving
+		 * indirect references for a data extent, since the fs tree path
+		 * is the same (same leaf, so same path). We skip as long as the
+		 * cached result for the leaf is valid and only if there's only
+		 * one file extent item pointing to the data extent, because in
+		 * the case of multiple file extent items, they may be located
+		 * in different leaves and therefore we have multiple paths.
+		 */
+		if (sc->ctx->curr_leaf_bytenr == sc->ctx->prev_leaf_bytenr &&
+		    sc->self_ref_count == 1) {
+			bool cached;
+			bool is_shared;
+
+			cached = lookup_backref_shared_cache(sc->ctx, sc->root,
+						     sc->ctx->curr_leaf_bytenr,
+						     0, &is_shared);
+			if (cached) {
+				if (is_shared)
+					ret = BACKREF_FOUND_SHARED;
+				else
+					ret = BACKREF_FOUND_NOT_SHARED;
+				goto out;
+			}
+		}
+	}
+
 	btrfs_release_path(path);
 
 	ret = add_missing_keys(fs_info, &preftrees, path->skip_locking == 0);
@@ -1731,7 +1771,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	struct btrfs_seq_list elem = BTRFS_SEQ_LIST_INIT(elem);
 	int ret = 0;
 	struct share_check shared = {
-		.root_objectid = root->root_key.objectid,
+		.ctx = ctx,
+		.root = root,
 		.inum = btrfs_ino(inode),
 		.data_bytenr = bytenr,
 		.share_count = 0,
@@ -1769,12 +1810,13 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 
 		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, &ctx->refs,
 					NULL, NULL, &shared, false);
-		if (ret == BACKREF_FOUND_SHARED) {
-			/* this is the only condition under which we return 1 */
-			ret = 1;
+		if (ret == BACKREF_FOUND_SHARED ||
+		    ret == BACKREF_FOUND_NOT_SHARED) {
+			/* If shared must return 1, otherwise return 0. */
+			ret = (ret == BACKREF_FOUND_SHARED) ? 1 : 0;
 			if (level >= 0)
 				store_backref_shared_cache(ctx, root, bytenr,
-							   level, true);
+							   level, ret == 1);
 			break;
 		}
 		if (ret < 0 && ret != -ENOENT)
@@ -1851,6 +1893,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	}
 out:
 	ulist_release(&ctx->refs);
+	ctx->prev_leaf_bytenr = ctx->curr_leaf_bytenr;
+
 	return ret;
 }
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index fda78db50be6..6dac462430b0 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -28,6 +28,19 @@ struct btrfs_backref_shared_cache_entry {
 struct btrfs_backref_share_check_ctx {
 	/* Ulists used during backref walking. */
 	struct ulist refs;
+	/*
+	 * The current leaf the caller of btrfs_is_data_extent_shared() is at.
+	 * Typically the caller (at the moment only fiemap) tries to determine
+	 * the sharedness of data extents point by file extent items from entire
+	 * leaves.
+	 */
+	u64 curr_leaf_bytenr;
+	/*
+	 * The previous leaf the caller was at in the previous call to
+	 * btrfs_is_data_extent_shared(). This may be the same as the current
+	 * leaf. On the first call it must be 0.
+	 */
+	u64 prev_leaf_bytenr;
 	/*
 	 * A path from a root to a leaf that has a file extent item pointing to
 	 * a given data extent should never exceed the maximum b+tree height.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index de62bdf11b33..e7bf750df366 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3969,6 +3969,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		if (extent_end <= lockstart)
 			goto next_item;
 
+		backref_ctx->curr_leaf_bytenr = leaf->start;
+
 		/* We have in implicit hole (NO_HOLES feature enabled). */
 		if (prev_extent_end < key.offset) {
 			const u64 range_end = min(key.offset, lockend) - 1;
-- 
2.35.1

