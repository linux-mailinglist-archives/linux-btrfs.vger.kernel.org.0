Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703A468F27
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhLFCdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhLFCdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58DFA1FD54
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVTYQGlKnXknG7jUoqzw7oV1bzUlbta6f3bJYyfXwEk=;
        b=rNKajSpd/8mTK1Sdn7cFeA1HYeJVMZtc0FmC1hoJU0b7fRd2g993YNXBPNaUFuXCNXo5td
        jsKrB0vYeHwdR04jAbW+/daNc6aYQrsacdj00EmAzD4B5yPA1ZCRXpOWqlP1Cg+rq4deHa
        vvLgcyb8OBf/kJEDbhStOIPk2mfp1mc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB52213451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uE4sHa91rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/17] btrfs: make data buffered write endio function to be split bio compatible
Date:   Mon,  6 Dec 2021 10:29:29 +0800
Message-Id: <20211206022937.26465-10-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only need to change the bio_for_each_segment_all() call to
__bio_for_each_segment() call, and using btrfs_bio::iter as the initial
bi_iter.

Now the endio function can handle both split and unsplit bios well.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 049da3811bae..952789ed650d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2833,31 +2833,31 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 static void end_bio_extent_writepage(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
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
@@ -2866,7 +2866,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 
 		end_extent_writepage(page, error, start, end);
 
-		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
+		btrfs_page_clear_writeback(fs_info, page, start, bvec.bv_len);
 	}
 
 	bio_put(bio);
-- 
2.34.1

