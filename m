Return-Path: <linux-btrfs+bounces-16073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE9B25ACE
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1461C2313C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA382236E3;
	Thu, 14 Aug 2025 05:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TdvRCM2m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TdvRCM2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319921FF58
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149631; cv=none; b=GQEStDaxSfN4qf4UQAuH2arAQtPwD+LuNQ6HtyxF9P2M9g1a815aynMJw9uEfHE7oVHRBwbkZBbYghDa5Hu27jphgiyPfhNCluUR3a7ZVXG0/0tC2Q3HhFo6DhHMLut4r3rU4aOeRdDgZ7qphH9DeXsKRHlnl7Vy0W2eyVCsukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149631; c=relaxed/simple;
	bh=6a60sO53PDS0mJLYfIT5qprwQMz/qmaKCqVaLCykTXA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGLUs7VFNod5dk1sK5IFaeKwPeiyTENleKa0gxkgU0W+wMlT7/1u48SsivOKSvUCkXQuju0ziRhUUe9nq/NcIhjvKv5iGFYv5RlZNzOqeoO0jyow3Ss2j5rmMJGsF9orwHpd8mp3M+NWFy+PRfn07dS+Csyppb06r6P2dlXcXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TdvRCM2m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TdvRCM2m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59E71F7C7
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I64duUpa9M4TN3FJnq3AyQKxGrmx6LzHN+7gex8cvlk=;
	b=TdvRCM2mQwzHf9w0RAi64R36LiKWsmEj60zgSU5qkbC/DkWz80VEcle8QAXk28w2orEwm4
	MOSFWkyUKlqyKr+oCjhJRwL0YIMtmdvYtA+vD1BAo3v+gj3Q/zhiY3lCosq8pn3VXbe/UK
	KWycIBYM6ShX9pTNjwU3UJmJa9/wUFM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I64duUpa9M4TN3FJnq3AyQKxGrmx6LzHN+7gex8cvlk=;
	b=TdvRCM2mQwzHf9w0RAi64R36LiKWsmEj60zgSU5qkbC/DkWz80VEcle8QAXk28w2orEwm4
	MOSFWkyUKlqyKr+oCjhJRwL0YIMtmdvYtA+vD1BAo3v+gj3Q/zhiY3lCosq8pn3VXbe/UK
	KWycIBYM6ShX9pTNjwU3UJmJa9/wUFM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5B8A13479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yPOIHzl1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: add an fs_info parameter for compression workspace manager
Date: Thu, 14 Aug 2025 15:03:20 +0930
Message-ID: <626bf695630779b72ca18a0da37882d73af8adbd.1755148754.git.wqu@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BACKGROUND]
Currently btrfs shares workspaces and their managers for all filesystems,
this is mostly fine as all those workspaces are using page size based
buffers, and btrfs only support block size (bs) <= page size (ps).

This means even if bs < ps, we at most waste some buffer space in the
workspace, but everything will still work fine.

The problem here is that is limiting our support for bs > ps cases.

As now a workspace now may need larger buffer to handle bs > ps cases,
but since the pool has no way to distinguish different workspaces, a
regular workspace (which is still using buffer size based on ps) can be
passed to a btrfs whose bs > ps.

In that case the buffer is not large enough, and will cause various
problems.

[ENHANCEMENT]
To prepare for the per-fs workspace migration, add an fs_info parameter
to all workspace related functions.

For now this new fs_info parameter is not yet utilized.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 73 ++++++++++++++++++++++--------------------
 fs/btrfs/compression.h | 23 +++++++------
 fs/btrfs/lzo.c         |  2 +-
 fs/btrfs/zlib.c        |  6 ++--
 fs/btrfs/zstd.c        | 12 +++----
 5 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 54525d700663..ddc18cec1e37 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -702,7 +702,7 @@ static void free_heuristic_ws(struct list_head *ws)
 	kfree(workspace);
 }
 
-static struct list_head *alloc_heuristic_ws(void)
+static struct list_head *alloc_heuristic_ws(struct btrfs_fs_info *fs_info)
 {
 	struct heuristic_ws *ws;
 
@@ -741,13 +741,13 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	&btrfs_zstd_compress,
 };
 
-static struct list_head *alloc_workspace(int type, int level)
+static struct list_head *alloc_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws();
-	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(level);
-	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace();
-	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(level);
+	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(fs_info);
+	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(fs_info, level);
+	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(fs_info);
+	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(fs_info, level);
 	default:
 		/*
 		 * This can't happen, the type is validated several times
@@ -773,7 +773,7 @@ static void free_workspace(int type, struct list_head *ws)
 	}
 }
 
-static void btrfs_init_workspace_manager(int type)
+static void btrfs_init_workspace_manager(struct btrfs_fs_info *fs_info, int type)
 {
 	struct workspace_manager *wsm;
 	struct list_head *workspace;
@@ -788,9 +788,9 @@ static void btrfs_init_workspace_manager(int type)
 	 * Preallocate one workspace for each compression type so we can
 	 * guarantee forward progress in the worst case
 	 */
