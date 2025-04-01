Return-Path: <linux-btrfs+bounces-12715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A4A775A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D3C188B753
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA71E8320;
	Tue,  1 Apr 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aW2EdjjM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aW2EdjjM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF892D05E
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493870; cv=none; b=bdexvCgwqkrtcHm0DbqgrXVZVgl/eM2kLB74R1F5cbjZtgPfYaa9ACDBmJZ0FK1d04iCf3pobSvTyBhkFKHEWQC0Djq1gegS+ZPkPmt6EOBQYSRww2ZBnAWQZHSXn5e1VyB8pTG4j26OY4dBDFVI3UnARLCVaDPn/OOhUPDk5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493870; c=relaxed/simple;
	bh=tBHGu9Cb4sFRJMJwOpy5Y8a0SfXlOGBmeasqIjzADUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/sESoPrDTx1XG8EbP6oKWTcrH9uoRJmlCILw+uZrg8PCTW4shofNch2EuPu8zI7J+0aK825dAFKA3PvneeVGGkJDTilL1dBIH2epNqYWny4cOL5MtOE6Vx2X71ceBcr4hthb4uDBGRWk0vWPTBpBNqmgS5MO7KO/kwi9LzIzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aW2EdjjM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aW2EdjjM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3082211E5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743493854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FGpj7Hb+w1Qr6+LxmeVvAC4ZqtVUTYNds0m/tr/MHg=;
	b=aW2EdjjMa94DjYhYHy/WBSYYmSnRK5E1TefUcnh1aVxL1Do6T56LTrwUkzcAGyXa7xCNXi
	B9od+4wFoUU/ll9BYd5kzh3MKPdOjyNI4CLmfclLk7ccHE8EAXrUYU/MqB5ySMH0kjLz20
	g/YUAaYJazMvnkghCqfyX8afPAzn5sY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aW2EdjjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743493854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FGpj7Hb+w1Qr6+LxmeVvAC4ZqtVUTYNds0m/tr/MHg=;
	b=aW2EdjjMa94DjYhYHy/WBSYYmSnRK5E1TefUcnh1aVxL1Do6T56LTrwUkzcAGyXa7xCNXi
	B9od+4wFoUU/ll9BYd5kzh3MKPdOjyNI4CLmfclLk7ccHE8EAXrUYU/MqB5ySMH0kjLz20
	g/YUAaYJazMvnkghCqfyX8afPAzn5sY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08FF3138A5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aHUWL92a62egXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 07:50:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: fix the file offset calculation inside btrfs_decompress_buf2page()
Date: Tue,  1 Apr 2025 18:20:29 +1030
Message-ID: <235ae192f8d1f9b525aa00a27fd476e2979ada1b.1743493507.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743493507.git.wqu@suse.com>
References: <cover.1743493507.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3082211E5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG WITH EXPERIMENTAL LARGE FOLIOS]
When testing the experimental large data folio support with compression,
there are several ASSERT()s triggered from btrfs_decompress_buf2page()
when running fsstress with compress=zstd mount option:

- ASSERT(copy_len) from btrfs_decompress_buf2page()
- VM_BUG_ON(offset + len > PAGE_SIZE) from memcpy_to_page()

[CAUSE]
Inside btrfs_decompress_buf2page(), we need to grab the file offset from
the current bvec.bv_page, to check if we even need to copy data into the
bio.

And since we're using single page bvec, and no large folio, every page
inside the folio should have its index properly setup.

But when large folios are involved, only the first page (aka, the head
page) of a large folio has its index properly initialized.

The other pages inside the large folio will not have their indexes
properly initialized.

Thus the page_offset() call inside btrfs_decompress_buf2page() will
result garbage, and completely screw up the @copy_len calculation.

[FIX]
Instead of using page->index directly, go with page_pgoff(), which can
handle non-head pages correctly.

So introduce a helper, file_offset_from_bvec(), to get the file offset
from a single page bio_vec, so the copy_len calculation can be done
correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e7f8ee5d48a4..cb954f9bc332 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1137,6 +1137,22 @@ void __cold btrfs_exit_compress(void)
 	bioset_exit(&btrfs_compressed_bioset);
 }
 
+/*
+ * The bvec is a single page bvec from a bio that contains folios from a filemap.
+ *
+ * Since the folios may be large one, and if the bv_page is not a head page of
+ * a large folio, then page->index is unreliable.
+ *
+ * Thus we need this helper to grab the proper file offset.
+ */
+static u64 file_offset_from_bvec(const struct bio_vec *bvec)
+{
+	const struct page *page = bvec->bv_page;
+	const struct folio *folio = page_folio(page);
+
+	return (page_pgoff(folio, page) << PAGE_SHIFT) + bvec->bv_offset;
+}
+
 /*
  * Copy decompressed data from working buffer to pages.
  *
@@ -1188,7 +1204,7 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		 * cb->start may underflow, but subtracting that value can still
 		 * give us correct offset inside the full decompressed extent.
 		 */
-		bvec_offset = page_offset(bvec.bv_page) + bvec.bv_offset - cb->start;
+		bvec_offset = file_offset_from_bvec(&bvec) - cb->start;
 
 		/* Haven't reached the bvec range, exit */
 		if (decompressed + buf_len <= bvec_offset)
-- 
2.49.0


