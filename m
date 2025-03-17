Return-Path: <linux-btrfs+bounces-12312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C6A642FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D337A14E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06B21A424;
	Mon, 17 Mar 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S1Z1O9Er";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S1Z1O9Er"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3141C6FF3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195487; cv=none; b=t/Jr0mog+esFQ0CHrb6oXCjoWbP7neHqbDpE5qSroLQ3fO//fKreVGmNBHzEeBC7s56vlNcw4PV1rHIwINvc7UDGNuI2mkQXwcCnfTFLPPu/GgtW/gvVAQagjnq5NyKjujffjqZyEAFkf3ciEyBlIhSazVBv25y0/PB7g8Ho050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195487; c=relaxed/simple;
	bh=KwAeuuDDeURhc1uduX+W4X6LwLA+hS0JrfZDqW/I6BE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9K+EAi0agNTm8erod+VmW9vCjPK54OxrZx8jaxbhWzQBVsyCkUhs/oHx572rssU3RnQvJw1EJM4O59WS5Rg8S5ksVlxUvGG1gm49mA+IqVKmw1mglvPPh1C2h15ePIcd7HSGCouquH5k+lUJ6EuZuzxoMClDR3KmkMnD5V0Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S1Z1O9Er; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S1Z1O9Er; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51BE72018C
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=S1Z1O9ErKflm0Dpt3Bf7S1Udbk246PGrEGhimFYXYSiuzxbuV/y6WlaNpkbrq8tH5hcoJY
	IAWq1Z+UQzH016A9uP3mKpZwnlkzXaOn0mhDHlMLNi+TBm6lQ6/gaXmmLwS/Ag/tu6gL/5
	Ws9cfvHowVyRg1J7Ax5Y/dOfUUqQZdU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S1Z1O9Er
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE9jrU/uLZfaGt8hL7BPeV+adQSNsYm65uG0ApJgfQM=;
	b=S1Z1O9ErKflm0Dpt3Bf7S1Udbk246PGrEGhimFYXYSiuzxbuV/y6WlaNpkbrq8tH5hcoJY
	IAWq1Z+UQzH016A9uP3mKpZwnlkzXaOn0mhDHlMLNi+TBm6lQ6/gaXmmLwS/Ag/tu6gL/5
	Ws9cfvHowVyRg1J7Ax5Y/dOfUUqQZdU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C16E139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJimExrL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/9] btrfs: send: prepare put_file_data() for larger data folios
Date: Mon, 17 Mar 2025 17:40:47 +1030
Message-ID: <3df45ec45510c3e37af0b494c944d786a3bdd54f.1742195085.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
References: <cover.1742195085.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51BE72018C
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
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


