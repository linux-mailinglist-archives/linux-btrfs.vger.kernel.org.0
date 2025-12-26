Return-Path: <linux-btrfs+bounces-20022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1847CDEA49
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 12:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696D13008D76
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D131AF1A;
	Fri, 26 Dec 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MQU9HrVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285351DA23;
	Fri, 26 Dec 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766748642; cv=none; b=oAMHpSa+HohRPgAuH4Wt4QKHzXsLLhw4DGRDQ4SAvZXz5/TU9sliaEga3E91AYWYh9gHCDg2+0fk8PMr3d+2ZAGCxroHDFjcBdGJ7s0MlB9hgKPJYh8cxR8SzlWH/AS+E3AugEUQWTedremJCFYcofk3qBEl0yuG9fIRaBfkReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766748642; c=relaxed/simple;
	bh=Ceh7OYGnreCDHrecqJ41Fiop08pDqOUCCZlXruTXPXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGhDcXnAAVZ/NfHele9tMN6Ap4OJ7c3bp1B5tGfdDSFGM1Iw1xWsDqcXsLJ93uprP6g25Lpo1SEoOtBQUoG1+6R8BNNEhTT848GQbumYk77xY1BhiTIeVms0MQoE0cbsLZsGMtM4tQ1OsiYDpC2hJCM99qdxDNsAhwVA5h60ccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MQU9HrVN; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2eac889a7;
	Fri, 26 Dec 2025 19:30:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: clm@fb.com
Cc: dsterba@suse.com,
	sunk67188@gmail.com,
	dan.carpenter@linaro.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
Date: Fri, 26 Dec 2025 11:30:22 +0000
Message-Id: <20251226113022.1883689-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b5a6cc01103a1kunmed2322233a275
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSExLVklOGU0dHR9MTEhDSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MQU9HrVNga5VKfUZSUGFIeP0oIsWT9yIlVZjIJERVzHvZOqq8XMJ6PFSdEJDRAfDeeXxrOMniq0rrMCevz4ilHM4ro4zdb4AahtOeSmPTXAHOdNC+4kxNQnbTvr4cDp/Ry/r5GuJ3EdPb0JRzyD+UE6H5xbZlL11UfqH9xlVJS0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Q4rzzonnCWkpmrqDf9w60ghPmmHzyIO6n0HAj6Xw8Qk=;
	h=date:mime-version:subject:message-id:from;

If btrfs_insert_fs_root() fails, the tmp_root allocated by
btrfs_alloc_dummy_root() is leaked because its initial reference count
is not decremented.

Fix this by calling btrfs_put_root() unconditionally after
btrfs_insert_fs_root(). This ensures the local reference is always
dropped.

Also fix a copy-paste error in the error message where the subvolume
root insertion failure was incorrectly logged as "fs root".

Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Reword commit message to be more concise.
- Fix copy-paste error in the error message.
- Add Co-developed-by and Signed-off-by tag.
---
 fs/btrfs/tests/qgroup-tests.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index e9124605974b..0fcc31beeffe 100644
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
-		test_err("couldn't insert fs root %d", ret);
+		test_err("couldn't insert subvolume root %d", ret);
 		goto out;
 	}
-	btrfs_put_root(tmp_root);
 
 	test_msg("running qgroup tests");
 	ret = test_no_shared_qgroup(root, sectorsize, nodesize);
-- 
2.34.1


