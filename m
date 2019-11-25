Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3B109469
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKYTrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41292 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfKYTrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id 59so13068017qtg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/uSEcZmYQD26T6L5eL2QFlCiJ6inR86K4hroBrXIOK8=;
        b=hkJewWn5kcaehAPRfT8vtbyR2uMbC3TVW3D05kzP1PhhEmJrVW6k5vySE8Yq4e2CZ+
         vCWVDuPVs6KtAczyTPe76eneu4ORDoCS7mYQMJL+BuBaHyAhnwXyOWSUH9DB6xa03h5h
         lJ1i1VX4CmEYyPMue6aFa/mc+/2XQ/ktAieE5hw0iSuQDrFzPQIAr2fUlLM8TsTNbIDq
         OpUZSXY2ciW8YM2/VudoZ0WBQ6f4yiI5ZM5NEQkxziyW71IRLOfQsimIGcCpjagJh4Ia
         I0861CrUmeXhfv/o2kQFsEv3HNXXyBeOEIM/afJiRWD+L6mOfWwKsaqwZLGjVKnQW7eP
         GELg==
X-Gm-Message-State: APjAAAWj38mN5Rc3AC8iAzWPAmBn9cee0ovBk7elOuVcGeg+O71eq27d
        VnBuVOihZFsfTVhH9Wy7Zy8=
X-Google-Smtp-Source: APXvYqxBVVH44zODn9OWbonotPjuAyvYwgPtZoNYKiqU/uw/c6bctPBZS61K6Z5GaWsh5J0cyj2KcQ==
X-Received: by 2002:ac8:6f66:: with SMTP id u6mr13690152qtv.72.1574711238734;
        Mon, 25 Nov 2019 11:47:18 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:18 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/22] btrfs: add discard sysfs directory
Date:   Mon, 25 Nov 2019 14:46:50 -0500
Message-Id: <ecde166ccab41a3980b509a5cd7237e3fc3edc76.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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

