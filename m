Return-Path: <linux-btrfs+bounces-9875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4EE9D78E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F9B25991
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C017E472;
	Sun, 24 Nov 2024 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pg0uqhs5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pg0uqhs5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF1169397
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488232; cv=none; b=sao8B07/CRdrVzAq7KRXB2ZFJqjwlGDsIO5CwQ5EAVlN7w1+Y4gx0YbSdrz/Yxg8SsnTrDxEwgq5ymWTKKY/vidGlIyDHrJskS1YpBYRr5+u1WKFhP/UBkRGBcg6XLOaw2Q7qEAJjPlzUl8BpnXl5w5Mg3AoC7FID4m1Q7ZtWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488232; c=relaxed/simple;
	bh=EDoHqbN6guOoX0fVu5kd+C0bKXcmeidHri/8OQY1Y/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JRTsLEjcuD74xt1XOFByAgCMFashYfdHuuXo/3dfUdfjCDjAoUQZgxoXxpCCjljNoNGGofDYYAQJUH7G4mHkM0uv5ISqydyjjkMU40jyd/AAWhTe/kuCYqmsM25uIa0OOStFrcyfGFD1I17ewfy25cvm9MlvgO2xpoIaD/TxY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pg0uqhs5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pg0uqhs5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0AEE2118A
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732488222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8xEKE2m0F0EsvEanoqcaK1aJZ5FEx6QEaLStsf51mz8=;
	b=Pg0uqhs5pY1FivbDkYG4tTYU54fWQDBXE4/JGLEXdOHFAG+rwHR/lWVgw9WZxQS9Y/3qAU
	Nf8YwM3KZZtAD09UtZKbnYdPfOJY+IuyEOiB9JRzQMXRv/ujf46h3FZ6ci748m+wOiPvtf
	kGUwtZMIJNAmTtSxt4eDGLDIuSRgqMM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732488222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8xEKE2m0F0EsvEanoqcaK1aJZ5FEx6QEaLStsf51mz8=;
	b=Pg0uqhs5pY1FivbDkYG4tTYU54fWQDBXE4/JGLEXdOHFAG+rwHR/lWVgw9WZxQS9Y/3qAU
	Nf8YwM3KZZtAD09UtZKbnYdPfOJY+IuyEOiB9JRzQMXRv/ujf46h3FZ6ci748m+wOiPvtf
	kGUwtZMIJNAmTtSxt4eDGLDIuSRgqMM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEEF213690
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 22:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4e+Ix2sQ2erNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 22:43:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use PTR_ERR() instead of PTR_ERR_OR_ZERO() for btrfs_get_extent()
Date: Mon, 25 Nov 2024 09:13:24 +1030
Message-ID: <1453d9d1513fa03098f5bf4d2fbecb29f7fd1332.1732488201.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The function btrfs_get_extent() will only return an PTR_ERR() or a valid
extent map pointer. It will not return NULL.

Thus the usage of PTR_ERR_OR_ZERO() inside submit_one_sector() is not
needed, use plain PTR_ERR() instead, and that is the only usage of
PTR_ERR_OR_ZERO() after btrfs_get_extent().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e629d2ee152a..438974d4def4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1335,7 +1335,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
 	if (IS_ERR(em))
-		return PTR_ERR_OR_ZERO(em);
+		return PTR_ERR(em);
 
 	extent_offset = filepos - em->start;
 	em_end = extent_map_end(em);
-- 
2.47.0


