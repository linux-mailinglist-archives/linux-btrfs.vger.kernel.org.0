Return-Path: <linux-btrfs+bounces-16954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6EB874D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19ED7C8234
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178D306D54;
	Thu, 18 Sep 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMOBhKKh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMOBhKKh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D068313D71
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236362; cv=none; b=jk52Ig2b3uMuLiGy/c3Kv+la03HEcFQKL96XWoFqHGEnYmxYxG7XRTG7bk3Hia4Jc59jROBIlQGrC2s42mckU7x6iQ3uTXsl3I0ckY3nyh0jo2N5M0lBPS6n9Qr3DnITs8cI2HwLOwkqP/jm22vBuZ4RjwZrbT8hmNVzW0zaNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236362; c=relaxed/simple;
	bh=x1bHkGXNSBmpBwTrqMYOjkhi+aL1AoUaNUcerqwoDnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/ARwatlA2Wqw9BMgKrRuhRsijzLuw5VotStz/c6KMq5Oqd4EYxCk5vI66yVwZpqQI9p3vlGYC+eugnb3fqnznCigZUzIjPXyUe5YeJzPIw6NfjQvavTi4JudyTW4PB5zPHo8JGRRufnBnnkT1ENifousIU5K6X7dNOsQs8ZWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMOBhKKh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMOBhKKh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A2AF3368A
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=os078w1PNeVWOygqgfQ5xClH/5VAeIfctxp+GmoXng8=;
	b=oMOBhKKhLTbc4AHL3ks/iDYTekQbTMb3Jz4ObUIQLLfcB7oo5oBX4kovLK38mn//P7qCMg
	D5isVUrTB4dQIztTUElVHQprKKQOdNp6qAcejp2Q4WDu68NcTGCUR5fR/MDNeMXbIYGW3b
	lOW55f37Zd1tTCbj84fi4aCjmSw4QtQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=os078w1PNeVWOygqgfQ5xClH/5VAeIfctxp+GmoXng8=;
	b=oMOBhKKhLTbc4AHL3ks/iDYTekQbTMb3Jz4ObUIQLLfcB7oo5oBX4kovLK38mn//P7qCMg
	D5isVUrTB4dQIztTUElVHQprKKQOdNp6qAcejp2Q4WDu68NcTGCUR5fR/MDNeMXbIYGW3b
	lOW55f37Zd1tTCbj84fi4aCjmSw4QtQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A541013A39
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EP+9GbWOzGjiYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: prepare zlib to support bs > ps cases
Date: Fri, 19 Sep 2025 08:28:34 +0930
Message-ID: <3e4a95c4da6556b47c1330d936b9ed881ee8931a.1758236028.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758236028.git.wqu@suse.com>
References: <cover.1758236028.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

This involves converting the following functions to use correct folio
sizes/shifts:

- zlib_compress_folios()
- zlib_decompress_bio()

There is a special handling for s390 hardware acceleration.
With bs > ps cases, we can go with 16K block size on s390 (which uses
fixed 4K page size).
In that case we do not need to do the buffer copy as our folio is large
enough for hardware acceleration.

So extract the s390 specific and folio size check into a helper,
need_special_buffer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index ccf77a0fa96c..889af188a924 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -53,6 +53,22 @@ void zlib_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
+/*
+ * For s390 hardware acceleration, the buffer size should be at least
+ * ZLIB_DFLTCC_BUF_SIZE to achieve the best performance.
+ *
+ * But if bs > ps we can have large enough folios that meets the s390 hardware
+ * handling.
+ */
+static bool need_special_buffer(struct btrfs_fs_info *fs_info)
+{
+	if (!zlib_deflate_dfltcc_enabled())
+		return false;
+	if (btrfs_min_folio_size(fs_info) >= ZLIB_DFLTCC_BUF_SIZE)
+		return false;
+	return true;
+}
+
 struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
 	const u32 blocksize = fs_info->sectorsize;
@@ -68,11 +84,7 @@ struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned i
 	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL | __GFP_NOWARN);
 	workspace->level = level;
 	workspace->buf = NULL;
-	/*
-	 * In case of s390 zlib hardware support, allocate lager workspace
-	 * buffer. If allocator fails, fall back to a single page buffer.
-	 */
-	if (zlib_deflate_dfltcc_enabled()) {
+	if (need_special_buffer(fs_info)) {
 		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
 					 __GFP_NOMEMALLOC | __GFP_NORETRY |
 					 __GFP_NOWARN | GFP_NOIO);
@@ -139,6 +151,8 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	int ret;
 	char *data_in = NULL;
 	char *cfolio_out;
@@ -147,7 +161,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	struct folio *out_folio = NULL;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
-	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
+	const unsigned long max_out = nr_dest_folios << min_folio_shift;
 	const u32 blocksize = fs_info->sectorsize;
 	const u64 orig_end = start + len;
 
@@ -179,7 +193,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	workspace->strm.next_in = workspace->buf;
 	workspace->strm.avail_in = 0;
 	workspace->strm.next_out = cfolio_out;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = min_folio_size;
 
 	while (workspace->strm.total_in < len) {
 		/*
@@ -191,10 +205,11 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			unsigned int copy_length = min(bytes_left, workspace->buf_size);
 
 			/*
-			 * This can only happen when hardware zlib compression is
-			 * enabled.
+			 * For s390 hardware accelerated zlib, and our folio is smaller
+			 * than the copy_length, we need to fill the buffer so that
+			 * we can take full advantage of hardware acceleration.
 			 */
-			if (copy_length > PAGE_SIZE) {
+			if (need_special_buffer(fs_info)) {
 				ret = copy_data_into_buffer(mapping, workspace,
 							    start, copy_length);
 				if (ret < 0)
@@ -258,7 +273,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			cfolio_out = folio_address(out_folio);
 			folios[nr_folios] = out_folio;
 			nr_folios++;
-			workspace->strm.avail_out = PAGE_SIZE;
+			workspace->strm.avail_out = min_folio_size;
 			workspace->strm.next_out = cfolio_out;
 		}
 		/* we're all done */
@@ -294,7 +309,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			cfolio_out = folio_address(out_folio);
 			folios[nr_folios] = out_folio;
 			nr_folios++;
-			workspace->strm.avail_out = PAGE_SIZE;
+			workspace->strm.avail_out = min_folio_size;
 			workspace->strm.next_out = cfolio_out;
 		}
 	}
@@ -320,20 +335,22 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	int ret = 0, ret2;
 	int wbits = MAX_WBITS;
 	char *data_in;
 	size_t total_out = 0;
 	unsigned long folio_in_index = 0;
 	size_t srclen = cb->compressed_len;
-	unsigned long total_folios_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
+	unsigned long total_folios_in = DIV_ROUND_UP(srclen, min_folio_size);
 	unsigned long buf_start;
 	struct folio **folios_in = cb->compressed_folios;
 
 	data_in = kmap_local_folio(folios_in[folio_in_index], 0);
 	workspace->strm.next_in = data_in;
-	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
+	workspace->strm.avail_in = min_t(size_t, srclen, min_folio_size);
 	workspace->strm.total_in = 0;
 
 	workspace->strm.total_out = 0;
@@ -394,7 +411,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			data_in = kmap_local_folio(folios_in[folio_in_index], 0);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
-			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
+			workspace->strm.avail_in = min(tmp, min_folio_size);
 		}
 	}
 	if (unlikely(ret != Z_STREAM_END)) {
-- 
2.50.1


