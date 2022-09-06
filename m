Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C25ADC1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiIFAB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFABY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:01:24 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D167445
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 17:01:22 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id A8DCD80C62;
        Mon,  5 Sep 2022 20:01:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662422482; bh=JFniCN5L1K8BAzx5WOxarzXXm+YmrtDsHgkeQBt40Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu01ywtIJeHajuTOKJ+aeXdjbdexUgqymjKXUmrG+hY7/WQ02qT7vbEPBlwGSUYFI
         IJZ4uqsKv1JDyhyQdMqquaJYl/VxDQ3+WdZCebvpqlF+yVtYjo72FUFXWUkVSjpJTj
         qoNePX8L+DXkhDfrSX8Axl0sOJSoIenj3+tNvwBtrIB27nFGG5oDyumM5xpH+JC2e3
         Hgl3ffVCZtlGcgvSxtS0Lk6AK6UhJF73jQG18oikunaAqOdZwROejQOk6oxupCjX1P
         ibHh17erivP65w2Ew1uKGuLTc5pMVQQb1YZvwW0mFb3p0gWdX3gEtQqtqS7YkgI/jt
         9K2d7lA/gexgg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/6] btrfs-progs: add fscrypt support to mkfs.
Date:   Mon,  5 Sep 2022 20:01:02 -0400
Message-Id: <1c087f585f2a82b295587ae37931714578cf2514.1662417859.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1662417859.git.sweettea-kernel@dorminy.me>
References: <cover.1662417859.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new experimental option to allow use of encryption.

Arguably, since older kernels can technically read non-encrypted parts
of an encrypted filesystem, perhaps this doesn't need to be an incompat
feature.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/fsfeatures.c   | 10 ++++++++++
 kernel-shared/ctree.h |  4 +++-
 libbtrfsutil/btrfs.h  |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 90704959..ea185a3c 100644
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
index be39448f..e464f399 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -515,6 +515,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_FSCRYPT		(1ULL << 14)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -544,7 +545,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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

