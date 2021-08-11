Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AD3E8A44
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 08:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhHKGhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 02:37:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41843 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhHKGhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 02:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628663850; x=1660199850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4b61TAc3neKN26mCdCOd2wB19gc9LsXoyPnXXm+KsMA=;
  b=gXw4qrGLGkaKimlFsfJoOAWstlwBz1RbmFlowXtAbl9S8CTShpEWNGKm
   rD5F7u0b4CA+CIafwMoSJbbebYe6zWxQFUfmSdor2gyoC+FWH2plBNGdN
   lwf1e7fHv8HDRphnUcPf5aIL33eyUb1P6g/REeEtPEQ6ZuICHvVpciiHd
   CcMgtHr9ujRgisJmfSk+XBKiwpSH3x142zbjrH/F7ReqC9Fo/TizJiUqZ
   5wBsz/sQGiH5/3Jw+jbQBd7JENbPfcxsxfzMu0RZn3OifdVWK9B+1BroL
   EwXSqbKGSuGekZA4RUO/B82zvsPD8xZ9japOMYN9M9sdufqpSl1cRC5mk
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="288472685"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 14:37:30 +0800
IronPort-SDR: 4Xo3RLRHsngFYKIYVSkUZ13ozHKHI1vo8szVXNH7/nXRilAb9YXDCwQKNo2dAlYpijUAXvD5LF
 orW8QEWm2cymwdrbkfruZ6jNOyQM6ACRSbOcAgmphGfb2Thq6rKANd2m3terwdHQimIPM47dPD
 fpM35npP8CClbNpHlHojnS9I8/ChH0UTK+llKYd7WIg4zh5UWRTb+JGhEPRSd4Qpd115evxz5C
 bpVwSvl6kNhZu8jIxTd+T/2bx/2z2IeVHJxeONKUP++Ar71mbp4DSduMNdpsc5QBxQfxuGfpED
 1KFAf8PJtP9oNDdCetAqZd+I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 23:14:50 -0700
IronPort-SDR: QMFRbR3NuOO8sJJVy3k2bnsxKhoVU4Pez4basBQy40qJr37CXX0yU4IaFm+q/+dU/XSXJelkPe
 i8L/vqrXLDVjnKIfMqj737YX96hsObJHvsc3mYKi1/lUaLuMiL8xB5YZNSFmLAux46nfVcpNSs
 Q2wW0g0audG2MhMdLyqPPyHLaXho1E5GinRImZiLhBlOdHKxj5DlZgEJgg43TxSneH2EAf27ZP
 Q//WPWvbLeSxErry0IcgpwBJRh1RNS8X3Hn2O428kLY3A/IPlMEo+BmSQPXzPwHbyt6LQ6zyev
 w1g=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Aug 2021 23:37:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs: zoned: fix ordered extent boundary calculation
Date:   Wed, 11 Aug 2021 15:37:08 +0900
Message-Id: <20210811063708.2520540-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_lookup_ordered_extent() should be queried with the offset in a file
instead of the logical address. Pass the file offset from
submit_extent_page() to calc_bio_boundaries().

Also, calc_bio_boundaries() relies on the bio's operation flag, so move the
call site after setting it.

Fixes: 390ed29b817e ("btrfs: refactor submit_extent_page() to make bio and its flag tracing easier")
Cc: Qu Wenruo <wqu@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7d4c03762374..c353bfd89dfc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3241,7 +3241,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 }
 
 static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
-			       struct btrfs_inode *inode)
+			       struct btrfs_inode *inode, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_io_geometry geom;
@@ -3283,7 +3283,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	}
 
 	/* Ordered extent not yet created, so we're good */
-	ordered = btrfs_lookup_ordered_extent(inode, logical);
+	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
 	if (!ordered) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
 		return 0;
@@ -3300,7 +3300,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			 struct writeback_control *wbc,
 			 unsigned int opf,
 			 bio_end_io_t end_io_func,
-			 u64 disk_bytenr, u32 offset,
+			 u64 disk_bytenr, u32 offset, u64 file_offset,
 			 unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -3317,13 +3317,13 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 		bio = btrfs_bio_alloc(disk_bytenr + offset);
 	bio_ctrl->bio = bio;
 	bio_ctrl->bio_flags = bio_flags;
-	ret = calc_bio_boundaries(bio_ctrl, inode);
-	if (ret < 0)
-		goto error;
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = &inode->io_tree;
 	bio->bi_write_hint = inode->vfs_inode.i_write_hint;
 	bio->bi_opf = opf;
+	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
+	if (ret < 0)
+		goto error;
 	if (wbc) {
 		struct block_device *bdev;
 
@@ -3398,6 +3398,7 @@ static int submit_extent_page(unsigned int opf,
 		if (!bio_ctrl->bio) {
 			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
 					    end_io_func, disk_bytenr, offset,
+					    page_offset(page) + cur,
 					    bio_flags);
 			if (ret < 0)
 				return ret;
-- 
2.32.0

