Return-Path: <linux-btrfs+bounces-4008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26289B1FE
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A01281CD3
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF66134CD3;
	Sun,  7 Apr 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2P7G1PX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13A1332AD;
	Sun,  7 Apr 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495636; cv=none; b=OQ8n6ZEhgbcx3X2qQtRsGma2bN2nBIbtPcv113oie8Jd1GYkLHkuTLQARWIhezk2AFNJaUdLSqB2+pJnMI9hVkguW1sfrZZG3gGOktamxkM1JfSQUWvBzDe1wFxsED6FIQowaz7j1zweICkbELI9P97pYGV+YRosdakFLsqUb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495636; c=relaxed/simple;
	bh=j93m5rRcB0ZwVVF22P855CDkTz/uCdJAY2FUZZCWVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBiUfp4H9fPqS0lLRutIBFb7XeED7RqRaGSsAVAFFytg2nacMeIk0RtabXhfYceB8TzbxoxOoLxb8qQmyxZcj3JJqNO4/tV/sVFdgvWK8cZzMWTfiqQUtE1AqpnirFsjZgPDk46uv9yqrbVHCd6qzGgEHna67wZ3dP1DjW4d5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2P7G1PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC152C433F1;
	Sun,  7 Apr 2024 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495635;
	bh=j93m5rRcB0ZwVVF22P855CDkTz/uCdJAY2FUZZCWVP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2P7G1PXHYkmWEh7WYhWdxFck8U8poSJa0j7lRBhdAEk2AzFBx0rK3leCpm83D4xb
	 xNiOYiLGRQwff+nmkYWcL0NSI0Xd1CBzv/A/QCwJHfllXU9x29Gnkw17dZgOdjPamN
	 blcT83eB1vCi24lQV0YcjodyO37Pg0ajwY3eqU+jVXdMc+BBzOroBNm76zplmoA9t+
	 y3DAPxljh1g7VL/CaXGrFyylHhf6zr5ctS/xwv9Sw2S9JF+RotHAZhMq03wP9991Fc
	 zEk1j4iM3fMTLQmD3EgfxO0h/tRf/P1Gdv0Il7yTJS/BC4dLzfMYgpQLFJ4NSwUddJ
	 lfnlg/rBtgm1A==
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
Subject: [PATCH AUTOSEL 5.15 09/10] btrfs: return accurate error code on open failure in open_fs_devices()
Date: Sun,  7 Apr 2024 09:13:39 -0400
Message-ID: <20240407131341.1052960-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131341.1052960-1-sashal@kernel.org>
References: <20240407131341.1052960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index cc18ba50a61cf..79541c5b3d752 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1260,25 +1260,32 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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


