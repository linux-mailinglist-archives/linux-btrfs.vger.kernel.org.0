Return-Path: <linux-btrfs+bounces-1591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DF836019
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BB1B258BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DD3AC24;
	Mon, 22 Jan 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CyK9yyEa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F553A8CC;
	Mon, 22 Jan 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920676; cv=none; b=EoKy70obk1nr+4WaOmOuxhicTmHENfJYzyLGZbzWn4SzeZt/E/0XcEcCk3YR4I+jTFV2c1ZaBxDzvWf61DF6V3xheKPJj0sAqzMMNJ0UgdnB2T0lYxcYK15HfJoWs+RFN0R6Hi1sJ/QbD8dBH0KZ4ulQBkbSCRHCYFtg/aMtW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920676; c=relaxed/simple;
	bh=wwPu7DkLQsyhuvNCEpSxZndOrmqP3sMH0uvfkUU5WjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnz1YhM9VBOmbhrVFD6E9nxLWTChC31yNr8O3xtnwPDrz3jqxmUtoUloa5JK4avs30RLm23WhBz+cV6Pd4hlth2SUTFqrwounJIJ4i02Mo5711Bipyk8nAhVzpXfl1SfaHy+LzDUWcurRC5DIqEOhiFpz8blCTKXeOmjwIb6bk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CyK9yyEa; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705920674; x=1737456674;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wwPu7DkLQsyhuvNCEpSxZndOrmqP3sMH0uvfkUU5WjI=;
  b=CyK9yyEaEfY5v61PVmUgs1XL0ZyVIRFIiKqhKn7xvk80PI88KmJH9vWo
   lKq7SO9expegn46DXTl94Ew6m50byh7NYtzvP1p0AwhK7JSuIPerV1Mmq
   dRudOfE+F4hvxJNv0ovJmnhqHWmcyLfjWuKFqdFUgH2m5SJAPkLdr73N6
   uyyL+UE/RNR5Qr3PQvZAyk3GxjGFquq76y0EmGTSLcfivekJEbupOiWc8
   lsezGsiC3mYceHBl7OxOaim9KFRy893H/UW6U+0ParEgfvfXBn6Apgh8S
   iNq2PjudNQFwDXAFuj56QaawYkiAejr9TKTxMLKqgcanhr69JVBzZYFMj
   g==;
X-CSE-ConnectionGUID: rtpBGrOAQ4KF5TsO5NhvAw==
X-CSE-MsgGUID: 1Yn1tz85SFKXYv0O2cCmTA==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7427194"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 18:51:13 +0800
IronPort-SDR: 32Nba8c8wwwixFwZCqcTkJj+GbHlGSTBGO/sqatOYqqTHtU3//vzSD9K0IkxvQc5sXCl+udusY
 L38F8EpmmucQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 02:01:16 -0800
IronPort-SDR: F3NWE8XuMcyk04xRq9g+JwpM08b7KqYnlodzG8W5bj/2xaqn4Ev5HTjVyo/iC0yRCtAVxQNGzZ
 qQYASCBRvJEQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Jan 2024 02:51:12 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 22 Jan 2024 02:51:03 -0800
Subject: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
In-Reply-To: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705920670; l=1177;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=wwPu7DkLQsyhuvNCEpSxZndOrmqP3sMH0uvfkUU5WjI=;
 b=guDBNuj3D6sX/OjE2aHJDCGPc1NYt+gvnf6rLifQxGQoHe3WfgKIjsSNl2U3iVo7mZMRAGtW7
 z2Xw8qZSCblCVqenWIBIB5/1xuqh2JbO+d9HrCZpCxRaye3xHti2x5i
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

As btrfs_zoned_should_reclaim only has to iterate the device list in order
to collect stats on the device's total and used bytes, we don't need to
take the full blown mutex, but can iterate the device list in a rcu_read
context.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 168af9d000d1..b7e7b5a5a6fa 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2423,15 +2423,15 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
 	if (fs_info->bg_reclaim_threshold == 0)
 		return false;
 
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
 		if (!device->bdev)
 			continue;
 
 		total += device->disk_total_bytes;
 		used += device->bytes_used;
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	rcu_read_unlock();
 
 	factor = div64_u64(used * 100, total);
 	return factor >= fs_info->bg_reclaim_threshold;

-- 
2.43.0


