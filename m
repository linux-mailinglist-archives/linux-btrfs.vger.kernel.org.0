Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5E6152F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiKAUNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKAUNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEEA1DA7A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84B66336C4;
        Tue,  1 Nov 2022 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FyF/l6X8cUmNBuY+INSZXNf7M3vBC33N0cuO2F/1+A=;
        b=aSqjcapu/qHZT1sBVXYjqlF27jf53vd4SltpzMaB91aeK2C3LXa/7sV9zxlN/iYYuz8Xz2
        76OxFJYTpXo5ZP7PoovX7eBJmavagJ5SucyNsmPtKXmov2YONxF/GEj8vV7gdFHrAOdF9U
        ckIsE8J8c025kxaoRCKSiCse7OYiz/s=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E1742C141;
        Tue,  1 Nov 2022 20:13:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE2EFDA79D; Tue,  1 Nov 2022 21:12:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 35/40] btrfs: pass btrfs_inode to inode_tree_add
Date:   Tue,  1 Nov 2022 21:12:55 +0100
Message-Id: <20ff613412776f61153cafd763715f55f120242c.1667331829.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4b4e360ce878..c08c8d616eb2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5679,16 +5679,16 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	return err;
 }
 
-static void inode_tree_add(struct inode *inode)
+static void inode_tree_add(struct btrfs_inode *inode)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_inode *entry;
 	struct rb_node **p;
 	struct rb_node *parent;
-	struct rb_node *new = &BTRFS_I(inode)->rb_node;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	struct rb_node *new = &inode->rb_node;
+	u64 ino = btrfs_ino(inode);
 
-	if (inode_unhashed(inode))
+	if (inode_unhashed(&inode->vfs_inode))
 		return;
 	parent = NULL;
 	spin_lock(&root->inode_lock);
@@ -5800,7 +5800,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 
 		ret = btrfs_read_locked_inode(inode, path);
 		if (!ret) {
-			inode_tree_add(inode);
+			inode_tree_add(BTRFS_I(inode));
 			unlock_new_inode(inode);
 		} else {
 			iget_failed(inode);
@@ -6567,7 +6567,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	inode_tree_add(inode);
+	inode_tree_add(BTRFS_I(inode));
 
 	trace_btrfs_inode_new(inode);
 	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
-- 
2.37.3

