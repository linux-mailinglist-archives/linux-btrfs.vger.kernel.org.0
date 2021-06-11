Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00933A394D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhFKBdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 21:33:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 21:33:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF9D4219A2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623375093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1R3GLExusSk1SD0sPR/3xBIzFnlnMY5aw7lL71vLSo=;
        b=GbhjjiWLtfM23fgHgBG71zZbe0DpTfdj0MaEUiJzMwhj2jiXhRsKpHfVouCzzh1WTS8Y/a
        73yu0v4bV7AUFgCrkq4ztJVgvx1dxkrdE9W0HIZ1WJk5Ut/Q+MrpSsqZp+VUyPFt6gV+lm
        lykLHoOdB5ZpWhsZ9feMGl0ChNTAy0M=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id C8787A3B91
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: remove unused function btrfs_bio_fits_in_stripe()
Date:   Fri, 11 Jun 2021 09:31:14 +0800
Message-Id: <20210611013114.57264-10-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611013114.57264-1-wqu@suse.com>
References: <20210611013114.57264-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the last caller in compression.c is removed, we don't need that
function anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  2 --
 fs/btrfs/inode.c | 42 ------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 918df8877b45..4364733f4464 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3144,8 +3144,6 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 				 struct extent_state *other);
 void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
-int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
-			     unsigned long bio_flags);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27d56a77aa5f..abbee108b298 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2232,48 +2232,6 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	}
 }
 
-/*
- * btrfs_bio_fits_in_stripe - Checks whether the size of the given bio will fit
- * in a chunk's stripe. This function ensures that bios do not span a
- * stripe/chunk
- *
- * @page - The page we are about to add to the bio
- * @size - size we want to add to the bio
- * @bio - bio we want to ensure is smaller than a stripe
- * @bio_flags - flags of the bio
- *
- * return 1 if page cannot be added to the bio
- * return 0 if page can be added to the bio
- * return error otherwise
- */
-int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
-			     unsigned long bio_flags)
-{
-	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u32 bio_len = bio->bi_iter.bi_size;
-	struct extent_map *em;
-	int ret = 0;
-	struct btrfs_io_geometry geom;
-
-	if (bio_flags & EXTENT_BIO_COMPRESSED)
-		return 0;
-
-	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical, &geom);
-	if (ret < 0)
-		goto out;
-
-	if (geom.len < bio_len + size)
-		ret = 1;
-out:
-	free_extent_map(em);
-	return ret;
-}
-
 /*
  * in order to insert checksums into the metadata in large chunks,
  * we wait until bio submission time.   All the pages in the bio are
-- 
2.32.0

