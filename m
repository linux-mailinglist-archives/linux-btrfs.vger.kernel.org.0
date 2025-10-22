Return-Path: <linux-btrfs+bounces-18160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646BBFB283
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3751A04EBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBDC315D41;
	Wed, 22 Oct 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pFD21Rms"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035C274659;
	Wed, 22 Oct 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125242; cv=none; b=uGAWaGzHj54aouHB52CLNsMppfKW/9wD7Lo9Ym/unHeQKBhvTmtmxVRbP3mYyBfkqhjKzehkj2X0ysH0ApJs4c/g7XCR1HvJjpwDXbwNcXlhLPA5fnwa/jpQg+rLvlmn4KaOgYUxNuIvYEXzhMym+7v2lPMt/0p+o6CPlOvrvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125242; c=relaxed/simple;
	bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igEfNinMRF6xT8zIcMlcio4s98ql4whds50UvujXNKp/OkLX3hRUhd02X0IgeaV1WF7f8vJ+72PNZ0W7hLr5SmJ/vmscdcBZj75n4cFldZpNVqNjDpafaxQEystjZpDqDf80lFx0xHGQ3RP67ud9ygCinpAMBx445AkYkCme2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pFD21Rms; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761125241; x=1792661241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
  b=pFD21RmsPFi1aQyZzB5MNkEsLUD+z7zd7X42josCYwJVcSQWqUsnaz7E
   Tl0dMCdJhSqI1uW1T6V20obOooKjzG6S5WkIxggvRiGlxNCfa0RDyqiKa
   HL6V7PjFLBMrX0VZDjY2B2kTa7snedErlyh4ZjDke7BdNFF7SpfbtLbhe
   U0Pt8o4LEFXBYJg3JV3sBoQb7c18+9tnqlPwOCBpWCymvXUVppgsLhdij
   F81dWu2MPpH15po8XF9CWXGDXoy5q8r2F5q8FoV3xjssNeTZisyRvm231
   UGCiuuoJhuUq56Khowa5EILtqsajLTG77Pi/9KOJmiEQRRG7X+vlEOEA+
   A==;
X-CSE-ConnectionGUID: FcSlGxaxRFKxYUxp1pCV4A==
X-CSE-MsgGUID: 1ZyPvGvwTUe67pkaxjb+aw==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="133356603"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 17:27:16 +0800
IronPort-SDR: 68f8a374_r9ZhsB0KqiQbbRiEH0RqLlICVcoY6a8AfH3eOsqXRwobcCF
 N0Cl+rSjZIu3xV0ohD5YkR4JpmhQiaJLVesK1Kw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:27:17 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 02:27:13 -0700
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v7 1/3] common/zoned: add _require_zloop
Date: Wed, 22 Oct 2025 11:27:05 +0200
Message-ID: <20251022092707.196710-2-johannes.thumshirn@wdc.com>
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

Add _require_zloop() function used by tests that require support for the
zoned loopback block device.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


