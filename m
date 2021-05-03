Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18937107A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 04:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhECCJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 22:09:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhECCJ5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 May 2021 22:09:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620007744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wL/HWuziAMcj5s7gFIOphsGiAkFtYVLOC3blHTczmxg=;
        b=ZyXmoGcPdHkzh+upkq2ZdbbO+CFoC8Ni2UfX3XykDYUe2h9igeFymW4eoYVE7RXq3z+mIh
        Z/0PctiLg7VF8/WCeoAGQZbu27UM6Rg4UF1tXuJOrc8OjFM29KBxs6c5su/vV5lkpzpyYT
        JuYEEw7eSZdJSLK4OaPTEVvPGf9XeT0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 607FCB198
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 02:09:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/4] btrfs: make btrfs_verify_data_csum() to return a bitmap
Date:   Mon,  3 May 2021 10:08:54 +0800
Message-Id: <20210503020856.93333-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503020856.93333-1-wqu@suse.com>
References: <20210503020856.93333-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will provide the basis for later per-sector repair for subpage,
while still keep the existing code happy.

As if all csum matches, the return value is still 0.
Only when csum mismatches, the return value is different.

The new return value will be a bitmap, for 4K sectorsize and 4K page
size, it will be either 1, instead of the old -EIO.

But for 4K sectorsize and 64K page size, aka subpage case, since the
bvec can contain multiple sectors, knowing which sectors are corrupted
will allow us to submit repair only for corrupted sectors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  4 ++--
 fs/btrfs/inode.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 80670a631714..7bb4212b90d3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3100,8 +3100,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end);
+unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
+				    struct page *page, u64 start, u64 end);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 294d8d98280d..e9db33afcb5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3135,15 +3135,19 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @start:	file offset of the range start
  * @end:	file offset of the range end (inclusive)
+ *
+ * Return a bitmap where bit set means a csum mismatch, and bit not set means
+ * csum match.
  */
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end)
+unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
+				    struct page *page, u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	const u32 sectorsize = root->fs_info->sectorsize;
 	u32 pg_off;
+	unsigned int result = 0;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -3171,10 +3175,13 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 
 		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
 				      page_offset(page) + pg_off);
-		if (ret < 0)
-			return -EIO;
+		if (ret < 0) {
+			int nr_bit = (pg_off - offset_in_page(start)) /
+				     sectorsize;
+			result |= (1 << nr_bit);
+		}
 	}
-	return 0;
+	return result;
 }
 
 /*
-- 
2.31.1

