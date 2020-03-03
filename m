Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3866176FD2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCCHPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgCCHPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83C3BAC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/19] btrfs: Move link_backref_edge() to backref.c
Date:   Tue,  3 Mar 2020 15:13:59 +0800
Message-Id: <20200303071409.57982-10-wqu@suse.com>
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
 fs/btrfs/backref.h    | 16 ++++++++++++++++
 fs/btrfs/relocation.c | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 04efc9d44bb8..431c8a15c5f9 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -295,4 +295,20 @@ void backref_cache_init(struct btrfs_fs_info *fs_info,
 struct backref_node *alloc_backref_node(struct backref_cache *cache,
 					u64 bytenr, int level);
 struct backref_edge *alloc_backref_edge(struct backref_cache *cache);
+
+#define		LINK_LOWER	(1 << 0)
+#define		LINK_UPPER	(1 << 1)
+static inline void link_backref_edge(struct backref_edge *edge,
+				     struct backref_node *lower,
+				     struct backref_node *upper,
+				     int link_which)
+{
+	ASSERT(upper && lower && upper->level == lower->level + 1);
+	edge->node[LOWER] = lower;
+	edge->node[UPPER] = upper;
+	if (link_which & LINK_LOWER)
+		list_add_tail(&edge->list[LOWER], &lower->upper);
+	if (link_which & LINK_UPPER)
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+}
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1f4fccd973d1..dfcedd7824bc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -225,22 +225,6 @@ static void free_backref_node(struct backref_cache *cache,
 	}
 }
 
-#define		LINK_LOWER	(1 << 0)
-#define		LINK_UPPER	(1 << 1)
-static inline void link_backref_edge(struct backref_edge *edge,
-				     struct backref_node *lower,
-				     struct backref_node *upper,
-				     int link_which)
-{
-	ASSERT(upper && lower && upper->level == lower->level + 1);
-	edge->node[LOWER] = lower;
-	edge->node[UPPER] = upper;
-	if (link_which & LINK_LOWER)
-		list_add_tail(&edge->list[LOWER], &lower->upper);
-	if (link_which & LINK_UPPER)
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-}
-
 static void free_backref_edge(struct backref_cache *cache,
 			      struct backref_edge *edge)
 {
-- 
2.25.1

