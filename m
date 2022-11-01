Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71F6152CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKAUML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKAUMJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621681E3CF
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 169C91F38A;
        Tue,  1 Nov 2022 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXzNaV9XGZCYp4eHqCGoh5E9LwnNnGRqFYIJ0Tw8j70=;
        b=uJ07xq1Yi+XCXZK73wNnMME2H9CC6Y2Le3hfTfWnNiebWQFAgjpz98hNlJBT6znXPURg+5
        TPInfMWM4eqQr3OT9qW+JVFFfi5GxB1gHDsD/xH4Vs2Mbi5az04FU5czc9mGTBBdKHq8zd
        7XAeBq5po2RSluGYDzDryTYJYM3V3Ow=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0F5512C141;
        Tue,  1 Nov 2022 20:12:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5998DDA79D; Tue,  1 Nov 2022 21:11:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/40] btrfs: simplify btree_submit_bio_start and btrfs_submit_bio_start parameters
Date:   Tue,  1 Nov 2022 21:11:49 +0100
Message-Id: <5f4b7a11669006529515316bececcddbdf513534.1667331828.git.dsterba@suse.com>
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

After previous patches the unused parameters can be removed from
btree_submit_bio_start and btrfs_submit_bio_start as they don't need to
conform to the extent_submit_bio_start_t typedef.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  3 +--
 fs/btrfs/disk-io.c     | 11 +++--------
 fs/btrfs/disk-io.h     |  3 +--
 fs/btrfs/inode.c       |  3 +--
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 72cf235b7beb..54bf002e0013 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -415,8 +415,7 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
-blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-				    u64 dio_file_offset);
+blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
 blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f2d5677a9e6f..6ae9d63036ce 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -639,18 +639,14 @@ static void run_one_async_start(struct btrfs_work *work)
 	async = container_of(work, struct  async_submit_bio, work);
 	switch (async->submit_cmd) {
 	case WQ_SUBMIT_METADATA:
-		ret = btree_submit_bio_start(async->inode, async->bio,
-					     async->dio_file_offset);
+		ret = btree_submit_bio_start(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_submit_bio_start(async->inode, async->bio,
-					     async->dio_file_offset);
-
+		ret = btrfs_submit_bio_start(async->inode, async->bio);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
 		ret = btrfs_submit_bio_start_direct_io(async->inode, async->bio,
 						       async->dio_file_offset);
-
 		break;
 	}
 	if (ret)
@@ -749,8 +745,7 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	return errno_to_blk_status(ret);
 }
 
-blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-				    u64 dio_file_offset)
+blk_status_t btree_submit_bio_start(struct bio *bio)
 {
 	/*
 	 * when we're called for a write, we're already in the async
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5998b2589830..d5b25fa8037b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -122,8 +122,7 @@ enum btrfs_wq_submit_cmd {
 
 bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
-blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-				    u64 dio_file_offset);
+blk_status_t btree_submit_bio_start(struct bio *bio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 962e39b4f7cb..2a61b610e02b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2550,8 +2550,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
  * At IO completion time the cums attached on the ordered extent record
  * are inserted into the btree
  */
-blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-				    u64 dio_file_offset)
+blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
 {
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
-- 
2.37.3

