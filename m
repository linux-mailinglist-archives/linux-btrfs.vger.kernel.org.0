Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEAB6CFB92
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjC3Gb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjC3Gb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9D5BA0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KJ8RdaCABGX208IoY0cIcWwADFt32og/FeiMSNahY1A=; b=xCTYZfY826eoLUTHDXfwi4TnKJ
        PSosbx+4iSEHmA3W0KlOSCZTWGC1C91E+DB8LsBC8aHOz7gN48MA29V2V1JAdqA7Qlh3SdpdznSbu
        uV4bG/0jGNIlolfVE9Xs/Aieu5Kno80wCsUnvYZNtsQEB9U44zGSN0eu0vSYmArslyFHAqFiqYrMl
        w9TwOntwXhMn6dPy+ff7DW5hP7AL6L9XyDh7U6S6+Ha73ceJ8PHq8l0eQJ1zrklf1NdFMi02JDBxa
        Ad+qzO7XI/vL8O7NqCwyI92qVWV1VvtP9THVmrIfd4OT/bLzniQpA9d4TITql4sP9h4YBsIyjEm/c
        HjNLUT1A==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloi-002leo-2G;
        Thu, 30 Mar 2023 06:31:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/21] btrfs: return bool from lock_extent_buffer_for_io
Date:   Thu, 30 Mar 2023 15:30:48 +0900
Message-Id: <20230330063059.1574380-11-hch@lst.de>
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

lock_extent_buffer_for_io never returns a negative error value, so switch
the return value to a simple bool.  Also remove the noinline_for_stack
annotation given that nothing in lock_extent_buffer_for_io or its callers
is particularly stack hungry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bc50163dd3b792..08e4e53f42e8a7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1628,18 +1628,17 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  *
  * May try to flush write bio if we can't get the lock.
  *
- * Return  0 if the extent buffer doesn't need to be submitted.
- *           (E.g. the extent buffer is not dirty)
- * Return >0 is the extent buffer is submitted to bio.
- * Return <0 if something went wrong, no page is locked.
+ * Return %false if the extent buffer doesn't need to be submitted (e.g. the
+ * extent buffer is not dirty)
+ * Return %true is the extent buffer is submitted to bio.
  */
-static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
-			  struct btrfs_bio_ctrl *bio_ctrl)
+static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
+				      struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i, num_pages;
 	int flush = 0;
-	int ret = 0;
+	bool ret = false;
 
 	if (!btrfs_try_tree_write_lock(eb)) {
 		submit_write_bio(bio_ctrl, 0);
@@ -1650,7 +1649,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
 		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
-			return 0;
+			return false;
 		if (!flush) {
 			submit_write_bio(bio_ctrl, 0);
 			flush = 1;
@@ -1677,7 +1676,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 					 -eb->len,
 					 fs_info->dirty_metadata_batch);
-		ret = 1;
+		ret = true;
 	} else {
 		spin_unlock(&eb->refs_lock);
 	}
@@ -2011,7 +2010,6 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 	u64 page_start = page_offset(page);
 	int bit_start = 0;
 	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
-	int ret;
 
 	/* Lock and write each dirty extent buffers in the range */
 	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
@@ -2057,25 +2055,13 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		if (!eb)
 			continue;
 
-		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
-		if (ret == 0) {
-			free_extent_buffer(eb);
-			continue;
+		if (lock_extent_buffer_for_io(eb, bio_ctrl)) {
+			write_one_subpage_eb(eb, bio_ctrl);
+			submitted++;
 		}
-		if (ret < 0) {
-			free_extent_buffer(eb);
-			goto cleanup;
-		}
-		write_one_subpage_eb(eb, bio_ctrl);
 		free_extent_buffer(eb);
-		submitted++;
 	}
 	return submitted;
-
-cleanup:
-	/* We hit error, end bio for the submitted extent buffers */
-	submit_write_bio(bio_ctrl, ret);
-	return ret;
 }
 
 /*
@@ -2154,8 +2140,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 
 	*eb_context = eb;
 
-	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
-	if (ret <= 0) {
+	if (!lock_extent_buffer_for_io(eb, bio_ctrl)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
 			btrfs_put_block_group(cache);
-- 
2.39.2

