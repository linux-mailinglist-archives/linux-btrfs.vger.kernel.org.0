Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8B36CF15
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhD0XEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBhrRhfgx0/Q/nu0FKLCmBOyxUYQj+KJdPJ0K3p8ZlY=;
        b=mKC5NRnJ+vzhqBDkzpADO4aRUSjvHC1TQStlRZSuMRZSy4OIlz8qF+OSXHb3fPZd5Ko7pS
        1oj+N7rwBtwgoAFLsxSydSDPgljHGeH+6JeI5V5FBYFyqCJsIcKo6p/EBDL3Haq0qm5fn/
        tCNKm46/ubVXYkzR2OJdRka53aSvp/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A137ABED;
        Tue, 27 Apr 2021 23:04:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 04/42] btrfs: allow btrfs_bio_fits_in_stripe() to accept bio without any page
Date:   Wed, 28 Apr 2021 07:03:11 +0800
Message-Id: <20210427230349.369603-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_bio_fits_in_stripe() now requires a bio with at least one
page added.
Or btrfs_get_chunk_map() will fail with -ENOENT.

But in fact this requirement is not needed at all, as we can just pass
sectorsize for btrfs_get_chunk_map().

This tiny behavior change is important for later subpage refactor on
submit_extent_page().

As for 64K page size, we can have a page range with pgoff=0 and
size=64K.
If the logical bytenr is just 16K before the stripe boundary, we have to
split the page range into two bios.

This means, we must check page range against stripe boundary, even adding
the range to an empty bio.

This tiny refactor is for the incoming change, but on its own, regular
sectorsize == PAGE_SIZE is not affected anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4c1a06736371..74ee34fc820d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2198,25 +2198,22 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 logical = bio->bi_iter.bi_sector << 9;
+	u32 bio_len = bio->bi_iter.bi_size;
 	struct extent_map *em;
-	u64 length = 0;
-	u64 map_length;
 	int ret = 0;
 	struct btrfs_io_geometry geom;
 
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
 		return 0;
 
-	length = bio->bi_iter.bi_size;
-	map_length = length;
-	em = btrfs_get_chunk_map(fs_info, logical, map_length);
+	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical, &geom);
 	if (ret < 0)
 		goto out;
 
-	if (geom.len < length + size)
+	if (geom.len < bio_len + size)
 		ret = 1;
 out:
 	free_extent_map(em);
-- 
2.31.1

