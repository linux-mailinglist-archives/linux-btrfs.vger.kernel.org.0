Return-Path: <linux-btrfs+bounces-4985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DB8C5B08
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF12D2829D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF0181301;
	Tue, 14 May 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HS08gQZF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD6180A6D
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711095; cv=none; b=El/K6y92xUJgI00MqxVKgIQikEAXAxW5kQPyCzBaZ/NZcP1j+x6zUtR+F8WKjZ2SeZAzstjZXdjzi2wPzNzJDcDGVqZBwCwMlYL5jVD6+0hJAyO7m7+owFQBrOwIhcdWbNcUbR/lumE6O8kBwh78cPkjR7XoHlZ80AoOoOv7k64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711095; c=relaxed/simple;
	bh=HHFvQPD4YAmAebDuRTdtW6wNl8XhmAP67kIb8IGY+QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua1DCyI5AnwFQwzdgi2djSIp+nwMie2z9tywBDxpCcATRms0+jTJ6R85H1BjKDbQYgYDU5VZJuvUvQX1BuMnymrPrng4/9yVMDAq+HXZBJTdjojHSnROq8JbsfQEDlEnvKfVjwLAsMOKrYm0O0dqCxphvVE9ZdioMvAWJdRPbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HS08gQZF; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711094; x=1747247094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHFvQPD4YAmAebDuRTdtW6wNl8XhmAP67kIb8IGY+QE=;
  b=HS08gQZFqSaMXi93gElS5KFHIrnbr7qde+NprO7U+zevIDPhuoa3PBb8
   0jt/hxGqY0zM+U7GJFxH3WNJGPSEJEnpKTd7sQWOctsLGZXB1l/zaA97k
   jHaiOUuy8oXZKnEN7hXnsjYeP8LpQ4VJDkmp6SEW6tEPiMUa6eR7cJ+75
   gkZYiY4b1CpGEsk/njXEqwc37pzcTMN12LObRknPHn9N4UBaWy8T/s69v
   dCu89G3ALy8KooAAkKqp9yXEof7yE8QtDZwdeC8OuqHrlxdzhwBIWFWzR
   amDrOszxPapjDNCgxRlEoajCsAGWgWPJzA0EtdD4Y73chIjoB8wOX1+gG
   A==;
X-CSE-ConnectionGUID: C8wrS42aSb6waInLzb6bpQ==
X-CSE-MsgGUID: NJvcnx8dSQeqfraIbueWdw==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162661"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:50 +0800
IronPort-SDR: 6643a034_hUUeVc0wb7GL8+ZOO7o64jRA0x0pA+g2zHC1EyEDjLou7gG
 436NBb1FgjeLvFnSZMJ1U84OsERXnbPrmVlReLQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:49 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 4/8] btrfs-progs: mkfs: fix minimum size calculation for zoned mode
Date: Tue, 14 May 2024 12:22:23 -0600
Message-ID: <20240514182227.1197664-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514182227.1197664-1-naohiro.aota@wdc.com>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
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
relocation BG, which are essential for the real usage. Count them as
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


