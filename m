Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC6465513
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbhLASUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352197AbhLASUl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:41 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D8C061748
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t11so24974134qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HuGfPdSGj3prkysuHHWnX3MA/RiJrsDPJ2DhpnRJ6Yw=;
        b=3hmNh5RFEyUEaSLEvgsNgOBsw6LfnECgnYFlS4r5PwXgAsZsrMuRPBhBXon7VRpclq
         oJ9pqGCFTLueNoxlsJGgDvOtTn8onoCcVpcBw+UcxSbCPl0A9y0fbVoCDgz2rrpZScP2
         egiTRyrpczJU0AX+7v/PCQoz1COFRzPQ9IWgJh9rpH/8fqYjF2W2lvwRJ25OMmt5gaE8
         17HMatMG49hv1zz/y4HpfuSInMHZHfAMnQaYvYiq9g9IrC/yoRYb/7SrSXJOqm3sNVqT
         5LFwRckEbT622bDXPDNNiWqyX57fr7q/iKH0jHXw91LIgBEvTyr1R55z/sNlu49g3sRP
         nXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuGfPdSGj3prkysuHHWnX3MA/RiJrsDPJ2DhpnRJ6Yw=;
        b=MQgVlwtRbd1iY0JsiXUcFp4qG6eOHnlZUfq6fR9cAh0vJDSz6+99RkVfY31InRrx/2
         J5rBslcXwpUyGOD0tYx5Z45JY7f3mnyb+fRcfCZAPcnOgt1gAQVDwT48P04IN0bujKe9
         ruLMVgJLX6lfpg5g2MY1c3O4/ecc7Yzb6W+kkpeWyGaqZC+JxIcDxJKKAH5eOtIK5eyG
         ST68iZNuK+djBIQqKU+kMFKFsj4YD2M0AY49hYkDc++VsLcaIzL2jp7/SOF8W8pJdU2Y
         vQ0OADps+7tzviwDrZAw1i3oJTXDLlooReHsM70hHcc4AtG57N/0Q6vTVHSCZGWUjZ+L
         Y47g==
X-Gm-Message-State: AOAM530ToAlz18l5/R4hJOTM0Uk5cT01DhsfMzYKFHJp6znv4h3XfqVF
        OupoMeE+cGgmFB3B8aL1bGUP8VwdOkMbxw==
X-Google-Smtp-Source: ABdhPJx+Bw2+IIcqUvKcKfjHG6X4yOfx6LZsxta06YY5QVZ3C1OIOyL4SSsCNrdELCEi/gY/aEDvxg==
X-Received: by 2002:ac8:7e8d:: with SMTP id w13mr8789225qtj.527.1638382639126;
        Wed, 01 Dec 2021 10:17:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f12sm223525qtj.93.2021.12.01.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/22] btrfs-progs: common: allow users to select extent-tree-v2 option
Date:   Wed,  1 Dec 2021 13:16:55 -0500
Message-Id: <f94351b4caedd5fbfbffc2e8d9cc86f22dc47dcd.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

