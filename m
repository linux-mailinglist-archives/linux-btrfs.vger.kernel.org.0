Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F6117621
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLITqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34922 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLITqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so7758409pfo.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4XulbwAnRoRi9vPyxn6hdsIYTAq3Isr0NirKNPjRglU=;
        b=LtTOw3tK7xHZLFf3wS3UcBPwgf0ZW+rY9D4qNVLfaiIKzC5ItqEY6vDNy9PWnPZ8MR
         yaFGlqL79G7J6W6kzRmCEwOPBypPFu039HRvpyvTw9Gndv7fOmB23wztn7fcTSNsy9b0
         MJEbQOxkmoWk0drXean7sQd81a1BlWY/T1p8kcpKoeVd3czGdaPccAM0ozRqltGbnYmu
         0pyIOsNr6dGyfg7UZN/UsCIb2GHFZY/nQEiabs9sajepwebzlWR6ExoV/mvC/pAyABjZ
         q1e8GswNSnQszGjZfGLsEKlMiDRdBaksOL5vkzgeS5PnoxIvifhdk5SNINOj2SNrj/ay
         z11w==
X-Gm-Message-State: APjAAAWq6/YjDtQs+JcshDAf+/15Kxn4yezrT2JKvlqmVvX8z2gUQkwL
        y9udAIG9mygxWnqE6ycMzLc=
X-Google-Smtp-Source: APXvYqz6QldQfPoAgXG+Rsy2JDoZ2vvrk36HsMoA//jEwBWilQntwiCorgjSiWWakXuen8JDnDh+fQ==
X-Received: by 2002:a62:ed16:: with SMTP id u22mr31708674pfh.28.1575920780337;
        Mon, 09 Dec 2019 11:46:20 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:19 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/22] btrfs: make UUID/debug have its own kobject
Date:   Mon,  9 Dec 2019 11:45:54 -0800
Message-Id: <6cb5c1bdf9d894cfd4a75382d9bb8c89217d31e6.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
index 2a116cdbffe7..86addfc7bcbf 100644
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

