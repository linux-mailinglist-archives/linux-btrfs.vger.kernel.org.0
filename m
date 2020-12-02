Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FFE2CB542
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgLBGtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgLBGtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z42Uca6UdEd30hZpG4Nu6fEt4kSlQLtaMW5jy5Zig+g=;
        b=mSPZqT0TAVKOSyWeXo23kY9/oS/i5o5oQ0ViCvDd3WDInYag0+Hv/Lf+RhBTepiIXEWDRK
        sr75snAhv+cqE0hVC+LW8dN9oQGTZ+V00oi1oNvuofGsvkRgV+5ljUfg+4LKo0cYdGdU0J
        GJEQHv5+RQnCVAReycUTHKOWdym0n/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78D8FAC2D;
        Wed,  2 Dec 2020 06:48:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3 03/15] btrfs: inode: make btrfs_verify_data_csum() follow sector size
Date:   Wed,  2 Dec 2020 14:47:59 +0800
Message-Id: <20201202064811.100688-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_verify_data_csum() just pass the whole page to
check_data_csum(), which is fine since we only support sectorsize ==
PAGE_SIZE.

To support subpage, we need to properly honor per-sector
checksum verification, just like what we did in dio read path.

This patch will do the csum verification in a for loop, starts with
pg_off == start - page_offset(page), with sectorsize increasement for
each loop.

For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
will only finish with just one loop.

For subpage case, we do the loop to iterate each sector and if we found
any error, we return error.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5c051b0e58a5..255ea28982ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2951,7 +2951,7 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   u32 bio_offset, struct page *page, int pgoff)
+			   u32 bio_offset, struct page *page, u32 pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -3002,10 +3002,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
-	size_t offset = start - page_offset(page);
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	const u32 sectorsize = root->fs_info->sectorsize;
+	u32 pg_off;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -3024,7 +3025,18 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 		return 0;
 	}
 
-	return check_data_csum(inode, io_bio, bio_offset, page, offset);
+	ASSERT(page_offset(page) <= start &&
+	       end <= page_offset(page) + PAGE_SIZE - 1);
+	for (pg_off = offset_in_page(start);
+	     pg_off < offset_in_page(end);
+	     pg_off += sectorsize, bio_offset += sectorsize) {
+		int ret;
+
+		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off);
+		if (ret < 0)
+			return -EIO;
+	}
+	return 0;
 }
 
 /*
-- 
2.29.2

