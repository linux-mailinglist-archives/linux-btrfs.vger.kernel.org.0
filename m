Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59327CF89D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjJSMTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbjJSMTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:19:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00BBE
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 05:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F5CC433C8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717975;
        bh=zJzxELriqloikKA7piv4tbwMkH3YseNDFXJcf4ySdG0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AOsCQsOG7wWYU71vsWD64ABn3uWEnJyZet0RZPuKEf0MNHLm9f9KO0b61/spyAOcs
         yqP/4U835QR4uPFJA5r41gzvDUi6pWZWsrxD60mqsNh1leBHT5Za79sZ362YfFIsLM
         4KcTcC8J9q4RrJBNGzM75b2Ay0nj1BSiu6Qn+4kMhBQUWm0ysIWNjW4MwPCLGjN655
         ZQoYy26PlXRdjXenE1YBMT0wuElnjWq0K2TAnxh2MySTShNgT7aGGWKZMRYkgdC34a
         Rbkqlp300Z8HvnzverkeTQCkN4OAk1d+xu/Ar2i0aTvG43gnNfR0L+ts1/WD38l1VC
         pTHl9SlhnW48g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix unwritten extent buffer after snapshoting a new subvolume
Date:   Thu, 19 Oct 2023 13:19:28 +0100
Message-Id: <ef914e446f823ccd3328a3471d3470b9b87a0996.1697716427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697716427.git.fdmanana@suse.com>
References: <cover.1697716427.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a snapshot of a subvolume that was created in the current
transaction, we can end up not persisting a dirty extent buffer that is
referenced by the snapshot, resulting in IO errors due to checksum failures
when trying to read the extent buffer later from disk. A sequence of steps
that leads to this is the following:

1) At ioctl.c:create_subvol() we allocate an extent buffer, with logical
   address 36007936, for the leaf/root of a new subvolume that has an ID
   of 291. We mark the extent buffer as dirty, and at this point the
   subvolume tree has a single node/leaf which is also its root (level 0);

2) We no longer commit the transaction used to create the subvolume at
   create_subvol(). We used to, but that was recently removed in
   commit 1b53e51a4a8f ("btrfs: don't commit transaction for every subvol
   create");

3) The transaction used to create the subvolume has an ID of 33, so the
   extent buffer 36007936 has a generation of 33;

4) Several updates happen to subvolume 291 during transaction 33, several
   files created and its tree height changes from 0 to 1, so we end up with
   a new root at level 1 and the extent buffer 36007936 is now a leaf of
   that new root node, which is extent buffer 36048896.

   The commit root remains as 36007936, since we are still at transaction
   33;

