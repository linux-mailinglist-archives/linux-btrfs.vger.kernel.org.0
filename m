Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6477AAFAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjIVKhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjIVKhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB88C6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A12C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379058;
        bh=2KxbC+dMezzGoHtrh8jOOe0IGMyXMLK+1lqR+FA+mUk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AUR+3/zUFa7OkGpiPLr6/mI5p/5pQCPaL7dCzrcXcMnEAlPZrysE4oDWFCKh8zN8N
         OlXMeecI2oqjvgePFUzx24QU8bn0TgVxnBCsj9aFQm07AZwN5JaYu4mn1CLQ8eS0ch
         db8xUX6uiTg26aqM0d37PL+kXl4Zb4c9ZBoOQlsJ4aY8wqhWLFhtZyfNTSekXQ+pDD
         EGHqwWNhhidCGaSJX1LWBa4J+ZctWIpKiAO7jwyWE5py73fUldKxeT4wfN4YMAXC3O
         6G42W4O2k3WDYGNlgJWsF+oRY98+eWXeq2FQN0S+iUDnCGQIpUfJ+QKtXO3m60a/xH
         cDebvj0bkE/HA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: remove redundant root argument from fixup_inode_link_count()
Date:   Fri, 22 Sep 2023 11:37:26 +0100
Message-Id: <9bae05da75131701556cd6704cab663d10e2bb20.1695333082.git.fdmanana@suse.com>
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

The root argument for fixup_inode_link_count() always matches the root of
the given inode, so remove the root argument and get it from the inode
argument. This also applies to the helpers count_inode_extrefs() and
count_inode_refs() used by fixup_inode_link_count() - they don't need the
root argument, as it always matches the root of the inode passed to them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a7bba3d61e55..f4257be56bd3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1482,8 +1482,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int count_inode_extrefs(struct btrfs_root *root,
-		struct btrfs_inode *inode, struct btrfs_path *path)
+static int count_inode_extrefs(struct btrfs_inode *inode, struct btrfs_path *path)
 {
 	int ret = 0;
 	int name_len;
@@ -1497,8 +1496,8 @@ static int count_inode_extrefs(struct btrfs_root *root,
 	struct extent_buffer *leaf;
 
 	while (1) {
-		ret = btrfs_find_one_extref(root, inode_objectid, offset, path,
-					    &extref, &offset);
+		ret = btrfs_find_one_extref(inode->root, inode_objectid, offset,
+					    path, &extref, &offset);
 		if (ret)
 			break;
 
@@ -1526,8 +1525,7 @@ static int count_inode_extrefs(struct btrfs_root *root,
 	return nlink;
 }
 
-static int count_inode_refs(struct btrfs_root *root,
-			struct btrfs_inode *inode, struct btrfs_path *path)
+static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
 {
 	int ret;
 	struct btrfs_key key;
@@ -1542,7 +1540,7 @@ static int count_inode_refs(struct btrfs_root *root,
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = btrfs_search_slot(NULL, inode->root, &key, path, 0, 0);
 		if (ret < 0)
 			break;
 		if (ret > 0) {
@@ -1594,9 +1592,9 @@ static int count_inode_refs(struct btrfs_root *root,
  * will free the inode.
  */
 static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
-					   struct btrfs_root *root,
 					   struct inode *inode)
 {
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path;
 	int ret;
 	u64 nlink = 0;
@@ -1606,13 +1604,13 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = count_inode_refs(root, BTRFS_I(inode), path);
+	ret = count_inode_refs(BTRFS_I(inode), path);
 	if (ret < 0)
 		goto out;
 
 	nlink = ret;
 
-	ret = count_inode_extrefs(root, BTRFS_I(inode), path);
+	ret = count_inode_extrefs(BTRFS_I(inode), path);
 	if (ret < 0)
 		goto out;
 
@@ -1684,7 +1682,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, root, inode);
+		ret = fixup_inode_link_count(trans, inode);
 		iput(inode);
 		if (ret)
 			break;
-- 
2.40.1

