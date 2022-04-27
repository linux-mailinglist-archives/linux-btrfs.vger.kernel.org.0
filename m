Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04643511240
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358722AbiD0HWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiD0HWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91495EDEC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E203210FC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uue2dhj/0zlHRszxdkWuYL8E7W2NeyV+R5fbci4DaDk=;
        b=V8jZchJ1ai23Q3xqtLjqnCDC9CAIDoJN0E8aEhsxT+P4u7tlVLqV/x2839fG/bnLGuwxSp
        FdiyIwvO2pNoqIdtYOx4FhnX9YZ8/tP12GjCEQG0cSQkLDBYlWKDaSQk2YH0dfAmqfI/k4
        s/250RDUxGRuJUe5DmD/zEfopjXh73U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A350313A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gAEAGnruaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 06/12] btrfs: introduce a helper to repair from one mirror
Date:   Wed, 27 Apr 2022 15:18:52 +0800
Message-Id: <5fdd88193173faea05d6f67f8abe587454031d48.1651043617.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, read_repair_from_one_mirror(), will repair the data by:

- Assemble a bio list for all corrupted sectors
  During the procedure, we will try to merge as many sectors as possible
  into one bio.
  This behavior is different from the old behavior, which will submit
  each sector using a new bio.

  This will reduce unnecessary calls on bio submission hooks.

- Submit the bios in the read_bio_list and wait for them to finish
  Here we don't want to waste time on re-search the csum.
  So here we introduce a new flag, EXTENT_BIO_SKIPCSUM,
  for btrfs_submit_data_bio() to skip the csum lookup.

- Each successful read will clear the bit in ctrl::cur_bad_bitmap

- Verify each sector of the newly read data
  We have several different combinations:

  * The read failed for one sector
    We just keep the bit in @cur_bad_bitmap, and leave it for next
    mirror.

  * The read succeeded, and the original bio has no data checksum
    We consider this a win, clear the error bit and update the page
    status

  * The read succeeded, but csum still mismatches
    Leave the error bit for next mirror.

  * The read succeeded, and csum matches
    Clear the error bit and update the page status.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |   1 +
 fs/btrfs/inode.c     |   2 +-
 3 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fbed78ffe8e1..7db6800cba31 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2732,6 +2732,11 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
+static int get_prev_mirror(int cur_mirror, int num_copy)
+{
+	return (cur_mirror - 1 <= 0) ? (num_copy) : cur_mirror - 1;
+}
+
 static struct page *read_repair_get_sector(struct btrfs_read_repair_ctrl *ctrl,
 					   int sector_nr, unsigned int *pgoff)
 {
@@ -2836,6 +2841,118 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
 }
 
+static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
+					struct inode *inode, int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const int nbits = ctrl->bio_size >> fs_info->sectorsize_bits;
+	const u64 failed_logical = ctrl->failed_bio->bi_iter.bi_sector <<
+				   SECTOR_SHIFT;
+	const u32 sectorsize = fs_info->sectorsize;
+	struct bio *bio;
+	int bit;
+
+	/* We shouldn't have any pending read */
+	ASSERT(bio_list_size(&ctrl->read_bios) == 0 &&
+	       atomic_read(&ctrl->io_bytes) == 0);
+
+	/*
+	 * @cur_bad_bitmap contains the corrupted sectors, save it to
+	 * @prev_bad_bitmap.
+	 * Now @cur_bad_bitmap is our workspace bitmap.
+	 */
+	bitmap_copy(ctrl->prev_bad_bitmap, ctrl->cur_bad_bitmap, nbits);
+
+	/* Queue all bad sectors into our read_bios list */
+	for_each_set_bit(bit, ctrl->prev_bad_bitmap, nbits)
+		read_repair_bio_add_sector(ctrl, bit);
+
+	/* Submit all bios in read_bios and wait for them to finish */
+	for (bio = bio_list_pop(&ctrl->read_bios); bio;
+	     bio = bio_list_pop(&ctrl->read_bios)) {
+		blk_status_t ret;
+
+		btrfs_bio(bio)->iter = bio->bi_iter;
+
+		ASSERT(bio_op(bio) == REQ_OP_READ);
+		ASSERT(bio->bi_private == ctrl);
+		ASSERT(bio->bi_end_io == read_repair_end_bio);
+
+		/*
+		 * Our endio is super atomic, and we don't want to waste time on
+		 * lookup data csum. So here we just call btrfs_map_bio()
+		 * directly.
+		 */
+		ret = btrfs_map_bio(fs_info, bio, mirror);
+		if (ret) {
+			bio->bi_status = ret;
+			bio_endio(bio);
+		}
+	}
+	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
+
+	/* Now re-verify the newly read out data */
+	for_each_set_bit(bit, ctrl->prev_bad_bitmap, nbits) {
+		struct extent_state *cached = NULL;
+		const u64 logical = failed_logical +
+				    (bit << fs_info->sectorsize_bits);
+		const u64 file_offset = ctrl->file_offset +
+					(bit << fs_info->sectorsize_bits);
+		struct page *page;
+		u8 *csum = NULL;
+		int pgoff;
+		int ret;
+
+		/*
+		 * We didn't get a successful read for this sector, keep the
+		 * bad sector for next mirror.
+		 */
+		if (test_bit(bit, ctrl->cur_bad_bitmap))
+			continue;
+
+		if (btrfs_bio(ctrl->failed_bio)->csum)
+			csum = btrfs_bio(ctrl->failed_bio)->csum +
+				bit * fs_info->csum_size;
+
+		page = read_repair_get_sector(ctrl, bit, &pgoff);
+		/*
+		 * No csum, and endio function has cleared the error bit, the data
+		 * is good now.
+		 */
+		if (!csum)
+			goto uptodate;
+
+		ret = btrfs_check_data_sector(fs_info, page, pgoff, csum);
+		/*
+		 * We got a good read, but contents still mismatch, keep the
+		 * bad sector for next mirror.
+		 */
+		if (ret) {
+			set_bit(bit, ctrl->cur_bad_bitmap);
+			continue;
+		}
+uptodate:
+		clear_bit(bit, ctrl->cur_bad_bitmap);
+		/*
+		 * We repaired one sector, write the correct data back
+		 * to the bad mirror. Note that this function do the
+		 * write synchronously, and can be optimized later.
+		 */
+		repair_io_failure(fs_info, btrfs_ino(BTRFS_I(inode)),
+			file_offset, sectorsize, logical, page, pgoff,
+			get_prev_mirror(mirror, ctrl->num_copies));
+
+		/* Also update the page status */
+		end_page_read(page, true, file_offset, sectorsize);
+		set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+				file_offset, file_offset + sectorsize - 1,
+				&cached, GFP_ATOMIC);
+		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+				file_offset, file_offset + sectorsize - 1,
+				&cached);
+	}
+}
+
 static int read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
 				  struct bio *failed_bio, u32 bio_offset)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4904229ee73a..8b2ccbb2813e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -15,6 +15,7 @@
  * type for this bio
  */
 #define EXTENT_BIO_COMPRESSED 1
+#define EXTENT_BIO_SKIPCSUM   2
 #define EXTENT_BIO_FLAG_SHIFT 16
 
 enum {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1b596de0c4e9..355e559358a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2609,7 +2609,7 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			btrfs_submit_compressed_read(inode, bio, mirror_num,
 						     bio_flags);
 			return;
-		} else {
+		} else if (!(bio_flags & EXTENT_BIO_SKIPCSUM)) {
 			/*
 			 * Lookup bio sums does extra checks around whether we
 			 * need to csum or not, which is why we ignore skip_sum
-- 
2.36.0

