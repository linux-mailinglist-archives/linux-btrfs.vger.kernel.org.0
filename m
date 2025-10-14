Return-Path: <linux-btrfs+bounces-17769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F4BD8419
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9814F4250F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD112DF146;
	Tue, 14 Oct 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CxjaOifE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B523F412;
	Tue, 14 Oct 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431601; cv=none; b=A84TJaRYEYqhMC3YF6FDcX2yspj1SYYlArVPXB2ka1v7mkDLCVsAQq9KfCjowyqjYsRrqzce7sIxRUHtHDAcVcF52mE8akE9YIwDcIvT+YZlgcYZ0G47YwHjDt21nxGDquPrRmwxz9fCbEXHxT6b99oteM4C7hAfhBlU0NkTjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431601; c=relaxed/simple;
	bh=2l04QcBFdaE8b7fpX6k+3XKl8r2SRCTm8rSebiiws24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1ZmUbZt8STPTQzB90Ljo7tyv1BTiCk9i6VvPmiBTQA5t5U8r2KjfvFVE3IfK+4risl2uBuOoYiQANwrlX87fy2QI+FxTz48IR63SIigL9WzQei/Ils5xTU30gR6t8HhrvrImR7rQVErsQmIrU4DsuPsqeGLOky/ZBEaHKiTI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CxjaOifE; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760431600; x=1791967600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2l04QcBFdaE8b7fpX6k+3XKl8r2SRCTm8rSebiiws24=;
  b=CxjaOifESnrnDCefa+NiLQWYFWkRQCiQCa8OBTFQr6bJgJ+jEOufnqM/
   +zJk2zzOQuBGN0xRrezzuyZRckU/Bc5Z39oWj7LvRaHBYu+bTxmmBk6To
   0u6Dfn6QwO7PWojTotdVg/KCE1qXn6ab6WBxb/BTCwi/2NqjfYNqZW0Yf
   wyqtAVvCgxc4ZBvvu21cP5Jt37tY82ysCxfMoFwtQz+ppycrSwNmB/2Lx
   DjKbgWTHMNPrGcTykE1G3d5RKB/Qjrl5l9OxW7qYEo/wBhsg9xtqgrK1X
   2unQnzts+QDapNw0Dt0chdM9QIgxDry2aSXSL3fk6Sl5iMIjvzmxv6fUb
   w==;
X-CSE-ConnectionGUID: Jb1uOuNERJqDZMffNhTWDg==
X-CSE-MsgGUID: GzTdqaIPSjW5pgU03XqIIg==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="130180117"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 16:46:38 +0800
IronPort-SDR: 68ee0dee_rJOJaIQZ/iNcfmBa07EPpkGQ3tzyi6kr6GBkszuaB06Rz/P
 E/Q//9Rm0DkuudxzkhgM/q4kOuLk0UzWwr1QNOw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 01:46:38 -0700
WDCIronportException: Internal
Received: from wdap-pnj1f24hc3.ad.shared (HELO neo.fritz.box) ([10.224.28.28])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2025 01:46:36 -0700
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
Subject: [PATCH v4 2/3] common/zoned: add _create_zloop
Date: Tue, 14 Oct 2025 10:46:24 +0200
Message-ID: <20251014084625.422974-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
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
 common/zoned | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..55acf120 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,38 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+_find_next_zloop()
+{
+    local last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
+    echo $last_id
+}
+
+# Create a zloop device
+# useage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
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
-- 
2.51.0


