Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B376152DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKAUMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKAUMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CDD1D667
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C85551F8BA;
        Tue,  1 Nov 2022 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AU94Dru1WtanFkrgjk9BPj4OLQ6Jao7C3qN7QOtL8k=;
        b=U1lMAyXFxUD/t+k74cVp6SHv55hO+JqbhV/FTNFIKb5JQ9uJZns6mpRxBYZUKbksc/zace
        bZrwO7x+O+FnegoW+F70EaXhuUJZv3usvgDvRWfq2MkCP7HXNLem9RM/4Ty/WquxYA85jC
        yfkLom5iyz0Tpp0e0BvMQQLRHf94DoI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C217D2C141;
        Tue,  1 Nov 2022 20:12:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13A55DA79D; Tue,  1 Nov 2022 21:12:15 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 16/40] btrfs: pass btrfs_inode to btrfs_submit_dio_bio
Date:   Tue,  1 Nov 2022 21:12:15 +0100
Message-Id: <3090019ccac6b91244281756ab5d58ca183ada17.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 652335c0c930..dbe55974eb82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7994,10 +7994,10 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	btrfs_dio_private_put(dip);
 }
 
-static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
+static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 				 u64 file_offset, int async_submit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	blk_status_t ret;
 
@@ -8005,13 +8005,13 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 	if (btrfs_op(bio) == BTRFS_MAP_READ)
 		btrfs_bio(bio)->iter = bio->bi_iter;
 
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+	if (inode->flags & BTRFS_INODE_NODATASUM)
 		goto map;
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		/* Check btrfs_submit_data_write_bio() for async submit rules */
-		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
-		    btrfs_wq_submit_bio(BTRFS_I(inode), bio, 0, file_offset,
+		if (async_submit && !atomic_read(&inode->sync_writers) &&
+		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
 					WQ_SUBMIT_DATA_DIO))
 			return;
 
@@ -8019,7 +8019,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
+		ret = btrfs_csum_one_bio(inode, bio, file_offset, false);
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
@@ -8141,7 +8141,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 				async_submit = 1;
 		}
 
-		btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
+		btrfs_submit_dio_bio(bio, BTRFS_I(inode), file_offset, async_submit);
 
 		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
-- 
2.37.3

