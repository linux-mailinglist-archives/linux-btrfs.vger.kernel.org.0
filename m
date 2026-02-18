Return-Path: <linux-btrfs+bounces-21756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BbzTMMrNlWnPUwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21756-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:33:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E590157135
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA0C3015A77
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D116330641;
	Wed, 18 Feb 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="wB0ChZ74"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F327C866
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425221; cv=none; b=GStUHhiGGTBgmWL9zukQazqGcSRBaV6rOKGGbW2u8/k8fdK2kP5Ntwp5aG46vVsIzBNGCipKDvHlNX1CNKZi87KGzWANUVAvjinktnOcsSP6q5b9hr1QHmJZtt0lUqvO0m4KOCg9yixI/d5Gg2BOjBDHLoxYBd1p7GN+l97c67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425221; c=relaxed/simple;
	bh=LYu0oKLpGthsrpQugk54mWx+qi6tvmMVPj8SwKijGwE=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=H0POVVqGXftNdTV5OoyP3JlNtR7Ma8ldBY6HMJ2L6zSQ1lKInI030qdqh3oqJmnJuKOtoje+5I2gTz9Yhlm/CIlk5OJr5i18qdLCifXCxaQLWwd1RHkUV9+KEANpaw+y1PHvAMOOcJbTeb7x/ymWO4LHRXqBPWY3uZDILyr5hYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=wB0ChZ74; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id C746B3037AE;
	Wed, 18 Feb 2026 14:33:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771425218;
	bh=6D/GRXWD5K8LBKfkHRsZNfakLG2vtubO73roeSRoJ0k=;
	h=From:To:Cc:Subject:Date;
	b=wB0ChZ74sFKXWBpPb+QiuB8Epx4AsbksXba7v7ZHMpfhvWSFXfWzwN4WCb6kmJDZM
	 ZWE5IWE2KldaBuI8T2MWg1y/9xoJ07AYzbzCEJBCZLkCxJ0qoFcRWtKCeKnLc6Ws2v
	 dre6mjhVyb7gsr9rTWUG3JWLFw/bZV2nA5WR9e0Q=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: fix chunk map leaks in btrfs_map_block()
Date: Wed, 18 Feb 2026 14:33:29 +0000
Message-ID: <20260218143334.25014-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21756-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email,fb.com:email]
X-Rspamd-Queue-Id: 1E590157135
X-Rspamd-Action: no action

Fix the two early returns in btrfs_map_block() so that we can no longer
fail to put the chunk map after getting it.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reported-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/volumes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 83e2834ea273..a1f0fccd552c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7082,7 +7082,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 		ret = btrfs_translate_remap(fs_info, &new_logical, length);
 		if (ret)
-			return ret;
+			goto out;
 
 		if (new_logical != logical) {
 			btrfs_free_chunk_map(map);
@@ -7096,8 +7096,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	num_copies = btrfs_chunk_map_num_copies(map);
-	if (io_geom.mirror_num > num_copies)
-		return -EINVAL;
+	if (io_geom.mirror_num > num_copies) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
-- 
2.52.0


