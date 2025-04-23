Return-Path: <linux-btrfs+bounces-13281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7910AA9825C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7958168607
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A80267383;
	Wed, 23 Apr 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X0eL+KbB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DP2mQwEt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A08265CDC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395806; cv=none; b=OO4eBBoK15loTMmpiTSYQjLUbBxbBudqDSWn45HjHxyqxHASWyKUHmLZw1QEy1SkS1x7NXMtdGEtWBmhwv1Fpu7XPIUjfDTT/QMqldM7XzAZKQ4vSBi1V+Yt1vrVWSoAU4CcRBxy3wsg46zOfFg1YpI6to6dbptbZD6PYAAoABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395806; c=relaxed/simple;
	bh=2cSfyhXHhJ42GXom0kqjnGO5lfglC3xG8oSxl8JfM6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fffkh2VmHa178/EP0cfXQAQJNj3LvQ8fbaZvJZ9+uRrPnZbnzN5H5QMLmXHpl0qKL8swgfqgactyDPC9C2RTggkRAa0LWxSkO15loVxdiZxr2Ee8H2S39zRcMixVagCipAZI1rL06ozX7SfViABpLBWyYXpJTuIwawAKMbH5GkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X0eL+KbB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DP2mQwEt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDA1B1F7D3;
	Wed, 23 Apr 2025 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745395802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MCRBBOJuZClETEUqixfcgMiw71j1SO+5sacu/xekEao=;
	b=X0eL+KbBxVoDPpj3zNoOtdnWfvXKKeXx2MzMadN4kkXY2FvnCSghlJxGBAIZaOAIwMMvyi
	Jwc2P6nrCoe0eZ+MM0RGVTAqNO8+A/KC+KJXRHWfhiZg47wPwXL8+YeM0XDl8Hdve2oJ2v
	8mlMM7/AmWP7EEOn3W676ZVq3bHmDyc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DP2mQwEt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745395801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MCRBBOJuZClETEUqixfcgMiw71j1SO+5sacu/xekEao=;
	b=DP2mQwEtcBIneT+iowSZ1uVTeNEZdtWCUppdDu0fyL9efuLxM3madybFM1rmw7eGemHRtJ
	gzvVMZ2MJN8KOTLtB0eSPq+trrkA0GNybL97hng+RGtD0qJZ1SxP9gY1XDd0Ndb3ahDNTT
	/m/ae+JMb6AfKl9Ns6P5WVaopUvdn/0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3B3413691;
	Wed, 23 Apr 2025 08:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wrL1MlmgCGgycwAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 23 Apr 2025 08:10:01 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fiemap: make the assert more explicit after handling the error cases
Date: Wed, 23 Apr 2025 10:09:39 +0200
Message-ID: <20250423080940.4025020-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDA1B1F7D3
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Let's not assert the errors and clearly state the expected result only
after eventual error handling. It makes a bit more sense this way.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/fiemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index b80c07ad8c5e7..034f832e10c1a 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -568,10 +568,10 @@ static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
 	 * there might be preallocation past i_size.
 	 */
 	ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
-	/* There can't be a file extent item at offset (u64)-1 */
-	ASSERT(ret != 0);
 	if (ret < 0)
 		return ret;
+	/* There can't be a file extent item at offset (u64)-1 */
+	ASSERT(ret == 1);
 
 	/*
 	 * For a non-existing key, btrfs_search_slot() always leaves us at a
-- 
2.47.2


