Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6927B48C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1SfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgI1SfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:35:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00485C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s131so1962664qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DGa9hwQGeCLQnx5BGppKF4jGmZXhe4DPBbyx0Zs7SE=;
        b=m0H9fYSm0JXnqgaHFjDCbca9MNzmu33kpKu7pt/ggGEklNUmmUi4wqCKuk1lnKDYuc
         LASs+lAtJ2Hdb3FllzvpCP7Xf5LTnw6KY+Da2bE/QnsEJCCEe6uribFFcBYKIwjHHh0v
         IOlRsuSqJMoN+nATSiXseZTxKjgoQb3GGauDid1GpetRYsi49g3MubzpvMX0rfg7HRBp
         xcciaVSu621dv8Lsr08CxVma0DdL8YjnqVd+W/NfSnVBVNXvXe1Ym4tEaYTK2106YwrU
         p/0t5bfdajNaBw5wNsApbJ5vkyr9LjB6IdG31xBAEzt53VHaiqRwEJIgaCAqaZtUDVgh
         4wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DGa9hwQGeCLQnx5BGppKF4jGmZXhe4DPBbyx0Zs7SE=;
        b=EmH2m89qihcoEZCrAHkT50PmUZvX6gobLGmylruybLHCVHLOJt+L8uUUR3cQtfh2cV
         mheoZvAZoWMKQhfizw+9Y0Cbqgp2EpRDfjW/ucQUCXdw6yG/SVg6RDFMwSSZPU2gZVwJ
         LOZgjdmVSNEDD6cJABf1HuvgruCCFpt4VAjzuukTsbWT/Diy5mttDr5We2vzT3w/qZuj
         fGg/bQiMej+vV87YvcRoXSDS61mEKgjnqdVNtRYpD0aOnb64sJCXDVJQ0c87+c5zAlRZ
         uKftY+KkKGKjpMy/XG2cZEDVK52X9qw/PV/ZxzH+RKPHYjp0fF/mpJjIw0oiluNkVvi2
         qu8g==
X-Gm-Message-State: AOAM532pWwxJJagNfM36r+cekKj7t5LJrttM/kRj9s4rCN0f6bAly0rs
        stehTf7lVrJs7Bf0JGWeeMLGyDc2+PIFhnMH
X-Google-Smtp-Source: ABdhPJz/bmrfhnjyGhCrD22BnkTSf11Cq3gSatUYvDqMDcj66gwgT1URj7hC8uvbUms2s4yjGtKC6A==
X-Received: by 2002:a37:af02:: with SMTP id y2mr839728qke.346.1601318106741;
        Mon, 28 Sep 2020 11:35:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 7sm1815917qkc.73.2020.09.28.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:35:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 4/5] btrfs: introduce rescue=ignoredatacsums
Date:   Mon, 28 Sep 2020 14:34:56 -0400
Message-Id: <1c4b7fef28dde35f38246ad17c6fd4c0cf8c5837.1601318001.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601318001.git.josef@toxicpanda.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are cases where you can end up with bad data csums because of
misbehaving applications.  This happens when an application modifies a
buffer in-flight when doing an O_DIRECT write.  In order to recover the
file we need a way to turn off data checksums so you can copy the file
off, and then you can delete the file and restore it properly later.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c | 21 ++++++++++++---------
 fs/btrfs/super.c   | 11 ++++++++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fb3cfd0aaf1e..397f5f6b88a4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1296,6 +1296,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
 #define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
+#define BTRFS_MOUNT_IGNOREDATACSUMS	(1 << 31)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5deedfb0e5c7..6f9d37567a10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2269,16 +2269,19 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		btrfs_init_devices_late(fs_info);
 	}
 
-	location.objectid = BTRFS_CSUM_TREE_OBJECTID;
-	root = btrfs_read_tree_root(tree_root, &location);
-	if (IS_ERR(root)) {
-		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-			ret = PTR_ERR(root);
-			goto out;
+	/* If IGNOREDATASCUMS is set don't bother reading the csum root. */
+	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
+		location.objectid = BTRFS_CSUM_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->csum_root = root;
 		}
-	} else {
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->csum_root = root;
 	}
 
 	/*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7cc7a9233f5e..2282f0240c1d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -361,6 +361,7 @@ enum {
 	Opt_usebackuproot,
 	Opt_nologreplay,
 	Opt_ignorebadroots,
+	Opt_ignoredatacsums,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -457,6 +458,7 @@ static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_ignorebadroots, "ignorebadroots"},
+	{Opt_ignoredatacsums, "ignoredatacsums"},
 	{Opt_err, NULL},
 };
 
@@ -504,6 +506,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, IGNOREBADROOTS,
 					   "ignoring bad roots");
 			break;
+		case Opt_ignoredatacsums:
+			btrfs_set_and_info(info, IGNOREDATACSUMS,
+					   "ignoring data csums");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
@@ -990,7 +996,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		goto out;
 
 	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots"))
+	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS,
+			    "ignorebadroots") ||
+	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS,
+			    "ignoredatacsums"))
 		ret = -EINVAL;
 out:
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-- 
2.26.2

