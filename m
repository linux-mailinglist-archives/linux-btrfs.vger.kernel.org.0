Return-Path: <linux-btrfs+bounces-5845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6B9105A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3731D1F26CE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDE1ACE92;
	Thu, 20 Jun 2024 13:17:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81A1E49E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889446; cv=none; b=ADGh8dmafS9cf/9slYDGaOPXC+3iJ6cMeeC7SmdJi1oaWpoON1dE4agvTOx97G0W/tygkVLpFn2YqvlTQXmheoAm14GVNPQi2mR2ntHtxO8VrFDJ59Ey+njLlrcL55gZlRBSkYAKRF1Pqtu/8710t7pNglrKl3jtEVsl/aBWbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889446; c=relaxed/simple;
	bh=a3E9T1mbQmlVrKDAVRAJmen4nvsFkqamUgimU6lB3C0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZnjGzFijbrJulVMi3b9+BzlMwHTYXkCBoWL1swcPqJcat6PVni6qQOgQx0ug024Q6AsZ4u0A2xCWQRId/QdM/uT0N5BOHIDEbKK1Nvz8CFU3Rpf0ta3DowJUucfeUVhNV4fYD2iBwNRbiR46mRu1fjEvUxXRmPpZF9e6R/lG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W4gt125GRzPrm1;
	Thu, 20 Jun 2024 21:13:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 44E621400D6;
	Thu, 20 Jun 2024 21:17:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 21:17:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] btrfs: support STATX_DIOALIGN for statx
Date: Thu, 20 Jun 2024 21:20:00 +0800
Message-ID: <20240620132000.888494-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add support for STATX_DIOALIGN for btrfs, so that direct I/O alignment
restrictions are exposed to userspace in a generic way.

[Before]
```
./statx_test /mnt/btrfs/test
statx(/mnt/btrfs/test) = 0
dio mem align:0
dio offset align:0
```

[After]
```
./statx_test /mnt/btrfs/test
statx(/mnt/btrfs/test) = 0
dio mem align:4096
dio offset align:4096
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/btrfs/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 753db965f7c0..a648e81143fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8610,6 +8610,18 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = BTRFS_I(inode)->i_otime_sec;
 	stat->btime.tv_nsec = BTRFS_I(inode)->i_otime_nsec;
+
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+		struct block_device *bdev = fs_info->fs_devices->latest_dev->bdev;
+
+		stat->result_mask |= STATX_DIOALIGN;
+		stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
+			fs_info->sectorsize);
+		stat->dio_offset_align = max_t(u32, bdev_logical_block_size(bdev),
+			fs_info->sectorsize);
+	}
+
 	if (bi_flags & BTRFS_INODE_APPEND)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (bi_flags & BTRFS_INODE_COMPRESS)
-- 
2.34.1


