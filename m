Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B31F476382
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhLOUkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:20 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A51C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:19 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 8so23179300qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DiFAXI6IvBOyQ1Zght5PfvS6NLFNrSM05Fq0huFf1hI=;
        b=YUdB7tOHO0LCvzNSiZbmmWO6cyCSndpS+pqZkxrLup0ZEt+EgiEDPynDFVup6ChIH1
         sRQGnG6Pzp/yRuNx+kkccFiHot+jaLGSaO3SVfdon3tcPjUzSa7Qimc7HXHg9y/MYHQf
         y4CeNvYorhPQSO200gwq3Hprz0qbjVH4pRKB7ltLcmiXJlx3dObijAQOXaJcHcCciaaK
         s67o7f9ogsNrC2MfTaj39dKxouEkJOvlIfz+LBXwZz7mehI/a4VQY/Ftbhm8l1oYi1Mm
         Qj/PPgg0NxUjMD0+sCrcUqwNTH1CVTkmoQqj87SNsa2DywWQK/g2sdpX9uS/8w9yu+tn
         yfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiFAXI6IvBOyQ1Zght5PfvS6NLFNrSM05Fq0huFf1hI=;
        b=xSNUpUTJ8qBGJWdqrw5UiUyicAOcVKxAKdEqbAVW+ZyAUokdl6yFD3I1Oqe8qK2kXY
         bviEoIV8P8Olb8VSfrN4XWzWlWhgOt52EBVFYMBYP0vEOA8n5Agz11Wkkoo5M5LhNN/C
         Y5o818L3AfIA6L5eP8zcCEi138e3LucBnGzyMRxmQn2ieYa+S9ILXnEt5v9Oe/QKmkFc
         oAJgDBJ5JOfgnNeftAxW9qGsrhEZyw/vF41GD3hzgCxQN1HyAkqW5UCoKExu8YoCGOGR
         WDVGbUx/jyR0SohoIHM7OTjcawBR2BOywLlVnv2bqLI/pW9nusVQXlV67DvGJ/WPiyvx
         mEOA==
X-Gm-Message-State: AOAM531caLiPsZZXR1oPgOXNMYcGMWLKPT7yTpqCUxhuFwOsd8EUa9mW
        JeMqqSgq5QYo5QAh9Lt8PM5bfQLNrkWh2Q==
X-Google-Smtp-Source: ABdhPJyVfO4Ivf23jtiI530pxMpG9mephwkQVfeyTkl4XTHrhKRqc+cZmgPE4EHlUg6dnnNRkLu2gg==
X-Received: by 2002:a05:622a:181d:: with SMTP id t29mr13997294qtc.338.1639600818553;
        Wed, 15 Dec 2021 12:40:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de13sm1652619qkb.81.2021.12.15.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/11] btrfs: disable snapshot creation/deletion for extent tree v2
Date:   Wed, 15 Dec 2021 15:40:03 -0500
Message-Id: <2e64cd01ee1e1cfd77f0050fd43f3bec379a8443.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we stop tracking metadata blocks all of snapshotting will break, so
disable it until I add the snapshot root and drop tree support.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++--
 fs/btrfs/ioctl.c | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a88130c7782e..3d590a96f5d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4565,14 +4565,21 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	int err = 0;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
-	if (btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID)
+	if (btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID) {
+		if (unlikely(btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))) {
+			btrfs_err(fs_info,
+				  "extent tree v2 doesn't support snapshot deletion yet.");
+			return -EOPNOTSUPP;
+		}
 		return btrfs_delete_subvolume(dir, dentry);
+	}
 
 	trans = __unlink_start_trans(dir);
 	if (IS_ERR(trans))
@@ -4611,7 +4618,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 out:
 	btrfs_end_transaction(trans);
-	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
+	btrfs_btree_balance_dirty(fs_info);
 
 	return err;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c81f50774cec..cfcffb69d5fe 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -751,6 +751,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	int ret;
 
+	/* We do not support snapshotting right now. */
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_warn(fs_info,
+			   "extent tree v2 doesn't support snapshotting yet.");
+		return -EOPNOTSUPP;
+	}
+
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 
@@ -2901,6 +2908,13 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	int err = 0;
 	bool destroy_parent = false;
 
+	/* We don't support snapshots with extent tree v2 yet. */
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info,
+			  "extent tree v2 doesn't support snapshot deletion yet.");
+		return -EOPNOTSUPP;
+	}
+
 	if (destroy_v2) {
 		vol_args2 = memdup_user(arg, sizeof(*vol_args2));
 		if (IS_ERR(vol_args2))
-- 
2.26.3

