Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8341D5A985F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiIANU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiIANTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE978F74
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75874B826AA
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D566C433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038322;
        bh=+me+WSRUG25FhWrSD6YWFzteVWK2qbQBixYVceJP6xM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eNZ9Xgh8+3o7Dg5kCFsa21r/WltjxJCOK6njQ8YJCMihWK+t5uVpFi4WiAdtXp2ld
         8znknDomuWAKzOzG6NUXxSXVklpSQS3PsXXzqHPz5gytilMX/IXV/gXKsgGaJtSPmK
         4VwvYeA82EeabXk0NCFDNS/BPyVJOeSnJ7aw8m0jdKIDcrWwXZTSXbKFc5IdzcCJ52
         4lZWfCAuSHi4UU4fNRqWqU2/JIbVZXsZ3nH9ZZ19kfEf+Xh2pleD8vo/fvyUo+h8cU
         z+Ck3mU7TrNtzG6nsqdZh/yY8d4DGm1+b/nzPzWKyWNs7ze5MbGHpWG9N/yg4Uz4lq
         JAlNWJHGE955w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: skip unnecessary extent buffer sharedness checks during fiemap
Date:   Thu,  1 Sep 2022 14:18:29 +0100
Message-Id: <d80f75e12d0212da59cbcccac2eddd506c8998af.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During fiemap, for each file extent we find, we must check if it's shared
or not. The sharedness check starts by verifying if the extent is directly
shared (its refcount in the extent tree is > 1), and if it is not directly
shared, then we will check if every node in the subvolume b+tree leading
from the root to the leaf that has the file extent item (in reverse order),
is shared (through snapshots).

However this second step is not needed if our extent was created in a
transaction more recent than the last transaction where a snapshot of the
inode's root happened, because it can't be shared indirectly (through
shared subtrees) without a snapshot created in a more recent transaction.

So grab the generation of the extent from the extent map and pass it to
btrfs_is_data_extent_shared(), which will skip this second phase when the
generation is more recent than the root's last snapshot value. Note that
we skip this optimization if the extent map is the result of merging 2
or more extent maps, because in this case its generation is the maximum
of the generations of all merged extent maps.

The fact the we use extent maps and they can be merged despite the
underlying extents being distinct (different file extent items in the
subvolume b+tree and different extent items in the extent b+tree), can
result in some bugs when reporting shared extents. But this is a problem
of the current implementation of fiemap relying on extent maps.
One example where we get incorrect results is:

    $ cat fiemap-bug.sh
    #!/bin/bash

    DEV=/dev/sdj
    MNT=/mnt/sdj

    mkfs.btrfs -f $DEV
    mount $DEV $MNT

    # Create a file with two 256K extents.
    # Since there is no other write activity, they will be contiguous,
    # and their extent maps merged, despite having two distinct extents.
    xfs_io -f -c "pwrite -S 0xab 0 256K" \
              -c "fsync" \
              -c "pwrite -S 0xcd 256K 256K" \
              -c "fsync" \
              $MNT/foo

    # Now clone only the second extent into another file.
    xfs_io -f -c "reflink $MNT/foo 256K 0 256K" $MNT/bar

    # Filefrag will report a single 512K extent, and say it's not shared.
    echo
    filefrag -v $MNT/foo

    umount $MNT

Running the reproducer:

    $ ./fiemap-bug.sh
    wrote 262144/262144 bytes at offset 0
    256 KiB, 64 ops; 0.0038 sec (65.479 MiB/sec and 16762.7030 ops/sec)
    wrote 262144/262144 bytes at offset 262144
    256 KiB, 64 ops; 0.0040 sec (61.125 MiB/sec and 15647.9218 ops/sec)
    linked 262144/262144 bytes at offset 0
    256 KiB, 1 ops; 0.0002 sec (1.034 GiB/sec and 4237.2881 ops/sec)

    Filesystem type is: 9123683e
    File size of /mnt/sdj/foo is 524288 (128 blocks of 4096 bytes)
     ext:     logical_offset:        physical_offset: length:   expected: flags:
       0:        0..     127:       3328..      3455:    128:             last,eof
    /mnt/sdj/foo: 1 extent found

