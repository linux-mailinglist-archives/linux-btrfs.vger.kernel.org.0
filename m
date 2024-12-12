Return-Path: <linux-btrfs+bounces-10322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8B9EECC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 16:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24B7188D9E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0737B2210CA;
	Thu, 12 Dec 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6ip5Lka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBD215777;
	Thu, 12 Dec 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017743; cv=none; b=gH9pv2UXy0jxdxhaKRQmvHcxTPCdUH4zeGz17bArXLFSLX61lYSfMQwyvKh0sRNFUtudhEKTHYRCGC1urbavtLvrHcPRP72tNJUF8N4/4SE4CXfeu46erClyzaqij2P/xbP4HWv02EP1wfGZc95/GDwGHjZTLxQmyMuXLOZVWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017743; c=relaxed/simple;
	bh=VCpk62H4VbAhHhwZtpGTBvb/rbh+wNsp2/F+2mEY1yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2BbU0CVIrgtphS/VvChygudWFEsjmH97zWbqt0KfoDnhP7SP8whsDEDbYedRqMGyHtbQjue/KytVFlpBQqXpCnmDstSO1Y9OMKzCOdC3QrcqKbfrI6vyTIKoYmbrefKYwTJruRt/AE+b+rtP045gy7bqIxqSYEqZvvG0XDjDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6ip5Lka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD74C4CED4;
	Thu, 12 Dec 2024 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017742;
	bh=VCpk62H4VbAhHhwZtpGTBvb/rbh+wNsp2/F+2mEY1yU=;
	h=From:To:Cc:Subject:Date:From;
	b=R6ip5Lka2Ajx96edBkDqxBnakjGyoY+ZJ1LYlhNmvpSBR/0eQmIXGE3H1VO3YmJP1
	 cTeewKDfaCjPEBtm7HxleL0Wjm4k/IcjrwL6tfXovOz0jb183BoG5oKKRqHuQ0arHp
	 fe39dDdA8e4ewOUTN6RkbKMBQUgp+BpbOWdwu2oA0nLGGE4ieLDybVd6HP2SAT17kF
	 8YfwgHsqG94G3cmJJ63h4OwEJExJjhr0Gz/H0qaqXEXBhahRdETIocSzvfBQe9T77f
	 QixRQGW5EUxEYczyDeRs+GxyXZhINV43ZVKMPz+O/8Wz7irMkGbRO6yR26nhvPyZdC
	 /+YZSK/+XnFxg==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Boris Burkov <boris@bur.io>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix stack size warning in btrfs_test_delayed_refs()
Date: Thu, 12 Dec 2024 16:35:32 +0100
Message-Id: <20241212153539.1192900-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added code has a btrfs_transaction structure on the stack,
which makes it somewhat too large for 32-bit kernels:

fs/btrfs/tests/delayed-refs-tests.c: In function 'btrfs_test_delayed_refs':
fs/btrfs/tests/delayed-refs-tests.c:1012:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
 1012 | }
      | ^

Change this to a dynamic allocation instead.

Fixes: fa3dda44871b ("btrfs: selftests: add delayed ref self test cases")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/tests/delayed-refs-tests.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
index 9b469791c20a..86333521b94a 100644
--- a/fs/btrfs/tests/delayed-refs-tests.c
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -978,7 +978,6 @@ static int select_delayed_refs_test(struct btrfs_trans_handle *trans)
 
 int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 {
-	struct btrfs_transaction transaction;
 	struct btrfs_trans_handle trans;
 	struct btrfs_fs_info *fs_info;
 	int ret;
@@ -991,8 +990,10 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 		return -ENOMEM;
 	}
 	btrfs_init_dummy_trans(&trans, fs_info);
-	btrfs_init_dummy_transaction(&transaction, fs_info);
-	trans.transaction = &transaction;
+	trans.transaction = kmalloc(sizeof(*trans.transaction), GFP_KERNEL);
+	if (!trans.transaction)
+		goto out;
+	btrfs_init_dummy_transaction(trans.transaction, fs_info);
 
 	ret = simple_tests(&trans);
 	if (!ret) {
@@ -1007,6 +1008,8 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 
 	if (!ret)
 		ret = select_delayed_refs_test(&trans);
+	kfree(trans.transaction);
+out:
 	btrfs_free_dummy_fs_info(fs_info);
 	return ret;
 }
-- 
2.39.5


