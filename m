Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0030B289920
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgJIUJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391551AbgJIUIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62473C0613B1
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so11870659qkg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1Q/E5ajjkHF2MyVXehvEF7edFEQTRyiEXftw9I8XQo=;
        b=zxOZfcKCBZL2sePvXDO9FhLIM1n6gEbN2ETpjaVybPTyuwUnpw3+zpnYYfcPSfgqlU
         eCaMjPmO8UrobXciWkDLZuElv0Of5QbV3wt3rFyj5DWxkfMMfewD9hegu28rx1yZ+wMI
         eiYTV4kjMTJCQDDAv/yZzZse112rm8cxaJ8Q7zy8DGKtfl94t/9YPvhX6IDOJ0IhQssK
         byIvT/csnAXo4i3O0vi2hd8XHLUA2XOQ/h3Bo/sMQr+oKTx4UEUdLgLSHqvaMtNNqbxw
         cizlhhKnOpUT8AVl5TuMCihpTB4Z2Gn8oz/tvrYCLz18fCXLsGtgw0Sd2tMLc8crfYWX
         muQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1Q/E5ajjkHF2MyVXehvEF7edFEQTRyiEXftw9I8XQo=;
        b=NNwkrVpGp+umyGTTUJqOsCWoWPQjU1dzPQ85pzgVvD9nHGKh/qVEVxFd0jLBMXWZSk
         2e5SAOFTJ2cM6Ghr6Ep8EVRNYYuwh32uQUaWdptVHF9mN9dmHo19wmh2FMRxNchIfdbe
         p37XTmuJ6bQjpYm7T/1heQZyLhOnGgmZJ135WmGCD18gaFKA/mb2L9lV2OHyi3BhalU/
         Xoy21SUp2t7KViDtQGivHMOAmmbDv9DF5KaDKa3rD0OH+scBnbKt03RljU9TeFdHsAQK
         qhI2moD1Q40mqa1fbnpZXZbfvnNRNjCWDh5smV8Rd1IG/aNyuL+teUF5oZexjD6H/omd
         3JnQ==
X-Gm-Message-State: AOAM531M6hcRmXmsxDTNeXcQ+yfxibAdw6QQrabZp4LdeTd5sSOXoY+g
        ciDKe3LgNbvoMN2FWJQz+SLvrvgDlJsXbMvl
X-Google-Smtp-Source: ABdhPJzRmPaMgN/dKhq6zsoNXouxn0hmNUHJ/3GEOMnmRxpHl5OmYOtxFXbGBh6xYLla7XkvroTpyQ==
X-Received: by 2002:a37:9e8e:: with SMTP id h136mr15822570qke.205.1602274055185;
        Fri, 09 Oct 2020 13:07:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm6613262qky.0.2020.10.09.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 7/8] btrfs: introduce rescue=ignoredatacsums
Date:   Fri,  9 Oct 2020 16:07:19 -0400
Message-Id: <7eb79c39ce53c3989aa3842773cb0384c70b21aa.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
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
 fs/btrfs/super.c   | 13 ++++++++++++-
 fs/btrfs/sysfs.c   |  1 +
 4 files changed, 26 insertions(+), 10 deletions(-)

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
index f08887703915..0d105398fdcf 100644
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
index dccdc670998d..becb61204eb5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -361,6 +361,7 @@ enum {
 	Opt_usebackuproot,
 	Opt_nologreplay,
 	Opt_ignorebadroots,
+	Opt_ignoredatacsums,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -458,6 +459,8 @@ static const match_table_t rescue_tokens = {
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_ignorebadroots, "ignorebadroots"},
 	{Opt_ignorebadroots, "ibadroots"},
+	{Opt_ignoredatacsums, "ignoredatacsums"},
+	{Opt_ignoredatacsums, "idatacsums"},
 	{Opt_err, NULL},
 };
 
@@ -505,6 +508,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
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
@@ -991,7 +998,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -1446,6 +1456,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	print_rescue_option(NOLOGREPLAY, "nologreplay");
 	print_rescue_option(USEBACKUPROOT, "usebackuproot");
 	print_rescue_option(IGNOREBADROOTS, "ignorebadroots");
+	print_rescue_option(IGNOREDATACSUMS, "ignoredatacsums");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c60240d0d7e6..8edc51f3d894 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -333,6 +333,7 @@ static const char *rescue_opts[] = {
 	"usebackuproot",
 	"nologreplay",
 	"ignorebadroots",
+	"ignoredatacsums",
 };
 
 static ssize_t supported_rescue_options_show(struct kobject *kobj,
-- 
2.26.2