5) Creation of a snapshot of subvolume 291, with an ID of 292, starts at
   ioctl.c:create_snapshot(). This triggers a commit of transaction 33 and
   we end up at transaction.c:create_pending_snapshot(), in the critical
   section of a transaction commit.

   There we COW the root of subvolume 291, which is extent buffer 36048896.
   The COW operation returns extent buffer 36048896, since there's no need
   to COW because the extent buffer was created in this transaction and it
   was not written yet.

   The we call btrfs_copy_root() against the root node 36048896. During
   this operation we allocate a new extent buffer to turn into the root
   node of the snapshot, copy the contents of the root node 36048896 into
   this snapshot root extent buffer, set the owner to 292 (the ID of the
   snapshot), etc, and then we call btrfs_inc_ref(). This will create a
   delayed reference for each leaf pointed by the root node with a
   reference root of 292 - this includes a reference for the leaf
   36007936.

   After that we set the bit BTRFS_ROOT_FORCE_COW in the root's state.

   Then we call btrfs_insert_dir_item(), to create the directory entry in
   in the tree of subvolume 291 that points to the snapshot. This ends up
   needing to modify leaf 36007936 to insert the respective directory
   items. Because the bit BTRFS_ROOT_FORCE_COW is set for the root's state,
   we need to COW the leaf. We end up at btrfs_force_cow_block() and then
   at update_ref_for_cow().

   At update_ref_for_cow() we call btrfs_block_can_be_shared() which
   returns false, despite the fact the leaf 36007936 is shared - the
   subvolume's root and the snapshot's root point to that leaf. The
   reason that it incorrectly returns false is because the commit root
   of the subvolume is extent buffer 36007936 - it was the initial root
   of the subvolume when we created it. So btrfs_block_can_be_shared()
   which has the following logic:

   int btrfs_block_can_be_shared(struct btrfs_root *root,
                                 struct extent_buffer *buf)
   {
       if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
           buf != root->node && buf != root->commit_root &&
           (btrfs_header_generation(buf) <=
            btrfs_root_last_snapshot(&root->root_item) ||
            btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
               return 1;

       return 0;
   }

   Returns false (0) since 'buf' (extent buffer 36007936) matches the
   root's commit root.

   As a result, at update_ref_for_cow(), we don't check for the number
   of references for extent buffer 36007936, we just assume it's not
   shared and therefore that it has only 1 reference, so we set the local
   variable 'refs' to 1.

   Later on, in the final if-else statement at update_ref_for_cow():

   static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
                                          struct btrfs_root *root,
                                          struct extent_buffer *buf,
                                          struct extent_buffer *cow,
                                          int *last_ref)
   {
      (...)
      if (refs > 1) {
          (...)
      } else {
          (...)
          btrfs_clear_buffer_dirty(trans, buf);
          *last_ref = 1;
      }
   }

   So we mark the extent buffer 36007936 as not dirty, and as a result
   we don't write it to disk later in the transaction commit, despite the
   fact that the snapshot's root points to it.

   Attempting to access the leaf or dumping the tree for example shows
   that the extent buffer was not written:

   $ btrfs inspect-internal dump-tree -t 292 /dev/sdb
   btrfs-progs v6.2.2
   file tree key (292 ROOT_ITEM 33)
   node 36110336 level 1 items 2 free space 119 generation 33 owner 292
   node 36110336 flags 0x1(WRITTEN) backref revision 1
   checksum stored a8103e3e
   checksum calced a8103e3e
   fs uuid 90c9a46f-ae9f-4626-9aff-0cbf3e2e3a79
   chunk uuid e8c9c885-78f4-4d31-85fe-89e5f5fd4a07
           key (256 INODE_ITEM 0) block 36007936 gen 33
           key (257 EXTENT_DATA 0) block 36052992 gen 33
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   total bytes 107374182400
   bytes used 38572032
   uuid 90c9a46f-ae9f-4626-9aff-0cbf3e2e3a79

   The respective on disk region is full of zeroes as the device was
   trimmed at mkfs time.

   Obviously 'btrfs check' also detects and complains about this:

   $ btrfs check /dev/sdb
   Opening filesystem to check...
   Checking filesystem on /dev/sdb
   UUID: 90c9a46f-ae9f-4626-9aff-0cbf3e2e3a79
   generation: 33 (33)
   [1/7] checking root items
   [2/7] checking extents
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   bad tree block 36007936, bytenr mismatch, want=36007936, have=0
   owner ref check failed [36007936 4096]
   ERROR: errors found in extent allocation tree or chunk allocation
   [3/7] checking free space tree
   [4/7] checking fs roots
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   checksum verify failed on 36007936 wanted 0x00000000 found 0x86005f29
   bad tree block 36007936, bytenr mismatch, want=36007936, have=0
   The following tree block(s) is corrupted in tree 292:
        tree block bytenr: 36110336, level: 1, node key: (256, 1, 0)
   root 292 root dir 256 not found
   ERROR: errors found in fs roots
   found 38572032 bytes used, error(s) found
   total csum bytes: 16048
   total tree bytes: 1265664
   total fs tree bytes: 1118208
   total extent tree bytes: 65536
   btree space waste bytes: 562598
   file data blocks allocated: 65978368
    referenced 36569088

