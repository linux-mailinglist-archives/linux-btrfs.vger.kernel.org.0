Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E611EF25
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLNAWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLNAWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so277816pga.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ilxmeqRHdi1GBmc6mS9OUD1plGcUdLb32SdiSYEudTs=;
        b=O1p/PtmxE657vDxcXxHrQkzAOGlSLj7KtEyHUVpUlA3ugBO1M0f8wkbI67Kd6cJ9Z6
         O/oBl7bi66ZWS4eJHUM0gbYObBuFhh3Cas6m796dbh7YY1R97sm3D22mM5noTzbMraCn
         8QfGIi9h+I3ro+m8oIrsZj3ShGyFjxZP0PqVHseayAXCtReVoFe9AOXM+aQ21FqpEbww
         MDvHaA8YFLU6en6g2dluR9DOciig2R4XQvnhq+jyiY6j4HA8QeMs2nEBxsYq0hIULo89
         asA5EoM60RBZ6CP+ZJcRC6ee0MapVMBijEDQnckLkMJtbbfUcaHjCXkFPEu1X6QWtrvS
         1URw==
X-Gm-Message-State: APjAAAWVU0DApYuDx2Q06NmSvYZ59gqofzX8NKRZmwNcAr+gAzT3XZ5q
        zzdfipF/o7ytxnBAALmuHsM=
X-Google-Smtp-Source: APXvYqxqKcSNDDPft1C+rar2k0P/MSWLaxCtRrbdiXEJH49lMbnXicZLdeucxoTQKdiTI7snbAuQtQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr2542474pgl.359.1576282970192;
        Fri, 13 Dec 2019 16:22:50 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:49 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/22] btrfs: add discard sysfs directory
Date:   Fri, 13 Dec 2019 16:22:19 -0800
Message-Id: <f243ae9b77be6f4db5bcdf848fc4a624f6d5e308.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index 0626e5562993..71317047c321 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -930,6 +930,7 @@ struct btrfs_fs_info {
 
 #ifdef CONFIG_BTRFS_DEBUG
 	struct kobject *debug_kobj;
+	struct kobject *discard_debug_kobj;
 #endif
 };
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3a56e0cdd673..bc5415f67987 100644
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
@@ -1127,6 +1140,19 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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

