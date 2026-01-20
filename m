Return-Path: <linux-btrfs+bounces-20767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OEQMZ+GcGkEYQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20767-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 08:56:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA55531CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C99FA62C52D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EF4266A1;
	Tue, 20 Jan 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="VmhpCCg7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9235CB65
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913431; cv=none; b=AKFWQPD6YswteBgZ8jMafQSGtU8yGIA6f8uCWRhg74RnNJnB+18tBTyD9Wj5bDTzZqy46/4M/nB948umHjuLv8Ixi0MsW8vOpVARbN3uc/8e1Wf0Lt4xxlXcWC7Pl2Fbx5jJaKho+MVM2rfCH8rtZJ5o3GHGvdVTiIVBUrzgVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913431; c=relaxed/simple;
	bh=9EeskUwd11LV7wFXjPr45azGCMQ3o0OQB6ZyNzAUOjw=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=FWv8CSYvI09QxObTxJStxiLNZ3BxAe1SdRvj6tTOomvNIzWd9jRIM/PnQhtP4IXB0cKc1fzccv1kjTd4rT1vV4feqG6aF07Ks1SGPm4Tl2tJAsfeSvMYTBncC4+zxxfTws/YNGPIfRj28bGfxVlXLS1aHmaPXuWcFp4Coj5++EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=VmhpCCg7; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 760942F6B8F;
	Tue, 20 Jan 2026 12:50:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1768913423;
	bh=Y3rBioGsRkDFR5SLxiAyxq8QfdOXTSDDGzoyQhKaIKQ=;
	h=From:To:Cc:Subject:Date;
	b=VmhpCCg7LpJ9OTjJaDjxSm0fZfA7THLU399JqL0JPNWhidVZ52UdjKQS742diFs80
	 BgsTLo8yd6zx2oKFN9kBhUnmW8DhBF1SUm2Y4ZVZBO6/5n70CmIni5Z3xm9ZV6o1m+
	 +6VM4p6mNB2VDhI17gJRjkqjO6sCmV+OfVkrTv2s=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: move BTRFS_FEAT_ATTR_INCOMPAT for remap tree behind EXPERIMENTAL
Date: Tue, 20 Jan 2026 12:50:18 +0000
Message-ID: <20260120125020.26633-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20767-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_POLICY_ALLOW(0.00)[harmstone.com,none];
	DKIM_TRACE(0.00)[harmstone.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,harmstone.com:email,harmstone.com:dkim,harmstone.com:mid]
X-Rspamd-Queue-Id: 3EA55531CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The patch "btrfs: add definitions and constants for remap-tree" added a
BTRFS_FEAT_ATTR_INCOMPAT for remap tree, but this should have been
behind a CONFIG_BTRFS_EXPERIMENTAL #ifdef in order to avoid an unused
variable warning.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 21645a98cfe7..27bfb7b55ec4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -291,7 +291,6 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
-BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -300,6 +299,8 @@ BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 /* Remove once support for raid stripe tree is feature complete. */
 BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
+/* Remove once support for remap tree is feature complete. */
+BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
-- 
2.51.2


