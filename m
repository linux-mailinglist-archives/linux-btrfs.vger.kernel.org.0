Return-Path: <linux-btrfs+bounces-5066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3D8C8700
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D83A1C222FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395D548F7;
	Fri, 17 May 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb82baev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4C5467E
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951612; cv=none; b=j6ZZz1/78DorSdcqGuYTHgdZ+LYNgks961rQ2NEeHM7QZuiUMZItdnRWDBN9evdmedMxbfEcUvoVtolJZGOke4cu8BHssQETgyv3PVlNjK1AiRWKi2S+Xae/7jE0tzWyaL6a9oaM2U4Y91wZst0BXMlBJE2Y+vVfCpk/VTP/aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951612; c=relaxed/simple;
	bh=5Y/XJGuWUZ3ffvanv4EPqlrl0qsYWAepHNmCuqQq+2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNhEmCM77jBP/yIDeyyrNXATtYk+4YIGL0PaNWE6VXL1dQkLpuHO8Te6HhZONQjh94hnfmaHnuqhXCnB//u4EcKzgQou61RGLymXHNaL2ovkTIqnFC6xM1lhOo+R4tftYmCJbmcGu3GQp5J3ZADXNX33ZN5yZbEoPa/vSMSJ85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb82baev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D6C32789
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951612;
	bh=5Y/XJGuWUZ3ffvanv4EPqlrl0qsYWAepHNmCuqQq+2U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yb82baevlqCSfHVg0aKbvhVR37TwuMP0E3ViWXZAzWkdt+U/mowLi8qgFsdu+l8rC
	 hM3wQvJIHq+eq/6mtnQNR8Ip7j0Uc3sK0wrvnIpykOaF3TENzneBT/K1U3Lz1TOnZW
	 4BxWn8gwgk3kXtLzWm/6dO2dE8hCIhEMxImWSgaQTr+TGYRhVbaVWzRIUbjZfHq6Xd
	 qVmaB3PDGgwubQeaLHtrXPY3dN5yGaMpZk3D8jySxdTQqvUyMvu8VIQY8NbHua8luc
	 Q1L3qNen7norcjuN1VlRANcr3kxr7NHV1Id06g3h4fdgeq4uGnZFhTk9KguiouLuGo
	 ydIjb17sXhWJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: add and use helpers to get and set an inode's delayed_node
Date: Fri, 17 May 2024 14:13:26 +0100
Message-Id: <48ccb776f018f79730fb9b9139623960401f9505.1715951291.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715951291.git.fdmanana@suse.com>
References: <cover.1715951291.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When reading the delayed_node of an inode without taking the lock of the
root->delayed_nodes we are using READ_ONCE(), and when updating it we are
using WRITE_ONCE().

Add and use helpers that hide the usage of READ_ONCE() and WRITE_ONCE(),
like we do for other inode fields such as first_dir_index_to_log or the
log_transid field of struct btrfs_root for example.

Also make use of the setter helper at btrfs_alloc_inode() for consistency
only - it shouldn't be needed since when allocating an inode no one else
can access it concurrently.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h   | 12 ++++++++++++
 fs/btrfs/delayed-inode.c | 10 +++++-----
 fs/btrfs/inode.c         |  4 ++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4d9299789a03..3c8bc7a8ebdd 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -330,6 +330,18 @@ struct btrfs_inode {
 	struct inode vfs_inode;
 };
 
+static inline struct btrfs_delayed_node *btrfs_get_inode_delayed_node(
+					      const struct btrfs_inode *inode)
+{
+	return READ_ONCE(inode->delayed_node);
+}
+
+static inline void btrfs_set_inode_delayed_node(struct btrfs_inode *inode,
+						struct btrfs_delayed_node *node)
+{
+	WRITE_ONCE(inode->delayed_node, node);
+}
+
 static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
 {
 	return READ_ONCE(inode->first_dir_index_to_log);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6df7e44d9d31..f2fe488665e8 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -71,7 +71,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 	u64 ino = btrfs_ino(btrfs_inode);
 	struct btrfs_delayed_node *node;
 
-	node = READ_ONCE(btrfs_inode->delayed_node);
+	node = btrfs_get_inode_delayed_node(btrfs_inode);
 	if (node) {
 		refcount_inc(&node->refs);
 		return node;
@@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
-			WRITE_ONCE(btrfs_inode->delayed_node, node);
+			btrfs_set_inode_delayed_node(btrfs_inode, node);
 		} else {
 			node = NULL;
 		}
@@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
-	WRITE_ONCE(btrfs_inode->delayed_node, node);
+	btrfs_set_inode_delayed_node(btrfs_inode, node);
 	xa_unlock(&root->delayed_nodes);
 
 	return node;
@@ -1308,11 +1308,11 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
 
-	delayed_node = READ_ONCE(inode->delayed_node);
+	delayed_node = btrfs_get_inode_delayed_node(inode);
 	if (!delayed_node)
 		return;
 
-	WRITE_ONCE(inode->delayed_node, NULL);
+	btrfs_set_inode_delayed_node(inode, NULL);
 	btrfs_release_delayed_node(delayed_node);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 11cad22d7b4c..2f3129fe0e58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6100,7 +6100,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 		ret = btrfs_update_inode(trans, inode);
 	}
 	btrfs_end_transaction(trans);
-	if (READ_ONCE(inode->delayed_node))
+	if (btrfs_get_inode_delayed_node(inode))
 		btrfs_balance_delayed_items(fs_info);
 
 	return ret;
@@ -8475,7 +8475,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->prop_compress = BTRFS_COMPRESS_NONE;
 	ei->defrag_compress = BTRFS_COMPRESS_NONE;
 
-	ei->delayed_node = NULL;
+	btrfs_set_inode_delayed_node(ei, NULL);
 
 	ei->i_otime_sec = 0;
 	ei->i_otime_nsec = 0;
-- 
2.43.0


