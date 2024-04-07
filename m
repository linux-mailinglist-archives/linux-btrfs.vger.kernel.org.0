Return-Path: <linux-btrfs+bounces-4009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D489B219
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640122840A6
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907D1384A1;
	Sun,  7 Apr 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9MdbC5B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1E137C55;
	Sun,  7 Apr 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495651; cv=none; b=twcTwkgzGpiBvyrG4vcn/40GkUKDnsWlDbHjBfLbFU/+0SaK+Ph6DRejh9/5xuZpatRTx0pv+Supn4A3Pnvmke9W/AV2OBHBQlcjMyLtZyEsbXagcffWtRZL6KpqHKI/qoBFb1oLbBXSA2GcA28e4iejZZPcJIAz/QaFVYSiV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495651; c=relaxed/simple;
	bh=6IGRAIkx6sTt8QDn1ULJSvLLda/JkS1Z/ciXg+v+cYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGgPGWyt38NrqH9lL/MRKR9bLdZWUmB4FXHI1872a9OadOIJ3LQUx90Gd2GttDMvPsQcIb/7i+oWNHnHwR8vBezy7wwQ5wzYzO8jE62DMv0sN7PnUog1opQTjJq5kAL7zsZn8R1vB1UmHLbj8Sh28opQrB5+Mg9xrZ7aHNy3Llw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9MdbC5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A5C43390;
	Sun,  7 Apr 2024 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495651;
	bh=6IGRAIkx6sTt8QDn1ULJSvLLda/JkS1Z/ciXg+v+cYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9MdbC5BWRum3GU1LWmB8vA5oo9bTjw7Kjrjxz5xyACqcyA4ohmfV5re/RGvAcJPD
	 a3kBcyYX3DBnry1U7yjs0suMOXZ1b6Yb25CwUt9G/cx5uVEXI+hYhs/reoaveOqypu
	 kyB2jMZGzbkfspVDgMsneJM7OZopKnbeRwGWWEEgZuRUCcL2f6U7njJ3gPduIuNyIA
	 FeK2stxNgTMey6FFL1D3JG7qshpbgABsNfMqwtvVAODai71ZldTnLLKc7bVIBlN+SL
	 DIVRC7Xm4BlzSsmpDV7Z1pzUgh6cZZ+7QBFAJtllsVG3iZKofXZFcvJ0rJmmQKnllT
	 dWg30Xrushlxw==
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
Subject: [PATCH AUTOSEL 5.10 7/7] btrfs: return accurate error code on open failure in open_fs_devices()
Date: Sun,  7 Apr 2024 09:13:58 -0400
Message-ID: <20240407131400.1053377-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131400.1053377-1-sashal@kernel.org>
References: <20240407131400.1053377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index eaf5cd043dace..7e77f81e297f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1266,25 +1266,32 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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
 	fs_devices->latest_bdev = latest_dev->bdev;
-- 
2.43.0