-	workspace = alloc_workspace(type, 0);
+	workspace = alloc_workspace(fs_info, type, 0);
 	if (IS_ERR(workspace)) {
-		btrfs_warn(NULL,
+		btrfs_warn(fs_info,
 			   "cannot preallocate compression workspace, will try later");
 	} else {
 		atomic_set(&wsm->total_ws, 1);
@@ -819,7 +819,7 @@ static void btrfs_cleanup_workspace_manager(int type)
  * Preallocation makes a forward progress guarantees and we do not return
  * errors.
  */
-struct list_head *btrfs_get_workspace(int type, int level)
+struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
 	struct workspace_manager *wsm;
 	struct list_head *workspace;
@@ -867,7 +867,7 @@ struct list_head *btrfs_get_workspace(int type, int level)
 	 * context of btrfs_compress_bio/btrfs_compress_pages
 	 */
 	nofs_flag = memalloc_nofs_save();
-	workspace = alloc_workspace(type, level);
+	workspace = alloc_workspace(fs_info, type, level);
 	memalloc_nofs_restore(nofs_flag);
 
 	if (IS_ERR(workspace)) {
@@ -890,7 +890,7 @@ struct list_head *btrfs_get_workspace(int type, int level)
 					/* no burst */ 1);
 
 			if (__ratelimit(&_rs))
-				btrfs_warn(NULL,
+				btrfs_warn(fs_info,
 				"no compression workspaces, low memory, retrying");
 		}
 		goto again;
@@ -898,13 +898,13 @@ struct list_head *btrfs_get_workspace(int type, int level)
 	return workspace;
 }
 
-static struct list_head *get_workspace(int type, int level)
+static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(type, level);
-	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(level);
-	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(type, level);
-	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(level);
+	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(fs_info, type, level);
+	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(fs_info, level);
+	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, type, level);
+	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, level);
 	default:
 		/*
 		 * This can't happen, the type is validated several times
@@ -918,7 +918,7 @@ static struct list_head *get_workspace(int type, int level)
  * put a workspace struct back on the list or free it if we have enough
  * idle ones sitting around
  */
-void btrfs_put_workspace(int type, struct list_head *ws)
+void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws)
 {
 	struct workspace_manager *wsm;
 	struct list_head *idle_ws;
@@ -949,13 +949,13 @@ void btrfs_put_workspace(int type, struct list_head *ws)
 	cond_wake_up(ws_wait);
 }
 
-static void put_workspace(int type, struct list_head *ws)
+static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(type, ws);
-	case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(type, ws);
-	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(type, ws);
-	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(ws);
+	case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(fs_info, type, ws);
+	case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(fs_info, type, ws);
+	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, type, ws);
+	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
 	default:
 		/*
 		 * This can't happen, the type is validated several times
@@ -1038,29 +1038,31 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const unsigned long orig_len = *total_out;
 	struct list_head *workspace;
 	int ret;
 
 	level = btrfs_compress_set_level(type, level);
-	workspace = get_workspace(type, level);
+	workspace = get_workspace(fs_info, type, level);
 	ret = compression_compress_pages(type, workspace, inode, start, folios,
 					 out_folios, total_in, total_out);
 	/* The total read-in bytes should be no larger than the input. */
 	ASSERT(*total_in <= orig_len);
-	put_workspace(type, workspace);
+	put_workspace(fs_info, type, workspace);
 	return ret;
 }
 
 static int btrfs_decompress_bio(struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct list_head *workspace;
 	int ret;
 	int type = cb->compress_type;
 
-	workspace = get_workspace(type, 0);
+	workspace = get_workspace(fs_info, type, 0);
 	ret = compression_decompress_bio(workspace, cb);
-	put_workspace(type, workspace);
+	put_workspace(fs_info, type, workspace);
 
 	if (!ret)
 		zero_fill_bio(&cb->orig_bbio->bio);
@@ -1087,10 +1089,10 @@ int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 	 */
 	ASSERT(dest_pgoff + destlen <= PAGE_SIZE && destlen <= sectorsize);
 
-	workspace = get_workspace(type, 0);
+	workspace = get_workspace(fs_info, type, 0);
 	ret = compression_decompress(type, workspace, data_in, dest_folio,
 				     dest_pgoff, srclen, destlen);
-	put_workspace(type, workspace);
+	put_workspace(fs_info, type, workspace);
 
 	return ret;
 }
@@ -1106,10 +1108,10 @@ int __init btrfs_init_compress(void)
 	if (!compr_pool.shrinker)
 		return -ENOMEM;
 
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
-	zstd_init_workspace_manager();
+	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_NONE);
+	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_ZLIB);
+	btrfs_init_workspace_manager(NULL, BTRFS_COMPRESS_LZO);
+	zstd_init_workspace_manager(NULL);
 
 	spin_lock_init(&compr_pool.lock);
 	INIT_LIST_HEAD(&compr_pool.list);
