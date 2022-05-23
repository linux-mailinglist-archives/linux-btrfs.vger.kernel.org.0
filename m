Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E828530744
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351963AbiEWBtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiEWBtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 21:49:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13D13FB9
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 18:49:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30A121F747
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653270540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCY+VONq8xSUQeK4+wxpaaAIupzWV9FtxCGTj37Df4Y=;
        b=prxufstzJG/ueTtWCDmn9jQUEcWOXLQmgMKmgXxkQrDYSJI+XnbIbbZleuzrvSTmcRROWa
        FW4sy8LBAnJK0aZ04miSshwVgaWHqqui5hwLFY6Q3mTvj3jVsOKrBbew2lnmAjCknVKWwo
        lUnW2Hrt6G5a/vgSvBG6w6BAWLd6gGI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 804C913ADF
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cFxEEgvoimLzOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: use the new read repair code for direct I/O
Date:   Mon, 23 May 2022 09:48:30 +0800
Message-Id: <cc97f85ceb603c81f4080b0834ca2477399fc55e.1653270323.git.wqu@suse.com>
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

Just convert the btrfs_repair_one_sector() call to
btrfs_read_repair_sector().

And we can remove the dio specific repair helper now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dd0882e1b982..2d52a19e02cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "read-repair.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -7863,23 +7864,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num,
-				  enum btrfs_compression_type compress_type)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
-		return;
-
-	refcount_inc(&dip->refs);
-	if (btrfs_map_bio(fs_info, bio, mirror_num))
-		refcount_dec(&dip->refs);
-}
-
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
@@ -7904,12 +7888,21 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
 					 bv.bv_offset);
 		} else {
+			u8 *csum_expected = NULL;
+			const u64 logical = (bbio->iter.bi_sector <<
+					     SECTOR_SHIFT) + offset;
+			int num_copies;
 			int ret;
 
-			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
-					bv.bv_page, bv.bv_offset, start,
-					bbio->mirror_num,
-					submit_dio_repair_bio);
+			if (bbio->csum)
+				csum_expected = btrfs_csum_ptr(fs_info,
+						bbio->csum, offset);
+			num_copies = btrfs_num_copies(fs_info, logical,
+						      fs_info->sectorsize);
+
+			ret = btrfs_read_repair_sector(inode, bv.bv_page,
+					bv.bv_offset, logical, start,
+					bbio->mirror_num, num_copies, csum_expected);
 			if (ret)
 				err = errno_to_blk_status(ret);
 		}
-- 
2.36.1

