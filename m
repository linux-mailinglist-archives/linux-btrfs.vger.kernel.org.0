Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415F6530743
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351953AbiEWBtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351959AbiEWBtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 21:49:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED51400C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 18:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1ACF921990
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653270539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IX2WtLF82B1yKV5W+OeEN74Js3KaNlxvPclxswB5HIQ=;
        b=G4ZRyl9jbwZe00oiXkheLGc6eE1sOVRt+Jsh3tj2ek1r/NKQhKYsfiDcTjxtSzYd+fWuvD
        sqOn6FjRfaOGE8qRkAV5MRycVlwaM5EhJle0dvaspkxZ5j6aD9Q0/gtuWcim3sZ9uPFnqB
        XtL+AIXgH83WYCO9N3aAFzdb122YjMc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F23BF13ADF
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wO8hLgnoimLzOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: use the new read repair code for buffered reads
Date:   Mon, 23 May 2022 09:48:29 +0800
Message-Id: <fd4b85fcfaee593638818f9dd5f216d4e8b3d73e.1653270322.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653270322.git.wqu@suse.com>
References: <cover.1653270322.git.wqu@suse.com>
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

Just call the new btrfs_read_repair_sector() to replace the old
btrfs_repair_one_sector().

And since the new helper only handles the page content, the caller still
needs to handle the page status update and unlock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1083d6cfa858..cf32b2ff0568 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -30,6 +30,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "compression.h"
+#include "read-repair.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -2756,10 +2757,13 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page *page = bvec->bv_page;
+	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
+	const u64 bio_logical = failed_bbio->iter.bi_sector << SECTOR_SHIFT;
 	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
 	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
+	int num_copies;
 	int i;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2776,10 +2780,13 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 	 */
 	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
 
+	num_copies = btrfs_num_copies(fs_info, bio_logical, fs_info->sectorsize);
+
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
 		const unsigned int offset = i * sectorsize;
 		bool uptodate = false;
+		u8 *expected_csum = NULL;
 		int ret;
 
 		if (!(error_bitmap & (1U << i))) {
@@ -2791,22 +2798,19 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 			goto next;
 		}
 
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
-			continue;
-		}
+		if (failed_bbio->csum)
+			expected_csum = btrfs_csum_ptr(fs_info,
+					failed_bbio->csum, bio_offset + offset);
+
+		ret = btrfs_read_repair_sector(inode, page, pgoff + offset,
+				bio_logical + bio_offset + offset,
+				start + offset, failed_bbio->mirror_num,
+				num_copies, expected_csum);
+		if (!ret)
+			uptodate = true;
 		/*
-		 * Continue on failed repair, otherwise the remaining sectors
-		 * will not be properly unlocked.
+		 * If above repair failed, we have tried all mirrors, time to
+		 * release the corrupted sector.
 		 */
 next:
 		end_sector_io(page, start + offset, uptodate);
-- 
2.36.1

