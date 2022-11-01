Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303D6152F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKAUNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKAUNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4C1D667
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 638C31F88E;
        Tue,  1 Nov 2022 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnaYfwT5WEyjkAga8MVQFTWnoRSY1/dHy1KdvOXWAxo=;
        b=dgr1oj8TVYqZJ6shI9rZSTDpgskQxkIzQjGXP9/hDG8j4pG8HUi2QHplEPPCr7xGTnPQX8
        rB3eZxXMPIMPuum0Yy5S1jFS/SkbkAL2x0BvSFbEMPQfpCaV2QO4ijPFvPzExHBlX6MNE8
        Q21Z5OIkJo0LR/tCiubWiC4Yby0w2aY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5D9942C141;
        Tue,  1 Nov 2022 20:13:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADDF7DA79D; Tue,  1 Nov 2022 21:12:53 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 34/40] btrfs: pass btrfs_inode to fixup_tree_root_location
Date:   Tue,  1 Nov 2022 21:12:53 +0100
Message-Id: <52e237f8cbb6b69dec743c4795939ef96fef74d7.1667331829.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0489c3df44c3..4b4e360ce878 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5613,7 +5613,7 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
  * is kind of like crossing a mount point.
  */
 static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
-				    struct inode *dir,
+				    struct btrfs_inode *dir,
 				    struct dentry *dentry,
 				    struct btrfs_key *location,
 				    struct btrfs_root **sub_root)
@@ -5627,7 +5627,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	int err = 0;
 	struct fscrypt_name fname;
 
-	ret = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
+	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
 	if (ret)
 		return ret;
 
@@ -5638,7 +5638,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	}
 
 	err = -ENOENT;
-	key.objectid = BTRFS_I(dir)->root->root_key.objectid;
+	key.objectid = dir->root->root_key.objectid;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = location->objectid;
 
@@ -5651,7 +5651,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 
 	leaf = path->nodes[0];
 	ref = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_root_ref);
-	if (btrfs_root_ref_dirid(leaf, ref) != btrfs_ino(BTRFS_I(dir)) ||
+	if (btrfs_root_ref_dirid(leaf, ref) != btrfs_ino(dir) ||
 	    btrfs_root_ref_name_len(leaf, ref) != fname.disk_name.len)
 		goto out;
 
@@ -5901,7 +5901,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return inode;
 	}
 
-	ret = fixup_tree_root_location(fs_info, dir, dentry,
+	ret = fixup_tree_root_location(fs_info, BTRFS_I(dir), dentry,
 				       &location, &sub_root);
 	if (ret < 0) {
 		if (ret != -ENOENT)
-- 
2.37.3

