Return-Path: <linux-btrfs+bounces-1556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C67831FD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776211C22735
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40D52E626;
	Thu, 18 Jan 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dhTjeJMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NGd1QOKZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dhTjeJMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NGd1QOKZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6F1F60B
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607157; cv=none; b=Kjpw/DzksXoq0YTKOdmHUbrDmuxEJO1yNRwrOkxeTgud98Tb8n14JD43EITDNJF2W1mcOlgjjrNghXw0FmipIypyr2puIv4NCoLKaALp+XcRxfILGIV4lNFoUgHEtZF4u8P4E0aqwt5P1YCWBcmCuoDowj5lpG0TX2FUHXmL9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607157; c=relaxed/simple;
	bh=vxyWSzU0gwOUfz9Z4jBSE2xgGhm8X7CngfpbrnQM2t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olsYYDolw/m/vIz8xr6FUH0COBo+JnBOLfzHwANVqi4Xab7RWrMf/7e1PtVxGjyoDnNc+WxzO+96J3OaLov0QEM3Hy2LrRxNYvXwqRRqCzydeJZFaKKuFU4H9JDdgeo2vym5F3AgovCI2NnjiY5TXLmI7ah23wuFiCj7H6cAXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dhTjeJMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NGd1QOKZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dhTjeJMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NGd1QOKZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 798ED21F11;
	Thu, 18 Jan 2024 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2obv1KZdvwObIEbwSR24IeaLWASP1pCuoUYN8krtqu8=;
	b=dhTjeJMJRNvakG9dnLXXarhla/9CAggsqhf8xXTMdiWcjO1lFKFPjOOqPbe8TicG5RrEEQ
	V0cWD/Z7LwU4PgYcsukxFSocG4isA1ragu/p1JxWD26MVLwalWBy35ozrB1EMHRd0ZYeBl
	8xnD192zJqqb5Opi/hjMp+eE2EDG+UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2obv1KZdvwObIEbwSR24IeaLWASP1pCuoUYN8krtqu8=;
	b=NGd1QOKZW5l2+OY5dx2eFTAdEanMRDJ1J1kf95XXz6TOCAbIEcj67mhbYQKQPWxsYTh5Ep
	nA74frS1xTpkcVAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2obv1KZdvwObIEbwSR24IeaLWASP1pCuoUYN8krtqu8=;
	b=dhTjeJMJRNvakG9dnLXXarhla/9CAggsqhf8xXTMdiWcjO1lFKFPjOOqPbe8TicG5RrEEQ
	V0cWD/Z7LwU4PgYcsukxFSocG4isA1ragu/p1JxWD26MVLwalWBy35ozrB1EMHRd0ZYeBl
	8xnD192zJqqb5Opi/hjMp+eE2EDG+UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2obv1KZdvwObIEbwSR24IeaLWASP1pCuoUYN8krtqu8=;
	b=NGd1QOKZW5l2+OY5dx2eFTAdEanMRDJ1J1kf95XXz6TOCAbIEcj67mhbYQKQPWxsYTh5Ep
	nA74frS1xTpkcVAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 25CB81377F;
	Thu, 18 Jan 2024 19:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id d0aeAPF/qWW5BQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Jan 2024 19:45:53 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/4] btrfs: Use IS_ERR() instead of checking folio for NULL
Date: Thu, 18 Jan 2024 13:46:37 -0600
Message-ID: <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>
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
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dhTjeJMJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NGd1QOKZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.89%]
X-Spam-Score: 2.49
X-Rspamd-Queue-Id: 798ED21F11
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

__filemap_get_folio() returns an error instead of a NULL pointer. Use
IS_ERR() to check if folio is not returned.

As we are fixing this, use set_folio_extent_mapped() instead of
set_page_extent_mapped().

Fixes: f8809b1f6a3e btrfs: page to folio conversion in btrfs_truncate_block()
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7199670599d9..25090d23834b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4714,7 +4714,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 again:
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
-	if (!folio) {
+	if (IS_ERR(folio)) {
 		btrfs_delalloc_release_space(inode, data_reserved, block_start,
 					     blocksize, true);
 		btrfs_delalloc_release_extents(inode, blocksize);
@@ -4742,7 +4742,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	 * folio private, but left the page in the mapping.  Set the page mapped
 	 * here to make sure it's properly set for the subpage stuff.
 	 */
-	ret = set_page_extent_mapped(&folio->page);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto out_unlock;
 
-- 
2.43.0


