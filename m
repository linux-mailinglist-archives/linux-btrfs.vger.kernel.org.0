Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A109117623
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLITqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34471 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLITqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so7635398pgf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MzyxE2WAAhGZKg0eCVFRcnL7x3mLBj90V046YTNiI5A=;
        b=Qr3UiHgwlzyfsfLPQGG8z9zyDqhQMfXYav9kYvFdpa8K7hcmOXS6+Ghcig8NhGYG9T
         uS1huj+nAunA3aT2ZUUwYEtqqWrt4plNAfk9ZAkXMOCWiG6XMnEN9bmOQUlC2JG46auK
         HOiOD7ttB1tojmlCDX0XF6rbs9FNMkmce1uteoG4m1gutWfg0OEDz7FJWL99FsyjOSq1
         fUTYDjNl/4lDInjb0YsT2YEmJAdTye/CElXli7FILxTMH3nw8YKjZZ+JvYt1B1+3ZtAz
         QkG57I/054ckX2lSOya7OBAy4354z0/Q+omRKSU76IyeziKSU80/FXJHV4dlQweYGOtn
         DROQ==
X-Gm-Message-State: APjAAAVIz79vn3NiS0szyYBvF0d3+CNHI9IHMZTpjVOLEZxkY1q10GEe
        STDM7VTR51OCfWyChGpqRqs=
X-Google-Smtp-Source: APXvYqyANrFbsuQb4gMNx3AIYt3p/8BDYKyRQ8Lz5WXNS5Lg3zjy3e0nKxc4dxfJSC63l/aCR6LOeQ==
X-Received: by 2002:a63:496:: with SMTP id 144mr21106727pge.207.1575920781470;
        Mon, 09 Dec 2019 11:46:21 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:20 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/22] btrfs: add discard sysfs directory
Date:   Mon,  9 Dec 2019 11:45:55 -0800
Message-Id: <36d628cc354e33708556b8ff3fa9b47be30c3385.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
index 86addfc7bcbf..40d6545337ff 100644
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

