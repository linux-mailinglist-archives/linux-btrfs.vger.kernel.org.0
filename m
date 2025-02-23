Return-Path: <linux-btrfs+bounces-11728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1CA41256
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB613A686F
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786C200B8A;
	Sun, 23 Feb 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GTcjMilh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GTcjMilh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92E10E4
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354434; cv=none; b=HIw/0qmSmol6q738+lPgWQOo572YqEZn0cWW4gafK5AeGamnhoV/Mw8OrIAVRLnJi8Pja3H32AsVB19FNUJiPFW9NdDvBES0hoEuOOHfiEuqFc2wY/MZ95Y09Qn9Piy4QRawtfV0ftK2SAIDN+69zFUksamkI/2qEj3gQ1QdrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354434; c=relaxed/simple;
	bh=Guqkvc0ESluSBC6XHg/Vypb72x6G6eY2rRdOHx4MzLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/uFAkKjL5/mxn/e7cPeKopfyIgy6anNurQwtTbxtWVuKN0X60S6x1jwB9vRvNDOnwHnpTZr+eoFyR9BOnKTsT308MWwPlo8e5xmNJmYoGoH0Ht3fJyekMKGA7Enmw++wJS25kojTFuddF+yPKEm9nOCmwa8fN4RcxnKCfyMmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GTcjMilh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GTcjMilh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3B201F38E
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCpJdceAISRtIdzBsAPLFMOeTR3iK36LOdioueDrdZI=;
	b=GTcjMilhLoZnLsYNZMbLC01TYGlNR/jCTeCY9rk15E4xVcpmvMG42If023APqcfeTw+9sb
	3Ve4pDT3UK6Tzl0EoAWxh+eBPC1YIy4AHMpXY5WpaPFRA7QEYIRmnLgHEen4JIr+g8xy91
	ZNp+uti+FTdLCqssqjXKRYAFk1SPMew=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GTcjMilh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCpJdceAISRtIdzBsAPLFMOeTR3iK36LOdioueDrdZI=;
	b=GTcjMilhLoZnLsYNZMbLC01TYGlNR/jCTeCY9rk15E4xVcpmvMG42If023APqcfeTw+9sb
	3Ve4pDT3UK6Tzl0EoAWxh+eBPC1YIy4AHMpXY5WpaPFRA7QEYIRmnLgHEen4JIr+g8xy91
	ZNp+uti+FTdLCqssqjXKRYAFk1SPMew=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332E213A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLvrOGezu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: allow inline data extents creation if block size < page size
Date: Mon, 24 Feb 2025 10:16:21 +1030
Message-ID: <592f1b35af2c203e4bb6dd6431b6bb0c880e81aa.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3B201F38E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Previously inline data extents creation is disable if the block size
(previously called sector size) is smaller than the page size, for the
following reasons:

- Possible mixed inline and regular data extents
  However this is also the same if the block size matches the page size,
  thus we do not treat mixed inline and regular extents as an error.

  And the chance to cause mixed inline and regular data extents are not
  even increased, it has the same requirement (compressed inline data
  extent covering the whole first block, followed by regular extents).

- Unable to handle async/inline delalloc range for block size < page
  size cases
  This is already fixed since commit 1d2fbb7f1f9e ("btrfs: allow
  compression even if the range is not page aligned").

  This was the major technical blockage, but it's no longer a blockage
  anymore.

With the major technical blockage already removed, we can enable inline
data extents creation no matter the block size nor the page size,
allowing the btrfs to have the same capacity for all block sizes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e99cb5109967..a1ea93bad80e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -566,19 +566,6 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
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
2.48.1


