Return-Path: <linux-btrfs+bounces-704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE7806CC0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DC2819D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D930CE8;
	Wed,  6 Dec 2023 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NENjOBEf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CA12B;
	Wed,  6 Dec 2023 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860183; x=1733396183;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
  b=NENjOBEfAExfVyQlmrHj7PFLOBg0oajd7sNS1ObSI5pdmXFQ9hVevJ0q
   w7Q3y4mRoEyQ7z8BbzP6aC0YMlA33FGH9fIZKIVW9a0lJtqbOQIieb/ya
   0ZW/2V3T75etkz7ALBgnZiZ8D69o2xvUYSSEhrl5sHzTiB3x5Sb+GPHAZ
   9b0+DEAleedjVhH+1NC/6X4VngpY0zlh4iLWsDg1+i4rVAwlTxZcVzxax
   Gj7tMAPHu8MFx/WVQSKS9ymYW3voJv5PzbmjYYN64aCBd/nvQZeOBqlI3
   yPtsxdfOf+NxzfJKdfUERIZqm8hAu1ozTgu0ORcm1I7rcl17FfPwCMWea
   Q==;
X-CSE-ConnectionGUID: x6LAKF08R4mK/QoD9yyVBA==
X-CSE-MsgGUID: dp+SSm4jT/S8yN1pU7kdFg==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119708"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:21 +0800
IronPort-SDR: /ABX/qDFVxlCMni84KRElqmr1k4epKUZEBNducG/8vVIMmQK7OtrgWcYs7/aYyE04OAHb1WsOC
 HOHaIbYnu8Kg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:22 -0800
IronPort-SDR: Yyz3ciS5HtupcSue501eCq/N1Cjm0ADI7qzpDnEYjjtfrq3OOQGmfEQCJ4SD9Ckm+8ncNwdzd9
 WeDs4Fl5ycMw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:20 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:13 -0800
Subject: [PATCH v4 1/8] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-1-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=705;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
 b=ShBBp7q1wx6Yv3TSVvXuYuqSsFe2aCIvsBOZm9OCHJmyuDWek2P9m4X94fDRxgxPeQ+mA/ty3
 pHTqjJ5hzudBCPheQ+ACsU4NkTNMmtxbj7tdX3lxuMpW0jPC21hC1Mk
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a new test group for testing the raid-stripe-tree feature of btrfs
with fstests.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index c3dcca375537..9c1624868518 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -94,6 +94,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
 qgroup			btrfs qgroup feature
 quota			filesystem usage quotas
 raid			btrfs RAID
+raid-stripe-tree	btrfs raid-stripe-tree feature
 read_repair		btrfs error correction on read failure
 realtime		XFS realtime volumes
 recoveryloop		crash recovery loops

-- 
2.43.0