@@ -1543,7 +1545,8 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
  */
 int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end)
 {
-	struct list_head *ws_list = get_workspace(0, 0);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct list_head *ws_list = get_workspace(fs_info, 0, 0);
 	struct heuristic_ws *ws;
 	u32 i;
 	u8 byte;
@@ -1612,7 +1615,7 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 
 out:
-	put_workspace(0, ws_list);
+	put_workspace(fs_info, 0, ws_list);
 	return ret;
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index bdb0125ddcb0..62c304767d3a 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -75,6 +75,11 @@ struct compressed_bio {
 	struct btrfs_bio bbio;
 };
 
+static inline struct btrfs_fs_info *cb_to_fs_info(const struct compressed_bio *cb)
+{
+	return cb->bbio.fs_info;
+}
+
 /* @range_end must be exclusive. */
 static inline u32 btrfs_calc_input_length(struct folio *folio, u64 range_end, u64 cur)
 {
@@ -128,8 +133,8 @@ struct workspace_manager {
 	wait_queue_head_t ws_wait;
 };
 
-struct list_head *btrfs_get_workspace(int type, int level);
-void btrfs_put_workspace(int type, struct list_head *ws);
+struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, int level);
+void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws);
 
 struct btrfs_compress_op {
 	struct workspace_manager *workspace_manager;
@@ -162,9 +167,9 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
-struct list_head *zlib_alloc_workspace(unsigned int level);
+struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
-struct list_head *zlib_get_workspace(unsigned int level);
+struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level);
 
 int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
@@ -173,7 +178,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
-struct list_head *lzo_alloc_workspace(void);
+struct list_head *lzo_alloc_workspace(struct btrfs_fs_info *fs_info);
 void lzo_free_workspace(struct list_head *ws);
 
 int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
@@ -183,11 +188,11 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
-void zstd_init_workspace_manager(void);
+void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info);
 void zstd_cleanup_workspace_manager(void);
-struct list_head *zstd_alloc_workspace(int level);
+struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level);
 void zstd_free_workspace(struct list_head *ws);
-struct list_head *zstd_get_workspace(int level);
-void zstd_put_workspace(struct list_head *ws);
+struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level);
+void zstd_put_workspace(struct btrfs_fs_info *fs_info, struct list_head *ws);
 
 #endif
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 7b46aef7dd93..82407d7d9502 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -80,7 +80,7 @@ void lzo_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-struct list_head *lzo_alloc_workspace(void)
+struct list_head *lzo_alloc_workspace(struct btrfs_fs_info *fs_info)
 {
 	struct workspace *workspace;
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 33dc7e7b5c36..5fc045aeaa19 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -36,9 +36,9 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-struct list_head *zlib_get_workspace(unsigned int level)
+struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
-	struct list_head *ws = btrfs_get_workspace(BTRFS_COMPRESS_ZLIB, level);
+	struct list_head *ws = btrfs_get_workspace(fs_info, BTRFS_COMPRESS_ZLIB, level);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
 	workspace->level = level;
@@ -55,7 +55,7 @@ void zlib_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-struct list_head *zlib_alloc_workspace(unsigned int level)
+struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
 	struct workspace *workspace;
 	int workspacesize;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index d521187336a5..24bf5cfaecec 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -182,7 +182,7 @@ static void zstd_calc_ws_mem_sizes(void)
 	}
 }
 
-void zstd_init_workspace_manager(void)
+void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info)
 {
 	struct list_head *ws;
 	int i;
@@ -198,7 +198,7 @@ void zstd_init_workspace_manager(void)
 	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++)
 		INIT_LIST_HEAD(&wsm.idle_ws[i]);
 
-	ws = zstd_alloc_workspace(ZSTD_BTRFS_MAX_LEVEL);
+	ws = zstd_alloc_workspace(fs_info, ZSTD_BTRFS_MAX_LEVEL);
 	if (IS_ERR(ws)) {
 		btrfs_warn(NULL, "cannot preallocate zstd compression workspace");
 	} else {
@@ -276,7 +276,7 @@ static struct list_head *zstd_find_workspace(int level)
  * attempt to allocate a new workspace.  If we fail to allocate one due to
  * memory pressure, go to sleep waiting for the max level workspace to free up.
  */
-struct list_head *zstd_get_workspace(int level)
+struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level)
 {
 	struct list_head *ws;
 	unsigned int nofs_flag;
@@ -291,7 +291,7 @@ struct list_head *zstd_get_workspace(int level)
 		return ws;
 
 	nofs_flag = memalloc_nofs_save();
-	ws = zstd_alloc_workspace(level);
+	ws = zstd_alloc_workspace(fs_info, level);
 	memalloc_nofs_restore(nofs_flag);
 
 	if (IS_ERR(ws)) {
@@ -318,7 +318,7 @@ struct list_head *zstd_get_workspace(int level)
  * isn't set, it is also set here.  Only the max level workspace tries and wakes
  * up waiting workspaces.
  */
-void zstd_put_workspace(struct list_head *ws)
+void zstd_put_workspace(struct btrfs_fs_info *fs_info, struct list_head *ws)
 {
 	struct workspace *workspace = list_to_workspace(ws);
 
@@ -357,7 +357,7 @@ void zstd_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-struct list_head *zstd_alloc_workspace(int level)
+struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 {
 	struct workspace *workspace;
 
-- 
2.50.1


