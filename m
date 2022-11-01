Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989A614F01
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKAQQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiKAQQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE9A1C903
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B95F61668
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C85CC433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319366;
        bh=PM5W93Tt6FMQWHy8RTa1h9ZPc0t9lcX/43ddjfFAoZI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ROW/4J2MD9pqA4tLKlKRjgHHDmk8tql4bD0zJ2kTQ4CoHY3SudvJJ1BujOfnoAWP9
         IBTM2FwteLvk8RtIyucFHnvdSaiXOo2d2Ku6od9poGPgsOHWIQq3AeR4jPiCKXKsA2
         P6ilMiCmJ/ZxRnRhm/M4Ypn/M1pWgx0GzeLvIV5ixKk4zlbdg2zJG85N/0dtytDCFX
         9CCYBrH8FspHUhfu8DgY/uT/mTeu5XIfh6UmmgHUfEJnLYPKuDuvIeM/cVSiSeADtG
         vt2VZgdwbHpBa3iIJK7urWxPSPVbWI+vuK3wd4Hy4djWoe4owotHnl+Yk5gOK7UUxL
         pSMNK/3UOZc2w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/18] btrfs: send: optimize clone detection to increase extent sharing
Date:   Tue,  1 Nov 2022 16:15:45 +0000
Message-Id: <47473c33c761413af35563e02150acc9281fdcaf.1667315100.git.fdmanana@suse.com>
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

Currently send does not do the best decisions when it comes to decide
between multiple clone sources, which results in clone operations for
partial extent ranges, which has the following disadvantages:

1) We get less shared extents at the destination;

2) We have to read more data during the send operation and emit more
   write commands.

Besides not being optimal behaviour, it also breaks user expectations and
is often reported by users, with a recent example in the Link tag at the
bottom of this change log.

Part of the reason for this non-optimal behaviour is that the backref
walking code does not provide information about the length of the file
extent items that were found for each backref, so send is blind about
which backref is the best to chose as a cloning source.

The other existing reasons are just silliness, namely always prefering
the inode with the lowest number when multiple are found for the same
root and when we can clone from multiple roots, always prefer the send
root over any of the other clone roots. This does not make any sense
since any inode or root is fine and as good as any other inode/root.

Fix this by making backref walking pass information about the number of
bytes referenced by each file extent item and then have send's backref
callback pick the inode with the highest number of bytes for each root.
Finally select the root from which we can clone more bytes from.

Example reproducer:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   xfs_io -f -c "pwrite -S 0xab -b 2M 0 2M" $MNT/foo
   cp --reflink=always $MNT/foo $MNT/bar
   cp --reflink=always $MNT/foo $MNT/baz
   sync

   # Overwrite the second half of file foo.
   xfs_io -c "pwrite -S 0xcd -b 1M 1M 1M" $MNT/foo
   sync

   echo
   echo "*** fiemap in the original filesystem ***"
   echo
   xfs_io -c "fiemap -v" $MNT/foo
   xfs_io -c "fiemap -v" $MNT/bar
   xfs_io -c "fiemap -v" $MNT/baz
   echo

   btrfs filesystem du $MNT

   btrfs subvolume snapshot -r $MNT $MNT/snap

   btrfs send -f /tmp/send_stream $MNT/snap

   umount $MNT
   mkfs.btrfs -f $DEV &> /dev/null
   mount $DEV $MNT

   btrfs receive -f /tmp/send_stream $MNT

   echo
   echo "*** fiemap in the new filesystem ***"
   echo
   xfs_io -r -c "fiemap -v" $MNT/snap/foo
   xfs_io -r -c "fiemap -v" $MNT/snap/bar
   xfs_io -r -c "fiemap -v" $MNT/snap/baz
   echo

   btrfs filesystem du $MNT

   rm -f /tmp/send_stream
   rm -f /tmp/snap.fssum

   umount $MNT

