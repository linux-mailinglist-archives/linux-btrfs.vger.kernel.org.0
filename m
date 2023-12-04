Return-Path: <linux-btrfs+bounces-559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036B8034BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36B0B20C3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA625751;
	Mon,  4 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jteBBCUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2D35B6;
	Mon,  4 Dec 2023 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701696319; x=1733232319;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
  b=jteBBCUpo/tNEnNMO0PS8xi23CBh6wU3CQrDEgZH4yRj5TIj5PmgWnG0
   etqyp16YPMVHPHGoSG7euah2KNDiSS9cvKseAZzy3wX9DhnIf8VCcXZ3x
   oQbUk8ZOOgYpYCzLAmz3MpHfkL3mWL9FkD578u6cTp3i8p9dLpvHuJXN1
   /EVV4DPVeHV0m/dcglta+AzuHtme//QaK+cakn6B6FXoUrCRSlc2hU0l2
   IrQ66rOYSEHWlt2syKMZoPU1eUGmz3ckDczeXoPVpxNf2jMOspwnVIYxD
   H/xsK3nt2qdJn2kbnXNRtYKJtwSBWeCNKH7EE6//BkgQCT5+Qj+amwn2W
   w==;
X-CSE-ConnectionGUID: qdVcmyJLQsye99AlREJovg==
X-CSE-MsgGUID: 9BfX78tiTRu1/7wTGF+MFA==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="4141615"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 21:25:18 +0800
IronPort-SDR: 1rty2LbmL80pjgaNzr91kShOC2+nMS9z5Pv3HeB2k7rbrWDQyk2k34xg0EJOy5NvzbgVHsbjey
 4IkKS0DPNTrQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 04:30:41 -0800
IronPort-SDR: vbppo8dpg3t/8RKwne5JR0TMid1XwRJZidvPj6V9QtG8v3rwYyyI+bHaaxk7Hd6qICfW3GgcB0
 CIL/LNZQseeA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2023 05:25:18 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 04 Dec 2023 05:25:10 -0800
Subject: [PATCH 7/7] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-btrfs-raid-v1-7-b254eb1bcff8@wdc.com>
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
In-Reply-To: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701696311; l=705;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
 b=WLJZYxUAvnUaR+04bV5daOaxqgNFd23RJlHvFeFr8IZcoeqT/I+kCbXAQYdyOBAOlKgIiCm8B
 RCFUc/VGjZpBgkck+sRvxoM/l65XvP7z44tDLyi+/7Uu3Azdiurb2XK
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


