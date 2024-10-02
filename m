Return-Path: <linux-btrfs+bounces-8431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9998DA56
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F2AB218B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F21D2F42;
	Wed,  2 Oct 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asvWEC2c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF21D2B2B
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878511; cv=none; b=rzgPGJEa2Y0qA0scgw0C9d4K3XNje8Kw6d/Qes7WDg3RznghgD0ZUddC58GXbLucW98fLK4twG1rPtvVINQ8sYNl9KlWGqHqpjGDwNQ0b7ymBGDL3EdHn/9NkYIwAwE0BgCj3hYTKK7XMQiJRnH5ck35kdGf51EnLcFKHV1Ia4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878511; c=relaxed/simple;
	bh=qnR3YAJxhfACK1No9nX520PCKhiEQB3RVG/bFlJ60TM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nPrDcJBZdMUYB686tdzFiGDcP7HomBWBO+E4xAEcmAOW+Q6lZ6NCMc71vutCvJ5QEMkPz58INJrRWKTFQCP54oBgeVRgaspHoebR/Sn33NuG2kGHORiYk0xE9DqHYNK566A5IzNk1AzHO/95JyUx6gv61IGOe6Kz/Po3WDYAji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asvWEC2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CACCC4CEC2
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727878510;
	bh=qnR3YAJxhfACK1No9nX520PCKhiEQB3RVG/bFlJ60TM=;
	h=From:To:Subject:Date:From;
	b=asvWEC2cfFSCiGM5A4vNIIyH/vDEuQc5bolXtvsJlDPArDk77ec6cLi8G1PvAtFMj
	 Oh7NTfWiuS0ehAhZiWPfWzwnD3ZH+RzjlBF/jfvUXDlpDkZlD1QOtGY7oF7NhEReNv
	 vgVImv7ZVw2mOkOUT3jjQm8CXIgHwdwyjcNc7N10VNvfClMems4q8zK4PXxW/fHKFf
	 wAdLTYfgJa+sQh8O0cBZintYvGyiJP/kgpUidhCiWleWdN5X2tEwk5nCKdvhOQw657
	 uANsULnIowP0xvmZLomLgICWX1kBv7V6mTcoc3+wszjP3a4esvr9w7GPHz4L5NWLfK
	 Isb3kSPUmAEIA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix missing rcu locking in error message when loading zone info
Date: Wed,  2 Oct 2024 15:15:07 +0100
Message-Id: <446a65bde464d5a19554687ffd1944bfbf9062ae.1727878321.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_load_zone_info() we have an error path that is dereferecing the
name of a device which is a RCU string but we are not holding a RCU read
lock, which is incorrect.

Fix this by using btrfs_err_in_rcu() instead of btrfs_err().

The problem is there since commit 08e11a3db098 ("btrfs: zoned: load zone's
allocation offset"), back then at btrfs_load_block_group_zone_info() but
then later on that code was factored out into the helper
btrfs_load_zone_info() by commit 09a46725cc84 ("btrfs: zoned: factor out
per-zone logic from btrfs_load_block_group_zone_info").

Fixes: 08e11a3db098 ("btrfs: zoned: load zone's allocation offset")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 00a016691d8e..dbcbf754d284 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1340,7 +1340,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	switch (zone.cond) {
 	case BLK_ZONE_COND_OFFLINE:
 	case BLK_ZONE_COND_READONLY:
-		btrfs_err(fs_info,
+		btrfs_err_in_rcu(fs_info,
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
 			  (info->physical >> device->zone_info->zone_size_shift),
 			  rcu_str_deref(device->name), device->devid);
-- 
2.43.0


