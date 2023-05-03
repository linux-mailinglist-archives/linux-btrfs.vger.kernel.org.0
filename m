Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6F6F5093
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjECHG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjECHGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:06:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC33C11
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jj35ohtDs9SXoCNYZ3zaN3XBSzFhEjYYggLE2AF1Vdo=; b=XaK2LXJap3qdQP9QxbpOKe66uA
        ByLgyhrDD0AVUfdmqSo3RXDg52t41lyvNO/8FH9eyPysMla3HuI8Owu4Hoy4Y8pHgZ97qduyjN0ij
        LDq6pRRbfneeNXkyAGdD+MoeVnKAj+iobOvZHmA/LAssGrGsZ5nUE0nsV9Dky1mFrho1LuDm51jM9
        auDirtDGT9EOCx6XIOAiLc/SiQI6PwPB6zh/IVUKUBzw0sApd21mX23ODK29Ma1jhbH2AZhlYBiHt
        AiQemln02Y/jYwRS2m6PDP3+IULVHNSzB9WYcmncU31KMJLICUByX8r4dVYUpzBgrjXI0UrLEsKV2
        roCPqnfA==;
Received: from 213-225-6-169.nat.highway.a1.net ([213.225.6.169] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pu6ZC-003aCq-2Z;
        Wed, 03 May 2023 07:06:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: never defer I/O submission for fast CRC implementations
Date:   Wed,  3 May 2023 09:06:13 +0200
Message-Id: <20230503070615.1029820-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503070615.1029820-1-hch@lst.de>
References: <20230503070615.1029820-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most modern hardware supports very fast accelerated crc32c calculation.
If that is supported the CPU overhead of the checksum calculation is
very limited, and offloading the calculation to special worker threads
has a lot of overhead for no gain.

E.g. on an Intel Optane device is actually very much slows down even
1M buffered writes with fio:

Unpatched:

write: IOPS=3316, BW=3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone resets

With synchronous CRCs:

write: IOPS=4882, BW=4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone resets

With a lot of variation during the unpatch run going down as low as
1100MB/s, while the synchronous CRC version has about the same peak write
speed but much lower dips, and fewer kworkers churning around.
Both tests had fio saturated at 100% CPU.

(thanks to Jens Axboe via Chris Mason for the benchmarking)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/bio.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4b5220509186a8..e8a55605ce22fa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -574,6 +574,12 @@ static void run_one_async_free(struct btrfs_work *work)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	/*
+	 * Submit synchronously if the checksum implementation is fast.
+	 */
+	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+		return false;
+
 	/*
 	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
 	 * then try to defer the submission to a workqueue to parallelize the
@@ -583,18 +589,10 @@ static bool should_async_write(struct btrfs_bio *bbio)
 		return false;
 
 	/*
-	 * Submit metadata writes synchronously if the checksum implementation
-	 * is fast, or we are on a zoned device that wants I/O to be submitted
-	 * in order.
+	 * Zoned devices require I/O to be submitted in order.
 	 */
-	if (bbio->bio.bi_opf & REQ_META) {
-		struct btrfs_fs_info *fs_info = bbio->fs_info;
-
-		if (btrfs_is_zoned(fs_info))
-			return false;
-		if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-			return false;
-	}
+	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(bbio->fs_info))
+		return false;
 
 	return true;
 }
-- 
2.39.2

