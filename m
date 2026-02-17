Return-Path: <linux-btrfs+bounces-21701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKqzGbxFlGmcBwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21701-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:41:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7214AF2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA14E301FA8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A7326D73;
	Tue, 17 Feb 2026 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="T3WoyDHp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D683033F1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324852; cv=none; b=INH+vBGl42mGJltc1O6Ub6NVXtP9+aNtto8vRiC+lpXfxtfCGdU4/6WtyG7/Il4RvvT4+DzZIiT6Lh9vV6Ls3lJC/igwXqdOFGGqXc3T1comKerJMXSVHa2cuvz0nuZ71yQVWy50hpiQAzlv+aQO69I8eKyx2MIXfteSSitWZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324852; c=relaxed/simple;
	bh=+LHdh3r6LulzeAwjQ7Fsxs0Kxyxu88KxnpV9aMhUybM=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=us2vCfDtgSBXyAToZCa425RSEeT30xp1SaBOzpAHYQSZY5rMMoNNwSIBjZ0aewKU9MmqFwMCuRzUoyfnCYn7V9hSUHRtoV52I/2Fsjpdjg+870UpfSCspHVgHnsvqn5CXioSGUrjHEAjKdWaBHIz4eZMinx+IZxrmIDQAWs4xZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=T3WoyDHp; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 9D08D302E0E;
	Tue, 17 Feb 2026 10:34:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771324462;
	bh=MpJyN629aRuF3Xne2OHUwRse7Ut1UftK3rUb2zNQ3xc=;
	h=From:To:Cc:Subject:Date;
	b=T3WoyDHpHnBa/Mz6e8RjyeDuCVSv0I1JEjfluEUO3N8raAJw/5PHIP0ogM5MahU/7
	 1tBjx3aqWqdIWdXED4uhGwQMI2NmjiJwGKvwYK7TXUrsBKAqGAjHbboJnFfRzdyHzL
	 4mQaFLMb4yVyYMafDTD3HZNZC7wbhQbgNHZ1J0qI=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Mark Harmstone <mark@harmstone.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: fix incorrect error message in check_dev_extent_item()
Date: Tue, 17 Feb 2026 10:34:08 +0000
Message-ID: <20260217103419.19609-1-mark@harmstone.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21701-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: D9F7214AF2E
X-Rspamd-Action: no action

Fix the error message in check_dev_extent_item(), when an overlapping
stripe is encountered. For dev extents, objectid is the disk number and
offset the physical address, so prev_key->objectid should actually be
prev_key->offset.

(I can't take any credit for this one - this was discovered by Chris and
his friend Claude.)

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Suggested-by: Chris Mason <clm@fb.com>
Fixes: 008e2512dc56 ("btrfs: tree-checker: add dev extent item checks")
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 452394b34d01..9774779f060b 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1921,7 +1921,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 		if (unlikely(prev_key->offset + prev_len > key->offset)) {
 			generic_err(leaf, slot,
 		"dev extent overlap, prev offset %llu len %llu current offset %llu",
-				    prev_key->objectid, prev_len, key->offset);
+				    prev_key->offset, prev_len, key->offset);
 			return -EUCLEAN;
 		}
 	}
-- 
2.52.0


