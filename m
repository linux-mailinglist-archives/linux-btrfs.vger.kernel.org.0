Return-Path: <linux-btrfs+bounces-10418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963169F3754
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F4C169DDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8E207DE7;
	Mon, 16 Dec 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VruPtjEX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0617207A22
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369454; cv=none; b=qunA9ZbxIjRfVM+19YxDoS3RHWDS3B6F06bsYcIWq7pdOqInq5TzBS/yIyF/CjE6skmiggccUeDr4ZOk1WMGQ9A22yF6XcNWGmOwp6q2Dj6CgdOBrcY1qFBCmWODsrkTMdPaBr7tFB+uKylQLRz1mI5dysfWakxzWlmE9u30Y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369454; c=relaxed/simple;
	bh=XefyvdWOX0X0kwSr4QsRVQ9z2/IN48WK4VajsRCC9wI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJ7CYBN5fEpL6pXPbOGW/6LfkPaF5F8n0DZfCC7Ek3cT39E/WDyGc5jSSlTmRWz+WGYaOQ58kMe+/skoouDreIl5ApBDbZY7erKn0FBnsOz1YUpl6DtA7RerQzdd2FuHqP88TvGaYpn+nbqbCn1DgcO7qeivV1zw0I81uFKmGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VruPtjEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F00C4CED0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369454;
	bh=XefyvdWOX0X0kwSr4QsRVQ9z2/IN48WK4VajsRCC9wI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VruPtjEXu1/lYMcIbSixXZonujg1/W+sFnr4nuS3nsXgNSMRmIWsgWi7lvLBmbR2z
	 I454MBVo+tcesVaNuQdF+VjHfXLTOguAsqHVoNkvJ+I3qLmeSCA+NI81tVffUaqNkO
	 mT+DXkhIsC8mfwMvdmZxz1QG6muIEKtXN3tA1QG8svigEwD2riOTg0I001WuXKvyL/
	 5MYtqSgt17MfLI/EZNcDBC58qwVrI6uXRoJqZgXWtAFqyw1woRLy+ffRvYLfMjr8Gk
	 FaUCrT7b3nUHLzJBFxn1DRnzRiQuaY7tvXNLjKwOqj+z2PQKlUaxQmSiq7aHxM53h/
	 mOeKfIxbv/uMQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: move btrfs_alloc_write_mask() into fs.h
Date: Mon, 16 Dec 2024 17:17:22 +0000
Message-Id: <e3418246200c237c8f9528b1ede474cbd9301215.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_alloc_write_mask() is defined in ctree.h but it's not
related at all to the btree data structure, so move it into fs.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 6 ------
 fs/btrfs/fs.h    | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bf054470dcd0..53f9fc04f66f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -7,7 +7,6 @@
 #define BTRFS_CTREE_H
 
 #include "linux/cleanup.h"
-#include <linux/pagemap.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/mutex.h>
@@ -506,11 +505,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
-{
-	return mapping_gfp_constraint(mapping, ~__GFP_FS);
-}
-
 void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index dd1a82297d4c..1113646374f3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -18,6 +18,7 @@
 #include <linux/rwsem.h>
 #include <linux/semaphore.h>
 #include <linux/list.h>
+#include <linux/pagemap.h>
 #include <linux/radix-tree.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
@@ -887,6 +888,11 @@ struct btrfs_fs_info {
 #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
 					   struct inode *: (_inode)))->root->fs_info)
 
+static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
+{
+	return mapping_gfp_constraint(mapping, ~__GFP_FS);
+}
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
-- 
2.45.2


