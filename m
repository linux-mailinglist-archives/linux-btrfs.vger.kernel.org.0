Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDFE26A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436916AbfJWWxb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40010 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436918AbfJWWxa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so26908079qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BF86uypJMa+5lyUdgGXD80AM8sGQXwKBWiPQQJT/fKg=;
        b=bCxzavs+DIFZVfkO41eQI+3neFwM7BsbxARkeXySeUMn8esaV7yoPzb/B2yxfRWUBQ
         pk+NRfrNfnci1MIEoBEUmPsP5R2PRsNHMo5kN35O793qHNdnmjB39t8bJki+gicfzk+U
         esAg1NqDCMT900vfMGiGBLbUhQeyQNIGtBZFXx2yvvFYHY7gQaAw9kJWm4E7B6eYzsK4
         TGS1+r1j+kLboFOi9z5kAA+mvxjhXdmi5W2ztpzxcMQcsJ/HEhxbRnxDouql/byDacJN
         GB31bu1KS5l0LsNyzDx5Q+gIuNFG+VJne509oG/F6GCLhpxrDyLuzrAQkvVfWB/jaZeN
         MwzA==
X-Gm-Message-State: APjAAAVaLY9q92oi2MwZrG/qfnLfME37ITz8SYVQ+xGDLFh0CzP57Y4/
        g5lDmLpeKI35FKeutNPK/K8=
X-Google-Smtp-Source: APXvYqwT1IJUj4ahn0kofL6dx73SI2ASi1uKDz6bVIFmRf7J8DUqWumAVVBw+8LhwDm3BgixJbYrcg==
X-Received: by 2002:a0c:8144:: with SMTP id 62mr11830005qvc.6.1571871209624;
        Wed, 23 Oct 2019 15:53:29 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:29 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
Date:   Wed, 23 Oct 2019 18:53:03 -0400
Message-Id: <e3007650cc13578a819e2593cfdcf84db1294d02.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
---
 fs/btrfs/ctree.h |  4 ++++
 fs/btrfs/sysfs.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e21aeb3a2266..8a34a90ce77f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -928,6 +928,10 @@ struct btrfs_fs_info {
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
index 16f2865fbbd4..03694792d621 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -319,6 +319,10 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
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
@@ -733,8 +737,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
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
@@ -1076,8 +1084,12 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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

