Return-Path: <linux-btrfs+bounces-703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B8806CBF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCBB20E7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19E3066F;
	Wed,  6 Dec 2023 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IRclsvao"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED112F;
	Wed,  6 Dec 2023 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860184; x=1733396184;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
  b=IRclsvaoX4JdbAoybz/tmEkDqDsYhucp38aqMaiBAt16+w7nujSeIKy8
   OXA2F6G5Psi83/pkNRb30GpzAGfXjeDY25fW3GIxg40QudYxLY+b0ILIJ
   363C68DF7zwO+juVqUpqOpQ6IOrzgtPy2Q2EdCG/PorEtEVomYM5JG619
   Nti7tfG2mXtjsCl9ikdqibXA88e8hufkEoWWfJ7MxkFYvot6hieUzkuW/
   rtnnhWFoI5a1WeWigoMmmLLPkQTt2sZI3NvRgBZMdp+i8ikKGBc4NhIbA
   k7c0pss8M3sCAq/ZQFNoLTLGFWQV7uN5wjuN0D9wV9ViTTwLDLXNppnmS
   Q==;
X-CSE-ConnectionGUID: UGNI61dSQoyPSzWaeTcbUg==
X-CSE-MsgGUID: c37RQ+fBQVu9Uc8imsj7kw==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119710"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:22 +0800
IronPort-SDR: CohK/yZiTC8wnkMRgJ6USM20JiOoraS1ssYffdFXYRHF5biD0NTtyKyeaoGOI0YYd6oY5EGjMg
 fL3nr/2PZ5JA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:23 -0800
IronPort-SDR: LLeAVrIwfnLF/J57iS0/ZjwUxgMS7dZ7Ic7RxEtSHCSfR2/kfGeS7dOJjvOT0IsBcbPoKxobQc
 lDb8fmKXGF0A==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:14 -0800
Subject: [PATCH v4 2/8] common: add filter for btrfs raid-stripe dump
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-2-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=1491;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0vFVxyKpqAp7DKayL6Ik1UXOmUX6REN6nOAs9orTBSo=;
 b=RfMt0ZfSDNgfKfmKjgbvjBfiiT1oguUJps40zXZIOcihp25eRzJK+KNAxBP7YJf2zOLgrQMrP
 9ofmHbDQ1J1A1gMpO6rvy2kBNlN+7/9YXRYHeDJjk/A9NYe7ZfwTMoF
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


