Return-Path: <linux-btrfs+bounces-12708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F9A77455
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 08:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D22C7A3073
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81741DF965;
	Tue,  1 Apr 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K83DH0eB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K83DH0eB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C61D8A10
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487982; cv=none; b=CNjfIVV6Rg/ryNkTWOVotTrsLCK62UR9BZdrlCZ/sUa1nstBRuiBoWnkMLqciUo/vmpjzDLY+AqeLA6QKR3ZiufzhvSjs0C5xLFA8eK7E/ZxINy3BmuIPdR9eHjPQ82PP0YmV8TlaIygaeD2GjJfsn8BOJqv4wjJbEL4mAOtS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487982; c=relaxed/simple;
	bh=am0hwctF5Abvj/or6q83mFw6VKc0YJ1TCMvbrmih/Ic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVsK/1d9XqSaAx6SnEnx5EEaXJA6ulT7PM3bV7NIIDAWg4Acz2XF7hTJ5ejfuY69qZpL5mRkPjX6RtWt3QFiL+divXrp+leRGOLp6AykoN0t+Gw79kAVeFhNxc4M7amVUUU294e7oljFeeCRTsqzAVE7ai4SIXOFxqUjSCWvR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K83DH0eB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K83DH0eB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FE3E1F38D
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743487978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uDw8IDwDCyQUdkXihcfDkyUhQB4hR+NuYVqx0b+gM4=;
	b=K83DH0eBuBrlgFOiW7tDn8pHwX8L5Y3WYxrz4zWLe/bxWn3DniPKgP7PVQHGFsw9q9EaEG
	urNfxaTi3lMKTJFevm2eh84Bf32jm0cMShoKXV94ihzQQ7JxBQIFty4cQZGGv4mWm3cwp4
	ofUG20bnAc4iqE31ULuZV3F6FcXYm38=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=K83DH0eB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743487978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uDw8IDwDCyQUdkXihcfDkyUhQB4hR+NuYVqx0b+gM4=;
	b=K83DH0eBuBrlgFOiW7tDn8pHwX8L5Y3WYxrz4zWLe/bxWn3DniPKgP7PVQHGFsw9q9EaEG
	urNfxaTi3lMKTJFevm2eh84Bf32jm0cMShoKXV94ihzQQ7JxBQIFty4cQZGGv4mWm3cwp4
	ofUG20bnAc4iqE31ULuZV3F6FcXYm38=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F38138A5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMj9DumD62dcPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 06:12:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix the file offset calculation inside btrfs_decompress_buf2page()
Date: Tue,  1 Apr 2025 16:42:33 +1030
Message-ID: <8fb7820d18bef8f661f807b3d96be2591aee6494.1743487686.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743487685.git.wqu@suse.com>
References: <cover.1743487685.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3FE3E1F38D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
index e7f8ee5d48a4..ee70f086c884 100644
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
+	return page_pgoff(folio, page) + bvec->bv_offset;
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


