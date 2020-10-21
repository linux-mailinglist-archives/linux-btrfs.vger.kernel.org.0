Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3629482B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440741AbgJUG0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440738AbgJUG0c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUTopscJhsVHaT3njNYY2hsgvNXAhR3XRRsgSZd+mJQ=;
        b=DeFBXxusXGAygsCEcoPFtNk+m2eq6I0m2Axdj2U45pUFC2WRAxPuMhKVQYK2kUfDHdPubp
        AOoK5kMox6LlEYDtnJn2nASGGJsumjswU0MANapbvwsTlyhKjtWVMvQqIJ1U6JeVeXE3AP
        vOfE45OQ/5yPOykDUU5uDKWFdAl441o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62281AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 15/68] btrfs: extent_io: rename page_size to io_size in submit_extent_page()
Date:   Wed, 21 Oct 2020 14:25:01 +0800
Message-Id: <20201021062554.68132-16-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable @page_size of submit_extent_page() is not bounded to page
size.

It can already be smaller than PAGE_SIZE, so rename it to io_size to
reduce confusion, this is especially important for later subpage
support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec0f1fb01a0f..5842d3522865 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3047,7 +3047,7 @@ static int submit_extent_page(unsigned int opf,
 {
 	int ret = 0;
 	struct bio *bio;
-	size_t page_size = min_t(size_t, size, PAGE_SIZE);
+	size_t io_size = min_t(size_t, size, PAGE_SIZE);
 	sector_t sector = offset >> 9;
 	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 
@@ -3064,12 +3064,12 @@ static int submit_extent_page(unsigned int opf,
 			contig = bio_end_sector(bio) == sector;
 
 		ASSERT(tree->ops);
-		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
+		if (btrfs_bio_fits_in_stripe(page, io_size, bio, bio_flags))
 			can_merge = false;
 
 		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
 		    force_bio_submit ||
-		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {
+		    bio_add_page(bio, page, io_size, pg_offset) < io_size) {
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
@@ -3078,13 +3078,13 @@ static int submit_extent_page(unsigned int opf,
 			bio = NULL;
 		} else {
 			if (wbc)
-				wbc_account_cgroup_owner(wbc, page, page_size);
+				wbc_account_cgroup_owner(wbc, page, io_size);
 			return 0;
 		}
 	}
 
 	bio = btrfs_bio_alloc(offset);
-	bio_add_page(bio, page, page_size, pg_offset);
+	bio_add_page(bio, page, io_size, pg_offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
 	bio->bi_write_hint = page->mapping->host->i_write_hint;
@@ -3095,7 +3095,7 @@ static int submit_extent_page(unsigned int opf,
 		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
-		wbc_account_cgroup_owner(wbc, page, page_size);
+		wbc_account_cgroup_owner(wbc, page, io_size);
 	}
 
 	*bio_ret = bio;
-- 
2.28.0

