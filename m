Return-Path: <linux-btrfs+bounces-913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86F811037
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D72822B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686024A01;
	Wed, 13 Dec 2023 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZTqs4Qyf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A71710;
	Wed, 13 Dec 2023 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467326; x=1734003326;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dTwUgOv/JrakUFKeSHVnjuhZOXq56pcOwJzXwvjhAwM=;
  b=ZTqs4QyfrmU+1amQLri7qLXG4PvAFJCbhKCdZej2pRHtqWiEkgha04zR
   ki+gp9m50ToNlmc7N0ALCDy02pCJ3XcwyePEdNwcB3Tu8tKANsHOeN7L9
   /nFtPTL/BzBM8OrNeIWdUEiMPFO9PLFMwKJGin1l64pDfz2Lg4FW6D0s8
   Kw3lAzwNNZPTuWlxJLTU8Nlr5+FawbxaV6h3FYyJX8IvcBbhyAx8egB0T
   vM7LTblTUrPCZUYFo5Wp41iNjOjOrnJ05TrP8Ao76JrHmNKS0m7WdBtnG
   Mm45b+sc5f/4Fa2XnTYDTkFGr0+7R5CUdG37OmUAaR65Hjc5P+cwdUrs5
   w==;
X-CSE-ConnectionGUID: FKr90zZvQsiAaLtKdzCrPA==
X-CSE-MsgGUID: ElOa5TTvRO2w0jg6GF3Kgg==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718828"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:25 +0800
IronPort-SDR: +bLEK0OlSJwr4bfvb5kRjVM0rokMVguEpRhIggt6hp8aBh1ugk/hXKfOlUHdTM6PrFkr3tV84z
 uU219zdEulKw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:37 -0800
IronPort-SDR: DH8lDxRUOhIusB3JYbYaBNgQL/Mi91yxPspjFi+O5hyYTtuCio8a0XSeLDyLmI1ydY0AjvEf5E
 YPQTYVZpjXlA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:26 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:22 -0800
Subject: [PATCH v6 1/9] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-1-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=753;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=dTwUgOv/JrakUFKeSHVnjuhZOXq56pcOwJzXwvjhAwM=;
 b=kKqSKZzrrJt1QRcxEku85ge+qTprewomoo2Jrc+GvllS01PDjxD+1zOgm8s9a6ab0gCl4dSMp
 g4euPeOfbuRCYzhqTxl8xgFMcPnh7B6bnLVzGLAalWDVHXgBRV8KNC2
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a new test group for testing the raid-stripe-tree feature of btrfs
with fstests.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index fec6bf71abcb..2ac95ac83a79 100644
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


