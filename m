Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFC5FB232
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKMRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKMRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946742E50
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B4C6117B
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D85C433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490633;
        bh=ByeA1xm/QJ7kq95vEl0/wPWLABGvmpEJKYCNMYXTGrM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ndJhUoCj7WpTvY1hV66ZERDq9tkQZn1Oq73GL6bwXmT0dCv8dbWucvc11664KpHfQ
         20+cppH/CnKOD5OgBw0gX+4c3bTNnAv36Ksz6qoj5NigZmEJ/HGITDkN53MpBZdTxw
         UGKmR2wsu+ihQMauk946uUrxNtcPb1tDfgqBC7LWs7hPRss5IphoxIOVLZUTs+3xjH
         H0ybTCQEVE+g2PZjtHabBZdakDXSNkC+dCLVyeQll7PIFAWaDAX7Qo7RyM8kbZ10bd
         WW0Rw5Nac8h0QcDKTcHHHPCC6BmZPcdb3cy4Y38rFRIDlE7sbeFcDzzM8+RA106BBY
         Z9yT50Duf/Pdg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/19] btrfs: fix processing of delayed data refs during backref walking
Date:   Tue, 11 Oct 2022 13:16:51 +0100
Message-Id: <11dbb89b10c0a4604a21c70fe3ee5c0575a3c3af.1665490018.git.fdmanana@suse.com>
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

When processing delayed data references during backref walking and we are
using a share context (we are being called through fiemap), whenever we
find a delayed data reference for an inode different from the one we are
interested in, then we immediately exit and consider the data extent as
shared. This is wrong, because:

1) This might be a DROP reference that will cancel out a reference in the
   extent tree;

2) Even if it's an ADD reference, it may be followed by a DROP reference
   that cancels it out.

In either case we should not exit immediately.

Fix this by never exiting when we find a delayed data reference for
another inode - instead add the reference and if it does not cancel out
other delayed reference, we will exit early when we call
extent_is_shared() after processing all delayed references. If we find
a drop reference, then signal the code that processes references from
the extent tree (add_inline_refs() and add_keyed_refs()) to not exit
immediately if it finds there a reference for another inode, since we
have delayed drop references that may cancel it out. In this later case
we exit once we don't have references in the rb trees that cancel out
each other and have two references for different inodes.

Example reproducer for case 1):

   $ cat test-1.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   xfs_io -f -c "pwrite 0 64K" $MNT/foo
   cp --reflink=always $MNT/foo $MNT/bar

   echo
   echo "fiemap after cloning:"
   xfs_io -c "fiemap -v" $MNT/foo

   rm -f $MNT/bar
   echo
   echo "fiemap after removing file bar:"
   xfs_io -c "fiemap -v" $MNT/foo

   umount $MNT

Running it before this patch, the extent is still listed as shared, it has
the flag 0x2000 (FIEMAP_EXTENT_SHARED) set:

   $ ./test-1.sh
   fiemap after cloning:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

   fiemap after removing file bar:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

Example reproducer for case 2):

   $ cat test-2.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   xfs_io -f -c "pwrite 0 64K" $MNT/foo
   cp --reflink=always $MNT/foo $MNT/bar

   # Flush delayed references to the extent tree and commit current
   # transaction.
   sync

   echo
   echo "fiemap after cloning:"
   xfs_io -c "fiemap -v" $MNT/foo

   rm -f $MNT/bar
   echo
   echo "fiemap after removing file bar:"
   xfs_io -c "fiemap -v" $MNT/foo

   umount $MNT

Running it before this patch, the extent is still listed as shared, it has
the flag 0x2000 (FIEMAP_EXTENT_SHARED) set:

   $ ./test-2.sh
   fiemap after cloning:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

   fiemap after removing file bar:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

After this patch, after deleting bar in both tests, the extent is not
reported with the 0x2000 flag anymore, it gets only the flag 0x1
(which is FIEMAP_EXTENT_LAST):

   $ ./test-1.sh
   fiemap after cloning:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

   fiemap after removing file bar:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128   0x1

   $ ./test-2.sh
   fiemap after cloning:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128 0x2001

   fiemap after removing file bar:
   /mnt/sdj/foo:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..127]:        26624..26751       128   0x1

These tests will later be converted to a test case for fstests.

Fixes: dc046b10c8b7d4 ("Btrfs: make fiemap not blow when you have lots of snapshots")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 3c0c1f626c75..cf47dabb786f 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -138,6 +138,7 @@ struct share_check {
 	u64 root_objectid;
 	u64 inum;
 	int share_count;
+	bool have_delayed_delete_refs;
 };
 
 static inline int extent_is_shared(struct share_check *sc)
@@ -884,13 +885,22 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			key.offset = ref->offset;
 
 			/*
-			 * Found a inum that doesn't match our known inum, we
-			 * know it's shared.
+			 * If we have a share check context and a reference for
+			 * another inode, we can't exit immediately. This is
+			 * because even if this is a BTRFS_ADD_DELAYED_REF
+			 * reference we may find next a BTRFS_DROP_DELAYED_REF
+			 * which cancels out this ADD reference.
+			 *
+			 * If this is a DROP reference and there was no previous
+			 * ADD reference, then we need to signal that when we
+			 * process references from the extent tree (through
+			 * add_inline_refs() and add_keyed_refs()), we should
+			 * not exit early if we find a reference for another
+			 * inode, because one of the delayed DROP references
+			 * may cancel that reference in the extent tree.
 			 */
-			if (sc && sc->inum && ref->objectid != sc->inum) {
-				ret = BACKREF_FOUND_SHARED;
-				goto out;
-			}
+			if (sc && count < 0)
+				sc->have_delayed_delete_refs = true;
 
 			ret = add_indirect_ref(fs_info, preftrees, ref->root,
 					       &key, 0, node->bytenr, count, sc,
@@ -920,7 +930,7 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 	}
 	if (!ret)
 		ret = extent_is_shared(sc);
-out:
+
 	spin_unlock(&head->lock);
 	return ret;
 }
@@ -1023,7 +1033,8 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum) {
+			if (sc && sc->inum && key.objectid != sc->inum &&
+			    !sc->have_delayed_delete_refs) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
 			}
@@ -1033,6 +1044,7 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			ret = add_indirect_ref(fs_info, preftrees, root,
 					       &key, 0, bytenr, count,
 					       sc, GFP_NOFS);
+
 			break;
 		}
 		default:
@@ -1122,7 +1134,8 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum) {
+			if (sc && sc->inum && key.objectid != sc->inum &&
+			    !sc->have_delayed_delete_refs) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
 			}
@@ -1661,6 +1674,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 		.root_objectid = root->root_key.objectid,
 		.inum = inum,
 		.share_count = 0,
+		.have_delayed_delete_refs = false,
 	};
 	int level;
 
@@ -1726,6 +1740,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 			break;
 		}
 		shared.share_count = 0;
+		shared.have_delayed_delete_refs = false;
 		cond_resched();
 	}
 
-- 
2.35.1

