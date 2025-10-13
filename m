Return-Path: <linux-btrfs+bounces-17676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24520BD1ED7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5034A3C15E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C22EC558;
	Mon, 13 Oct 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VlF4LEMl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C921FF46;
	Mon, 13 Oct 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342894; cv=none; b=MT1E9Z5MEAOskBz5ifzJ/BPpQRM6LGWxaQN4Rq/Sjqz85t0CXCh5MkaVthxkbgMraCGwsKIKCAZrmX/U8osj7qF/KixSYQsi3UymX3nNt4rW+6RB0lGYpItxk8y+ojDtxzOO2PVnVuELivvyGck3nGh/9TDfc7VjjpuA1pivVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342894; c=relaxed/simple;
	bh=8HiiWkeOKGje7STS8RFKwnMfazeDMfjImyGX8/8PG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q71vT9r6m3b9kmVxe5srM/YA3MT1qyiL7G4OwgaFZsxaCD7U6pfJi4yHKl4XbZq87Z0GgTx+L6DYLFtgdnWTJjeryE8bqoT/Ag0qrDvTvMIMpKS5XpJ2grYqPtsK/Plt7mnoExEAzCOIXJ2vxWw7WZ/L1Us63ZDD+k8Z/98ks8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VlF4LEMl; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760342892; x=1791878892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8HiiWkeOKGje7STS8RFKwnMfazeDMfjImyGX8/8PG18=;
  b=VlF4LEMlOpi7Iat1t7uTsaE7OSf7SDHrA1venl9Oi7WF9RoIgnUNtU3p
   37ZmstiR/Doo0DtBo5FEAnPDfD5zOpt1FaQTpcpFBFBR3XkqR9OIR2Y+O
   RXrSqYuzn0Ap72Nm0dr1PbXvzohtamHHQphgwGK1zvmDTzpFH8tWegssr
   k1ORSCUMvb8HZxPalA5XQt2mBD0LPp6LVVi3Mm1VK1BAZSmBjG7Qjz1S3
   yB5UC7mg6rk6sEr0JONUBqLeT481lUDhytGMkuNGENW/LfhseIymvCoPW
   kF7xc4kAUrFAM+VFjm85xayuK+f4Er8v/CvqEpGPc//eDvCJXjHJz5yML
   A==;
X-CSE-ConnectionGUID: nZxIiBR/T6e22kpjqL3gKw==
X-CSE-MsgGUID: tH4DVV+RRMe31oiuDWPmHA==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="133101996"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:08:10 +0800
IronPort-SDR: 68ecb36a_VJSUWIImlsbj4kF7WfH/GBQ99NY55Hdj+lKwVYzTe/x9Nfr
 BFA3+kt8AKE+p1O6G+xpJBfgWKTHE7DNhxkFYbA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2025 01:08:10 -0700
WDCIronportException: Internal
Received: from chnhcln-775.ad.shared (HELO neo.fritz.box) ([10.224.28.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2025 01:08:07 -0700
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v3 1/3] common/zoned: add _require_zloop
Date: Mon, 13 Oct 2025 10:07:57 +0200
Message-ID: <20251013080759.295348-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
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