Before this change:

   $ ./test.sh
   (...)

   *** fiemap in the original filesystem ***

   /mnt/sdi/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    30720..32767      2048   0x1
   /mnt/sdi/bar:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001
   /mnt/sdi/baz:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001

        Total   Exclusive  Set shared  Filename
      2.00MiB     1.00MiB           -  /mnt/sdi/foo
      2.00MiB       0.00B           -  /mnt/sdi/bar
      2.00MiB       0.00B           -  /mnt/sdi/baz
      6.00MiB     1.00MiB     2.00MiB  /mnt/sdi

   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap'
   At subvol /mnt/sdi/snap
   At subvol snap

   *** fiemap in the new filesystem ***

   /mnt/sdi/snap/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001
   /mnt/sdi/snap/bar:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    30720..32767      2048   0x1
   /mnt/sdi/snap/baz:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    32768..34815      2048   0x1

        Total   Exclusive  Set shared  Filename
      2.00MiB       0.00B           -  /mnt/sdi/snap/foo
      2.00MiB     1.00MiB           -  /mnt/sdi/snap/bar
      2.00MiB     1.00MiB           -  /mnt/sdi/snap/baz
      6.00MiB     2.00MiB           -  /mnt/sdi/snap
      6.00MiB     2.00MiB     2.00MiB  /mnt/sdi

We end up with two 1M extents that are not shared for files bar and baz.

After this change:

   $ ./test.sh
   (...)

   *** fiemap in the original filesystem ***

   /mnt/sdi/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    30720..32767      2048   0x1
   /mnt/sdi/bar:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001
   /mnt/sdi/baz:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001

        Total   Exclusive  Set shared  Filename
      2.00MiB     1.00MiB           -  /mnt/sdi/foo
      2.00MiB       0.00B           -  /mnt/sdi/bar
      2.00MiB       0.00B           -  /mnt/sdi/baz
      6.00MiB     1.00MiB     2.00MiB  /mnt/sdi
   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap'
   At subvol /mnt/sdi/snap
   At subvol snap

   *** fiemap in the new filesystem ***

   /mnt/sdi/snap/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..4095]:       26624..30719      4096 0x2001
   /mnt/sdi/snap/bar:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    30720..32767      2048 0x2001
   /mnt/sdi/snap/baz:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..2047]:       26624..28671      2048 0x2000
      1: [2048..4095]:    30720..32767      2048 0x2001

        Total   Exclusive  Set shared  Filename
      2.00MiB       0.00B           -  /mnt/sdi/snap/foo
      2.00MiB       0.00B           -  /mnt/sdi/snap/bar
      2.00MiB       0.00B           -  /mnt/sdi/snap/baz
      6.00MiB       0.00B           -  /mnt/sdi/snap
      6.00MiB       0.00B     3.00MiB  /mnt/sdi

Now there's a much better sharing, files bar and baz share 1M of the
extent of file foo and the second extent of files bar and baz is shared
between themselves.

This will later be turned into a test case for fstests.

Link: https://lore.kernel.org/linux-btrfs/20221008005704.795b44b0@crass-HP-ZBook-15-G2/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c |  9 +++++----
 fs/btrfs/backref.h |  4 ++--
 fs/btrfs/scrub.c   |  4 ++--
 fs/btrfs/send.c    | 49 +++++++++++++++++++++++++++++++---------------
 4 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 04cb608e7cfb..9be11a342de5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -27,6 +27,7 @@
 struct extent_inode_elem {
 	u64 inum;
 	u64 offset;
+	u64 num_bytes;
 	struct extent_inode_elem *next;
 };
 
