Return-Path: <linux-btrfs+bounces-1107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83181BC50
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97127289A9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739D58211;
	Thu, 21 Dec 2023 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XANdJFFf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1D55E73
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703177196; x=1734713196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d4Jasx1v3ugGdtGD4MQuxx8Q2u9yMUcmt4T9PWrMFmo=;
  b=XANdJFFfU3rrWvk0t1o36ghG4zu2HwjNTKTZDGrZdnL00CH/8Oraotxz
   YyubJKi4Of8MduMYA/dqBvX7Rmh6HKXOmgG0cMbT7L9Z7jpPG0zQb9PFY
   UwjH5rMmKDsdTgJXtaH6Ypx8V83AL7UDf3BRflS5Hq3pljK+jytpSiJC7
   ZxobWKIzq9S7hQ4RyLum6fOm29/meAg2AwOOqr/AOID5nsJ446PyBuzog
   h18o+Nh3PAgtGGgyLa+hBBvlqhwbcVvs4WotFR40wKXsx1FpVdG9apj5f
   jYWl2R6jDu7+yxv5T6QK7nRWPL8a0F6RMOn58QT4RI3gT+EcHDnClUmNj
   A==;
X-CSE-ConnectionGUID: iLgeYGECSainLUrJ5GqrDg==
X-CSE-MsgGUID: Y63FsrIuTmGDnQp0/m/MyQ==
X-IronPort-AV: E=Sophos;i="6.04,293,1695657600"; 
   d="scan'208";a="5605956"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2023 00:46:29 +0800
IronPort-SDR: Aid1lNpLLraOx54aNh4pkJRMYvl39ksXg7PoW+eqbNZ5zJZkIY9kW5RMewqUA1431ACQghWDpg
 8NJ/hddYwuqQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2023 07:51:31 -0800
IronPort-SDR: wrNO3xZvYN7mqmT0rv2vE99Yf1lFVwrTjzYbiUabH3Zvnik2hwOtRTIxzcne0HKuXn5oao2SAy
 09f8QJD8hKog==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2023 08:46:29 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix unbalanced unlock of mapping_tree_lock
Date: Fri, 22 Dec 2023 01:46:16 +0900
Message-ID: <8752e4df194f7c765d04a5830716e3218fb22222.1703177167.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path of btrfs_get_chunk_map() releases
fs_info->mapping_tree_lock. But, it is taken and released in
btrfs_find_chunk_map(). So, there is no need to do so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c32497311d2..d67785be2c77 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3087,7 +3087,6 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	map = btrfs_find_chunk_map(fs_info, logical, length);
 
 	if (unlikely(!map)) {
-		read_unlock(&fs_info->mapping_tree_lock);
 		btrfs_crit(fs_info,
 			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
@@ -3095,7 +3094,6 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	}
 
 	if (unlikely(map->start > logical || map->start + map->chunk_len <= logical)) {
-		read_unlock(&fs_info->mapping_tree_lock);
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, map->start,
-- 
2.43.0


