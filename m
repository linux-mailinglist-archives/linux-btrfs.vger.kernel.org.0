Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD304D7E31
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiCNJJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiCNJJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E56E13F27
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:07:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 675AE210F5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lzlNVeeKUQwsSd54mjnD03kooKk8RuZH+v+EhswnSk=;
        b=GJ9bSkGPT/0QsPC704RR2MjdFgCU6M18+NxM6YSRB/3yhO7fV3GVwFUpxxx1izjHHPMskN
        2wgVypy8WFtk5iC/iTzbQqlc81mFoCupHpGz06UmHRUp2+KQyFzNGoYI+JDDVBBxvp5zKa
        1jzgj/mhPBz1xbpIshaI/U++vXEVvnQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B016713ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMljHugFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 03/18] btrfs: use correct bio size for error message in btrfs_end_dio_bio()
Date:   Mon, 14 Mar 2022 17:07:16 +0800
Message-Id: <1db2f7469f0304e897eacd2f9f9237d2e80f5d49.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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

At endio time, bio->bi_iter is no longer valid (there are some cases
they are still valid, but never ensured).

Thus if we really want to get the full size of bio, we have to iterate
them.

In btrfs_end_dio_bio() when we hit error, we would grab bio size from
bi_iter which can be wrong.

Fix it by iterating the bvecs and calculate the bio size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dded46291637..dbcb4ae9e06d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7866,12 +7866,19 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	struct btrfs_dio_private *dip = bio->bi_private;
 	blk_status_t err = bio->bi_status;
 
-	if (err)
+	if (err) {
+		struct bvec_iter_all iter_all;
+		struct bio_vec *bvec;
+		u32 bi_size = 0;
+
+		bio_for_each_segment_all(bvec, bio, iter_all)
+			bi_size += bvec->bv_len;
+
 		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
 			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
 			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
-			   bio->bi_opf, bio->bi_iter.bi_sector,
-			   bio->bi_iter.bi_size, err);
+			   bio->bi_opf, bio->bi_iter.bi_sector, bi_size, err);
+	}
 
 	if (bio_op(bio) == REQ_OP_READ)
 		err = btrfs_check_read_dio_bio(dip, btrfs_bio(bio), !err);
-- 
2.35.1

