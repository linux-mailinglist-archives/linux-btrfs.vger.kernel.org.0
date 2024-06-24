Return-Path: <linux-btrfs+bounces-5915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD949142EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1617C284B8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1ED44C68;
	Mon, 24 Jun 2024 06:39:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026353EA7B
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211162; cv=none; b=puhxtL7lnV1WkUNDdasRHwst23ky6zhGQetrKtegUc8EX6oMKo/HrZilOeBJZs9/p2b1fYK5xv/ojTkednQfgb4m2XV4MPQ9QaxiqFkI2ohHmDJT0MG1EQwGan1uOpJyT/ISSSjfzk1DXe2Uc/D7HMSWT8j68+xxRVXLIGHa3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211162; c=relaxed/simple;
	bh=bWYhAeM3Wuay6WD2y6NrB0Qc3BsOCJUFxzC701jUOjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxVlwanEMs121A2Smo1Mw9RzmKoFxLzwjYHmH+9yijSpDpEv+AByXl5e3qTjNQf9By11BhTnU4AwhYNHp1AbWzyqXcdPo7jLs4WY1HdOXziVXYfQCFZYpvHSmquPQM+Bh2CIGoAsAfHgNLAUGWTwVs1LCsxcUqSZNx6iPpmMzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W6yrL0vzwz2CkXT;
	Mon, 24 Jun 2024 14:35:14 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id 355DE1A0188;
	Mon, 24 Jun 2024 14:39:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 14:39:11 +0800
From: Huang Xiaojia <huangxiaojia2@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<yuehaibing@huawei.com>
CC: <linux-btrfs@vger.kernel.org>, <huangxiaojia2@huawei.com>
Subject: [PATCH -next] btrfs: add support for FS_IOC_GETFSSYSFSPATH
Date: Mon, 24 Jun 2024 14:42:18 +0800
Message-ID: <20240624064218.2476312-1-huangxiaojia2@huawei.com>
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
 dggpemm500021.china.huawei.com (7.185.36.109)

FS_IOC_GETFSSYSFSPATH ioctl exposes /sys/fs path of a given filesystem,
potentially standarizing sysfs reporting. This patch add support for
FS_IOC_GETFSSYSFSPATH for btrfs, "btrfs/<uuid>" will be outpt.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f05cce7c8b8d..9372166cdb8c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -963,6 +963,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	}
 
 	sb->s_flags |= SB_ACTIVE;
+	super_set_sysfs_name_uuid(sb);
 	return 0;
 
 fail_close:
-- 
2.34.1


