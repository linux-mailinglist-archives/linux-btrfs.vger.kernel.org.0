Return-Path: <linux-btrfs+bounces-19999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44504CDDAA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53DA13013ED5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02F31A554;
	Thu, 25 Dec 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BC89Zrp9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536C2F49F0;
	Thu, 25 Dec 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658457; cv=none; b=VdKEY1oCl/S3PT6GzPifZi6EuAt9UwVBXgqBo8N0u6RgKNoka8K/9TVvq7h/CSY+QRLXeMG8AbaZ3HkAlnNpA98Czt7Ck5Xx84ZajuDV6aUGKer81PaH1aXKt3BxFSBF3ayVpsiJdO8dXaHsI5IOBgrYff8lfAhX3vQI9EggOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658457; c=relaxed/simple;
	bh=kcxm1mHC2AHWepF9LVrufs5Vd2CCt+oDM36bSQRdspU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rk0OTZlYok406VvmlnVAT/nqgYDzf37UHOoDWIk13ic+3TzctCR/JILFZejp5WZNAE8i3l64mtQZwkNGVdO+iejJl4ML2YzekCNC9p7Jah7dPBa/CIw+j6EGSxYuuGjQ3xEMR1KpSc2RoggIFkPIUen8BB8jWbMv/fZhe1zA5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BC89Zrp9; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e8b969cf;
	Thu, 25 Dec 2025 18:27:29 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: clm@fb.com
Cc: dsterba@suse.com,
	sunk67188@gmail.com,
	dan.carpenter@linaro.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
Date: Thu, 25 Dec 2025 10:27:27 +0000
Message-Id: <20251225102727.967360-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b550ca04403a1kunm3d3657943c873
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ05OVk1CSEpNSB1JSUseTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=BC89Zrp9QQRDw2fh648sIke0ofJxDAJK/j/N618/kAJyWPSi5x/0q1dsPosTmIGa8+miHrUofVzaX2/eyErOhZIAdwm0VMtC4nDhekEYcVna9mGv1E3ddRMDYPYVY4MBthm/H20LF0SHsZR80wB41xa54d9ciKo8tiFwjW1/46c=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xMumdwLGnzfooVex7fPc5gc9CljbwqfTQRSpLl35PKU=;
	h=date:mime-version:subject:message-id:from;

btrfs_alloc_dummy_root() allocates a root with a reference count of 1.
Then btrfs_insert_fs_root() is used to insert the root into the fs_info.
On success, it increments the reference count. On failure, it does not.

Currently, if btrfs_insert_fs_root() fails, the error handling path
jumps to the out label immediately without decrementing the reference
count of tmp_root, leading to a memory leak.

Fix this by calling btrfs_put_root() unconditionally after
btrfs_insert_fs_root(). This correctly handles both cases: on success,
it drops the local reference, leaving the root with the reference held
by fs_info; on failure, it drops the sole reference, freeing the root.

Fixes: 4785e24fa5d23 ("btrfs: don't take an extra root ref at allocation time")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/btrfs/tests/qgroup-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index e9124605974b..0d51e0abaeac 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -517,11 +517,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	tmp_root->root_key.objectid = BTRFS_FS_TREE_OBJECTID;
 	root->fs_info->fs_root = tmp_root;
 	ret = btrfs_insert_fs_root(root->fs_info, tmp_root);
+	btrfs_put_root(tmp_root);
 	if (ret) {
 		test_err("couldn't insert fs root %d", ret);
 		goto out;
 	}
-	btrfs_put_root(tmp_root);
 
 	tmp_root = btrfs_alloc_dummy_root(fs_info);
 	if (IS_ERR(tmp_root)) {
@@ -532,11 +532,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 
 	tmp_root->root_key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	ret = btrfs_insert_fs_root(root->fs_info, tmp_root);
+	btrfs_put_root(tmp_root);
 	if (ret) {
 		test_err("couldn't insert fs root %d", ret);
 		goto out;
 	}
-	btrfs_put_root(tmp_root);
 
 	test_msg("running qgroup tests");
 	ret = test_no_shared_qgroup(root, sectorsize, nodesize);
-- 
2.34.1


