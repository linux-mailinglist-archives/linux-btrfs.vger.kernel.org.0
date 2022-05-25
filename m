Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6320533B22
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiEYK7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbiEYK7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C725F8C1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61A0421A5F
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lm9WBl34ztj0R/xZ2prryd94Y+yF2kPIhQLLlnJnBMs=;
        b=akVgOuzdw9ZRZe3e/ijAuJJjz8S4EXNY93gvu/t6cjvjGJ5KXaNhp7/ymJdehTryAL6BMr
        YuYqRmlpBikqp4qlTfCzkshVVPM6fqiZuKstSdNO35kb2lzyYWOeRLvLZgRIznHa/CUq6b
        4iSPJXlZcWYAsEf5EENbQT52c8wuZpE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B218613ADF
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wMSdHiAMjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs: make direct io read path to use the new read repair infrastructure
Date:   Wed, 25 May 2022 18:59:16 +0800
Message-Id: <9d71475db36ef39574fb1015a3f6a9d37db980db.1653476251.git.wqu@suse.com>
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

By doing this, we can also remove the function submit_dio_repair_bio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 51 +++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dd0882e1b982..26718ec1e07b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "read-repair.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -7863,58 +7864,42 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
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
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_read_repair_ctrl ctrl = {0};
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	blk_status_t err = BLK_STS_OK;
 	struct bvec_iter iter;
 	struct bio_vec bv;
+	int ret;
 	u32 offset;
 
 	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
 		u64 start = bbio->file_offset + offset;
 
-		if (uptodate &&
-		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
-				bv.bv_offset, start))) {
-			clean_io_failure(fs_info, failure_tree, io_tree, start,
-					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
-					 bv.bv_offset);
-		} else {
-			int ret;
-
-			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
-					bv.bv_page, bv.bv_offset, start,
-					bbio->mirror_num,
-					submit_dio_repair_bio);
+		if (!uptodate ||
+		    (csum && check_data_csum(inode, bbio, offset, bv.bv_page,
+					     bv.bv_offset, start))) {
+			u64 logical = (bbio->iter.bi_sector << SECTOR_SHIFT) +
+				      offset;
+			u8 *csum = NULL;
+
+			if (bbio->csum)
+				csum = btrfs_csum_ptr(fs_info, bbio->csum, offset);
+			ret = btrfs_read_repair_add_sector(inode, &ctrl,
+					bv.bv_page, bv.bv_offset, logical,
+					start, csum, bbio->mirror_num, true);
 			if (ret)
 				err = errno_to_blk_status(ret);
 		}
 	}
-
+	ret = btrfs_read_repair_finish(&ctrl);
+	if (ret)
+		err = errno_to_blk_status(ret);
 	return err;
 }
 
-- 
2.36.1

