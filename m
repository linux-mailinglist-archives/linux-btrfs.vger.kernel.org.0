Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF4187AEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCQIM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCQIM3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 609EEADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 19/39] btrfs: Move alloc_backref_edge() to backref.c
Date:   Tue, 17 Mar 2020 16:11:05 +0800
Message-Id: <20200317081125.36289-20-wqu@suse.com>
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
 fs/btrfs/backref.c    | 10 ++++++++++
 fs/btrfs/backref.h    |  1 +
 fs/btrfs/relocation.c | 10 ----------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index eb4a2b8dd282..77201948a583 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2504,3 +2504,13 @@ struct backref_node *alloc_backref_node(struct backref_cache *cache,
 	node->bytenr = bytenr;
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
index ccb676ca685b..87d0735908ed 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -273,4 +273,5 @@ void backref_cache_init(struct btrfs_fs_info *fs_info,
 			struct backref_cache *cache, int is_reloc);
 struct backref_node *alloc_backref_node(struct backref_cache *cache,
 					u64 bytenr, int level);
+struct backref_edge *alloc_backref_edge(struct backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d946cdd07e31..0357dc8861fc 100644
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
 static void link_backref_edge(struct backref_edge *edge,
-- 
2.25.1

