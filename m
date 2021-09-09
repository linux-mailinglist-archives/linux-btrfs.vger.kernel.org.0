Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CC404FF1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbhIIMXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 08:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351663AbhIIMTL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Sep 2021 08:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F27461A8F;
        Thu,  9 Sep 2021 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188217;
        bh=EO5WTZ8O4LLdufi6+e6+MagC1+NkIj5HFqVjt36Xhxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soouTyLhUBZC1aPkLHBVIL+Va/u2C58Fi1XjD5Yi3sK3WjMnAmsjB6OZwPx0H83UT
         PdrMBO7d4DNQQGwAOKqpfqP5R20GPiWSxQeXUrQvb6ePyeIqf0LyZNcoExj+hOGman
         tIYCNjsYRPfu6napHtewYMo7CpE3s6ZoQzRlKv854eQFriASBoHHRs78crGAK0onAr
         QpL7AAb0VkOLy9+iuu4vx0gI46mPl+8xu275ZURpU+OTEySs+STCADaWWamf2uzIaS
         jEmIEMmpi3ZX5NFBvWzFk4v92KyWPV9rWDMeXPZTGAbj9vIhFfiJe6drYTyu+zHuth
         SvdWvUxfq28PA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 172/219] btrfs: grab correct extent map for subpage compressed extent read
Date:   Thu,  9 Sep 2021 07:45:48 -0400
Message-Id: <20210909114635.143983-172-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114635.143983-1-sashal@kernel.org>
References: <20210909114635.143983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 557023ea9f06baf2659b232b08b8e8711f7001a6 ]

[BUG]
When subpage compressed read write support is enabled, btrfs/038 always
fails with EIO.

A simplified script can easily trigger the problem:

  mkfs.btrfs -f -s 4k $dev
  mount $dev $mnt -o compress=lzo

  xfs_io -f -c "truncate 118811" $mnt/foo
  xfs_io -c "pwrite -S 0x0d -b 39987 92267 39987" $mnt/foo > /dev/null

  sync
  btrfs subvolume snapshot -r $mnt $mnt/mysnap1

  xfs_io -c "pwrite -S 0x3e -b 80000 200000 80000" $mnt/foo > /dev/null
  sync

  xfs_io -c "pwrite -S 0xdc -b 10000 250000 10000" $mnt/foo > /dev/null
  xfs_io -c "pwrite -S 0xff -b 10000 300000 10000" $mnt/foo > /dev/null

  sync
  btrfs subvolume snapshot -r $mnt $mnt/mysnap2

  cat $mnt/mysnap2/foo
  # Above cat will fail due to EIO

[CAUSE]
The problem is in btrfs_submit_compressed_read().

When it tries to grab the extent map of the read range, it uses the
following call:

	em = lookup_extent_mapping(em_tree,
  				   page_offset(bio_first_page_all(bio)),
				   fs_info->sectorsize);

The problem is in the page_offset(bio_first_page_all(bio)) part.

The offending inode has the following file extent layout

        item 10 key (257 EXTENT_DATA 131072) itemoff 15639 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13680640 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 11 key (257 EXTENT_DATA 135168) itemoff 15586 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 0 nr 0
        item 12 key (257 EXTENT_DATA 196608) itemoff 15533 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13676544 nr 4096
                extent data offset 0 nr 53248 ram 86016
                extent compression 2 (lzo)

And the bio passed in has the following parameters:

page_offset(bio_first_page_all(bio))	= 131072
bio_first_bvec_all(bio)->bv_offset	= 65536

If we use page_offset(bio_first_page_all(bio) without adding bv_offset,
we will get an extent map for file offset 131072, not 196608.

This means we read uncompressed data from disk, and later decompression
will definitely fail.

[FIX]
Take bv_offset into consideration when trying to grab an extent map.

And add an ASSERT() to ensure we're really getting a compressed extent.

Thankfully this won't affect anything but subpage, thus we only need to
ensure this patch get merged before we enabled basic subpage support.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/compression.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f69b8d332574..f25ea4764ea1 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -683,6 +683,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct page *page;
 	struct bio *comp_bio;
 	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
+	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -692,15 +693,17 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
 
+	file_offset = bio_first_bvec_all(bio)->bv_offset +
+		      page_offset(bio_first_page_all(bio));
+
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree,
-				   page_offset(bio_first_page_all(bio)),
-				   fs_info->sectorsize);
+	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em)
 		return BLK_STS_IOERR;
 
+	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
-- 
2.30.2

