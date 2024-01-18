Return-Path: <linux-btrfs+bounces-1559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F62831FDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 20:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11EA1C22B72
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95DA2E642;
	Thu, 18 Jan 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RZhg3WfZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VhplqZ38";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RZhg3WfZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VhplqZ38"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E732E63A
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607169; cv=none; b=oW1oiU7CczKJbeV+azmGKSoqKM01QMlILXQhAJDtk8qWzBZLJ8zrEvBhms74TYOXJQKtLEIlg0ZMHOZ7nsGJrTLlyxgT6vGrDVtw+Le6vsQR4+fDKnJg9pygh8syvZqbHX1q/7e+Kpxd+VE9ELw2+2ANZvM2pJEx+UF2OOqAX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607169; c=relaxed/simple;
	bh=i4q4xaM1FKLb5VI7Teirkw4YMH05Ce4E99vvNFeKp7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTgTN67ib+XLeM9EX6tlhbBYQr7UmNB7jiXMk/V384JkL0L7pvSua9bkzj9CrX0z0q3KhI7OjtzJb0nRiY0eXLwfqcaLo5805Py/HEKhrB+dtesI+lLaRxWcvYZvD2hgdIdoIcHuATOpPjpFLD3Ugr0NRHeSbWmtX04xtsiPmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RZhg3WfZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VhplqZ38; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RZhg3WfZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VhplqZ38; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BB761F7B2;
	Thu, 18 Jan 2024 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDT3Sy2ogE8OdnJMJ5ptjroZAUL2KlFRubUbBU5ERzY=;
	b=RZhg3WfZcDjodSnA0OxbuWt/hn2qb3TGTRXEqW2BGB7eWo6AaMe0a/7hVWLqu7yY6nYzcv
	iImYOJVJ1gF3dMTvT+vFd4wv3zNr5qwODF7vnlSr1NWc9JCIFG1WXfXw0YjjxOMOvYh46N
	z15W3GXtFY1JCuyTywLg4VfuTiqDV5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDT3Sy2ogE8OdnJMJ5ptjroZAUL2KlFRubUbBU5ERzY=;
	b=VhplqZ380nL5i45GLqhwDnV2LbC856nF2dXVQsx2B+6CfYtOV0iBdxESyg3G6IogxLAPvo
	0NPDbB6eSJNib9Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDT3Sy2ogE8OdnJMJ5ptjroZAUL2KlFRubUbBU5ERzY=;
	b=RZhg3WfZcDjodSnA0OxbuWt/hn2qb3TGTRXEqW2BGB7eWo6AaMe0a/7hVWLqu7yY6nYzcv
	iImYOJVJ1gF3dMTvT+vFd4wv3zNr5qwODF7vnlSr1NWc9JCIFG1WXfXw0YjjxOMOvYh46N
	z15W3GXtFY1JCuyTywLg4VfuTiqDV5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDT3Sy2ogE8OdnJMJ5ptjroZAUL2KlFRubUbBU5ERzY=;
	b=VhplqZ380nL5i45GLqhwDnV2LbC856nF2dXVQsx2B+6CfYtOV0iBdxESyg3G6IogxLAPvo
	0NPDbB6eSJNib9Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB9A81377F;
	Thu, 18 Jan 2024 19:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RS8sJ/h/qWXIBQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Jan 2024 19:46:00 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/4] btrfs: page to folio conversion in put_file_data()
Date: Thu, 18 Jan 2024 13:46:40 -0600
Message-ID: <861fb1618d04ccb56c00ac78b4c6ca81dc9a59e4.1705605787.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705605787.git.rgoldwyn@suse.com>
References: <cover.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RZhg3WfZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VhplqZ38
X-Spamd-Result: default: False [3.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.69
X-Rspamd-Queue-Id: 4BB761F7B2
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use folio instead of page in put_file_data(). This converts usage of all
page based functions to folio-based.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/send.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7902298c1f25..0de3d4163f6b 100644
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
@@ -5273,44 +5274,43 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
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


