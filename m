Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D15302C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbiEVLsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiEVLsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0C252AA
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tPhBANDYHkVVSztiiRuLvH6bGaTqH0OvA8WX/2PF9cw=; b=wMEfEjt/S1htCYWc/+diFt5W5T
        WhVk8Ibl784epRdof8/sbn/bW9BuMk1iSUHLbw339KAR8j3Q9xMhnhQGqkefUeVjkWQU1tmWwjFPx
        w06vkocznHutxV4V+mzeLznKOBnlL32kcWLzparK4qQviTGA95jlpD57jQ/4fwukltRgxZgBADbZl
        vgHrqLqqMkXj6QdA3uYOe67Cb3p37X3VJsKXBjdwZYn/g9p3kBZNdy45Hhr2PeUB7+qKHJ3ftFLk6
        pAXz7YG8utxblJ+7bvC7AUz0XkHUgTAIyFm2z9cRvXHWgQnFcJGjGKaQCzP8vqmUPBc5MKZxCXoXr
        633yFMBw==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk49-001E45-QE; Sun, 22 May 2022 11:48:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: refactor end_bio_extent_readpage
Date:   Sun, 22 May 2022 13:47:51 +0200
Message-Id: <20220522114754.173685-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
References: <20220522114754.173685-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Untangle the goto mess and remove the pointless 'ret' local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 87 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e87474f5b9415..1d144f655f653 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3015,7 +3015,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	 */
 	u32 bio_offset = 0;
 	int mirror;
-	int ret;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -3026,6 +3025,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 		unsigned int error_bitmap = (unsigned int)-1;
+		bool repair = false;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -3063,55 +3063,23 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (is_data_inode(inode)) {
 				error_bitmap = btrfs_verify_data_csum(bbio,
 						bio_offset, page, start, end);
-				ret = error_bitmap;
+				if (error_bitmap)
+					uptodate = false;
 			} else {
-				ret = btrfs_validate_metadata_buffer(bbio,
-					page, start, end, mirror);
+				if (btrfs_validate_metadata_buffer(bbio,
+						page, start, end, mirror))
+					uptodate = false;
 			}
-			if (ret)
-				uptodate = false;
-			else
-				clean_io_failure(BTRFS_I(inode)->root->fs_info,
-						 failure_tree, tree, start,
-						 page,
-						 btrfs_ino(BTRFS_I(inode)), 0);
 		}
 
-		if (likely(uptodate))
-			goto readpage_ok;
-
-		if (is_data_inode(inode)) {
-			/*
-			 * If we failed to submit the IO at all we'll have a
-			 * mirror_num == 0, in which case we need to just mark
-			 * the page with an error and unlock it and carry on.
-			 */
-			if (mirror == 0)
-				goto readpage_ok;
-
-			/*
-			 * submit_data_read_repair() will handle all the good
-			 * and bad sectors, we just continue to the next bvec.
-			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
-
-			ASSERT(bio_offset + len > bio_offset);
-			bio_offset += len;
-			continue;
-		} else {
-			struct extent_buffer *eb;
-
-			eb = find_extent_buffer_readpage(fs_info, page, start);
-			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-			eb->read_mirror = mirror;
-			atomic_dec(&eb->io_pages);
-		}
-readpage_ok:
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
 
+			clean_io_failure(BTRFS_I(inode)->root->fs_info,
+					 failure_tree, tree, start, page,
+					 btrfs_ino(BTRFS_I(inode)), 0);
+
 			/*
 			 * Zero out the remaining part if this range straddles
 			 * i_size.
@@ -3128,14 +3096,41 @@ static void end_bio_extent_readpage(struct bio *bio)
 				zero_user_segment(page, zero_start,
 						  offset_in_page(end) + 1);
 			}
+		} else if (is_data_inode(inode)) {
+			/*
+			 * Only try to repair bios that actually made it to a
+			 * device.  If the bio failed to be submitted mirror
+			 * is 0 and we need to fail it without retrying.
+			 */
+			if (mirror > 0)
+				repair = true;
+		} else {
+			struct extent_buffer *eb;
+
+			eb = find_extent_buffer_readpage(fs_info, page, start);
+			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+			eb->read_mirror = mirror;
+			atomic_dec(&eb->io_pages);
 		}
+
+		if (repair) {
+			/*
+			 * submit_data_read_repair() will handle all the good
+			 * and bad sectors, we just continue to the next bvec.
+			 */
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
+		} else {
+			/* Update page status and unlock */
+			end_page_read(page, uptodate, start, len);
+			endio_readpage_release_extent(&processed,
+					BTRFS_I(inode), start, end,
+					PageUptodate(page));
+		}
+
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
 
-		/* Update page status and unlock */
-		end_page_read(page, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, PageUptodate(page));
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-- 
2.30.2

