Return-Path: <linux-btrfs+bounces-16354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25ACB35032
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81038201D06
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B10239E7F;
	Tue, 26 Aug 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qNgMuWfp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3B238149;
	Tue, 26 Aug 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168045; cv=none; b=Rfe/wp01ylGbm/CoRFMTwpLYC6z3OwY9tMpSqILym3ZXmPEMGktBqM7esCbQXVUM6KUc0XEMeY4gQQJN0FMxk1rlJFI/bLEbRrkutJwDcADuy32OcQM6BRxrpGs+JwPzSlWTq4AFJp176+QwSArB3bTmH2VrUqIiLAzRatKA388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168045; c=relaxed/simple;
	bh=99FxQZCJDzrOUANtltH/uG/ZoGiLqP0aWuAKecy9HwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KT+k6mYW1jtBJySyvfL6mVgSd6WOpgALFfZcC/4zPUU5fcJEInM1zygw3TzrDKR24DCwBzz4PnZoggrHHt7T/pfY2yI8XFlamP+Sm/fM+A7CPsYSVBfDx1eiy7hHX0C7aZuR0e9j5GWNJ8MI9VK3qpsDM4zir6JaoKzzb7dsqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qNgMuWfp; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756168043; x=1787704043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=99FxQZCJDzrOUANtltH/uG/ZoGiLqP0aWuAKecy9HwM=;
  b=qNgMuWfpjxbeDAvEfXUdxVlgnpqDNiRrP/cw6FOgoA1kshBVyeTy3f1m
   v/VTvjZcAYmW/offovp6gOBhZMrEvO4pTB79MVFkvHS+Lb7RsJC0pGyAd
   Os+0jRQyceWoc18JyfaYLj9IFT81E/vz/oDX7cn+5W16uZ0tzXp5pbcs/
   3atPGEe8aGrDeUrycadan/BEuTgZqomZ+fzs/VGAg4pDElLFz73FVIY10
   eVd8vVQyyEeQg0MbwLVFlrWqR8BZQOMu8xizn6EKxxTWyvj1993usRK51
   f0erHrQ4bZeOoIhFRAA6wf/zMe0ZZnYAXXorFzNXwxiy8wS5TNTtxFSdf
   w==;
X-CSE-ConnectionGUID: 5R8mP9GVRlu/TIWwC80OLA==
X-CSE-MsgGUID: PxsruT5QRg29CQWxs9wEUw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751212800"; 
   d="scan'208";a="105333138"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2025 08:27:23 +0800
IronPort-SDR: 68acff6b_y1fdOI3c0DD1arceJyfND+cBT4UUiYuQtGlyuuh2+DWTiX/
 zp3mrbofHLGoi5RD3dLXPJPxdieP5piBsDWdlRw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 17:27:23 -0700
WDCIronportException: Internal
Received: from wdap-r7gzyagyjd.ad.shared (HELO shinmob.wdc.com) ([10.224.163.112])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2025 17:27:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd/009: increase max open zones limit to 16
Date: Tue, 26 Aug 2025 09:27:20 +0900
Message-ID: <20250826002720.12222-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel commit 04147d8394e8 ("btrfs: zoned: limit active zones to
max_open_zones") introduced in kernel version v6.17-rc3 caused the
zbd/009 test case to hang during execution. The hang happens because
zoned btrfs requires the maximum active zones limit of zoned block
devices to be at least 11 or greater. The kernel commit applies this
same requirement to the maximum open zones limit also.

However, by default, the maximum open zones limit for zoned scsi_debug
devices is 8. The test case zbd/009 creates a scsi_debug device with
this limit and set up zoned btrfs. Thereby it violates the 11-zones
requirement, which resulted in the hang.

To avoid the hang, increase the max open zones limit of the scsi_debug
device from the default value 8 to 16.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/009 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/zbd/009 b/tests/zbd/009
index 6226d83..b268483 100755
--- a/tests/zbd/009
+++ b/tests/zbd/009
@@ -50,6 +50,7 @@ test() {
 		zone_cap_mb=3
 		zone_nr_conv=0
 		zone_size_mb=4
+		zone_max_open=16
 	)
 	_init_scsi_debug "${params[@]}" || return 1
 
-- 
2.51.0


