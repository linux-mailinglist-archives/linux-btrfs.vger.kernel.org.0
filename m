Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA32510461C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKTVvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44194 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKTVvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so1221066qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/uSEcZmYQD26T6L5eL2QFlCiJ6inR86K4hroBrXIOK8=;
        b=fXDKi4O7dxmLT/7gOytxN5QDHpmksNVs122UY4Ij2MS0Kmy8jyXgWDe5stRnBvM4oP
         iVg8xh2mAODXPbpSUgthrnk6sfdPsZzZ/JcHbenW3MTY7eLbgpx+8ZMEkq1DdXy2SWOk
         z2AOhpGugzEupYZXGFCZcyEyM8hbqgorMGYGOyOIwNnXqcQE49578fzHTcctDmp3dvti
         ceCM/U3FgohtWUmsWX96pM4P0Ob6rACE64Sy8S/dFeZn/ufnwHs/UlBlAlngXqWRpxMc
         X6YOSg+CN1AGDPsLmGBUGYJbCpeu27GlbtyBQnNo3eA7FxiYGIZY0DmBzVO2kVFfNxoB
         Upmw==
X-Gm-Message-State: APjAAAW9IFgjBFBzcPSU10rIH22OoiZ/s5z/aP3XVZ8B/yxcDhXi4rv3
        75cvaKQK2K3xKtAOZwh/+Ds=
X-Google-Smtp-Source: APXvYqw2tlriwxc0zC4sKhzcaOrtlA7FmqmL1QCJPrqp8N0LFgSeKE/5H0biS1vaAZd7e65HiACq6A==
X-Received: by 2002:a37:dc03:: with SMTP id v3mr4733522qki.309.1574286699367;
        Wed, 20 Nov 2019 13:51:39 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:38 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/22] btrfs: add discard sysfs directory
Date:   Wed, 20 Nov 2019 16:51:09 -0500
Message-Id: <e500f070f776c2723b6b0dc7d321ce88bfed6024.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Setup sysfs directory for discard stats + tunables.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/sysfs.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0c5cd5e6c2c5..6a547317d26f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -930,6 +930,7 @@ struct btrfs_fs_info {
 
 #ifdef CONFIG_BTRFS_DEBUG
 	struct kobject *debug_kobj;
+	struct kobject *discard_debug_kobj;
 #endif
 };
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beae5c8146fb..e877e4b3c631 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -338,6 +338,13 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
 
 #ifdef CONFIG_BTRFS_DEBUG
 
+/*
+ * Discard statistics and tunables.
+ */
+static const struct attribute *discard_debug_attrs[] = {
+	NULL,
+};
+
 /*
  * Runtime debugging exported via sysfs
  *
@@ -776,6 +783,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_put(fs_info->space_info_kobj);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
+	if (fs_info->discard_debug_kobj) {
+		sysfs_remove_files(fs_info->discard_debug_kobj,
+				   discard_debug_attrs);
+		kobject_del(fs_info->discard_debug_kobj);
+		kobject_put(fs_info->discard_debug_kobj);
+	}
 	if (fs_info->debug_kobj) {
 		sysfs_remove_files(fs_info->debug_kobj,
 				   btrfs_debug_mount_attrs);
@@ -1131,6 +1144,19 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 				   btrfs_debug_mount_attrs);
 	if (error)
 		goto failure;
+
+	/* Discard directory. */
+	fs_info->discard_debug_kobj = kobject_create_and_add("discard",
+						     fs_info->debug_kobj);
+	if (!fs_info->discard_debug_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+
+	error = sysfs_create_files(fs_info->discard_debug_kobj,
+				   discard_debug_attrs);
+	if (error)
+		goto failure;
 #endif
 
 	error = addrm_unknown_feature_attrs(fs_info, true);
-- 
2.17.1

