Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCB6B8B15
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCNGRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCNGRf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985247B48A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KJ8RdaCABGX208IoY0cIcWwADFt32og/FeiMSNahY1A=; b=vbHq6gD0E3ce9kSBl1tPS2TdAT
        j+1muVQ1DLSVPdY7fbfB8S764RSr3/USY0cfe7g1ljHutespnX9LWT0eaiCerrc52emQ/6nS6JPmd
        lmOCm4+kQJvgjRXnc+Aig015/PTSctXjiOCQF7BigoQygeFymAniawZTNrrwROexCQxy8Hf7ZjnaG
        j+y/w3nviOx3FcQwOH3RztNE/d4a0dnYZqdQbdrPF7xMfyf3MRDJSY0+L1SsmJUI85BR2oNg33AI+
        WyrD+RBluRIps1XA5emVs3HmbzAyBjnHFZfAMvQtUnU2hz3rQE+h8+zeY952hdU8vLX6+MOFIL/0k
        gAIqYy+Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyW-009Alg-DU; Tue, 14 Mar 2023 06:17:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/21] btrfs: return bool from lock_extent_buffer_for_io
Date:   Tue, 14 Mar 2023 07:16:44 +0100
Message-Id: <20230314061655.245340-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

