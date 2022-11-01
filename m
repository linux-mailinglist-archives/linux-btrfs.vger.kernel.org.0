Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98986152D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKAUMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKAUMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DC1DF34
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B66A51F8C2;
        Tue,  1 Nov 2022 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2/5GX8SEtCPrMWScYF+uV97ZwmvFgt3IBXaiF5lsog=;
        b=dYjbkBeHxsxI8bJgIf/QIusqJWjJxKgDLU3AGzbexDtIVyP2LCziUB6LjccjtSrL72Cbr2
        XhHykfeA24R8zYUcjNfNP60HevNiDfuUplwdPGmoNzUyc/6LT+buZFGPkPOeMb18LgNquv
        XMFrWzueNPWJuiq393qwEGU+k1Rcq8g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AEF172C141;
        Tue,  1 Nov 2022 20:12:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B222DA79D; Tue,  1 Nov 2022 21:12:00 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/40] btrfs: pass btrfs_inode to btrfs_submit_metadata_bio
Date:   Tue,  1 Nov 2022 21:11:59 +0100
Message-Id: <761056d110d39612bd870386b0e0538494ca0207.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/disk-io.c   | 8 ++++----
 fs/btrfs/disk-io.h   | 2 +-
 fs/btrfs/extent_io.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ced90987127b..c86513e70ff3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -766,9 +766,9 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
 	return true;
 }
 
-void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num)
+void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
@@ -783,8 +783,8 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	 * Kthread helpers are used to submit writes so that checksumming can
 	 * happen in parallel across all CPUs.
 	 */
-	if (should_async_write(fs_info, BTRFS_I(inode)) &&
-	    btrfs_wq_submit_bio(BTRFS_I(inode), bio, mirror_num, 0, WQ_SUBMIT_METADATA))
+	if (should_async_write(fs_info, inode) &&
+	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_METADATA))
 		return;
 
 	ret = btree_csum_one_bio(bio);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 65cf976b74e8..f2c507fd0e04 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -86,7 +86,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
-void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num);
+void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cc05ae772fa5..e770cbc5cb6a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -134,7 +134,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
 	if (!is_data_inode(inode))
-		btrfs_submit_metadata_bio(inode, bio, mirror_num);
+		btrfs_submit_metadata_bio(BTRFS_I(inode), bio, mirror_num);
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 		btrfs_submit_data_write_bio(inode, bio, mirror_num);
 	else
-- 
2.37.3

