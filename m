Return-Path: <linux-btrfs+bounces-12317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60864A64304
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B33A5C23
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2A21ABD6;
	Mon, 17 Mar 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZBabcXH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZBabcXH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA73421ABAA
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195505; cv=none; b=IJCyPAc0RwrjCCcKmfDR6FyFU3unsr37/bT0O8cRSUeyfeeOdFfArqMscHQA0+GOG1jbNJC4XfSNSlctdDs9XKM0bKLEs+V9luDhBUyJbS1icwDf8T7RIxjHA9W2jNrTrYXWFuWg3pezJCKuCXfrH9F9y2P42mqplFvXWMbZcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195505; c=relaxed/simple;
	bh=MDy/Pp03UtLhAWBjaBc5fJGJbdvNyJ8jCsBK73+iLZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSBktPr1OjCa47CW1KX/Mg6Q/xQjHC/lQJH7gyQURxbys6X55Ikr90Jejg4WKoVQn1ST3eZHMo+RRudJzIZcU2BGP9PqizJf5VA2B+wVDPjaZb7Fufv7mba9X7UwcmIhANB7FivgXXxsHpLTeK6Q17zIzRBzcSYS2nk4DPSmmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZBabcXH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZBabcXH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87216220E6
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=KZBabcXH8U0r1lIlVsUEFCZHOynrOADrPAIITkdmbMST4yH+hGFQFfZDIBMBlMrIlti7al
	OjXXKpmNPVFecCyVx2EXxMv4MnD4bT3ZlBwc3hAy0KhxKOXnT6BGIgydcfsxK9yWEIqgI8
	3AYZk/JF0SGHLf6RogQBCQUnOrNrd40=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=KZBabcXH8U0r1lIlVsUEFCZHOynrOADrPAIITkdmbMST4yH+hGFQFfZDIBMBlMrIlti7al
	OjXXKpmNPVFecCyVx2EXxMv4MnD4bT3ZlBwc3hAy0KhxKOXnT6BGIgydcfsxK9yWEIqgI8
	3AYZk/JF0SGHLf6RogQBCQUnOrNrd40=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3AA8139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAIIIRvL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/9] btrfs: prepare btrfs_page_mkwrite() for larger data folios
Date: Mon, 17 Mar 2025 17:40:48 +1030
Message-ID: <1a6d45ee86aec29e267eba57cf46c318689606e5.1742195085.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
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


