Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFE7AAFA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjIVKhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjIVKhn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F35AC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91318C433CB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379056;
        bh=KVX9zKgXOgOqLlkcwI+VMVJu3EmQ6tHatj73+xJNW7E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a1Kdl90kKfyyFoxECKTMl70dE4QvThxqkTUNjDJQgPCyy/smTo8qXS3XfbqsiMDDY
         1Px/3goIKQBJ7EGsbkf4kx6CUbY6+fFIY/OfvpAIbtWGlcDG9Y0qpjZx6mdTcJJM35
         rK5ZePJEipIfgrTRUJICLGCKpW+qRov1l14d9txb75fFW/IWWljaoiP6Sn94PIpuAp
         dya9OGBw+uSLvjoSfiMD3bqnCFIIrQpcv2vnxHjgsQ/huoRBT6eI+JaohxHA+DYgn9
         yK1WdDgCXddjxndXLFKvEIsKXtHwNKKf3rYPDdpJg+ldFu5DgUwSkeItc3fIJaQ64g
         Wmn3obcX1mlZQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: remove redundant root argument from btrfs_delayed_update_inode()
Date:   Fri, 22 Sep 2023 11:37:24 +0100
Message-Id: <38eb656f778e10215d4b52a1bbb3401025b9110e.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument for btrfs_delayed_update_inode() always matches the root
of the given inode, so remove the root argument and get it from the inode
argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/delayed-inode.h | 1 -
 fs/btrfs/inode.c         | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 8ba045ae1d75..35d7616615c1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1913,9 +1913,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 }
 
 int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
 			       struct btrfs_inode *inode)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_delayed_node *delayed_node;
 	int ret = 0;
 
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index dc1085b2a397..d050e572c7f9 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -135,7 +135,6 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode);
 
 
 int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
 			       struct btrfs_inode *inode);
 int btrfs_fill_inode(struct inode *inode, u32 *rdev);
 int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4b5d4047c5d..54647b7fb600 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4019,7 +4019,7 @@ int btrfs_update_inode(struct btrfs_trans_handle *trans,
 	    && !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
 		btrfs_update_root_times(trans, root);
 
-		ret = btrfs_delayed_update_inode(trans, root, inode);
+		ret = btrfs_delayed_update_inode(trans, inode);
 		if (!ret)
 			btrfs_set_inode_last_trans(trans, inode);
 		return ret;
-- 
2.40.1

