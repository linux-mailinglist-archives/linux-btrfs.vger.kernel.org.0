Return-Path: <linux-btrfs+bounces-1592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543AA83601B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2F51F22BD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A83B287;
	Mon, 22 Jan 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lfs6mLb4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0C3A8CD;
	Mon, 22 Jan 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920677; cv=none; b=pUgH5GxBwUM3rs/Ui5/zMNSgCymGVf3C3e48loaZfImHVsJv5St25lPcr3DQ6+nFu0ReQeV5SV6b8V9UHo4MuhnVCOcLrc9vCooLgqs5m4d88jKS+tKkdWnqQShYYSFIAWeUhRTjrxVZoyReuLdOkLvKeq2Mw9T4Hk6Y94+kM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920677; c=relaxed/simple;
	bh=svg98VKnZP3fRHaDjBbkju9KVDMrZOgy1g4WP5WhQD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW+h/1nXpPEX6xsag4jv/WhBLHlqaG92TxmqblvS5wy0CUfdUZYU6DLygfJk1T3heW+r0DUFF+vLTQ8EOg8N0WLPbUGP80oEAYkxWFQnc+pw4/5L0DpMQ8p3Yr/yk+UCUuKs9jnmYq0wKsl3ww49slYgmV4bcwKSE9vOzUq/7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lfs6mLb4; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705920675; x=1737456675;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=svg98VKnZP3fRHaDjBbkju9KVDMrZOgy1g4WP5WhQD8=;
  b=Lfs6mLb4NIc/zjcrtvaiG3jfqtHe6vBEs+cxB4txS4HQ1Np2BtDAexTE
   OmTzZDxy2TbDbpU31DWuuh1MXIbTTMPm3jePEm8TUcGOYfp7EB1W6W0nQ
   IGr4f4L8tt93TZbTuvGioKtdLuqPeeSwAFXnMnZm9CV+KXieycLl/V6Eo
   F/oG9S3UG5Waagfh/uDdeLlHaiGuuAB7kQ62IsiC+GX5Bn7yXqg1sWcIx
   C85PZR42Pf0vkYVPpzcwF/WGRKNSGLVvZ+v1sT0vlW5DgipdQ3+8wTzky
   1+277gGJOjFoT0+z2Hzy6Zsyc6LNCmX/DTkvKK+nvOd2JNd0R5LKIIyBk
   g==;
X-CSE-ConnectionGUID: fAln4nUlTd+41qLbaJkDGw==
X-CSE-MsgGUID: fLY4dCxFTJadzOIiXJQpDA==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7427196"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 18:51:14 +0800
IronPort-SDR: Ol0B+PAA1Xfy4fEmP4YDPQ+AyE0T1Nw4ssoKvgy9fwd7nAiCDylfiv13aGgQ7+l1j1K8QCED70
 c3TD8o/6KR1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 02:01:18 -0800
IronPort-SDR: HN3211Og+EnTAn1/uYEQkSJ5IpLy/3YoVt9P+QxZvh1hwrxvbYrIaEPgmZ3kVPmAxboLudfs7h
 T0v8FSZEZkvQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Jan 2024 02:51:13 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 22 Jan 2024 02:51:04 -0800
Subject: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
In-Reply-To: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705920670; l=1609;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=svg98VKnZP3fRHaDjBbkju9KVDMrZOgy1g4WP5WhQD8=;
 b=xWcXukl8CocPEfPTRefwvLuPkvBUrurbPRTiQsU8YMfBGpQ8agEMYORtkjbOPJVHTXE2+g1cq
 xtjSqYemPEBBX1S9tIcXZ8j9wWBY88FBT3OSNbny+hF+tbfujjBD5Km
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

On very fast but small devices, waiting for a transaction commit can be
too long of a wait in order to wake up the cleaner kthread to remove unused
and reclaimable block-groups.

Check every time we're adding back free space to a block group, if we need
to activate the cleaner kthread.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d372c7ce0e6b..2d98b9ca0e83 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -30,6 +30,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "super.h"
+#include "zoned.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
@@ -2694,6 +2695,7 @@ int __btrfs_add_free_space(struct btrfs_block_group *block_group,
 static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 					u64 bytenr, u64 size, bool used)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_space_info *sinfo = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 offset = bytenr - block_group->start;
@@ -2745,6 +2747,10 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
+	if (btrfs_zoned_should_reclaim(fs_info) &&
+	    !test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
+		wake_up_process(fs_info->cleaner_kthread);
+
 	return 0;
 }
 

-- 
2.43.0


