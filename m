Return-Path: <linux-btrfs+bounces-15966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B6B1F9AD
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Aug 2025 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35FB7A5602
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Aug 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434CC23FC7D;
	Sun, 10 Aug 2025 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UlWM557+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UlWM557+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B71CBEB9
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754822730; cv=none; b=ZVbdzENjxtmxcVacvjRhP5Q32zJzdalKKn7s3DxEYl7GVm7F+H/NPlgWaihXelgwlrek+71usWRYZrPkUdS6SctwY7uz/lEDYkZO8Jn0/uQxpfCyTfFXm7NfIe3xV1mHlI9STMAdstDDXfiZ3lBl6meYdZDQNI6xLk3Jm6Kvwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754822730; c=relaxed/simple;
	bh=7knb6EEsY2I4YcioF1QrzsUNg4QS+GTMmGhalNbNyjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UVOYPNDAeP1sOGPw8OL7ZtLmJmpWvGPz0t6LSbN6H8MLtAKu7jq5U63h8oaQBGiI3tKTfdMsPmXipFthKlhNIoXGR8U4hu3Yb0Y0rtuNTrXhdlBapNmEvvBLKd9TEVQNS4kD6+r+/DRm7RzI6fXdZOyfAqOxx5qCRk2OO4ztqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UlWM557+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UlWM557+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62FE933E56
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754822720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mv0wMeduUVxXHGoY2zNcnmRQu3Y5NzN0rSRcPZ9sgzs=;
	b=UlWM557+nCeMwGYpyDgTDhM5vpc0ELvsbHd0L7GwHm4GBX662PSSqb3E9UkR/xlM6UgLus
	tvs+IaDJ94qQvxdDR6iU2s4gdyGsYM24B4AIWz75q7gfypDwg5FV2nK6pJ2StlQfnJI569
	UrScaWSz5dvQYPNcQF+BVjjq+Ih1ZfM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UlWM557+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754822720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mv0wMeduUVxXHGoY2zNcnmRQu3Y5NzN0rSRcPZ9sgzs=;
	b=UlWM557+nCeMwGYpyDgTDhM5vpc0ELvsbHd0L7GwHm4GBX662PSSqb3E9UkR/xlM6UgLus
	tvs+IaDJ94qQvxdDR6iU2s4gdyGsYM24B4AIWz75q7gfypDwg5FV2nK6pJ2StlQfnJI569
	UrScaWSz5dvQYPNcQF+BVjjq+Ih1ZfM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9443E13316
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 10:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nnGqFD94mGjzMgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 10:45:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: pass btrfs_inode pointer directly into btrfs_compress_folios()
Date: Sun, 10 Aug 2025 20:14:57 +0930
Message-ID: <fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 62FE933E56
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

For the 3 supported compression algorithms, two of them (zstd and zlib)
are already grabbing the btrfs inode for error messages.

It's more common to pass btrfs_inode and grab the address space from it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 12 ++++++------
 fs/btrfs/compression.h |  8 ++++----
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/lzo.c         |  5 +++--
 fs/btrfs/zlib.c        |  7 ++-----
 fs/btrfs/zstd.c        |  9 ++-------
 6 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f1c6338ae8b9..54525d700663 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -90,19 +90,19 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
 }
 
 static int compression_compress_pages(int type, struct list_head *ws,
-				      struct address_space *mapping, u64 start,
+				      struct btrfs_inode *inode, u64 start,
 				      struct folio **folios, unsigned long *out_folios,
 				      unsigned long *total_in, unsigned long *total_out)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB:
