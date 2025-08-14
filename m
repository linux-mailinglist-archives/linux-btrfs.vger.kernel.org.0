Return-Path: <linux-btrfs+bounces-16078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F100B25AD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54BD64E26C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F212248A3;
	Thu, 14 Aug 2025 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XvpTLfQa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XvpTLfQa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22E21FF58
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149650; cv=none; b=r64JTtX/7cSulr35pJalLJ/SOHYMx1jVU4ZmKc1cYWclWra0sd84eZt/evHre1C0KEMI9tUfpWKgONUXsAh/OO6pMFirHd6sXM+25p3OdM2rR4iLO0CoWiTv1QYqIDGCm6CvxYKFCzomdzaH/ISxidywLBQHGQqXwWQpU4Q3ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149650; c=relaxed/simple;
	bh=/O9txlbUGQ3jiK3xlO+mDoewpUI+vqJqR3q1mCv6GIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y73KcRHruTl/tOYuCQ7gTCn7b8oXYn6fSuIRk4gv7xcfkIh33+HSBpKSyo02DwegvK/a9wHedAU25kJYYg5dd/3AHp/aTP+tYdNc9GNhZd5FyyLMyqpVfVryfxCYeJIItT8K+OQklu2yW8SvurMcIcsfLq9dI1s/SCmwFhAx1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XvpTLfQa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XvpTLfQa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C62321B4B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o3zbXj1SsJhM+DBX3MEn32h0Anx4e/50sAw0rbt0ko=;
	b=XvpTLfQa2bRhlj6WTPCFD9/5CQcx4uBvVJLrghBWMhvtudBH3gD8rQZcYPccRIkyymlnGh
	0dwBNmbFiIPrcZOvVDR/0w5CpXGdX6rCvjiYXYh4+21IJdeQ3KlPoN6Q+TNCFw0MhFAvjo
	or0N93Nd01p7u6Uz4khZeh4bVrUGvEk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o3zbXj1SsJhM+DBX3MEn32h0Anx4e/50sAw0rbt0ko=;
	b=XvpTLfQa2bRhlj6WTPCFD9/5CQcx4uBvVJLrghBWMhvtudBH3gD8rQZcYPccRIkyymlnGh
	0dwBNmbFiIPrcZOvVDR/0w5CpXGdX6rCvjiYXYh4+21IJdeQ3KlPoN6Q+TNCFw0MhFAvjo
	or0N93Nd01p7u6Uz4khZeh4bVrUGvEk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB3A13479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPfJCT91nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: cleanup the per-module workspace managers
Date: Thu, 14 Aug 2025 15:03:24 +0930
Message-ID: <cb28b8b9352b9a8c95ced99d5943dcbf982b4fa0.1755148754.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755148754.git.wqu@suse.com>
References: <cover.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Since all workspaces are handled by the per-fs workspace managers, we
can safely remove the old per-module managers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 55 +-----------------------------------------
 fs/btrfs/compression.h |  2 --
 fs/btrfs/lzo.c         |  3 ---
 fs/btrfs/zlib.c        |  3 ---
 fs/btrfs/zstd.c        | 49 -------------------------------------
 5 files changed, 1 insertion(+), 111 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4c5a9d6c22ef..12b851218598 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -688,8 +688,6 @@ struct heuristic_ws {
 	struct list_head list;
 };
 
-static struct workspace_manager heuristic_wsm;
-
 static void free_heuristic_ws(struct list_head *ws)
 {
 	struct heuristic_ws *workspace;
@@ -729,9 +727,7 @@ static struct list_head *alloc_heuristic_ws(struct btrfs_fs_info *fs_info)
 	return ERR_PTR(-ENOMEM);
 }
 
-const struct btrfs_compress_op btrfs_heuristic_compress = {
-	.workspace_manager = &heuristic_wsm,
-};
+const struct btrfs_compress_op btrfs_heuristic_compress = { 0 };
 
 static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	/* The heuristic is represented as compression type 0 */
