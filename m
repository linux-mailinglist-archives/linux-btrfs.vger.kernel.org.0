Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9903C6152D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKAUMW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKAUMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F91D30A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9252D1F8BA;
        Tue,  1 Nov 2022 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVF5wIM+2MiHyWXjM4dVO1pTOtGhTyq6uThnPvuc2D4=;
        b=A9SkGgJIszkYcNzwEDqb9NpK+ce4pwe7pufc7QSMozB442POu6fSn0E9+WKUjCFAvZyNiQ
        40TZ/QpYm0I2fV6uVhqTikQnIKUfrLupuSP+n9w2K9C7NuAyiOO1ZqW/PutTDJQ+yQGlUW
        qlOmI8C8yQ8lUeWSG1RNHarRwON331Q=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8AB0F2C141;
        Tue,  1 Nov 2022 20:12:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DACE3DA79D; Tue,  1 Nov 2022 21:11:57 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/40] btrfs: pass btrfs_inode to btrfs_wq_submit_bio
Date:   Tue,  1 Nov 2022 21:11:57 +0100
Message-Id: <7965cfc05410fbf52933428b59988118a3469534.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/disk-io.c | 8 ++++----
 fs/btrfs/disk-io.h | 2 +-
 fs/btrfs/inode.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 49c2beb72d21..ced90987127b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -698,17 +698,17 @@ static void run_one_async_free(struct btrfs_work *work)
  * - true if the work has been succesfuly submitted
  * - false in case of error
  */
-bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
+bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd)
 {
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct async_submit_bio *async;
 
 	async = kmalloc(sizeof(*async), GFP_NOFS);
 	if (!async)
 		return false;
 
-	async->inode = BTRFS_I(inode);
+	async->inode = inode;
 	async->bio = bio;
 	async->mirror_num = mirror_num;
 	async->submit_cmd = cmd;
@@ -784,7 +784,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	 * happen in parallel across all CPUs.
 	 */
 	if (should_async_write(fs_info, BTRFS_I(inode)) &&
-	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_METADATA))
+	    btrfs_wq_submit_bio(BTRFS_I(inode), bio, mirror_num, 0, WQ_SUBMIT_METADATA))
 		return;
 
 	ret = btree_csum_one_bio(bio);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index d5b25fa8037b..65cf976b74e8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -120,7 +120,7 @@ enum btrfs_wq_submit_cmd {
 	WQ_SUBMIT_DATA_DIO,
 };
 
-bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
+bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
 blk_status_t btree_submit_bio_start(struct bio *bio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2c786075196a..c05b5639337a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2757,7 +2757,7 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
 	    !btrfs_is_data_reloc_root(bi->root)) {
 		if (!atomic_read(&bi->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_DATA))
+		    btrfs_wq_submit_bio(bi, bio, mirror_num, 0, WQ_SUBMIT_DATA))
 			return;
 
 		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
@@ -8013,7 +8013,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		/* Check btrfs_submit_data_write_bio() for async submit rules */
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
+		    btrfs_wq_submit_bio(BTRFS_I(inode), bio, 0, file_offset,
 					WQ_SUBMIT_DATA_DIO))
 			return;
 
-- 
2.37.3

