Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8527311EF24
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfLNAWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLNAWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id z3so381278plk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=o2w5XoSkE149kOU4h2jpLQ/F+4AlDkRPJxZqZ3JQhO0=;
        b=Ipg4MoPZggbaXczToZ4IcF8GCgF03+/synCpYB5Clx1yKiKfW2DpDSZij2ho8V+c2+
         9v4v70v9DDne+vF3DIGXiSt7XZ1ehqGx+PzLTiqJpqcVIbqEOptrV3PRmfGSduR/vvvm
         6OpZd9rqDFQ3Nw14wSEXQ2RVNDmrW5TDmrqSkCePS5J/RprpCjyQQsMfFvJ2OGabww2F
         keUMzulXKD0HQ13Bj2vjqZVILyKnF6qCBMtZf0z9lsPAsfiXJQzQPdaQQchOMCsjN17d
         xr0bxOvPoveMmmjvAy/eWI1t1LmKErezfQuKy+8DWd1SwVRfcqfaEwwYKLjhx5s0kOtM
         56Fw==
X-Gm-Message-State: APjAAAX6uZ7Jy0tYX/5qWtqAJZr23/Z1w00W1dzH1OxG1adGPXZtD9uE
        mBOw1buv+YUS//0VNkO8QXw=
X-Google-Smtp-Source: APXvYqz2pckltZDW4UEAnjACpcEFWBH8h3QAejYrjvUlDVhnDwrWXv9TK8qKPv9z6+lj9oATDZZo6A==
X-Received: by 2002:a17:90a:8043:: with SMTP id e3mr2574358pjw.24.1576282969213;
        Fri, 13 Dec 2019 16:22:49 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
Date:   Fri, 13 Dec 2019 16:22:18 -0800
Message-Id: <c61536b8a5b88101480d33815089cf656748a58b.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs only allowed attributes to be exposed in debug/. Let's let other
groups be created by making debug its own kobject.

This also makes the per-fs debug options separate from the global
features mount attributes. This seems to be needed as
sysfs_create_files() requires const struct attribute * while
sysfs_create_group() can take struct attribute *. This seems nicer as
per file system, you'll probably use to_fs_info().

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h |  4 ++++
 fs/btrfs/sysfs.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d15a4aa721aa..0626e5562993 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -927,6 +927,10 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct kobject *debug_kobj;
+#endif
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4c022757ffa4..3a56e0cdd673 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -344,6 +344,10 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
  * /sys/fs/btrfs/debug - applies to module or all filesystems
  * /sys/fs/btrfs/UUID  - applies only to the given filesystem
  */
+static const struct attribute *btrfs_debug_mount_attrs[] = {
+	NULL,
+};
+
 static struct attribute *btrfs_debug_feature_attrs[] = {
 	NULL
 };
@@ -772,8 +776,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_put(fs_info->space_info_kobj);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj,
-			   &btrfs_debug_feature_attr_group);
+	if (fs_info->debug_kobj) {
+		sysfs_remove_files(fs_info->debug_kobj,
+				   btrfs_debug_mount_attrs);
+		kobject_del(fs_info->debug_kobj);
+		kobject_put(fs_info->debug_kobj);
+	}
 #endif
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
@@ -1111,8 +1119,12 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 		goto failure;
 
 #ifdef CONFIG_BTRFS_DEBUG
-	error = sysfs_create_group(fsid_kobj,
-				   &btrfs_debug_feature_attr_group);
+	fs_info->debug_kobj = kobject_create_and_add("debug", fsid_kobj);
+	if (!fs_info->debug_kobj)
+		goto failure;
+
+	error = sysfs_create_files(fs_info->debug_kobj,
+				   btrfs_debug_mount_attrs);
 	if (error)
 		goto failure;
 #endif
-- 
2.17.1

