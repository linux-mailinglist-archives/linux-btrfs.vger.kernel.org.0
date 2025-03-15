Return-Path: <linux-btrfs+bounces-12295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE28A6234F
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BBA19C5EA7
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F91F9E8;
	Sat, 15 Mar 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EZIU3prO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EZIU3prO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CBDF78
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999370; cv=none; b=uGLvczejWYb9B/uWDKg8jZOOpKe+a+asWRxupfiXmpsoKPO8VA3TXBtJoSFW1/HDuf7rSN6XH2E90jF2rzotP3qJ+Jd/QXAevFAnUZJjqMvIL+9hwIv7yhp4/6+rysAXDUxpPEaVTQCwZExXwWJGrJMQCORP6szsekaSS3CSeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999370; c=relaxed/simple;
	bh=MDy/Pp03UtLhAWBjaBc5fJGJbdvNyJ8jCsBK73+iLZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy1zLKzx1KLdRtU3UiX13UJnOuBxEdOqIStrxE8+CWPfN7k+MP5XvuGTtbT4LKq1CciLWFXomxtn3m+r7d6jGVgt5rqOtdztBs6lvv11oALBKLTtGNgPNSLG1I+UZNkCOfuv5pnkzhdqMSbo8TAXaoxuE9WFYvtCRywqDRQPq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EZIU3prO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EZIU3prO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8BF1F38E
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=EZIU3prOqsc2Q8740TCeItsjIxYTbpl1u452I0ASCAhP9QTXLgxIu1VXMfw3z90eZ/WYuX
	Yp3LreGJOOXvD6w5FtX8/LpL1prSCtSkUA/yWR7CGq1uwY3rz28zEZyBGuHGdJKKLSz2nz
	my1q48U5lft0tPVh2XYBB0w02rp0lBE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EZIU3prO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=EZIU3prOqsc2Q8740TCeItsjIxYTbpl1u452I0ASCAhP9QTXLgxIu1VXMfw3z90eZ/WYuX
	Yp3LreGJOOXvD6w5FtX8/LpL1prSCtSkUA/yWR7CGq1uwY3rz28zEZyBGuHGdJKKLSz2nz
	my1q48U5lft0tPVh2XYBB0w02rp0lBE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E2113797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0InADQLN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/7] btrfs: prepare btrfs_page_mkwrite() for larger data folios
Date: Sat, 15 Mar 2025 11:12:14 +1030
Message-ID: <ce0466e50b039b2a03a48c51019cd00287bed9c8.1741999217.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 8F8BF1F38E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function btrfs_page_mkwrite() has an explicit ASSERT() checking the
folio order.

To make it support larger data folios, we need to:

- Remove the ASSERT(folio_order(folio) == 0)

- Use folio_contains() to check if the folio covers the last page

Otherwise the code is already supporting larger folios well.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 262a707d8990..4213807982d6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1791,8 +1791,6 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	u64 page_end;
 	u64 end;
 
-	ASSERT(folio_order(folio) == 0);
-
 	reserved_space = fsize;
 
 	sb_start_pagefault(inode->i_sb);
@@ -1857,7 +1855,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		goto again;
 	}
 
-	if (folio->index == ((size - 1) >> PAGE_SHIFT)) {
+	if (folio_contains(folio, (size - 1) >> PAGE_SHIFT)) {
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
-- 
2.48.1


