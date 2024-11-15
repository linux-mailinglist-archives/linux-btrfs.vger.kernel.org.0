Return-Path: <linux-btrfs+bounces-9680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBF79CD6CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 07:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9679B1F218C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89963184551;
	Fri, 15 Nov 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VlC0Z6uf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VlC0Z6uf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD151158DB2
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650649; cv=none; b=bl3BrBEzBf6mK4T7kU1P9xFwCH6MrgSXzA+9Ruen0IXGuE9NNLQYKrlxhNhHSwvQXlzUBKRQ3ItGcslf3rClpXedvvQUMnOzk+iwp3uNy4Pgy5xZ1AjRT2+yofDq9wc1D2rDpXZxEvUraRdRk9UQU2TI5AbqDyEFj/1tFN//dkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650649; c=relaxed/simple;
	bh=ZjmGORUlIpc/s0rqZ4es2zlFqWmH1Xw/irMBQNJAfZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLbqfLPdnLQ+T4fyDwtanEPTz/eqOIrqINvwcvpxVcFPjFNvbQvVrDitg8WBVp4EDkZ6QU2W1MOrQiairHlsSV7AIGGwEVVsuKPB2U+ctslTQ3kci4i5/aMnzD+eMexXht30mVFjbpHKCfp97glY8mF5SxeNLwjt8905VAVuFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VlC0Z6uf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VlC0Z6uf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D55A41F7CB
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+MpQ6t07AbGPnvfsNFZYTDn1D3vsMALDnTiKPYVwNk=;
	b=VlC0Z6ufEFF6NbOC/Sthzkzba3hVzso/gf9MogMsjq9fTHfM08yP75OB6MQZYeP88LUWDn
	2t1EyKVszAZ2nKnjCIhieCMEA3as+dfDsrL//ge9HxZR7KR01gCdZjJttEVIep3Sj7OGJw
	6RGXUMRQwubIx/CNufaKFTbjbq4tyOw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+MpQ6t07AbGPnvfsNFZYTDn1D3vsMALDnTiKPYVwNk=;
	b=VlC0Z6ufEFF6NbOC/Sthzkzba3hVzso/gf9MogMsjq9fTHfM08yP75OB6MQZYeP88LUWDn
	2t1EyKVszAZ2nKnjCIhieCMEA3as+dfDsrL//ge9HxZR7KR01gCdZjJttEVIep3Sj7OGJw
	6RGXUMRQwubIx/CNufaKFTbjbq4tyOw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EE44134B8
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBiAL1TkNmdQBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: allow inline data extents creation if sector size < page size
Date: Fri, 15 Nov 2024 16:33:44 +1030
Message-ID: <4df35fbb829dfbcf64a914e5c8f652d9a3ad5227.1731650263.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731650263.git.wqu@suse.com>
References: <cover.1731650263.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Previously inline data extents creation is disable if sector size < page
size, as there are two blockage:

- Possible mixed inline and regular data extents
  However this is also the case for sector size < page size cases, thus
  we do not treat mixed inline and regular extents as an error.
  So from day one, more mixed inline and regular extents are not a
  strong argument to disable inline extents.

- Unable to handle async/inline delalloc range for sector size < page
  size cases
  This is fixed with the recent sector perfect compressed write support
  for sector size < page size cases.
  And this is the main technical blockage.

With the major technical blockage already removed, we can enable inline
data extents creation for sector size < page size, allowing the btrfs to
have the same capacity no matter the page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a0599369ca0c..712157ecda08 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -605,19 +605,6 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (offset != 0)
 		return false;
 
-	/*
-	 * Due to the page size limit, for subpage we can only trigger the
-	 * writeback for the dirty sectors of page, that means data writeback
-	 * is doing more writeback than what we want.
-	 *
-	 * This is especially unexpected for some call sites like fallocate,
-	 * where we only increase i_size after everything is done.
-	 * This means we can trigger inline extent even if we didn't want to.
-	 * So here we skip inline extent creation completely.
-	 */
-	if (fs_info->sectorsize != PAGE_SIZE)
-		return false;
-
 	/* Inline extents are limited to sectorsize. */
 	if (size > fs_info->sectorsize)
 		return false;
-- 
2.47.0


