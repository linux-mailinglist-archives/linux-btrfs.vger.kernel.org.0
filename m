Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0F597196
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiHQOnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiHQOne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:34 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF04DF01
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:30 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0928D80A9D;
        Wed, 17 Aug 2022 10:43:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747410; bh=3Mx2jbxtrJmSQnucNP5szJZ0hAuj3ehmiON8uBJKck4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bq8YIkJVr8K72Tj7KJhO4cdIaL0+pVNJiOZOIOIxxUklsxi86LwLmRxO8bvzfHAZs
         aTmT+g3mqbMvvwS3eveBqRZzOG/Cn6nMRbQBXdbWnqlylxTqsGw8VZpMyNA3QJB1vH
         ffl70kMAAYxCOcCd8rbaWpPTcC5sZls9hrgUi3QPdBxYrnA8TDD/n7h3gEClEV+B2r
         yCiXoB4DsehHR8dPgwx/+e6aloO2hIle91zQefO50pzpEJCREMW9ArRLQMHH4n6bgd
         YX9RbQ/Llmn48sbnuWRFang6Xf6eMCEEKfkU0gzo39stxHuDo39DbUfFGttJHh77Gc
         PzY4trjmuiB+g==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/6] btrfs-progs: add fscrypt feature flag.
Date:   Wed, 17 Aug 2022 10:42:54 -0400
Message-Id: <aece7add1d9231eff82c3eba12183fb677483680.1660729916.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1660729916.git.sweettea-kernel@dorminy.me>
References: <cover.1660729916.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the new FSCRYPT feature flag and mkfs option.

For now, claim 5.19 as the earliest version with this, though the actual
kernel version will need fixing up when it actually gets in.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/fsfeatures.c   | 10 ++++++++++
 kernel-shared/ctree.h |  4 +++-
 libbtrfsutil/btrfs.h  |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 23a92c21..7c12576f 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -143,6 +143,16 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "new extent tree format"
 	},
 #endif
+	{
+		.name		= "encrypt",
+		.flag		= BTRFS_FEATURE_INCOMPAT_FSCRYPT,
+		.sysfs_name	= "fscrypt",
+		VERSION_TO_STRING2(compat, 5,19),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "fs-level encryption"
+	},
+
 	/* Keep this one last */
 	{
 		.name = "list-all",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 38758dfc..6e5bf74b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -508,6 +508,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_FSCRYPT		(1ULL << 14)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -536,7 +537,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
+	 BTRFS_FEATURE_INCOMPAT_FSCRYPT)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 0d863d58..3d67f251 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -277,6 +277,8 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
+#define BTRFS_FEATURE_INCOMPAT_FSCRYPT		(1ULL << 14)
+
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
 	__u64 compat_ro_flags;
-- 
2.35.1

