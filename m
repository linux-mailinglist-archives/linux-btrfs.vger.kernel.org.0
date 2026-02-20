Return-Path: <linux-btrfs+bounces-21804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLT1GTpdmGlRGwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21804-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 14:10:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C5167B00
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 14:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C4B3307AA19
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01D346770;
	Fri, 20 Feb 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="wSdFWNqW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E1331200
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593011; cv=none; b=MOYLIKHqaWXP5Ab8/JxxVQC9nuxx3F5F4IrGfss2r1w3izLpaRL03g+1LiqvCAENrvn1CS5JOlsW50eVgswB8bwXOBt7rDFGD1PDl3n86xVab8wk7g+XM1O71VRfiIRJx/EgG2Enl/+Sy0kYofMFFDu1w9zlE+Ljif59DXtTlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593011; c=relaxed/simple;
	bh=bbGBt/WLXO9djENELyIAShZ1IM4RBegc2tBi2BATkJE=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=bIselGwsXUzpLFDjpL/vZfE7tRWBp98/81syxl50ovUSxzjAfD1Y1JCX8Q9oe9IfyEWwKDxCNv0fZfZAccF7eP13JTrTdAlYl/Wos+jEqawyva0yfc1Zp6aFv6JE2a2JalxMpbHPsBfx9TV6hDQYZ5lPeZq/Pok4XyjSGCPOVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=wSdFWNqW; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id AE85A3046D5;
	Fri, 20 Feb 2026 13:10:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771593008;
	bh=uFpkYe0yHQYAYvH04gYds7IZFScMRNiqZk0pmxbpYE8=;
	h=From:To:Cc:Subject:Date;
	b=wSdFWNqWA0j6YdmwysqL2h4kTB0drh4VEbCyapNf1pyJBY9fi3V0UsUYWpJU+L+p0
	 6V07irzlMgiT8HBD+lxGjbV6WueNf0ssdTBVlAJIIBxWcm4yeTB2AGV34UYHPx4Xlg
	 24qNDLhD8UxFZ5BUSAMuc8zTfVw5wE9TnuhPwzYc=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: fix chunk map leak in btrfs_map_block() after btrfs_translate_remap()
Date: Fri, 20 Feb 2026 13:09:54 +0000
Message-ID: <20260220131002.6269-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21804-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:mid,harmstone.com:dkim,harmstone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: EA9C5167B00
X-Rspamd-Action: no action

If the call to btrfs_translate_remap() in btrfs_map_block() returns an
error code, we were leaking the chunk map. Fix it by jumping to out
rather than returning directly.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: 18ba64992871 ("btrfs: redirect I/O for remapped block groups")
Suggested-by: Chris Mason <clm@fb.com>
Link: https://lore.kernel.org/linux-btrfs/20260125125830.2352988-1-clm@meta.com/
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 83e2834ea273..1bd3464ccdd8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7082,7 +7082,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 		ret = btrfs_translate_remap(fs_info, &new_logical, length);
 		if (ret)
-			return ret;
+			goto out;
 
 		if (new_logical != logical) {
 			btrfs_free_chunk_map(map);
-- 
2.52.0


