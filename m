Return-Path: <linux-btrfs+bounces-915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03432811039
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360C71C20A9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37324A1B;
	Wed, 13 Dec 2023 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YEB0Muz0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548310F;
	Wed, 13 Dec 2023 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467340; x=1734003340;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v5k4+1h53SpXphnL69HSsqydNWptq57JFBS9641GEd4=;
  b=YEB0Muz0tLa5aoZoDalqouFRBdxeSi2kIKmDmqEi++aNumc9FgXxVArS
   HBGNROKOCHJ7f5xlw0R7Mx2HAlVcSldYUlFmvE0KvTLMUBlMwbCooF1T0
   IOQScbGikbJic42g5xi4gv/j8PId4XMKLizscK4Y/5p+OfDxgGU300mQ/
   oRz82wVAI3aRCOo8H6HVWAfQTED08cRgvBn2ugr++uOMrAdlC4YuNSAFE
   u2fYlQAx5/smKsyJcYlTlrKi45dhklOTAxUw1Zo0gUiizzmO71MBKy4Kk
   /lkC8gCFs0IBltwcDazjhHRa9JJ9VHLeFCbMrkEus5Mi6n1pow5dCGjWU
   Q==;
X-CSE-ConnectionGUID: 6dVjPDyJTx+TTvZ2hVxHdg==
X-CSE-MsgGUID: 8kPpatZoSUK6Cpo0PMcuUw==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718831"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:27 +0800
IronPort-SDR: AfpuSi8y1ZfuHilru19ltnfB9AZaCb/d3Rt0PmscTHGK/BXHRXkfy9t3s7UdywNFrukCo6DVLe
 5XyaAv6nV4Vw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:39 -0800
IronPort-SDR: 48ecPNzRiLoC6w/KrwvcY+KJsxN8y7SB+pRlZOYugheS04SMuynd1I3zWmhH6I63s+sdHLheYg
 aKFMhE02XJUA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:28 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:24 -0800
Subject: [PATCH v6 3/9] common: add _require_btrfs_no_nodatacow helper
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-3-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=638;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=v5k4+1h53SpXphnL69HSsqydNWptq57JFBS9641GEd4=;
 b=EZYgI+sfJbYgxvuPmcX/VRcR+CrDDeJfhnoFKNNHUqnnrXQVSFwihtQUTK9khyAsGx/Sp1s9s
 0N7T3B+wInSAELZk0NYq6mLoV9UgwPIL+q4uOeeVL+AbZtQdwLYeF6e
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 36f9b94b02c5..a80ff0264c6a 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -120,6 +120,13 @@ _require_btrfs_no_compress()
 	fi
 }
 
+_require_btrfs_no_nodatacow()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+		_notrun "This test requires no nodatacow enabled"
+	fi
+}
+
 _require_btrfs_no_block_group_tree()
 {
 	_scratch_mkfs > /dev/null 2>&1

-- 
2.43.0


