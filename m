Return-Path: <linux-btrfs+bounces-21751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDf5OeW3lWmNUQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21751-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:00:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B61567DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B3283008C28
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB30324B24;
	Wed, 18 Feb 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="nspWDGAd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151C3246F9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419618; cv=none; b=lJ9q8GleVg1P6UiwuxVeymrlrzvM3+VFaCJF/iy4psrmNtTyQM2bd8vrd2JTp25VpuhPIYw2FTPLBlcbvpgrF2vCniORWIPN3nAzdWOGfkzRXqSYkqQxo4l3PWZQ+f/XIFcT5KDGgvDCiH49Eni2v5JPsVWN4RSvZF3oYxt/aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419618; c=relaxed/simple;
	bh=Q6wzqliQKiW7wxGUyGOlH1dOuAUdePgtvcVpjoxQxlc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=E+2I93M56/xV1ZZHrqV+6o6D0RwZmMx1xYlVw5XDaEM9erCku3nGTPSiEL6iDm5okjsj0AsrPl1u81NQzlTRau0u3zzc8p9uiV7zVEN6sDxfT2FjWHj188+gTpsxBw7WSr7ILv3a/ewNXiLzuEOidW93aa0cta7m3xcgpBzCh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=nspWDGAd; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id ED006303718;
	Wed, 18 Feb 2026 13:00:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771419612;
	bh=yMzeBc1Gepcpq/C8IwrNUbs6HpJ8cfMdTAZmu2lA1Zk=;
	h=From:To:Cc:Subject:Date;
	b=nspWDGAdl6W3UubVTheaNfDBcATF738/D1MgEZk5PhVLMz/Cd5nTNEYXFSUkpS7sj
	 VTdIvnAqhlYqYLeMhHyKX4VKYamYXjJ99PnQP8NBHdjzaZZoGOC/PQPxLjmPSl66wN
	 rHLBWFHomy3of3cW2ZmejMsbmtxMx/jAmk5HznhE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: fix unlikely in btrfs_insert_one_raid_extent()
Date: Wed, 18 Feb 2026 12:59:31 +0000
Message-ID: <20260218130006.9563-1-mark@harmstone.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21751-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E1B61567DF
X-Rspamd-Action: no action

Fix the unlikely added to btrfs_insert_one_raid_extent() by commit
a929904c: the exclamation point is in the wrong place, so we are telling
the compiler that allocation failure is actually expected.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: a929904cf73b ("btrfs: add unlikely annotations to branches leading to transaction abort")
---
 fs/btrfs/raid-stripe-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 2987cb7c686e..638c4ad572c9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -300,7 +300,7 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 	int ret;
 
 	stripe_extent = kzalloc(item_size, GFP_NOFS);
-	if (!unlikely(stripe_extent)) {
+	if (unlikely(!stripe_extent)) {
 		btrfs_abort_transaction(trans, -ENOMEM);
 		btrfs_end_transaction(trans);
 		return -ENOMEM;
-- 
2.52.0


