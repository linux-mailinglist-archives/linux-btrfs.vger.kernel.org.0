Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373CD21251F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgGBNrC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbgGBNqz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80FDEB16C;
        Thu,  2 Jul 2020 13:46:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/10] btrfs: Remove fail2 label from btrfs_submit_compressed_read
Date:   Thu,  2 Jul 2020 16:46:49 +0300
Message-Id: <20200702134650.16550-10-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2033ce17e5c6..c28ee9fcd15d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -661,8 +661,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
-	blk_status_t ret = BLK_STS_RESOURCE;
-	int faili = 0;
+	blk_status_t ret;
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	u8 *sums;
 
@@ -712,12 +711,16 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
 							      __GFP_HIGHMEM);
 		if (!cb->compressed_pages[pg_index]) {
-			faili = pg_index - 1;
-			ret = BLK_STS_RESOURCE;
-			goto fail2;
+			int i;
+
+			for (i = 0; i < pg_index; i++)
+				__free_page(cb->compressed_pages[i]);
+
+			kfree(cb->compressed_pages);
+			kfree(cb);
+			return BLK_STS_RESOURCE;
 		}
 	}
-	faili = nr_pages - 1;
 	cb->nr_pages = nr_pages;
 
 	add_ra_bio_pages(inode, em_start + em_len, cb);
@@ -801,14 +804,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	return 0;
 
-fail2:
-	while (faili >= 0) {
-		__free_page(cb->compressed_pages[faili]);
-		faili--;
-	}
-
-	kfree(cb->compressed_pages);
-	kfree(cb);
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.17.1

