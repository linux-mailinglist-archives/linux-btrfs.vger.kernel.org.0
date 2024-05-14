Return-Path: <linux-btrfs+bounces-4950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A98C4AA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48871C23218
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26563D0;
	Tue, 14 May 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GIrBi8ON"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E617F7
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647931; cv=none; b=kiM2t62wmCJbFZnVf3puzZRQ/U/rCLFH59LBtRuaSBnFz1YtPMgpYIu5dcQ9FgybLBIr0Ii4Fx4cHuNg+MTSKQ9bY6NqHOnwuiNh9j/JmW+vKW5X+NJKzHlIxMTV6jyvEwQyY+suq4T00zg1U1vQ+k2nz4DCAxxyanbmRl3oiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647931; c=relaxed/simple;
	bh=H7MQbFgVBsa/41MrMi9xW8AJFk6zCjEkOzRcEVn0po4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDYxs8U5PVPYFbczcRV1N1TgN0r4C4dSs4Xk6KkmWoN/MkV2Q52MU6RhsppWtmp6/k17dNSxI8qv8jnLKB6e2GcBmnkAFf478zGLjxQd1p5cubPE/LWGMfwFBqTAx+0CKniCMs+sUJHz0M5LJhArn59pzZwXv1sNtQoG71SmCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GIrBi8ON; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647929; x=1747183929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7MQbFgVBsa/41MrMi9xW8AJFk6zCjEkOzRcEVn0po4=;
  b=GIrBi8ONtqwUYX8jnnx/V9IMB1WB+T443DsJMeGxnTKeWy/xKuud8LOp
   eDgj0g2QmbEavhybQxCytCFeM9jnKJxcRoOtUAabZXA/foqBuDlcUUwq1
   Ys2JTt/NDTzr6qVAPjQZdB5JIIG8Crv97XwMDIQ7UG1GX4NaokFiJecLl
   qVoY4n0gf0elmvWFd/oPWlaGgwCEiiFMNj76UsEM6GSleE6s+kTy3BjoR
   lDc9pc8u/amSvnyIqx2gmTLL9QmR0O12MjxGEyNASqKUjLxYCZRhgGy+H
   pRo5RRmUBCP3uRB1z+tA+IZ4LsiMlJhfpjMwr+hJKFwgyNI02AtvYvKsh
   w==;
X-CSE-ConnectionGUID: wwM/fWyuQJGRfsa/trV5Kg==
X-CSE-MsgGUID: OJ6gJLq2Thqw4l4Z6Yi14w==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16252234"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:52:05 +0800
IronPort-SDR: 6642a823_2/apwzdE8OWJfxVfG5KDZYYlQF381Ch1UDGUYxQkK5vpmCg
 R8vFBzEmmW77seS2dXNfzmh96YcaDbxzD1gOAyg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:54:12 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:52:04 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/7] btrfs-progs: mkfs: fix minimum size calculation for zoned
Date: Mon, 13 May 2024 18:51:30 -0600
Message-ID: <20240514005133.44786-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514005133.44786-1-naohiro.aota@wdc.com>
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we check if a device is larger than 5 zones to determine we can
create btrfs on the device or not. Actually, we need more zones to create
DUP block groups, so it fails with "ERROR: not enough free space to
allocate chunk". Implement proper support for non-SINGLE profile.

Also, current code does not ensure we can create tree-log BG and data
relocaiton BG, which are essential for the real usage. Count them as
requirement too.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 53 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index af54089654a0..a5100b296f65 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -818,14 +818,51 @@ u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile
 	u64 meta_size;
 	u64 data_size;

-	/*
-	 * 2 zones for the primary superblock
-	 * 1 zone for the system block group
-	 * 1 zone for a metadata block group
-	 * 1 zone for a data block group
-	 */
-	if (zone_size)
-		return 5 * zone_size;
+	if (zone_size) {
+		/* 2 zones for the primary superblock. */
+		reserved += 2 * zone_size;
+
+		/*
+		 * 1 zone each for the initial system, metadata, and data block
+		 * group
+		 */
+		reserved += 3 * zone_size;
+
+		/*
+		 * non-SINGLE profile needs:
+		 * 1 zone for system block group
+		 * 1 zone for normal metadata block group
+		 * 1 zone for tree-log block group
+		 *
+		 * SINGLE profile only need to add tree-log block group
+		 */
+		if (meta_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
+			meta_size = 3 * zone_size;
+		else
+			meta_size = zone_size;
+		/* DUP profile needs two zones for each block group. */
+		if (meta_profile & BTRFS_BLOCK_GROUP_DUP)
+			meta_size *= 2;
+		reserved += meta_size;
+
+		/*
+		 * non-SINGLE profile needs:
+		 * 1 zone for data block group
+		 * 1 zone for data relocation block group
+		 *
+		 * SINGLE profile only need to add data relocationblock group
+		 */
+		if (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
+			data_size = 2 * zone_size;
+		else
+			data_size = zone_size;
+		/* DUP profile needs two zones for each block group. */
+		if (data_profile & BTRFS_BLOCK_GROUP_DUP)
+			data_size *= 2;
+		reserved += data_size;
+
+		return reserved;
+	}

 	if (mixed)
 		return 2 * (BTRFS_MKFS_SYSTEM_GROUP_SIZE +
--
2.45.0


