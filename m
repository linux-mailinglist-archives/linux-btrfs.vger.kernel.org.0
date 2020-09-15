Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEA269DD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIOFfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFfm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:35:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E93EAC98
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:35:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/19] btrfs: remove the unnecessary parameter @start and @len for check_data_csum()
Date:   Tue, 15 Sep 2020 13:35:15 +0800
Message-Id: <20200915053532.63279-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For check_data_csum(), the page we're using is directly from inode
mapping, thus it has valid page_offset().

We can use (page_offset() + pg_off) to replace @start parameter
completely, while the @len should always be sectorsize.

Since we're here, also add some comment, since there are quite some
confusion in words like start/offset, without explaining whether it's
file_offset or logical bytenr.

This should not affect the existing behavior, as for current sectorsize
== PAGE_SIZE case, @pgoff should always be 0, and len is always
PAGE_SIZE (or sectorsize from the dio read path).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9570458aa847..bb4442950d2b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2793,17 +2793,30 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	btrfs_queue_work(wq, &ordered_extent->work);
 }
 
+/*
+ * Verify the checksum of one sector of uncompressed data.
+ *
+ * @inode:	The inode.
+ * @io_bio:	The btrfs_io_bio which contains the csum.
+ * @icsum:	The csum offset (by number of sectors).
+ * @page:	The page where the data to be verified is.
+ * @pgoff:	The offset inside the page.
+ *
+ * The length of such check is always one sector size.
+ */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   int icsum, struct page *page, int pgoff, u64 start,
-			   size_t len)
+			   int icsum, struct page *page, int pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
+	u32 len = fs_info->sectorsize;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
+	ASSERT(pgoff + len <= PAGE_SIZE);
+
 	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
 
 	kaddr = kmap_atomic(page);
@@ -2817,8 +2830,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
+				    csum, csum_expected, io_bio->mirror_num);
 	if (io_bio->device)
 		btrfs_dev_stat_inc_and_print(io_bio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -2857,8 +2870,7 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	}
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset, start,
-			       (size_t)(end - start + 1));
+	return check_data_csum(inode, io_bio, phy_offset, page, offset);
 }
 
 /*
@@ -7545,8 +7557,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, io_bio, icsum,
-						       bvec.bv_page, pgoff,
-						       start, sectorsize))) {
+						       bvec.bv_page, pgoff))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
-- 
2.28.0

