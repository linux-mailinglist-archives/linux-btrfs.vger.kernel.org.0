Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855426152CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKAUMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKAUMF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3E1C91F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C33EF336C4;
        Tue,  1 Nov 2022 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcB1MmLinUdF65JWgPl9pY1dzyyFDJThiWRg4yH9e+w=;
        b=qBYwfglH+MIu8ORRPUksPkBhC4Azs3Na2ON6Iw0hGhRnc54PZ++eaHskEKU5se/pNlgV7t
        6t/ifxxH5W+9oKCPVUnWplOagWoyiU3fTHyYuCeSuM6CDSyydvxzleRMrjbZ8F4+w/tYhw
        IJbFzcXqvq4NUQr8evWSNwD8TUxSvJA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB2E72C141;
        Tue,  1 Nov 2022 20:12:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0ED73DA79D; Tue,  1 Nov 2022 21:11:45 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/40] btrfs: drop parameter compression_type from btrfs_submit_dio_repair_bio
Date:   Tue,  1 Nov 2022 21:11:44 +0100
Message-Id: <8497018e5dfef721a98a0679d9e643eaef76fa19.1667331828.git.dsterba@suse.com>
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

Compression and direct io don't work together so the compression
parameter can be dropped after previous patch that changed the call
to direct.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 4 +---
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/inode.c       | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index fa0c72cabd8f..62019d7c1cbd 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -414,9 +414,7 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num,
-				 enum btrfs_compression_type compress_type);
+void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 44ff41304247..cc05ae772fa5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -863,7 +863,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	if (submit_buffered)
 		btrfs_submit_data_read_bio(inode, repair_bio, failrec->this_mirror, 0);
 	else
-		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror, 0);
+		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror);
 
 	return BLK_STS_OK;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9aa805bbe55..da9d3a8e2d93 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7922,9 +7922,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num,
-				 enum btrfs_compression_type compress_type)
+void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num)
 {
 	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-- 
2.37.3

