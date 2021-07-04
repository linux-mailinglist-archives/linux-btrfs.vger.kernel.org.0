Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62C3BB160
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhGDXLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 19:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232466AbhGDXKb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 19:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 788CF613FC;
        Sun,  4 Jul 2021 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440070;
        bh=iPctzeSbVfDkPeY4rHVyaIU+h+KZulPpbBZMMhHQ4FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdOaqM/HgpzDNxMvpcnQGqTcFbaJ5IVnbV7UZRcbHrxqXmZfBGFXiQoBbe0VEHxje
         lhXOsrV26dl2lE77UcnTX9vIrRLNa8MTSh6EKmjI88sW0gnC1gkGmidIyofRFdJ/6v
         3FSiK6tCN6JQiyfzgY+RlQbjTgrno4hBuqRceqaw1yciVhlIipVeqdAsa62N8H0M5P
         EJOFodIRt0FQtUSWjVtOBECTSTa5HwjdFaidKjNMmjFAClZtcJlNXA2bWFtcMwOUvQ
         +pK5FNjh/rCyi7PWsy3o3L9wJJWxTNa8k/66WJLGGzwUgoD2zaB3hg2TNzl8VimBiy
         amW6NTeYTFu5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 70/80] btrfs: scrub: fix subpage repair error caused by hard coded PAGE_SIZE
Date:   Sun,  4 Jul 2021 19:06:06 -0400
Message-Id: <20210704230616.1489200-70-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230616.1489200-1-sashal@kernel.org>
References: <20210704230616.1489200-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 8df507cbb5952719353c912a021b66c27641e90c ]

[BUG]
For the following file layout, scrub will not be able to repair all
these two repairable error, but in fact make one corruption even
unrepairable:

	  inode offset 0      4k     8K
Mirror 1               |XXXXXX|      |
Mirror 2               |      |XXXXXX|

[CAUSE]
The root cause is the hard coded PAGE_SIZE, which makes scrub repair to
go crazy for subpage.

For above case, when reading the first sector, we use PAGE_SIZE other
than sectorsize to read, which makes us to read the full range [0, 64K).
In fact, after 8K there may be no data at all, we can just get some
garbage.

Then when doing the repair, we also writeback a full page from mirror 2,
this means, we will also writeback the corrupted data in mirror 2 back
to mirror 1, leaving the range [4K, 8K) unrepairable.

[FIX]
This patch will modify the following PAGE_SIZE use with sectorsize:

- scrub_print_warning_inode()
  Remove the min() and replace PAGE_SIZE with sectorsize.
  The min() makes no sense, as csum is done for the full sector with
  padding.

  This fixes a bug that subpage report extra length like:
   checksum error at logical 298844160 on dev /dev/mapper/arm_nvme-test,
   physical 575668224, root 5, inode 257, offset 0, length 12288, links 1 (path: file)

  Where the error is only 1 sector.

- scrub_handle_errored_block()
  Comments with PAGE|page involved, all changed to sector.

- scrub_setup_recheck_block()
- scrub_repair_page_from_good_copy()
- scrub_add_page_to_wr_bio()
- scrub_wr_submit()
- scrub_add_page_to_rd_bio()
- scrub_block_complete()
  Replace PAGE_SIZE with sectorsize.
  This solves several problems where we read/write extra range for
  subpage case.

