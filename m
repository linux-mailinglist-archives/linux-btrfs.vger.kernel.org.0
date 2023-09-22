Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A527AAFA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjIVKhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjIVKhn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F2CC0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBAAC433CC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379055;
        bh=yt4UElT14Y9oW2SjVl0E8mfNhIf+J8qCKetMf5ye69g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Znv/fj45vHHZtTKefxA9YQ+SEJO/gJsjEC8gCzf3FL7OUPmDonAWGErRIusTGBUkQ
         ZttaEbayzG2IuBVWoO3o2xYJN9TMTaNNczbgtMAEGiHnC7jXoHqrG0SJbMUl4SaCze
         Q2RLfvAJczvwmCu4bHONvmFW3mgFyE5nPMvKF0ScmAzXohmp2UdwJzil8sQsVICtwN
         D9L5UCo5zJ5gqRzkr0S8EW9bMmBD4RF5kwElVMDwhaN7pBFxbR2+8EbBuW6qjsFneg
         FuF6M4zDUjrc++5vT4SZXmqb5VxTbZQAL+5HRozt8NbtRQoRVIr2gm4SeLiDRavJNZ
         qurthb+m9HZjg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: remove redundant root argument from btrfs_update_inode_item()
Date:   Fri, 22 Sep 2023 11:37:23 +0100
Message-Id: <4472470053d1a06d99e80292f6a2fe06d6f40041.1695333082.git.fdmanana@suse.com>
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

The root argument for btrfs_update_inode_item() always matches the root of
the given inode, so remove the root argument and get it from the inode
argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 13a97d3ce34a..c4b5d4047c5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3966,8 +3966,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
  * copy everything in the in-memory inode into the btree.
  */
 static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
-				struct btrfs_inode *inode)
+					    struct btrfs_inode *inode)
 {
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_path *path;
@@ -3978,7 +3977,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_lookup_inode(trans, root, path, &inode->location, 1);
+	ret = btrfs_lookup_inode(trans, inode->root, path, &inode->location, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -4026,7 +4025,7 @@ int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	return btrfs_update_inode_item(trans, root, inode);
+	return btrfs_update_inode_item(trans, inode);
 }
 
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
@@ -4036,7 +4035,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_inode(trans, inode);
 	if (ret == -ENOSPC)
-		return btrfs_update_inode_item(trans, inode->root, inode);
+		return btrfs_update_inode_item(trans, inode);
 	return ret;
 }
 
-- 
2.40.1

