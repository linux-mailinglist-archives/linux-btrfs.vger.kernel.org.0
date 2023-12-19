Return-Path: <linux-btrfs+bounces-1066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D92819276
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A8F2897E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47683B78B;
	Tue, 19 Dec 2023 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zd5+jzmW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F203B287;
	Tue, 19 Dec 2023 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703022159; x=1734558159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tPP2kDEf/tN7yIAxxly8R2bJj7+PWjjcASYnXDyDXAI=;
  b=Zd5+jzmWEY3tdtsgR7QnSMqXic56XObdc6Ny3K83jNApQgRvE69Wc6Qh
   nEc0tIpkN4LCYmBxa17L3jhUk7xAINusmbJ0SHMVQ8Nbg7TrDMwM+40qw
   KxFBygfTAitmM5GrtmenwrDP3NIJiPJGOQgbs8PT/AXKGhpKlQfdnm6LU
   DvR7aJm2R1sHBrdaQDSBBjPWw2yAl1XRqdFFMZbWVPuExm6Obhyg9h+Sc
   opUOwHyiRKoBLabV41bSze1xKm+emvaxWMbFxaoIGcrWb+h5PJ4w9tHDV
   JxECxS3Nvk/CzNIsyyBbVQb1+AOLM3uZfslnZHRa6iOqwQzXlHlifYTAy
   w==;
X-CSE-ConnectionGUID: fmJvmysGSFanO9JYKWvAig==
X-CSE-MsgGUID: cQ+N/ee3T5K/bwRkySxDbA==
X-IronPort-AV: E=Sophos;i="6.04,289,1695657600"; 
   d="scan'208";a="5328979"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2023 05:42:33 +0800
IronPort-SDR: 7sSVpd69KBg7RW6M4gv3n9j9FpUdMQGueSeLS3P7jSRddWFiN9H/oM/u4xRl5aIvGH0i0ZQ8ZZ
 91F0/8ClgqGA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2023 12:47:37 -0800
IronPort-SDR: N0nYHn3UrUEGXVcv3yanexY5Yg7nyGkQT0Mj56efowPshBruEPICk1Y6viY4Q1hI8YxE1DT/5D
 uNU+QOcGKIdw==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Dec 2023 13:42:33 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] fstests: filter.btrfs: update _filter_transaction_commit()
Date: Wed, 20 Dec 2023 06:42:30 +0900
Message-ID: <20231219214230.770724-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent btrfs-progs commit 5c91264d2dfc ("btrfs-progs: subvol delete:
print the id of the deleted subvolume") added the id of the deleted
subvolume to "Delete subvolume" print format.

As a result, btrfs/001 now always fail by the output difference.

  - output mismatch (see /host/results/btrfs/001.out.bad)
      --- tests/btrfs/001.out     2021-02-05 01:44:17.000000000 +0000
      +++ /host/results/btrfs/001.out.bad 2023-12-15 01:43:07.000000000 +0000
      @@ -33,7 +33,7 @@
       Listing subvolumes
       snap
       subvol
      -Delete subvolume 'SCRATCH_MNT/snap'
      +Delete subvolume 256 (no-commit): 'SCRATCH_MNT/snap'
       List root dir
       subvol
      ...

Fix the issue by updating _filter_transaction_commit().

Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/filter.btrfs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

v2: Fold multiple filters in single sed command, as suggested by David
Disseldorp.

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 02c6b92dfa94..8c6fe5793663 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -69,8 +69,9 @@ _filter_btrfs_device_stats()
 }
 
 _filter_transaction_commit() {
-	sed -e "/Transaction commit: none (default)/d" | \
-	sed -e "s/Delete subvolume (.*commit):/Delete subvolume/g"
+	sed -e "/Transaction commit: none (default)/d" \
+	    -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolume/g" \
+	    -e "s/Delete subvolume (.*commit):/Delete subvolume/g"
 }
 
 _filter_btrfs_subvol_delete()
-- 
2.43.0


