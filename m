Return-Path: <linux-btrfs+bounces-12320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DFA64308
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B2F3A7561
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7E21ABAB;
	Mon, 17 Mar 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u4nz0C/p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u4nz0C/p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269A18A6B5
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195518; cv=none; b=VWq0sR8zDbQLscy7h0hfwnxsAN1IMAoMEMF/Dq+BIY5Rhs4u4JTdfC/uZNZHjJHMOkEY3wHxRst9ExgO6lAui/4Y3D3Wmp/mB082otkQtkKIleBX7vLNmk1+k8b/fmxiCjQwe3975qG2ALzurr8SoU4uV79CtqNc9o4lCPuVdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195518; c=relaxed/simple;
	bh=fV39FIZBHcLoysOcEHA/fNtbn1s1mlpDtFc3Eo+jfyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6ja4/0ObOVmgGxQd6j0xUn0QVn+ftLM+S3IvUvwCZ4LS4Ebd9VkhCYU1DpwMOx1sNhwg8QFF2FC33f+zTQNp8pc67IbrIpmwrBiIwR6K/X3hBh7u+h7gq8PvLrUp1YrwjkDYDYzOHU1E3EndvIi2skXXTgPj5aeIkCok+065Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u4nz0C/p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u4nz0C/p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DF712212C
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=u4nz0C/ptWSmFQHTo9tYfHBtbaEzsZpyBr/49dhWA15Ck8NTTLOdzvT+vW5CsIoNO1oQWc
	dmMwJy9RG+l4onDFFk4Eeod13K2tZWR0D161pTqLzSjdQNHBw5hp1ryOdkIsHLRQB/lZE0
	IImHWa2a5FegIEAJm4YoufqW4G7HcTI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="u4nz0C/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=u4nz0C/ptWSmFQHTo9tYfHBtbaEzsZpyBr/49dhWA15Ck8NTTLOdzvT+vW5CsIoNO1oQWc
	dmMwJy9RG+l4onDFFk4Eeod13K2tZWR0D161pTqLzSjdQNHBw5hp1ryOdkIsHLRQB/lZE0
	IImHWa2a5FegIEAJm4YoufqW4G7HcTI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8913C139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPDfEh/L12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 6/9] btrfs: subpage: prepare for larger data folios
Date: Mon, 17 Mar 2025 17:40:51 +1030
Message-ID: <a2b3545fb1e81fc4ebe488d638621191fd5f1a69.1742195085.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 4DF712212C
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

The subpage handling code has two locations not supporting larger
folios:

- btrfs_attach_subpage()
  Which is doing a metadata specific ASSERT() check.

  But for the future larger data folios support, that check is too
  generic.
  Since it's metadata specific, only check the ASSERT() for metadata.

- btrfs_subpage_assert()
  Just remove the "ASSERT(folio_order(folio) == 0)" check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 834161f35a00..bf7fd50ab9ec 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -69,7 +69,8 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage;
 
 	/* For metadata we don't support larger folio yet. */
-	ASSERT(!folio_test_large(folio));
+	if (type == BTRFS_SUBPAGE_METADATA)
+		ASSERT(!folio_test_large(folio));
 
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mapped
@@ -181,9 +182,6 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *
 static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len)
 {
-	/* For subpage support, the folio must be single page. */
-	ASSERT(folio_order(folio) == 0);
-
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-- 
2.48.1


