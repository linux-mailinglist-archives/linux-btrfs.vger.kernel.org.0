Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A552A548
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiEQOv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349313AbiEQOvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C9DF1D
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9lEPp0W11O6pCOqq3KvJ2LQANZTph+El3y/9ezo6YYc=; b=pW2j9kYbgITO4hHBdACEt5vD+F
        bhk7InLzx8zVpHvb6CXATQd/D6TaKIsfzq3R3ODTBXjW0aF+DTy6VbGpYlsFF+FZRK+nc9NRbbI17
        7NRvFE/Sn5rxlv/J+MZTw/pnQStU440cx/Zql5Riph5KQxm7PBJKHPn33cn6z8y3U4miPAKHCx4M1
        iuz/BZa4lFsNVxVrrsLIuQCg3XZX4PxOG2VCIz3qG5F55Mp2JwvPcNb6g6uCzxDrrx7qrDs1gQrzt
        IU2vF98MMD6pxrL6yLdYR3n2Zmu6kjgEouhgGg6nqTop6SZpxXTj7q0lGBQOV7oqjv1tYHWVsi8Tg
        fuBaI6Ag==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXJ-00EXBY-CW; Tue, 17 May 2022 14:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/15] btrfs: remove duplicated parameters from submit_data_read_repair()
Date:   Tue, 17 May 2022 16:50:28 +0200
Message-Id: <20220517145039.3202184-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

The function submit_data_read_repair() is only called for buffered data
read path, thus those members can be calculated using bvec directly:

- start
  start = page_offset(bvec->bv_page) + bvec->bv_offset;

- end
  end = start + bvec->bv_len - 1;

- page
  page = bvec->bv_page;

- pgoff
  pgoff = bvec->bv_offset;

Thus we can safely replace those 4 parameters with just one bio_vec.

Also remove the unused return value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: also remove the return value]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8fe5f505d6e92..cee205d8d4bac 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2739,18 +2739,17 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_data_read_repair(struct inode *inode,
-					    struct bio *failed_bio,
-					    u32 bio_offset, struct page *page,
-					    unsigned int pgoff,
-					    u64 start, u64 end,
-					    int failed_mirror,
-					    unsigned int error_bitmap)
+static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
+		u32 bio_offset, const struct bio_vec *bvec, int failed_mirror,
+		unsigned int error_bitmap)
 {
+	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct page *page = bvec->bv_page;
+	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
+	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
-	int error = 0;
 	int i;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2797,11 +2796,9 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 			continue;
 		}
 		/*
-		 * Repair failed, just record the error but still continue.
-		 * Or the remaining sectors will not be properly unlocked.
+		 * Continue on failed repair, otherwise the remaining sectors
+		 * will not be properly unlocked.
 		 */
-		if (!error)
-			error = ret;
 next:
 		end_page_read(page, uptodate, start + offset, sectorsize);
 		if (uptodate)
@@ -2814,7 +2811,6 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 				start + offset + sectorsize - 1,
 				&cached);
 	}
-	return errno_to_blk_status(error);
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
@@ -3105,10 +3101,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, page,
-						start - page_offset(page),
-						start, end, mirror,
-						error_bitmap);
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
-- 
2.30.2

