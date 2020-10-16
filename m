Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9229085D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410116AbgJPP3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgJPP3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39443C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so2196074qkk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpnUXtAXjyTWlnwMA3aBaxYEdlZZnjtTMX7pzJkxGs0=;
        b=KcoZBAUbdWCnW6GAz/3v75EkZqTIvm0f3UGF2hYcMtvAnXYUMym2IIfYhdkKS7OHok
         RaTOcqK5IQEybfgrKWE6PbGcFIjWvtr4m8kh6V//K5NoWw5twylTYdrR6If2adOvrJmu
         M8FJpZI1CBRUgCDabN6aMZxHG3/6MwsBWCyr1filjqmb4m07P1N6DFXE5Ez21lYb4oIa
         tohsl/sQvt5utGnwnwBtx07VwBThvRZec3Osv5opwwL/AiX7ja7hiIXnaBVwITHkfxMq
         Jc0grwYOyEj4ulQ5wacho0eqQ2nulJIFJlHWMsWnSTbr6UWHHTL4KRwUcuZgEJpCzPUX
         VwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpnUXtAXjyTWlnwMA3aBaxYEdlZZnjtTMX7pzJkxGs0=;
        b=YubKvSoDnbiT+pWSvupwMP6ecZFDH/TGJGFwni83AK8ceK9CF6hI9BSFrM2yJs4RsP
         zi5niBQn+LZQw9+PmR3imWL9oKiY/e9b726235SN1z/fmZ/NuawfLV8u+QlsAn9Az9y/
         F9DWHx0/S0dWBk5aKQxDsR+geRwlAVEIF3kz6SlNWJCJ8gFWa0h13g2gxFF+of8+BEkk
         GdnoUtNaqyClGjs+MmtUjMsACNzF1hisA84sCUB9ly/+afpcTlzhfAP8nJ2/24wTGEwB
         Rdv30gzeUncMhiNihhuvN6jTkpgeZJfKgamo8NLfIeV20SQ3QSXyDhbOE/vZJJjlu0eP
         WzRQ==
X-Gm-Message-State: AOAM531vJoQpBAMYbKLqG7w65kWqJ2wNgB+CV88VDO2GnR7NxAPzG2H0
        5TJqb86QzlvJ9Wxy3zxv6L1wqX6GIJmRDx84
X-Google-Smtp-Source: ABdhPJydHy1qRqIZSQIi7JtvEkXT7ucsMkXFNtM0cDCIEwIFkgUTvgXVO3QASEz7PXKQtGAi/XJVYQ==
X-Received: by 2002:a37:ba42:: with SMTP id k63mr4393423qkf.22.1602862174762;
        Fri, 16 Oct 2020 08:29:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n201sm330772qka.32.2020.10.16.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 7/8] btrfs: introduce rescue=ignoredatacsums
Date:   Fri, 16 Oct 2020 11:29:19 -0400
Message-Id: <b59d0ce6febd03ce388a95efe38bc5044b004c8f.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
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
 fs/btrfs/super.c   | 14 +++++++++++++-
 fs/btrfs/sysfs.c   |  1 +
 4 files changed, 27 insertions(+), 10 deletions(-)

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
index 82f125a77911..504262e7c7d5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2268,16 +2268,19 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
index 230caa4252b3..83689e6659fc 100644
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
@@ -1450,6 +1460,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		print_rescue_option(seq, "usebackuproot", &printed);
 	if (btrfs_test_opt(info, IGNOREBADROOTS))
 		print_rescue_option(seq, "ignorebadroots", &printed);
+	if (btrfs_test_opt(info, IGNOREDATACSUMS))
+		print_rescue_option(seq, "ignoredatacsums", &printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e9f482989415..86f70a60447b 100644
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

