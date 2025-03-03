Return-Path: <linux-btrfs+bounces-11964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0AA4B973
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE13F3AA421
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720391EE03B;
	Mon,  3 Mar 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7yIP4+v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7yIP4+v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA11E9B31
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990953; cv=none; b=NdfYzCD1B9O6ITOiAZIkIDFB060x/DxNwPJgkbaGOPDyQmK06E8Y7xIKwGIY6Kvv4SPnTvAUuo5afeZLfW1eeq4T1pmOTL2p7dmVUxUnttxgRd7/ZFpMynQyAZpX6R/QvFhK+JqMB8q4eEXf5tljL11i3ig5hD9dTQchHTN8Npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990953; c=relaxed/simple;
	bh=7f71+FfVIvmxfb1H7dp+XpUURvWMHgeP0lC6jA4ioaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk69o7KAMW2tNsQB9zMjIuVEABcMvAO8yoc/dXv8sXv+quFgoZUWv5nlyz5FqkIGAAbcnTXt4uS/+MgAWb4C6LXibHaZWnT3Bd/DwuOR2pRynjKRovqJXELeDkrEYUV6d9qXAtdObGhR8/DBum6ynAnmFJegUGkf+wXF76Xv+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7yIP4+v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7yIP4+v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40EFC2117A;
	Mon,  3 Mar 2025 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd0+jIKIKuvH/EHdK/Y1rCQtBmjvQ1M0AVPDy7ldCww=;
	b=s7yIP4+vZEJSYqopCkVwqyqbbJCE7eQhBvP4CvWfEPzvM7G+NMxk7Bpz3LLo2YT92iUeI3
	/EQEfEuTAhiqie4QY4ZRa8bM0PryPdXytwc39j2r+S44Ntm7+PgdoHQbE3hF5MopBdvd/D
	xk3eYLLQGie6OPiz933+dn4hu7jVGVQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=s7yIP4+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd0+jIKIKuvH/EHdK/Y1rCQtBmjvQ1M0AVPDy7ldCww=;
	b=s7yIP4+vZEJSYqopCkVwqyqbbJCE7eQhBvP4CvWfEPzvM7G+NMxk7Bpz3LLo2YT92iUeI3
	/EQEfEuTAhiqie4QY4ZRa8bM0PryPdXytwc39j2r+S44Ntm7+PgdoHQbE3hF5MopBdvd/D
	xk3eYLLQGie6OPiz933+dn4hu7jVGVQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4209613939;
	Mon,  3 Mar 2025 08:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YOKiAeBpxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 7/8] btrfs: allow inline data extents creation if block size < page size
Date: Mon,  3 Mar 2025 19:05:15 +1030
Message-ID: <0010fc6e27dbde67022e63e65f68bdfa78202472.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40EFC2117A
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
index c7b0f1173722..a58505f037b5 100644
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


