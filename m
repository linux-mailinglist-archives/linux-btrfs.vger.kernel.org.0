Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D846152D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKAUM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKAUMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC4C1D0F3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2F1591F38A;
        Tue,  1 Nov 2022 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPSprNBqKPYGuobEPK51FCDs/0ufdIX9uZd0X47QqIo=;
        b=WKc9/CVGkW7p6d6fKt3/e1Y+fVyy5kVazGi0AQQGc8H/T3xC04kotE2Zr9T7hvCjonyXxM
        9FaMVBW2IrdUdhMbKSB87QfzZnaCg+v8l7/etpLx6lJguY1hZSSoYU3DZnKVjvjN4+7B90
        Fi/TyMTbZuvnlPr7aLfa9FvgwGhAmFk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 282A62C141;
        Tue,  1 Nov 2022 20:12:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78388DA79D; Tue,  1 Nov 2022 21:12:06 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 12/40] btrfs: pass btrfs_inode to btrfs_submit_dio_repair_bio
Date:   Tue,  1 Nov 2022 21:12:06 +0100
Message-Id: <03a642d47fc5546547f6b6e0774a4f752789e620.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/extent_io.c   | 3 ++-
 fs/btrfs/inode.c       | 5 ++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5406a2f817b2..9fe1a11a2eb3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -414,7 +414,7 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
+void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
 blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac69e5f1605c..bddda397e438 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -864,7 +864,8 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		btrfs_submit_data_read_bio(BTRFS_I(inode), repair_bio,
 					   failrec->this_mirror, 0);
 	else
-		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror);
+		btrfs_submit_dio_repair_bio(BTRFS_I(inode), repair_bio,
+					    failrec->this_mirror);
 
 	return BLK_STS_OK;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 06ae712be423..477d4db2d14e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7919,15 +7919,14 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num)
+void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
 	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
 	refcount_inc(&dip->refs);
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
-- 
2.37.3

