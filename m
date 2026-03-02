Return-Path: <linux-btrfs+bounces-22151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPJZFCqjpWngCwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22151-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:48:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD81DB20B
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9B26302CC16
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452E3FFADE;
	Mon,  2 Mar 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J7oRmyYK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68B3FFAC6
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462396; cv=none; b=LYlPsOuMQ4Y3lQK/W8cUXdlEv+BgcRb0lRnI/J4jDkaULczDpLzmzR3pcHeMT1yHa1JN5YuFUvntjiaBQsJWAN0VA5Z5fYqIzE9vrK31Gb5V7jrOud+MRDRNWKbIcRWy9ZW9P5ACM/JrpvTWWzMT51O0xxQtJE/u0PX75T2jyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462396; c=relaxed/simple;
	bh=xTdJeOSrZSvYqzllriQ0cHPGY7Z6Wao/zbhs3yArFeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h97dftDsW3ewuuPmuaXJdtVY95E1gS+4gFzUXs+NGG9oRpcJrZiUquygiuFHmVC4E/OYmtaWLRihfLEg8m8C4vJHQSCi1W5M+FVyWOVnmDaoU85f3llirRKS8Bb6DB0aaGhY1qv5eRUpdBt6kF4CQJjezSKmM+w3XofMT4c4drA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J7oRmyYK; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772462395; x=1803998395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTdJeOSrZSvYqzllriQ0cHPGY7Z6Wao/zbhs3yArFeg=;
  b=J7oRmyYKslIryb43KgujF1Pdgla1nuammW3/JiG2GClW8MI33eFYohNd
   G1+gSHF155H3vRMLG+KFav75wb1hbyweOPNyy0LHmicOTsxPpywI+TnrN
   iJMHsu+KVhvdRtk/0hywFzGYSElb/3trDXLcdjtO3AOzo96/mH1n36WJE
   tt+oADGSJf6iF6FBeI6Bh5Caaw6JYsahKKXvjZ7T90TTMzxnrzEf95MSx
   MfUBEwOLrtKDRWqks+6qyMTfD4qxkmjgdAxKe+VgccQl13ItRYPnnljPm
   3YhwdqnTcf/h9WHU8j8CdTRdOyTYw8gsEsaAQy25A8hZTjXHc4Ld2Xhom
   g==;
X-CSE-ConnectionGUID: he7xgqsHRV66/nSK6b3qSg==
X-CSE-MsgGUID: P/iXj05rQtqF11qaoGMsaA==
X-IronPort-AV: E=Sophos;i="6.21,320,1763395200"; 
   d="scan'208";a="141343846"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2026 22:39:49 +0800
IronPort-SDR: 69a5a135_SwdQJQ2h67+vLYmEYvZKya1DODClIexnQLqiulk8/msgltQ
 HvUW+JnbIrTOJTDoMJyyo6FhwGky6hZIpsp0Xcw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 06:39:49 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.176])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2026 06:39:48 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: create btrfs_reclaim_block_groups()
Date: Mon,  2 Mar 2026 15:39:41 +0100
Message-ID: <20260302143942.115619-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
References: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31CD81DB20B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22151-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:dkim,wdc.com:email,wdc.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Create a function btrfs_reclaim_block_groups() that gets called from the
block-group reclaim worker.

This allows creating synchronous block_group reclaim later on.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e95f68d246c6..f0e4a1dd812f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2040,10 +2040,8 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
 	return ret;
 }
 
-void btrfs_reclaim_bgs_work(struct work_struct *work)
+static void btrfs_reclaim_block_groups(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_info *fs_info =
-		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
@@ -2111,6 +2109,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	btrfs_exclop_finish(fs_info);
 }
 
+void btrfs_reclaim_bgs_work(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info =
+		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
+
+	btrfs_reclaim_block_groups(fs_info);
+}
+
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reclaim_sweep(fs_info);
-- 
2.53.0


