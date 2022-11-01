Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD206152D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKAUMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKAUMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803811D0F3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B7C51F8C2;
        Tue,  1 Nov 2022 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdzaauaub73lnCkTsF8h75vVD67ZceM5Sm4O1G5Wxkw=;
        b=J9Avrtrj9afZ1/apJGEKlsllfHiH6CBfe9/X+Lbq8pGyNzcjGyqx9YD3Q6YJocSsZEygit
        t8dOl3TlkJhw8wX1Zl2LquvZixhKYxgDp+wMfPIMKBmCUniqPg0ZMvZj9ruRftgfthpmrr
        XaWLdJsryFgfouxJAPITDafQQf5AiQw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 059BB2C141;
        Tue,  1 Nov 2022 20:12:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55EBCDA79D; Tue,  1 Nov 2022 21:12:04 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/40] btrfs: pass btrfs_inode to btrfs_submit_data_read_bio
Date:   Tue,  1 Nov 2022 21:12:04 +0100
Message-Id: <b25213a72daa608c25b46a06eec1ca1d5dcec0f1.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/extent_io.c   | 5 +++--
 fs/btrfs/inode.c       | 8 ++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 01fc62d39ed2..5406a2f817b2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -412,7 +412,7 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
-void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
 blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fba51be32d..ac69e5f1605c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -138,7 +138,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 		btrfs_submit_data_write_bio(BTRFS_I(inode), bio, mirror_num);
 	else
-		btrfs_submit_data_read_bio(inode, bio, mirror_num,
+		btrfs_submit_data_read_bio(BTRFS_I(inode), bio, mirror_num,
 					   bio_ctrl->compress_type);
 
 	/* The bio is owned by the end_io handler now */
@@ -861,7 +861,8 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 * error here.
 	 */
 	if (submit_buffered)
-		btrfs_submit_data_read_bio(inode, repair_bio, failrec->this_mirror, 0);
+		btrfs_submit_data_read_bio(BTRFS_I(inode), repair_bio,
+					   failrec->this_mirror, 0);
 	else
 		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f10eb3430756..06ae712be423 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2768,10 +2768,10 @@ void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
-void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	blk_status_t ret;
 
 	if (compress_type != BTRFS_COMPRESS_NONE) {
@@ -2779,7 +2779,7 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 		 * btrfs_submit_compressed_read will handle completing the bio
 		 * if there were any errors, so just return here.
 		 */
-		btrfs_submit_compressed_read(inode, bio, mirror_num);
+		btrfs_submit_compressed_read(&inode->vfs_inode, bio, mirror_num);
 		return;
 	}
 
@@ -2790,7 +2790,7 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
 	 */
-	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+	ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
 	if (ret) {
 		btrfs_bio_end_io(btrfs_bio(bio), ret);
 		return;
-- 
2.37.3

