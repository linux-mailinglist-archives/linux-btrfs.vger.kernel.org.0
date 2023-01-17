Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643966DC3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjAQLWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjAQLWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 06:22:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5631BADC
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 03:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E98612BC
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE0C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673954505;
        bh=P9AsgOWFdqrsTKj5TuSOTkuWaq2FcblB2GuBhvbG3gU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WXNAfz5cNABRNzSCGcjAxgX3wc25wjwh+/Eh58ucQ5/L0rBo4WWmKygQlZDbQbImW
         tHGiNqUIanv0ByQH3e8MwN1TQ+shNFySQk9rf5Uf76HuuZLoURrCfHKB4KL3SKMBHY
         wpyn3y/GN8UpnFz54r0wxD3kQCayD4gkX6dk9cPaP9jkWHIaDMeKprFns0nTZ5YSoK
         NNJckwAXEe1LNljerZhI2b14upCNFNMTT2KaC3vzJ8PcWx6Ywvj7uv0/R2ZPcjjqXn
         9imh4rWuN5iIkw+PxqhOF9sLdEzw8+cWyRjgzNV1JnlRw65gyQAz5CU+qJJGfMh1im
         V//8yox+5PVsg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: skip backref walking during fiemap if we know the leaf is shared
Date:   Tue, 17 Jan 2023 11:21:39 +0000
Message-Id: <50ea5c760791ff8cff1399a5c83de3a98013bf39.1673954069.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673954069.git.fdmanana@suse.com>
References: <cover.1673954069.git.fdmanana@suse.com>
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

During fiemap, when checking if a data extent is shared we are doing the
backref walking even if we already know the leaf is shared, which is a
waste of time since if the leaf shared then the data extent is also
shared. So skip the backref walking when we know we are in a shared leaf.

The following test was measures the gains for a case where all leaves
are shared due to a snapshot:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

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

   # Unmount and mount again to clear cached metadata.
   umount $MNT
   mount -o compress=lzo $DEV $MNT

   start=$(date +%s%N)
   # The filefrag tool  uses the fiemap ioctl.
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

The results were the following on a non-debug kernel (Debian's default
kernel config).

Before this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 1821 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 399 milliseconds (metadata cached)

After this patch:

   (...)
   /mnt/sdi/foobar: 327680 extents found
   fiemap took 591 milliseconds (metadata not cached)

   /mnt/sdi/foobar: 327680 extents found
   fiemap took 123 milliseconds (metadata cached)

That's a speedup of 3.1x and 3.2x.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f846fec08c86..90e40d5ceccd 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1872,6 +1872,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		.have_delayed_delete_refs = false,
 	};
 	int level;
+	bool leaf_cached;
+	bool leaf_is_shared;
 
 	for (int i = 0; i < BTRFS_BACKREF_CTX_PREV_EXTENTS_SIZE; i++) {
 		if (ctx->prev_extents_cache[i].bytenr == bytenr)
@@ -1893,6 +1895,23 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		walk_ctx.time_seq = elem.seq;
 	}
 
+	ctx->use_path_cache = true;
+
+	/*
+	 * We may have previously determined that the current leaf is shared.
+	 * If it is, then we have a data extent that is shared due to a shared
+	 * subtree (caused by snapshotting) and we don't need to check for data
+	 * backrefs. If the leaf is not shared, then we must do backref walking
+	 * to determine if the data extent is shared through reflinks.
+	 */
+	leaf_cached = lookup_backref_shared_cache(ctx, root,
+						  ctx->curr_leaf_bytenr, 0,
+						  &leaf_is_shared);
+	if (leaf_cached && leaf_is_shared) {
+		ret = 1;
+		goto out_trans;
+	}
+
 	walk_ctx.ignore_extent_item_pos = true;
 	walk_ctx.trans = trans;
 	walk_ctx.fs_info = fs_info;
@@ -1901,7 +1920,6 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	/* -1 means we are in the bytenr of the data extent. */
 	level = -1;
 	ULIST_ITER_INIT(&uiter);
-	ctx->use_path_cache = true;
 	while (1) {
 		bool is_shared;
 		bool cached;
@@ -1972,6 +1990,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		ctx->prev_extents_cache_slot = slot;
 	}
 
+out_trans:
 	if (trans) {
 		btrfs_put_tree_mod_seq(fs_info, &elem);
 		btrfs_end_transaction(trans);
-- 
2.35.1

