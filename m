Return-Path: <linux-btrfs+bounces-9988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5099DF51F
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BF11613F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788313AA2D;
	Sun,  1 Dec 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAaUhQby"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A67641E
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045773; cv=none; b=reyFaEvDiAfxZp7K0BGgl4rLmh9IF/iQhwWwAuX2vdoDRzjwVwO1iBGLRKVAELG9yYZA6x/fNbbLiGy36Ua3aPF0zvlLIm3PauvoZZrFG/O+HfRxhEJlDxglHNgo3WsBIDyP8QmeZg8qOeKO/k1N0DG0Z8hf/LYwrqdfkqsA/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045773; c=relaxed/simple;
	bh=ACdJRYtvT54h2D5uwzZyukQ5TybF5LCQCuBGDaRqadA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Spe1MGE+Z3o7LAz95p1+M6iK6oBT0vlE4EKUQxu9p3f3nHggzTUW3kBgS8jhLqo0WKpdR+4ni8Ga/nXndtNL4cu4UOjjWUGtQnHEFiMbYiHMLokqpt8HVsBL6MUYDowluO0LVjaRZC31dgQsErqKxaNA97cs4mFa4o1Stg/Lhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAaUhQby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AB3C4CECF;
	Sun,  1 Dec 2024 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733045773;
	bh=ACdJRYtvT54h2D5uwzZyukQ5TybF5LCQCuBGDaRqadA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAaUhQbyVifk1SBtkY9VPE6CiF86oFUu3ILFofqve0zuXvyPFSpxs87/dYon8sHba
	 16w47wSn3MyKD0meaKvzancjOXGjqRysx9lEUPiKrCkf6WJy2nUXu/kxKgPaUUlz0M
	 NufCm3Com12YqJi7yD99lTMMiBXVJral7WXK89aUI47qggUfw/nDbxjJFXu1/JYXIx
	 eZ2KPaK+fQyM94xKtPigLZsxsULRjs7Dt9LxaXgs4KYp75a/ecVX/xamnwb6zuzSQK
	 zpoZiMvzgQ39ZNQBLKrkzmswzlkiIR5IaPHa98dKzMQoelqNrR33t25VBTMDel4Ivo
	 KTltt0x7hA0ng==
From: Zorro Lang <zlang@kernel.org>
To: ltp@lists.linux.it
Cc: linux-btrfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option for xfs
Date: Sun,  1 Dec 2024 17:36:05 +0800
Message-ID: <20241201093606.68993-3-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
References: <20241201093606.68993-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all filesystems use "-b 1024" to set its blocksize. XFS uses
"-b size=1024", so this test fails as "unknown option -b 1024" on
xfs.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 testcases/kernel/syscalls/lstat/lstat03.c | 8 ++++++--
 testcases/kernel/syscalls/stat/stat04.c   | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index d48af180b..675fb56f4 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -44,8 +44,9 @@ static void run(void)
 
 static void setup(void)
 {
+	char *opt_name="-b";
 	char opt_bsize[32];
-	const char *const fs_opts[] = {opt_bsize, NULL};
+	const char *const fs_opts[] = {opt_name, opt_bsize, NULL};
 	struct stat sb;
 	int pagesize;
 	int fd;
@@ -54,7 +55,10 @@ static void setup(void)
 	SAFE_STAT(".", &sb);
 	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
 
-	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
+	if (strcmp(tst_device->fs_type, "xfs") == 0)
+		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else
+		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
 
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 05ace606a..2a17cc7d7 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -43,8 +43,9 @@ static void run(void)
 
 static void setup(void)
 {
+	char *opt_name="-b";
 	char opt_bsize[32];
-	const char *const fs_opts[] = {opt_bsize, NULL};
+	const char *const fs_opts[] = {opt_name, opt_bsize, NULL};
 	struct stat sb;
 	int pagesize;
 	int fd;
@@ -56,7 +57,10 @@ static void setup(void)
 	SAFE_STAT(".", &sb);
 	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
 
-	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
+	if (strcmp(tst_device->fs_type, "xfs") == 0)
+		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else
+		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
 
-- 
2.45.2


