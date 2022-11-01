Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F66152E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKAUMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKAUMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479F1D667
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88D4D1F8BA;
        Tue,  1 Nov 2022 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2R75UxAXCkqU9BXfu+gV9a90xY7/bS3fwZU/yInumU=;
        b=UOPX4O8gLS+4oZhc5sGvN9L1IhYCdJzIQtVqba9ytfTBCYR2F86MdX/nfGfpB+Q5THsvmt
        vVLmBGxWuyBe46aBh8bwgnGQ2Xw6EaD0xaaQs4PnYYEb+/G3hSAuaXN4djP2Fkc86rnLI2
        Uw30hXvquEyVLQosgWhvcb/OLMO38YU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 819772C141;
        Tue,  1 Nov 2022 20:12:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1A63DA79D; Tue,  1 Nov 2022 21:12:25 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 21/40] btrfs: pass btrfs_inode to btrfs_add_delalloc_inodes
Date:   Tue,  1 Nov 2022 21:12:25 +0100
Message-Id: <bd63c3074021dabc83fba49952a3635991b00bb6.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 754198b18d41..45c46043f5e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2369,16 +2369,14 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 }
 
 static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
-				      struct inode *inode)
+				      struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	spin_lock(&root->delalloc_lock);
-	if (list_empty(&BTRFS_I(inode)->delalloc_inodes)) {
-		list_add_tail(&BTRFS_I(inode)->delalloc_inodes,
-			      &root->delalloc_inodes);
-		set_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-			&BTRFS_I(inode)->runtime_flags);
+	if (list_empty(&inode->delalloc_inodes)) {
+		list_add_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
+		set_bit(BTRFS_INODE_IN_DELALLOC_LIST, &inode->runtime_flags);
 		root->nr_delalloc_inodes++;
 		if (root->nr_delalloc_inodes == 1) {
 			spin_lock(&fs_info->delalloc_root_lock);
@@ -2391,7 +2389,6 @@ static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
 	spin_unlock(&root->delalloc_lock);
 }
 
-
 void __btrfs_del_delalloc_inode(struct btrfs_root *root,
 				struct btrfs_inode *inode)
 {
@@ -2458,7 +2455,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			BTRFS_I(inode)->defrag_bytes += len;
 		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
 					 &BTRFS_I(inode)->runtime_flags))
-			btrfs_add_delalloc_inodes(root, inode);
+			btrfs_add_delalloc_inodes(root, BTRFS_I(inode));
 		spin_unlock(&BTRFS_I(inode)->lock);
 	}
 
-- 
2.37.3