We end up reporting that we have a single 512K that is not shared, however
we have two 256K extents, and the second one is shared. Changing the
reproducer to clone instead the first extent into file 'bar', makes us
report a single 512K extent that is shared, which is algo incorrect since
we have two 256K extents and only the first one is shared.

This is z problem that existed before this change, and remains after this
change, as it can't be easily fixed. The next patch in the series reworks
fiemap to primarily use file extent items instead of extent maps (except
for checking for delalloc ranges), with the goal of improving its
scalability and performance, but it also ends up fixing this particular
bug caused by extent map merging.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   | 27 +++++++++++++++++++++------
 fs/btrfs/backref.h   |  1 +
 fs/btrfs/extent_io.c | 18 ++++++++++++++++--
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 40b48abb6978..bf4ca4a82550 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1613,12 +1613,14 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 /**
  * Check if a data extent is shared or not.
  *
- * @root:   root inode belongs to
- * @inum:   inode number of the inode whose extent we are checking
- * @bytenr: logical bytenr of the extent we are checking
- * @roots:  list of roots this extent is shared among
- * @tmp:    temporary list used for iteration
- * @cache:  a backref lookup result cache
+ * @root:        The root the inode belongs to.
+ * @inum:        Number of the inode whose extent we are checking.
+ * @bytenr:      Logical bytenr of the extent we are checking.
+ * @extent_gen:  Generation of the extent (file extent item) or 0 if it is
+ *               not known.
+ * @roots:       List of roots this extent is shared among.
+ * @tmp:         Temporary list used for iteration.
+ * @cache:       A backref lookup result cache.
  *
  * btrfs_is_data_extent_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
@@ -1632,6 +1634,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
  * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
  */
 int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_shared_cache *cache)
 {
@@ -1683,6 +1686,18 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 		if (ret < 0 && ret != -ENOENT)
 			break;
 		ret = 0;
+		/*
+		 * If our data extent is not shared through reflinks and it was
+		 * created in a generation after the last one used to create a
+		 * snapshot of the inode's root, then it can not be shared
+		 * indirectly through subtrees, as that can only happen with
+		 * snapshots. In this case bail out, no need to check for the
+		 * sharedness of extent buffers.
+		 */
+		if (level == -1 &&
+		    extent_gen > btrfs_root_last_snapshot(&root->root_item))
+			break;
+
 		if (level >= 0)
 			store_backref_shared_cache(cache, root, bytenr,
 						   level, false);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 797ba5371d55..7d18b5ac71dd 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -77,6 +77,7 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  struct btrfs_inode_extref **ret_extref,
 			  u64 *found_off);
 int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_shared_cache *cache);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 781436cc373c..0e3fa9b08aaf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5645,9 +5645,23 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= (FIEMAP_EXTENT_DELALLOC |
 				  FIEMAP_EXTENT_UNKNOWN);
 		} else if (fieinfo->fi_extents_max) {
+			u64 extent_gen;
 			u64 bytenr = em->block_start -
 				(em->start - em->orig_start);
 
+			/*
+			 * If two extent maps are merged, then their generation
+			 * is set to the maximum between their generations.
+			 * Otherwise its generation matches the one we have in
+			 * corresponding file extent item. If we have a merged
+			 * extent map, don't use its generation to speedup the
+			 * sharedness check below.
+			 */
+			if (test_bit(EXTENT_FLAG_MERGED, &em->flags))
+				extent_gen = 0;
+			else
+				extent_gen = em->generation;
+
 			/*
 			 * As btrfs supports shared space, this information
 			 * can be exported to userspace tools via
@@ -5656,8 +5670,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			 * lookup stuff.
 			 */
 			ret = btrfs_is_data_extent_shared(root, btrfs_ino(inode),
-							  bytenr, roots,
-							  tmp_ulist,
+							  bytenr, extent_gen,
+							  roots, tmp_ulist,
 							  backref_cache);
 			if (ret < 0)
 				goto out_free;
-- 
2.35.1

