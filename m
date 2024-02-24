Return-Path: <linux-btrfs+bounces-2709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D8862537
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 14:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E585C1C20E84
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B145BEB;
	Sat, 24 Feb 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PRi3Bq1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F864502C
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782438; cv=none; b=Gh1ge726CM94N4AGBIUMQkbPIYt65SZYHgo+fAmIAlYAqc1K/Z0smcHJq7iQnvp9KMz5Ds6gP0mPbWbT6K3mH/u7OnAiO4NVeLqz7XBUVBPLlTBx2M0DK2juU9jeWkK/JL8GRGLgkynHYCLo8qVFYkVGplB0+ms4ThPV9hht1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782438; c=relaxed/simple;
	bh=dfkuXdM1TfGRdOTvfYcpzHaUouxLyzj75vujnsQGm8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKKHU4FDPkMRTE5Ey0YGAA8cGit3+PSg/Rzt745nGmPR3X2fsHGigQuIT6cIr5kgEM9f61PsVPmwUQMop1IoP7hmw8vis5kfe+iwnsnnv835E+O0erPAkTsMyXLyGPEoXmP/HcGCunRlsvqAv+XmMvb00OnmI+X2Rdv0dZ8yKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PRi3Bq1B; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yKqN1sI8hqn9RRCulN4vsVyKZb8ToBpRi5CxTQ7ZeiE=;
	b=PRi3Bq1B9FbPNMB1z9xmo71ykAJIhO4pCqBW3HUot2pZd4HONcMHQWXBYxWeXWhwxcVwSH
	r2e/VSZ7c18iWnzvkzgIWdzYykX8De67sfvG9USH+HVIepEd0mju8tH4lhEImqkQr+yWo5
	9DsgdK1Y5tf4ZZfSyc5MfaDTKFG0t2w=
