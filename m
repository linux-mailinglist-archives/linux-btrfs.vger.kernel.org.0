Return-Path: <linux-btrfs+bounces-736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95258083BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B91284198
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8032C65;
	Thu,  7 Dec 2023 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DZ3T+Uz7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA819A;
	Thu,  7 Dec 2023 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939816; x=1733475816;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
  b=DZ3T+Uz7AvrswvH4vSpIrc0aqQVih5exmTiefTXx+5gv9qL/94yy89hI
   pesBSZGn/7twaw8A/R/toh2tuKrAAm/LmGt00VIq/qjqONhJIGYJo+5q2
   hFuFrwu2Smqr8hmY7ZNaWDoMi36x8ehPj7RCqshZIbscYMb3dvmTmzV7Q
   aIaTmgjJkuSNHQE9SHVUcLUkxNJqbjUrcJGbErEoBkAp3Tb1unR+Zd/Wn
   ug5GfAmurtrI8TGkuxp1nnjb5CJMv8nGUWP0hHCLt4yh3sB+JR9w082Kq
   9OpOTQrGSvRpIQF3R1zte+rW7sIji9opmNPftLUozdxMtVF4YZO1tV8xC
   Q==;
X-CSE-ConnectionGUID: RvBSzxVNS9OUfRF66t7BCg==
X-CSE-MsgGUID: EY2mzXmJRxiAP36T15T1aQ==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:35 +0800
IronPort-SDR: 6dw4cDUNbaJl3fx4MrkeOdZyg4EIz0IcufI6c/R9AySknN1b8scolw+Knq0r/wzyN4SbnSKGCz
 CIC6D/9t18cw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:35 -0800
IronPort-SDR: 8hgs9KZbW9q179/gmQ3R3ryc0jJjXW9Sqk83HCJEtOAp551oVF3fuvG5f2tp/aFOgfXGxkWTCg
 zonLRWXzaFRQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 07 Dec 2023 01:03:28 -0800
Subject: [PATCH v5 1/9] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-btrfs-raid-v5-1-44aa1affe856@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=705;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
 b=Vgk0HKTRPpi7DQFc9M++IYMrdQsI4Mh96CkeGohE06KT7/XgbXVTByjcUH9tcacjDQe0cclkh
 S3O9XSdCqx6DKD0387hLbM1ZruXqKd6Nio0SA3d5mEs474Aj0mP9OiA
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


