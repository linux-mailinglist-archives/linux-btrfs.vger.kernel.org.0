Return-Path: <linux-btrfs+bounces-12406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2CFA684DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BD7A8C6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78524EF9D;
	Wed, 19 Mar 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ja3N4V4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EF24EF62
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364902; cv=none; b=N+SUSHxQ4HgC3hU8ke97UOYJMSK0Vl8bxQlA7kAz3uJ5/ReU8vdzkKaBL1x+TqUaZ53q4+U2vGvfTLlCarJ0QrPafT9QkAAXj7EzoXUenY+00j5gzspcelJIvMzClCo4DlyG2ajjnuJHbLhcK37YyVPdT6+6AO7pUgAsc522fiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364902; c=relaxed/simple;
	bh=LNXbIHKPa1vr5dlvOZR8bX5sxFAn8cKOBw1GIbqb8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJxv9CuqZq0fXzJwtNIIRYY9pB2qip3FNAv5reRNJwpPfVCMRCRGclvPVtBHqSGtWKkeYorBZRKwN3bUpBwZ1cs86NqFM3Dl6nZVTquvMPva1s2M7fTIFuGRaDSfKiiX/tIeofZMJLbN/BVVTixf8mn5kBvuyXOl/l+q1DoPqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ja3N4V4f; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364901; x=1773900901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LNXbIHKPa1vr5dlvOZR8bX5sxFAn8cKOBw1GIbqb8Hg=;
  b=ja3N4V4foe6+tht5W9Evey2PqJqFqhwLyksUAxHLPEbUccMxL5saJLB9
   EIUQjWyyMq4uwayNJGXM1AxNI0vrt2LsOOpNpiFKxyeKHQ4CHpX9EVJn5
   +nSrhAmTXBoS6KFkAfaiH4DTMw+nxdoznExGuVBrt4YJLVF3rGdN+tjYu
   OpcTlCISFiOKZd/4oDWXDhhCYVtnci7ns2/X6qPgraFKAzCVYNKFR1awD
   tnttrYMSZPi4I9pdNknfIPmEoxddTNpRx96h9dOeBmI9nGWYswkRlsrey
   XKFkOV3aLs7MTXbIHz5/MDPaZNgWv6d6s40CizkxsZVsQNk+ICrtYQHC1
   g==;
X-CSE-ConnectionGUID: du06e8ehR2qGAOcyIQyWuQ==
X-CSE-MsgGUID: d5BoJm7jS6qPDHig6a2p2A==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227211"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:00 +0800
IronPort-SDR: 67da5304_itfspwg0D9DeVxs3NXlGqaBmhTzU2RDKq6L1+0FhO1CBa00
 pvY9b7nvF+tIUX3GnR6J/gF2B1nvdsfAcHzViCg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:49 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:14:59 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 03/13] btrfs: factor out init_space_info()
Date: Wed, 19 Mar 2025 15:14:34 +0900
Message-ID: <268c9cc120a683f57c919466cad6a923c9ee30ed.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742364593.git.naohiro.aota@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out initialization of the space_info struct, which is used in a
later patch. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 71c562e78b16..60f76afc5fe9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -234,19 +234,11 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 	WRITE_ONCE(space_info->chunk_size, chunk_size);
 }
 
-static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+static void init_space_info(struct btrfs_fs_info *info,
+			    struct btrfs_space_info *space_info, u64 flags)
 {
-
-	struct btrfs_space_info *space_info;
-	int i;
-	int ret;
-
-	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
-	if (!space_info)
-		return -ENOMEM;
-
 	space_info->fs_info = info;
-	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
 	spin_lock_init(&space_info->lock);
@@ -260,6 +252,19 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+}
+
+static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+{
+
+	struct btrfs_space_info *space_info;
+	int ret;
+
+	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
+	if (!space_info)
+		return -ENOMEM;
+
+	init_space_info(info, space_info, flags);
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-- 
2.49.0


