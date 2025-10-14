Return-Path: <linux-btrfs+bounces-17782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB7BDAF1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E793AA33A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC529A301;
	Tue, 14 Oct 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJX4gViM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9E299931
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466466; cv=none; b=BSHt6TlhMqCLQLF3wfh/MfiGLzCIl7pgMPbpuUBs4FmA/v/x0NKlTcQ56Q+ITsEGzUplmpnnJ2PgsCOdCTpcaLM08f5YON6J0W8sjZzBvMGnizHmAPtoWgjzEHjuOcObGoHZV8uOmDp2SNeFnWeya+Cu+5HY01aQ77Sf3az/wnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466466; c=relaxed/simple;
	bh=cAYlTnQpc4ie8IqO6O2sq88byDHm23lCaYA5eVEcUW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N81PhaVrp8Kt/ZoZyyKeNG1VVd5hv31ryTypwkruRmhbClRjVGgZs7T5XgjMT5VwD1BHb9BG7eoUXiPNh8+knra6uhpqt/4JEaDoOatKHdAf5+9PN1UYApo8ebtHgyz7O0FVX2G3/5pbPzXLdtBDTDiMM6IXrgZx5KQ5ekW7/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJX4gViM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5E3C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466465;
	bh=cAYlTnQpc4ie8IqO6O2sq88byDHm23lCaYA5eVEcUW0=;
	h=From:To:Subject:Date:From;
	b=fJX4gViMwA1Azr1fRzTZuRVDDJhZp/rluL9+b8728G3azHv1TUU1ejgDrWv/qYP/w
	 94+z/OGgVlyvldt/U/Qww17uJ7zGqM1zsrLH5LfrmX620V1gULmwZF1ObfDh/RotsN
	 h0PrImhTpdpwo+Xs1SFN91ddFY6YBekclXIeadIUszp4n2g2xUZ0k+WNG68vCDibA9
	 oBMRJqCJiWPb32jFGvvhGvhj6a0DJbVv2afVXxITUU1xipTCTcycg2lKS9tjvTuzlc
	 O4RI2cj8tDzONmIEpTT1KbYLL7wggpW3R7yqui8jUiqyz/pth56eS29LekAUFwFyUg
	 mNpVHOdFeI0Pw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
Date: Tue, 14 Oct 2025 19:27:43 +0100
Message-ID: <72ec649f946ae942b018b9f8b6c095a3ec722620.1760466450.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 fs/btrfs/sysfs.c      | 5 ++---
 fs/btrfs/sysfs.h      | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9ced89678953..69237f5d6078 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -274,7 +274,7 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 	sub_group->parent = parent;
 	sub_group->subgroup_id = id;
 
-	ret = btrfs_sysfs_add_space_info_type(fs_info, sub_group);
+	ret = btrfs_sysfs_add_space_info_type(sub_group);
 	if (ret) {
 		kfree(sub_group);
 		parent->sub_group[index] = NULL;
@@ -308,7 +308,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 			return ret;
 	}
 
-	ret = btrfs_sysfs_add_space_info_type(info, space_info);
+	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 81f52c1f55ce..d66681ce2b3d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1981,13 +1981,12 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
  * Create a sysfs entry for a space info type at path
  * /sys/fs/btrfs/UUID/allocation/TYPE
  */
-int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info)
+int btrfs_sysfs_add_space_info_type(struct btrfs_space_info *space_info)
 {
 	int ret;
 
 	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
-				   fs_info->space_info_kobj, "%s",
+				   space_info->fs_info->space_info_kobj, "%s",
 				   alloc_name(space_info));
 	if (ret) {
 		kobject_put(&space_info->kobj);
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 0f94ae923210..05498e5346c3 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -37,8 +37,7 @@ void __cold btrfs_exit_sysfs(void);
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
-int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info);
+int btrfs_sysfs_add_space_info_type(struct btrfs_space_info *space_info);
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
 void btrfs_sysfs_update_devid(struct btrfs_device *device);
 
-- 
2.47.2


