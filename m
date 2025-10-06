Return-Path: <linux-btrfs+bounces-17461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4276BBE2E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD834EBEA4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2DA2C3774;
	Mon,  6 Oct 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Shz7JLXU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE42D0C70;
	Mon,  6 Oct 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757181; cv=none; b=rkkLnTGRGscoP7vXhWOSmTfIEyhAogDsMI3QvRR4es8uZEiOS1dsv+l5wNHrSPEF1NpnZAHBu/450sdlY87PY7TWnxGVxixwU2UpKwpWlOEr+Beia7aBitfnWerc1La4SmEwPTFaA5gZgDCRRoagCUoBu7hNDxLx4l6aJxVfEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757181; c=relaxed/simple;
	bh=zBT+p1pZgQnKbUSpPje0CUADC62S0X968plno6pvvFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5qsI08vMB8tAAby9V4kmzGy3ENBeyg/63+RA0o0pSXgrpidk8B/rsgkKFRFtLpHVvREH6DaWBCvOATgpPkVfqw+wpp9NwLO7F8T/giRNQo0nkp/jMNowHhd0C9Ga/GYykT5kFHHYt11WxrWFc5XBJSIEzK1cl8Hvx7kx6kYCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Shz7JLXU; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759757180; x=1791293180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zBT+p1pZgQnKbUSpPje0CUADC62S0X968plno6pvvFU=;
  b=Shz7JLXUlkwQnV3NvbmLGfbu90GlbFt2wLBBjVYaZLBSpIuzjCa9rahB
   NZD76Efy/sbRzcnXnUUfs5/74UlWhpuyIyTcTgRTJ0aUWAHDBJqCRP7Hl
   jvB8q2n1HqbHDcqE+qiy2sPztWO9sBX/R3pZmYAs8nYSc43pHWFYxFtQY
   Z12hOC5jniGsgGm+ubP1ARI3e4Jkn4t2efZFeQ8MFIRRlnc6YlBP1YC7y
   5i+amFA2NYz3d9GxsgsVn/H1wMDYRmbaZF/8A7U2g3DISXeEZlCBEiB5F
   VTSJMddJ3LsJWvQODGIVpvE+51aNEPD3J1DIWQePVLKkcvc9Ot90Hj7zk
   A==;
X-CSE-ConnectionGUID: YzaQY4vFTjK4uaSX4JEhCw==
X-CSE-MsgGUID: kKtiDyBBTHijxtNTmBkoAA==
X-IronPort-AV: E=Sophos;i="6.18,319,1751212800"; 
   d="scan'208";a="133893171"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2025 21:25:03 +0800
IronPort-SDR: 68e3c32f_OHNIKMUPza0SFqbnQVgXSej2il8A8r6UCP6J5r9SUykGPLU
 2fvVG92w+dw1/dbLJ/ploxVEQgE5PRQEwv/3uQg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2025 06:25:03 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.183.246])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2025 06:25:01 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] common/zoned: add _require_zloop
Date: Mon,  6 Oct 2025 15:24:54 +0200
Message-ID: <20251006132455.140149-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _require_zloop() function used by tests that require support for the
zoned loopback block device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/zoned b/common/zoned
index eed0082a..41697b08 100644
--- a/common/zoned
+++ b/common/zoned
@@ -37,3 +37,11 @@ _zone_capacity() {
 	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
     echo $((size << 9))
 }
+
+_require_zloop()
+{
+    modprobe zloop >/dev/null 2>&1
+    if [ ! -c "/dev/zloop-control" ]; then
+	    _notrun "This test requires zoned loopback device support"
+    fi
+}
-- 
2.51.0


