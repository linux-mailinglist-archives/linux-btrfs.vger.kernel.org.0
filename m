Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9523D18F2B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCWKZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76843ADF1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/40] btrfs: Rename alloc_backref_edge() to btrfs_backref_alloc_edge() and move it backref.c
Date:   Mon, 23 Mar 2020 18:23:56 +0800
Message-Id: <20200323102416.112862-21-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 11 +++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 17 +++--------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9050fa545a54..2bf3bf2d7b85 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2504,3 +2504,14 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 	node->bytenr = bytenr;
 	return node;
 }
+
+struct btrfs_backref_edge *btrfs_backref_alloc_edge(
+		struct btrfs_backref_cache *cache)
+{
+	struct btrfs_backref_edge *edge;
+
+	edge = kzalloc(sizeof(*edge), GFP_NOFS);
+	if (edge)
+		cache->nr_edges++;
+	return edge;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 6e2b7b4a99e5..4e9b343c2c31 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -272,4 +272,6 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 			      struct btrfs_backref_cache *cache, int is_reloc);
 struct btrfs_backref_node *btrfs_backref_alloc_node(
 		struct btrfs_backref_cache *cache, u64 bytenr, int level);
+struct btrfs_backref_edge *btrfs_backref_alloc_edge(
+		struct btrfs_backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4b670ae6a0fb..36b0d03709ef 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -225,17 +225,6 @@ static void free_backref_node(struct btrfs_backref_cache *cache,
 	}
 }
 
-static struct btrfs_backref_edge *alloc_backref_edge(
-		struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_edge *edge;
-
-	edge = kzalloc(sizeof(*edge), GFP_NOFS);
-	if (edge)
-		cache->nr_edges++;
-	return edge;
-}
-
 #define		LINK_LOWER	(1 << 0)
 #define		LINK_UPPER	(1 << 1)
 static void link_backref_edge(struct btrfs_backref_edge *edge,
@@ -588,7 +577,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		return 0;
 	}
 
-	edge = alloc_backref_edge(cache);
+	edge = btrfs_backref_alloc_edge(cache);
 	if (!edge)
 		return -ENOMEM;
 
@@ -707,7 +696,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 			break;
 		}
 
-		edge = alloc_backref_edge(cache);
+		edge = btrfs_backref_alloc_edge(cache);
 		if (!edge) {
 			btrfs_put_root(root);
 			ret = -ENOMEM;
@@ -1272,7 +1261,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 
 	if (!node->lowest) {
 		list_for_each_entry(edge, &node->lower, list[UPPER]) {
-			new_edge = alloc_backref_edge(cache);
+			new_edge = btrfs_backref_alloc_edge(cache);
 			if (!new_edge)
 				goto fail;
 
-- 
2.25.2

