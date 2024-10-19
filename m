Return-Path: <linux-btrfs+bounces-9008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75C9A4C78
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB421F22F89
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA91DED55;
	Sat, 19 Oct 2024 09:06:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4E18DF6F;
	Sat, 19 Oct 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328811; cv=none; b=EBaf36xvRIz0u3q1py9I8bhQ/YRU8jqlVEvFQfVkJxoIBmmDwvftZNV/U+D4yMDOGkOBwOupebL3CoGI/PjBQ3JdHKwoFwFGmfswmsa8H7iWvX/05kDT5oulDBuFY993irZThm1zr5KanWPROkL9zJHZML9RMg50eNLAWb+JTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328811; c=relaxed/simple;
	bh=IotfTlG/EjPB/YRAH8pw3SksaP3QMNRc+dyUvAzjS/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6PMXJgrPy46mB0eDFXTLgSMWMytqSZ7DbioYrnxU3ztNlKPM1mTUdoxbqEQsFUw3+v9N35mLjSRK4pfURQHe6gAMjy0T7khkvWEWIKNdP6ONPqZrh/mVbgtOGfwJfkxLRdcYIZmLoNb7Hiygyqx7kvmWEFXGK0Eb4FH+TU0lPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVwdb1c6Cz1j9kZ;
	Sat, 19 Oct 2024 17:05:23 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 07DA01A0188;
	Sat, 19 Oct 2024 17:06:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Oct
 2024 17:06:40 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<mpdesouza@suse.com>, <gniebler@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH] btrfs: Fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()
Date: Sat, 19 Oct 2024 17:23:57 +0800
Message-ID: <20241019092357.212439-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Return NULL instead of passing to ERR_PTR while ret is zero, this fix
smatch warnings:

fs/btrfs/dir-item.c:353
 btrfs_search_dir_index_item() warn: passing zero to 'ERR_PTR'

Fixes: 9dcbe16fccbb ("btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 fs/btrfs/dir-item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 001c0c2f872c..cdb30ec7366a 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -350,7 +350,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 	if (ret > 0)
 		ret = 0;
 
-	return ERR_PTR(ret);
+	return ret ? ERR_PTR(ret) : NULL;
 }
 
 struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
-- 
2.34.1


