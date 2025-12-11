Return-Path: <linux-btrfs+bounces-19636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32EACB489F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 03:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E863011EF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE32C0303;
	Thu, 11 Dec 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="II+OuEnT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="II+OuEnT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83C2BE02D
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419360; cv=none; b=Bxl1c8VpzE0kHe46NMGJhAxETN5f7TpKDpIaSEUHGIOKM3hImkReWcbunfODMxPaMyvj6B+Jve9j71Nk/OCqo41ATkFCQhcLoNBp+vcBa6pSpfT0ZjOXQeN7RtJhhR8Le0TXzxNJ68IZ/2QtbY0sV5Tgp8fMyZJo751H9E9K7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419360; c=relaxed/simple;
	bh=MB1Bwk+SADTi5i40WrVyZ2SDBdFQdCbL2Pi3DphCtLg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+/xqj/md+SKuQM9tuctID04yLJpGXNqQ2WsSp7EAywJpJwfdXCIaP00MgoZXbRl+3EWlSIcyOqaUNmODjvYUvO1sB9+/jjWC/RPscRWlG3CQmQKgVhEMYmv2vAQIphCh7JS1ldr/C1VCmn/2Hzr3fbVxZp9Ic+P0269wBh/2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=II+OuEnT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=II+OuEnT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD5D7336F6
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkaez2Gm5VTNtcYOfB9kqrbTG+vQQGb1/ZFO/GlQHHs=;
	b=II+OuEnTbf0yjs+QEkAtrnjjASE5O6FxKocCpx0vIwaa4hkAkf+aAYVz4oniQv6gVijC9X
	pa5fXQxSn18EutKvzbUosz80k2JH6n57yQiZMf7ZB13Np6FdBpIiYrXCFEX91uUSbxZ/Gj
	70AzMHr77zrH2iGF0aqN/21jI3Pju5s=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=II+OuEnT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkaez2Gm5VTNtcYOfB9kqrbTG+vQQGb1/ZFO/GlQHHs=;
	b=II+OuEnTbf0yjs+QEkAtrnjjASE5O6FxKocCpx0vIwaa4hkAkf+aAYVz4oniQv6gVijC9X
	pa5fXQxSn18EutKvzbUosz80k2JH6n57yQiZMf7ZB13Np6FdBpIiYrXCFEX91uUSbxZ/Gj
	70AzMHr77zrH2iGF0aqN/21jI3Pju5s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01D1C3EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLOSLUopOmmBAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add an ASSERT() to catch ordered extents without datasum
Date: Thu, 11 Dec 2025 12:45:18 +1030
Message-ID: <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765418669.git.wqu@suse.com>
References: <cover.1765418669.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: BD5D7336F6
X-Spam-Flag: NO
X-Spam-Score: -3.01

Inside btrfs_finish_one_ordered(), there are only very limited
situations where the OE has no checksum:

- The OE is completely truncated or error happened
  In that case no file extent is going to be inserted.

- The inode has NODATASUM flag

- The inode belongs to data reloc tree

Add an ASSERT() using the last two cases, which will help us to catch
problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
extent when skipping writeback past i_size"), and prevent future similar
cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 461725c8ccd7..740de9436d24 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
+	/*
+	 * If we have no data checksum, either the OE is:
+	 * - Fully truncated
+	 *   Those ones won't reach here.
+	 *
+	 * - No data checksum
+	 *
+	 * - Belongs to data reloc inode
+	 *   Which doesn't have csum attached to OE, but cloned
+	 *   from original chunk.
+	 */
+	if (list_empty(&ordered_extent->list))
+		ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
+		       btrfs_is_data_reloc_root(inode->root));
+
 	ret = add_pending_csums(trans, &ordered_extent->list);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.52.0


