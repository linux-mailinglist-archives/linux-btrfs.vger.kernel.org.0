Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2925FB240
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJKMRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJKMRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF64D175
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F358B815B1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AE3C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490646;
        bh=EcO2dFWcm1pFOoOzPG1tk8NYa+7hTGU6itcGzyXlqGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qZdn4h+wW0Ak6B8pxslB5AwGXRLSIHmoHCHbWSJk3ulMkYWtfOGS6ooXj2h54tAo4
         L50bY90z8dCEJYfjAxzZb1RvuQBWFGCk0PGGUbzWjNJ+dzn7V2TYGnkXTV8lJtdXm5
         sHVf+vVLh+YOE5C/HUcSrhXR0W4Fa8nVJQv0490hi6vuLBk2vGAMg5Hqq94bT9hdKT
         VwiQ2DRj+rMTe+6tdvX8x2XLGl4hXlbt8h/E58wvSdB6YhbNLbYNOxiLerYNaQfGKF
         ATa3DCOZv+JsnGCpwychgD1UJEk4663Oq3LcrDMQp9wXDPL35axsURhcjTDcnr1rSS
         0R7yFIW4z+50Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/19] btrfs: cache sharedness of the last few data extents during fiemap
Date:   Tue, 11 Oct 2022 13:17:06 +0100
Message-Id: <6550d0a22b38eff14e04b5343d46ded649040849.1665490019.git.fdmanana@suse.com>
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

During fiemap we process all the file extent items of an inode, by their
file offset order (left to right b+tree order), and then check if the data
extent they point at is shared or not. Until now we didn't cache those
results, we only did it for b+tree nodes/leaves since for each unique
b+tree path we have access to hundreds of file extent items. However, it
is also common to repeat checking the sharedness of a particular data
extent in a very short time window, and the cases that lead to that are
the following:

1) COW writes.

   If have a file extent item like this:

                  [ bytenr X, offset = 0, num_bytes = 512K ]
   file offset    0                                        512K

   Then a 4K write into file offset 64K happens, we end up with the
   following file extent item layout:

                  [ bytenr X, offset = 0, num_bytes = 64K ]
   file offset    0                                       64K

                  [ bytenr Y, offset = 0, num_bytes = 4K ]
   file offset   64K                                     68K

                  [ bytenr X, offset = 68K, num_bytes = 444K ]
   file offset   68K                                         512K

   So during fiemap we well check for the sharedness of the data extent
   with bytenr X twice. Typically for COW writes and for at least
   moderately updated files, we end up with many file extent items that
   point to different sections of the same data extent.

2) Writing into a NOCOW file after a snapshot is taken.

   This happens if the target extent was created in a generation older
   than the generation where the last snapshot for the root (the tree the
   inode belongs to) was made.

   This leads to a scenario like the previous one.

3) Writing into sections of a preallocated extent.

   For example if a file has the following layout:

   [ bytenr X, offset = 0, num_bytes = 1M, type = prealloc ]
   0                                                       1M

   After doing a 4K write into file offset 0 and another 4K write into
   offset 512K, we get the following layout:

      [ bytenr X, offset = 0, num_bytes = 4K, type = regular ]
      0                                                      4K

      [ bytenr X, offset = 4K, num_bytes = 508K, type = prealloc ]
     4K                                                          512K

      [ bytenr X, offset = 512K, num_bytes = 4K, type = regular ]
   512K                                                         516K

      [ bytenr X, offset = 516K, num_bytes = 508K, type = prealloc ]
   516K                                                            1M

   So we end up with 4 consecutive file extent items pointing to the data
   extent at bytenr X.

