Return-Path: <linux-btrfs+bounces-5914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6019142D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AEB1F23EEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64D2C184;
	Mon, 24 Jun 2024 06:35:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C6DDD2
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210934; cv=none; b=eDBeAwi5XSe2D2rIU4x58WkbiuGtkkQsdqpPsivi+c6mcqsR+TP8o/BtSF0+3iAOJ1cVIeDS3m+d8fAwYKMlL64xYNVEi4TvH9Pj0EOgHL+Y57YkYOxatVHLGNlnF/5MpSNkR7gLz949CJ60KIHmza5zbw/F7loSeHNGsncVdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210934; c=relaxed/simple;
	bh=WGhv23HR7t0ZT8bOlYi8osm/vM2xoAGUWW9YbkYeJLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsmmUvJk+hwQLOtyJi49sziKsoDFmDlskeQGAkhMTXw4FScfxpwe0LvUC0YNC3Dhs2d6NmJzvryBm3f9xKOHN+N2MJhQm56FrKbAuijay7pgfJSlvC4VHhcx7rbPnKr/eV+mcPvvCt0YKBIcx8Gu9UlgFnuC/ku560Kk2X7bbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W6yrZ1jcXznXJ1;
	Mon, 24 Jun 2024 14:35:26 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id 23F8018006C;
	Mon, 24 Jun 2024 14:35:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 14:35:28 +0800
From: Huang Xiaojia <huangxiaojia2@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<yuehaibing@huawei.com>
CC: <linux-btrfs@vger.kernel.org>, <huangxiaojia2@huawei.com>
Subject: [PATCH -next] btrfs: convert to use super_set_uuid to support for FS_IOC_GETFSUUID
Date: Mon, 24 Jun 2024 14:38:35 +0800
Message-ID: <20240624063835.2476169-1-huangxiaojia2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500021.china.huawei.com (7.185.36.109)

FS_IOC_GETFSUUID ioctl exposes the uuid of a filesystem. To support
the ioctl, init sb->s_uuid with super_set_uuid().

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 38cdb8875e8e..e5235dbf9016 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3369,7 +3369,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/* Update the values for the current filesystem. */
 	sb->s_blocksize = sectorsize;
 	sb->s_blocksize_bits = blksize_bits(sectorsize);
-	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
+	super_set_uuid(sb, (void *)fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
 	ret = btrfs_read_sys_array(fs_info);
-- 
2.34.1


