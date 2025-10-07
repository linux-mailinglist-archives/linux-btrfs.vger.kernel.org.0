Return-Path: <linux-btrfs+bounces-17515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A7BC16C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B646A19A2519
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD52E040B;
	Tue,  7 Oct 2025 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hCaz5jv5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603E2E03E4;
	Tue,  7 Oct 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841892; cv=none; b=TAxMbbTnDIbuNMQhJSrgbtzns+/QJsy88q2w31fyl2rCziSDdbIb3bs29YTjN61CPMC9yI51IT5nxqzbAh5wVgVCa8YcyFPrAykycELbjpQlKI13pzqjEeF5LfcoY/8w9A7Kycw8u2EhljWTDCVFKOr9l5/UWo/UJwBQNXN6Oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841892; c=relaxed/simple;
	bh=zBT+p1pZgQnKbUSpPje0CUADC62S0X968plno6pvvFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl/TIt07F8k7zB8j9RHUOaDtG+GEma53LNO9Y14wPbMELUahJ0VDhveZ9KCVAcdkB5w6FT5A0n7LJkcwiWQEUFAh/yHxSuJIMqXX2Ipj9QfjVVJtd8KskAz+FMegq208ae+T03hyqV3QUIVZvZCqgtVeRmltlLnUf0asyrH33mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hCaz5jv5; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759841890; x=1791377890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zBT+p1pZgQnKbUSpPje0CUADC62S0X968plno6pvvFU=;
  b=hCaz5jv5tsrKrVMZHsn0IMtfPWTf8rLJGe16mqJHOEHuxodPiwo9OYfL
   hYAYOamS7QmBq+89xiefJGkrmHwdYrAPA4uRe7pomVuCdPC3T35h4KDjW
   WraAaCNU1OCeUAanGDnBdTj5qiTm4BvnVZxpMyJqfBEtw/adqqc+/3z4n
   /fEyruC7N26nudVwIM8Z7NTvcLxJJYFp6y2zAJNIWTNmARcvUAkpmFhTb
   LpItwF3bhvE32JlWb5dDknO3CrtLPg4CBCeGNSy0e/0elkQL2Z9Z+oa90
   Zoh6CuEclahZqGQU8YFTL9ALC4qRAZ6pRPvaiwdTqrLGikQIzF8OnQIC9
   g==;
X-CSE-ConnectionGUID: 5tll4T1PRU6PuJ/r7hPhAA==
X-CSE-MsgGUID: 5RJ/9AYFSBqZKd3qFnjw5Q==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132746698"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:58:10 +0800
IronPort-SDR: 68e50e62_4AueIu0KqZfxz1az6b/tZtTTJVuYgtHlXIdIa3Zh5u7ALqu
 Kuo1WhN6SKOPkDMXR1Fp4uxxUSxRyQDLNqx+qbQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 05:58:11 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.183.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 05:58:08 -0700
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
Subject: [PATCH v2 1/3] common/zoned: add _require_zloop
Date: Tue,  7 Oct 2025 14:58:01 +0200
Message-ID: <20251007125803.55797-2-johannes.thumshirn@wdc.com>
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


