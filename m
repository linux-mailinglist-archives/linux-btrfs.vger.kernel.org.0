Return-Path: <linux-btrfs+bounces-563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C18034C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 14:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ADD281081
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A4250FD;
	Mon,  4 Dec 2023 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PdKSxena"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436221BD3;
	Mon,  4 Dec 2023 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701696363; x=1733232363;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
  b=PdKSxena9VF4a0IVe0N3XOGlUyvHKNPQqGTCngxpMVgesPjcjuermx+H
   GpxJ6r95NJ3PWc7WbfNPle6gs97TtohLB7s1lm67uXJPAI+lnW+VPZtWY
   tGvxuPzR2vD3QxAZlkYGDUeBGNip28V55Mz/RrePKn7RpbbOgm5FJ40+S
   pgN78tztgtTMzjYfC+4/Np5i+11D1cNr85XnfFIopmO3GebwWEG/nnt9K
   XvycGki+A1B3UdwUEk54OSSZi4kTXxzbwEAZdAfCQREzENgRc3CjhYOhd
   /yCNha56zbkT0Q3CtpA1vizlxnxb3D58yKN1N0KKZSWJwSKOitTH8EJZs
   A==;
X-CSE-ConnectionGUID: i6JTjpMCRcWeMM/ZN5ZMRg==
X-CSE-MsgGUID: FBmLLc5PRQymz+hyTuSoQA==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="3929134"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 21:25:19 +0800
IronPort-SDR: SlbzCfDgY6rqJF47o4f2h2b5lUJbI/2u43W5X2E+a17ABxi5u42msF2XC0foXCOlCNbLJ+GcPy
 02DtHEcpZXDQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 04:36:22 -0800
IronPort-SDR: J8BjInL79iaOnoc38YL82nOnQ8UhWuBTBiwW9DPApqst4JwI00/8TDnwmc9vtc8SnMymKL+6TK
 Zn6u+voJUf6A==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2023 05:25:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 04 Dec 2023 05:25:09 -0800
Subject: [PATCH 6/7] common: add filter for btrfs raid-stripe dump
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-btrfs-raid-v1-6-b254eb1bcff8@wdc.com>
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
In-Reply-To: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701696311; l=1491;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
 b=Zk65r4w5MZcoUK9r5+7MvpnuHn9bYAWbImFlEfU7zYEzSNK3VDlgywPPDAXNjrdszkbWYyqYU
 A7O3Y9pg13IBbxtXeWA7zZ8bkei0nmZmoc7Und6fBHNZKBamzk/x5UF
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/filter.btrfs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 02c6b92dfa94..2003ba7b7015 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -125,5 +125,19 @@ _filter_btrfs_cloner_error()
 	sed -e "s/\(clone failed:\) Operation not supported/\1 Invalid argument/g"
 }
 
+# filter output of "btrfs inspect-internal dump-tree -t raid-stripe"
+_filter_stripe_tree()
+{
+	sed -E -e "s/leaf [0-9]+ items [0-9]+ free space [0-9]+ generation [0-9]+ owner RAID_STRIPE_TREE/leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE/" \
+		-e "s/leaf [0-9]+ flags 0x1\(WRITTEN\) backref revision 1/leaf XXXXXXXXX flags 0x1\(WRITTEN\) backref revision 1/" \
+		-e "s/checksum stored [0-9a-f]+/checksum stored <CHECKSUM>/"  \
+		-e "s/checksum calced [0-9a-f]+/checksum calced <CHECKSUM>/"  \
+		-e "s/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/<UUID>/" \
+		-e "s/item ([0-9]+) key \([0-9]+ RAID_STRIPE ([0-9]+)\) itemoff [0-9]+ itemsize ([0-9]+)/item \1 key \(XXXXXX RAID_STRIPE \2\) itemoff XXXXX itemsize \3/" \
+		-e "s/stripe ([0-9]+) devid ([0-9]+) physical [0-9]+/stripe \1 devid \2 physical XXXXXXXXX/" \
+		-e "s/total bytes [0-9]+/total bytes XXXXXXXX/" \
+		-e "s/bytes used [0-9]+/bytes used XXXXXX/"
+}
+
 # make sure this script returns success
 /bin/true

-- 
2.43.0


