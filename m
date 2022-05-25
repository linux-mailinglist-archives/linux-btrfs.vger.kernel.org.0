Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892E533B24
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiEYK7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiEYK7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4960BAF
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C82121A5E
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHjekY4AMs5aaFQWuDYtU6PCS6lx+UZosvsGLH6pqp0=;
        b=tXxkIr4fs1dn2Zs50WbAaSKpVFHrUOqGRowbCOSRmgLLOcDZ3T9YOhRXLXYzZ+SEXBU6p3
        DF0cJRswNCXrCmEVwdu0Y5xg1MvVsGJIQRSjRD48U3DbpkA3i3GlL3vaHnlwlnLZga0y/A
        EDPu55Vx7S4C/euMNxczfW7dUPlNndU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E1D713ADF
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2IuvGR8MjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs: make buffered read path to use the new read repair infrastructure
Date:   Wed, 25 May 2022 18:59:15 +0800
Message-Id: <9d5aa449b6e26247b3ad8437b3a948913f427cba.1653476251.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653476251.git.wqu@suse.com>
References: <cover.1653476251.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only need to prepare the logical bytenr and file offset of the
corrupted sector, and pass it to btrfs_read_repair_add_sector().

And call btrfs_read_repair_finish() before we free the csum.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 160dedb078fd..c14699b5758b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -30,6 +30,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "compression.h"
+#include "read-repair.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -2749,13 +2750,15 @@ void end_sector_io(struct page *page, u64 offset, bool uptodate)
 			offset + sectorsize - 1, &cached);
 }
 
-static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
+static void submit_data_read_repair(struct inode *inode,
+		struct btrfs_read_repair_ctrl *ctrl, struct bio *failed_bio,
 		u32 bio_offset, const struct bio_vec *bvec, int failed_mirror,
 		unsigned int error_bitmap)
 {
 	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page *page = bvec->bv_page;
+	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
 	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
 	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
@@ -2780,7 +2783,9 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	for (i = 0; i < nr_bits; i++) {
 		const unsigned int offset = i * sectorsize;
 		bool uptodate = false;
-		int ret;
+		u64 logical = (failed_bbio->iter.bi_sector << SECTOR_SHIFT) +
+			      bio_offset + offset;
+		u8 *csum = NULL;
 
 		if (!(error_bitmap & (1U << i))) {
 			/*
@@ -2788,28 +2793,17 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 			 * and unlock the range.
 			 */
 			uptodate = true;
-			goto next;
-		}
-
-		ret = btrfs_repair_one_sector(inode, failed_bio,
-				bio_offset + offset,
-				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
-		if (!ret) {
-			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
-			 */
+			end_sector_io(page, start + offset, uptodate);
 			continue;
 		}
-		/*
-		 * Continue on failed repair, otherwise the remaining sectors
-		 * will not be properly unlocked.
-		 */
-next:
-		end_sector_io(page, start + offset, uptodate);
+		if (failed_bbio->csum)
+			csum = btrfs_csum_ptr(fs_info, failed_bbio->csum,
+					      bio_offset + offset);
+
+		/* The function will release the page if hit failure. */
+		btrfs_read_repair_add_sector(inode, ctrl, page, pgoff + offset,
+					     logical, start + offset, csum,
+					     failed_mirror, false);
 	}
 }
 
@@ -3017,6 +3011,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
+	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
@@ -3126,8 +3121,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
+			submit_data_read_repair(inode, &ctrl, bio, bio_offset,
+						bvec, mirror, error_bitmap);
 		} else {
 			/* Update page status and unlock */
 			end_page_read(page, uptodate, start, len);
@@ -3142,6 +3137,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
+	btrfs_read_repair_finish(&ctrl);
 	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
-- 
2.36.1

