Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF366152CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKAUMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKAUMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989321D0D8
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 59F7C1F38A;
        Tue,  1 Nov 2022 20:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxRRvxgHKSSrzGgO+EQ9XQoL2su/Lq2/oougbC22goM=;
        b=Plz5a9xgtFhWvwIx0FKErgKrbcF7vgs6CoWZ16E1UVwAl6tuZ3LtIm0HFTMykSmGUoTdYi
        erM/0qpe2/Us/GlhmjkHZb14ShFsYeom5Nbzk9PWWNUN7vnPDX8DQVq0t/Azhsqct/4v9b
        ryH2FBSPlqIgOfJ+8+zColvwwLDW5/E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5056C2C141;
        Tue,  1 Nov 2022 20:12:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9A485DA79D; Tue,  1 Nov 2022 21:11:53 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/40] btrfs: pass btrfs_inode to btrfs_submit_bio_start
Date:   Tue,  1 Nov 2022 21:11:53 +0100
Message-Id: <c9c11ed69ffea7e4123ae3cbeecc158d7398836e.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/btrfs_inode.h | 2 +-
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/inode.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 54bf002e0013..4ec6a74dd6ba 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -415,7 +415,7 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
-blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
+blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
 blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 51e98e0997d5..6319df271cff 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -642,7 +642,7 @@ static void run_one_async_start(struct btrfs_work *work)
 		ret = btree_submit_bio_start(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_submit_bio_start(&async->inode->vfs_inode, async->bio);
+		ret = btrfs_submit_bio_start(async->inode, async->bio);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
 		ret = btrfs_submit_bio_start_direct_io(&async->inode->vfs_inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b7cc5cfcf220..aa27c8b990cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2550,9 +2550,9 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
  * At IO completion time the cums attached on the ordered extent record
  * are inserted into the btree
  */
-blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio)
+blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
+	return btrfs_csum_one_bio(inode, bio, (u64)-1, false);
 }
 
 /*
-- 
2.37.3

