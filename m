Return-Path: <linux-btrfs+bounces-9060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E09A9E9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8491F2218C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297B198E65;
	Tue, 22 Oct 2024 09:35:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F338DF9;
	Tue, 22 Oct 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589717; cv=none; b=feJzNVxn4HtvM9Rf8c80CzFduAG3W6Nelfra2pALQEDt/MKOXlS7/etuIidmeC3JyUXj/kBAe6d53UCsHemAYpooi87vd9jEGL40kopuHdW108twgSz7ED3OQwHfKTCaSI8JjR4ELJTdRzdQToAhZ6jx9s8g8UbVQUBFnTx9Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589717; c=relaxed/simple;
	bh=Rp2YAPmT6eb5+b/9irGQcM/XdUNlyVMMg51kRmiKBqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q6mAjqQ5Idtzb4/Z5FdwTpbhqT9GS4zBFPluzmdUkbVwDV+i79T+h680ykwtW9qUk+2OMk2Hx25FdSKNbiIQcgcN7FYvmHWJopwEGyNY9EzwK4RHEw1bbFYD3C555z5IFXUIA3z9KuhBjT7cwbM0h9/F9nl6ovR6phiQ0vRFGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XXn6J41w6z1T8mM;
	Tue, 22 Oct 2024 17:33:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D4C5C1402CA;
	Tue, 22 Oct 2024 17:35:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 17:35:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <Johannes.Thumshirn@wdc.com>,
	<dsterba@suse.com>, <mpdesouza@suse.com>, <gniebler@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2] btrfs: Fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()
Date: Tue, 22 Oct 2024 17:52:08 +0800
Message-ID: <20241022095208.1369473-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

ret may be zero in btrfs_search_dir_index_item() and should not passed
to ERR_PTR(). Now btrfs_unlink_subvol() is the only caller to this,
reconstructed it to check ERR_PTR(-ENOENT) while ret >= 0, this fix
smatch warnings:

fs/btrfs/dir-item.c:353
 btrfs_search_dir_index_item() warn: passing zero to 'ERR_PTR'

Fixes: 9dcbe16fccbb ("btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: return ERR_PTR(-ENOENT) while ret >= 0
---
 fs/btrfs/dir-item.c | 4 ++--
 fs/btrfs/inode.c    | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index d3093eba54a5..1ea5d8fcfbf7 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -345,8 +345,8 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 			return di;
 	}
 	/* Adjust return code if the key was not found in the next leaf. */
-	if (ret > 0)
-		ret = 0;
+	if (ret >= 0)
+		ret = -ENOENT;
 
 	return ERR_PTR(ret);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index acb206d5da3b..7569c8b27f9f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4373,11 +4373,8 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
 		di = btrfs_search_dir_index_item(root, path, dir_ino, &fname.disk_name);
-		if (IS_ERR_OR_NULL(di)) {
-			if (!di)
-				ret = -ENOENT;
-			else
-				ret = PTR_ERR(di);
+		if (IS_ERR(di)) {
+			ret = PTR_ERR(di);
 			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
-- 
2.34.1


