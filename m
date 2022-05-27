Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA3535BC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiE0Inm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbiE0Ing (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD242AC53
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pLz7fCaRYTbnnB67rTLJ5HL/EzUvu0brbWAz/EHB/NQ=; b=DLhfjS8Ot/Ywi6hqkRI+yuQfEG
        tv75UkYcBH5CEV6IfYDC2BcLWPGIzcGUBC84CQYhwkdqyQ9qO9yZauJvbr3za3QTnRPJtXP9HJArv
        msWZNpIb+MOFVDrhdSuRFsm8dV4seC+pUNWeIITGbmIliN4oT1FRM/cAqclEWcg4jACZGMy8e1VD5
        IgOt3QZpnKmZVWIa2iXZzehKc7SkkTqF2ToXkkgGPDUcznbWfVrqKjwskKkXUsH92I47Ku9Gl/MiP
        FbAnRpv0hh5ii9/Z3n5IAX1y34IhL3JGBDTp6KjRk6siC2ii+fZpliv6X2F7L8h6wVINNuNu5P9zJ
        8zU6pQUQ==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZE-00H3W9-I3; Fri, 27 May 2022 08:43:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: support read bios in btrfs_map_repair_bio
Date:   Fri, 27 May 2022 10:43:15 +0200
Message-Id: <20220527084320.2130831-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enhance btrfs_map_repair_bio to also support reading so that we have a
single function dealing with all synchronous bio I/O for the repair code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 515f5fccf3d17..9053b62af3607 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6805,6 +6805,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return errno_to_blk_status(ret);
 }
 
+static void btrfs_bio_end_io_sync(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
 /*
  * This bypasses the standard btrfs submit functions deliberately, as the
  * standard behavior is to write all copies in a raid setup. Here we only want
@@ -6814,15 +6819,17 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		int mirror_num)
 {
+	enum btrfs_map_op op = btrfs_op(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 map_length = bio->bi_iter.bi_size;
+	bool is_raid56 = btrfs_is_parity_mirror(fs_info, logical, map_length);
 	struct btrfs_io_context *bioc = NULL;
+	unsigned int stripe_idx = 0;
 	struct btrfs_device *dev;
 	u64 sector;
 	int ret;
 
 	ASSERT(mirror_num);
-	ASSERT(bio_op(bio) == REQ_OP_WRITE);
 
 	/*
 	 * Avoid races with device replace and make sure our bioc has devices
@@ -6830,7 +6837,23 @@ int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	 * read repair operation.
 	 */
 	btrfs_bio_counter_inc_blocked(fs_info);
-	if (btrfs_is_parity_mirror(fs_info, logical, map_length)) {
+	if (is_raid56) {
+		if (op == BTRFS_MAP_READ) {
+			DECLARE_COMPLETION_ONSTACK(done);
+
+			ret = __btrfs_map_block(fs_info, op, logical,
+					&map_length, &bioc, mirror_num, 1);
+			if (ret)
+				goto out_counter_dec;
+
+			bio->bi_private = &done;
+			bio->bi_end_io = btrfs_bio_end_io_sync;
+			ret = raid56_parity_recover(bio, bioc,
+					map_length, mirror_num, 1);
+			wait_for_completion_io(&done);
+			goto out_bio_status;
+		}
+
 		/*
 		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
 		 * to update all raid stripes, but here we just want to correct
@@ -6843,19 +6866,24 @@ int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			goto out_counter_dec;
 		ASSERT(bioc->mirror_num == 1);
 	} else {
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
-				&map_length, &bioc, mirror_num);
+		ret = btrfs_map_block(fs_info, op, logical, &map_length, &bioc,
+				mirror_num);
 		if (ret)
 			goto out_counter_dec;
-		BUG_ON(mirror_num != bioc->mirror_num);
+
+		if (op == BTRFS_MAP_WRITE) {
+			ASSERT(mirror_num == bioc->mirror_num);
+			stripe_idx = bioc->mirror_num - 1;
+		}
 	}
 
-	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	dev = bioc->stripes[bioc->mirror_num - 1].dev;
+	sector = bioc->stripes[stripe_idx].physical >> 9;
+	dev = bioc->stripes[stripe_idx].dev;
 	btrfs_put_bioc(bioc);
 
 	if (!dev || !dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
+	    (op == BTRFS_MAP_WRITE &&
+	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
 		ret = -EIO;
 		goto out_counter_dec;
 	}
@@ -6865,9 +6893,9 @@ int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	btrfsic_check_bio(bio);
 	submit_bio_wait(bio);
-
+out_bio_status:
 	ret = blk_status_to_errno(bio->bi_status);
-	if (ret)
+	if (ret && op == BTRFS_MAP_WRITE)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
 out_counter_dec:
 	btrfs_bio_counter_dec(fs_info);
-- 
2.30.2

