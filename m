Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF74E203C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 06:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbiCUFu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 01:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiCUFu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 01:50:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937554505D
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Mar 2022 22:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 529CB1F37C
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 05:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647841742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ykbHIEnOxecO1jTcaygWdAJ9qDwI3ADRTt34/Dj+7q0=;
        b=KSByhbr7Y8PkOK8hXQblRaoKrZcbJ2Ywe/ztFNKG7XRbl1Xgo5yuhkwLIcaxgSLNZe7d0x
        gUEBKoqDJjYRtIIjW8Gu8Tch71xJ/1KU34YiAzDm5CXT7QiHORWfzcwQ3rjMUUNSV4T4Cz
        YLTPfpSSocqBIkS0FU0wG3lS1gLGJs8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E5FD13A04
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 05:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k1grGc0ROGI+fAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 05:49:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: submit_read_repair() cleanup
Date:   Mon, 21 Mar 2022 13:48:42 +0800
Message-Id: <9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

Cleanup the function submit_read_repair() by:

- Remove the fixed argument submit_bio_hook()
  The function is only called on buffered data read path, so the
  @submit_bio_hook argument is always btrfs_submit_data_bio().

  Since it's fixed, then there is no need to pass that argument at all.

- Rename the function to submit_data_read_repair()
  Just to be more explicit on all the 3 things, data, read and repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53b59944013f..b6f87abdbc51 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2716,12 +2716,13 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u32 bio_offset,
-				      struct page *page, unsigned int pgoff,
-				      u64 start, u64 end, int failed_mirror,
-				      unsigned int error_bitmap,
-				      submit_bio_hook_t *submit_bio_hook)
+static blk_status_t submit_data_read_repair(struct inode *inode,
+					    struct bio *failed_bio,
+					    u32 bio_offset, struct page *page,
+					    unsigned int pgoff,
+					    u64 start, u64 end,
+					    int failed_mirror,
+					    unsigned int error_bitmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u32 sectorsize = fs_info->sectorsize;
@@ -2731,6 +2732,9 @@ static blk_status_t submit_read_repair(struct inode *inode,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
+	/* This repair is only for data */
+	ASSERT(is_data_inode(inode));
+
 	/* We're here because we had some read errors or csum mismatch */
 	ASSERT(error_bitmap);
 
@@ -2759,7 +2763,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, submit_bio_hook);
+				failed_mirror, btrfs_submit_data_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
@@ -3077,13 +3081,13 @@ static void end_bio_extent_readpage(struct bio *bio)
 				goto readpage_ok;
 
 			/*
-			 * btrfs_submit_read_repair() will handle all the good
+			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_read_repair(inode, bio, bio_offset, page,
-					   start - page_offset(page), start,
-					   end, mirror, error_bitmap,
-					   btrfs_submit_data_bio);
+			submit_data_read_repair(inode, bio, bio_offset, page,
+						start - page_offset(page),
+						start, end, mirror,
+						error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
-- 
2.35.1

