Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588511C74F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENKzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:55:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbfENKyt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C027BAEFF
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/8] btrfs: Streamline replace sem unlock in btrfs_dev_replace_start
Date:   Tue, 14 May 2019 13:54:42 +0300
Message-Id: <20190514105445.23051-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514105445.23051-1-nborisov@suse.com>
References: <20190514105445.23051-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are only 2 branches which goto leave label with need_unlock set
to true. Essentially need_unlock is used as a substitute for directly
calling up_write. Since the branches needing this are only 2 and their
context is not that big it's more clear to just call up_write where
required. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index fbf53e996668..61ae43308192 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -400,7 +400,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_device *tgt_device = NULL;
 	struct btrfs_device *src_device = NULL;
-	bool need_unlock;
 
 	src_device = btrfs_find_device_by_devspec(fs_info, srcdevid,
 						  srcdev_name);
@@ -432,7 +431,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
-	need_unlock = true;
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
@@ -443,6 +441,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
 		ASSERT(0);
 		ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
+		up_write(&dev_replace->rwsem);
 		goto leave;
 	}
 
@@ -471,7 +470,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	atomic64_set(&dev_replace->num_write_errors, 0);
 	atomic64_set(&dev_replace->num_uncorrectable_read_errors, 0);
 	up_write(&dev_replace->rwsem);
-	need_unlock = false;
 
 	ret = btrfs_sysfs_add_device_link(tgt_device->fs_devices, tgt_device);
 	if (ret)
@@ -483,12 +481,12 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		need_unlock = true;
 		down_write(&dev_replace->rwsem);
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
 		dev_replace->srcdev = NULL;
 		dev_replace->tgtdev = NULL;
+		up_write(&dev_replace->rwsem);
 		goto leave;
 	}
 
@@ -510,8 +508,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	return ret;
 
 leave:
-	if (need_unlock)
-		up_write(&dev_replace->rwsem);
 	btrfs_destroy_dev_replace_tgtdev(tgt_device);
 	return ret;
 }
-- 
2.17.1

