Return-Path: <linux-btrfs+bounces-4006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F364389B1AB
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C9B281A9C
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629485642;
	Sun,  7 Apr 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpUax+gb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D58529C;
	Sun,  7 Apr 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495581; cv=none; b=CCFnk2vLGbBzI3gPn2rLePiLaj4LM3xCGasKtX5nLXsnjF10z/RnCHAKDMLSg2L1C7nkn8jK7cSJ4jvPAKrFkJqimIRB3Wd62fEslTl4Q6PWIzSvhNThapQOczGJ/yHI2fl5T1jwyuNlTywZ6JQbUKHX6me3lJmuRZxFD/4H7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495581; c=relaxed/simple;
	bh=L9ENyd2I71695lQvM2cmvdJaIXid+JjaQbxTMvs0VuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvQ0OfK/YfB6eaDsinJRmiGW68O4wbk1vnMdP9FdZcG0nKRsoh25LU1uqJr+CO/TV6SUJfpivHECVGHisXbbmvonFCt4pqUCDEOeiMwssSoBYsIKiHR7fXATnnDJTL+wln/yVVl70FDCeISgAU6BitsZhx0CqJBUQAoR/d03xBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpUax+gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1207AC433F1;
	Sun,  7 Apr 2024 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495581;
	bh=L9ENyd2I71695lQvM2cmvdJaIXid+JjaQbxTMvs0VuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpUax+gbTLbqOfoD+A48P/ISd7PJImWR2NVM4POG1yKJ62mUgvpjN3FXY5gamASz2
	 JDuyJlF1J2+gfFWcxQXNVGGXKViQOrXW83x2UhmPLdWv9Af3Yp/zpRwiaqhcWXqw/Y
	 voobgxD+zB3EE8hFX03qYRftZxFlRYf/KvUeJPYy71yLuEYLxyYIMprx44A3IL8RwK
	 6rFAJIO7LfbYFo407xEb1HKRHdDdq6aUby6le76sqG1Et+lWQk3px550qMhgwq313S
	 N3sMgNpJbGzmClrFQLVycD/hYwKeq1hCkt1E5d7sgJZefd7EJ0c9PzgfnFR8sQYcvk
	 EuArQ4c8YMVag==
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
Subject: [PATCH AUTOSEL 6.6 17/22] btrfs: return accurate error code on open failure in open_fs_devices()
Date: Sun,  7 Apr 2024 09:12:16 -0400
Message-ID: <20240407131231.1051652-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index 722a1dde75636..0bf08672caaa2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1224,23 +1224,30 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	int ret = 0;
 
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


