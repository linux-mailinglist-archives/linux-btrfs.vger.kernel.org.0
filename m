Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B339577C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEaIxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhEaIx0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYwd8yKPZq1mQY1tZcf68ClNgr2CaN+mR1mny4d3Gzc=;
        b=qqtDZ/BbUhfhuo6PkKaXPGEGBT3l2dAkbrfuhrIQVUQp8YaKfVT3ZqzZvBTlMFrNRc65cU
        wO+6vz6SNPKYjjCz8dEv1alruYz2FNTKLxPkGJSpaBJQUL0IB7lNTAy9L21XimK2Wq0vOx
        EZeO4rrdmh9BqieMnQGSiSCxrlOAq4g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59D80B49A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 20/30] btrfs: extract relocation page read and dirty part into its own function
Date:   Mon, 31 May 2021 16:50:56 +0800
Message-Id: <20210531085106.259490-21-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function relocate_file_extent_cluster(), we have a big loop for
marking all involved page delalloc.

That part is long enough to be contained in one function, so this patch
will move that code chunk into a new function, relocate_one_page().

This also provides enough space for later subpage work.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 199 ++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b70be2ac2e9e..862fe5247c76 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2885,19 +2885,102 @@ noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
-static int relocate_file_extent_cluster(struct inode *inode,
-					struct file_extent_cluster *cluster)
+static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
+			     struct file_extent_cluster *cluster,
+			     int *cluster_nr, unsigned long page_index)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 offset = BTRFS_I(inode)->index_cnt;
+	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
+	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
+	struct page *page;
 	u64 page_start;
 	u64 page_end;
+	int ret;
+
+	ASSERT(page_index <= last_index);
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), PAGE_SIZE);
+	if (ret)
+		return ret;
+
+	page = find_lock_page(inode->i_mapping, page_index);
+	if (!page) {
+		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
+				page_index, last_index + 1 - page_index);
+		page = find_or_create_page(inode->i_mapping, page_index, mask);
+		if (!page) {
+			ret = -ENOMEM;
+			goto release_delalloc;
+		}
+	}
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto release_page;
+
+	if (PageReadahead(page))
+		page_cache_async_readahead(inode->i_mapping, ra, NULL, page,
+				   page_index, last_index + 1 - page_index);
+
+	if (!PageUptodate(page)) {
+		btrfs_readpage(NULL, page);
+		lock_page(page);
+		if (!PageUptodate(page)) {
+			ret = -EIO;
+			goto release_page;
+		}
+	}
+
+	page_start = page_offset(page);
+	page_end = page_start + PAGE_SIZE - 1;
+
+	lock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
+
+	if (*cluster_nr < cluster->nr &&
+	    page_start + offset == cluster->boundary[*cluster_nr]) {
+		set_extent_bits(&BTRFS_I(inode)->io_tree, page_start, page_end,
+				EXTENT_BOUNDARY);
+		(*cluster_nr)++;
+	}
+
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, page_end,
+					0, NULL);
+	if (ret) {
+		clear_extent_bits(&BTRFS_I(inode)->io_tree, page_start,
+				  page_end, EXTENT_LOCKED | EXTENT_BOUNDARY);
+		goto release_page;
+
+	}
+	set_page_dirty(page);
+
+	unlock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
+	unlock_page(page);
+	put_page(page);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	balance_dirty_pages_ratelimited(inode->i_mapping);
+	btrfs_throttle(fs_info);
+	if (btrfs_should_cancel_balance(fs_info))
+		ret = -ECANCELED;
+	return ret;
+
+release_page:
+	unlock_page(page);
+	put_page(page);
+release_delalloc:
+	btrfs_delalloc_release_metadata(BTRFS_I(inode), PAGE_SIZE, true);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	return ret;
+}
+
+static int relocate_file_extent_cluster(struct inode *inode,
+					struct file_extent_cluster *cluster)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	unsigned long index;
 	unsigned long last_index;
-	struct page *page;
 	struct file_ra_state *ra;
-	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-	int nr = 0;
+	int cluster_nr = 0;
 	int ret = 0;
 
 	if (!cluster->nr)
@@ -2918,109 +3001,15 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	if (ret)
 		goto out;
 
-	index = (cluster->start - offset) >> PAGE_SHIFT;
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
-	while (index <= last_index) {
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				PAGE_SIZE);
-		if (ret)
-			goto out;
-
-		page = find_lock_page(inode->i_mapping, index);
-		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping,
-						  ra, NULL, index,
-						  last_index + 1 - index);
-			page = find_or_create_page(inode->i_mapping, index,
-						   mask);
-			if (!page) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							PAGE_SIZE, true);
-				btrfs_delalloc_release_extents(BTRFS_I(inode),
-							PAGE_SIZE);
-				ret = -ENOMEM;
-				goto out;
-			}
-		}
-		ret = set_page_extent_mapped(page);
-		if (ret < 0) {
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							PAGE_SIZE, true);
-			btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-			unlock_page(page);
-			put_page(page);
-			goto out;
-		}
-
-		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping,
-						   ra, NULL, page, index,
-						   last_index + 1 - index);
-		}
-
-		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
-				put_page(page);
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							PAGE_SIZE, true);
-				btrfs_delalloc_release_extents(BTRFS_I(inode),
-							       PAGE_SIZE);
-				ret = -EIO;
-				goto out;
-			}
-		}
-
-		page_start = page_offset(page);
-		page_end = page_start + PAGE_SIZE - 1;
-
-		lock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
-
-		if (nr < cluster->nr &&
-		    page_start + offset == cluster->boundary[nr]) {
-			set_extent_bits(&BTRFS_I(inode)->io_tree,
-					page_start, page_end,
-					EXTENT_BOUNDARY);
-			nr++;
-		}
-
-		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start,
-						page_end, 0, NULL);
-		if (ret) {
-			unlock_page(page);
-			put_page(page);
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							 PAGE_SIZE, true);
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-			                               PAGE_SIZE);
-
-			clear_extent_bits(&BTRFS_I(inode)->io_tree,
-					  page_start, page_end,
-					  EXTENT_LOCKED | EXTENT_BOUNDARY);
-			goto out;
-
-		}
-		set_page_dirty(page);
-
-		unlock_extent(&BTRFS_I(inode)->io_tree,
-			      page_start, page_end);
-		unlock_page(page);
-		put_page(page);
-
-		index++;
-		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-		balance_dirty_pages_ratelimited(inode->i_mapping);
-		btrfs_throttle(fs_info);
-		if (btrfs_should_cancel_balance(fs_info)) {
-			ret = -ECANCELED;
-			goto out;
-		}
-	}
-	WARN_ON(nr != cluster->nr);
+	for (index = (cluster->start - offset) >> PAGE_SHIFT;
+	     index <= last_index && !ret; index++)
+		ret = relocate_one_page(inode, ra, cluster, &cluster_nr,
+					index);
 	if (btrfs_is_zoned(fs_info) && !ret)
 		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+	if (ret == 0)
+		WARN_ON(cluster_nr != cluster->nr);
 out:
 	kfree(ra);
 	return ret;
-- 
2.31.1

