Return-Path: <linux-btrfs+bounces-17891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693CBE432D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B45A54089D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D934AAF7;
	Thu, 16 Oct 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZTkZL86O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59634DCD8;
	Thu, 16 Oct 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628046; cv=none; b=dm2pVJoZcwwmGiHJ9aUjCXTmUYEJ4FQwCtGFyU5NukRXA9EJUz0cdBfMap3mW5d7Xr96yfw9YhU8xOPbIWnjaI4+oNBH/V3/b7npaneErRG+y8F3QhVVC6IreV9KVoTDjORD749gsPR18dk1+J5L3dqrFE7MJrebMPrZsMYOpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628046; c=relaxed/simple;
	bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScXLSKaDvWPzRep3c9gEFHsCbzUg1apIhuSZa2UocDgw4xhC++b+ucU4OY0anCa+ZbpNNuAmA/7mqVQyVTLz6KL2w+GDogrMW7HvVxvCJngHKHQo8MxM40WqQ92+4dq+kHITKIrp2MHsAaI02Jer7fTFIrbJoeNe+hJU+XVi9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZTkZL86O; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760628044; x=1792164044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmS0tznIxkS/Y70IdMthiSs4C2kk2YSm9B0eDTVnljo=;
  b=ZTkZL86OBZ7TKibpvBd+H5VeUpGaXjpNKTPsfcGY+qz8N3ZsID+pRr7n
   OFnX23xxjiGD8k26wT4N66TDuyJTBwnnjhZCZQyAqnZyePjlyquqiQW9e
   br5RCy/xeyPKtGRnCIbrm74ci3fRkJ6iZ6Z333+x+gh8a0IoPzyP1rKTN
   Mo62r9J+ysndzlai5hNmECu8GUu2xUxToZDR7Xsoa6eTgOhyYGi2LmojD
   uP0QnsJbAJaCFr+C7x51rP71sMNOZQkSx3Nf0divLcZwL9FMajZJMd16/
   wzu7UtozpeGuUVAbPCma2+H/xiVdBoPooSBTFkENmxyTJFB1kXF04RJfZ
   g==;
X-CSE-ConnectionGUID: pxCl5CaNQJKLd2w0xKKewA==
X-CSE-MsgGUID: koGqpEqKSDqAWJ2Y3KeDgw==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134589300"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:20:43 +0800
IronPort-SDR: 68f10d4c_iSdvoJy3Lsg00GQkP08nMjwx+XF2aE30qeLZj7CbiW9Uu1X
 8YNlFjijW1rU9rWXFlRzktz6lrOHWTgVaoJhasg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 08:20:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.40])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 08:20:39 -0700
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
Subject: [PATCH v5 1/3] common/zoned: add _require_zloop
Date: Thu, 16 Oct 2025 17:20:30 +0200
Message-ID: <20251016152032.654284-2-johannes.thumshirn@wdc.com>
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


