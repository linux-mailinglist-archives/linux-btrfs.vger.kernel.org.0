Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31E6152CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKAUMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiKAUMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7876E1D667
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 37C191F8BA;
        Tue,  1 Nov 2022 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6sjSkskWBrqjBYeV2X4jwnBM128fFCSsxoCneh3hb8=;
        b=nH9Tllh246b+n3FU38qbmrtiMIjTZNY9+JpInyJtCCU+DfFRiWUrpbjjTgFWNrf4vV2VGx
        XwG+PDC4shmpzTGJjb2/iS0w3m23//jVAi7fV8EWAbcxF0oTdvqWY8LRQ+yO9/cZFHMq7y
        DQHZK+6pCYQ4fpbw2dqxTE2Ee0Wqfts=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 31C982C141;
        Tue,  1 Nov 2022 20:12:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A0D0DA79D; Tue,  1 Nov 2022 21:11:51 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/40] btrfs: switch async_submit_bio::inode to btrfs_inode
Date:   Tue,  1 Nov 2022 21:11:51 +0100
Message-Id: <675be97c9169d16010f6cd008a835e8f937777f6.1667331828.git.dsterba@suse.com>
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

The async bio submit is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 14 +++++++-------
 fs/btrfs/inode.c   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6ae9d63036ce..51e98e0997d5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -84,7 +84,7 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
  * just before they are sent down the IO stack.
  */
 struct async_submit_bio {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct bio *bio;
 	enum btrfs_wq_submit_cmd submit_cmd;
 	int mirror_num;
@@ -642,11 +642,11 @@ static void run_one_async_start(struct btrfs_work *work)
 		ret = btree_submit_bio_start(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_submit_bio_start(async->inode, async->bio);
+		ret = btrfs_submit_bio_start(&async->inode->vfs_inode, async->bio);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_submit_bio_start_direct_io(async->inode, async->bio,
-						       async->dio_file_offset);
+		ret = btrfs_submit_bio_start_direct_io(&async->inode->vfs_inode,
+				async->bio, async->dio_file_offset);
 		break;
 	}
 	if (ret)
@@ -665,7 +665,7 @@ static void run_one_async_done(struct btrfs_work *work)
 {
 	struct async_submit_bio *async =
 		container_of(work, struct  async_submit_bio, work);
-	struct inode *inode = async->inode;
+	struct btrfs_inode *inode = async->inode;
 	struct btrfs_bio *bbio = btrfs_bio(async->bio);
 
 	/* If an error occurred we just want to clean up the bio and move on */
@@ -680,7 +680,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	 * This changes nothing when cgroups aren't in use.
 	 */
 	async->bio->bi_opf |= REQ_CGROUP_PUNT;
-	btrfs_submit_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
+	btrfs_submit_bio(inode->root->fs_info, async->bio, async->mirror_num);
 }
 
 static void run_one_async_free(struct btrfs_work *work)
@@ -708,7 +708,7 @@ bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
 	if (!async)
 		return false;
 
-	async->inode = inode;
+	async->inode = BTRFS_I(inode);
 	async->bio = bio;
 	async->mirror_num = mirror_num;
 	async->submit_cmd = cmd;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2a61b610e02b..b7cc5cfcf220 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2550,7 +2550,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
  * At IO completion time the cums attached on the ordered extent record
  * are inserted into the btree
  */
-blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
+blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio)
 {
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
-- 
2.37.3

