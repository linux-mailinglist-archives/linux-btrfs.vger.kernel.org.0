Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0881E7C8152
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjJMJFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMJFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 05:05:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7A95
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 02:05:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80410C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697187952;
        bh=4T/aLb/Ni8B0zai6YBNI4zPCYZIIkT22BjASDhiY8p4=;
        h=From:To:Subject:Date:From;
        b=QFdj9PMAlg/3AmcQZtA3kHoG25tv1CAseRqp0OOso0PhDoX75dxAa6/JKfOkz9V1d
         vPV3RlH80a6ZAsLX7GNxtCsLihd+G5HpvBnGbLaaUPfEWe9C3BKd0cGEFP7INjVBYu
         GAYnHyBZEkCNwODDT82qYTdJpBB+tIHmc7RKezKD8DJxbd12v0V1OuOmaodcL8UG23
         ECuagaASO1/sR7lOEOT4nwpXB+w62amgAnIf2EU5qusZPfLrGQDSLB+909nRkTETo5
         K+z/vThazwnk5mQi9AIvd3PBXhvgpNOeoyjAoPPRR9EB8ftXbxkr6YPPO2bz3VdJUm
         DWxnkvuDdMsIw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use u64 for buffer sizes in the tree search ioctls
Date:   Fri, 13 Oct 2023 10:05:48 +0100
Message-Id: <44cfbc3f3ee2465d776ce6926c6f1cece2511325.1697187887.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the tree search v2 ioctl we use the type size_t, which is an unsigned
long, to track the buffer size in the local variable 'buf_size'. An
unsigned long is 32 bits wide on a 32 bits architecture. The buffer size
defined in struct btrfs_ioctl_search_args_v2 is a u64, so when we later
try to copy the local variable 'buf_size' to the argument struct, when
the search returns -EOVERFLOW, we copy only 32 bits which will be a
problem on big endian systems.

Fix this by using a u64 type for the buffer sizes, not only at
btrfs_ioctl_tree_search_v2(), but also everywhere down the call chain
so that we can use the u64 at btrfs_ioctl_tree_search_v2().

Fixes: cc68a8a5a433 ("btrfs: new ioctl TREE_SEARCH_V2")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-btrfs/ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab4ddbebeb16..130d863a5d01 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1528,7 +1528,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
-			       size_t *buf_size,
+			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
 			       int *num_found)
@@ -1660,7 +1660,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 static noinline int search_ioctl(struct inode *inode,
 				 struct btrfs_ioctl_search_key *sk,
-				 size_t *buf_size,
+				 u64 *buf_size,
 				 char __user *ubuf)
 {
 	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
@@ -1733,7 +1733,7 @@ static noinline int btrfs_ioctl_tree_search(struct inode *inode,
 	struct btrfs_ioctl_search_args __user *uargs = argp;
 	struct btrfs_ioctl_search_key sk;
 	int ret;
-	size_t buf_size;
+	u64 buf_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1763,8 +1763,8 @@ static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
 	struct btrfs_ioctl_search_args_v2 __user *uarg = argp;
 	struct btrfs_ioctl_search_args_v2 args;
 	int ret;
-	size_t buf_size;
-	const size_t buf_limit = SZ_16M;
+	u64 buf_size;
+	const u64 buf_limit = SZ_16M;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-- 
2.40.1

