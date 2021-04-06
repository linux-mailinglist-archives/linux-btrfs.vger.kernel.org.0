Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB8354E3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhDFIHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34730 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhDFIHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696436; x=1649232436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Zqw5XcHlgEJqRbG0p+Y+o9TCIn/xhvSgQL6gJALRxs=;
  b=ZLxVZj5/dpaCVGbeDEl9V+A6f/NVNpGtC+BeqcSF/NKWJiwOYpXVsljX
   EH6FhRRF8/5LnEE0d+3amL8U6eq+xz3i0Cpqe4mw0bxVsqdQHH8Y2zwAt
   keOvMZmJXqA/CNK/sSwoB3rWyjctaAHEBxKuGz0MVf9PsdW6CO1n6O33e
   Cs/SZmW3MjVhLCNz9wyCShixsiBGXwVPZ+yLa7A3u/A/Yb1XeSPEbXaPD
   YMPywdoE1akyMzVNUvArr2yflQ2+/htlRblgnTP4VLddV9/K+jYmajrPv
   q7IN2GwaIf38Reo9tlC8xA6B6F+JzhjAPewsqRVp32JNhT0pq0bTHenub
   A==;
IronPort-SDR: onq7CYVFDsZxHfBpdEQ8iTtrUquXIDWo5+Hok40Ev2Ue/+50PWGGNQAFEtsjf6CXrbCNs1SnH2
 MZ6fck8i35avdJIzXK/soJ1PiTnY2nMS1JnYfL45V1fWyYe0Q2cwYKuhdXb/6UFkFU4J6Z/J2f
 biKQZ++V1J+BlCx+tBmfXdKiHLHb9tN1LmBg4XFpxOD3xX2sspPjFy0NMpSivzi/OK6GANsmkq
 Ajz+n9j7hx4ucU+9iSbOoqhA6qJyVqpqrRRAK57vO7ev56kskhDPYGfMxqqtIXS3vQSvQvVSM/
 G/g=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="163733687"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:06 +0800
IronPort-SDR: arUWSlQr0K4ngLmaXIrVYnk6I/bUWSd4AtD5UM6bHwP4KuNfz9OTsqCKscLxflLw2WwM4dH/Sw
 kkVGwAG+9lTbWIrLTJ96g2vQ/XhskE8mC9AHa1lwkFGxsw8o6C5On0joITBFlV51pPtwmzOKnZ
 +sASFG7IjR97xyjTAK3iocJFUGaeFfzf4VxwTP1pchgA6dzFuMdWg6siDCWs0iBMkZ/SfHms4e
 tjy3xxTL96gFBcPykbVWntA8WXW4C76lenj5wwUwA1ppWZdHwImCPnTFQUjaUrBNmd6dB9f98X
 zUNyIv9fIV0S7WdezgtUkCSw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:20 -0700
IronPort-SDR: eK0AU01QOn4egMr8+RCY+AChz0e0zWUNBm0gqhUueGu1ibLG7RPi+TuOvswCEFMgdXIXUKQBJo
 leVUuj00+hQAnFUgFFNS4/21jK5rIy3kMstb1ZwK2k7HDFwx0kgxjXukb87923sWiRPB24a/ZM
 iRXbPIfL9DNYYWyvJjwslZ6fcDZk72Wnh3UfSycM8JA5RPvEwCbx5Q8SI2BPtGChR/aw2EpmER
 OYoojR2RxwLkDYu+VpYbf9SrpQn+71SOo7eTyHJTeKJMey0CtwtMdqufJcumlIhTrzrKcFa0p+
 Ewg=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/12] btrfs-progs: introduce chunk allocation policy
Date:   Tue,  6 Apr 2021 17:05:43 +0900
Message-Id: <4bedaf48df7ba0a31ed0466bfd5645d3436dfe77.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce chunk allocation policy for btrfs. This policy controls how
chunks and device extents are allocated from devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 1 +
 kernel-shared/volumes.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ddddae62581c..7bd6af451e78 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -254,6 +254,7 @@ static int device_list_add(const char *path,
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
 		fs_devices->lowest_devid = (u64)-1;
+		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 		device = NULL;
 	} else {
 		device = find_device(fs_devices, devid,
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index d6e92db298ca..e1d7918dd30b 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -69,6 +69,10 @@ struct btrfs_device {
 	u8 uuid[BTRFS_UUID_SIZE];
 };
 
+enum btrfs_chunk_allocation_policy {
+	BTRFS_CHUNK_ALLOC_REGULAR,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE]; /* FS specific uuid */
@@ -87,6 +91,8 @@ struct btrfs_fs_devices {
 
 	int seeding;
 	struct btrfs_fs_devices *seed;
+
+	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 };
 
 struct btrfs_bio_stripe {
-- 
2.31.1

