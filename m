Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4E6152D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKAUMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKAUMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10AB1D30A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7BBBA336C4;
        Tue,  1 Nov 2022 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBecMNgl5yesEGJcdkt9oBACt3ZwKCLholzF37VtZtg=;
        b=m3BRssfWBvF1gbzQ4ETRdmWCTXG1NjjUM03ZbmQHjp6lQdzT5zpV6JltEIm7dfFSZ8QmVh
        pwJAnazBrZQ8+8a4s/fz4J9o87dgBHLLEz8RvW69rTfyJtcN1b7vpno+0ZkYDrfZTJ5ngq
        dlwqYIQY3uoPi9uikrd9VYDWYchbEaE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 744892C141;
        Tue,  1 Nov 2022 20:12:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC88ADA79D; Tue,  1 Nov 2022 21:11:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/40] btrfs: pass btrfs_inode to btrfs_submit_bio_start_direct_io
Date:   Tue,  1 Nov 2022 21:11:55 +0100
Message-Id: <95180f3a98ceb8f2a6ab7e57dbb9fc254bf6d6af.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
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
 fs/btrfs/btrfs_inode.h | 2 +-
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/inode.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4ec6a74dd6ba..a41d4f953bfa 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -416,7 +416,7 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
 blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
-blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
+blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6319df271cff..49c2beb72d21 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -645,7 +645,7 @@ static void run_one_async_start(struct btrfs_work *work)
 		ret = btrfs_submit_bio_start(async->inode, async->bio);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_submit_bio_start_direct_io(&async->inode->vfs_inode,
+		ret = btrfs_submit_bio_start_direct_io(async->inode,
 				async->bio, async->dio_file_offset);
 		break;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa27c8b990cf..2c786075196a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7964,11 +7964,11 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	return err;
 }
 
-blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
+blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
+	return btrfs_csum_one_bio(inode, bio, dio_file_offset, false);
 }
 
 static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
-- 
2.37.3

