Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F65153BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379714AbiD2SfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380020AbiD2SfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F063692B3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 146FD1F892;
        Fri, 29 Apr 2022 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLQl1xx1rJL3qSYX87IVA/+KIvA+pstfAJ5DTQJS4aE=;
        b=MaMeiqTFzI0rdl/PzsPzyVpgVB2X+l98SGdtNSwzCSVlSmuTgqX+sUQwdwTW6Iws7W/Pw+
        i1/zG4QciKkpTlHgFzU/mOybBAaYzE/6n9X+HDFSgnEF0pBoYNXSf0ob0gPfC33BovG1hN
        rrC7ypkPNGoN09gO2ZSh8UVgb0IIvcM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0CBB52C141;
        Fri, 29 Apr 2022 18:31:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72970DA7DE; Fri, 29 Apr 2022 20:27:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/9] btrfs: remove unused parameter bio_flags from btrfs_wq_submit_bio
Date:   Fri, 29 Apr 2022 20:27:33 +0200
Message-Id: <6455730749fdad4022bb7138bd9108692a3697cb.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
References: <cover.1651255990.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 fs/btrfs/disk-io.h | 3 +--
 fs/btrfs/inode.c   | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 73e12ecc81be..b9e03da5f2cb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -849,8 +849,7 @@ static void run_one_async_free(struct btrfs_work *work)
 }
 
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags,
-				 u64 dio_file_offset,
+				 int mirror_num, u64 dio_file_offset,
 				 extent_submit_bio_start_t *submit_bio_start)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
@@ -943,7 +942,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 		 * checksumming can happen in parallel across all CPUs
 		 */
 		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-					  0, btree_submit_bio_start);
+					  btree_submit_bio_start);
 	}
 
 	if (ret) {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9340e3266e0a..4ee8c42c9f78 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -124,8 +124,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags,
-				 u64 dio_file_offset,
+				 int mirror_num, u64 dio_file_offset,
 				 extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b7df1c0ee5e..ac37e5088fc8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2624,7 +2624,7 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		if (btrfs_is_data_reloc_root(root))
 			goto mapit;
 		/* we're doing a write, do the async checksumming */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
+		ret = btrfs_wq_submit_bio(inode, bio, mirror_num,
 					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
@@ -7913,7 +7913,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write && async_submit) {
-		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
+		ret = btrfs_wq_submit_bio(inode, bio, 0, file_offset,
 					  btrfs_submit_bio_start_direct_io);
 		goto err;
 	} else if (write) {
-- 
2.34.1