Fix this by updating btrfs_block_can_be_shared() to consider that an
extent buffer may be shared if it matches the commit root and if its
generation matches the current transaction's generation.

This can be reproduced with the following script:

   $ cat test.sh
   #!/bin/bash

   MNT=/mnt/sdi
   DEV=/dev/sdi

   # Use a filesystem with a 64K node size so that we have the same node
   # size on every machine regardless of its page size (on x86_64 default
   # node size is 16K due to the 4K page size, while on PPC it's 64K by
   # default). This way we can make sure we are able to create a btree for
   # the subvolume with a height of 2.
   mkfs.btrfs -f -n 64K $DEV
   mount $DEV $MNT

   btrfs subvolume create $MNT/subvol

   # Create a few empty files on the subvolume, this bumps its btree
   # height to 2 (root node at level 1 and 2 leaves).
   for ((i = 1; i <= 300; i++)); do
       echo -n > $MNT/subvol/file_$i
   done

   btrfs subvolume snapshot -r $MNT/subvol $MNT/subvol/snap

   umount $DEV

   btrfs check $DEV

Running it on a 6.5 kernel (or any 6.6-rc kernel at the moment):

   $ ./test.sh
   Create subvolume '/mnt/sdi/subvol'
   Create a readonly snapshot of '/mnt/sdi/subvol' in '/mnt/sdi/subvol/snap'
   Opening filesystem to check...
   Checking filesystem on /dev/sdi
   UUID: bbdde2ff-7d02-45ca-8a73-3c36f23755a1
   [1/7] checking root items
   [2/7] checking extents
   parent transid verify failed on 30539776 wanted 7 found 5
   parent transid verify failed on 30539776 wanted 7 found 5
   parent transid verify failed on 30539776 wanted 7 found 5
   Ignoring transid failure
   owner ref check failed [30539776 65536]
   ERROR: errors found in extent allocation tree or chunk allocation
   [3/7] checking free space tree
   [4/7] checking fs roots
   parent transid verify failed on 30539776 wanted 7 found 5
   Ignoring transid failure
   Wrong key of child node/leaf, wanted: (256, 1, 0), have: (2, 132, 0)
   Wrong generation of child node/leaf, wanted: 5, have: 7
   root 257 root dir 256 not found
   ERROR: errors found in fs roots
   found 917504 bytes used, error(s) found
   total csum bytes: 0
   total tree bytes: 851968
   total fs tree bytes: 393216
   total extent tree bytes: 65536
   btree space waste bytes: 736550
   file data blocks allocated: 0
    referenced 0

A test case for fstests will follow soon.

Fixes: 1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
CC: stable@vger.kernel.org # 6.5+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c    | 14 +++++++++-----
 fs/btrfs/backref.h    |  3 ++-
 fs/btrfs/ctree.c      | 21 ++++++++++++++++-----
 fs/btrfs/ctree.h      |  3 ++-
 fs/btrfs/relocation.c |  7 ++++---
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0dc91bf654b5..beed7e459dab 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3199,12 +3199,14 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
  * We still need to do a tree search to find out the parents. This is for
  * TREE_BLOCK_REF backref (keyed or inlined).
  *
+ * @trans:	Transaction handle.
  * @ref_key:	The same as @ref_key in  handle_direct_tree_backref()
  * @tree_key:	The first key of this tree block.
  * @path:	A clean (released) path, to avoid allocating path every time
  *		the function get called.
  */
-static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
+static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
+					struct btrfs_backref_cache *cache,
 					struct btrfs_path *path,
 					struct btrfs_key *ref_key,
 					struct btrfs_key *tree_key,
@@ -3318,7 +3320,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 			 * If we know the block isn't shared we can avoid
 			 * checking its backrefs.
 			 */
-			if (btrfs_block_can_be_shared(root, eb))
+			if (btrfs_block_can_be_shared(trans, root, eb))
 				upper->checked = 0;
 			else
 				upper->checked = 1;
