Return-Path: <linux-btrfs+bounces-5188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E78CBAEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4876F282F2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA378C7B;
	Wed, 22 May 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+ru+U1/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2277F13
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357830; cv=none; b=dC9TryT6MpGwxPDm/BIAwmus5AnUjXnD2nA3C0o5suqjGv76eFdR4dIdbJM3t1BZeaMbxPwpXAu6psd2ocsLl1SGREpvnx7j7XJ35PzFTwAAC0hVKZR16rX2UCpuo4oxjKxsavOgqDtVJINE5eIh03hMs1h67U5kBwAQeRu5fcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357830; c=relaxed/simple;
	bh=VXq0f4lmSAMQ7qpNIpQ1Dxc8+Hfcw7+vt2hvmdRIYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmDeR/Jg9zpgG8ecDCtwBezu1gIfo/sKm8glolKCCIYcNVpZ/q1e8i8xVSycZPqgkjgejgROkFVNmYMw9Q/XEflIoLS6XXLbf9mIYT2sgMp2PAw8m1P/z4Z8OStCJuQcz4AWB1Autb3Mn9oz+4arLSAYjNna/lStuAY/FbTw6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I+ru+U1/; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357828; x=1747893828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VXq0f4lmSAMQ7qpNIpQ1Dxc8+Hfcw7+vt2hvmdRIYpo=;
  b=I+ru+U1/zTBUORuNErCM8gB+6guLTQqd5PpVExfbLzn4UiIrf4hT2TvM
   XqCvohYOhEn9V07k6jEhJdXuw0wkpOryd7qUIt+g8aFSlQd1xgRAO7/YV
   vn6dtJaj5CJxkuIgsnaV8E68revFerBfUUoginF9HacuPj2jSPlA8O5MV
   T6LzCnZkLRlxZ/zoaoXFCU37W7iisyRo5spjG2se90CaDsK+vS+fT1hIy
   3GbeKSi80LLWbTXfMNyVxfFHh0+yb1OMLbY6OZtpnm0gPDTJMtsnhpqJs
   rPWEt0Q7v+Nhpm0pRt1ItmdFWv730P5kKhvEjBKEETjLm8MFoXgMCY1wG
   g==;
X-CSE-ConnectionGUID: 6hHx2P1CRkKu23EPSPKjgw==
X-CSE-MsgGUID: +l8xGOGoSpGqKJ9YjBx6KQ==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16664805"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:42 +0800
IronPort-SDR: 664d7d22_nqADyQR11VmgvAUSQI/Isy8Ug2kFoc0br9JgBw+lfvV+Wwk
 6W2pTWWT4c2eHuXefI185VKmcgFQGCkwaL9piMw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:42 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with sectorsize and zone size
Date: Wed, 22 May 2024 15:02:27 +0900
Message-ID: <20240522060232.3569226-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While "byte_count" is eventually rounded down to sectorsize at make_btrfs()
or btrfs_add_to_fs_id(), it would be better round it down first and do the
size checks not to confuse the things.

Also, on a zoned device, creating a btrfs whose size is not aligned to the
zone boundary can be confusing. Round it down further to the zone boundary.

The size calculation with a source directory is also tweaked to be aligned.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a437ecc40c7f..baf889873b41 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1591,6 +1591,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	min_dev_size = btrfs_min_dev_size(nodesize, mixed,
 					  opt_zoned ? zone_size(file) : 0,
 					  metadata_profile, data_profile);
+	if (byte_count) {
+		byte_count = round_down(byte_count, sectorsize);
+		if (opt_zoned)
+			byte_count = round_down(byte_count,  zone_size(file));
+	}
+
 	/*
 	 * Enlarge the destination file or create a new one, using the size
 	 * calculated from source dir.
@@ -1624,12 +1630,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 * Or we will always use source_dir_size calculated for mkfs.
 		 */
 		if (!byte_count)
-			byte_count = device_get_partition_size_fd_stat(fd, &statbuf);
+			byte_count = round_up(device_get_partition_size_fd_stat(fd, &statbuf),
+					      sectorsize);
 		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
 				min_dev_size, metadata_profile, data_profile);
 		if (byte_count < source_dir_size) {
 			if (S_ISREG(statbuf.st_mode)) {
-				byte_count = source_dir_size;
+				byte_count = round_up(source_dir_size, sectorsize);
 			} else {
 				warning(
 "the target device %llu (%s) is smaller than the calculated source directory size %llu (%s), mkfs may fail",
-- 
2.45.1


