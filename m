Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC64469D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhKEUne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhKEUnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8708C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g13so7868436qtk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EsrZbE5IMa4+oE32EaQaDzUdZDifMpyNY3/MtyR/nVg=;
        b=5VVfLPwzESgxECkpYQUwUfROrecejyuIhmRPNhQu1deupZ5U31lpUzuexDr2cH+wzk
         ih13u/zaHXF7ferjjnwWkvvti5dSocG2WrktZNiFRCZk76XJSq/HSNFOb5UWK2ONxul+
         pDDXm9tQnMCu7drQiWlcotkSRE2hvSy/N0T/wyFXPZ2ix2DFflaUnhqlS7v0PFnBcUBF
         duooVaGcc2zVZk3mjX0xmJqBePYtZ8lDyEfBktK5ppvlh3LAc2mcp1pCLLrhd4JsCDrM
         OU2xgYueUwifqtHK676WvM/Qwohci+J9QHLFFul0zXqvMGxZxb5VHGjXi7ccEMA3impr
         i/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsrZbE5IMa4+oE32EaQaDzUdZDifMpyNY3/MtyR/nVg=;
        b=4C7CBVyrvodJCeLbhmMja0CMUOB4ueREPBf3Hru4ne9AUKiYSZboXRCk1xe+YeqBH8
         EMjDeuvjEzrnoFXNHrpudRr/qr/k7KyJU8OknYellgd154n/bl2saUd26kVM0+1ahOPL
         kV2mWYEQCy111VMC0eIxTlZx+1ASiTKLlHCAWIyBeIc2GH9e+B1eOD+2DTtTqt1WX0kP
         RlxcyIKgCRp55UaYDAX0a+VsUbDrAmLeDMPCjpdpHnqeB9OS1VntNeK/7XdrwRcHjG9o
         7Mz/BLkWsIwjpvhuuiYj9iHaYbAqCBUNBGyfExRLMW3CS40CoNUUpG6jhe7EhQKO4jW/
         sv9g==
X-Gm-Message-State: AOAM530Aokm5kpa8/u6dqRoxQmkCbS1YhvgT/O46BEy6tGvh7ZGugzOK
        oR+vFCoaRmLdhVzC3Qcd7bN8gQyeI6fNFA==
X-Google-Smtp-Source: ABdhPJwcq9OlB6HfoKW4crRtI/yC5fRjd3QvViLDEWABXWU9fvQSNcwUHzZMjwQFdWm/LIdGy4XKGw==
X-Received: by 2002:a05:622a:2d5:: with SMTP id a21mr46231690qtx.48.1636144850766;
        Fri, 05 Nov 2021 13:40:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de26sm3935872qkb.81.2021.11.05.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/22] btrfs-progs: common: allow users to select extent-tree-v2 option
Date:   Fri,  5 Nov 2021 16:40:27 -0400
Message-Id: <7745f8ddba3c384a28cbe9e81f1cdf1572b251c7.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to enable developers to test the extent tree v2 features as they
are added, add the ability to mkfs an extent tree v2 fs if we have
experimental enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/fsfeatures.c   | 11 +++++++++++
 kernel-shared/ctree.h | 18 ++++++++++++++++++
 mkfs/main.c           |  6 ++++++
 3 files changed, 35 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index df1bb8f7..23a92c21 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -131,6 +131,17 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "support zoned devices"
 	},
+#endif
+#if EXPERIMENTAL
+	{
+		.name		= "extent-tree-v2",
+		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
+		.sysfs_name	= "extent_tree_v2",
+		VERSION_TO_STRING2(compat, 5,15),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "new extent tree format"
+	},
 #endif
 	/* Keep this one last */
 	{
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 12a8165d..8a46306e 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -507,6 +507,23 @@ struct btrfs_super_block {
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
 
+#if EXPERIMENTAL
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+#else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
 	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
@@ -521,6 +538,7 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED)
+#endif
 
 /*
  * A leaf is full of items. offset and size tell us where to find
diff --git a/mkfs/main.c b/mkfs/main.c
index d0c863fd..2c4b7b00 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1223,6 +1223,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
 	}
 
+	/* Extent tree v2 comes with a set of mandatory features. */
+	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
+	}
+
 	if (zoned) {
 		if (source_dir_set) {
 			error("the option -r and zoned mode are incompatible");
-- 
2.26.3

