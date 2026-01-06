Return-Path: <linux-btrfs+bounces-20170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38348CF9527
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 783333066329
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5DB330B20;
	Tue,  6 Jan 2026 16:21:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1C3128BA
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716483; cv=none; b=UHTaNBWO72x1BPRYwUbeOZ62E5Nlqm8rpTfXe9KkO3NjpJQcaTgzTwbsmYf5UVivTB6mMFUObUBheepGDjhTLbdJEu0ywVxPtTX/1K67Xbhj/5qeUyoD4cvnScmGbN5CB5gRh0qE3fNFrU2f5fFEkJvk2Xb4uAbrhW5A/wVGAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716483; c=relaxed/simple;
	bh=v6mVXkPFf6em2MugiuXtwbJyndTgW+h667hW4b25dpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiEKmhR4rYWHwF7ULjhwLJqbrYkU69YtlgWBjTS7R7wTYlAaTM+uXY1nahqRw9ZYmOFRTLUWzLjHXQsBk3o1A23yk75vG4lHYPaqwmFk96ctiNeXI3EN2GHDG7zimNBoMAo1p6Eg8sYZcJVeYo8K0YCO0kH31JzFb6NgJuJTPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8E405BCD1;
	Tue,  6 Jan 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1E673EA63;
	Tue,  6 Jan 2026 16:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FituK382XWnLWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/12] btrfs: zstd: don't cache sectorsize in a local variable
Date: Tue,  6 Jan 2026 17:20:34 +0100
Message-ID: <8980a59aca9cb257150989aa2f2ea425ec7175a4.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B8E405BCD1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The sectorsize is used once or at most twice in the callbacks, no need
to cache it on stack. Minor effect on zstd_compress_folios() where it
saves 8 bytes of stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4edc5f6f63a110..75294302fe0530 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -370,7 +370,6 @@ void zstd_free_workspace(struct list_head *ws)
 
 struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 {
-	const u32 blocksize = fs_info->sectorsize;
 	struct workspace *workspace;
 
 	workspace = kzalloc(sizeof(*workspace), GFP_KERNEL);
@@ -383,7 +382,7 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 	workspace->req_level = level;
 	workspace->last_used = jiffies;
 	workspace->mem = kvmalloc(workspace->size, GFP_KERNEL | __GFP_NOWARN);
-	workspace->buf = kmalloc(blocksize, GFP_KERNEL);
+	workspace->buf = kmalloc(fs_info->sectorsize, GFP_KERNEL);
 	if (!workspace->mem || !workspace->buf)
 		goto fail;
 
@@ -411,7 +410,6 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
-	const u32 blocksize = fs_info->sectorsize;
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	unsigned long max_out = nr_dest_folios * min_folio_size;
 	unsigned int cur_len;
@@ -469,7 +467,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		}
 
 		/* Check to see if we are making it bigger */
-		if (*total_in + workspace->in_buf.pos > blocksize * 2 &&
+		if (*total_in + workspace->in_buf.pos > fs_info->sectorsize * 2 &&
 				*total_in + workspace->in_buf.pos <
 				*total_out + workspace->out_buf.pos) {
 			ret = -E2BIG;
@@ -589,7 +587,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	size_t srclen = cb->compressed_len;
 	zstd_dstream *stream;
 	int ret = 0;
-	const u32 blocksize = fs_info->sectorsize;
 	const unsigned int min_folio_size = btrfs_min_folio_size(fs_info);
 	unsigned long folio_in_index = 0;
 	unsigned long total_folios_in = DIV_ROUND_UP(srclen, min_folio_size);
@@ -614,7 +611,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = blocksize;
+	workspace->out_buf.size = fs_info->sectorsize;
 
 	while (1) {
 		size_t ret2;
@@ -675,7 +672,6 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct btrfs_fs_info *fs_info = btrfs_sb(folio_inode(dest_folio)->i_sb);
-	const u32 sectorsize = fs_info->sectorsize;
 	zstd_dstream *stream;
 	int ret = 0;
 	unsigned long to_copy = 0;
@@ -699,7 +695,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = sectorsize;
+	workspace->out_buf.size = fs_info->sectorsize;
 
 	/*
 	 * Since both input and output buffers should not exceed one sector,
-- 
2.51.1


