Return-Path: <linux-btrfs+bounces-22065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Iy0EMSYoWl8ugQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22065-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 14:14:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81381B7813
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B60F303C4EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8013C1980;
	Fri, 27 Feb 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P5aLF640"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7A31986E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197950; cv=none; b=NzVIy2gRKVqtJMC8QLaMpKiCXgQ2Cgm9/VBMjk66Qtaq1XLDIJ/MAC408nQ7+QNG7P93Tmk3tENT6RZjTcR2/ULtQjWs5Y9iXQWG1d1o8UJR4D7G3vcBc/ZJe3voAb/BzUs6jy737Mms0XOjMBKQEAy/qz29ZuUPjj/RM/0bMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197950; c=relaxed/simple;
	bh=0TXBq1CjHEqPX1CZsMnHNdNWkIhy6JKHXIpzouqna/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCelr7iLBRU2LcZiIB7mJbfDr4lU1LwKOvkR9CZy7d+I4UBwmCbBhuTUqdilU2LSmODGG5NO/jLrkU+17MjT0mGE5pzta4Et/f0JQTO4oSr++ek50DcEwm+cUrS1HCpZghaesTdegSOB68l34MhkfLgvV/Ki8uELlCWwfKXQgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P5aLF640; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772197949; x=1803733949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0TXBq1CjHEqPX1CZsMnHNdNWkIhy6JKHXIpzouqna/0=;
  b=P5aLF640fO66Ou6fTRrSr3Dsy9pknpMFeRumw7BoEPQQ2elr94ypcG5u
   fFwpdgRZbY4io9rioMH3s1CXQ7pCUxBY2DMKWFi9TsE0pIrCcqoZeGEF3
   6nGAu0QYzKHES47WljaBUJB3Cv1+a755yHJuolyYyBqIoPFQbvXQ7NKjQ
   F741WVFwjRE+cyQr/h/sWggFD/Fh6JvE7Gf/W/XJHFYemlBNtxd8zyFf8
   yllllzvGdMAlxA6vBBxbKxTBbegEB5VliV43fNydHtjQRZKn7CRur55FR
   mdBKzJX9hXV3aiYffTwSlqxtQncI5pXwOp9xq8t5pLVbxrYGwBl5cEDo2
   g==;
X-CSE-ConnectionGUID: 5MertYz8TaS850gjuUfnbw==
X-CSE-MsgGUID: cmxispmGR1GohV9XeYY/yw==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="142717442"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2026 21:12:29 +0800
IronPort-SDR: 69a1983c_Vb6FGPZU8HZUNprCNs4QV6WEdMB2hqHyeGFQ+RgwKAryDWW
 +Gt9iz6ZaVldjMybOq4IMFkZHi+iWdNnt0QvjGQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 05:12:29 -0800
WDCIronportException: Internal
Received: from wdap-c0ecwecpdk.ad.shared (HELO neo.wdc.com) ([10.224.28.161])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2026 05:12:28 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: pass 'verbose' parameter to btrfs_relocate_block_group
Date: Fri, 27 Feb 2026 14:12:24 +0100
Message-ID: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22065-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81381B7813
X-Rspamd-Action: no action

Function `btrfs_relocate_chunk()` always passes verbose=true to
`btrfs_relocate_block_group()` instead of the `verbose` parameter passed
into it by it's callers.

While user initiated rebalancing should be logged in the Kernel's log
buffer. This causes excessive log spamming from automatic rebalancing,
e.g. on zoned filesystems running low on usable space.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c0cf8f7c5a8e..95accc9361bd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3595,7 +3595,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset, bool v
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
-	ret = btrfs_relocate_block_group(fs_info, chunk_offset, true);
+	ret = btrfs_relocate_block_group(fs_info, chunk_offset, verbose);
 	btrfs_scrub_continue(fs_info);
 	if (ret) {
 		/*
-- 
2.53.0


