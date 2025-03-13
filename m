Return-Path: <linux-btrfs+bounces-12249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA7A5EA80
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F7D3B526F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24F13BAF1;
	Thu, 13 Mar 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="okN9gfC0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="okN9gfC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EF2B9A8
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839685; cv=none; b=hDKBphOJaYJny+agOH3z5Q7OI+rvQfqsOqcFrVCQJiUJo5gy3Eb9U4egtuwW88ZBURJvG5zyEPGYbvapunGJYTxifIRg5l5cAw/9oXG+UbQYUWWycqQudiYLWQLjIFPkaFjIs6A0og7992g2NIpJQIb55RvZrGEkx6SAvuXjPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839685; c=relaxed/simple;
	bh=KwAeuuDDeURhc1uduX+W4X6LwLA+hS0JrfZDqW/I6BE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDwKsSvgPxErAuOGCcGhnYW5qo65ar9Pn0cCHaxs7vpQsrdVK1++jsJkzmlnjhY6YPKRYkYSttcixxNAftD7q/yYaXMo3unaC9tzTEkH3FwSQl8hfZcxmlGDo2NSFeUzFr4vc8dDj9JDF9oydw5n0oPgYQZ4v6Ru6JyyovvdtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=okN9gfC0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=okN9gfC0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3776721190
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=okN9gfC0GgfCG5kDKqPIum74WwOAvohzs15nOeGHYZT53XbGKJ4CPlLjgnZcNny14addiN
	PrzQ/o8Ezy9QseZTDuu7Z+5ddk2S3CThIE/YuO/gfx2+N1YpLHw/jwReAAi4PBwhTYu7+5
	vDoa3jur5/Pwj+L8jQzjaFdQXF3H4BA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=okN9gfC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=okN9gfC0GgfCG5kDKqPIum74WwOAvohzs15nOeGHYZT53XbGKJ4CPlLjgnZcNny14addiN
	PrzQ/o8Ezy9QseZTDuu7Z+5ddk2S3CThIE/YuO/gfx2+N1YpLHw/jwReAAi4PBwhTYu7+5
	vDoa3jur5/Pwj+L8jQzjaFdQXF3H4BA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B54513797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCgKCzVd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: send: prepare put_file_data() for larger data folios
Date: Thu, 13 Mar 2025 14:50:44 +1030
Message-ID: <75668be54f15f044d412fb946ed845345c8698bc.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741839616.git.wqu@suse.com>
References: <cover.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3776721190
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
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


