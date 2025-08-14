Return-Path: <linux-btrfs+bounces-16079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC4B25AD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B452A7BED
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B7228CA9;
	Thu, 14 Aug 2025 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="khtoyvyo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="khtoyvyo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579642248A8
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149653; cv=none; b=F3xianpLQRzFVHlvpFDRd9z0fYCjk2PZ+zbnad6SnGhHgZwMfhNbG1fPP05Vmh+vl07wNJ1G5zYdDTK1JmhJE8x/v36JxiIh8gN8XDv7WaKpWkNecFWkV4LQ6ILIwn2lWkuES1+58pPXMwgaDl1FoEZneXkQSGqwQ4g/ffxQn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149653; c=relaxed/simple;
	bh=ysB9C7aPqI6ApKZKopHDQrcupvejqDpBFqcalrF1Bb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWAkALh62gkudiTLYxbt5kF0j5uxItIrZkHIIVrNaO7t3Kmbd3tWGl2tHHVufaVGyA/ZqHB99ErhKmRk6+KxcqnEaOqCI1GU3iDluzGpF9Q6X8peN8MtygjniyEAp/D5YtW82L8jlSzAxIoUyHXGU1670+EoATfIF2AXdscg0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=khtoyvyo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=khtoyvyo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C9F21F7D6
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJFeHuoDiwzlzIbeqoPSdVO0VJlfVhQp/7l59lLMiZo=;
	b=khtoyvyoQLXP90Euy7a8gFaRTgB353jU55+XmuXwFyxtlAVNIYjajpMcHlGj+s8iWR7KO7
	CQiEGlvKvDXvLKbH6PIkpdl59DSzfBJeDf91wiV3hlohLHt0SYdrGrQ9+MaWO1jqCRlwUF
	oV250uTZDPG7p+pWndeBDWzAmKf9s5c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=khtoyvyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJFeHuoDiwzlzIbeqoPSdVO0VJlfVhQp/7l59lLMiZo=;
	b=khtoyvyoQLXP90Euy7a8gFaRTgB353jU55+XmuXwFyxtlAVNIYjajpMcHlGj+s8iWR7KO7
	CQiEGlvKvDXvLKbH6PIkpdl59DSzfBJeDf91wiV3hlohLHt0SYdrGrQ9+MaWO1jqCRlwUF
	oV250uTZDPG7p+pWndeBDWzAmKf9s5c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E8F813479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uGogOkF1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: reduce workspace buffer space to block size
Date: Thu, 14 Aug 2025 15:03:26 +0930
Message-ID: <a7f4b79beb03dd6eafbff7feb93158ad4f40e10d.1755148754.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1C9F21F7D6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Currently the compression workspace buffer size is always based on
PAGE_SIZE, but btrfs has support subpage sized block size for some time.

This means for one-shot compression algorithm like lzo, we're wasting
quite some memory if the block size is smaller than page size, as the
LZO only works on one block (thus one-shot).

On 64K page sized systems with 4K block size, it means we only need at
most 8K buffer space for lzo, but in reality we're allocating 64K
buffer.

So to reduce the memory usage, change all workspace buffer to base its
size based on block size other than page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/lzo.c  | 20 +++++++++++++-------
 fs/btrfs/zlib.c |  5 +++--
 fs/btrfs/zstd.c |  6 ++++--
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 2983214643da..047d90e216f6 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -58,9 +58,6 @@
  * 0x1000   | SegHdr N+1| Data payload N+1 ...                |
  */
 
-#define WORKSPACE_BUF_LENGTH	(lzo1x_worst_compress(PAGE_SIZE))
-#define WORKSPACE_CBUF_LENGTH	(lzo1x_worst_compress(PAGE_SIZE))
-
 struct workspace {
 	void *mem;
 	void *buf;	/* where decompressed data goes */
@@ -68,6 +65,15 @@ struct workspace {
 	struct list_head list;
 };
 
+static u32 workspace_buf_length(const struct btrfs_fs_info *fs_info)
+{
+	return lzo1x_worst_compress(fs_info->sectorsize);
+}
+static u32 workspace_cbuf_length(const struct btrfs_fs_info *fs_info)
+{
+	return lzo1x_worst_compress(fs_info->sectorsize);
+}
+
 void lzo_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -87,8 +93,8 @@ struct list_head *lzo_alloc_workspace(struct btrfs_fs_info *fs_info)
 		return ERR_PTR(-ENOMEM);
 
 	workspace->mem = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL | __GFP_NOWARN);
-	workspace->buf = kvmalloc(WORKSPACE_BUF_LENGTH, GFP_KERNEL | __GFP_NOWARN);
-	workspace->cbuf = kvmalloc(WORKSPACE_CBUF_LENGTH, GFP_KERNEL | __GFP_NOWARN);
+	workspace->buf = kvmalloc(workspace_buf_length(fs_info), GFP_KERNEL | __GFP_NOWARN);
+	workspace->cbuf = kvmalloc(workspace_cbuf_length(fs_info), GFP_KERNEL | __GFP_NOWARN);
 	if (!workspace->mem || !workspace->buf || !workspace->cbuf)
 		goto fail;
 
@@ -384,7 +390,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
 
-		if (unlikely(seg_len > WORKSPACE_CBUF_LENGTH)) {
+		if (unlikely(seg_len > workspace_cbuf_length(fs_info))) {
 			struct btrfs_inode *inode = cb->bbio.inode;
 
 			/*
@@ -444,7 +450,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	const u32 sectorsize = fs_info->sectorsize;
 	size_t in_len;
 	size_t out_len;
-	size_t max_segment_len = WORKSPACE_BUF_LENGTH;
+	size_t max_segment_len = workspace_buf_length(fs_info);
 	int ret = 0;
 
 	if (srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2)
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8e0bf34e0998..d72566a87afa 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -55,6 +55,7 @@ void zlib_free_workspace(struct list_head *ws)
 
 struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
+	const u32 blocksize = fs_info->sectorsize;
 	struct workspace *workspace;
 	int workspacesize;
 
@@ -78,8 +79,8 @@ struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned i
 		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
 	}
 	if (!workspace->buf) {
-		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-		workspace->buf_size = PAGE_SIZE;
+		workspace->buf = kmalloc(blocksize, GFP_KERNEL);
+		workspace->buf_size = blocksize;
 	}
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 63faeb3ed9ac..b11a87842cda 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -370,6 +370,7 @@ void zstd_free_workspace(struct list_head *ws)
 
 struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 {
+	const u32 blocksize = fs_info->sectorsize;
 	struct workspace *workspace;
 
 	workspace = kzalloc(sizeof(*workspace), GFP_KERNEL);
@@ -382,7 +383,7 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 	workspace->req_level = level;
 	workspace->last_used = jiffies;
 	workspace->mem = kvmalloc(workspace->size, GFP_KERNEL | __GFP_NOWARN);
-	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	workspace->buf = kmalloc(blocksize, GFP_KERNEL);
 	if (!workspace->mem || !workspace->buf)
 		goto fail;
 
@@ -590,6 +591,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	size_t srclen = cb->compressed_len;
 	zstd_dstream *stream;
 	int ret = 0;
+	const u32 blocksize = cb_to_fs_info(cb)->sectorsize;
 	unsigned long folio_in_index = 0;
 	unsigned long total_folios_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
 	unsigned long buf_start;
@@ -613,7 +615,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = PAGE_SIZE;
+	workspace->out_buf.size = blocksize;
 
 	while (1) {
 		size_t ret2;
-- 
2.50.1


