Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA6CFB97
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjC3Gbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3Gbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A261A4
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GTXPl7ZnHJt9YGS+zBSwtJqc2OTNzbrNHVzIoAO8mfY=; b=GL4RV2BjWa0h5Q9YvqiX8hHYxE
        SxevWTzSw4Cl9PQGFGVNy0SkomMQL/0V+XEk7WbPkA3dnBwEFLAxNpIioIvnq07vCpdHCyn/NJ1q6
        btUr080DRhexh5jYnNLUosuLGpb3R8QAZmIJE7+lGSPxtveOHzA3q+uO29+u/S54k42xOeuFITjVO
        sxDxOAwNGSMPWKCTLd6bZLQ11o4kWXeJnixFPQwfweH9oE8L5FCI4M/0LHMJCR5+4JXUPKHeyAAqo
        jOmv8tBNlr+M1FzviZysR1r6DjukQPikzBpu1vgqmB7Em1eG57axcLR6o/WITIOYcCPbhdDNoNtAM
        17sRp9WA==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phlos-002lgj-1n;
        Thu, 30 Mar 2023 06:31:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree block checksumming
Date:   Thu, 30 Mar 2023 15:30:53 +0900
Message-Id: <20230330063059.1574380-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The checksumming of btree blocks always operates on the entire
extent_buffer, and because btree blocks are always allocated contiguously
on disk they are never split by btrfs_submit_bio.

Simplify the checksumming code by finding the extent_buffer in the
btrfs_bio private data instead of trying to search through the bio_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 121 ++++++++++-----------------------------------
 1 file changed, 25 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4fd181f67925f9..3e15965c531e81 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -312,12 +312,35 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 	return ret;
 }
 
-static int csum_one_extent_buffer(struct extent_buffer *eb)
+/*
+ * Checksum a dirty tree block before IO.
+ */
+blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 {
+	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u64 found_start = btrfs_header_bytenr(eb);
 	u8 result[BTRFS_CSUM_SIZE];
 	int ret;
 
+	/*
+	 * Btree blocks are always contiguous on disk.
+	 */
+	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
+		return BLK_STS_IOERR;
+	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
+		return BLK_STS_IOERR;
+
+	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
+		WARN_ON_ONCE(found_start != 0);
+		return BLK_STS_OK;
+	}
+
+	if (WARN_ON_ONCE(found_start != eb->start))
+		return BLK_STS_IOERR;
+	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
+		return BLK_STS_IOERR;
+
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
 				    offsetof(struct btrfs_header, fsid),
 				    BTRFS_FSID_SIZE) == 0);
@@ -344,8 +367,7 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
 		goto error;
 	}
 	write_extent_buffer(eb, result, 0, fs_info->csum_size);
-
-	return 0;
+	return BLK_STS_OK;
 
 error:
 	btrfs_print_tree(eb, 0);
@@ -359,99 +381,6 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
 	 */
 	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
 		btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID);
-	return ret;
-}
-
-/* Checksum all dirty extent buffers in one bio_vec */
-static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
-				      struct bio_vec *bvec)
-{
-	struct page *page = bvec->bv_page;
-	u64 bvec_start = page_offset(page) + bvec->bv_offset;
-	u64 cur;
-	int ret = 0;
-
-	for (cur = bvec_start; cur < bvec_start + bvec->bv_len;
-	     cur += fs_info->nodesize) {
-		struct extent_buffer *eb;
-		bool uptodate;
-
-		eb = find_extent_buffer(fs_info, cur);
-		uptodate = btrfs_subpage_test_uptodate(fs_info, page, cur,
-						       fs_info->nodesize);
-
-		/* A dirty eb shouldn't disappear from buffer_radix */
-		if (WARN_ON(!eb))
-			return -EUCLEAN;
-
-		if (WARN_ON(cur != btrfs_header_bytenr(eb))) {
-			free_extent_buffer(eb);
-			return -EUCLEAN;
-		}
-		if (WARN_ON(!uptodate)) {
-			free_extent_buffer(eb);
-			return -EUCLEAN;
-		}
-
-		ret = csum_one_extent_buffer(eb);
-		free_extent_buffer(eb);
-		if (ret < 0)
-			return ret;
-	}
-	return ret;
-}
-
-/*
- * Checksum a dirty tree block before IO.  This has extra checks to make sure
- * we only fill in the checksum field in the first page of a multi-page block.
- * For subpage extent buffers we need bvec to also read the offset in the page.
- */
-static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
-{
-	struct page *page = bvec->bv_page;
-	u64 start = page_offset(page);
-	u64 found_start;
-	struct extent_buffer *eb;
-
-	if (fs_info->nodesize < PAGE_SIZE)
-		return csum_dirty_subpage_buffers(fs_info, bvec);
-
-	eb = (struct extent_buffer *)page->private;
-	if (page != eb->pages[0])
-		return 0;
-
-	found_start = btrfs_header_bytenr(eb);
-
-	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
-		WARN_ON(found_start != 0);
-		return 0;
-	}
-
-	/*
-	 * Please do not consolidate these warnings into a single if.
-	 * It is useful to know what went wrong.
-	 */
-	if (WARN_ON(found_start != start))
-		return -EUCLEAN;
-	if (WARN_ON(!PageUptodate(page)))
-		return -EUCLEAN;
-
-	return csum_one_extent_buffer(eb);
-}
-
-blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
-{
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	int ret = 0;
-
-	bio_for_each_segment(bv, &bbio->bio, iter) {
-		ret = csum_dirty_buffer(fs_info, &bv);
-		if (ret)
-			break;
-	}
-
 	return errno_to_blk_status(ret);
 }
 
-- 
2.39.2

