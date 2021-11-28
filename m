Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFD34604D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhK1F6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhK1F4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADEF41FD37;
        Sun, 28 Nov 2021 05:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVt9OfxBECVG2p8rz9FvunW4H+fqBQcwg/n9PNHZfGs=;
        b=ObSMgp5mGa+qigS7+UKjidQug5LCgmTAiezt04Bvy4nFJ9ulyBSfBOqDOB1zW8qh6BamOh
        6YeVrS3mWIXF6qEQnRCZ+7v3UrYvzIkw0n46m8fxPkt7TE7YZn8ITFAqZY7uiCmMCJ+fs1
        6hGbW3j4K2gBKuJZx0xx7IEuHGTYIyA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5F3313446;
        Sun, 28 Nov 2021 05:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGhJIVcZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 07/11] btrfs: make end_bio_extent_*_writepage() to handle split biot properly
Date:   Sun, 28 Nov 2021 13:52:55 +0800
Message-Id: <20211128055259.39249-8-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are 3 call sites involved:

- end_bio_extent_writepage()
  For data writeback

- end_bio_subpage_eb_writepage()
  For subpage metadata writeback

- end_bio_extent_buffer_writepage()
  For regular metadata writeback

All those functions share the same modification:

- Remove ASSERT() to non-cloned bios
- Use bio_for_each_segment()
  Which can handle both unsplit bio and split biot properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 67965faeef47..91013c1dce25 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2827,31 +2827,31 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 static void end_bio_extent_writepage(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 	u64 start;
 	u64 end;
-	struct bvec_iter_all iter_all;
 	bool first_bvec = true;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 
 		/* Our read/write should always be sector aligned. */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(bvec.bv_offset, sectorsize))
 			btrfs_err(fs_info,
 		"partial page write in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_len, sectorsize))
+				  bvec.bv_offset, bvec.bv_len);
+		else if (!IS_ALIGNED(bvec.bv_len, sectorsize))
 			btrfs_info(fs_info,
 		"incomplete page write with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+				   bvec.bv_offset, bvec.bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
+		start = page_offset(page) + bvec.bv_offset;
+		end = start + bvec.bv_len - 1;
 
 		if (first_bvec) {
 			btrfs_record_physical_zoned(inode, start, bio);
@@ -2860,7 +2860,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 
 		end_extent_writepage(page, error, start, end);
 
-		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
+		btrfs_page_clear_writeback(fs_info, page, start, bvec.bv_len);
 	}
 
 	bio_put(bio);
@@ -4475,20 +4475,20 @@ static struct extent_buffer *find_extent_buffer_nolock(
 static void end_bio_subpage_eb_writepage(struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 
 	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		u64 bvec_start = page_offset(page) + bvec->bv_offset;
-		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
+		u64 bvec_start = page_offset(page) + bvec.bv_offset;
+		u64 bvec_end = bvec_start + bvec.bv_len - 1;
 		u64 cur_bytenr = bvec_start;
 
-		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+		ASSERT(IS_ALIGNED(bvec.bv_len, fs_info->nodesize));
 
 		/* Iterate through all extent buffers in the range */
 		while (cur_bytenr <= bvec_end) {
@@ -4531,14 +4531,14 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 	struct extent_buffer *eb;
 	int done;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
 
 		eb = (struct extent_buffer *)page->private;
 		BUG_ON(!eb);
-- 
2.34.0

