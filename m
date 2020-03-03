Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11A176FD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCCHPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:56816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgCCHPW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 125E5AC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/19] btrfs: Move alloc_backref_edge() to backref.c
Date:   Tue,  3 Mar 2020 15:13:58 +0800
Message-Id: <20200303071409.57982-9-wqu@suse.com>
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
 fs/btrfs/backref.c    | 10 ++++++++++
 fs/btrfs/backref.h    |  1 +
 fs/btrfs/relocation.c | 10 ----------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b6183cb7c60b..7511ce8447e8 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2480,3 +2480,13 @@ struct backref_node *alloc_backref_node(struct backref_cache *cache,
 	}
 	return node;
 }
+
+struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
+{
+	struct backref_edge *edge;
+
+	edge = kzalloc(sizeof(*edge), GFP_NOFS);
+	if (edge)
+		cache->nr_edges++;
+	return edge;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index b7aad5f116ae..04efc9d44bb8 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -294,4 +294,5 @@ void backref_cache_init(struct btrfs_fs_info *fs_info,
 			struct backref_cache *cache, int is_reloc);
 struct backref_node *alloc_backref_node(struct backref_cache *cache,
 					u64 bytenr, int level);
+struct backref_edge *alloc_backref_edge(struct backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f97ff88dba21..1f4fccd973d1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -225,16 +225,6 @@ static void free_backref_node(struct backref_cache *cache,
 	}
 }
 
-static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
-{
-	struct backref_edge *edge;
-
-	edge = kzalloc(sizeof(*edge), GFP_NOFS);
-	if (edge)
-		cache->nr_edges++;
-	return edge;
-}
-
 #define		LINK_LOWER	(1 << 0)
 #define		LINK_UPPER	(1 << 1)
 static inline void link_backref_edge(struct backref_edge *edge,
-- 
2.25.1

