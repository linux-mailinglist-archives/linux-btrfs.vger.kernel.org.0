Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2717E3C57B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353036AbhGLIg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 04:36:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49268 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353981AbhGLId2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 04:33:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B3151FF5C;
        Mon, 12 Jul 2021 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626078638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/UfTuo7OALdy/3G2F1KaK+MUh+gVUjcd35B7aUYLMY=;
        b=VGNVpCHMnitRlOPvkA4P17zH5siuH70Sf3N4ToeligWaYKYMJUkGTlSvSFDNY+y8vVv4sC
        yGuW225yw1d7kRZu0iHJklP3HvygRFFLEKm5IiXZseYotFDTbeeXQQdtaRW13NU7abus8Y
        XRZwhehEni7xQy3GcB4bLnvKD2X1acw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B65D213455;
        Mon, 12 Jul 2021 08:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eL0+Haz962ByEAAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 12 Jul 2021 08:30:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 04/17] btrfs: grab correct extent map for subpage compressed extent read
Date:   Mon, 12 Jul 2021 16:30:14 +0800
Message-Id: <20210712083027.212734-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712083027.212734-1-wqu@suse.com>
References: <20210712083027.212734-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When subpage compressed read write support is enabled, btrfs/038 always
fail with EIO.

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

Thankfully this won't affect anything but subpage, thus we wonly need to
ensure this patch get merged before we enabled basic subpage support.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f17be6398d2c..22945189287b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -682,6 +682,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct page *page;
 	struct bio *comp_bio;
 	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
+	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -691,15 +692,17 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
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
2.32.0

