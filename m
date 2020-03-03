Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A1176FD3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCCHP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:56838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgCCHP3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE463B016
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/19] btrfs: Move free_backref_node() and free_backref_edge() to backref.h
Date:   Tue,  3 Mar 2020 15:14:00 +0800
Message-Id: <20200303071409.57982-11-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 20 ++++++++++++++++++++
 fs/btrfs/relocation.c | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 431c8a15c5f9..d8492846a961 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -8,6 +8,7 @@
 
 #include <linux/btrfs.h>
 #include "ulist.h"
+#include "disk-io.h"
 #include "extent_io.h"
 
 struct inode_fs_paths {
@@ -311,4 +312,23 @@ static inline void link_backref_edge(struct backref_edge *edge,
 	if (link_which & LINK_UPPER)
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 }
+static inline void free_backref_node(struct backref_cache *cache,
+				     struct backref_node *node)
+{
+	if (node) {
+		cache->nr_nodes--;
+		btrfs_put_root(node->root);
+		kfree(node);
+	}
+}
+
+static inline void free_backref_edge(struct backref_cache *cache,
+				     struct backref_edge *edge)
+{
+	if (edge) {
+		cache->nr_edges--;
+		kfree(edge);
+	}
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index dfcedd7824bc..43b1bab2f51f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -215,25 +215,6 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static void free_backref_node(struct backref_cache *cache,
-			      struct backref_node *node)
-{
-	if (node) {
-		cache->nr_nodes--;
-		btrfs_put_root(node->root);
-		kfree(node);
-	}
-}
-
-static void free_backref_edge(struct backref_cache *cache,
-			      struct backref_edge *edge)
-{
-	if (edge) {
-		cache->nr_edges--;
-		kfree(edge);
-	}
-}
-
 static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 {
 
-- 
2.25.1

