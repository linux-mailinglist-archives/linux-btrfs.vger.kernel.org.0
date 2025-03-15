Return-Path: <linux-btrfs+bounces-12294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD0A62350
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623A88803E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65F846F;
	Sat, 15 Mar 2025 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TVwXepd9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TVwXepd9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B3D2FF
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999370; cv=none; b=he+qZGTo4cCVHufqbyHOwb2HNE/yQBMeTCBJQw7uUSIgwDih7G150Atbny3XumbM1JyQOCDJiS9XAiqH5VEfYFhiJkOfRZ2qFNyDOqF9rTH39c21u/VbB75dIexCuMZruOgrybS//NJXpktp9StmgliiILlh3M2J27cS0w0ay24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999370; c=relaxed/simple;
	bh=KwAeuuDDeURhc1uduX+W4X6LwLA+hS0JrfZDqW/I6BE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cde0e4NSPnQUbDtLWyq6eahPb7DTL9C0Uo+R8RR+wKRu0hz6EMHdeioDfm+YFaZyoY8tuo4jLE+0ZIUHjEz0mWzhNoBlKU+3y96s0CBs2xX1YukReJfhN9AUQrdgmFNvL4+EnCPaN/5NAmkHTv6w1fWoI5zZmrm+jIips8cx+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TVwXepd9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TVwXepd9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0D9421196
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=TVwXepd9usJLOLsAfa9PYSfw5P/y9hHPC2cnS+iJL6wKdH3i6vYYdW0UyrhMbVPETngnXB
	+2Gl6H3i/ue85Wjhs8SHMYO6uAOcwomlTdBdzvX/JPqrmX+TqQrGk44DznvwZf+EPsk3us
	4EaDwJYqJooaYk7JxU8OHfwbYkEW0mg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TVwXepd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=TVwXepd9usJLOLsAfa9PYSfw5P/y9hHPC2cnS+iJL6wKdH3i6vYYdW0UyrhMbVPETngnXB
	+2Gl6H3i/ue85Wjhs8SHMYO6uAOcwomlTdBdzvX/JPqrmX+TqQrGk44DznvwZf+EPsk3us
	4EaDwJYqJooaYk7JxU8OHfwbYkEW0mg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D876013797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YJkDIQDN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/7] btrfs: send: prepare put_file_data() for larger data folios
Date: Sat, 15 Mar 2025 11:12:13 +1030
Message-ID: <3bcdc0894eae02c7a6f0b43e8b94c0518eaf6b9a.1741999217.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741999217.git.wqu@suse.com>
References: <cover.1741999217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0D9421196
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently the function put_file_data() can only accept page sized folio.

However the function itself is not that complex, it's just copying data
from filemap folio into send buffer.

So make it support larger data folios by:

- Change the loop to use file offset instead of page index

- Calculate @pg_offset and @cur_len after getting the folio

- Remove the "WARN_ON(folio_order(folio));" line

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/send.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 43c29295f477..4df07dfe326f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5263,10 +5263,9 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct folio *folio;
-	pgoff_t index = offset >> PAGE_SHIFT;
-	pgoff_t last_index;
-	unsigned pg_offset = offset_in_page(offset);
+	u64 cur = offset;
+	const u64 end = offset + len;
+	const pgoff_t last_index = (end - 1) >> PAGE_SHIFT;
 	struct address_space *mapping = sctx->cur_inode->i_mapping;
 	int ret;
 
@@ -5274,11 +5273,11 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 	if (ret)
 		return ret;
 
-	last_index = (offset + len - 1) >> PAGE_SHIFT;
-
-	while (index <= last_index) {
-		unsigned cur_len = min_t(unsigned, len,
-					 PAGE_SIZE - pg_offset);
+	while (cur < end) {
+		pgoff_t index = cur >> PAGE_SHIFT;
+		unsigned int cur_len;
+		unsigned int pg_offset;
+		struct folio *folio;
 
 		folio = filemap_lock_folio(mapping, index);
 		if (IS_ERR(folio)) {
@@ -5292,8 +5291,9 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 				break;
 			}
 		}
-
-		WARN_ON(folio_order(folio));
+		pg_offset = offset_in_folio(folio, cur);
+		cur_len = min_t(unsigned int, end - cur,
+				folio_size(folio) - pg_offset);
 
 		if (folio_test_readahead(folio))
 			page_cache_async_readahead(mapping, &sctx->ra, NULL, folio,
@@ -5323,9 +5323,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 				  pg_offset, cur_len);
 		folio_unlock(folio);
 		folio_put(folio);
-		index++;
-		pg_offset = 0;
-		len -= cur_len;
+		cur += cur_len;
 		sctx->send_size += cur_len;
 	}
 
-- 
2.48.1


