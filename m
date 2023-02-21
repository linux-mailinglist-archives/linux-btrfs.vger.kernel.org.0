Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAB69E46D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 17:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjBUQVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 11:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjBUQVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 11:21:31 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED6206B9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676996479; x=1708532479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nbAxWnLGA71G5FgxUitkvhanDxm+otfhAd9Uxpm/cxo=;
  b=A3M9Ll5i/fYKSG7/a4cXh+hSrbkuvOp7n7Yvnfudp03zceF6AXA3j7js
   W+pbLvo1lj0QDBc1q5xxl8vIdgRJq4abUNe0NfEu/ZIy/CcCAw/K/LyX/
   7FqUZqEJjsXZCreBrrJP54Axs9dB1E3AFmr23rppkMx3S2eAB4OZvD+ZR
   /Q8cm6iieW+LgI1sA5CiQu1QPpoNJZ313c5P3lPHwQ93iWZci7F1DzhRy
   R/5aeru6faYmMyt08EEESJbgfG4oztcvwM89N+vFkbhMTqEYAWm8bz16v
   pmVC30COZENjuJ7aC8d5ZePX3dpb+8Nq4Z2kFp54GUUcggZnBXNyVvKfJ
   A==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="335796692"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 00:21:19 +0800
IronPort-SDR: ocyfeW8wcHzzB3CREhjBEPHyhQUQUl11d9S8dzrg1j/fke7BO8Qp3iW1SKt1wJiiuAmgpzdAIZ
 oY4KkG3kRJGG3owpgyVZyhpLfA0Ifp0Vqpr7WheqTuE023HRYtv1WWqqSUQ2b2dHRBHy7S/t2g
 +JCuXx1TmUHXHpPDsvIOJxwjMiV4bSNZcwlmCv+Hyzp2L09Nn1A8Lclasd6W9jpBisPQcdij9D
 bICUh7vNZVVUVqb03s1LNr89UW1Bfukc9sPsGhWNtA69C3L6Kf74FM/q4WMAWsWICY0TbqqF5C
 U1A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 07:38:18 -0800
IronPort-SDR: mdQ6PSFTAzqsqdR1oFjlhraicvQuSMsfugtsGM5QCcZ3cZyRMPUMiFo0PWfIY2BWJ0g05asUE3
 0wcVVEnYkV2tueLgwxB/pc8Jircmv9bhqQ+9Zcr7AGN4uyikMiniHVCyIUUpsS4Hzd7tkM56aV
 jn27ddhpFjn7txBpsxt7TCRYd7xIWNrK7b86GYG6SwGvGfrNAeD7t77xSYr0jbEgQqcs7ONbTJ
 xddMaFowY4lrGfbsSuKb5kNREo5USv+z3jQv4ni+/lQWjsT7hrcsavy/ObTgrZvly7++hz7CZh
 6NA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2023 08:21:19 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, hch@infradead.org
Subject: [PATCH v2] btrfs: sink calc_bio_boundaries into its only caller
Date:   Tue, 21 Feb 2023 08:21:04 -0800
Message-Id: <9c8a6815c5cfd36dbf2a45a80fea31c052bbb318.1676996243.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nowadays calc_bio_boundaries() is a relatively simple function that only
guarantees the one bio equals to one ordered extent rule for uncompressed
Zone Append bios.

Sink it into it's only caller alloc_new_bio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

The resulting diff looks a bit ugly, but when applied the code looks
sane again.

This is based ontop of Christoph's series "cleanup submit_extent_page and
friends"

 fs/btrfs/extent_io.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 644cc326ecd4..16bd43b073d7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -897,10 +897,19 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 		page_offset(page) + pg_offset;
 }
 
-static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
-				struct btrfs_inode *inode, u64 file_offset)
+static void alloc_new_bio(struct btrfs_inode *inode,
+			  struct btrfs_bio_ctrl *bio_ctrl,
+			  u64 disk_bytenr, u64 file_offset)
 {
-	struct btrfs_ordered_extent *ordered;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bio *bio;
+
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
+			      bio_ctrl->end_io_func, NULL);
+	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	btrfs_bio(bio)->file_offset = file_offset;
+	bio_ctrl->bio = bio;
+	bio_ctrl->len_to_oe_boundary = U32_MAX;
 
 	/*
 	 * Limit the extent to the ordered boundary for Zone Append.
@@ -908,34 +917,18 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * them.
 	 */
 	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio))) {
-		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+	    btrfs_use_zone_append(btrfs_bio(bio))) {
+		struct btrfs_ordered_extent *ordered =
+			btrfs_lookup_ordered_extent(inode, file_offset);
+
 		if (ordered) {
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
 			btrfs_put_ordered_extent(ordered);
-			return;
 		}
 	}
 
-	bio_ctrl->len_to_oe_boundary = U32_MAX;
-}
-
-static void alloc_new_bio(struct btrfs_inode *inode,
-			  struct btrfs_bio_ctrl *bio_ctrl,
-			  u64 disk_bytenr, u64 file_offset)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio;
-
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
-			      bio_ctrl->end_io_func, NULL);
-	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	btrfs_bio(bio)->file_offset = file_offset;
-	bio_ctrl->bio = bio;
-	calc_bio_boundaries(bio_ctrl, inode, file_offset);
-
 	if (bio_ctrl->wbc) {
 		/*
 		 * Pick the last added device to support cgroup writeback.  For
-- 
2.39.1