@@ -3366,11 +3368,13 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
  *	 links aren't yet bi-directional. Needs to finish such links.
  *	 Use btrfs_backref_finish_upper_links() to finish such linkage.
  *
+ * @trans:	Transaction handle.
  * @path:	Released path for indirect tree backref lookup
  * @iter:	Released backref iter for extent tree search
  * @node_key:	The first key of the tree block
  */
-int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
+int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
+				struct btrfs_backref_cache *cache,
 				struct btrfs_path *path,
 				struct btrfs_backref_iter *iter,
 				struct btrfs_key *node_key,
@@ -3470,8 +3474,8 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 			 * offset means the root objectid. We need to search
 			 * the tree to get its parent bytenr.
 			 */
-			ret = handle_indirect_tree_backref(cache, path, &key, node_key,
-							   cur);
+			ret = handle_indirect_tree_backref(trans, cache, path,
+							   &key, node_key, cur);
 			if (ret < 0)
 				goto out;
 		}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 83a9a34e948e..ab4ca0eda605 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -540,7 +540,8 @@ static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
 		    bytenr);
 }
 
-int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
+int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
+				struct btrfs_backref_cache *cache,
 				struct btrfs_path *path,
 				struct btrfs_backref_iter *iter,
 				struct btrfs_key *node_key,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c0c5f2239820..346f3104eee7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -370,7 +370,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 /*
  * check if the tree block can be shared by multiple trees
  */
-int btrfs_block_can_be_shared(struct btrfs_root *root,
+int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
 			      struct extent_buffer *buf)
 {
 	/*
@@ -379,11 +380,21 @@ int btrfs_block_can_be_shared(struct btrfs_root *root,
 	 * not allocated by tree relocation, we know the block is not shared.
 	 */
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-	    buf != root->node && buf != root->commit_root &&
+	    buf != root->node &&
 	    (btrfs_header_generation(buf) <=
 	     btrfs_root_last_snapshot(&root->root_item) ||
-	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
-		return 1;
+	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))) {
+		if (buf != root->commit_root)
+			return 1;
+		/*
+		 * An extent buffer that used to be the commit root may still be
+		 * shared because the tree height may have increased and it
+		 * became a child of a higher level root. This can happen when
+		 * snapshoting a subvolume created in the current transaction.
+		 */
+		if (btrfs_header_generation(buf) == trans->transid)
+			return 1;
+	}
 
 	return 0;
 }
@@ -418,7 +429,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	 * are only allowed for blocks use full backrefs.
 	 */
 
-	if (btrfs_block_can_be_shared(root, buf)) {
+	if (btrfs_block_can_be_shared(trans, root, buf)) {
 		ret = btrfs_lookup_extent_info(trans, fs_info, buf->start,
 					       btrfs_header_level(buf), 1,
 					       &refs, &flags);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4dfa20e2f39a..99fe28bc013b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -558,7 +558,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_block_can_be_shared(struct btrfs_root *root,
+int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
 			      struct extent_buffer *buf);
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a896f22e138b..f5d9e5f74a52 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -461,6 +461,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
  * cached.
  */
 static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
+			struct btrfs_trans_handle *trans,
 			struct reloc_control *rc, struct btrfs_key *node_key,
 			int level, u64 bytenr)
 {
@@ -494,8 +495,8 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 
 	/* Breadth-first search to build backref cache */
 	do {
-		ret = btrfs_backref_add_tree_node(cache, path, iter, node_key,
-						  cur);
+		ret = btrfs_backref_add_tree_node(trans, cache, path, iter,
+						  node_key, cur);
 		if (ret < 0) {
 			err = ret;
 			goto out;
@@ -2802,7 +2803,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 
 	/* Do tree relocation */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
-		node = build_backref_tree(rc, &block->key,
+		node = build_backref_tree(trans, rc, &block->key,
 					  block->level, block->bytenr);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
-- 
2.40.1