@@ -37,6 +38,7 @@ static int check_extent_in_eb(const struct btrfs_key *key,
 			      struct extent_inode_elem **eie,
 			      bool ignore_offset)
 {
+	const u64 data_len = btrfs_file_extent_num_bytes(eb, fi);
 	u64 offset = 0;
 	struct extent_inode_elem *e;
 
@@ -45,10 +47,8 @@ static int check_extent_in_eb(const struct btrfs_key *key,
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
-		u64 data_len;
 
 		data_offset = btrfs_file_extent_offset(eb, fi);
-		data_len = btrfs_file_extent_num_bytes(eb, fi);
 
 		if (extent_item_pos < data_offset ||
 		    extent_item_pos >= data_offset + data_len)
@@ -63,6 +63,7 @@ static int check_extent_in_eb(const struct btrfs_key *key,
 	e->next = *eie;
 	e->inum = key->objectid;
 	e->offset = key->offset + offset;
+	e->num_bytes = data_len;
 	*eie = e;
 
 	return 0;
@@ -2265,7 +2266,7 @@ static int iterate_leaf_refs(struct btrfs_fs_info *fs_info,
 			    "ref for %llu resolved, key (%llu EXTEND_DATA %llu), root %llu",
 			    extent_item_objectid, eie->inum,
 			    eie->offset, root);
-		ret = iterate(eie->inum, eie->offset, root, ctx);
+		ret = iterate(eie->inum, eie->offset, eie->num_bytes, root, ctx);
 		if (ret) {
 			btrfs_debug(fs_info,
 				    "stopping iteration for %llu due to ret=%d",
@@ -2357,7 +2358,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-static int build_ino_list(u64 inum, u64 offset, u64 root, void *ctx)
+static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, u64 root, void *ctx)
 {
 	struct btrfs_data_container *inodes = ctx;
 	const size_t c = 3 * sizeof(u64);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 2dd68f87dca5..8d3598155f3b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -75,8 +75,8 @@ struct btrfs_backref_share_check_ctx {
 	int prev_extents_cache_slot;
 };
 
-typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
-		void *ctx);
+typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_bytes,
+				      u64 root, void *ctx);
 
 struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void);
 void btrfs_free_backref_share_ctx(struct btrfs_backref_share_check_ctx *ctx);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c7053d20c14..f9c58e39f7e1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -809,8 +809,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	return ERR_PTR(-ENOMEM);
 }
 
-static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
-				     void *warn_ctx)
+static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
+				     u64 root, void *warn_ctx)
 {
 	u32 nlink;
 	int ret;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 35c12fc7a864..4e175a8579ff 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -76,7 +76,7 @@ struct clone_root {
 	struct btrfs_root *root;
 	u64 ino;
 	u64 offset;
-
+	u64 num_bytes;
 	u64 found_refs;
 };
 
@@ -1273,7 +1273,8 @@ static int __clone_root_cmp_sort(const void *e1, const void *e2)
  * Called for every backref that is found for the current extent.
  * Results are collected in sctx->clone_roots->ino/offset/found_refs
  */
-static int __iterate_backrefs(u64 ino, u64 offset, u64 root, void *ctx_)
+static int __iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root,
+			      void *ctx_)
 {
 	struct backref_ctx *bctx = ctx_;
 	struct clone_root *found;
@@ -1318,15 +1319,17 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 root, void *ctx_)
 
 	bctx->found++;
 	found->found_refs++;
-	if (ino < found->ino) {
+
+	/*
+	 * If the given backref refers to a file extent item with a larger
+	 * number of bytes than what we found before, use the new one so that
+	 * we clone more optimally and end up doing less writes and getting
+	 * less exclusive, non-shared extents at the destination.
+	 */
+	if (num_bytes > found->num_bytes) {
 		found->ino = ino;
 		found->offset = offset;
-	} else if (found->ino == ino) {
-		/*
-		 * same extent found more then once in the same file.
-		 */
-		if (found->offset > offset + bctx->extent_len)
-			found->offset = offset;
+		found->num_bytes = num_bytes;
 	}
 
 	return 0;
@@ -1437,6 +1440,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 		cur_clone_root = sctx->clone_roots + i;
 		cur_clone_root->ino = (u64)-1;
 		cur_clone_root->offset = 0;
+		cur_clone_root->num_bytes = 0;
 		cur_clone_root->found_refs = 0;
 	}
 
@@ -1506,14 +1510,27 @@ static int find_extent_clone(struct send_ctx *sctx,
 
 	cur_clone_root = NULL;
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
-		if (sctx->clone_roots[i].found_refs) {
-			if (!cur_clone_root)
-				cur_clone_root = sctx->clone_roots + i;
-			else if (sctx->clone_roots[i].root == sctx->send_root)
-				/* prefer clones from send_root over others */
-				cur_clone_root = sctx->clone_roots + i;
-		}
+		struct clone_root *clone_root = &sctx->clone_roots[i];
 
+		if (clone_root->found_refs == 0)
+			continue;
+
+		/*
+		 * Choose the root from which we can clone more bytes, to
+		 * minimize write operations and therefore have more extent
+		 * sharing at the destination (the same as in the source).
+		 */
+		if (!cur_clone_root ||
+		    clone_root->num_bytes > cur_clone_root->num_bytes) {
+			cur_clone_root = clone_root;
+
+			/*
+			 * We found an optimal clone candidate (any inode from
+			 * any root is fine), so we're done.
+			 */
+			if (clone_root->num_bytes >= backref_ctx.extent_len)
+				break;
+		}
 	}
 
 	if (cur_clone_root) {
-- 
2.35.1

