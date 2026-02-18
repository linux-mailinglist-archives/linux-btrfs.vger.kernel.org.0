Return-Path: <linux-btrfs+bounces-21749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICxZAKeqlWkxTQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21749-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:03:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21E156362
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B895130137A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BE2FF147;
	Wed, 18 Feb 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="aOoXjeyv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D12D7D47
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416211; cv=none; b=MmGk34B3qV9h/2w+Tr8RjDawCWNkwGb5Sclq3IZg4LZNoVezHFaEtbpSkmrDUHUhtN85XhpcwTYY5KaX7UThhQ0NyswCElsIoksEJHQjVWbIOBPmZyMFCR26XZfsSTYg2sXis5mPjol48AN1Mnl3hW4FbzjIi/FIx/VZfnUlO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416211; c=relaxed/simple;
	bh=OdxcdFXac3WysoPcVqZrWbh0Y9eSlbezu5zf3VB52iw=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=rg29ewvqsXtQ0Kd6Qsp0coQp1+prI9H/2CNR1rUzMeMFqm51zRWg8XU9e1+Df/PfBFsCxO5o7f80CMdoZm0xYsSPZFYYEcS+GytiNroGe26aUiOj25XWRnoq8by5mWshzW3oJGSKNoWvxYqUsCzfnH5dMoajAWkpVikvxOLxqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=aOoXjeyv; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id C2F8B3036B2;
	Wed, 18 Feb 2026 12:03:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771416207;
	bh=q7R0BtiEFmThW1sMg46YUCwWcwBvqq+6Z9Cn/3PubRA=;
	h=From:To:Cc:Subject:Date;
	b=aOoXjeyv2zzDI0xGWN5To2BCpl0Xm7zUiHhdWOFprP5fQOuNfoBQUHi5Ib6olMH/n
	 nSzWuH4jL1MbUsMFQ4AXKvHVpwzuLO8EJLnMfpwF935sVzNlPO1JdhZgjavbkUs+cd
	 4CFUva0FfbbDctSfdaNd/yN4c8mUDiRSuUvy9RYo=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	kevinhu@synology.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: print correct subvol num if can't delete because of active swapfile
Date: Wed, 18 Feb 2026 12:03:07 +0000
Message-ID: <20260218120322.327-1-mark@harmstone.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21749-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: 5B21E156362
X-Rspamd-Action: no action

Fix the error message in btrfs_delete_subvolume() if we can't delete a
subvolume because it has an active swapfile: we were printing the number
of the parent rather than the target.

Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4523b689711d..233d91556fe4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4804,7 +4804,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
-			   btrfs_root_id(root));
+			   btrfs_root_id(dest));
 		ret = -EPERM;
 		goto out_up_write;
 	}
-- 
2.52.0


