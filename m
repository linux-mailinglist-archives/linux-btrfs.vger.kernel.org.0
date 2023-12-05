Return-Path: <linux-btrfs+bounces-630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC680550A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015BD2819BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012505E0AA;
	Tue,  5 Dec 2023 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JDAiRiga"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778F182;
	Tue,  5 Dec 2023 04:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780314; x=1733316314;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
  b=JDAiRigat1yeRiG5UADGXaQVxg+v1/X516z+eQhlO2doOzP5rtRhiGC7
   qrQ6XDSXQu0c1DxBlevFdwgk/t11/kvGXNmm1WwIKHbr1ceXsQMuB4FmM
   H9uS7EYcDMmm/jGy+96qVSM3t9JkmWHhtMDfqmDrkkB1XYfdxl+KX6tdt
   p8itqno62LIEUZXar1ZET/cqBdmbT0NHcX5Qyp0OW9RTBQ/YueHoaa+fK
   3/HVSAtEMYplQOmaBXtRdPitzhHNlJ9BrgFS24vH19uUazmezA4C8kPcG
   AqtLNerP9p1vQa52+uRtS1kqfEjRftqx8Ko0ngxj2Dyw4cFFcE9tnITh8
   A==;
X-CSE-ConnectionGUID: WONirUX2TkqgVzSxYIlbqQ==
X-CSE-MsgGUID: Y9SD2CFiTIqH1YS+mcASbQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043900"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:14 +0800
IronPort-SDR: hlHx45imY1XvsjuQkfuX37DRPDh7JlI5xR6GFVpvJtWkCINSpaR4NBalPgdg9MtXnddUxtRJx/
 w8MDoCxCWXTw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:16 -0800
IronPort-SDR: slw6nzBIrgX6LfaWZxF4WK7kfwUM3q8qNvVJhYSUVAJCl+tzmFbAvrqNERgXc8QH0CnLN922et
 7Mom5CouuCEw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:14 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 04:45:08 -0800
Subject: [PATCH v2 2/7] common: add filter for btrfs raid-stripe dump
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v2-2-25f80eea345b@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=1491;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
 b=VYEja1VcmxM92+/Ij8DR34Fgfz+1MTEV1MMQYWVQla4qf6RwEw2Gu9hjuTQzoxaBta8Wo1W9/
 2g8+avg02PHDI5LwkIm8r5sIy51Qk+NrFd+QLBiploXtMgTM/11ke7c
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


