Return-Path: <linux-btrfs+bounces-4982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAEC8C5B05
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCEC1C21779
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F1180A82;
	Tue, 14 May 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TsGBjv3N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD21802DD
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711093; cv=none; b=HEbzk+3cNrSwqer0V2V8EZzL1Bze6kAz+BMBKex3mS2Ibe/410j26F5DKOjUvPEUpGtSdPhNV4108ZFh4UMioXj7EmjraSLCAXojAAC9iCH9t/eJFrYan3l86iXixwHaz7YSZzh8Od6dHM68bnJAeJXdNsrSPlvm57yyyHW5La0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711093; c=relaxed/simple;
	bh=TBUYJ3c6BS0lMAzA+zRpFALc0P5qHwaGeFmjh/qbv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbLspiC6xrzoarQpnHKEZiqdMGNMlqOsg9s2ZtLZ+FT/LdJ+Eb5fsh1D1jYdYeKZwsaHoPGuC3x350GuaXwgbREIio8jqU/cDZqffp7Rj3F/u3xzz6cG2sGoDcxVQyYd+T2b6I8sV7QV1QcvRujrVgI8MKDOj5C+6pB1dNfcDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TsGBjv3N; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711092; x=1747247092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TBUYJ3c6BS0lMAzA+zRpFALc0P5qHwaGeFmjh/qbv/o=;
  b=TsGBjv3Nv7s6H0DKIog4wN4a0b4PHC8TOo8sZXISMaf3Z0zWhX+R5/xD
   liTCm2fnJ96R9qMUmubEP1DJCn3CPkZc+venXRaa5WplMqnRWMcCozdkO
   /8MTFlO4y3he1J1o4N6SnhDarJD5Tts1qyY12Nw0HmhfD4RzslanBDwpA
   2T1uGl89+3/YpCDKmvIzE2nWaqnzbdd54Fnq540LpiZv0oHpCmQlh6rqD
   jcKYjF+K2fTbPq6pGlH3WdpIAK2l0eYDh4iV5yOYgoHxPULUWeksMRcYk
   LC+DQxil1YyD6ENPJ4s58Kv/hApX2uCPSG0OhpUW3t1Xd3hSfD9s5b5fn
   A==;
X-CSE-ConnectionGUID: 1Ztb+vY/TleaeEz6EPDQ8Q==
X-CSE-MsgGUID: OUMCUwWeQjG84DvBzCuEBQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162636"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:47 +0800
IronPort-SDR: 6643a030_vbkhKolijDfota61KtO5IZcnXqoddt7g8f6UktERxVuhCt2
 B0M8kVMUYS+gl9osGHl3elA//n+k91aNvhON2NQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:33 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:45 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/8] btrfs-progs: mkfs: remove duplicated device size check
Date: Tue, 14 May 2024 12:22:21 -0600
Message-ID: <20240514182227.1197664-3-naohiro.aota@wdc.com>
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

test_minimum_size() already checks if each device can host the initial
block groups. There is no need to check if the first device can host the
initial system chunk again.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 950f76101058..f6f67abf3b0e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1189,7 +1189,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct prepare_device_progress *prepare_ctx = NULL;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
-	u64 system_group_size;
 	/* Options */
 	bool force_overwrite = false;
 	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
@@ -1770,14 +1769,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	/* To create the first block group and chunk 0 in make_btrfs */
-	system_group_size = (opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	if (dev_byte_count < system_group_size) {
-		error("device is too small to make filesystem, must be at least %llu",
-				system_group_size);
-		goto error;
-	}
-
 	if (btrfs_bg_type_to_tolerated_failures(metadata_profile) <
 	    btrfs_bg_type_to_tolerated_failures(data_profile))
 		warning("metadata has lower redundancy than data!\n");
-- 
2.45.0


