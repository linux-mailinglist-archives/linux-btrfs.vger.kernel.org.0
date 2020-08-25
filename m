Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFB251BC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHYPCr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 11:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgHYPCp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 11:02:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8314EADDB;
        Tue, 25 Aug 2020 15:03:14 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: export currently executing exclusive operation via sysfs
Date:   Tue, 25 Aug 2020 10:02:33 -0500
Message-Id: <20200825150233.30294-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825150233.30294-1-rgoldwyn@suse.de>
References: <20200825150233.30294-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

/sys/fs/<fsid>/exclusive_operation contains the currently executing
exclusive operation. Add a sysfs_notify() when operation end, so
userspace can be notified of exclusive operation is finished.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c |  2 ++
 fs/btrfs/sysfs.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 256e58d42a7b..97ce65c7a631 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -387,6 +387,8 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info, int type)
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 {
 	atomic_set(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL,
+			"exclusive_operation");
 }
 
 /*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8593086d1d10..a301cf74336d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -809,6 +809,30 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
+static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
+		struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	switch (atomic_read(&fs_info->exclusive_operation)) {
+		case  BTRFS_EXCLOP_NONE:
+			return scnprintf(buf, PAGE_SIZE, "none\n");
+		case BTRFS_EXCLOP_BALANCE:
+			return scnprintf(buf, PAGE_SIZE, "balance\n");
+		case BTRFS_EXCLOP_DEV_ADD:
+			return scnprintf(buf, PAGE_SIZE, "device add\n");
+		case BTRFS_EXCLOP_DEV_REPLACE:
+			return scnprintf(buf, PAGE_SIZE, "device replace\n");
+		case BTRFS_EXCLOP_DEV_REMOVE:
+			return scnprintf(buf, PAGE_SIZE, "device remove\n");
+		case BTRFS_EXCLOP_SWAP_ACTIVATE:
+			return scnprintf(buf, PAGE_SIZE, "swap activate\n");
+		case BTRFS_EXCLOP_RESIZE:
+			return scnprintf(buf, PAGE_SIZE, "resize\n");
+	}
+	return 0;
+}
+BTRFS_ATTR(, exclusive_operation, btrfs_exclusive_operation_show);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -817,6 +841,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, exclusive_operation),
 	NULL,
 };
 
-- 
2.26.2

