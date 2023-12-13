Return-Path: <linux-btrfs+bounces-914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD56811038
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE8B21026
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2F24A06;
	Wed, 13 Dec 2023 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NvB+VEaq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766401715;
	Wed, 13 Dec 2023 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467327; x=1734003327;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5iZA9SkIO5wyZ+2Fn6Ju/riFtUFCqKW90ZWUZWCI4E0=;
  b=NvB+VEaq25R2AKxAW8gItp8zgmPbBLH53ITEOuLVqJoMKkALObMCqGKC
   G4mweHczsuvvHo06zjk3IAQpAlEskTIY5sTJVjHcBMK2+FrpT95Yi/aFC
   PpDqr3ZJGm3tmGBWdlAeTIgSzyWB5IaVZBaO9u/0ECDDmTgDkJm+leefo
   Wz2GvXeCoDP3nsY14fPMtwIsLQE7FFvfyAVd/1YHUXnTAaS6O1t168Ecg
   Wzopgj3CUJJ/j1qwJqirgfO5LEfk5ry0PR8IxwY4IvklPBRHTYDk+1Pd1
   XWv57z7Ss/twbQzMVn355mgYbWMOfGbbQyzifRG3KYgpELjwNz8Fc74k2
   g==;
X-CSE-ConnectionGUID: JMPt+RazR5iSJv6TZiT95A==
X-CSE-MsgGUID: RnhMLba/REuIjmfGpTx7vQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718830"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:26 +0800
IronPort-SDR: ylthAfIruGxnKzuEhSijATll9urUif876uX/IIcipGvyk65OJkeOQIhimD7hdv9qTAB4ywwckt
 SqtWIzR+nWfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:38 -0800
IronPort-SDR: wsrp3X1qO4iiKJH4UP7TS6N6Fc8YVsGXEf9iW2Fmp8dNnM0xeOWturM5UBqyMRCSFrFQDgxpgm
 CZkAoWRpivFQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:23 -0800
Subject: [PATCH v6 2/9] common: add filter for btrfs raid-stripe dump
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-2-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=1539;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=5iZA9SkIO5wyZ+2Fn6Ju/riFtUFCqKW90ZWUZWCI4E0=;
 b=kPERd2MkTh471A0ti/duDAVL98vy1Bpteo9ATJlw3qYeR4/MMs+ycW0MdM+af3mOSabDQDwRj
 KRq8v3AyqsqDAG/HiymnZOmv3U/5wQZzK99lLAhkyQtQFAsyFuxkW6o
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


