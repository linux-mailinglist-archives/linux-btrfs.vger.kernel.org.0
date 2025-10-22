Return-Path: <linux-btrfs+bounces-18161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE523BFB292
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBABD507FB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CAF3176F4;
	Wed, 22 Oct 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z5R833Ma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4456313298;
	Wed, 22 Oct 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125243; cv=none; b=VZkHXyumBsvldKwRODdveNGoPc9JZ/LR88vRKvBAaNDjf86SgrwSvDnqOjaG3pIKvgnFFXeIibZHadHXg/P/+sWfvbA/bpZWah5r1AiUdlYG/CWv4xi7VgYNO2V0WfPv5NssRwACoxVfDRl/rW2VYIXLjUIq+sHWSitfu9bSj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125243; c=relaxed/simple;
	bh=UBnelHARFm/Zy32AXrop4+jUmgR+kjoRVSPApWUV8eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4CYXQnh6nYpg81HRDxZ/KNsfI6DIow0WpMORMmUK2Gkuj/PA9S8rJ3E9apVSqUqCQNiw7MqfBiNe1z2SNlkjLkdHs2X9+zLfe0S/xpWYbBTvDbtFJmRe3ZN4lPfFzOJIJjoNSDkK5AZyDnmwTF597DWRSmAsC//lYOB7Gs5WiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z5R833Ma; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761125241; x=1792661241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBnelHARFm/Zy32AXrop4+jUmgR+kjoRVSPApWUV8eM=;
  b=Z5R833Ma2Q6rOA3Is65PC+bpSCKas59f4g4LKVQLf4T2jPeiAubRuHqv
   ZF96FqAtwVhrR1VDttIxzaPv6rZlqFm83UTQXvYPQh9iAcStJz4q3+loN
   0Veofc0OjVFTgGbr8qiHKVkb0Lz3yC17jSmjNi2LeoRmTqyDSxJl3XqSQ
   ZX4QEfrABqqfm3MwgFm6MXUdEPHBfEq5PMaq8LuKKEHdz3kARyDgrK2ZT
   sxTlTevVUuNweSAQpeLtA/MrPWEXsykOP5V/PQ8YaV+PMLRqFtXmcRCKO
   CTkxYKT2dNTMcT2eF8J2fJv0k7UN/uooc3pSDgGS1qXsJgK3KHpxAljbt
   g==;
X-CSE-ConnectionGUID: qbhQEhU8RxmT7XjD7eaUpw==
X-CSE-MsgGUID: qsituvK6SliG4OA1Lif5bA==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="133356604"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 17:27:20 +0800
IronPort-SDR: 68f8a378_8uMgnzfRJvZapQDySTYcT6gO4sHEYmhCut7Dx4zcPEzW0dc
 sQZRD/k5af0ufmnzeTygcOm/yrrk6f11H2ViMRQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:27:21 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 02:27:17 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 2/3] common/zoned: add helpers for creation and teardown of zloop devices
Date: Wed, 22 Oct 2025 11:27:06 +0200
Message-ID: <20251022092707.196710-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
for creating destroying and finding the next free zloop device.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..88b81de5 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,56 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+_find_next_zloop()
+{
+    local id=0
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
+        local zloop_base="/var/local/zloop"
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
+    echo "$zloop_args" > /dev/zloop-control || \
+        _fail "cannot create zloop device"
+
+    echo "/dev/zloop$id"
+}
+
+_destroy_zloop() {
+    local zloop="$1"
+
+    test -b "$zloop" || return
+    local id=$(echo $zloop | grep -oE '[0-9]+$')
+
+    echo "remove id=$id" > /dev/zloop-control
+}
-- 
2.51.0


