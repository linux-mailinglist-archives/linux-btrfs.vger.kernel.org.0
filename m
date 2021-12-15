Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C476267
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhLOT7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 14:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhLOT7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84782C06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:53 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g28so21204563qkk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HuGfPdSGj3prkysuHHWnX3MA/RiJrsDPJ2DhpnRJ6Yw=;
        b=lJo+ntBPLqOXP25NVBJuA5UCJ/6iPjPtmLY0uFZCf30JkR0VwOekU4oMWvrgFHS2G2
         /JG6MHAiY/Be8lYT0mkGhZ+G/id6/2cQWSOhDdyoBrpF1J2qP7dUUrovkOJr4FRj9TFY
         zEQF/252tXAfGwxVsns9Fp9nCFSrgOAU9daUjEBdH146xMynJmm1x7Ih2NXE62xmHrVv
         wYGnQPbK8SYvnKrlnUpq/2Bt2KjjazrqO7sC5ERGlLbDDNM8rQsYWflkhnpmHBl2/ajk
         VDNfDIK73HSooU++BratXES1zHJM1fVr9lZ4whqOMHjKp5BAACfGBW6hp4eeVLNHpS0m
         afKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuGfPdSGj3prkysuHHWnX3MA/RiJrsDPJ2DhpnRJ6Yw=;
        b=2mejcGgX2JcQKf2PVM17hOlL7BLdBXPM5E4WiCRvAFvxMHhFzrGXMZR+5ADfJLuSsw
         2FF37z+WKO8BCYmICwxYUSvTiwHw5Gnt1wgj3M+DI2MIK1o4bNX41VsHMn5r7/pUFRoT
         SRo++J8Kul/CQgXVA+2nLMhsHd4vVpv3zF1aq7DmvZtjj9nesrFOHxpeTgv1tuVNDwJx
         6XylLTdjg/xmsh+TAjHiaablqwBmPsgm7Iok/QHGJwnbE3OXgulSH/F22meYDiYdbJ8w
         c5PRRgKFXBNLTS8LZBPmjHmmLC0doAdH+No4Ntos5p09pNme7UyNZPNT/dVxNru9BCCn
         pk7w==
X-Gm-Message-State: AOAM531vumFFPKSF31e35E+TiXfyLEtzYFKp7JHOP8PUUhQDP5co2n3+
        CeXUBH3LpSqcA8TvFed1RYBUcE11jItErA==
X-Google-Smtp-Source: ABdhPJz0kMmhVHKWHyZVRxIX5WlprcA8mR1zxybMo8AmWoJnT1uoOCmSkymxEGe5snJRIIaf9eSWMA==
X-Received: by 2002:a05:620a:1f8:: with SMTP id x24mr10101854qkn.780.1639598392319;
        Wed, 15 Dec 2021 11:59:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u27sm2186600qtc.58.2021.12.15.11.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 01/22] btrfs-progs: common: allow users to select extent-tree-v2 option
Date:   Wed, 15 Dec 2021 14:59:27 -0500
Message-Id: <78151390ea8c1087776aceca2b993e43fca2c4c4.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index 7a80fa0c..9f7ccd38 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -513,6 +513,23 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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
@@ -527,6 +544,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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

