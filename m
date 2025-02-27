Return-Path: <linux-btrfs+bounces-11891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B9A47594
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F768188F88E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BF21B9C9;
	Thu, 27 Feb 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E9kjjsJY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E9kjjsJY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2621858C
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635725; cv=none; b=lip0toZyP5SCCNh4uRPBdL7f72iejfqHK04w9YkX3ouBRPegnzdWo9crtdza+16RsIJdx6/DjalyL8d5tqdqmWGPvNvMhqal2cjoAcDM5O6iT3nWbHHn/J9fwnY6KeOAs4DFZZS21Jt3XQUHhLOl+i6Rvy85FaZJ/4G5xrsz5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635725; c=relaxed/simple;
	bh=d2tcZ2DOi7wCMHu2kKENRQLvXDkcxXJFw5xvTc5IJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM5YXzq0ca7zbnshwzB77mXIKiYI3/NNXQkScMIcJ1osMLUrxu3ptL3HO6X5QHr8APwjAavde9PGedb3rb+v6wRUtjFD58clPU7NfgTmreVmU860JCTih9Hp+2wzXaeub8ZeT69biWLFO0SHJyD4gCKGYfYPLCpoAnsVIJfrmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E9kjjsJY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E9kjjsJY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F1612119E;
	Thu, 27 Feb 2025 05:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1530XvLpzBBsPjvBXRI3lqAtzgpf+fSWmDbS71aLAvc=;
	b=E9kjjsJYcWUdSKGyOHlqRcIkiqe5+9vOpGhu7Mk90T1VA7Clt6OLRHGRC4kmQ97ERiEvZc
	CTBkKY6Ilim+L1CA7Ptzskd9Qws+KPdMUpuOE7wvUnm7Mtah/YXuQzimryoC5AiMF91PhH
	uKw+ZGpFVmV74mgpctPbbITRWvZsyXA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=E9kjjsJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1530XvLpzBBsPjvBXRI3lqAtzgpf+fSWmDbS71aLAvc=;
	b=E9kjjsJYcWUdSKGyOHlqRcIkiqe5+9vOpGhu7Mk90T1VA7Clt6OLRHGRC4kmQ97ERiEvZc
	CTBkKY6Ilim+L1CA7Ptzskd9Qws+KPdMUpuOE7wvUnm7Mtah/YXuQzimryoC5AiMF91PhH
	uKw+ZGpFVmV74mgpctPbbITRWvZsyXA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E4311376A;
	Thu, 27 Feb 2025 05:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CANJOEH+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Feb 2025 05:55:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 7/8] btrfs: allow inline data extents creation if block size < page size
Date: Thu, 27 Feb 2025 16:24:45 +1030
Message-ID: <05bd0b48a83d90b992f2499806ee118107985621.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F1612119E
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 52802a3a078c..c325185bb134 100644
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