RAID56 code is excluded intentionally, as RAID56 has extra PAGE_SIZE
usage, and is not really safe enough.
Thus we will reject RAID56 for subpage in later commit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 82 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b9202a1f1af1..37a9e1c2e2f5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -634,7 +634,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				     void *warn_ctx)
 {
-	u64 isize;
 	u32 nlink;
 	int ret;
 	int i;
@@ -670,7 +669,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	eb = swarn->path->nodes[0];
 	inode_item = btrfs_item_ptr(eb, swarn->path->slots[0],
 					struct btrfs_inode_item);
-	isize = btrfs_inode_size(eb, inode_item);
 	nlink = btrfs_inode_nlink(eb, inode_item);
 	btrfs_release_path(swarn->path);
 
@@ -699,12 +697,12 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
 		btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %llu, links %u (path: %s)",
+"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
 				  swarn->errstr, swarn->logical,
 				  rcu_str_deref(swarn->dev->name),
 				  swarn->physical,
 				  root, inum, offset,
-				  min(isize - offset, (u64)PAGE_SIZE), nlink,
+				  fs_info->sectorsize, nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
 	btrfs_put_root(local_root);
@@ -893,25 +891,25 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * read all mirrors one after the other. This includes to
 	 * re-read the extent or metadata block that failed (that was
 	 * the cause that this fixup code is called) another time,
-	 * page by page this time in order to know which pages
+	 * sector by sector this time in order to know which sectors
 	 * caused I/O errors and which ones are good (for all mirrors).
 	 * It is the goal to handle the situation when more than one
 	 * mirror contains I/O errors, but the errors do not
 	 * overlap, i.e. the data can be repaired by selecting the
-	 * pages from those mirrors without I/O error on the
-	 * particular pages. One example (with blocks >= 2 * PAGE_SIZE)
-	 * would be that mirror #1 has an I/O error on the first page,
-	 * the second page is good, and mirror #2 has an I/O error on
-	 * the second page, but the first page is good.
-	 * Then the first page of the first mirror can be repaired by
-	 * taking the first page of the second mirror, and the
-	 * second page of the second mirror can be repaired by
-	 * copying the contents of the 2nd page of the 1st mirror.
-	 * One more note: if the pages of one mirror contain I/O
+	 * sectors from those mirrors without I/O error on the
+	 * particular sectors. One example (with blocks >= 2 * sectorsize)
+	 * would be that mirror #1 has an I/O error on the first sector,
+	 * the second sector is good, and mirror #2 has an I/O error on
+	 * the second sector, but the first sector is good.
+	 * Then the first sector of the first mirror can be repaired by
+	 * taking the first sector of the second mirror, and the
+	 * second sector of the second mirror can be repaired by
+	 * copying the contents of the 2nd sector of the 1st mirror.
+	 * One more note: if the sectors of one mirror contain I/O
 	 * errors, the checksum cannot be verified. In order to get
 	 * the best data for repairing, the first attempt is to find
 	 * a mirror without I/O errors and with a validated checksum.
-	 * Only if this is not possible, the pages are picked from
+	 * Only if this is not possible, the sectors are picked from
 	 * mirrors with I/O errors without considering the checksum.
 	 * If the latter is the case, at the end, the checksum of the
 	 * repaired area is verified in order to correctly maintain
@@ -1068,26 +1066,26 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 
 	/*
 	 * In case of I/O errors in the area that is supposed to be
-	 * repaired, continue by picking good copies of those pages.
-	 * Select the good pages from mirrors to rewrite bad pages from
+	 * repaired, continue by picking good copies of those sectors.
+	 * Select the good sectors from mirrors to rewrite bad sectors from
 	 * the area to fix. Afterwards verify the checksum of the block
 	 * that is supposed to be repaired. This verification step is
 	 * only done for the purpose of statistic counting and for the
 	 * final scrub report, whether errors remain.
 	 * A perfect algorithm could make use of the checksum and try
-	 * all possible combinations of pages from the different mirrors
+	 * all possible combinations of sectors from the different mirrors
 	 * until the checksum verification succeeds. For example, when
-	 * the 2nd page of mirror #1 faces I/O errors, and the 2nd page
+	 * the 2nd sector of mirror #1 faces I/O errors, and the 2nd sector
 	 * of mirror #2 is readable but the final checksum test fails,
-	 * then the 2nd page of mirror #3 could be tried, whether now
+	 * then the 2nd sector of mirror #3 could be tried, whether now
 	 * the final checksum succeeds. But this would be a rare
 	 * exception and is therefore not implemented. At least it is
 	 * avoided that the good copy is overwritten.
 	 * A more useful improvement would be to pick the sectors
 	 * without I/O error based on sector sizes (512 bytes on legacy
-	 * disks) instead of on PAGE_SIZE. Then maybe 512 byte of one
+	 * disks) instead of on sectorsize. Then maybe 512 byte of one
 	 * mirror could be repaired by taking 512 byte of a different
-	 * mirror, even if other 512 byte sectors in the same PAGE_SIZE
+	 * mirror, even if other 512 byte sectors in the same sectorsize
 	 * area are unreadable.
 	 */
 	success = 1;
@@ -1268,7 +1266,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 {
 	struct scrub_ctx *sctx = original_sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 length = original_sblock->page_count * PAGE_SIZE;
+	u64 length = original_sblock->page_count * fs_info->sectorsize;
 	u64 logical = original_sblock->pagev[0]->logical;
 	u64 generation = original_sblock->pagev[0]->generation;
 	u64 flags = original_sblock->pagev[0]->flags;
@@ -1291,13 +1289,13 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 	 */
 
 	while (length > 0) {
-		sublen = min_t(u64, length, PAGE_SIZE);
+		sublen = min_t(u64, length, fs_info->sectorsize);
 		mapped_length = sublen;
 		bbio = NULL;
 
 		/*
-		 * with a length of PAGE_SIZE, each returned stripe
-		 * represents one mirror
+		 * With a length of sectorsize, each returned stripe represents
+		 * one mirror
 		 */
 		btrfs_bio_counter_inc_blocked(fs_info);
 		ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
@@ -1488,7 +1486,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		bio = btrfs_io_bio_alloc(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
-		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
+		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
 		bio->bi_iter.bi_sector = spage->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
@@ -1552,6 +1550,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 	struct scrub_page *spage_bad = sblock_bad->pagev[page_num];
 	struct scrub_page *spage_good = sblock_good->pagev[page_num];
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	BUG_ON(spage_bad->page == NULL);
 	BUG_ON(spage_good->page == NULL);
@@ -1571,8 +1570,8 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 
-		ret = bio_add_page(bio, spage_good->page, PAGE_SIZE, 0);
-		if (PAGE_SIZE != ret) {
+		ret = bio_add_page(bio, spage_good->page, sectorsize, 0);
+		if (ret != sectorsize) {
 			bio_put(bio);
 			return -EIO;
 		}
@@ -1650,6 +1649,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 {
 	struct scrub_bio *sbio;
 	int ret;
+	const u32 sectorsize = sctx->fs_info->sectorsize;
 
 	mutex_lock(&sctx->wr_lock);
 again:
@@ -1689,16 +1689,16 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 		sbio->status = 0;
-	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
+	} else if (sbio->physical + sbio->page_count * sectorsize !=
 		   spage->physical_for_dev_replace ||
-		   sbio->logical + sbio->page_count * PAGE_SIZE !=
+		   sbio->logical + sbio->page_count * sectorsize !=
 		   spage->logical) {
 		scrub_wr_submit(sctx);
 		goto again;
 	}
 
-	ret = bio_add_page(sbio->bio, spage->page, PAGE_SIZE, 0);
-	if (ret != PAGE_SIZE) {
+	ret = bio_add_page(sbio->bio, spage->page, sectorsize, 0);
+	if (ret != sectorsize) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
@@ -1737,7 +1737,8 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	btrfsic_submit_bio(sbio->bio);
 
 	if (btrfs_is_zoned(sctx->fs_info))
-		sctx->write_pointer = sbio->physical + sbio->page_count * PAGE_SIZE;
+		sctx->write_pointer = sbio->physical + sbio->page_count *
+			sctx->fs_info->sectorsize;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -2014,6 +2015,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 {
 	struct scrub_block *sblock = spage->sblock;
 	struct scrub_bio *sbio;
+	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int ret;
 
 again:
@@ -2052,9 +2054,9 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 		sbio->status = 0;
-	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
+	} else if (sbio->physical + sbio->page_count * sectorsize !=
 		   spage->physical ||
-		   sbio->logical + sbio->page_count * PAGE_SIZE !=
+		   sbio->logical + sbio->page_count * sectorsize !=
 		   spage->logical ||
 		   sbio->dev != spage->dev) {
 		scrub_submit(sctx);
@@ -2062,8 +2064,8 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	}
 
 	sbio->pagev[sbio->page_count] = spage;
-	ret = bio_add_page(sbio->bio, spage->page, PAGE_SIZE, 0);
-	if (ret != PAGE_SIZE) {
+	ret = bio_add_page(sbio->bio, spage->page, sectorsize, 0);
+	if (ret != sectorsize) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
@@ -2406,7 +2408,7 @@ static void scrub_block_complete(struct scrub_block *sblock)
 	if (sblock->sparity && corrupted && !sblock->data_corrected) {
 		u64 start = sblock->pagev[0]->logical;
 		u64 end = sblock->pagev[sblock->page_count - 1]->logical +
-			  PAGE_SIZE;
+			  sblock->sctx->fs_info->sectorsize;
 
 		ASSERT(end - start <= U32_MAX);
 		scrub_parity_mark_sectors_error(sblock->sparity,
-- 
2.30.2

