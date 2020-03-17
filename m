Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87F187AF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCQIMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQIMd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8540ADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 21/39] btrfs: Move free_backref_node() and free_backref_edge() to backref.h
Date:   Tue, 17 Mar 2020 16:11:07 +0800
Message-Id: <20200317081125.36289-22-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
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
index b21304d3f3f8..99d8a9301bc1 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -8,6 +8,7 @@
 
 #include <linux/btrfs.h>
 #include "ulist.h"
+#include "disk-io.h"
 #include "extent_io.h"
 
 struct inode_fs_paths {
@@ -290,4 +291,23 @@ static inline void link_backref_edge(struct backref_edge *edge,
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
index efd49553ada0..bb46e2e38c4f 100644
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

