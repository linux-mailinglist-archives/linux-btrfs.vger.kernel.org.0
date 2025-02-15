Return-Path: <linux-btrfs+bounces-11479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE43A36CA4
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4E83B1B8A
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE693199249;
	Sat, 15 Feb 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EiTj2gbo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EiTj2gbo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C21DDA8
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608499; cv=none; b=qaNi8rx/WJm+klTneTwe0MuMyoIv5+NfSSQaS48KpT2OZdmjX7iofwo20gHdlb/shTqVQOg1tBTfRhf060sS5iWMsMip8rHbPu/UBC/N9qbQ8lZ9S/oacOFv3MAIlVADFY/HT0AJMA6+lLv7mMbA7A3Nq/65w6uqMCaWzWVrBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608499; c=relaxed/simple;
	bh=gBz9FMpZx2CkIcyxJGRf6AsJl+i36twoh2uj98WM93o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNACJK1WUDmPJFxvci39YsUFfH0x/LCHZJpCEjg7fgvOeQtEwEnhyB1YB7m0Om7f3aHwHLpUI9MW/8f+MlLTiYLPh+cOUdRySokVjnshVAT1occNootNYSR90AQFNWzRKg+8hKYGTWQiWKaoL+HXz5k3OCZeBWoxcnUeQ1timto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EiTj2gbo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EiTj2gbo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2727D2117A
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHyZtwA0P/O7QphiXxWGgv1SNIqr7h/fj1ZbkB0jHAs=;
	b=EiTj2gboETWNQOiWaUu+H+L+Dc9aXTBSMo21jTdEVkMoVeqesoZoXp9aOkNbsDibJDj+ps
	tK15yDQBB70Xn5LfZL38gBUML305VPjL9RJaUnH077DyvAYNNXcCAuRxO3Jzc5y7w38Hep
	Xtqp5HWFUseoSoGuw18ECj3fqMqlt3s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHyZtwA0P/O7QphiXxWGgv1SNIqr7h/fj1ZbkB0jHAs=;
	b=EiTj2gboETWNQOiWaUu+H+L+Dc9aXTBSMo21jTdEVkMoVeqesoZoXp9aOkNbsDibJDj+ps
	tK15yDQBB70Xn5LfZL38gBUML305VPjL9RJaUnH077DyvAYNNXcCAuRxO3Jzc5y7w38Hep
	Xtqp5HWFUseoSoGuw18ECj3fqMqlt3s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50DE0136E6
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mK+QBKRRsGfNTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: allow inline data extents creation if sector size < page size
Date: Sat, 15 Feb 2025 19:04:21 +1030
Message-ID: <eb1e63eabbf5a491edcbada177cd6f25d938e9df.1739608189.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739608189.git.wqu@suse.com>
References: <cover.1739608189.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
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
index 4b87fafa9944..7796e81dbb9d 100644
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


