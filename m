Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5781810461B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKTVvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34957 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKTVvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so1280209qki.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1hqK1ji8GJMZyNJzHdTRClKXccRDS+c6leUcVy6PfBU=;
        b=YqDEBRbECdTNP1fy+YK84t/ifkZdzkZAxiP/uDi/nqgPjywtG5eYLjUNtnMaGok1ze
         P95WVe+5rL9fCWtTRR33K0NSUTcwV8LM/sPxr31Ha0i1stiLDZV0jKEuaeOtycA5/5J/
         Ps1yyzE10CWG6aQMZ5R4h2CjLHZMwlKxn28xnZ6vjL/74WrMY7E+nojpg5+Z5ANaJuAS
         /e102qo2OBurUEJk28KXRIphAF4JepNAfjgeyvsJ37WGQ/Du9tMM62DBfTuqaXa/ap8Z
         OLk24baTi7jI2v49TaxNubD+IYBDGVKkBud6aJdqe1YFTWEc8nnf7MwySD93BD6SU7i9
         IPVw==
X-Gm-Message-State: APjAAAXJHQnaX8SFUsDppI5TQwoDe5QVwezeiRIOW8PhCJADlqAmcFKK
        51HDVM2avGACGUJs1mQ/rbQ=
X-Google-Smtp-Source: APXvYqzOHGPLE4glCTQoVmsX+VuAJJrs92Z7rPWnJpPj0xsy7wmbCy0D9IG8Aqq2o5LCWsBlDBhGow==
X-Received: by 2002:a05:620a:4:: with SMTP id j4mr4714602qki.357.1574286698148;
        Wed, 20 Nov 2019 13:51:38 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:37 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
Date:   Wed, 20 Nov 2019 16:51:08 -0500
Message-Id: <75f813899da474eeebb1984628801fca7ae12377.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
index 68340d65a8b6..0c5cd5e6c2c5 100644
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
index 58d089354bc1..beae5c8146fb 100644
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
@@ -1115,8 +1123,12 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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

