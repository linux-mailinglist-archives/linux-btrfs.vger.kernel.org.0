Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16A34BBBCB
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiBRPD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiBRPD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:56 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629529720E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d3so15190632qvb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3qRZot/DLMtNPxSFXIfQAOQcu5vHJvMFSfS4j/fBhsY=;
        b=He4v7uL0awO9JuBT9k7PI1C6/+eVZhY9qArpczJHJH5756lW7zpIiixsg4nA2lfYes
         9UIxvG2mBfvyllBdnm9qZ1O7ExykaLGKJdBjVK+7NBJcjtuchnfUOJg0Ll6gy7jCuXlO
         U7AqbK51pxCmkKSnOYEaaPCYS/Gmmu/O+asaWzuZA++UktYmTZnFa4NIzm2QDDUZQqlG
         Lh8zAiU9lmPrShr7i2Aojuau6LaY7vS7oF1jUnfpzAQwajwjfaiBQgTWuWUiKOTrF2yA
         GYLcpuESmIWgTp8uVc0/nSWA6Rn21sGjSK/urI08MgrEhkh1v2hyvhRdHiGNtN5wNfPa
         +1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qRZot/DLMtNPxSFXIfQAOQcu5vHJvMFSfS4j/fBhsY=;
        b=E8RGDRHmBdGeDIUoI7v7GKv61oXFC9azdINSurM4xzhUujtFP9xCrp0lnZCHlRRNVx
         NNOJPUjvA7hDnPDTBbJC/yffABejs9LfaY7kG3qtSudkinM61T89xjmbCPzBIA0R7zn2
         PgsKz+LARAlyt67NcxBRm58eQD+IjZjRiRPLn6oTgK2bGy9J/gjW4lUCDSfsJigcqBXB
         n2M5TIDM33l/TS4h/LhwtCkThWaNKoImiuHJDrm+CQ8q0fLI/OSuzbsaIZ492Cd5qouz
         nscimm17JX3ycbp9un2sPaDyBG2x3qx+b5gzWD2T+ED+/kSQPrMbmdMgeTpO6Zrd/d8M
         ycRA==
X-Gm-Message-State: AOAM533wWmETUx16y+r3A3FlAr0s+vmfqbYWk0+oR8IjRElnQYw2W93z
        obZy8Sk9cvBdW+1s5QRLkzgFFZeoc8/MJf5X
X-Google-Smtp-Source: ABdhPJwKWSKwMpG3JPE73GDp8C130pEzPfH8gDaBXKsxf45TUHuEnAbcGBtw7nUvCMByD9oibyfyQA==
X-Received: by 2002:ac8:5f0c:0:b0:2cd:4ca2:2f73 with SMTP id x12-20020ac85f0c000000b002cd4ca22f73mr7200060qta.600.1645196618105;
        Fri, 18 Feb 2022 07:03:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z17sm25486037qta.11.2022.02.18.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/8] btrfs: track compressed bio errors as blk_status_t
Date:   Fri, 18 Feb 2022 10:03:26 -0500
Message-Id: <05f3b58ae6cfaca328c1065371a0116670598718.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now we just have a binary "errors" flag, so any error we get on
the compressed bio's gets translated to EIO.  This isn't necessarily a
bad thing, but if we get an ENOMEM it may be nice to know that's what
happened instead of an EIO.  Track our errors as a blk_status_t, and do
the appropriate setting of the errors accordingly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 28 +++++++++++++++-------------
 fs/btrfs/compression.h |  2 +-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0112fba345d4..747920ce1c17 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -219,7 +219,7 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb, struct bio *b
 		bi_size += bvec->bv_len;
 
 	if (bio->bi_status)
-		cb->errors = 1;
+		cb->status = bio->bi_status;
 
 	ASSERT(bi_size && bi_size <= cb->compressed_len);
 	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
@@ -247,8 +247,9 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	}
 
 	/* Do io completion on the original bio */
-	if (cb->errors) {
-		bio_io_error(cb->orig_bio);
+	if (cb->status != BLK_STS_OK) {
+		cb->orig_bio->bi_status = cb->status;
+		bio_endio(cb->orig_bio);
 	} else {
 		struct bio_vec *bvec;
 		struct bvec_iter_all iter_all;
@@ -306,7 +307,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	 * Some IO in this cb have failed, just skip checksum as there
 	 * is no way it could be correct.
 	 */
-	if (cb->errors == 1)
+	if (cb->status != BLK_STS_OK)
 		goto csum_failed;
 
 	inode = cb->inode;
@@ -322,7 +323,7 @@ static void end_compressed_bio_read(struct bio *bio)
 
 csum_failed:
 	if (ret)
-		cb->errors = 1;
+		cb->status = errno_to_blk_status(ret);
 	finish_compressed_bio_read(cb);
 out:
 	bio_put(bio);
@@ -340,11 +341,12 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct page *pages[16];
 	unsigned long nr_pages = end_index - index + 1;
+	int errno = blk_status_to_errno(cb->status);
 	int i;
 	int ret;
 
-	if (cb->errors)
-		mapping_set_error(inode->i_mapping, -EIO);
+	if (errno)
+		mapping_set_error(inode->i_mapping, errno);
 
 	while (nr_pages > 0) {
 		ret = find_get_pages_contig(inode->i_mapping, index,
@@ -356,7 +358,7 @@ static noinline void end_compressed_writeback(struct inode *inode,
 			continue;
 		}
 		for (i = 0; i < ret; i++) {
-			if (cb->errors)
+			if (errno)
 				SetPageError(pages[i]);
 			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
 							 cb->start, cb->len);
@@ -377,9 +379,9 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
 	 * Ok, we're the last bio for this extent, step one is to call back
 	 * into the FS and do all the end_io operations.
 	 */
-	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
-			cb->start, cb->start + cb->len - 1,
-			!cb->errors);
+	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL, cb->start,
+					     cb->start + cb->len - 1,
+					     cb->status == BLK_STS_OK);
 
 	end_compressed_writeback(inode, cb);
 	/* Note, our inode could be gone now */
@@ -522,7 +524,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	if (!cb)
 		return BLK_STS_RESOURCE;
 	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
-	cb->errors = 0;
+	cb->status = BLK_STS_OK;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
 	cb->len = len;
@@ -829,7 +831,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto out;
 
 	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
-	cb->errors = 0;
+	cb->status = BLK_STS_OK;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
 	sums = cb->sums;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 7dbd14caab01..c224c67f8c5e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -55,7 +55,7 @@ struct compressed_bio {
 	u8 compress_type;
 
 	/* IO errors */
-	u8 errors;
+	blk_status_t status;
 	int mirror_num;
 
 	/* for reads, this is the bio we are copying the data into */
-- 
2.26.3

