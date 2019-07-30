Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C17AEFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfG3RJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:09:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729490AbfG3RJg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:09:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0279AAC10
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:09:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09704DA808; Tue, 30 Jul 2019 19:10:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: sysfs: add debugging exports
Date:   Tue, 30 Jul 2019 19:10:09 +0200
Message-Id: <3f694d71e45864469c34359ee3b5a0bbc44a345d.1564505777.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564505777.git.dsterba@suse.com>
References: <cover.1564505777.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add 'debug' directories to global sysfs and per-filesystem. This will
replace the debugfs directory. The sysfs location is simpler and builds
on top of the existing file hierarchy so there will hopefully be no more
questions about the sample debugfs file.

The directory is called 'debug' and only present under
CONFIG_BTRFS_DEBUG so this will not affect productions builds.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6493b068294..6eef46556d75 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -247,6 +247,25 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
 	.attrs = btrfs_supported_static_feature_attrs,
 };
 
+#ifdef CONFIG_BTRFS_DEBUG
+
+/*
+ * Runtime debugging exported via sysfs
+ *
+ * /sys/fs/btrfs/debug - applies to module or all filesystems
+ * /sys/fs/btrfs/UUID  - applies only to the given filesystem
+ */
+static struct attribute *btrfs_debug_feature_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group btrfs_debug_feature_attr_group = {
+	.name = "debug",
+	.attrs = btrfs_debug_feature_attrs,
+};
+
+#endif
+
 static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 {
 	u64 val;
@@ -857,6 +876,13 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+#ifdef CONFIG_BTRFS_DEBUG
+	error = sysfs_create_group(fsid_kobj,
+				   &btrfs_debug_feature_attr_group);
+	if (error)
+		goto failure;
+#endif
+
 	error = addrm_unknown_feature_attrs(fs_info, true);
 	if (error)
 		goto failure;
@@ -954,6 +980,12 @@ int __init btrfs_init_sysfs(void)
 	if (ret)
 		goto out_remove_group;
 
+#ifdef CONFIG_BTRFS_DEBUG
+	ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
+	if (ret)
+		goto out2;
+#endif
+
 	return 0;
 
 out_remove_group:
-- 
2.22.0

