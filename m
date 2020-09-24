Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62612277571
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgIXPdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIXPdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 11:33:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8011C0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so3249273qtq.10
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t73NgxwDYgtQirb7X6yceENW0PFaSD+3K+ON0ltvmUw=;
        b=TCV/4/eRBDFbltN1gnCUGNEEZ2TTovezFLB3iBhjHlK0MoLwO40Q0GdNaFF0WKTfmG
         maWVyni/vN80XxXC/DRsjPDFvugjVG9JB7lkpBOm4EUguotkQ+HI6LgbDS1fIuVvrsSP
         W1UsJN+Ntio0KzDhWUT8GQcUsGrJN9Umge9JYYH48lAXMrMgbGB/6+GR1KjmseXBc8fj
         VPJBIBUkMQJPqbNH0qlvEvYhoFK3IAOnsPFXMk1eBh8JlefUGVVQ7AkTFqMSZHA1b5d/
         PNO3tVUnDS3Pmj3R8r8JhAljc7S/eBpRRo6/G7S7CBkEK0/LE2vgVW5XGKq9nl2w2jky
         jRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t73NgxwDYgtQirb7X6yceENW0PFaSD+3K+ON0ltvmUw=;
        b=FrnIj/gvTWMHkGvSCV7lyi3DOPN0NL1Gnzw7FxGOKIxM/r9j6BNJ7RJuqIN1BEk1nk
         yi8vOMRd37e0gZPJuZ5fGILuiGhldvqTXm5PR5gxEcANXmvmgBOAJx+FjNdBbKASi1JR
         317fpLMTxNz512UaXaSnc9YMBLmPdz7Zw9H8gpGmTbX3+3egPZSu5PWUaIsy/u5V5Tf8
         98bSD/hOOGkqhbdJEV/z6zncDcgN2jiwViMw6Vi4Ree/oOcjZgNMMSAzJeE2BkinwOsJ
         IvPXTJuFtxFwT7OPNS5t0GQhTp0fo9OMni7LAg/T6gmp57S7rHLy/TmyASlCQZDgmpVH
         Spjw==
X-Gm-Message-State: AOAM5336cxDqKr7JY2s49uea6+sx2a2i7t4UA68kMwQMe948RJCT28Fl
        hYJIWrnafdudZrbj0plxNrGDOcLSjFDGUXtg
X-Google-Smtp-Source: ABdhPJw5VyR0DESQXhc4q7jfHbifS3TyL07wkzDe9wBSlZOBh3PMLWdwkfl8UoTxRAjakxqtohoA+g==
X-Received: by 2002:aed:26a1:: with SMTP id q30mr106743qtd.25.1600961585719;
        Thu, 24 Sep 2020 08:33:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m10sm2445834qti.46.2020.09.24.08.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:33:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: introduce rescue=ignoredatacsums
Date:   Thu, 24 Sep 2020 11:32:53 -0400
Message-Id: <c3cc0815c5756d07201c57063f3759250f662c77.1600961206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600961206.git.josef@toxicpanda.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
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

