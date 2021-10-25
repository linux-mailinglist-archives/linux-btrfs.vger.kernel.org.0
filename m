Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B6439315
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhJYJ7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhJYJ6v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DD2761029
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635155790;
        bh=Bni20bC5kEhAfZp83ccnaWJexvMC+YHymeJTB+WQcYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gqZzGLWU9nlCJccce6wZnrLnSxLZvwHNwUW7p+AR0xYCDiBFHrogKQatON3Txj/jw
         FEBg5xFOlcKywG+w6VbDNpyd64L5olGxipBWYwX+f4hUnoIKWHKeiRiR9Yaj17PZSb
         10F0gMQ5UbxZJlva1V/MZxFKGd2OS4lVA7TmNjPyywtJ5rhwthOvBMgKA/c14z16a/
         UAkN45ox4E9LaywPCueDZq5NFlUE8J0P/h6b7/2FDBjQZ297Zn3qQko79efhMEWpXb
         b9CS5nYvl9OiH5vI/OkS46EDNGw0DgzQT70ZTg4FI+l8mLz68zdPnz5A/FO8s3tAtb
         21jvxj8ydgOYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: remove root argument from drop_one_dir_item()
Date:   Mon, 25 Oct 2021 10:56:21 +0100
Message-Id: <63f3aa795649c8ff556354e1472aee6db6795e51.1635155473.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635155473.git.fdmanana@suse.com>
References: <cover.1635155473.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument for drop_one_dir_item() always matches the root of the
given directory inode, since each log tree is associated to one and only
one subvolume/root, so remove the argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c900eb27cf8..23f1a35ea04f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -921,11 +921,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
  * item
  */
 static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root,
 				      struct btrfs_path *path,
 				      struct btrfs_inode *dir,
 				      struct btrfs_dir_item *di)
 {
+	struct btrfs_root *root = dir->root;
 	struct inode *inode;
 	char *name;
 	int name_len;
@@ -1220,7 +1220,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
-		ret = drop_one_dir_item(trans, root, path, dir, di);
+		ret = drop_one_dir_item(trans, path, dir, di);
 		if (ret)
 			return ret;
 	}
@@ -1232,7 +1232,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
-		ret = drop_one_dir_item(trans, root, path, dir, di);
+		ret = drop_one_dir_item(trans, path, dir, di);
 		if (ret)
 			return ret;
 	}
@@ -2049,7 +2049,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	if (!exists)
 		goto out;
 
-	ret = drop_one_dir_item(trans, root, path, BTRFS_I(dir), dst_di);
+	ret = drop_one_dir_item(trans, path, BTRFS_I(dir), dst_di);
 	if (ret)
 		goto out;
 
-- 
2.33.0

