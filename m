Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD922454B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGQUm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGQUmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 16:42:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE3C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 13:42:25 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ed14so4844903qvb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgz82dMYHiBvBp09sYG/l/SpQQeEJhU5BVl3vrIvB1I=;
        b=RMB2qaR+/g02lNED2q38NKWk4qbIUQVHVwXdmVGyfz854vtduqLI4PljcYtFyGWv9U
         +4Yv67c1gxHIa27hdMWzKctgQKNgVrplzWBCxH9CILYMBnsjOzaIjWwC5+KnSzSsgOJn
         qMNuveMlLT7ZwKD6r+C2End3lQXTjWFMXKjEnlc7sxxENVbWzfIxGmJ2duVTdSlZwBCy
         05QMXh1LwuaK8CO8/hXNSqPRlvYSghfckr+jYybty8qv81Js8zLjQxUjP/WazRLqCinp
         tUkiwwPEpsHKWH7pVzMIO7vCo44ivV5O2fTjRPDTIN49ApZYjVFIkMKEcBUqL5UEocWg
         bQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgz82dMYHiBvBp09sYG/l/SpQQeEJhU5BVl3vrIvB1I=;
        b=ip2Ny0EoQtaEQBkX8IS6JU2X6gLGvZuEnI0x7pQ7uvXJSvc4OGV4lNOatEVpERwEhz
         2cz+Q0Zte7wYs/57NF++Bfzjged6XznzvWXgycYm/Z0p4nnXVODQO+CuIpMdJMVQc3fu
         iR+kJddpJjK+h00/JG0MSgVdQsMp+/AlDxyhojtcm6V6L/Rph2rstYdnjMXzJ8TqWYam
         04+Qy+ptYtlWc1IHQ2gRQh/R5gXgpZ1WwZJXmO+YVy2dwRTmcMT/vCgoWghs2KhmwqZA
         75KB9MgaN2IdG2z5uWOqomut6SD2Oc1474Q5qzNRUvIPqQuhPw0DnXtebNhp2e3/NFSE
         iFIA==
X-Gm-Message-State: AOAM532PhI1HLPOqSoIP3jArwfDNE0pp87tnTQsnQr6B0cWX21tTlPHO
        XoEWLyQzPwQH2hg+Ak/MJ/n1842vaQvnrg==
X-Google-Smtp-Source: ABdhPJxf4vtwfb8UsaQ1mCOc7+oH0KlBpTEg7F2B/CyD/JU4BS8CKcESovLNh2buOIjhO/JPOyEExA==
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr10865776qvr.212.1595018544118;
        Fri, 17 Jul 2020 13:42:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c133sm12524434qkb.111.2020.07.17.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:42:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        chris@colorremedies.com
Subject: [RFC][PATCH] btrfs: add an autodefrag property
Date:   Fri, 17 Jul 2020 16:42:21 -0400
Message-Id: <20200717204221.2285627-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Autodefrag is very useful for somethings, like the 9000 sqllite files
that Firefox uses, but is way less useful for virt images.
Unfortunately this is only available currently as a whole mount option.
Fix this by adding an "autodefrag" property, that users can set on a per
file or per directory basis.  Thus allowing them to control where
exactly the extra write activity is going to occur.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- This is an RFC because I want to make sure we're ok with this before I go and
  add btrfs-progs support for this.  I'm not married to the name or the value,
  but I think the core goal is valuable.

 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/file.c        | 16 ++++++++++------
 fs/btrfs/props.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e7d709505cb1..4f04f0535f90 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -31,6 +31,7 @@ enum {
 	BTRFS_INODE_READDIO_NEED_LOCK,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
+	BTRFS_INODE_AUTODEFRAG,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 841c516079a9..cac2092bdcdf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -116,12 +116,16 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 	return 0;
 }
 
-static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
+static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info,
+				     struct btrfs_inode *inode)
 {
-	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
+	if (btrfs_fs_closing(fs_info))
 		return 0;
 
-	if (btrfs_fs_closing(fs_info))
+	if (inode && test_bit(BTRFS_INODE_AUTODEFRAG, &inode->runtime_flags))
+		return 1;
+
+	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
 		return 0;
 
 	return 1;
@@ -140,7 +144,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	u64 transid;
 	int ret;
 
-	if (!__need_auto_defrag(fs_info))
+	if (!__need_auto_defrag(fs_info, inode))
 		return 0;
 
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
@@ -187,7 +191,7 @@ static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret;
 
-	if (!__need_auto_defrag(fs_info))
+	if (!__need_auto_defrag(fs_info, inode))
 		goto out;
 
 	/*
@@ -348,7 +352,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 			     &fs_info->fs_state))
 			break;
 
-		if (!__need_auto_defrag(fs_info))
+		if (btrfs_fs_closing(fs_info))
 			break;
 
 		/* find an inode to defrag */
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 2dcb1cb21634..5c6411c8b19f 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -310,6 +310,40 @@ static const char *prop_compression_extract(struct inode *inode)
 	return NULL;
 }
 
+static int prop_autodefrag_validate(const char *value, size_t len)
+{
+	if (!value)
+		return 0;
+	if (!strncmp("true", value, 4))
+		return 0;
+	return -EINVAL;
+}
+
+static int prop_autodefrag_apply(struct inode *inode, const char *value,
+				 size_t len)
+{
+	if (len == 0) {
+		clear_bit(BTRFS_INODE_AUTODEFRAG,
+			  &BTRFS_I(inode)->runtime_flags);
+		return 0;
+	}
+
+	if (!strncmp("true", value, 4)) {
+		set_bit(BTRFS_INODE_AUTODEFRAG,
+			&BTRFS_I(inode)->runtime_flags);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const char *prop_autodefrag_extract(struct inode *inode)
+{
+	if (test_bit(BTRFS_INODE_AUTODEFRAG, &BTRFS_I(inode)->runtime_flags))
+		return "true";
+	return NULL;
+}
+
 static struct prop_handler prop_handlers[] = {
 	{
 		.xattr_name = XATTR_BTRFS_PREFIX "compression",
@@ -318,6 +352,13 @@ static struct prop_handler prop_handlers[] = {
 		.extract = prop_compression_extract,
 		.inheritable = 1
 	},
+	{
+		.xattr_name = XATTR_BTRFS_PREFIX "autodefrag",
+		.validate = prop_autodefrag_validate,
+		.apply = prop_autodefrag_apply,
+		.extract = prop_autodefrag_extract,
+		.inheritable = 1
+	},
 };
 
 static int inherit_props(struct btrfs_trans_handle *trans,
-- 
2.24.1

