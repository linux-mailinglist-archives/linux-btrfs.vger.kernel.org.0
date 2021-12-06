Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878F3468F21
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhLFCde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51840 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhLFCda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 778C41FD5F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJ5vZF1+Ea6krFc0na9UXeiRAV8wrbBoYaiSjMXBdIE=;
        b=qWcIhmEf2yTjlB7d3apjIo4Lvvv2wNLiqTGelsCHxFASzOvku9EnlHugXXIrI3MryZMOrH
        CjuROWHDGaRmDR1KY7EyzmyIV4ksowQdjJd2xEqXqVjpNyM5Te8WUueJweDIHNyFi6gPqf
        85ul09DAl7l8vpBF3p9JXF7aBI8JOf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8ABA13451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SLgrJKh1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/17] btrfs: use correct bio size for error message in btrfs_end_dio_bio()
Date:   Mon,  6 Dec 2021 10:29:23 +0800
Message-Id: <20211206022937.26465-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 6079d30f83e8..126d2117954c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8175,12 +8175,19 @@ static void btrfs_end_dio_bio(struct bio *bio)
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
2.34.1

