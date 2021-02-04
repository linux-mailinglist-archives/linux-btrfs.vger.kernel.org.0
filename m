Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5D30ECEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhBDHET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 02:04:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhBDHEQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 02:04:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612422210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/dtuhPu/0KOqIxM7ItHlc78j+75rEXaW4afJQC6I9s=;
        b=mV1ESbuUHTWBVa3goUS6UKXlOyIr6jjqDu0CcVpjeNqrEdc91NBrNUNa1fxYrQL0CO3THC
        qviwooiusf6Ir7Psah1d/ozrLYnNGVML9In6UE9wAylvo99/JWGN8BvUpJDnLqUo+RNfTz
        ohLpwz5Gi0aY228xx/Km1uMRPc/MKCI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7598ACB7
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 07:03:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make btrfs_submit_compressed_read() to be subpage compatible
Date:   Thu,  4 Feb 2021 15:03:23 +0800
Message-Id: <20210204070324.45703-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204070324.45703-1-wqu@suse.com>
References: <20210204070324.45703-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For compressed read, we always submit page read using page size.

This doesn't work well with subpage, as for subpage one page can contain
several sectors.
Such submission will read range out of what we want, and cause problems.

Thankfully to make it subpage compatible, we only need to change how the
last page of the compressed extent is read.

Instead of always adding a full page to the compressed read bio, if we're
at the last page, calculate the size using compressed length, so that we
only add part of the range into the compressed read bio.

Since we are here, also change the PAGE_SIZE used in
lookup_extent_mapping() to sectorsize.
This modification won't cause any functional change, as
lookup_extent_mapping() can handle the case where the search range is
larger than found extent range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6d203acfdeb3..3d16ca5d420d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -640,7 +640,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree,
 				   page_offset(bio_first_page_all(bio)),
-				   PAGE_SIZE);
+				   fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em)
 		return BLK_STS_IOERR;
@@ -698,19 +698,33 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	refcount_set(&cb->pending_bios, 1);
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
+		u32 pg_len;
 		int submit = 0;
 
+		/*
+		 * To handle subpage case, we need to make sure the bio only
+		 * covers the range we need.
+		 *
+		 * If we're at the last page, truncate the length to only cover
+		 * the remaining part.
+		 */
+		if (pg_index == nr_pages - 1)
+			pg_len = min_t(u32, PAGE_SIZE,
+					compressed_len - pg_index * PAGE_SIZE);
+		else
+			pg_len = PAGE_SIZE;
+
 		page = cb->compressed_pages[pg_index];
 		page->mapping = inode->i_mapping;
 		page->index = em_start >> PAGE_SHIFT;
 
 		if (comp_bio->bi_iter.bi_size)
-			submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE,
+			submit = btrfs_bio_fits_in_stripe(page, pg_len,
 							  comp_bio, 0);
 
 		page->mapping = NULL;
-		if (submit || bio_add_page(comp_bio, page, PAGE_SIZE, 0) <
-		    PAGE_SIZE) {
+		if (submit || bio_add_page(comp_bio, page, pg_len, 0) <
+		    pg_len) {
 			unsigned int nr_sectors;
 
 			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
@@ -743,9 +757,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			comp_bio->bi_private = cb;
 			comp_bio->bi_end_io = end_compressed_bio_read;
 
-			bio_add_page(comp_bio, page, PAGE_SIZE, 0);
+			bio_add_page(comp_bio, page, pg_len, 0);
 		}
-		cur_disk_byte += PAGE_SIZE;
+		cur_disk_byte += pg_len;
 	}
 
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
-- 
2.30.0

