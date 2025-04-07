Return-Path: <linux-btrfs+bounces-12860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB2A7F027
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 00:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AE716C678
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD0222594;
	Mon,  7 Apr 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jJStaVhB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jJStaVhB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6B207E1A
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063493; cv=none; b=QkXJsj6v2XqLyXfsjwc2ahVZtSS3PRbNhTgu8hgrE8MPfdITacROtjLyEW4jcSaSzH88+tLpfcuLRkp5XlR9HbqW+7841YamyVwjfnEAiWeFS4zjZrMG4NWdcbnSyhUbhRrmbMVOghQJT+Q4rVeUsEU3YlyMmsqJtufuTABf6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063493; c=relaxed/simple;
	bh=7sjK2AXY8OxaD34OfY2oo1TF+p99ueL8S6hGLMGga6Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L337bcs1UXB5tyJcKlAHfnw2/Vw7+BWP6umVuNPEofFkuqwfd70vrGGQI7JIY+FUPgke0aHgvGfa5ivIHSd6BFA9WSyB8X5a31cYWu5JemNLsi3u3QHgduHQFyOIBeX/bSzYFDU2bRstCjJh62aX856XJxiw97mdlRh/ZjJqcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jJStaVhB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jJStaVhB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8527B21180
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744063488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPuOHbXi4oskqicmvU1+JwpGuK+arZ5PzVJA9zZ1EQo=;
	b=jJStaVhBR7c19acmBGlbKEReZPTffbbiEauAStgzE8FbD8bTCjgMUkaUEkQHRRkJ0MkS8k
	Uqf6D8LphwjotVPcMFVqHIIZQacuxnpzQ3K0Ve5hkgN3QzKwvwKYa+F0mh7/Qf6KCw7O4/
	UxCMdYFTsiE39N/IcSfAh++fEKeHNRk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744063488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPuOHbXi4oskqicmvU1+JwpGuK+arZ5PzVJA9zZ1EQo=;
	b=jJStaVhBR7c19acmBGlbKEReZPTffbbiEauAStgzE8FbD8bTCjgMUkaUEkQHRRkJ0MkS8k
	Uqf6D8LphwjotVPcMFVqHIIZQacuxnpzQ3K0Ve5hkgN3QzKwvwKYa+F0mh7/Qf6KCw7O4/
	UxCMdYFTsiE39N/IcSfAh++fEKeHNRk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F1813A4B
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 22:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qcrZIf9L9GeeKwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Apr 2025 22:04:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: prepare compreesion paths for large data folios
Date: Tue,  8 Apr 2025 07:34:30 +0930
Message-ID: <4a76fdcba3b1707714fa6b08f28f955c35cae0ee.1744063163.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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

All compression algorithms inside btrfs are not supporting
large folios due to the following points:

- btrfs_calc_input_length() is assuming page sized folio

- kmap_local_folio() usages are using offset_in_page()

Prepare them to support large data folios by:

- Add a folio parameter to btrfs_calc_input_length()
  And use that folio parameter to calculate the correct length.

  Since we're here, also add extra ASSERT()s to make sure the parameter
  @cur is inside the folio range.

  This affects only zlib and zstd. Lzo compresses at most one block one
  time, thus not affected.

- Use offset_in_folio() to calculate the kmap_local_folio() offset
  This affects all 3 algorithms.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is exposed by the fstests run btrfs/138 with large data folios
enabled, which verify the contents of compressed extents and found out
that the compressed data is all duplication of the first page.

That's the only new regression exposed during my large data folios runs.
The final enablement patch will be sent when all dependent patches are
mreged.
---
 fs/btrfs/compression.h | 12 +++++++++---
 fs/btrfs/lzo.c         |  5 ++---
 fs/btrfs/zlib.c        |  7 +++----
 fs/btrfs/zstd.c        |  8 ++++----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index df198623cc08..d3a61d5fb425 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -11,7 +11,9 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
+#include <linux/pagemap.h>
 #include "bio.h"
+#include "messages.h"
 
 struct address_space;
 struct page;
@@ -73,11 +75,15 @@ struct compressed_bio {
 };
 
 /* @range_end must be exclusive. */
-static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
+static inline u32 btrfs_calc_input_length(struct folio *folio,
+					  u64 range_end, u64 cur)
 {
-	u64 page_end = round_down(cur, PAGE_SIZE) + PAGE_SIZE;
+	u64 folio_end = folio_pos(folio) + folio_size(folio);
 
-	return min(range_end, page_end) - cur;
+	/* @cur must be inside the folio. */
+	ASSERT(folio_pos(folio) <= cur);
+	ASSERT(cur < folio_end);
+	return min(range_end, folio_end) - cur;
 }
 
 int __init btrfs_init_compress(void);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index a45bc11f8665..d403641889ca 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -252,9 +252,8 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 		/* Compress at most one sector of data each time */
 		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
 		ASSERT(in_len);
-		data_in = kmap_local_folio(folio_in, 0);
-		ret = lzo1x_1_compress(data_in +
-				       offset_in_page(cur_in), in_len,
+		data_in = kmap_local_folio(folio_in, offset_in_folio(folio_in, cur_in));
+		ret = lzo1x_1_compress(data_in, in_len,
 				       workspace->cbuf, &out_len,
 				       workspace->mem);
 		kunmap_local(data_in);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index b32aa05b288e..f8cd9d6d7e37 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -203,7 +203,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 				workspace->strm.next_in = workspace->buf;
 				workspace->strm.avail_in = copy_length;
 			} else {
-				unsigned int pg_off;
 				unsigned int cur_len;
 
 				if (data_in) {
@@ -215,9 +214,9 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 						start, &in_folio);
 				if (ret < 0)
 					goto out;
-				pg_off = offset_in_page(start);
-				cur_len = btrfs_calc_input_length(orig_end, start);
-				data_in = kmap_local_folio(in_folio, pg_off);
+				cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
+				data_in = kmap_local_folio(in_folio,
+							   offset_in_folio(in_folio, start));
 				start += cur_len;
 				workspace->strm.next_in = data_in;
 				workspace->strm.avail_in = cur_len;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index cd5f38d6fbaa..b20aeaf12424 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -426,8 +426,8 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 	if (ret < 0)
 		goto out;
-	cur_len = btrfs_calc_input_length(orig_end, start);
-	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_page(start));
+	cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
+	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = cur_len;
 
@@ -511,9 +511,9 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 			ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 			if (ret < 0)
 				goto out;
-			cur_len = btrfs_calc_input_length(orig_end, start);
+			cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
 			workspace->in_buf.src = kmap_local_folio(in_folio,
-							 offset_in_page(start));
+							 offset_in_folio(in_folio, start));
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = cur_len;
 		}
-- 
2.49.0