-		return zlib_compress_folios(ws, mapping, start, folios,
+		return zlib_compress_folios(ws, inode, start, folios,
 					    out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_LZO:
-		return lzo_compress_folios(ws, mapping, start, folios,
+		return lzo_compress_folios(ws, inode, start, folios,
 					   out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_ZSTD:
-		return zstd_compress_folios(ws, mapping, start, folios,
+		return zstd_compress_folios(ws, inode, start, folios,
 					    out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_NONE:
 	default:
@@ -1034,7 +1034,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * @total_out is an in/out parameter, must be set to the input length and will
  * be also used to return the total number of compressed bytes
  */
-int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
+int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
@@ -1044,7 +1044,7 @@ int btrfs_compress_folios(unsigned int type, int level, struct address_space *ma
 
 	level = btrfs_compress_set_level(type, level);
 	workspace = get_workspace(type, level);
-	ret = compression_compress_pages(type, workspace, mapping, start, folios,
+	ret = compression_compress_pages(type, workspace, inode, start, folios,
 					 out_folios, total_in, total_out);
 	/* The total read-in bytes should be no larger than the input. */
 	ASSERT(*total_in <= orig_len);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 1b38e707bbd9..bdb0125ddcb0 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -88,7 +88,7 @@ int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
 bool btrfs_compress_level_valid(unsigned int type, int level);
-int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
+int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inode,
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
 int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
@@ -155,7 +155,7 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 				     struct folio **in_folio_ret);
 
-int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
+int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
@@ -166,7 +166,7 @@ struct list_head *zlib_alloc_workspace(unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
 struct list_head *zlib_get_workspace(unsigned int level);
 
-int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
+int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
@@ -176,7 +176,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 struct list_head *lzo_alloc_workspace(void);
 void lzo_free_workspace(struct list_head *ws);
 
-int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
+int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 83e242bf42f3..4001cd2a08b1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -959,7 +959,7 @@ static void compress_file_range(struct btrfs_work *work)
 
 	/* Compression level is applied here. */
 	ret = btrfs_compress_folios(compress_type, compress_level,
-				    mapping, start, folios, &nr_folios, &total_in,
+				    inode, start, folios, &nr_folios, &total_in,
 				    &total_compressed);
 	if (ret)
 		goto mark_incompressible;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index d403641889ca..7b46aef7dd93 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -209,12 +209,13 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	return 0;
 }
 
-int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
+int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 			unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	struct folio *folio_in = NULL;
 	char *sizes_ptr;
 	const unsigned long max_nr_folio = *out_folios;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 5292cd341f70..21af68f93a2d 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -133,11 +133,12 @@ static int copy_data_into_buffer(struct address_space *mapping,
 	return 0;
 }
 
-int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
+int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
 	char *data_in = NULL;
 	char *cfolio_out;
@@ -155,8 +156,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 	ret = zlib_deflateInit(&workspace->strm, workspace->level);
 	if (unlikely(ret != Z_OK)) {
-		struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 		btrfs_err(inode->root->fs_info,
 	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
@@ -225,8 +224,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (unlikely(ret != Z_OK)) {
-			struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 			btrfs_warn(inode->root->fs_info,
 		"zlib compression failed, error %d root %llu inode %llu offset %llu",
 				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index ff0292615e1f..00159e0e921e 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -384,11 +384,12 @@ struct list_head *zstd_alloc_workspace(int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
+int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	zstd_cstream *stream;
 	int ret = 0;
 	int nr_folios = 0;
@@ -411,8 +412,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
 			workspace->size);
 	if (unlikely(!stream)) {
-		struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 		btrfs_err(inode->root->fs_info,
 	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
 			  workspace->req_level, btrfs_root_id(inode->root),
@@ -447,8 +446,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (unlikely(zstd_is_error(ret2))) {
-			struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 			btrfs_warn(inode->root->fs_info,
 "zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
 				   workspace->req_level, zstd_get_error_code(ret2),
@@ -522,8 +519,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		ret2 = zstd_end_stream(stream, &workspace->out_buf);
 		if (unlikely(zstd_is_error(ret2))) {
-			struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 			btrfs_err(inode->root->fs_info,
 "zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
 				  workspace->req_level, zstd_get_error_code(ret2),
-- 
2.50.1


