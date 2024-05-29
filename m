Return-Path: <linux-btrfs+bounces-5339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9E8D2DE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28CB285DD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE8167264;
	Wed, 29 May 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CSFhWGdB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EE1649CD
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966820; cv=none; b=fDYMk2thf1+k1CvdjSujjmo6HvwXNOuHFS8m2jrdikiVpuJox0882uyMF+n0BoFfZNQf9vf6whAniDE2bf51whKgWJotvkhumbw2qAqFqbS5fEOuk6F+gBCVaLhisQDLtvTJA7F9AkG7CqjibwCYH7ufNiuMDxy+aDNzp2a+AzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966820; c=relaxed/simple;
	bh=fjNG+MvTZcDGNAylJ8cU+SnnpA6+sZiLFD0FZ+0zI4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2BE5DHqpUuEBKlD7c3bVG4rXJpE5cmRrbxnQv3GdNKb26wgh4Gre4Skyr55jXgiuB5nhcmTaRmEqh5O5+i4hmonilNS3RxoLqbq+C3ORLlUdL5RXc1qSpnuTzZE0GEDwCDCj8y++SgWH7B+sBL1KhUfVZ+NdzYKFKsF1aYtPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CSFhWGdB; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966819; x=1748502819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fjNG+MvTZcDGNAylJ8cU+SnnpA6+sZiLFD0FZ+0zI4I=;
  b=CSFhWGdBqpKkMgReEQsIIlXTHmgYArKnUMOSYq3kyOHcMUgrbWfKxRMV
   k52+bzRHjpkOEKIEZamyzu6Tx3wFKLB6dTsRb8q3iZMEO4JAYf3R3/hRS
   KmqIcZQ8tkAZuVmGwLNKRwSk0kQeVcO5fb3UD43dSIirGPx2oWdOc4qnu
   iJtHo0oO9sy6+qjzW9d4QPLylzg3MfMBUtNVBtm9iBsO47YPVkR8pa2IJ
   E66b2JVC/UA40XDzSmlDnveFUv73KpQimP5txHeoXpG0A2Zyc1PBQrN/X
   adF1v4huDkGLrkGiX0U7H1MBkHiVj3LKsUduHx8E0aK8V5qHKpVSSD+UF
   g==;
X-CSE-ConnectionGUID: FOREaHjuTFm2zBheqgofgw==
X-CSE-MsgGUID: go7gHnlBSf+YZqGuv7hufg==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865337"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:31 +0800
IronPort-SDR: 6656c94b_s2PMdPHxpevXmoeZKhWV2l6iVkkO2V9oH0YYlMh9CBiNHmr
 N6PeZxG+X1NmbuH7nImkm0E1UqR+cZLpOOneUeQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:00 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:31 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 02/10] btrfs-progs: mkfs: remove duplicated device size check
Date: Wed, 29 May 2024 16:13:17 +0900
Message-ID: <20240529071325.940910-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
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
2.45.1


