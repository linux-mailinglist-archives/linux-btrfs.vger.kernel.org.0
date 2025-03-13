Return-Path: <linux-btrfs+bounces-12251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128ADA5EA81
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558A2175D57
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B72813C8E8;
	Thu, 13 Mar 2025 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7EMsGpY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7EMsGpY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503D7DA6A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839692; cv=none; b=cP6s4OC01+HReBXn0rer9KlfErFkknhzq2qwUnm8VsjvRqqLWGZeKqHwtXxmp/veYTGtxuUuqvqZ8JPm/XkhkesumHQdbmQuTtGp8X0Hz2O7uBFSt8FZqRH1J2xPorPf2BxcVeIOMDrMYD6iDdHejGu8xYdSKM9mQ1Gn+T14ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839692; c=relaxed/simple;
	bh=MDy/Pp03UtLhAWBjaBc5fJGJbdvNyJ8jCsBK73+iLZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5VWYzy3nkmvnpIp3AMIY+VuftDLDmU1q8IPtlOhXidMUjwph3HGKl0nIo2zjqEeYV3xB4Kt8yllcmBlebxfgRZNyOWTrTxhDFKbqSErh2ip4lP7o6dZMZYSqLVg4ktKhaQCYZtuzWhF7vVaV3SvJtDIf/FWJnNfEh8d9PsTZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7EMsGpY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7EMsGpY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A77421191
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=t7EMsGpYKs1I7Lb6PNVJHcXMwzFDLriuOWoli8trGzkPdQ9Pxv4cppWZNQoSwwi12LtekB
	lUeaAhfyQq2eptd+89y0LY8IKJs3VL3x1uCHngv7MlcQrsf+KWmrDH4w4FUdY1T3pbYtRQ
	/96kuEetcI+reNUZjvGO72sXIo88Yik=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QenZUiEmnYmgQb+ZCfW+2P3Xg2hrNWxKJRKqwvriTXI=;
	b=t7EMsGpYKs1I7Lb6PNVJHcXMwzFDLriuOWoli8trGzkPdQ9Pxv4cppWZNQoSwwi12LtekB
	lUeaAhfyQq2eptd+89y0LY8IKJs3VL3x1uCHngv7MlcQrsf+KWmrDH4w4FUdY1T3pbYtRQ
	/96kuEetcI+reNUZjvGO72sXIo88Yik=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF8913797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDqBGzZd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: prepare btrfs_page_mkwrite() for larger data folios
Date: Thu, 13 Mar 2025 14:50:45 +1030
Message-ID: <8d975a6a45c3abac0a1eca861a9d0f4d5795ffe1.1741839616.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
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


