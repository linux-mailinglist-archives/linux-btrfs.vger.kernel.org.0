Return-Path: <linux-btrfs+bounces-660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E829805B4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0261C21088
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB50675B2;
	Tue,  5 Dec 2023 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aMlShtK6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A318D;
	Tue,  5 Dec 2023 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798427; x=1733334427;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
  b=aMlShtK6if3ijreij7xCKua+6vhxhfVo0PSW1t7AIPQXBSjHpfQ/s6r2
   41ifJ+nn8qw0KKRgwum26lZXuMf88SEXWS+tbvk3rU59cX5QoEiAOXUdm
   s2TuaAEpBZkUXU3bRzPXZzyTyOG2Rmj2ua5rF+/Y7SKx3tuPZGi2+sBX2
   BtYGWmEOLZSjPRzp/zweiKZn08SAFsG9RerythiJOEjyNxRrM8CEAF9Au
   2zBlE2HzoP21dmWNLpD3NoC/59/RuHxRwXiay/l+KAxqpsb/n+LUanM8l
   TFgdz+QX9m6n/+c36ZYK/0OQ/F6nUXZu6ObdZR2NFewUlD9ETE2iY0MST
   w==;
X-CSE-ConnectionGUID: z0DAkijnRXWAe+vedJ2nYQ==
X-CSE-MsgGUID: 0wRV5txVTq62qcuhLa5+RQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944954"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:06 +0800
IronPort-SDR: AJypIuObM0/1S9Zf2x3Vn2Jo5J7VgsFUWp+ey36HjdIvpXIzO/Q42naXBV5o6S1P25CBYb9+gF
 FvrRaw52/29w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:27 -0800
IronPort-SDR: 7Wa70RChXDSa7JQ9fxwtNePvxkDHB9RX/1XVfTyz+iMgMamiuXgPaxqZM5aql+l5C/GG7WL03/
 JP+xxsuYE2Ug==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:06 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 09:47:02 -0800
Subject: [PATCH v3 2/7] common: add filter for btrfs raid-stripe dump
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v3-2-0e857a5439a2@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=1491;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
 b=lL6AwdIzdDtveXDi9fYNMdOoukqqYhHlgpOEMKxXXvp7ZSxg7g6NMT+5ElVDw+4+nnNlviGzx
 r2bos5fiPWyDWbUOB636csHSpXqs85Vv0eR4xwcJBSz/FIoIzTBh8cE
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


