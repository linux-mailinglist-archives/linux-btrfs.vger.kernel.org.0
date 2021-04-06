Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6219C354E40
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhDFIH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49866 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhDFIHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696440; x=1649232440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HdWP9kEKhaHkVtclaCpVg0Lg/Nf0Mu06pyHA54z7Czc=;
  b=iNjtHKCSLTaA615RAEzoQwSsMpeodfF2Xj+vnAVgkE9FIbPmuFu17773
   +UW70OFVVb6nwuv3bZkCtXu1DutAFTnMeJ4ZQg68f6EenxSPtZJekLWFh
   u74Ux8gPB9dLUu+ez5tZvVs/mN3OKpRp4YBYhKczUQGaGgfsX1wjhswWj
   +RhbXHTDJGuZFPyLDkMNIhp78eAOdZ7sVLUMuSzwA+ejCPtq0VDBcIC55
   mNYwNHBrGx9WgAKaKJtcBGOXZecLtIFSmT6qCkGdR3uVEct+pcalcHwEm
   qr2x5T3tkxCMWCgBdFOVEqHjuaAyFsZBPmcwtgWnjmC1Vn5atCicp5xy+
   A==;
IronPort-SDR: RPlxRv4InD/p8JDC/TNVqm4XN+yxsGfiaZ+CSde2RR0QGnhn8GV7ffsQKpmiEvTdiZagtj7wsj
 SrnlERj7GAVfsIBfU/HbsfN4aKrn8BixSy9gjsHyU9vTVMCiZBOhI/7MYoNzgRZZggJtrzkYef
 3RK3CLKcXTwTtM4P5kb2Dy5M+OtMb33wPykXoJJS0xoK2A2FhA6mUftlsZJdqGUgaOvaNLKxiI
 nmq9nT1xk2QQHfA18QYMabtG21LUBEQjAJEwcqqiSuQQ37l9aGz93YwiQvGVTvEjAok2chag/B
 2zw=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290642"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:05 +0800
IronPort-SDR: 3s7pE5qkgwaxSeNgAnc27GAm5PAmz3/247ZQhHB1XewujecUxIMII+/gjpHOggtEMUuBPAIIM7
 ZXDtR00H2ZMaEJzjwCBgT2WgNjoNX0FjHh1ZlwxAtKTYJnupfXtHNXfoZFO4/XDvN9xVH3Dex3
 HX1h/wR+Nmm9izGpt7DuIJ0z/lyRFLBAIbvuN83HKnWcaaFfvDgVe8OnA1Mfn52XDfcFunmLJu
 yyVdOOHjQ1mt2StIvQFQTWeZHh8nRFvG/nliLARUWDxIoxUOYQZjHiuumB3U8hv7JJZBUmg5qA
 bI5943NxkrBC3EvNrFWLc+TT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:21 -0700
IronPort-SDR: dQ7U3I6QT/L4RlXWre3wa1pHWcC2Za1w5hQb5IiloTBp7smjjTqtXuR8kKvbVV90J7XIj58OBR
 hnlys212WFwgilxDqV+L65Ra27hK7FRGZa77Z49G2UskeAeyizyCONPRa+YP52fAz2I73L24k+
 BuBxZdj5MQWoW47AsBAZ+CIDQnqQR8Cm4zCfd/ty/brK1lYxMV6Tak1FG+b3FTfNHyuWECe1JC
 boFDqZW1/304NxTMA9C3ZEAYs5xbDj/qxC3GjncIWzk3HC5jS0hYlglIps4Y25AHRWzpS7na2m
 Tsg=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/12] btrfs-progs: refactor find_free_dev_extent_start()
Date:   Tue,  6 Apr 2021 17:05:44 +0900
Message-Id: <71a8276cc5028cbe14914b7dc097321af9b226ed.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out the function dev_extent_search_start() from
find_free_dev_extent_start() to decide the starting position of a device
extent search.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 7bd6af451e78..3b1b8fc0b560 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -444,6 +444,21 @@ int btrfs_scan_one_device(int fd, const char *path,
 	return ret;
 }
 
+static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
+{
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/*
+		 * We don't want to overwrite the superblock on the drive nor
+		 * any area used by the boot loader (grub for example), so we
+		 * make sure to start at an offset of at least 1MB.
+		 */
+		return max(start, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	default:
+		BUG();
+	}
+}
+
 /*
  * find_free_dev_extent_start - find free space in the specified device
  * @device:	  the device which we search the free space in
@@ -481,15 +496,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int ret;
 	int slot;
 	struct extent_buffer *l;
-	u64 min_search_start;
 
-	/*
-	 * We don't want to overwrite the superblock on the drive nor any area
-	 * used by the boot loader (grub for example), so we make sure to start
-	 * at an offset of at least 1MB.
-	 */
-	min_search_start = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
-	search_start = max(search_start, min_search_start);
+	search_start = dev_extent_search_start(device, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
-- 
2.31.1