@@ -807,32 +803,6 @@ static int generic_alloc_workspace_manager(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static void btrfs_init_workspace_manager(struct btrfs_fs_info *fs_info, int type)
-{
-	struct workspace_manager *wsm;
-	struct list_head *workspace;
-
-	wsm = btrfs_compress_op[type]->workspace_manager;
-	INIT_LIST_HEAD(&wsm->idle_ws);
-	spin_lock_init(&wsm->ws_lock);
-	atomic_set(&wsm->total_ws, 0);
-	init_waitqueue_head(&wsm->ws_wait);
-
-	/*
-	 * Preallocate one workspace for each compression type so we can
-	 * guarantee forward progress in the worst case
-	 */
-	workspace = alloc_workspace(fs_info, type, 0);
-	if (IS_ERR(workspace)) {
-		btrfs_warn(fs_info,
-			   "cannot preallocate compression workspace, will try later");
-	} else {
-		atomic_set(&wsm->total_ws, 1);
-		wsm->free_ws = 1;
-		list_add(workspace, &wsm->idle_ws);
-	}
-}
-
 static void generic_free_workspace_manager(struct btrfs_fs_info *fs_info,
 					   enum btrfs_compression_type type)
 {
@@ -853,20 +823,6 @@ static void generic_free_workspace_manager(struct btrfs_fs_info *fs_info,
 	kfree(gwsm);
 }
 
-static void btrfs_cleanup_workspace_manager(int type)
-{
-	struct workspace_manager *wsman;
-	struct list_head *ws;
-
-	wsman = btrfs_compress_op[type]->workspace_manager;
-	while (!list_empty(&wsman->idle_ws)) {
-		ws = wsman->idle_ws.next;
-		list_del(ws);
-		free_workspace(type, ws);
-		atomic_dec(&wsman->total_ws);
-	}
-}
-
 /*
  * This finds an available workspace or allocates a new one.
  * If it's not possible to allocate a new one, waits until there's one.
@@ -1192,11 +1148,6 @@ int __init btrfs_init_compress(void)
 	if (!compr_pool.shrinker)
 		return -ENOMEM;
 
-	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_NONE);
-	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_ZLIB);
-	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_LZO);
-	zstd_init_workspace_manager(NULL);
-
 	spin_lock_init(&compr_pool.lock);
 	INIT_LIST_HEAD(&compr_pool.list);
 	compr_pool.count = 0;
@@ -1217,10 +1168,6 @@ void __cold btrfs_exit_compress(void)
 	btrfs_compr_pool_scan(NULL, NULL);
 	shrinker_free(compr_pool.shrinker);
 
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_NONE);
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_ZLIB);
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_LZO);
-	zstd_cleanup_workspace_manager();
 	bioset_exit(&btrfs_compressed_bioset);
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 40cb21e85dee..e9f5f821cf53 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -183,8 +183,6 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		size_t destlen);
 int zstd_alloc_workspace_manager(struct btrfs_fs_info *fs_info);
 void zstd_free_workspace_manager(struct btrfs_fs_info *fs_info);
-void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info);
-void zstd_cleanup_workspace_manager(void);
 struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level);
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 82407d7d9502..3456a1dcd420 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -68,8 +68,6 @@ struct workspace {
 	struct list_head list;
 };
 
-static struct workspace_manager wsm;
-
 void lzo_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -489,7 +487,6 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 }
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
-	.workspace_manager	= &wsm,
 	.max_level		= 1,
 	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 5fc045aeaa19..aecc58054045 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -34,8 +34,6 @@ struct workspace {
 	int level;
 };
 
-static struct workspace_manager wsm;
-
 struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
 	struct list_head *ws = btrfs_get_workspace(fs_info, BTRFS_COMPRESS_ZLIB, level);
@@ -483,7 +481,6 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 }
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
-	.workspace_manager	= &wsm,
 	.min_level		= 1,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 41019fcebc13..d514a73a4015 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -86,8 +86,6 @@ struct zstd_workspace_manager {
 	struct timer_list timer;
 };
 
-static struct zstd_workspace_manager wsm;
-
 static size_t zstd_ws_mem_sizes[ZSTD_BTRFS_MAX_LEVEL];
 
 static inline struct workspace *list_to_workspace(struct list_head *list)
@@ -212,31 +210,6 @@ int zstd_alloc_workspace_manager(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info)
-{
-	struct list_head *ws;
-	int i;
-
-	zstd_calc_ws_mem_sizes();
-
-	wsm.ops = &btrfs_zstd_compress;
-	spin_lock_init(&wsm.lock);
-	init_waitqueue_head(&wsm.wait);
-	timer_setup(&wsm.timer, zstd_reclaim_timer_fn, 0);
-
-	INIT_LIST_HEAD(&wsm.lru_list);
-	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++)
-		INIT_LIST_HEAD(&wsm.idle_ws[i]);
-
-	ws = zstd_alloc_workspace(fs_info, ZSTD_BTRFS_MAX_LEVEL);
-	if (IS_ERR(ws)) {
-		btrfs_warn(NULL, "cannot preallocate zstd compression workspace");
-	} else {
-		set_bit(ZSTD_BTRFS_MAX_LEVEL - 1, &wsm.active_map);
-		list_add(ws, &wsm.idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1]);
-	}
-}
-
 void zstd_free_workspace_manager(struct btrfs_fs_info *fs_info)
 {
 	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
@@ -260,26 +233,6 @@ void zstd_free_workspace_manager(struct btrfs_fs_info *fs_info)
 	kfree(zwsm);
 }
 
-void zstd_cleanup_workspace_manager(void)
-{
-	struct workspace *workspace;
-	int i;
-
-	spin_lock_bh(&wsm.lock);
-	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
-		while (!list_empty(&wsm.idle_ws[i])) {
-			workspace = container_of(wsm.idle_ws[i].next,
-						 struct workspace, list);
-			list_del(&workspace->list);
-			list_del(&workspace->lru_list);
-			zstd_free_workspace(&workspace->list);
-		}
-	}
-	spin_unlock_bh(&wsm.lock);
-
-	timer_delete_sync(&wsm.timer);
-}
-
 /*
  * Find workspace for given level.
  *
@@ -775,8 +728,6 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 }
 
 const struct btrfs_compress_op btrfs_zstd_compress = {
-	/* ZSTD uses own workspace manager */
-	.workspace_manager = NULL,
 	.min_level	= ZSTD_BTRFS_MIN_LEVEL,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
-- 
2.50.1


