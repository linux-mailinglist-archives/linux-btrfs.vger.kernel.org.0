Return-Path: <linux-btrfs+bounces-16555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E82B3DB40
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A173BEE8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404626E17D;
	Mon,  1 Sep 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BWOQPkYe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499726CE22
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712333; cv=none; b=Fkr3quU4XXdaGCDT2rxz6iPnOAKV6QB4wCiSTCsCsDZmwOOxA4gdrW6ob5PSZBoSdEtzJxp9VqExLcN2tiJ3g6RmS94HglT2l6wLNlVPj3Er4rPpJrjMaF8ClwMBFRoebzKZmXEdR6THg6EmqKCO63l1U77ByY7Y/a62limspA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712333; c=relaxed/simple;
	bh=W5cjMV8gNQlvkegO1MaGlxoPLYAxkN/GUnUApnblvI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmsXSWdbj+C0Quz/4rFl9tBEI96R3CSqHK0Ds2wD8mUxGJ50SOPhfH8oFN7Ha/JVMaaFQDXo1LswDrQJwj2sYFN0l+siSCdAIZRvpzIIC853hSdb2xFT/YPuRkh2P6NqF+0xtae2jtkVsqYlK5p4bIN98cRCC62U3uxFqhUUO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BWOQPkYe; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756712331; x=1788248331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W5cjMV8gNQlvkegO1MaGlxoPLYAxkN/GUnUApnblvI8=;
  b=BWOQPkYeDqBymSPc0uzjC2JSBiCN3SRowHaDiVueo0X9Uzvg7WtqNYrv
   aWHtHJ5NmRv/mXss3sxeDQoNWO30pfxREboFM06Tcus5uUZz49g0f1dDj
   V0XKEWT06LFWqZVcx1Fg0WqB3LN18ECW6XBysLZojZB/D9v0VEp/sV8YZ
   ++SdS1Gve9ZsiJgN9Dx6qzg4MCVustClozJuhyb4+DOlxWSgldVmtJ0lh
   4sNg2u0+6BIXmx9H+dI9xX/zJOPhnlwVNvIef/athcv77NxMRZYIHJV4i
   M6tQ8kRzSpU9b73yfD3zRp2cFmJ12UYjAf32kOADAbRiBFFlCoYUEVFQW
   g==;
X-CSE-ConnectionGUID: ql/Xi79JQjGIb7moBGwU7g==
X-CSE-MsgGUID: tuDUbMIGTtOCV91Gmtsf+Q==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="107117065"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 15:38:51 +0800
IronPort-SDR: 68b54d8a_Rg4vSUHKVObsPGaahBRxQEeii8B6gRSMN3gbbCjMMPNNlYU
 IE5z4pOdbLEQOZThwYxITlUGqHsfAq55PKkqIjA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 00:38:50 -0700
WDCIronportException: Internal
Received: from wdap-uxdzwi0ixx.ad.shared (HELO naota-xeon) ([10.224.163.20])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2025 00:38:51 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Date: Mon,  1 Sep 2025 16:38:26 +0900
Message-ID: <20250901073826.2776351-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to recow the stripe tree as well. If not, we leave the tree node in
the temporally SINGLE profile block group, and we cannot remove that SINGLE
metadata block group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index f0d2e42421e6..34a4ee4fd6db 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -337,6 +337,11 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
         }
+	if (btrfs_fs_incompat(info, RAID_STRIPE_TREE)) {
+		ret = __recow_root(trans, info->stripe_root);
+		if (ret)
+			return ret;
+	}
 	ret = recow_global_roots(trans);
 	if (ret)
 		return ret;
-- 
2.51.0


