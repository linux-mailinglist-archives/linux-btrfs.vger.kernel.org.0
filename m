Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B499387CA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbhERPmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 11:42:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbhERPmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 11:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621352456; x=1652888456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osnJmKP5sKenaayUwfORo7tKZeICjT50jUXSBX6mA9o=;
  b=emkDiDJnsAYFi4jNlx6rUtSFbDlgvtR02C1+S4P8kRBqNRpdEqnUWqBy
   bIpStumCQ5dxqLWZpg5Hpgy4WqG09efdjwX+YLRmoZGdT7C3d1GeMiF5+
   u9ekC3Q1SozoiBhVuFmUCc418wrjT95uMy0TnRck0Lq9FIMkzS4UTesoR
   swFjpPickpNpUg6MjQvSARubTDUn4Bwo0OJQSiJXHTTSIuf6MOyLwqc8n
   t/Ok+f5ggsqo1/t6LXl0XTCguquqg+WllCuF4+2iU3QOyKfumoHoN9G0E
   XOla71qIOim1rNmm34ETcIGFB8gCKl30wDNepweDWYM/6Q8YaQTyF8djv
   Q==;
IronPort-SDR: iDP8oq4r48gcEZr/h8sZvr8zcToLZy7W3anrnrAI7NRi22qXpz9F++DYw3OhqykjDti4h9iL41
 Xqp0Lt/PzzkOYqdoOrOSKca8IVSiUvKjUp2JMFXN32WS4W+APFh67ZoJP0cZ0wTYRt2hGgKSM9
 LvvZ6idFhWumwUzqfHruWTRTIU3K9kV0fWdGfrokE5bCyCDDVsXNkPWtTtsX888SK0VrFZMM+H
 gH0tkr5319UtObrl5fCUEH2364j45Phsf4RNghsE3DgfEyCV5KglJ3Fg+CKgys/7QXLPgs1/tS
 fHc=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; 
   d="scan'208";a="279802254"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 23:40:56 +0800
IronPort-SDR: jaRc2Zvuy+KqqIRZ0uX4hxTGPFjBW+IMqUJaj8aJqH9ZlSjb4IQ+isW2CqyKpxkKwwRjA5mQHf
 W+J1nsR1D5f+JndTBIOvZAvbdyekNAwiXVmcfCZa7bJqfwPVxmre9mlU/IMmR98bt1dHls4M3J
 6YH6oDLRjZNl04sjJqeVsC3KPkxUROZbQ51ZKrEB6eW3dWXOJkSF+/rsx4Xnb6EzXp+YzlKq3a
 Lc+6mm3Gl7CmYve/2NA2NqhRNbneeAhFoDgAJjPUi3npKiBjCht4yl66gOgXGY1n1RujtmIh1X
 8gVn3RYYxVxA+zshvfyl6nEO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:20:35 -0700
IronPort-SDR: yIJxCe7BO8FuD3BnkCs0wTA+tSgW9Lj4VXUq/ifhfxkmbodSgzm+SZNWlhmZ0VXO50uB2VrYun
 G83ReweSVKNfsg6r1RmqBN6hVSJSXcVbgt8DXuXi5XWWG461gYO2AcrpVzIVOc2+pc2iCX7q3w
 JaF9FWMWm0GjqknwO3jUZRwH6ngYLwXSnDeQ+6A0MVcPhtCe7HOUrepkZ4OPpLv6oxPN5rUe0F
 D1tWNHHVlOyDiELAf+HOad88c5yyhTeXv33WQFkktybK7le4bhbb7g7FOHKae2yKmK/MIv7PdS
 zIs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 08:40:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Date:   Wed, 19 May 2021 00:40:28 +0900
Message-Id: <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621351444.git.johannes.thumshirn@wdc.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When multiple processes write data to the same block group on a compressed
zoned filesystem, the underlying device could report I/O errors and data
corruption is possible.

This happens because on a zoned file system, compressed data writes where
sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
operation. But with REQ_OP_WRITE and parallel submission it cannot be
guaranteed that the data is always submitted aligned to the underlying
zone's write pointer.

The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zoned
filesystem is non intrusive on a regular file system or when submitting to
a conventional zone on a zoned filesystem, as it is guarded by
btrfs_use_zone_append.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 43 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2bea01d23a5b..f224c35de5d8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -28,6 +28,7 @@
 #include "compression.h"
 #include "extent_io.h"
 #include "extent_map.h"
+#include "zoned.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -349,6 +350,7 @@ static void end_compressed_bio_write(struct bio *bio)
 	 */
 	inode = cb->inode;
 	cb->compressed_pages[0]->mapping = cb->inode->i_mapping;
+	btrfs_record_physical_zoned(inode, cb->start, bio);
 	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],
 			cb->start, cb->start + cb->len - 1,
 			bio->bi_status == BLK_STS_OK);
@@ -401,6 +403,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	u64 first_byte = disk_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
+	const bool use_append = btrfs_use_zone_append(inode, disk_start);
+	const unsigned int bio_op =
+		use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
 	WARN_ON(!PAGE_ALIGNED(start));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
@@ -418,10 +423,31 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->nr_pages = nr_pages;
 
 	bio = btrfs_bio_alloc(first_byte);
-	bio->bi_opf = REQ_OP_WRITE | write_flags;
+	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
 
+	if (use_append) {
+		struct extent_map *em;
+		struct map_lookup *map;
+		struct block_device *bdev;
+
+		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
+		if (IS_ERR(em)) {
+			kfree(cb);
+			bio_put(bio);
+			return BLK_STS_NOTSUPP;
+		}
+
+		map = em->map_lookup;
+		/* We only support single profile for now */
+		ASSERT(map->num_stripes == 1);
+		bdev = map->stripes[0].dev->bdev;
+
+		bio_set_dev(bio, bdev);
+		free_extent_map(em);
+	}
+
 	if (blkcg_css) {
 		bio->bi_opf |= REQ_CGROUP_PUNT;
 		kthread_associate_blkcg(blkcg_css);
@@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	bytes_left = compressed_len;
 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
 		int submit = 0;
+		int len;
 
 		page = compressed_pages[pg_index];
 		page->mapping = inode->vfs_inode.i_mapping;
@@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
 							  0);
 
+		if (pg_index == 0 && use_append)
+			len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
+		else
+			len = bio_add_page(bio, page, PAGE_SIZE, 0);
+
 		page->mapping = NULL;
-		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
-		    PAGE_SIZE) {
+		if (submit || len < PAGE_SIZE) {
 			/*
 			 * inc the count before we submit the bio so
 			 * we know the end IO handler won't happen before
@@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			}
 
 			bio = btrfs_bio_alloc(first_byte);
-			bio->bi_opf = REQ_OP_WRITE | write_flags;
+			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
+			/*
+			 * Use bio_add_page() to ensure the bio has at least one
+			 * page.
+			 */
 			bio_add_page(bio, page, PAGE_SIZE, 0);
 		}
 		if (bytes_left < PAGE_SIZE) {
-- 
2.31.1

