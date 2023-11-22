Return-Path: <linux-btrfs+bounces-305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052697F4E25
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B9EB2174D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53C03FB1B;
	Wed, 22 Nov 2023 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rzC16qit"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5DE1B1
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3303126276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673499; x=1701278299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfG4hyB4O5XNpX1RJYjLDGWKE4yC6O/Sj1eGyBCJcN4=;
        b=rzC16qitHtEUDtPpdRTpdljHJcRB6Ng/e52bq3+UmSyFCMcK/Zz0cRsBsBB7gdGzAn
         KkbKZG0f/EkYzy6rSqgTrRRgEJApSEuYKN9bGTPKgevBz3mRadjsdJCls0M5ewMG1YWe
         eYboI4EAVIv3aIKXm15RBUjsFsKxtTC2FFXihWVrEhXPQKkH1/GsAZLbHQk1197Xnwk5
         cMosl+0rFhH1uaOZC8gs0sKAx+871eZr8Pvon+2ECQnHwbRvKTAKXMMl8POJf0nY/lhW
         04UnRNc9MtfAa9SqKGJgCFoBo5fHz6jGcCmZ3Vv6StsbjLdyARVf/GADihKa6aYHPkWc
         pWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673499; x=1701278299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfG4hyB4O5XNpX1RJYjLDGWKE4yC6O/Sj1eGyBCJcN4=;
        b=tn0cBhlMYwGLA8gYMGM9g8YgvNiFSjUC8e40BmVAJn5EYz+h3Bfqaf9aP4vGwLuItI
         U4GQemKTIzWzpzqUNa289+UO05P1RaTkuuI/hVq/bQL69iEQICGZPo9OpRX2wk5XhBPu
         vsf3Cff0KbH6S6waxwRsPHJgUln9r9r4EiqyQhJJnnwYkXSNatftH2wwni0+AcKBgnUc
         OWoMpd79l1n8liN+7b2HFgN3iy6qrMFZiTUKxKiOIczr8ShRant6nzwD4u+NwsngCKhI
         +iG+TTvXKmWA983rYQiHhY0OH+Fuw7WqAiigQANgawsdqtv3EhdYN7GrAJJkdBklNhNx
         8mxA==
X-Gm-Message-State: AOJu0YxxYNRW+9age2pA4xD6hoLtCMVN4EfUxh8DEzfviITp/UIvf5Z6
	oj9fSmtaJy+dMFbBPNyZtgO4Jw8Y3Cx9ImlmuEIAM0pg
X-Google-Smtp-Source: AGHT+IHS7b91/ODATFX/M3iG9EwQI8nHpGObE3DCFudOQoDcFDvKF/GdBMLBFlaVM8YfLoXOq93TDA==
X-Received: by 2002:a25:8748:0:b0:db3:fd83:e0f with SMTP id e8-20020a258748000000b00db3fd830e0fmr2549769ybn.10.1700673499263;
        Wed, 22 Nov 2023 09:18:19 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d13-20020a5b00cd000000b00d8674371317sm1447110ybp.36.2023.11.22.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:18 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 15/19] btrfs: move the device specific mount options to super.c
Date: Wed, 22 Nov 2023 12:17:51 -0500
Message-ID: <cf71190d0187bfc665814b2ba846a7bac3b53caf.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
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
index 6df8dbea3581..367bf31230df 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3502,29 +3502,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index 3bb77fb72f03..a6d4bda7330e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -832,6 +832,29 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
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
@@ -2889,6 +2912,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		goto error;
 	}
 
+	set_device_specific_options(fs_info);
+
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
-- 
2.41.0


