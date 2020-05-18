Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378A51D767C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgERLPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 07:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgERLPE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 07:15:04 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D142084C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 11:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589800503;
        bh=cQZbP4XHGBvAhpTFkKPZwl0JxUF6acU7bhugkDOzk5s=;
        h=From:To:Subject:Date:From;
        b=OhWQNHsQeZ6P8tP9azrItLI+4rbzIvBWZpl18Fefc4Mn+bJSQ7cmO+gzou4F+wFb8
         jFjJ71Eqkgfa9f0HdFEAEs7ffQd/cwc7D1NJ/SQmI8pQR/gCsyzYLJCm0G96Qm2C+z
         dOjQb+n7sixC1+2sbcz0e6c9Mw4J4ttuCMpDkxdQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] Btrfs: make checksum item extension more efficient
Date:   Mon, 18 May 2020 12:15:00 +0100
Message-Id: <20200518111500.7268-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we want to add checksums into the checksums tree, or a log tree, we
try whenever possible to extend existing checksum items, as this helps
reduce amount of metadata space used, since adding a new item uses extra
metadata space for a btrfs_item structure (25 bytes).

However we have two inneficiencies in the current approach:

1) After finding a checksum item that covers a range with an end offset
   that matches the start offset of the checksum range we want to insert,
   we release the search path populated by btrfs_lookup_csum() and then
   do another COW search on tree with the goal of getting additional
   space for at least one checksum. Doing this path release and then
   searching again is a waste of time because very often the leaf already
   has enough free space for at least one more checksum;

2) After the COW search that guarantees we get free space in the leaf for
   at least one more checksum, we end up not doing the extension of the
   previous checksum item, and fallback to insertion of a new checksum
   item, if the leaf doesn't have an amount of free space larger then the
   space required for 2 checksums plus one btrfs_item structure - this is
   pointless for two reasons:

   a) We want to extend an existing item, so we don't need to account for
      a btrfs_item structure (25 bytes);

   b) We made the COW search with an insertion size for 1 single checksum,
      so if the leaf ends up with a free space amount smaller then 2
      checksums plus the size of a btrfs_item structure, we give up on the
      extension of the existing item and jump to the 'insert' label, where
      we end up releasing the path and then doing yet another search to
      insert a new checksum item for a single checksum.

Fix these inefficiencies by doing the following:

- For case 1), before releasing the path just check if the leaf already
  has enough space for at least 1 more checksum, and if it does, jump
  directly to the item extension code, with releasing our current path,
  which was already COWed by btrfs_lookup_csum();

- For case 2), fix the logic so that for item extension we require only
  that the leaf has enough free space for 1 checksum, and not a minimum
  of 2 checksums plus space for a btrfs_item structure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index b618ad5339ba..104858e2a836 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -905,9 +905,22 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	}
 
 	/*
-	 * at this point, we know the tree has an item, but it isn't big
-	 * enough yet to put our csum in.  Grow it
+	 * At this point, we know the tree has a checksum item that ends at an
+	 * offset matching the start of the checksum range we want to insert.
+	 * We try to extend that item as much as possible and then add as many
+	 * checksums to it as they fit.
+	 *
+	 * First check if the leaf has enough free space for at least one
+	 * checksum. If it has go directly to the item extension code, otherwise
+	 * release the path and do a search for insertion before the extension.
 	 */
+	if (btrfs_leaf_free_space(leaf) >= csum_size) {
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		csum_offset = (bytenr - found_key.offset) >>
+			fs_info->sb->s_blocksize_bits;
+		goto extend_csum;
+	}
+
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(trans, root, &file_key, path,
 				csum_size, 1);
@@ -931,19 +944,13 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		goto insert;
 	}
 
+extend_csum:
 	if (csum_offset == btrfs_item_size_nr(leaf, path->slots[0]) /
 	    csum_size) {
 		int extend_nr;
 		u64 tmp;
 		u32 diff;
-		u32 free_space;
-
-		if (btrfs_leaf_free_space(leaf) <
-				 sizeof(struct btrfs_item) + csum_size * 2)
-			goto insert;
 
-		free_space = btrfs_leaf_free_space(leaf) -
-					 sizeof(struct btrfs_item) - csum_size;
 		tmp = sums->len - total_bytes;
 		tmp >>= fs_info->sb->s_blocksize_bits;
 		WARN_ON(tmp < 1);
@@ -954,7 +961,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   MAX_CSUM_ITEMS(fs_info, csum_size) * csum_size);
 
 		diff = diff - btrfs_item_size_nr(leaf, path->slots[0]);
-		diff = min(free_space, diff);
+		diff = min_t(u32, btrfs_leaf_free_space(leaf), diff);
 		diff /= csum_size;
 		diff *= csum_size;
 
-- 
2.11.0

