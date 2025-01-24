Return-Path: <linux-btrfs+bounces-11055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CEAA1B0B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 08:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554891887445
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F91DB121;
	Fri, 24 Jan 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jJq2/SHj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dj17kDsQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9C33998
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702564; cv=none; b=achbOtBdpoW9v2svDDodVwpD9ClpfycQlO8y7V0/2ntTUwYiEYiRllCviHqX05N+Iu+h51xAX1zp76MZMCBzgE8YOXvZdXcBjmGKv2zDxtvx9SNFo7unJDIbJuZfkzQydNuVfQmG/HUr25buCb/77LcFra2Brz3OlNufkYKKjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702564; c=relaxed/simple;
	bh=zF6ALYLz0N569QsXqBoZ3Z/LEOQbBckGFe47rIC313M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6+gzHpVKhz1kYmekwtmGnVe9mwKM/rQebjDaCnmVKbsJ/w+enQUob6TPKlKcSh6Vi7JTeKKPF26Hp2nfdj6di9vtkQxO00YkLTQKz3SMfLkwhxaYK9mQLdXJfCRGuNvAjtlIL9cfaCitO5Txq5jQoKK/SZFrNorXticvhnHSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jJq2/SHj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dj17kDsQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14A41F38C;
	Fri, 24 Jan 2025 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737702022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TcS4uUNoOXXJl1L1o7v6uBLjpJMqvEjb+m5s9jMnlNY=;
	b=jJq2/SHjpgjJP0OomrFHO2oczE5x1bspCWrKDPpbHOIl+uZFOjOis4+uK8jmJooAwfZexB
	SGo4kTEOUs7RQ07KdVX9YKspmX+ub68XmCvInRvOVamY358ZiAR77y56yaYpAIhI0BDfY6
	IIpRQRyKqcZv9CBEEoYl9fP4Tnu9pyA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737702020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TcS4uUNoOXXJl1L1o7v6uBLjpJMqvEjb+m5s9jMnlNY=;
	b=Dj17kDsQQ2m0I+DVwQ6u5NCxD8SirSPbluHU+L2VfoqYKcAXy7s1f/y6XW6g2W3Tw83V0s
	UpMK/vRpN5L+ym0Mp+ULogskSCxFp0Rc5snGZTGYBQXykWWzx481UTUpPhGOT1NMwV0bg1
	OzKQCo5qd5JlqAu4lG0c8AWPRsGThlc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF936139CB;
	Fri, 24 Jan 2025 07:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QlTWK4M6k2dTbQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 24 Jan 2025 07:00:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH] btrfs: zlib: refactor S390x HW acceleration buffer preparation
Date: Fri, 24 Jan 2025 17:29:58 +1030
Message-ID: <bee6ac5945df3db876a553dbf6d0dd546f145aa7.1737701962.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Currently for s390x HW zlib compression, to get the best performance we
need a buffer size which is larger than a page.

This means we need to copy multiple pages into workspace->buf, then use
that buffer as zlib compression input.

Currently it's hardcoded using page sized folio, and all the handling
are deep inside a loop.

Refactor the code by:

- Introduce a dedicated helper to do the buffer copy
  The new helper will be called copy_data_into_buffer().

- Add extra ASSERT()s
  * Make sure we only go into the function for hardware acceleration
  * Make sure we still get page sized folio

- Prepare for future larger folios
  This means we will rely on the folio size, other than PAGE_SIZE to do
  the copy.

- Handle the folio mapping and unmapping inside the helper function
  For S390x hardware acceleration case, it never utilize the @data_in
  pointer, thus we can do folio mapping/unmapping all inside the function.

Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Hi Mikhail,

Mind to give this patch a test on S390x? As I do not have easy access to
such system.

And I hope I won't need to bother you again when we enable larger folios
for btrfs in the near future.

Thanks,
Qu
---
 fs/btrfs/zlib.c | 82 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c9e92c6941ec..7d81d9a0b3a0 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -94,6 +94,47 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
+/*
+ * Helper for S390x with hardware zlib compression support.
+ *
+ * That hardware acceleration requires a buffer size larger than a single page
+ * to get ideal performance, thus we need to do the memory copy other than
+ * use the page cache directly as input buffer.
+ */
+static int copy_data_into_buffer(struct address_space *mapping,
+				 struct workspace *workspace, u64 filepos,
+				 unsigned long length)
+{
+	u64 cur = filepos;
+
+	/* It's only for hardware accelerated zlib code. */
+	ASSERT(zlib_deflate_dfltcc_enabled());
+
+	while (cur < filepos + length) {
+		struct folio *folio;
+		void *data_in;
+		unsigned int offset;
+		unsigned long copy_length;
+		int ret;
+
+		ret = btrfs_compress_filemap_get_folio(mapping, cur, &folio);
+		if (ret < 0)
+			return ret;
+		/* No larger folio support yet. */
+		ASSERT(!folio_test_large(folio));
+
+		offset = offset_in_folio(folio, cur);
+		copy_length = min(folio_size(folio) - offset,
+				  filepos + length - cur);
+
+		data_in = kmap_local_folio(folio, offset);
+		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
+		kunmap_local(data_in);
+		cur += copy_length;
+	}
+	return 0;
+}
+
 int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
@@ -105,8 +146,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	int nr_folios = 0;
 	struct folio *in_folio = NULL;
 	struct folio *out_folio = NULL;
-	unsigned long bytes_left;
-	unsigned int in_buf_folios;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
@@ -150,34 +189,21 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 		 * the workspace buffer if required.
 		 */
 		if (workspace->strm.avail_in == 0) {
-			bytes_left = len - workspace->strm.total_in;
-			in_buf_folios = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
-					    workspace->buf_size / PAGE_SIZE);
-			if (in_buf_folios > 1) {
-				int i;
+			unsigned long bytes_left = len - workspace->strm.total_in;
+			unsigned int copy_length = min(bytes_left, workspace->buf_size);
 
-				/* S390 hardware acceleration path, not subpage. */
-				ASSERT(!btrfs_is_subpage(
-						inode_to_fs_info(mapping->host),
-						mapping));
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
+			/*
+			 * This can only happen when hardware zlib compression is
+			 * enabled.
+			 */
+			if (copy_length > PAGE_SIZE) {
+				ret = copy_data_into_buffer(mapping, workspace,
+							    start, copy_length);
+				if (ret < 0)
+					goto out;
+				start += copy_length;
 				workspace->strm.next_in = workspace->buf;
-				workspace->strm.avail_in = min(bytes_left,
-							       in_buf_folios << PAGE_SHIFT);
+				workspace->strm.avail_in = copy_length;
 			} else {
 				unsigned int pg_off;
 				unsigned int cur_len;
-- 
2.48.1


