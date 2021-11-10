Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5001A44CA57
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhKJURt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhKJURs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8167C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:00 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o17so3317626qtk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EsrZbE5IMa4+oE32EaQaDzUdZDifMpyNY3/MtyR/nVg=;
        b=5jcc1T9GYSmgoxYn86xVZ/O78xRFzH4tOEb/aDpkLLMvo6/AFNStL4dV2juzztEBES
         /cTgSQp1Ob9W2h2cXesVgvxBNkKGhyVcibStA9m/eVZgsEqRX2atwYqLAye6dNl85LyB
         gFcakb9X0zDFDJ4DMdPbkfNtI8ZzoKX6NaIMOMBGw/xeUTz+GRD4N1jqImA6+KYr+PUi
         6rRyC3dihvjeor7KqFkvAoikBPbdiJ+VfRHor4LF38xIVH+GHyBtN28i82IlFbUzWi8T
         3a+tF+JWVmluewIM9PozQYCBlc11hJkq4rw1BIMmT0REisrL0blatK3jhhPmBt2x7FHS
         DUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsrZbE5IMa4+oE32EaQaDzUdZDifMpyNY3/MtyR/nVg=;
        b=lgmkN1Ph1f/J4RrlDbnpiuyCk0ZOX5Lb6xVU6ZUxsJHImD5rEA6w2slUFLTGzB0CzW
         ELmRgI/bosQQMgOamLHhv2Z+Haxr4szxG9eKaRqkmXuerp+WYu4f2HPA82QqKPnovIKC
         8VXmooJQGaK+3MiGTIWfCA5MokaN3X4Zdy/IKnbyA5aYrYBYQ3d/4CMmsgvLkpGro4u+
         GW23c499GE7EFaruavckf2LoBnFwaKLRP6tL3TjdMY/h9ZwatAibeBO9s005LZXsLE1p
         OeMQE5XP5hRC3Tds/Gwn+l4kkjSZmj8u9hLhB25OmzOxokdwdqkYswNBka1X/JNLCPTM
         CWTg==
X-Gm-Message-State: AOAM530TuO7a+I+O071mpsDWBWdH5UJEnyqvBsY/yisJ77RRzpKrlW0D
        meL4V7nAVsx1l9o2hF0p4JEjtfqEsmzMzw==
X-Google-Smtp-Source: ABdhPJyhoq5Z2EiWgqdsnoFV7E3J3y6uNNEX+2cKQczHo02s70vyJ8uQpE8UwdM6MMpe1Uo0/5JuGw==
X-Received: by 2002:ac8:5cd1:: with SMTP id s17mr1840909qta.159.1636575299784;
        Wed, 10 Nov 2021 12:14:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w1sm489904qtj.28.2021.11.10.12.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/30] btrfs-progs: common: allow users to select extent-tree-v2 option
Date:   Wed, 10 Nov 2021 15:14:21 -0500
Message-Id: <9d422ce7a5a601d38bb161cd01b57a5277e49175.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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

