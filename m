Return-Path: <linux-btrfs+bounces-966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C677C814075
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0202F282149
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD2D28D;
	Fri, 15 Dec 2023 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bEBOHVoP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A125D267;
	Fri, 15 Dec 2023 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702609867; x=1734145867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gh5AUfShu/tb5OHGohSqHYmVNwGdi4FZVRNNWWVufO8=;
  b=bEBOHVoPr/mGL7K9Ur+JUAyItdLv4Fwx7kdEMuwM4urDgzk4pUXILzxc
   EzOEwmleBvmG/wrRl0kyIkYY8iOvDTd/N79vq5ey4dORAIEP1XU9towTq
   ioSmSrvJ+XATM3lDgyczngfBmNcwG4aIpiq+qiicwSYnRRK9tvcMqv0EQ
   JCoW1lrBSp6iOhiEIgM3Qpw6jDw4JKgzQsdBT701y4W3bi8e2zGE0vlJN
   HHQZk7S5A0saE0FvYB1aVOwopiqxOxpu14j6FRcbUX1AkH5ZAX/omKHIX
   4L+JaliDY84WGCGBzke6sz6pTo6xOyu5LYbLpmXYXMCu49ny8mFKSCQ1k
   Q==;
X-CSE-ConnectionGUID: ksT/0r7TQgmtpMKh0R7V4Q==
X-CSE-MsgGUID: 7yNH5KoLRLOSU2HEp0vqMw==
X-IronPort-AV: E=Sophos;i="6.04,277,1695657600"; 
   d="scan'208";a="4869973"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 11:09:58 +0800
IronPort-SDR: 2nv/rVvEjIbRzQu5UMX7+1jkiTRsp9CdMnvvDnsndNm16uTlhM9eWuUDysQZJ9Injphzrb3mQx
 F76Xu3EHk8rQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Dec 2023 18:20:49 -0800
IronPort-SDR: jA3LjlOEHO/T/NLT4I64/XOVR3hBauPReBrl+g/elg/WE8FjVGeAUy1wrL0kUtUuXvuY+4HD1b
 Z10HwQoSiaHg==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.84])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2023 19:09:57 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: filter.btrfs: update _filter_transaction_commit()
Date: Fri, 15 Dec 2023 12:09:51 +0900
Message-ID: <20231215030951.449252-1-naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/filter.btrfs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 02c6b92dfa94..cea9911448eb 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -70,6 +70,7 @@ _filter_btrfs_device_stats()
 
 _filter_transaction_commit() {
 	sed -e "/Transaction commit: none (default)/d" | \
+	sed -e "s/Delete subvolume [0-9]\+/Delete subvolume/g" | \
 	sed -e "s/Delete subvolume (.*commit):/Delete subvolume/g"
 }
 
-- 
2.43.0


