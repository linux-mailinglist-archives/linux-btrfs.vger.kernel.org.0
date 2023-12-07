Return-Path: <linux-btrfs+bounces-737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716848083C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A276C1C21F61
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F032C84;
	Thu,  7 Dec 2023 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iIahbUY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE17D4A;
	Thu,  7 Dec 2023 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939817; x=1733475817;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/PZsmw0zyU4nAM+H32DiGBfJFTVkJfKctQwr8KH9gZg=;
  b=iIahbUY2mntVk42lC26+mN/ZuaRoWIMd+7jf8J3zk1r6QpeAhNAgbc1Z
   HUWO77wium6Y1651DwFqDTt9gHyDHi2xAiEccEiTfk0ahsaVP9pEg0Fng
   Wf65SwpoRYGdjagj4F3my0ku3IrPGF/rYdYHI2u6Q2fOK8PiChoSRX3ZR
   CKqmOWIouj6G+H6btPDeqB+BRWdpSIKjDRwaYGRFOFr5FabrVMnpk9ywL
   0VQ21X3hRJhiJE+sfwJpWT1UUWqz1P3Lagm+VgzM34oCP5GVsi/kOodU1
   vt5f3v5DqNUXDSc4Pjt5FTtNHwvmfMQWYUwI7AvOheQHFHo5RgryozFd9
   g==;
X-CSE-ConnectionGUID: grqKFKCeSLa7bzwcx5flnw==
X-CSE-MsgGUID: lnXgttUgTAWDNkeoKrShgg==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272774"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:36 +0800
IronPort-SDR: M48Bj6RYuJGiB2u6nY85HIWKdYJr24n9M9uScIfzmd7lDkJUFpMjqSejnqOKx2Idu9dr72RmRi
 urRJvLe9Vvmg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:37 -0800
IronPort-SDR: 6fbVWwHwVvg1pha5B+4C+3i2oFWu752Fo4UA5YA9FxaDrVQGPuREFvV4OaGtf81a1WD5FvGvNV
 rgmdzF+Enl0w==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:36 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 07 Dec 2023 01:03:30 -0800
Subject: [PATCH v5 3/9] common: add _require_btrfs_no_nodatacow helper
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-btrfs-raid-v5-3-44aa1affe856@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=590;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=/PZsmw0zyU4nAM+H32DiGBfJFTVkJfKctQwr8KH9gZg=;
 b=IC4vn/SyDQCfGeXuGFXF2ktQRHye67skzSgU06AzECN/1pLvE/JC7tVfPXQWJRMe9/NbiFvrc
 OZBRFDwr3ofDYenieZ2DU3xV/nOasDGIm80EWjHUqXX1V5M44s72Ro8
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e3ccb4fa07d4..bf69bcee158b 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -120,6 +120,13 @@ _require_btrfs_no_compress()
 	fi
 }
 
+_require_btrfs_no_nodatacow()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+		_notrun "This test requires no nodatacow enabled"
+	fi
+}
+
 _require_btrfs_no_block_group_tree()
 {
 	_scratch_mkfs > /dev/null 2>&1

-- 
2.43.0


