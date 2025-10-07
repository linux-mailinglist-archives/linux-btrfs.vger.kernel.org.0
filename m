Return-Path: <linux-btrfs+bounces-17516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7AEBC16D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793E919A2452
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51B2E06EF;
	Tue,  7 Oct 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aLninJH/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13642E0413;
	Tue,  7 Oct 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841895; cv=none; b=JAxymVcMUlBRhLxJOTQTGBP4aQqF0+BDeix7n8CXbgNjODC31jV0wtnPkKTD6hYVPAUVBmT9xphGxvIvswQ5KYuAz9ME3aDGcfDyM9SpF2lIuyTGlykHEpgqmL1grc1oeFJR8VXC1o3tORjaKOllziLecPidcXRDTxcGwzE1jSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841895; c=relaxed/simple;
	bh=8Zfy7qLX20/mgSXxIbg34JfC5/In4E67PrS/vwwnLHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhcDfZrVyNK/vgCpBmhS26jCog36b7x9DgUFhVNH432Tg0lp/hEiOigMe9wxWh/bCCMxxpOHqjUMutXiFtmSXLszW0Ej9iv6AJc1wrzY1ND5u/AsIo2vBj3kcsuvLahMUQOYeSVHRaaxOFkRzW/0rAN8QuvpQBdQ9y5xrvJFpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aLninJH/; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759841893; x=1791377893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Zfy7qLX20/mgSXxIbg34JfC5/In4E67PrS/vwwnLHw=;
  b=aLninJH/MOWDxIGEMnebOAiFDKLoylnnxSVpz55nn3K8I7aWT4KO8a70
   mPg3q8nKJatm3N15iA7TKBRZ0JUX3Tg9laXyqOqTC3Ua7TdYiHpwDisuY
   b0Qortq3frJlDhcl854bXdVJ2Li8yC0aGGFbX6wEBBZuKU5j1ePhyiAql
   8aUoG5oGjfFXj38kZQE+rqD4beFhIO0Ps3ZRl9DzKTDVrSNSUeskL1CgY
   Aws1NBwJzgLw+dbE0DHLIBNgJAFo1vBKaVda48llE/4TDSk/NzTnhJclJ
   cJPLNP36GEhhLrCS/3xL4RcG0fesi0jZ6gpd3PcLtfgcqd88sQXeNKWxI
   w==;
X-CSE-ConnectionGUID: IIi/kPnWTBufS4+mpMZzjw==
X-CSE-MsgGUID: +iGpJGXNS2WghGtgZe2cRA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132746702"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:58:13 +0800
IronPort-SDR: 68e50e65_rVwj+SbHJ38UrfcGQKBwDzJ/cFzQrtS4HX031yWqFi1BhBB
 TAYT/zZW/2ilO1/Iyf3CnmCOnSO3RHlRKrFnq6Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 05:58:13 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.183.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 05:58:11 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/3] common/zoned: add _create_zloop
Date: Tue,  7 Oct 2025 14:58:02 +0200
Message-ID: <20251007125803.55797-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _create_zloop a helper function for creating a zloop device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..33d3543b 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,26 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+# Create a zloop device
+# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
+_create_zloop()
+{
+    local id=$1
+
+    if [ -n "$2" ]; then
+        local base_dir=",base_dir=$2"
+    fi
+
+    if [ -n "$3" ]; then
+        local zone_size=",zone_size_mb=$3"
+    fi
+
+    if [ -n "$4" ]; then
+        local conv_zones=",conv_zones=$4"
+    fi
+
+    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
+
+    echo "$zloop_args" > /dev/zloop-control
+}
-- 
2.51.0


