Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCD517D9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiECGyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiECGx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509D5FC3
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 775021F749
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsBWRTtYf0FGjZDIOyXwm69IomvEgbbJnsFMKcTFSuQ=;
        b=GHY7nf4t/nPwbPe4jIV4RXinJamtf7Ghtg9NZ3LfVBrWxxlcVQU1FEdGLDuVefsMMe6FT/
        DTWtnIFfaCmKvJIfzTeB37AabWKDAKTOOV+4Ih/9T1c9qLzEwlq1EG5i6riwOMARbB2Z/+
        5iaqk1qO0zgi8aeveswE4JaSs0gSRYE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2E6F13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEqyLK7QcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/13] btrfs: allow btrfs read repair to submit writes in asynchronous mode
Date:   Tue,  3 May 2022 14:49:52 +0800
Message-Id: <ad68ea136896b9ceb6dfed3b42764746e9c0357a.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
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

Currently if we want to submit write for read time repair, we call
btrfs_repair_io_failure(), which will submit the bio and wait for it.

But for our newer btrfs_read_repair infrastructure , we want to submit
write bios and only wait for all of them to finish. Just like how we
handle the read bios.

This patch will get rid of the btrfs_repair_io_failure() call, replacing
it with the same bios handling, by try merging the sector into the bio
first, and if not mergeable then submit the current bio and allocate a
new one.

And finally submit the last bio, and wait for all write bios to finish.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/read-repair.c | 46 +++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index 3169f01e961b..aecdc4ee54ba 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -119,7 +119,6 @@ static void read_repair_submit_bio(struct btrfs_read_repair_ctrl *ctrl,
 	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
 	blk_status_t ret;
 
-	ASSERT(bio_op(&rbio->bio) == REQ_OP_READ);
 	ASSERT(rbio->bio.bi_private == ctrl);
 	ASSERT(rbio->bio.bi_end_io == read_repair_end_bio);
 	ASSERT(rbio->logical >= ctrl->logical &&
@@ -140,13 +139,22 @@ static void read_repair_submit_bio(struct btrfs_read_repair_ctrl *ctrl,
 /* Add a sector into the read repair bios list for later submission */
 static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 				       struct page *page, unsigned int pgoff,
-				       int sector_nr, int mirror)
+				       int sector_nr, int mirror,
+				       unsigned int opf)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
 	struct btrfs_read_repair_bio *rbio;
 	struct bio *bio;
 	int ret;
 
+	ASSERT(opf == REQ_OP_WRITE || opf == REQ_OP_READ);
+
+	/* For write, we need to handle zoned case first */
+	if (opf == REQ_OP_WRITE) {
+		if (btrfs_repair_one_zone(fs_info, ctrl->logical))
+			return;
+	}
+
 	/* Check if the sector can be added to the last bio */
 	if (ctrl->cur_bio) {
 		bio = ctrl->cur_bio;
@@ -162,10 +170,6 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 		 * just submit it.
 		 */
 		read_repair_submit_bio(ctrl, rbio, mirror);
-		if (ret) {
-			bio->bi_status = ret;
-			bio_endio(bio);
-		}
 		ctrl->cur_bio = NULL;
 	}
 	ASSERT(ctrl->cur_bio == NULL);
@@ -176,7 +180,7 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 
 	rbio = repair_bio(bio);
 	rbio->logical = ctrl->logical + (sector_nr << fs_info->sectorsize_bits);
-	bio->bi_opf = REQ_OP_READ;
+	bio->bi_opf = opf;
 	bio->bi_iter.bi_sector = rbio->logical >> SECTOR_SHIFT;
 	bio->bi_private = ctrl;
 	bio->bi_end_io = read_repair_end_bio;
@@ -190,6 +194,15 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	 */
 	ASSERT(ret == fs_info->sectorsize);
 	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
+
+	/* Output a meesage about we repaired a sector. */
+	btrfs_info_rl(fs_info,
+"read error corrected: root %lld ino %llu off %llu logical %llu from good mirror %d",
+		BTRFS_I(ctrl->inode)->root->root_key.objectid,
+		btrfs_ino(BTRFS_I(ctrl->inode)),
+		ctrl->file_offset + (sector_nr << fs_info->sectorsize_bits),
+		ctrl->logical + (sector_nr << fs_info->sectorsize_bits),
+		mirror);
 }
 
 static int get_prev_mirror(int cur_mirror, int num_copy)
@@ -243,11 +256,12 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 			continue;
 		/* Queue and submit bad sectors. */
 		read_repair_bio_add_sector(ctrl, bvec.bv_page, bvec.bv_offset,
-					   bit, mirror);
+					   bit, mirror, REQ_OP_READ);
 	}
 	/* Submit the last assembled bio and wait for all bios to finish. */
 	ASSERT(ctrl->cur_bio);
 	read_repair_submit_bio(ctrl, repair_bio(ctrl->cur_bio), mirror);
+	ctrl->cur_bio = NULL;
 	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 
 	/* Now re-verify the newly read out data */
@@ -256,8 +270,6 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 		struct btrfs_inode *binode = BTRFS_I(ctrl->inode);
 		const u64 file_offset = ctrl->file_offset +
 					(bit << fs_info->sectorsize_bits);
-		const u64 logical = ctrl->logical +
-				    (bit << fs_info->sectorsize_bits);
 		struct extent_state *cached = NULL;
 		u8 *csum = NULL;
 		int ret;
@@ -288,10 +300,10 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 		 * We repaired one sector, write the correct data back to the bad
 		 * mirror.
 		 */
-		btrfs_repair_io_failure(fs_info, btrfs_ino(binode), file_offset,
-					sectorsize, logical, bvec.bv_page,
-					bvec.bv_offset,
-					get_prev_mirror(mirror, ctrl->num_copies));
+		read_repair_bio_add_sector(ctrl, bvec.bv_page, bvec.bv_offset,
+					bit, get_prev_mirror(mirror,
+							     ctrl->num_copies),
+					REQ_OP_WRITE);
 
 		/* Update the page status and extent locks. */
 		btrfs_end_page_read(bvec.bv_page, true, file_offset, sectorsize);
@@ -302,6 +314,12 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 				file_offset, file_offset + sectorsize - 1,
 				&cached);
 	}
+	/* Submit the last write bio from above loop and wait for them. */
+	if (ctrl->cur_bio)
+		read_repair_submit_bio(ctrl, repair_bio(ctrl->cur_bio),
+				get_prev_mirror(mirror, ctrl->num_copies));
+	ctrl->cur_bio = NULL;
+	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 }
 
 void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
-- 
2.36.0

