Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF43260C7F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgIHHxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:51350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgIHHxW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B706AE25
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/17] btrfs: allow RO mount of 4K sector size fs on 64K page system
Date:   Tue,  8 Sep 2020 15:52:30 +0800
Message-Id: <20200908075230.86856-18-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the basic RO mount ability for 4K sector size on 64K page
system.

Currently we only plan to support 4K and 64K page system.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 24 +++++++++++++++++++++---
 fs/btrfs/super.c   |  7 +++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5153c0420e7e..9e3938e68355 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2446,13 +2446,21 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info, "invalid sectorsize %llu", sectorsize);
 		ret = -EINVAL;
 	}
-	/* Only PAGE SIZE is supported yet */
-	if (sectorsize != PAGE_SIZE) {
+
+	/*
+	 * For 4K page size, we only support 4K sector size.
+	 * For 64K page size, we support RW for 64K sector size, and RO for
+	 * 4K sector size.
+	 */
+	if ((PAGE_SIZE == SZ_4K && sectorsize != PAGE_SIZE) ||
+	    (PAGE_SIZE == SZ_64K && (sectorsize != SZ_4K &&
+				     sectorsize != SZ_64K))) {
 		btrfs_err(fs_info,
-			"sectorsize %llu not supported yet, only support %lu",
+			"sectorsize %llu not supported yet for page size %lu",
 			sectorsize, PAGE_SIZE);
 		ret = -EINVAL;
 	}
+
 	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
 	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
@@ -3100,6 +3108,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	/* For 4K sector size support, it's only read-only yet */
+	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
+		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
+			btrfs_err(fs_info,
+				"subpage sector size only support RO yet");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 25967ecaaf0a..edc731780d64 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1922,6 +1922,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			ret = -EINVAL;
 			goto restore;
 		}
+		if (fs_info->sectorsize < PAGE_SIZE) {
+			btrfs_warn(fs_info,
+	"read-write mount is not yet allowed for sector size %u page size %lu",
+				   fs_info->sectorsize, PAGE_SIZE);
+			ret = -EINVAL;
+			goto restore;
+		}
 
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
-- 
2.28.0

