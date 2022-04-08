Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECED4F8EAB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiDHFK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiDHFK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:10:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF423AFBA
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EcHhm2abOChfcl0CZG6d0X1WuFDgHEJdUhCPvog3kWw=; b=cPy08R9cRAtb3mnIX3HTiTH1jE
        O3ABmqfOaWx6NiyY2yqZOtDAyvD7xP1DzA3GEycT8bhRR7tyso9O9h73SiBgArmsFCGcdyFqP1oYY
        NmGisPg93bpZpZzD6DsgikVToAl6Xt6NKFX6qcoVthaeKEHhedLHjpDlEy/v0Jlshw0fsaoOEJaFa
        o/QK8zSHljl3fyeHrcSzaUCr15rU4NFGEDnTGR8H8RIo6X7zAOCjC7Cu2/VUo7qmYT/jqiBvTPiB2
        yTzJWXI0s8delyqKAAo6U34fx0qFBM/NN4qUtu6tKWi1fRMZDhccqIjVZQsRs4GGOJokNA2SQv52+
        /dzANOGQ==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrZ-00F13i-GO; Fri, 08 Apr 2022 05:08:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: split submit_bio from btrfsic checking
Date:   Fri,  8 Apr 2022 07:08:29 +0200
Message-Id: <20220408050839.239113-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
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

Require a separate call to the integrity checking helpers from the
actual bio submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c | 14 +-------------
 fs/btrfs/check-integrity.h |  8 ++++----
 fs/btrfs/disk-io.c         |  6 ++++--
 fs/btrfs/extent_io.c       |  3 ++-
 fs/btrfs/scrub.c           | 12 ++++++++----
 fs/btrfs/volumes.c         |  3 ++-
 6 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index ec8a73ff82717..9efd33b4e24d7 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2701,7 +2701,7 @@ static void btrfsic_check_flush_bio(struct bio *bio,
 	}
 }
 
-static void __btrfsic_submit_bio(struct bio *bio)
+void btrfsic_check_bio(struct bio *bio)
 {
 	struct btrfsic_dev_state *dev_state;
 
@@ -2723,18 +2723,6 @@ static void __btrfsic_submit_bio(struct bio *bio)
 	mutex_unlock(&btrfsic_mutex);
 }
 
-void btrfsic_submit_bio(struct bio *bio)
-{
-	__btrfsic_submit_bio(bio);
-	submit_bio(bio);
-}
-
-int btrfsic_submit_bio_wait(struct bio *bio)
-{
-	__btrfsic_submit_bio(bio);
-	return submit_bio_wait(bio);
-}
-
 int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		  struct btrfs_fs_devices *fs_devices,
 		  int including_extent_data, u32 print_mask)
diff --git a/fs/btrfs/check-integrity.h b/fs/btrfs/check-integrity.h
index bcc730a06cb58..ed115e0f2ebbd 100644
--- a/fs/btrfs/check-integrity.h
+++ b/fs/btrfs/check-integrity.h
@@ -7,11 +7,11 @@
 #define BTRFS_CHECK_INTEGRITY_H
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-void btrfsic_submit_bio(struct bio *bio);
-int btrfsic_submit_bio_wait(struct bio *bio);
+void btrfsic_check_bio(struct bio *bio);
 #else
-#define btrfsic_submit_bio submit_bio
-#define btrfsic_submit_bio_wait submit_bio_wait
+static inline void btrfsic_check_bio(struct bio *bio)
+{
+}
 #endif
 
 int btrfsic_mount(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dfec67e8a78c7..2bc867d353087 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4167,7 +4167,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			bio->bi_opf |= REQ_FUA;
 
-		btrfsic_submit_bio(bio);
+		btrfsic_check_bio(bio);
+		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
 			errors++;
@@ -4280,7 +4281,8 @@ static void write_dev_flush(struct btrfs_device *device)
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
 
-	btrfsic_submit_bio(bio);
+	btrfsic_check_bio(bio);
+	submit_bio(bio);
 	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4bcc182744e48..9d5bc6598489b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2368,7 +2368,8 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 	bio_add_page(bio, page, length, pg_offset);
 
-	if (btrfsic_submit_bio_wait(bio)) {
+	btrfsic_check_bio(bio);
+	if (submit_bio_wait(bio)) {
 		/* try to remap that extent elsewhere? */
 		btrfs_bio_counter_dec(fs_info);
 		bio_put(bio);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5c979f7411937..a4f9cfdec8b60 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1475,7 +1475,8 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		bio->bi_iter.bi_sector = sector->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
-		if (btrfsic_submit_bio_wait(bio)) {
+		btrfsic_check_bio(bio);
+		if (submit_bio_wait(bio)) {
 			sector->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
@@ -1559,7 +1560,8 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		if (btrfsic_submit_bio_wait(bio)) {
+		btrfsic_check_bio(bio);
+		if (submit_bio_wait(bio)) {
 			btrfs_dev_stat_inc_and_print(sector_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
@@ -1715,7 +1717,8 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * orders the requests before sending them to the driver which
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
-	btrfsic_submit_bio(sbio->bio);
+	btrfsic_check_bio(sbio->bio);
+	submit_bio(sbio->bio);
 
 	if (btrfs_is_zoned(sctx->fs_info))
 		sctx->write_pointer = sbio->physical + sbio->sector_count *
@@ -2049,7 +2052,8 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	sbio = sctx->bios[sctx->curr];
 	sctx->curr = -1;
 	scrub_pending_bio_inc(sctx);
-	btrfsic_submit_bio(sbio->bio);
+	btrfsic_check_bio(sbio->bio);
+	submit_bio(sbio->bio);
 }
 
 static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 26ada24890a5a..6b49d78d15029 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6742,7 +6742,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
-	btrfsic_submit_bio(bio);
+	btrfsic_check_bio(bio);
+	submit_bio(bio);
 }
 
 static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logical)
-- 
2.30.2

