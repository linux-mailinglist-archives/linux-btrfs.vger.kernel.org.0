Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8FA4E66A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351426AbiCXQIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbiCXQIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:08:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913250B15
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rvWULxyJuO1VuPlidrjDvm41hQGcQWe+44HTMts4xJ0=; b=5FaG5CqPF9/q3ta7u+FAJLcFUs
        H3wYdRDkvTLroyQulqZ5sZjl8OPkePlmP3ukfW6/TITF26txQmTOw3npLcFA9DpgBjGW3btTpf6ov
        TJEvEjtDQ2kATVEGE/UZhUBfVRgsUtjXwImRzYn1o0tD7OdFQ1G9F8T7j5pXW6cw1haFVzJIkIjdX
        YeI2CETERkVT9Z91crecy3NI5yaWgAaZPGBDq9P1dRuTOYnow4Llt2O38fmvYKlXLumD4ChSK7p3O
        1Sget77AwEzU6Bdjo/z3zQNfNzS+WCOKh98PkacT0Apzl4F9x19X1ddtztZRPiBskuuaKaRz57ssq
        8DeJD/xw==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXPyr-00H8wk-ER; Thu, 24 Mar 2022 16:06:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix direct I/O read repair for split bios
Date:   Thu, 24 Mar 2022 17:06:27 +0100
Message-Id: <20220324160628.1572613-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324160628.1572613-1-hch@lst.de>
References: <20220324160628.1572613-1-hch@lst.de>
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

When a bio is split in btrfs_submit_direct, dip->file_offset contains
the file offset for the first bio.  But this means the start value used
in btrfs_check_read_dio_bio is incorrect for subsequent bios.  Add
a file_offset field to struct btrfs_bio to pass along the correct offset.

Given that check_data_csum only uses start of an error message this
means problems with this miscalculation will only show up when I/O
fails or checksums mismatch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  1 +
 fs/btrfs/inode.c     | 13 +++++--------
 fs/btrfs/volumes.h   |  3 +++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d78b3a2d04e3b..c50d3a1225086 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2658,6 +2658,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 	repair_bio = btrfs_bio_alloc(1);
 	repair_bbio = btrfs_bio(repair_bio);
+	repair_bbio->file_offset = start;
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa0a60ee26cb7..762133fac0df1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7805,8 +7805,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	const u64 orig_file_offset = dip->file_offset;
-	u64 start = orig_file_offset;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
@@ -7816,6 +7814,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
 		pgoff = bvec.bv_offset;
 		for (i = 0; i < nr_sectors; i++) {
+			u64 start = bbio->file_offset + bio_offset;
+
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, bbio,
@@ -7828,17 +7828,13 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			} else {
 				int ret;
 
-				ASSERT((start - orig_file_offset) < UINT_MAX);
-				ret = btrfs_repair_one_sector(inode,
-						&bbio->bio,
-						start - orig_file_offset,
-						bvec.bv_page, pgoff,
+				ret = btrfs_repair_one_sector(inode, &bbio->bio,
+						bio_offset, bvec.bv_page, pgoff,
 						start, bbio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
 					err = errno_to_blk_status(ret);
 			}
-			start += sectorsize;
 			ASSERT(bio_offset + sectorsize > bio_offset);
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
@@ -8041,6 +8037,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
+		btrfs_bio(bio)->file_offset = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e7..f3e28f11cfb6e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -328,6 +328,9 @@ struct btrfs_fs_devices {
 struct btrfs_bio {
 	unsigned int mirror_num;
 
+	/* for direct I/O */
+	u64 file_offset;
+
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
 	u8 *csum;
-- 
2.30.2

