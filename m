Return-Path: <linux-btrfs+bounces-17892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F691BE4334
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195B6508726
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC434F487;
	Thu, 16 Oct 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dSVZnS/8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6134DCEC;
	Thu, 16 Oct 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628049; cv=none; b=t5fOJ55IZpVqWWvkAIrWEptFYI1vFx4+HOVUR5Du320vny6rWioW/Mx2UKnBqS7z7SslXDJU+8dXtSQTw0/3PO13o4/NG96/dOxfkrQS1Ms4GUnXC+tD2ADXEolHyPTtxb7cXJlcNlo7Q1fllmKKIyoBP6eBdULTjtlnrOYIr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628049; c=relaxed/simple;
	bh=q1thB2V2eSKgJv4bt90yU/LR5kYd5/YEGidHiKuJAjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsdVuiYP06WJRSIz8GImnBAFYeH2TR6framTH0z5ksSaLz6JrAu0u7Mk8FcCtuG2EjNuoqIXEe30QvDagYswIj+bzfV+DGiAbfLdfjXYCvh7VCUfgLUx8hwFyUz10y/j37rZ4XB+r1ZDZOSUmx8re3kTvtqn9lFWDuU8z20XdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dSVZnS/8; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760628048; x=1792164048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1thB2V2eSKgJv4bt90yU/LR5kYd5/YEGidHiKuJAjw=;
  b=dSVZnS/8MU7c1hbavvs9BWDGsdZ3YIx64UNAYPdVZn07ncAwAWrEc+BV
   YOyxNppVmDO4dLt2pKbeJCaINvdEeidrBkTo/+5jWTXT43e7M1sCLdcs7
   8x7TkOj8v/22m6KfBBPAnc6xVfEmT9mQODat4l7E6v2t6euiPIKh91UOZ
   MN29p0YpgsWROXEirmLjdAej5aHw0Shghlv5hZslOSAgs7TeH1SkImUtb
   fAmwmgh8KQRoNw0RZVY6BeqgupgEs9SqwlQ6pO6TSojJ9qbS5h2+m2a9Y
   E5TPrIjqcyreutczWA3vy9Zqu4Vx77tR05ZO8E/V5Kro5O5qMnbQwDqm3
   g==;
X-CSE-ConnectionGUID: 6q2iJWnZQziXG60DE2KXfw==
X-CSE-MsgGUID: FVG62KZYT0G4K7sXOjFWSA==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134589304"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:20:47 +0800
IronPort-SDR: 68f10d4f_WFpfgqgxNDzKV4ZWBW1STeiJH+xcqMt1jiZj/XARw+zm+1V
 zLPsLhRbVC0EC49Lq3M77Z//nH/MJAkkOhZNa+A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 08:20:48 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.40])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 08:20:44 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 2/3] common/zoned: add helpers for creation and teardown of zloop devices
Date: Thu, 16 Oct 2025 17:20:31 +0200
Message-ID: <20251016152032.654284-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
for creating destroying and finding the next free zloop device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..313e755e 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,55 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+_find_next_zloop()
+{
+    id=0
+
+    while true; do
+        if [[ ! -b "/dev/zloop$id" ]]; then
+            break
+        fi
+        id=$((id + 1))
+    done
+
+    echo "$id"
+}
+
+# Create a zloop device
+# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
+_create_zloop()
+{
+    local id="$(_find_next_zloop)"
+
+    if [ -n "$1" ]; then
+        local zloop_base="$1"
+    else
+	local zloop_base="/var/local/zloop"
+    fi
+
+    if [ -n "$2" ]; then
+        local zone_size=",zone_size_mb=$2"
+    fi
+
+    if [ -n "$3" ]; then
+        local conv_zones=",conv_zones=$3"
+    fi
+
+    mkdir -p "$zloop_base/$id"
+
+    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"
+
+    echo "$zloop_args" > /dev/zloop-control
+
+    echo "/dev/zloop$id"
+}
+
+_destroy_zloop() {
+	local zloop="$1"
+
+	test -b "$zloop" || return
+	local id=$(echo $zloop | grep -oE '[0-9]+$')
+
+	echo "remove id=$id" > /dev/zloop-control
+}
-- 
2.51.0


