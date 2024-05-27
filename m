Return-Path: <linux-btrfs+bounces-5297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C088CFCC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E23B1F23D00
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063A13A27D;
	Mon, 27 May 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YwS63syd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YwS63syd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D78139D1A;
	Mon, 27 May 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801889; cv=none; b=ZKjhdZxzjrug+WEScQANBbIKXQ+xK8pGookPJNm3bMcJsQj476M9kpTlKQ1gzBkjfjqiGj0pD+zcx9rsCeK9uHXjBt/orTkiHQXLxWyBiiyV6lCRSpROZKO8WgBQmBQEUEOoxNcq6iDOMYJxXrm/N/vI+ECtuUvNiZU/mxmyvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801889; c=relaxed/simple;
	bh=Q7D+m3l2vmACEdOqvae9ajJI7nYAKmVmjQAXd226dq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+8zbo9TH08aOxLHuYrzI5KOSAa6elEIM/daw41PAc4TeYsARjDpZR9M6tvD24jrypERWOKGlQfGdpVbsLRhtn2rfsq4tfq3b5gjzXpD9qhr3kwJZ+2pjrc115kM9Np/Qucj5OqgShovSqoCGB76EKol2Z2m9HKh94V0QUr3DHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YwS63syd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YwS63syd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 412441FC06;
	Mon, 27 May 2024 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716801885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cSPJQddEZEPITV3yBLPrgxEKYNRZkCiaMSkaYeATp8A=;
	b=YwS63sydchtN0IiU4BY55e7fnuMiHBdqliEXE6KVkncjlXNuLhkQhWfbEVCAkQdjAJLMwi
	GYFSnRfeZc6uEPM2aI44Lsl3ozoM83zUxXeR6zfAO4eqLRN/x+tsGhMWMs6gg/wygTmMYg
	VBZ0cAe48YvVygA32a1mPDEhQQfWmBY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YwS63syd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716801885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cSPJQddEZEPITV3yBLPrgxEKYNRZkCiaMSkaYeATp8A=;
	b=YwS63sydchtN0IiU4BY55e7fnuMiHBdqliEXE6KVkncjlXNuLhkQhWfbEVCAkQdjAJLMwi
	GYFSnRfeZc6uEPM2aI44Lsl3ozoM83zUxXeR6zfAO4eqLRN/x+tsGhMWMs6gg/wygTmMYg
	VBZ0cAe48YvVygA32a1mPDEhQQfWmBY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F07D913A6B;
	Mon, 27 May 2024 09:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ee1cKltRVGadHAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 27 May 2024 09:24:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Subject: [PATCH] btrfs: zlib: do not do unnecessary page copying for compression
Date: Mon, 27 May 2024 18:54:17 +0930
Message-ID: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 412441FC06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

[BUG]
In function zlib_compress_folios(), we handle the input by:

- If there are multiple pages left
  We copy the page content into workspace->buf, and use workspace->buf
  as input for compression.

  But on x86_64 (which doesn't support dfltcc), that buffer size is just
  one page, so we're wasting our CPU time copying the page for no
  benefit.

- If there is only one page left
  We use the mapped page address as input for compression.

The problem is, this means we will copy the whole input range except the
last page (can be as large as 124K), without much obvious benefit.

Meanwhile the cost is pretty obvious.

[POSSIBLE REASON]
The possible reason may be related to the support of S390 hardware zlib
decompression acceleration.

As we allocate 4 pages (4 * 4K) as workspace input buffer just for s390.

[FIX]
I checked the dfltcc code, there seems to be no requirement on the
input buffer size.
The function dfltcc_can_deflate() only checks:

- If the compression settings are supported
  Only level/w_bits/strategy/level_mask is checked.

- If the hardware supports

No mention at all on the input buffer size, thus I believe there is no
need to waste time doing the page copying.

Maybe the hardware acceleration is so good for s390 that they can offset
the page copying cost, but it's definitely a penalty for non-s390
systems.

So fix the problem by:

- Use the same buffer size
  No matter if dfltcc support is enabled or not

- Always use page address as input

Cc: linux-s390@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 67 +++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d9e5c88a0f85..9c88a841a060 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -65,21 +65,8 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 			zlib_inflate_workspacesize());
 	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL | __GFP_NOWARN);
 	workspace->level = level;
-	workspace->buf = NULL;
-	/*
-	 * In case of s390 zlib hardware support, allocate lager workspace
-	 * buffer. If allocator fails, fall back to a single page buffer.
-	 */
-	if (zlib_deflate_dfltcc_enabled()) {
-		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
-					 __GFP_NOMEMALLOC | __GFP_NORETRY |
-					 __GFP_NOWARN | GFP_NOIO);
-		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
-	}
-	if (!workspace->buf) {
-		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-		workspace->buf_size = PAGE_SIZE;
-	}
+	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	workspace->buf_size = PAGE_SIZE;
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
 
@@ -103,7 +90,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	struct folio *in_folio = NULL;
 	struct folio *out_folio = NULL;
 	unsigned long bytes_left;
-	unsigned int in_buf_folios;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
@@ -130,7 +116,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	folios[0] = out_folio;
 	nr_folios = 1;
 
-	workspace->strm.next_in = workspace->buf;
 	workspace->strm.avail_in = 0;
 	workspace->strm.next_out = cfolio_out;
 	workspace->strm.avail_out = PAGE_SIZE;
@@ -142,43 +127,19 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 		 */
 		if (workspace->strm.avail_in == 0) {
 			bytes_left = len - workspace->strm.total_in;
-			in_buf_folios = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
-					    workspace->buf_size / PAGE_SIZE);
-			if (in_buf_folios > 1) {
-				int i;
-
-				for (i = 0; i < in_buf_folios; i++) {
-					if (data_in) {
-						kunmap_local(data_in);
-						folio_put(in_folio);
-						data_in = NULL;
-					}
-					ret = btrfs_compress_filemap_get_folio(mapping,
-							start, &in_folio);
-					if (ret < 0)
-						goto out;
-					data_in = kmap_local_folio(in_folio, 0);
-					copy_page(workspace->buf + i * PAGE_SIZE,
-						  data_in);
-					start += PAGE_SIZE;
-				}
-				workspace->strm.next_in = workspace->buf;
-			} else {
-				if (data_in) {
-					kunmap_local(data_in);
-					folio_put(in_folio);
-					data_in = NULL;
-				}
-				ret = btrfs_compress_filemap_get_folio(mapping,
-						start, &in_folio);
-				if (ret < 0)
-					goto out;
-				data_in = kmap_local_folio(in_folio, 0);
-				start += PAGE_SIZE;
-				workspace->strm.next_in = data_in;
+			if (data_in) {
+				kunmap_local(data_in);
+				folio_put(in_folio);
+				data_in = NULL;
 			}
-			workspace->strm.avail_in = min(bytes_left,
-						       (unsigned long) workspace->buf_size);
+			ret = btrfs_compress_filemap_get_folio(mapping,
+					start, &in_folio);
+			if (ret < 0)
+				goto out;
+			data_in = kmap_local_folio(in_folio, 0);
+			start += PAGE_SIZE;
+			workspace->strm.next_in = data_in;
+			workspace->strm.avail_in = min(bytes_left, PAGE_SIZE);
 		}
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
-- 
2.45.1


