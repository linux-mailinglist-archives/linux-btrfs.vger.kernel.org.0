Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A06152F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKAUNU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKAUNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EB1E3D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A527F336C4;
        Tue,  1 Nov 2022 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/4OUtkS6s8R3r0cmDziPnqdrWyX7lQBrP+ZA+yHpdM=;
        b=FW/Mmlt4d7YmOflXx/1IcgpM30qnmcsG3i9n6hdhp+Za0jRVa+cosm3Z3OKVgB9nbKupaM
        rskG3kGnTd+e0OeL9tDP3s1ufepBTjhZ8wC+qVB9PDJBOlrMDL7v0DetkyLyonK5jlYbOA
        G1RFFH0yn0sCLeT/DhUpWKgGdcn0u/o=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9E53B2C141;
        Tue,  1 Nov 2022 20:13:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE76ADA79D; Tue,  1 Nov 2022 21:12:57 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 36/40] btrfs: pass btrfs_inode to btrfs_inherit_iflags
Date:   Tue,  1 Nov 2022 21:12:57 +0100
Message-Id: <d0321cc2fe74f606dd498832ece594d64c912d83.1667331829.git.dsterba@suse.com>
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
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c08c8d616eb2..cb284388896c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6344,27 +6344,27 @@ void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args)
  *
  * Currently only the compression flags and the cow flags are inherited.
  */
-static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
+static void btrfs_inherit_iflags(struct btrfs_inode *inode, struct btrfs_inode *dir)
 {
 	unsigned int flags;
 
-	flags = BTRFS_I(dir)->flags;
+	flags = dir->flags;
 
 	if (flags & BTRFS_INODE_NOCOMPRESS) {
-		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
-		BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
+		inode->flags &= ~BTRFS_INODE_COMPRESS;
+		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (flags & BTRFS_INODE_COMPRESS) {
-		BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
-		BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;
+		inode->flags &= ~BTRFS_INODE_NOCOMPRESS;
+		inode->flags |= BTRFS_INODE_COMPRESS;
 	}
 
 	if (flags & BTRFS_INODE_NODATACOW) {
-		BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW;
-		if (S_ISREG(inode->i_mode))
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
+		inode->flags |= BTRFS_INODE_NODATACOW;
+		if (S_ISREG(inode->vfs_inode.i_mode))
+			inode->flags |= BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
 }
 
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
@@ -6423,7 +6423,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	 * change it now without compatibility issues.
 	 */
 	if (!args->subvol)
-		btrfs_inherit_iflags(inode, dir);
+		btrfs_inherit_iflags(BTRFS_I(inode), BTRFS_I(dir));
 
 	if (S_ISREG(inode->i_mode)) {
 		if (btrfs_test_opt(fs_info, NODATASUM))
-- 
2.37.3

