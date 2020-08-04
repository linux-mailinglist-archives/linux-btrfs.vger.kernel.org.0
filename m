Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F523B59A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgHDH0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 03:26:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgHDH0B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 03:26:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35B86ACA9;
        Tue,  4 Aug 2020 07:26:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: inode: don't re-evaluate inode_need_compress() in compress_file_extent()
Date:   Tue,  4 Aug 2020 15:25:48 +0800
Message-Id: <20200804072548.34001-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804072548.34001-1-wqu@suse.com>
References: <20200804072548.34001-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extra inode_need_compress() has already caused problems for pages
releasing.
We had hot fix to solve that problem, now it's time to fix it from the
root.

This patch will remove the extra inode_need_compress() to address the
problem.

This would lead to the following behavior change:
- Worse bad compression ratio detection
  Now if we had one async_chunk hitting bad compression ratio, other
  async_chunk will still try to compress.

  Only newer delalloc range will follow the new INODE_NO_COMPRESS flag
  then.
  Although one could argue that, if only part of the file content has
  bad compression, we should still try on other ranges.

Despite the behavior change, the code cleanup isn't that elegant either,
as kcalloc() can still fail for @pages, thus from cont: tag, we still
need to check @pages manually, thus the cleanup doesn't bring much
benefit, just one indent removal and comments reformatting.

Suggested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 106 +++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 96064eb41d55..37d9cff0b1b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -549,67 +549,65 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	ret = 0;
 
 	/*
-	 * we do compression for mount -o compress and when the
-	 * inode has not been flagged as nocompress.  This flag can
-	 * change at any time if we discover bad compression ratios.
+	 * We're in compress_file_range() because run_delalloc_range() has
+	 * already evaluated inode_need_compress().
+	 * So don't re-check it again to avoid race between ioctl.
+	 * This behavior would make bad compression ratio detection less
+	 * effective, as we will only skip compression until next
+	 * run_delalloc_range().
 	 */
-	if (inode_need_compress(BTRFS_I(inode), start, end)) {
-		WARN_ON(pages);
-		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-		if (!pages) {
-			/* just bail out to the uncompressed code */
-			nr_pages = 0;
-			goto cont;
-		}
+	WARN_ON(pages);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages) {
+		/* just bail out to the uncompressed code */
+		nr_pages = 0;
+		goto cont;
+	}
 
-		if (BTRFS_I(inode)->defrag_compress)
-			compress_type = BTRFS_I(inode)->defrag_compress;
-		else if (BTRFS_I(inode)->prop_compress)
-			compress_type = BTRFS_I(inode)->prop_compress;
+	if (BTRFS_I(inode)->defrag_compress)
+		compress_type = BTRFS_I(inode)->defrag_compress;
+	else if (BTRFS_I(inode)->prop_compress)
+		compress_type = BTRFS_I(inode)->prop_compress;
 
-		/*
-		 * we need to call clear_page_dirty_for_io on each
-		 * page in the range.  Otherwise applications with the file
-		 * mmap'd can wander in and change the page contents while
-		 * we are compressing them.
-		 *
-		 * If the compression fails for any reason, we set the pages
-		 * dirty again later on.
-		 *
-		 * Note that the remaining part is redirtied, the start pointer
-		 * has moved, the end is the original one.
-		 */
-		if (!redirty) {
-			extent_range_clear_dirty_for_io(inode, start, end);
-			redirty = 1;
-		}
+	/*
+	 * We need to call clear_page_dirty_for_io on each page in the range.
+	 * Otherwise applications with the file mmap'd can wander in and
+	 * change the page contents while we are compressing them.
+	 *
+	 * If the compression fails for any reason, we set the pages dirty
+	 * again later on.
+	 *
+	 * Note that the remaining part is redirtied, the start pointer has
+	 * moved, the end is the original one.
+	 */
+	if (!redirty) {
+		extent_range_clear_dirty_for_io(inode, start, end);
+		redirty = 1;
+	}
 
-		/* Compression level is applied here and only here */
-		ret = btrfs_compress_pages(
-			compress_type | (fs_info->compress_level << 4),
-					   inode->i_mapping, start,
-					   pages,
-					   &nr_pages,
-					   &total_in,
-					   &total_compressed);
+	/* Compression level is applied here and only here */
+	ret = btrfs_compress_pages(
+		compress_type | (fs_info->compress_level << 4),
+				   inode->i_mapping, start, pages, &nr_pages,
+				   &total_in, &total_compressed);
 
-		if (!ret) {
-			unsigned long offset = offset_in_page(total_compressed);
-			struct page *page = pages[nr_pages - 1];
-			char *kaddr;
+	if (!ret) {
+		unsigned long offset = offset_in_page(total_compressed);
+		struct page *page = pages[nr_pages - 1];
+		char *kaddr;
 
-			/* zero the tail end of the last page, we might be
-			 * sending it down to disk
-			 */
-			if (offset) {
-				kaddr = kmap_atomic(page);
-				memset(kaddr + offset, 0,
-				       PAGE_SIZE - offset);
-				kunmap_atomic(kaddr);
-			}
-			will_compress = 1;
+		/* zero the tail end of the last page, we might be
+		 * sending it down to disk
+		 */
+		if (offset) {
+			kaddr = kmap_atomic(page);
+			memset(kaddr + offset, 0,
+			       PAGE_SIZE - offset);
+			kunmap_atomic(kaddr);
 		}
+		will_compress = 1;
 	}
+
 cont:
 	if (start == 0) {
 		/* lets try to make an inline extent */
@@ -656,7 +654,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/*
 			 * Ensure we only free the compressed pages if we have
 			 * them allocated, as we can still reach here with
-			 * inode_need_compress() == false.
+			 * previous kcalloc() failure.
 			 */
 			if (pages) {
 				for (i = 0; i < nr_pages; i++) {
-- 
2.28.0

