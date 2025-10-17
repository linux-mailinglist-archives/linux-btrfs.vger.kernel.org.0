Return-Path: <linux-btrfs+bounces-17916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50709BE67AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 07:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A21A64E3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 05:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB030F538;
	Fri, 17 Oct 2025 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DRwfdCJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7B211A05;
	Fri, 17 Oct 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680220; cv=none; b=VQW1b781QiH44VPdisFTmP+Ad1bJhfZ5xJBKu2U53vl8kSoopEWgQU6PRdn33xqml5ADXTfxGktMcJDJ5r+ak6yKyvUdL97XN70eaam3dtn9TfWnzGnMh2ZNdPTzeXQGvk3hcYJTzl+tdbr2e5A26LR87UMEsz8AaqmK/JNKoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680220; c=relaxed/simple;
	bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krHDNGWHwbHeaSul9yYY8T716OnMR8ZO7pxVF1IixQBRaQTBbv/dA0Tw8+XEdhZ3+IA4kmZHszPyoTFzVSAvvOIOw5pzQCMWrDC2CmbrgGPJsawAEJ9tXOp8mPPlAO5dsNnrCuA1EdKW7ta18Dp9xS3F/euSbhUn+LdFTPpO7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DRwfdCJS; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760680219; x=1792216219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
  b=DRwfdCJSTCiPD4IWTyOMa2bhJrhDFA3/dcZrwGqOHfQT5Lb1bMSJg5EY
   6S/x3I0abbN5qsxix2KOCf0fdWfouEUlzv6P5o5zBfhsozvMe//Rkr3fa
   88a4Z+m+lTNiV1oJakhQHhP0V0ogVOB3beEpDKwsP1TU1Pcc1jARFUcHt
   5tl+Y/0fSUykdNzwGMzkSB0mpZPfjtLgjAvO9mvakDywKcZ3u0wI7CXku
   zYwU43VcNPgtjHqtSGTzUQmq+ortktoTI1K2486ZRBDM0sWsWhw5tISf+
   LPPxVrhWIgs5bA+P7eP2DfReb7dc/nlNql9PSeoD3UV2ZUlF5NUJEF46U
   Q==;
X-CSE-ConnectionGUID: whEJEi/sTUObCRif2T2n2w==
X-CSE-MsgGUID: 3aEOlpEXQ7ix9/8bAN58pg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134338859"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 13:50:19 +0800
IronPort-SDR: 68f1d91a_JAA2av0xeRKxN5e2sMADLFY1/RYjqz0AI4dz1Ngqrs6Wa2a
 CGLvGNSzF2Gh4wQXzijSp8caw3yzCMaQtrVDoAQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 22:50:18 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 22:50:15 -0700
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
Subject: [PATCH v6 1/3] common/zoned: add _require_zloop
Date: Fri, 17 Oct 2025 07:50:06 +0200
Message-ID: <20251017055008.672621-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
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


