Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28D05FB243
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJKMRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJKMRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39279558EA
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D8E0CE1697
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A001C433D6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490649;
        bh=LlVVasrBPj7nVkMrimppuoYogZnhGm/f5HwSNwgXJ90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kz2quJTZEuAaEKazaksoTwMgRw95I4YzkovScNJ5UdRRMe8rZt7t6qEFFPoSXcnj0
         IKkcsA6luxFQ4C4lNY/EHD7+77KSK5lWuvUolkscB4GC2eHvxMd9mYPyRbyv5z4vQA
         T76HqAITSxcGha0CsusZJgPr6SrIK3UpPZ/BlVY8k1ltNVpUABeIwtMYlOjmLIQCqu
         pMvmQBWOymwYom4sVyAu++AZMoACvDhGeHwcq7rc2LhDsenmqIMqMv9EFDBusEsU70
         NOytSB8Gh1xEltKBWgoQZ79vmK3DlR360hsA/gczGCA2N0u+DH7mecGKAxeaRcRVMJ
         +V7IvU7d8Axeg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/19] btrfs: avoid unnecessary resolution of indirect backrefs during fiemap
Date:   Tue, 11 Oct 2022 13:17:09 +0100
Message-Id: <50af763fe04355c0a3f99179deae4a8f9509293d.1665490019.git.fdmanana@suse.com>
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

However when the generation of the data extent is more recent than the
last generation used to snapshot the root, we don't need to determine
the path, since the data extent can not be shared through snapshots.
For this case we currently still determine the leaf of that path (at
find_parent_nodes(), but then stop determining the other nodes in the
path (at btrfs_is_data_extent_shared()) as it's pointless.

So do the check of the data extent's generation earlier, at
find_parent_nodes(), before trying to resolve the indirect reference to
determine the leaf in the path. This saves us from doing one expensive
b+tree search in the fs tree of our target inode, as well as other minor
work.

The following test was run on a non-debug kernel (Debian's default kernel
config):

   $ cat test-fiemap.sh
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

Before applying this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 1285 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 742 milliseconds (metadata cached)

After applying this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 689 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 393 milliseconds (metadata cached)

That's a -46.4% total reduction for the metadata not cached case, and
a -47.0% reduction for the cached metadata case.

The test is somewhat limited in the sense the gains may be higher in
practice, because in the test the filesystem is small, so we have small
fs and extent trees, plus there's no concurrent access to the trees as
well, therefore no lock contention there.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f200c3945aa4..e6b69ac1a77c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -140,6 +140,7 @@ struct share_check {
 	struct btrfs_root *root;
 	u64 inum;
 	u64 data_bytenr;
+	u64 data_extent_gen;
 	/*
 	 * Counts number of inodes that refer to an extent (different inodes in
 	 * the same root or different roots) that we could find. The sharedness
@@ -1462,6 +1463,21 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	 * of the extent buffers in the path is referenced by other trees.
 	 */
 	if (sc && bytenr == sc->data_bytenr) {
+		/*
+		 * If our data extent is from a generation more recent than the
+		 * last generation used to snapshot the root, then we know that
+		 * it can not be shared through subtrees, so we can skip
+		 * resolving indirect references, there's no point in
+		 * determining the extent buffers for the path from the fs tree
+		 * root node down to the leaf that has the file extent item that
+		 * points to the data extent.
+		 */
+		if (sc->data_extent_gen >
+		    btrfs_root_last_snapshot(&sc->root->root_item)) {
+			ret = BACKREF_FOUND_NOT_SHARED;
+			goto out;
+		}
+
 		/*
 		 * If we are only determining if a data extent is shared or not
 		 * and the corresponding file extent item is located in the same
@@ -1775,6 +1791,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		.root = root,
 		.inum = btrfs_ino(inode),
 		.data_bytenr = bytenr,
+		.data_extent_gen = extent_gen,
 		.share_count = 0,
 		.self_ref_count = 0,
 		.have_delayed_delete_refs = false,
@@ -1822,17 +1839,6 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		if (ret < 0 && ret != -ENOENT)
 			break;
 		ret = 0;
-		/*
-		 * If our data extent is not shared through reflinks and it was
-		 * created in a generation after the last one used to create a
-		 * snapshot of the inode's root, then it can not be shared
-		 * indirectly through subtrees, as that can only happen with
-		 * snapshots. In this case bail out, no need to check for the
-		 * sharedness of extent buffers.
-		 */
-		if (level == -1 &&
-		    extent_gen > btrfs_root_last_snapshot(&root->root_item))
-			break;
 
 		/*
 		 * If our data extent was not directly shared (without multiple
-- 
2.35.1

