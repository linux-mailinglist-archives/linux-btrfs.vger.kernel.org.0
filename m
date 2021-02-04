Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325E230ECEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 08:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBDHEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 02:04:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhBDHET (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 02:04:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612422211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7iMl/fAhJbD+PIEVRHr/dR3JxNP2eRyC68Eahd4Wtw=;
        b=XbV88BtL96Z8XNCGNqcBSk/1/Hjps1JMPu6F01jfV74drq5gj3I+otWVHdFNjk15GPbIaj
        HJ59OszAam48io6OajmzEvxLc0GVP1kOW1xh7/fIvRHkrk5HfvgF0MgARriLqmJ2ZtTxHW
        /FbI+bBgc2M71kB0aAsRic0WTjP6nvw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3620ACF4
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 07:03:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: make check_compressed_csum() to be subpage compatible
Date:   Thu,  4 Feb 2021 15:03:24 +0800
Message-Id: <20210204070324.45703-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204070324.45703-1-wqu@suse.com>
References: <20210204070324.45703-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently check_compressed_csum() completely relies on sectorsize ==
PAGE_SIZE to do checksum verification for compressed extents.

To make it subpage compatible, this patch will:
- Do extra calculation for the csum range
  Since we have multiple sectors inside a page, we need to only hash
  the range we want, not the full page anymore.

- Do sector-by-sector hash inside the page

With this patch and previous conversion on
btrfs_submit_compressed_read(), now we can read subpage compressed
extents properly, and do proper csum verification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3d16ca5d420d..696459d9d244 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -141,6 +141,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	const u32 csum_size = fs_info->csum_size;
+	const u32 sectorsize = fs_info->sectorsize;
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
@@ -154,22 +155,36 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < cb->nr_pages; i++) {
+		u32 pg_offset;
+		u32 bytes_left;
 		page = cb->compressed_pages[i];
 
-		kaddr = kmap_atomic(page);
-		crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
-		kunmap_atomic(kaddr);
-
-		if (memcmp(&csum, cb_sum, csum_size)) {
-			btrfs_print_data_csum_error(inode, disk_start,
-					csum, cb_sum, cb->mirror_num);
-			if (btrfs_io_bio(bio)->device)
-				btrfs_dev_stat_inc_and_print(
-					btrfs_io_bio(bio)->device,
-					BTRFS_DEV_STAT_CORRUPTION_ERRS);
-			return -EIO;
+		/* Determine the remaining bytes inside the page first */
+		if (i == cb->nr_pages - 1)
+			bytes_left = cb->compressed_len - i * PAGE_SIZE;
+		else
+			bytes_left = PAGE_SIZE;
+
+		/* Hash through the page sector by sector */
+		for (pg_offset = 0; pg_offset < bytes_left;
+		     pg_offset += sectorsize) {
+			kaddr = kmap_atomic(page);
+			crypto_shash_digest(shash, kaddr + pg_offset,
+					    sectorsize, csum);
+			kunmap_atomic(kaddr);
+
+			if (memcmp(&csum, cb_sum, csum_size)) {
+				btrfs_print_data_csum_error(inode, disk_start,
+						csum, cb_sum, cb->mirror_num);
+				if (btrfs_io_bio(bio)->device)
+					btrfs_dev_stat_inc_and_print(
+						btrfs_io_bio(bio)->device,
+						BTRFS_DEV_STAT_CORRUPTION_ERRS);
+				return -EIO;
+			}
+			cb_sum += csum_size;
+			disk_start += sectorsize;
 		}
-		cb_sum += csum_size;
 	}
 	return 0;
 }
-- 
2.30.0

