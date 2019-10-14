Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19AFD626F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfJNMWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731938AbfJNMWa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01962BE80;
        Mon, 14 Oct 2019 12:22:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95C14DA7E3; Mon, 14 Oct 2019 14:22:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/15] btrfs: compression: export alloc/free/get/put callbacks of all algos
Date:   Mon, 14 Oct 2019 14:22:40 +0200
Message-Id: <7f085aedf524e3b9b00d5dd30494607c62d2f08e.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The indirect calls will be replaced by a switch in compression.c.
(Switch is faster than indirect calls with when Spectre mitigations are
enabled).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 12 ++++++++++++
 fs/btrfs/lzo.c         |  8 ++++----
 fs/btrfs/zlib.c        |  8 ++++----
 fs/btrfs/zstd.c        | 13 ++++++-------
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 34921a120829..f707db4a9a53 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -36,6 +36,10 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
+struct list_head *zlib_alloc_workspace(unsigned int level);
+void zlib_free_workspace(struct list_head *ws);
+struct list_head *zlib_get_workspace(unsigned int level);
+void zlib_put_workspace(struct list_head *ws);
 
 int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
@@ -44,6 +48,10 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
+struct list_head *lzo_alloc_workspace(unsigned int level);
+void lzo_free_workspace(struct list_head *ws);
+struct list_head *lzo_get_workspace(unsigned int level);
+void lzo_put_workspace(struct list_head *ws);
 
 int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
@@ -54,6 +62,10 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
 void zstd_cleanup_workspace_manager(void);
+struct list_head *zstd_alloc_workspace(unsigned int level);
+void zstd_free_workspace(struct list_head *ws);
+struct list_head *zstd_get_workspace(unsigned int level);
+void zstd_put_workspace(struct list_head *ws);
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 6f4619e76c11..18018619c019 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -63,17 +63,17 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static struct list_head *lzo_get_workspace(unsigned int level)
+struct list_head *lzo_get_workspace(unsigned int level)
 {
 	return btrfs_get_workspace(&wsm, level);
 }
 
-static void lzo_put_workspace(struct list_head *ws)
+void lzo_put_workspace(struct list_head *ws)
 {
 	btrfs_put_workspace(&wsm, ws);
 }
 
-static void lzo_free_workspace(struct list_head *ws)
+void lzo_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
@@ -83,7 +83,7 @@ static void lzo_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-static struct list_head *lzo_alloc_workspace(unsigned int level)
+struct list_head *lzo_alloc_workspace(unsigned int level)
 {
 	struct workspace *workspace;
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 03c632c7deac..f2a56e999e5f 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -29,7 +29,7 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static struct list_head *zlib_get_workspace(unsigned int level)
+struct list_head *zlib_get_workspace(unsigned int level)
 {
 	struct list_head *ws = btrfs_get_workspace(&wsm, level);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -39,12 +39,12 @@ static struct list_head *zlib_get_workspace(unsigned int level)
 	return ws;
 }
 
-static void zlib_put_workspace(struct list_head *ws)
+void zlib_put_workspace(struct list_head *ws)
 {
 	btrfs_put_workspace(&wsm, ws);
 }
 
-static void zlib_free_workspace(struct list_head *ws)
+void zlib_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
@@ -53,7 +53,7 @@ static void zlib_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-static struct list_head *zlib_alloc_workspace(unsigned int level)
+struct list_head *zlib_alloc_workspace(unsigned int level)
 {
 	struct workspace *workspace;
 	int workspacesize;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index f575ce77ea3d..2caf08e06e2f 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -91,9 +91,8 @@ static inline struct workspace *list_to_workspace(struct list_head *list)
 	return container_of(list, struct workspace, list);
 }
 
-static void zstd_free_workspace(struct list_head *ws);
-static struct list_head *zstd_alloc_workspace(unsigned int level);
-
+void zstd_free_workspace(struct list_head *ws);
+struct list_head *zstd_alloc_workspace(unsigned int level);
 /*
  * zstd_reclaim_timer_fn - reclaim timer
  * @t: timer
@@ -261,7 +260,7 @@ static struct list_head *zstd_find_workspace(unsigned int level)
  * attempt to allocate a new workspace.  If we fail to allocate one due to
  * memory pressure, go to sleep waiting for the max level workspace to free up.
  */
-static struct list_head *zstd_get_workspace(unsigned int level)
+struct list_head *zstd_get_workspace(unsigned int level)
 {
 	struct list_head *ws;
 	unsigned int nofs_flag;
@@ -302,7 +301,7 @@ static struct list_head *zstd_get_workspace(unsigned int level)
  * isn't set, it is also set here.  Only the max level workspace tries and wakes
  * up waiting workspaces.
  */
-static void zstd_put_workspace(struct list_head *ws)
+void zstd_put_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_to_workspace(ws);
 
@@ -332,7 +331,7 @@ static void zstd_put_workspace(struct list_head *ws)
 		cond_wake_up(&wsm.wait);
 }
 
-static void zstd_free_workspace(struct list_head *ws)
+void zstd_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
@@ -341,7 +340,7 @@ static void zstd_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-static struct list_head *zstd_alloc_workspace(unsigned int level)
+struct list_head *zstd_alloc_workspace(unsigned int level)
 {
 	struct workspace *workspace;
 
-- 
2.23.0

