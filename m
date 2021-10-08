Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0E42653D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhJHHcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Oct 2021 03:32:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33536 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHHcG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Oct 2021 03:32:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 98C761FD35
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633678210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csMnVMB9IF7Y5EKikjsmVmTOTIi3M0tSiw0hSlbWdKQ=;
        b=bqzoYWp/NrIQekuBICm+DD25wY3UxS550OUkcrw3zLI9Cvh9IXP20o1xBQDI111Gpc/KGd
        qmAFLBRNs/IltowO0a9hgbv6vRZsV8icYzZg3BRuIYxQ9+ZXZjAgFQyRqGWLjlOSGWJvWc
        bRypC4oTlJeeM77MAsYxVUq36eb+qQs=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 9686DA3B85
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove btrfs_bio::logical member
Date:   Fri,  8 Oct 2021 15:30:00 +0800
Message-Id: <20211008073000.62391-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008073000.62391-1-wqu@suse.com>
References: <20211008073000.62391-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The member btrfs_bio::logical is only initialized by two call sites:

- btrfs_repair_one_sector()
  No corresponding site to utilize it.

- btrfs_submit_direct()
  The corresponding site to utilize it is btrfs_check_read_dio_bio().

However for btrfs_check_read_dio_bio(), we can grab the file_offset from
btrfs_dio_private::file_offset directly.

Thus it turns out we don't really that btrfs_bio::logical member at all.

For btrfs_bio, the logical bytenr can be fetched from its
bio->bi_iter.bi_sector directly.

So let's just remove the member to save 8 bytes for structure btrfs_bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  1 -
 fs/btrfs/inode.c     | 17 ++++++++---------
 fs/btrfs/volumes.h   |  1 -
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b10dc75eef1c..4e03a6d3aa32 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2673,7 +2673,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->logical = failrec->start;
 	repair_bbio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d65f7d6b7df1..b9c70a073a24 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8089,10 +8089,11 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 	return ret;
 }
 
-static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
+static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
 {
+	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
@@ -8100,7 +8101,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	u64 start = bbio->logical;
+	const u64 orig_file_offset = dip->file_offset;
+	u64 start = orig_file_offset;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
@@ -8122,10 +8124,10 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				int ret;
 
-				ASSERT((start - bbio->logical) < UINT_MAX);
+				ASSERT((start - orig_file_offset) < UINT_MAX);
 				ret = btrfs_repair_one_sector(inode,
 						&bbio->bio,
-						start - bbio->logical,
+						start - orig_file_offset,
 						bvec.bv_page, pgoff,
 						start, bbio->mirror_num,
 						submit_dio_repair_bio);
@@ -8168,10 +8170,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_opf, bio->bi_iter.bi_sector,
 			   bio->bi_iter.bi_size, err);
 
-	if (bio_op(bio) == REQ_OP_READ) {
-		err = btrfs_check_read_dio_bio(dip->inode,
-					       btrfs_bio(bio), !err);
-	}
+	if (bio_op(bio) == REQ_OP_READ)
+		err = btrfs_check_read_dio_bio(dip, btrfs_bio(bio), !err);
 
 	if (err)
 		dip->dio_bio->bi_status = err;
@@ -8337,7 +8337,6 @@ static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
-		btrfs_bio(bio)->logical = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 83075d6855db..49322a43593a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -313,7 +313,6 @@ struct btrfs_bio {
 
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
-	u64 logical;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 	struct bvec_iter iter;
-- 
2.33.0

