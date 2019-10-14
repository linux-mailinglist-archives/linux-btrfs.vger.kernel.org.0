Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2900ED6272
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfJNMWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731983AbfJNMWg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03927BE8A;
        Mon, 14 Oct 2019 12:22:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8CBE1DA7E3; Mon, 14 Oct 2019 14:22:47 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/15] btrfs: compression: pass type to btrfs_get_workspace
Date:   Mon, 14 Oct 2019 14:22:47 +0200
Message-Id: <495a8c7d9931c06946f5683c1231582b1acf3584.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can infer the workspace_manager from type and the type will be used
in the following patch to call a common helper for alloc_workspace.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 12 +++++-------
 fs/btrfs/compression.h |  3 +--
 fs/btrfs/zlib.c        |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9b9638557e19..ffc94e15d86e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -972,9 +972,9 @@ static void btrfs_cleanup_workspace_manager(int type)
  * Preallocation makes a forward progress guarantees and we do not return
  * errors.
  */
-struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
-				      unsigned int level)
+struct list_head *btrfs_get_workspace(int type, unsigned int level)
 {
+	struct workspace_manager *wsm;
 	struct list_head *workspace;
 	int cpus = num_online_cpus();
 	unsigned nofs_flag;
@@ -984,6 +984,7 @@ struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 	wait_queue_head_t *ws_wait;
 	int *free_ws;
 
+	wsm = btrfs_compress_op[type]->workspace_manager;
 	idle_ws	 = &wsm->idle_ws;
 	ws_lock	 = &wsm->ws_lock;
 	total_ws = &wsm->total_ws;
@@ -1052,13 +1053,10 @@ struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 
 static struct list_head *get_workspace(int type, int level)
 {
-	struct workspace_manager *wsm;
-
-	wsm = btrfs_compress_op[type]->workspace_manager;
 	switch (type) {
-	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(wsm, level);
+	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(type, level);
 	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(level);
-	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(wsm, level);
+	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(type, level);
 	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(level);
 	default:
 		/*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index b8ed97fc6db4..accb1d61df87 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -120,8 +120,7 @@ struct workspace_manager {
 	wait_queue_head_t ws_wait;
 };
 
-struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
-				      unsigned int level);
+struct list_head *btrfs_get_workspace(int type, unsigned int level);
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
 
 struct btrfs_compress_op {
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 610765640c8e..5679a2e41a52 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -31,7 +31,7 @@ static struct workspace_manager wsm;
 
 struct list_head *zlib_get_workspace(unsigned int level)
 {
-	struct list_head *ws = btrfs_get_workspace(&wsm, level);
+	struct list_head *ws = btrfs_get_workspace(BTRFS_COMPRESS_ZLIB, level);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
 	workspace->level = level;
-- 
2.23.0

