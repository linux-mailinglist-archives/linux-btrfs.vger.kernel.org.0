Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231E69C1C8
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Feb 2023 19:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBSSKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Feb 2023 13:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjBSSKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Feb 2023 13:10:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC013D7F
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2qlaGnak/dycCfSjOBLHPxxNUbXekj7S2M04q7eyKF0=; b=R42RnkRMNfA54HzzvxqrmfslNL
        uXGPK80wHoKikhH8mIPRiObEWjxoFUqYwYacbbqYAJq91VhKoPwyf2kBoUTY8A+tIkkDqAFwOJB87
        AoCk2WAbqJr1SS0xJLxmovRr357Wfg1q68HIE7FkIp1grcqff/KOt2SQtu3kKFEQgoYRGMXt0Wn4v
        DM5V1augMJbshhmcUvKcmIQpVIth+JQX5zjQ80INku0PVtEmKgmdQRrHK4WKOqzJgVTdgKpBvMeQL
        IQzVHTQ2GLJo2PoNnR4pEQeQZzmikqCYGKS2R5JTxkqvV6HrVDDt9RtdOG/ExkxD5euNuK1ip05i9
        JK5DVn0Q==;
Received: from [2001:4bb8:180:e4a2:2f09:db6a:5f2b:c813] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTo8q-0025qk-7b; Sun, 19 Feb 2023 18:10:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move all btree initialization into btrfs_init_btree_inode
Date:   Sun, 19 Feb 2023 19:10:22 +0100
Message-Id: <20230219181022.3499088-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the remaining code that deals with initializing the btree
inode into btrfs_init_btree_inode instead of splitting it between
that helpers and its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b53f0e30ce2b3b..981973b40b065a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2125,11 +2125,16 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
 	atomic_set(&fs_info->reloc_cancel_req, 0);
 }
 
-static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
+static int btrfs_init_btree_inode(struct super_block *sb)
 {
-	struct inode *inode = fs_info->btree_inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	unsigned long hash = btrfs_inode_hash(BTRFS_BTREE_INODE_OBJECTID,
 					      fs_info->tree_root);
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
 
 	inode->i_ino = BTRFS_BTREE_INODE_OBJECTID;
 	set_nlink(inode, 1);
@@ -2140,6 +2145,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	 */
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &btree_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
@@ -2152,6 +2158,8 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	BTRFS_I(inode)->location.offset = 0;
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
+	fs_info->btree_inode = inode;
+	return 0;
 }
 
 static void btrfs_init_dev_replace_locks(struct btrfs_fs_info *fs_info)
@@ -3351,13 +3359,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail;
 	}
 
-	fs_info->btree_inode = new_inode(sb);
-	if (!fs_info->btree_inode) {
-		err = -ENOMEM;
+	err = btrfs_init_btree_inode(sb);
+	if (err)
 		goto fail;
-	}
-	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
-	btrfs_init_btree_inode(fs_info);
 
 	invalidate_bdev(fs_devices->latest_dev->bdev);
 
-- 
2.39.1

