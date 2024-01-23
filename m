Return-Path: <linux-btrfs+bounces-1654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5D839981
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939C31F2B6D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30085C4E;
	Tue, 23 Jan 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JQApYBJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BQuMDb3A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JQApYBJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BQuMDb3A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA49823DC
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038046; cv=none; b=LdgUaIIks0m3NvKoLMc3cPMLxRgDMdwsoQDxtEWtma3RlmQ0VqFws6+fBlvklkVyEor2wNfoXN5L+dfg+eQq2ORnJRT6wQuQlnFO/wuy1E1flnyvWS79PhZC6r1OyyrEllJuJ8kPonsvqd4veK6Cea+qVNLX++KXSOXaGlHNnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038046; c=relaxed/simple;
	bh=7OE/OgkZiymhYYl7vhuYu64EouFAQnuAdCaLAxNcI2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5ITkYU3ACq+nWncGJsCzsf4w8nHCH98HeFmTvHitag+39Pkkj71eawtTdahtFts9mQGWwF3c/EbRTwmT86B2d6dNLe8h2K3jGt3QHmrXwpl1hl5SC6mXhADkcHhe0h6CD33Dl+/qtS88XGVI2HXZ514a4m4xo6sstud58NZxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JQApYBJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BQuMDb3A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JQApYBJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BQuMDb3A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2DF221E88;
	Tue, 23 Jan 2024 19:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvxq5K5aiXExb5RVHKgZXivD1fPQ/U++u+7iaKlTybI=;
	b=JQApYBJE6lszW6HbvlQdMH9u3sVC0GgQlNBp4UbxeMUxUqMRzALTcFgtIfEEmkqp5Vs3yJ
	tBCXQrWJBuU9lrIKwADpE1njCWIZ+WjGiKvT87sdWg+qBexIh48RlkgMw8IvhNVWZQxcBt
	3/Xx16ShLD7J4c11cmRSgT9feuBR/Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvxq5K5aiXExb5RVHKgZXivD1fPQ/U++u+7iaKlTybI=;
	b=BQuMDb3Aj4wD614rMC9TYut907YGQu3mAoeE5hIYhyromKPfIqlOus5seYd89dHvVOhoPc
	xfSrfk6t0fpJErBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvxq5K5aiXExb5RVHKgZXivD1fPQ/U++u+7iaKlTybI=;
	b=JQApYBJE6lszW6HbvlQdMH9u3sVC0GgQlNBp4UbxeMUxUqMRzALTcFgtIfEEmkqp5Vs3yJ
	tBCXQrWJBuU9lrIKwADpE1njCWIZ+WjGiKvT87sdWg+qBexIh48RlkgMw8IvhNVWZQxcBt
	3/Xx16ShLD7J4c11cmRSgT9feuBR/Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvxq5K5aiXExb5RVHKgZXivD1fPQ/U++u+7iaKlTybI=;
	b=BQuMDb3Aj4wD614rMC9TYut907YGQu3mAoeE5hIYhyromKPfIqlOus5seYd89dHvVOhoPc
	xfSrfk6t0fpJErBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A04913786;
	Tue, 23 Jan 2024 19:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BXSSOBoTsGXYQAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Jan 2024 19:27:22 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/3] btrfs: page to folio conversion in put_file_data()
Date: Tue, 23 Jan 2024 13:28:07 -0600
Message-ID: <12136abe1189961a89e4d10ffc7726c0f93df782.1706037337.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706037337.git.rgoldwyn@suse.com>
References: <cover.1706037337.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use folio instead of page in put_file_data().
Add a WARN_ON(folio_order(folio)) to make sure we are dealing with
PAGE_SIZE folios.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/send.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 141ab89fb63e..8885eadbb6a8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5257,10 +5257,11 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
 	unsigned pg_offset = offset_in_page(offset);
+	struct address_space *mapping = sctx->cur_inode->i_mapping;
 	int ret;
 
 	ret = put_data_header(sctx, len);
@@ -5273,44 +5274,45 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
-		page = find_lock_page(sctx->cur_inode->i_mapping, index);
-		if (!page) {
-			page_cache_sync_readahead(sctx->cur_inode->i_mapping,
+		folio = filemap_lock_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			page_cache_sync_readahead(mapping,
 						  &sctx->ra, NULL, index,
 						  last_index + 1 - index);
 
-			page = find_or_create_page(sctx->cur_inode->i_mapping,
-						   index, GFP_KERNEL);
-			if (!page) {
-				ret = -ENOMEM;
+	                folio = filemap_grab_folio(mapping, index);
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
 				break;
 			}
 		}
 
-		if (PageReadahead(page))
-			page_cache_async_readahead(sctx->cur_inode->i_mapping,
-						   &sctx->ra, NULL, page_folio(page),
+		WARN_ON(folio_order(folio));
+
+		if (folio_test_readahead(folio))
+			page_cache_async_readahead(mapping,
+						   &sctx->ra, NULL, folio,
 						   index, last_index + 1 - index);
 
-		if (!PageUptodate(page)) {
-			btrfs_read_folio(NULL, page_folio(page));
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
+		if (!folio_test_uptodate(folio)) {
+			btrfs_read_folio(NULL, folio);
+			folio_lock(folio);
+			if (!folio_test_uptodate(folio)) {
+				folio_unlock(folio);
 				btrfs_err(fs_info,
 			"send: IO error at offset %llu for inode %llu root %llu",
-					page_offset(page), sctx->cur_ino,
+					folio_pos(folio), sctx->cur_ino,
 					sctx->send_root->root_key.objectid);
-				put_page(page);
+				folio_put(folio);
 				ret = -EIO;
 				break;
 			}
 		}
 
-		memcpy_from_page(sctx->send_buf + sctx->send_size, page,
+		memcpy_from_folio(sctx->send_buf + sctx->send_size, folio,
 				 pg_offset, cur_len);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		index++;
 		pg_offset = 0;
 		len -= cur_len;
-- 
2.43.0


