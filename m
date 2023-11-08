Return-Path: <linux-btrfs+bounces-48-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105887E5E53
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031CF1C20ACD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F93984A;
	Wed,  8 Nov 2023 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bT/wBbzY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAA38F8C
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:35 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFE2116
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:34 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b3ec45d6e9so28825b6e.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470574; x=1700075374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WGcH+vh3MxMHVr4lGo2U8HngouNdzqsfhTQcZZzMkA=;
        b=bT/wBbzY227Xy+zbPa1ePt6whpv9H+SfuaL4yAJ+w5maUcZRXswmDL5+l1+MHedXJv
         /OWRtoht6jWpRjjd0cD69Jzg8AJo2C0Ayp+D/ciY2zCbD3wel4GzHHKHFmcJqUe6mU3R
         Q8xuffrXiWx9EDEtxaiLEAtPduuWK1uOXDg1E9yLAAeWXRfD6T3XonmAr7PlnHzUcaKV
         cdalMdF4ZFEuvWsuAhX4U9grsItG4kKLpThDbt9xCQaNm32dKoxdX78Wz6iRpz6b9LEc
         jfWkCmWvJTbfT9jneZSJoETwO8ISCk19cKcyrQUI30SgNi7BOScxRsmgnXOEygjtDzr3
         Qo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470574; x=1700075374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WGcH+vh3MxMHVr4lGo2U8HngouNdzqsfhTQcZZzMkA=;
        b=KeAtLTz6wL4wDxAbl0gohH2zLauITdvjLeR4lfA6DuKNYif5idPZia4qZNe0ZAtJg/
         Tw5Y7LE2aC5h9PfY3EFpv8gTIzFY43/Plue/S8xmdBSpoteR5xWryTJtG/Cq3Eo1UtFN
         lf5/b9bJ0/Z2BWJyPOFmiDKmlBOTB0i3Wmv0vNanS3Yolq1kHwvHWu3J9+fu9EujoNrw
         XOOLTNzHDoKoNbVXYOOA6jVrMy210Z8/RGZ+ucpuYqwSZlKNm6o/crquLB6ezwy+ZiVw
         hAbSDQixEiSFyX2t8RMLfJQfomPh8QSV0XBW9bwyoZk9p96MOFVpVqQjcwnjf9EhQF3X
         YgHw==
X-Gm-Message-State: AOJu0YyHz8WGC6fUYQ33khkcy2J7c04X3s+KuDK48hlQnhoIkleeFMiY
	QPTddmNDGfuVoiLfBphjZ77AlKlVe+89iT3eK7uM4A==
X-Google-Smtp-Source: AGHT+IESR9XGLOO688poD/IlDJXg9p38Nwmif5DC9D65IHPpKvY1ciDYmjiw/3KU6uvUh/dp0GjDvA==
X-Received: by 2002:a05:6808:2341:b0:3b2:db61:ff8e with SMTP id ef1-20020a056808234100b003b2db61ff8emr3136993oib.33.1699470573899;
        Wed, 08 Nov 2023 11:09:33 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a220800b00775afce4235sm1327729qkh.131.2023.11.08.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 15/18] btrfs: move the device specific mount options to super.c
Date: Wed,  8 Nov 2023 14:08:50 -0500
Message-ID: <be68ae40b612c046bd7ba843d7424411f02d788b.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add these mount options based on the fs_devices settings, which can
be set once we've opened the fs_devices.  Move these into their own
helper and call it from get_tree_super.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 23 -----------------------
 fs/btrfs/super.c   | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ce861f4baf47..50ed7ece0840 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3483,29 +3483,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_cleaner;
 	}
 
-	if (!btrfs_test_opt(fs_info, NOSSD) &&
-	    !fs_info->fs_devices->rotating) {
-		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
-	}
-
-	/*
-	 * For devices supporting discard turn on discard=async automatically,
-	 * unless it's already set or disabled. This could be turned off by
-	 * nodiscard for the same mount.
-	 *
-	 * The zoned mode piggy backs on the discard functionality for
-	 * resetting a zone. There is no reason to delay the zone reset as it is
-	 * fast enough. So, do not enable async discard for zoned mode.
-	 */
-	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
-	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
-	      btrfs_test_opt(fs_info, NODISCARD)) &&
-	    fs_info->fs_devices->discardable &&
-	    !btrfs_is_zoned(fs_info)) {
-		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
-				   "auto enabling async discard");
-	}
-
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ce07d255497..c6c2bd407f90 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -823,6 +823,29 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 }
 
+static void set_device_specific_options(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, NOSSD) &&
+	    !fs_info->fs_devices->rotating)
+		btrfs_set_opt(fs_info->mount_opt, SSD);
+
+	/*
+	 * For devices supporting discard turn on discard=async automatically,
+	 * unless it's already set or disabled. This could be turned off by
+	 * nodiscard for the same mount.
+	 *
+	 * The zoned mode piggy backs on the discard functionality for
+	 * resetting a zone. There is no reason to delay the zone reset as it is
+	 * fast enough. So, do not enable async discard for zoned mode.
+	 */
+	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+	      btrfs_test_opt(fs_info, NODISCARD)) &&
+	    fs_info->fs_devices->discardable &&
+	    !btrfs_is_zoned(fs_info))
+		btrfs_set_opt(fs_info->mount_opt, DISCARD_ASYNC);
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -2913,6 +2936,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		goto error;
 	}
 
+	set_device_specific_options(fs_info);
+
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
-- 
2.41.0


