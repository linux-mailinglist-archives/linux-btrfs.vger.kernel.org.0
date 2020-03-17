Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9AC187AED
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgCQIM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCQIM2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86077ADA1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 18/39] btrfs: Move alloc_backref_node() to backref.c
Date:   Tue, 17 Mar 2020 16:11:04 +0800
Message-Id: <20200317081125.36289-19-wqu@suse.com>
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
 fs/btrfs/backref.c    | 20 ++++++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 20 --------------------
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 2f1a60760342..eb4a2b8dd282 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2484,3 +2484,23 @@ void backref_cache_init(struct btrfs_fs_info *fs_info,
 	cache->fs_info = fs_info;
 	cache->is_reloc = is_reloc;
 }
+
+struct backref_node *alloc_backref_node(struct backref_cache *cache,
+					u64 bytenr, int level)
+{
+	struct backref_node *node;
+
+	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
+	node = kzalloc(sizeof(*node), GFP_NOFS);
+	if (!node)
+		return node;
+	INIT_LIST_HEAD(&node->list);
+	INIT_LIST_HEAD(&node->upper);
+	INIT_LIST_HEAD(&node->lower);
+	RB_CLEAR_NODE(&node->rb_node);
+	cache->nr_nodes++;
+
+	node->level = level;
+	node->bytenr = bytenr;
+	return node;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 7c81fed555d7..ccb676ca685b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -271,4 +271,6 @@ struct backref_cache {
 
 void backref_cache_init(struct btrfs_fs_info *fs_info,
 			struct backref_cache *cache, int is_reloc);
+struct backref_node *alloc_backref_node(struct backref_cache *cache,
+					u64 bytenr, int level);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2e54251b9129..d946cdd07e31 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -215,26 +215,6 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static struct backref_node *alloc_backref_node(struct backref_cache *cache,
-						u64 bytenr, int level)
-{
-	struct backref_node *node;
-
-	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
-	node = kzalloc(sizeof(*node), GFP_NOFS);
-	if (!node)
-		return node;
-	INIT_LIST_HEAD(&node->list);
-	INIT_LIST_HEAD(&node->upper);
-	INIT_LIST_HEAD(&node->lower);
-	RB_CLEAR_NODE(&node->rb_node);
-	cache->nr_nodes++;
-
-	node->level = level;
-	node->bytenr = bytenr;
-	return node;
-}
-
 static void free_backref_node(struct backref_cache *cache,
 			      struct backref_node *node)
 {
-- 
2.25.1