4) Hole punching in the middle of an extent.

   For example if a file has the following file extent item:

   [ bytenr X, offset = 0, num_bytes = 8M ]
   0                                      8M

   And then hole is punched for the file range [4M, 6M[, we our file
   extent item split into two:

   [ bytenr X, offset = 0, num_bytes = 4M  ]
   0                                       4M

   [ 2M hole, implicit or explicit depending on NO_HOLES feature ]
   4M                                                            6M

   [ bytenr X, offset = 6M, num_bytes = 2M  ]
   6M                                       8M

   Again, we end up with two file extent items pointing to the same
   data extent.

5) When reflinking (clone and deduplication) within the same file.
   This is probably the least common case of all.

In cases 1, 2, 4 and 4, when we have multiple file extent items that point
to the same data extent, their distance is usually short, typically
separated by a few slots in a b+tree leaf (or across sibling leaves). For
case 5, the distance can vary a lot, but it's typically the less common
case.

This change caches the result of the sharedness checks for data extents,
but only for the last 8 extents that we notice that our inode refers to
with multiple file extent items. Whenever we want to check if a data
extent is shared, we lookup the cache which consists of doing a linear
scan of an 8 elements array, and if we find the data extent there, we
return the result and don't check the extent tree and delayed refs.

The array/cache is small so that doing the search has no noticeable
negative impact on the performance in case we don't have file extent items
within a distance of 8 slots that point to the same data extent.

Slots in the cache/array are overwritten in a simple round robin fashion,
as that approach fits very well.

Using this simple approach with only the last 8 data extents seen is
effective as usually when multiple file extents items point to the same
data extent, their distance is within 8 slots. It also uses very little
memory and the time to cache a result or lookup the cache is negligible.

The following test was run on non-debug kernel (Debian's default kernel
config) to measure the impact in the case of COW writes (first example
given above), where we run fiemap after overwriting 33% of the blocks of
a file:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   FILE_SIZE=$((1 * 1024 * 1024  * 1024))

   # Create the file full of 1M extents.
   xfs_io -f -s -c "pwrite -b 1M -S 0xab 0 $FILE_SIZE" $MNT/foobar

   block_count=$((FILE_SIZE / 4096))
   # Overwrite about 33% of the file blocks.
   overwrite_count=$((block_count / 3))

   echo -e "\nOverwriting $overwrite_count 4K blocks (out of $block_count)..."
   RANDOM=123
   for ((i = 1; i <= $overwrite_count; i++)); do
       off=$(((RANDOM % block_count) * 4096))
       xfs_io -c "pwrite -S 0xcd $off 4K" $MNT/foobar > /dev/null
       echo -ne "\r$i blocks overwritten..."
   done
   echo -e "\n"

   # Unmount and mount to clear all cached metadata.
   umount $MNT
   mount $DEV $MNT

   start=$(date +%s%N)
   filefrag $MNT/foobar
   end=$(date +%s%N)
   dur=$(( (end - start) / 1000000 ))
   echo "fiemap took $dur milliseconds"

   umount $MNT

Result before applying this patch:

   fiemap took 128 milliseconds

Result after applying this patch:

   fiemap took 92 milliseconds   (-28.1%)

The test is somewhat limited in the sense the gains may be higher in
practice, because in the test the filesystem is small, so we have small
fs and extent trees, plus there's no concurrent access to the trees as
well, therefore no lock contention there.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 50 +++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/backref.h | 27 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 080d5f36106e..d93a0104ef70 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -137,7 +137,25 @@ struct preftrees {
 struct share_check {
 	u64 root_objectid;
 	u64 inum;
+	u64 data_bytenr;
+	/*
+	 * Counts number of inodes that refer to an extent (different inodes in
+	 * the same root or different roots) that we could find. The sharedness
+	 * check typically stops once this counter gets greater than 1, so it
+	 * may not reflect the total number of inodes.
+	 */
 	int share_count;
+	/*
+	 * The number of times we found our inode refers to the data extent we
+	 * are determining the sharedness. In other words, how many file extent
+	 * items we could find for our inode that point to our target data
+	 * extent. The value we get here after finishing the extent sharedness
+	 * check may be smaller than reality, but if it ends up being greater
+	 * than 1, then we know for sure the inode has multiple file extent
+	 * items that point to our inode, and we can safely assume it's useful
+	 * to cache the sharedness check result.
+	 */
+	int self_ref_count;
 	bool have_delayed_delete_refs;
 };
 
@@ -207,7 +225,7 @@ static int prelim_ref_compare(struct prelim_ref *ref1,
 }
 
 static void update_share_count(struct share_check *sc, int oldcount,
-			       int newcount)
+			       int newcount, struct prelim_ref *newref)
 {
 	if ((!sc) || (oldcount == 0 && newcount < 1))
 		return;
@@ -216,6 +234,11 @@ static void update_share_count(struct share_check *sc, int oldcount,
 		sc->share_count--;
 	else if (oldcount < 1 && newcount > 0)
 		sc->share_count++;
+
+	if (newref->root_id == sc->root_objectid &&
+	    newref->wanted_disk_byte == sc->data_bytenr &&
+	    newref->key_for_search.objectid == sc->inum)
+		sc->self_ref_count += newref->count;
 }
 
 /*
@@ -266,14 +289,14 @@ static void prelim_ref_insert(const struct btrfs_fs_info *fs_info,
 			 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
 			 */
 			update_share_count(sc, ref->count,
-					   ref->count + newref->count);
+					   ref->count + newref->count, newref);
 			ref->count += newref->count;
 			free_pref(newref);
 			return;
 		}
 	}
 
