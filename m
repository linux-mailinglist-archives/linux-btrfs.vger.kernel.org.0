Return-Path: <linux-btrfs+bounces-15171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A1AEFE91
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30591736E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66627B4F7;
	Tue,  1 Jul 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMXuASL/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FA27935C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384550; cv=none; b=XNc7DsPC9xdHzEspt35QlfV7u6ZuhmMwdwFYZ+sU5ACzengIAB3XD7IbxnYtCo1KX0wIXIiJb7ecjntgCC2395sG44gSwISU/HtwRzbHikzCRn0aW7047lrvH1h5m4ffr3uyEcFeJYFfAf6WZzp6+YQeqgtqfjTai0zq4tIfhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384550; c=relaxed/simple;
	bh=HT2RUBEBmON0PeW8K0u2p991r22+YdtDW4QCxgBY2ho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8QAIHtz1zSxyZK3aUKoIaSIG1aDWBR4gbw4/qkgWDVCZa1bAptFBSdCVEEGOkv0fEiBWlkmHCE9+n2eu/4GWZtHOLPNx3cI8b7XjcfneF8oOlZ+foE+wXCmOQhWtDm99NO6xoImNiebff8tFTIL+fbeexJ1HlHvd0Vg83K1eA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMXuASL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668DBC4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384550;
	bh=HT2RUBEBmON0PeW8K0u2p991r22+YdtDW4QCxgBY2ho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DMXuASL/A6wQhfSKZ49skh/8q4ukMdSqbRO6z1+Cbh6HERPwhqtaxt0keJqRPX4GG
	 +xE5YXg7vAAkL25dCGsEFK/i89FESDdNKC/Z3vxpzGOlahsYmhB6/OocymFDwYCAIY
	 6KBu923EMZx9CvEyk/x0oxUoQKFeg9YGyKTlPhNJZTYjDRomGcUZ1ZN6khdBIGZYPK
	 xRbzdcX1qlhuIthHvfOjpBmf7Y3UbP8vkSKNGvMdUrQymKwdmYorJsBw9EsGyt9o68
	 F/pgabpl+qEXP9MWn43VwOUh/kIA8pQueDEuoyarxy7bDCN0wLZHAQ4EMudXR3NnjV
	 7q9Nlooh0IHQw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: qgroup: use btrfs_qgroup_enabled() in ioctls
Date: Tue,  1 Jul 2025 16:42:22 +0100
Message-ID: <3fe4cd28b0cf16c62d2574868fd085086c9a7319.1751383079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751383079.git.fdmanana@suse.com>
References: <cover.1751383079.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a publicly exported btrfs_qgroup_enabled() and an ioctl.c private
qgroup_enabled() helper. Both of these test if qgroups are enabled, the
first check if the flag BTRFS_FS_QUOTA_ENABLED is set in fs_info->flags
while the second checks if fs_info->quota_root is not NULL while holding
the mutex fs_info->qgroup_ioctl_lock.

We can get away with the private ioctl.c:qgroup_enabled(), as all entry
points into the qgroup code check if fs_info->quota_root is NULL or not
while holding the mutex fs_info->qgroup_ioctl_lock, and returning the
error -ENOTCONN in case it's NULL.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3621ed2eacd1..3c4619375bc9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3714,22 +3714,6 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 	return ret;
 }
 
-/*
- * Quick check for ioctl handlers if quotas are enabled. Proper locking must be
- * done before any operations.
- */
-static bool qgroup_enabled(struct btrfs_fs_info *fs_info)
-{
-	bool ret = true;
-
-	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!fs_info->quota_root)
-		ret = false;
-	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-
-	return ret;
-}
-
 static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -3744,7 +3728,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!qgroup_enabled(root->fs_info))
+	if (!btrfs_qgroup_enabled(fs_info))
 		return -ENOTCONN;
 
 	ret = mnt_want_write_file(file);
@@ -3814,7 +3798,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!qgroup_enabled(root->fs_info))
+	if (!btrfs_qgroup_enabled(root->fs_info))
 		return -ENOTCONN;
 
 	ret = mnt_want_write_file(file);
@@ -3873,7 +3857,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!qgroup_enabled(root->fs_info))
+	if (!btrfs_qgroup_enabled(root->fs_info))
 		return -ENOTCONN;
 
 	ret = mnt_want_write_file(file);
@@ -3921,7 +3905,7 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!qgroup_enabled(fs_info))
+	if (!btrfs_qgroup_enabled(fs_info))
 		return -ENOTCONN;
 
 	ret = mnt_want_write_file(file);
-- 
2.47.2


