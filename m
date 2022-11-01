Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F786152F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKAUN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKAUNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805FE02
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 290BC1F88E;
        Tue,  1 Nov 2022 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmdRF7tpbLjKMOVF1y6lDJGbqBrmnBg6QatJft1t8cA=;
        b=JtTYDQO4o5P0fE9fX+rBYtkn7ZglDdsk0817LWNCN8YzvN4kxT++E5EqaK9fNfVzO3S3b3
        gBoylxJxGahbUajwi+R/2MjYyIYvNL5CQbsyLaWdIoxKZQOgeIDh+sQkFbQ2xtuLRc8Csq
        eqgNXt/Kkb8BMw37IddJGB2TTlO5KD0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F6D72C141;
        Tue,  1 Nov 2022 20:13:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F837DA79D; Tue,  1 Nov 2022 21:13:04 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 39/40] btrfs: use btrfs_inode inside btrfs_verify_data_csum
Date:   Tue,  1 Nov 2022 21:13:04 +0100
Message-Id: <3eebcce1819b94a1a521783e2c81b413fa5333e5.1667331829.git.dsterba@suse.com>
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

The function is mostly using internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c55ffb856ae7..9d4e97eb5651 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3529,10 +3529,10 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end)
 {
-	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	const u32 sectorsize = root->fs_info->sectorsize;
 	u32 pg_off;
 	unsigned int result = 0;
@@ -3545,7 +3545,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 	if (bbio->csum == NULL)
 		return 0;
 
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+	if (inode->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
 	if (unlikely(test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)))
@@ -3569,7 +3569,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = btrfs_check_data_csum(BTRFS_I(inode), bbio, bio_offset, page, pg_off);
+		ret = btrfs_check_data_csum(inode, bbio, bio_offset, page, pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
 				     root->fs_info->sectorsize_bits;
-- 
2.37.3

