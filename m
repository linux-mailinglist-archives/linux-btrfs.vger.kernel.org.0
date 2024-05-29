Return-Path: <linux-btrfs+bounces-5342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17A8D2DE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C21F2378A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F9167296;
	Wed, 29 May 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c3l/5+ii"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081121667EC
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966822; cv=none; b=KMMoSXMccjQeQ65zqgP8qhbz6pjiu3FPlJEU7MFYFqxgQNa4lx3a2WwYUXibWmT/eWThd01mEhPO6H5f9lFMN82EDd0ftrtCknAWm2cDRY8A/Yl9ag76u9xj/JuTUHg+fKznX++rvCe8pwekLZp0fxuzgSQGoNyJyq5jbQwgC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966822; c=relaxed/simple;
	bh=RRH0i+zs6OwMRK0hsjxAQJYgGLPDQ5LxzfkK8ZxMQQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG7rMyncJEaNiLUWxXrqwtz/PtJvft7PhPbnP8xNiH7DV1YP4J7FUAJT4FSKjCMyBTINIlUeeeAIh0Xm8k3B+76DZvVu7iYfW79csnVwKAqLlx9qgUo/wI4pke1XSG1bq8OEyGPsCvxkMOK4guZ+h0B+qYqYTy3Lmzt45kqcVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c3l/5+ii; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966821; x=1748502821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RRH0i+zs6OwMRK0hsjxAQJYgGLPDQ5LxzfkK8ZxMQQA=;
  b=c3l/5+iiWXY2CgI6rQCvW5za+9fuLJDvbrJFrDWiH/C7bYIZo0MKS1Eq
   jpuSNQc37tt7Ggylh+71yXeDKhSQyccWTgeHVCfoGJj9oI9hvHQ1hN2Rm
   0vAP3MTFjNAi0iYKlCLNX7rinqnSPLp0pVdb+/hP4/Dzfi+Wua2uwZ1w1
   FTK7KQF26+w8TMNug3YYa0ZwLALQBOxFTNE8oZqIwMeG60ZewGn/dSsUp
   DpW/pXZ8x+2QLU89laJi7NvJLAqFse/ODkeMSrXqx+nx0HYYczpnbi8tp
   oA3ayrJVv4eyDV0XyuhTvYdNUNbFDf8LomQ1TIg62k/8ZwbIYMNjreKYX
   g==;
X-CSE-ConnectionGUID: H+622OaZRSOCc1e2Hd+EFg==
X-CSE-MsgGUID: YuILdcp5QpWCQWCWBTd1Ww==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865345"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:34 +0800
IronPort-SDR: 6656c94e_tkek76fSAaUiNgGUJgSPA5MLXTrvvPeWckGxxnDewcR3Zcs
 KK8b3apIA2/W/pIDve7tn5khWxAoQtJ1xFD9APA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:03 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 05/10] btrfs-progs: mkfs: align byte_count with sectorsize and zone size
Date: Wed, 29 May 2024 16:13:20 +0900
Message-ID: <20240529071325.940910-6-naohiro.aota@wdc.com>
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

While "byte_count" is eventually rounded down to sectorsize at make_btrfs()
or btrfs_add_to_fs_id(), it would be better round it down first and do the
size checks not to confuse the things.

Also, on a zoned device, creating a btrfs whose size is not aligned to the
zone boundary can be confusing. Round it down further to the zone boundary.

The size calculation with a source directory is also tweaked to be aligned.
device_get_partition_size_fd_stat() must be aligned down not to exceed the
device size. And, btrfs_mkfs_size_dir() should have return sectorsize aligned
size. So, add an UASSERT for it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a437ecc40c7f..3446a5b1222f 100644
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
@@ -1624,9 +1630,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 * Or we will always use source_dir_size calculated for mkfs.
 		 */
 		if (!byte_count)
-			byte_count = device_get_partition_size_fd_stat(fd, &statbuf);
+			byte_count = round_down(device_get_partition_size_fd_stat(fd, &statbuf),
+						sectorsize);
 		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
 				min_dev_size, metadata_profile, data_profile);
+		UASSERT(IS_ALIGNED(source_dir_size, sectorsize));
 		if (byte_count < source_dir_size) {
 			if (S_ISREG(statbuf.st_mode)) {
 				byte_count = source_dir_size;
-- 
2.45.1


