Return-Path: <linux-btrfs+bounces-4007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6989B1DB
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242D21F211EE
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3110212FF7C;
	Sun,  7 Apr 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOztTaYb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D512FB3C;
	Sun,  7 Apr 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495615; cv=none; b=t8F3hDi9Bher+oxVmkVxDS8umFFxgUebhTZAZQ6H7YY5KnQa/fwJ/7uPsjPHBeMVH51xNH9UEhdWtnoZT0fi8onS1gV+ZeP0B3dXxZK190uooLUYX8BM0Yu9wOUMFSUKO9z6Z9SJnBQOirK2cubqX3khPzRt7JXhSFmsuMUONX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495615; c=relaxed/simple;
	bh=l3LLm6PiuBl9fYukzhmGZIc8CCpsaX4qL55yeK5J/YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf4cRJlk9bpoI2i0HJiLNsm17CbDxjLVFi3NlskSiDL1yNue8hRZmrGcOpbSPRBRAuqHbcXAaSr/0oEaYllN97S2k6VelvSg+3+ZqUPoewQxErV1nyzO8WuB8en06TL3YzfGlPsfLYwFhz4MO78BYobNwR2DNfQbuC0OO9odaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOztTaYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F3C433C7;
	Sun,  7 Apr 2024 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495615;
	bh=l3LLm6PiuBl9fYukzhmGZIc8CCpsaX4qL55yeK5J/YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOztTaYbeU0YOj2eG4JdBOT+ms9VYt2/R4iWpPVxsOAxH3pLZaw3ZkiUjCw42v8kW
	 Q84mZCwJ/IfGxQAjocjxNf8s8iRnqa8Y6rrXtj9KDg7eNAEd3nq1XpIcBuJMizE2/K
	 Z7NAH/VrmF7AxAFLuvWY+JbAf3JbRsy75EMuQ0zN5FbiatHbIOG+2UwwQVIrVz9tmR
	 5JC6+WBlEyYYXLbksIiBtJ8uTasjhFvzB0ouM8G12WKHSJq9AlFdlYHgDzrsY7ySfj
	 cQ3mwNZBq9vdjkvJR9Ihu97iieBW/kmq8z/yYam5M3JgIJGxCMx3J6y4aOU+uxEXC9
	 sptYFZm0EowMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/13] btrfs: return accurate error code on open failure in open_fs_devices()
Date: Sun,  7 Apr 2024 09:13:10 -0400
Message-ID: <20240407131316.1052393-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 2f1aeab9fca1a5f583be1add175d1ee95c213cfa ]

When attempting to exclusive open a device which has no exclusive open
permission, such as a physical device associated with the flakey dm
device, the open operation will fail, resulting in a mount failure.

In this particular scenario, we erroneously return -EINVAL instead of the
correct error code provided by the bdev_open_by_path() function, which is
-EBUSY.

Fix this, by returning error code from the bdev_open_by_path() function.
With this correction, the mount error message will align with that of
ext4 and xfs.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6fc2d99270c18..a9b44755fc6f0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1233,25 +1233,32 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	int ret = 0;
 
 	flags |= FMODE_EXCL;
 
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
-		int ret;
+		int ret2;
 
-		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
-		if (ret == 0 &&
+		ret2 = btrfs_open_one_device(fs_devices, device, flags, holder);
+		if (ret2 == 0 &&
 		    (!latest_dev || device->generation > latest_dev->generation)) {
 			latest_dev = device;
-		} else if (ret == -ENODATA) {
+		} else if (ret2 == -ENODATA) {
 			fs_devices->num_devices--;
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
 		}
+		if (ret == 0 && ret2 != 0)
+			ret = ret2;
 	}
-	if (fs_devices->open_devices == 0)
+
+	if (fs_devices->open_devices == 0) {
+		if (ret)
+			return ret;
 		return -EINVAL;
+	}
 
 	fs_devices->opened = 1;
 	fs_devices->latest_dev = latest_dev;
-- 
2.43.0