-	update_share_count(sc, 0, newref->count);
+	update_share_count(sc, 0, newref->count, newref);
 	preftree->count++;
 	trace_btrfs_prelim_ref_insert(fs_info, newref, NULL, preftree->count);
 	rb_link_node(&newref->rbnode, parent, p);
@@ -1710,11 +1733,18 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	struct share_check shared = {
 		.root_objectid = root->root_key.objectid,
 		.inum = btrfs_ino(inode),
+		.data_bytenr = bytenr,
 		.share_count = 0,
+		.self_ref_count = 0,
 		.have_delayed_delete_refs = false,
 	};
 	int level;
 
+	for (int i = 0; i < BTRFS_BACKREF_CTX_PREV_EXTENTS_SIZE; i++) {
+		if (ctx->prev_extents_cache[i].bytenr == bytenr)
+			return ctx->prev_extents_cache[i].is_shared;
+	}
+
 	ulist_init(&ctx->refs);
 
 	trans = btrfs_join_transaction_nostart(root);
@@ -1799,6 +1829,20 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		cond_resched();
 	}
 
+	/*
+	 * Cache the sharedness result for the data extent if we know our inode
+	 * has more than 1 file extent item that refers to the data extent.
+	 */
+	if (ret >= 0 && shared.self_ref_count > 1) {
+		int slot = ctx->prev_extents_cache_slot;
+
+		ctx->prev_extents_cache[slot].bytenr = shared.data_bytenr;
+		ctx->prev_extents_cache[slot].is_shared = (ret == 1);
+
+		slot = (slot + 1) % BTRFS_BACKREF_CTX_PREV_EXTENTS_SIZE;
+		ctx->prev_extents_cache_slot = slot;
+	}
+
 	if (trans) {
 		btrfs_put_tree_mod_seq(fs_info, &elem);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5f468f0defda..fda78db50be6 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -23,6 +23,8 @@ struct btrfs_backref_shared_cache_entry {
 	bool is_shared;
 };
 
+#define BTRFS_BACKREF_CTX_PREV_EXTENTS_SIZE 8
+
 struct btrfs_backref_share_check_ctx {
 	/* Ulists used during backref walking. */
 	struct ulist refs;
@@ -32,6 +34,31 @@ struct btrfs_backref_share_check_ctx {
 	 */
 	struct btrfs_backref_shared_cache_entry path_cache_entries[BTRFS_MAX_LEVEL];
 	bool use_path_cache;
+	/*
+	 * Cache the sharedness result for the last few extents we have found,
+	 * but only for extents for which we have multiple file extent items
+	 * that point to them.
+	 * It's very common to have several file extent items that point to the
+	 * same extent (bytenr) but with different offsets and lengths. This
+	 * typically happens for COW writes, partial writes into prealloc
+	 * extents, NOCOW writes after snapshoting a root, hole punching or
+	 * reflinking within the same file (less common perhaps).
+	 * So keep a small cache with the lookup results for the extent pointed
+	 * by the last few file extent items. This cache is checked, with a
+	 * linear scan, whenever btrfs_is_data_extent_shared() is called, so
+	 * it must be small so that it does not negatively affect performance in
+	 * case we don't have multiple file extent items that point to the same
+	 * data extent.
+	 */
+	struct {
+		u64 bytenr;
+		bool is_shared;
+	} prev_extents_cache[BTRFS_BACKREF_CTX_PREV_EXTENTS_SIZE];
+	/*
+	 * The slot in the prev_extents_cache array that will be used for
+	 * storing the sharedness result of a new data extent.
+	 */
+	int prev_extents_cache_slot;
 };
 
 typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
-- 
2.35.1

