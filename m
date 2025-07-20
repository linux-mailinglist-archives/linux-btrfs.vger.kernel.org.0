Return-Path: <linux-btrfs+bounces-15575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8BB0B3CA
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA290176A3D
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBE01C4A13;
	Sun, 20 Jul 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h1hWCdCS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h1hWCdCS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE420B22
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752993000; cv=none; b=aUocEx9L4pIVdhBD82D5ZAIif/eBrHQO9CBGjbUJiAaC85vzQRQBW8/6ETHVq53v1W5mFGYKlYfoljVldWZ9IMORWc8IhNPRREQfT64OLz1GGEgz8z1W7w6LfJhk/aXtz2w+BlHCphUFaGRxsTiyzHVYd2cBDBdwU+6VG00q9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752993000; c=relaxed/simple;
	bh=a7ipzNNgAYpAvaS+B09M0J9vBCPqg4+wX5vIN3W1rhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV0qQErwUE49dGixxlwi3VJmPsAoWx6MrGtcnxZBSCabjhlLdZ/ThTfyWyDIj98pHvFn30D5W9NpKWX84261XB22hRAT3E1eA78UUTKpKAtCLfA2PIAT8uT0jYrepl40YqTB9N+EL9vj1ti8BQh2V64hwma9ixTxAv1H0QAbsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h1hWCdCS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h1hWCdCS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFC1E1F391
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgoB9QHP99Ro0KefQGW1yErdgyPjuFTFA3RJT672fAY=;
	b=h1hWCdCSvyGAhRLA7WRVa4hpa2+R0GniK8MD3eyQ2P2TimEELmXhj2t4NvskHpcTm1PEgy
	TWJDEPtUXVRe8N6VzncevWsmW5leDNyvz7x22jt7KSQ2To+uzF8vSRnGnrBEdlpNMQojFx
	vK03XBXfcQF4pQsTA1oURzq3gEKDhlU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=h1hWCdCS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgoB9QHP99Ro0KefQGW1yErdgyPjuFTFA3RJT672fAY=;
	b=h1hWCdCSvyGAhRLA7WRVa4hpa2+R0GniK8MD3eyQ2P2TimEELmXhj2t4NvskHpcTm1PEgy
	TWJDEPtUXVRe8N6VzncevWsmW5leDNyvz7x22jt7KSQ2To+uzF8vSRnGnrBEdlpNMQojFx
	vK03XBXfcQF4pQsTA1oURzq3gEKDhlU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D4E13A1E
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PqdKMyMfGjJfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: fix the wrong parameter for btrfs_cleanup_ordered_extents()
Date: Sun, 20 Jul 2025 15:59:11 +0930
Message-ID: <15717a81b5c75c91a129bdb4b81671a4fe2c5e8c.1752992367.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752992367.git.wqu@suse.com>
References: <cover.1752992367.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: AFC1E1F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Inside nocow_one_range(), if the checksum cloning for data reloc inode
failed, we call btrfs_cleanup_ordered_extents() to cleanup the just
allocated ordered extents.

But unlike extent_clear_unlock_delalloc(),
btrfs_cleanup_ordered_extents() requires a length, not an inclusive end
bytenr.

This can be problematic, as the @end is normally way larger than @len.

This means btrfs_cleanup_ordered_extents() can be called on folios
out of the correct range, and if the out-of-range folio is under
writeback, we can incorrectly clear the ordered flag of the folio, and
trigger the DEBUG_WARN() inside btrfs_writepage_cow_fixup().

Fix the wrong parameter with correct length instead.

Fixes: 94f6c5c17e52 ("btrfs: move ordered extent cleanup to where they are allocated")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5259bb8ec430..6d9a8d8bea4c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2018,7 +2018,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	 * cleaered by the caller.
 	 */
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, file_pos, end);
+		btrfs_cleanup_ordered_extents(inode, file_pos, len);
 	return ret;
 }
 
-- 
2.50.0