From: chengming.zhou@linux.dev
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] btrfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:09 +0000
Message-Id: <20240224134709.829191-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/btrfs/backref.c          | 2 +-
 fs/btrfs/ctree.c            | 2 +-
 fs/btrfs/defrag.c           | 2 +-
 fs/btrfs/delayed-inode.c    | 2 +-
 fs/btrfs/delayed-ref.c      | 8 ++++----
 fs/btrfs/extent-io-tree.c   | 2 +-
 fs/btrfs/extent_io.c        | 2 +-
 fs/btrfs/extent_map.c       | 2 +-
 fs/btrfs/free-space-cache.c | 4 ++--
 fs/btrfs/inode.c            | 2 +-
 fs/btrfs/ordered-data.c     | 2 +-
 fs/btrfs/transaction.c      | 2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6514cb1d404a..f2abb9afd04a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -200,7 +200,7 @@ int __init btrfs_prelim_ref_init(void)
 	btrfs_prelim_ref_cache = kmem_cache_create("btrfs_prelim_ref",
 					sizeof(struct prelim_ref),
 					0,
-					SLAB_MEM_SPREAD,
+					0,
 					NULL);
 	if (!btrfs_prelim_ref_cache)
 		return -ENOMEM;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index bae17dbe71d6..aaf53fd84358 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5086,7 +5086,7 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 
 int __init btrfs_ctree_init(void)
 {
-	btrfs_path_cachep = KMEM_CACHE(btrfs_path, SLAB_MEM_SPREAD);
+	btrfs_path_cachep = KMEM_CACHE(btrfs_path, 0);
 	if (!btrfs_path_cachep)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 6d3abfcf92d4..4f9e78a94a0a 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1516,7 +1516,7 @@ int __init btrfs_auto_defrag_init(void)
 {
 	btrfs_inode_defrag_cachep = kmem_cache_create("btrfs_inode_defrag",
 					sizeof(struct inode_defrag), 0,
-					SLAB_MEM_SPREAD,
+					0,
 					NULL);
 	if (!btrfs_inode_defrag_cachep)
 		return -ENOMEM;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0a7a40d97e91..dd6f566a383f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -28,7 +28,7 @@ static struct kmem_cache *delayed_node_cache;
 
 int __init btrfs_delayed_inode_init(void)
 {
-	delayed_node_cache = KMEM_CACHE(btrfs_delayed_node, SLAB_MEM_SPREAD);
+	delayed_node_cache = KMEM_CACHE(btrfs_delayed_node, 0);
 	if (!delayed_node_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index c90efc20b8b2..7c5377151a1f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1308,22 +1308,22 @@ void __cold btrfs_delayed_ref_exit(void)
 int __init btrfs_delayed_ref_init(void)
 {
 	btrfs_delayed_ref_head_cachep = KMEM_CACHE(btrfs_delayed_ref_head,
-						   SLAB_MEM_SPREAD);
+						   0);
 	if (!btrfs_delayed_ref_head_cachep)
 		goto fail;
 
 	btrfs_delayed_tree_ref_cachep = KMEM_CACHE(btrfs_delayed_tree_ref,
-						   SLAB_MEM_SPREAD);
+						   0);
 	if (!btrfs_delayed_tree_ref_cachep)
 		goto fail;
 
 	btrfs_delayed_data_ref_cachep = KMEM_CACHE(btrfs_delayed_data_ref,
-						   SLAB_MEM_SPREAD);
+						   0);
 	if (!btrfs_delayed_data_ref_cachep)
 		goto fail;
 
 	btrfs_delayed_extent_op_cachep = KMEM_CACHE(btrfs_delayed_extent_op,
-						    SLAB_MEM_SPREAD);
+						    0);
 	if (!btrfs_delayed_extent_op_cachep)
 		goto fail;
 
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6b923c0ef4ea..102572e31636 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1884,7 +1884,7 @@ int __init extent_state_init_cachep(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 			sizeof(struct extent_state), 0,
-			SLAB_MEM_SPREAD, NULL);
+			0, NULL);
 	if (!extent_state_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfef67c68221..e779a85e752f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -147,7 +147,7 @@ int __init extent_buffer_init_cachep(void)
 {
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
 			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
+			0, NULL);
 	if (!extent_buffer_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index ea08601988de..692d62b2fab2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -16,7 +16,7 @@ int __init extent_map_init(void)
 {
 	extent_map_cache = kmem_cache_create("btrfs_extent_map",
 			sizeof(struct extent_map), 0,
-			SLAB_MEM_SPREAD, NULL);
+			0, NULL);
 	if (!extent_map_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d984912dae06..c8a05d5eb9cb 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -4154,13 +4154,13 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
 
 int __init btrfs_free_space_init(void)
 {
-	btrfs_free_space_cachep = KMEM_CACHE(btrfs_free_space, SLAB_MEM_SPREAD);
+	btrfs_free_space_cachep = KMEM_CACHE(btrfs_free_space, 0);
 	if (!btrfs_free_space_cachep)
 		return -ENOMEM;
 
 	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
 							PAGE_SIZE, PAGE_SIZE,
-							SLAB_MEM_SPREAD, NULL);
+							0, NULL);
 	if (!btrfs_free_space_bitmap_cachep) {
 		kmem_cache_destroy(btrfs_free_space_cachep);
 		return -ENOMEM;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df55dd891137..6c4d60746af6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8717,7 +8717,7 @@ int __init btrfs_init_cachep(void)
 {
 	btrfs_inode_cachep = kmem_cache_create("btrfs_inode",
 			sizeof(struct btrfs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			init_once);
 	if (!btrfs_inode_cachep)
 		goto fail;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1ee2fb8dcd6a..b749ba45da2b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1235,7 +1235,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 
 int __init ordered_data_init(void)
 {
-	btrfs_ordered_extent_cache = KMEM_CACHE(btrfs_ordered_extent, SLAB_MEM_SPREAD);
+	btrfs_ordered_extent_cache = KMEM_CACHE(btrfs_ordered_extent, 0);
 	if (!btrfs_ordered_extent_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ea080ec2f927..2f151c5367ed 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2672,7 +2672,7 @@ void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 int __init btrfs_transaction_init(void)
 {
 	btrfs_trans_handle_cachep = KMEM_CACHE(btrfs_trans_handle,
-					       SLAB_TEMPORARY | SLAB_MEM_SPREAD);
+					       SLAB_TEMPORARY);
 	if (!btrfs_trans_handle_cachep)
 		return -ENOMEM;
 	return 0;
-- 
2.40.1


