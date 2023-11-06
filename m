Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9117E2F7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjKFWJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjKFWIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:55 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CED71
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:52 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778ac9c898dso260493685a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308532; x=1699913332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reEakIOm3rrykETmz3iMDC9rTy9UEkj05xNfQfA4/Qo=;
        b=CRGWLn5MbEeaHXzo4e+YS0XQhWRmuGRtuzzxc/at5RwjNSz8aEvYN7RpjxZ6MBL6k8
         4K/pbPTxNrJ++Tz7NgN9VCtxNzH3v3JflbikWSNi4oy7aa5hSNhx0fTzcSyKbUdARZhT
         0cQ9Sb4H/ohGIpFDomFEWhvGgWw4o1d7bS3lpzUlHV7geXTJny0AzwaDAzZuYwO17mlt
         dWd47aVTEHuxobJa5c3QfuNGjuSTBOxLl92bL10ZykQmHk8Rg3niQyPGwmYcc5EJS6+u
         b7H+4ScNGTWnQwsXTIVsOVv5I3oYfXc9tvpqG2mJ+ASWoLaxAnPl1E10TmokUdf3DBNi
         dUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308532; x=1699913332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reEakIOm3rrykETmz3iMDC9rTy9UEkj05xNfQfA4/Qo=;
        b=D5XpGcHLlfCC7ErcKhVNSfjk8/QAxjt29tJthNV1gm7TvCyR33If3sDYDM5wNuyVLP
         tGE3epiRplc4HMRjcxqjfUsiVmzSGJd5718cQkQ9B8zfiSaVQKFl9XXY/EIlRlHY4VBz
         Z44xHfjbfAMPc1/6d85FYfvarS/+lnX7Qa9o0kZvKwm4L4iFNo7QGXhwOymO8T14xZu/
         D3kleMl4QhjLUNDMjJarNA9p3xCm8vh7iAVCnLcJPB+pe8fraqq4ESGLscHVt7z68y/C
         /txVEvjJtAsB30TI3MyU3Av8o9EjkghRmgL53bFo9dq7G5Rbb9s8g2cHLlRsuvQZVNXr
         J3CQ==
X-Gm-Message-State: AOJu0Yw4bv4zlQJAeypS5NX58JhuNyaO7i8Wn5Ima+iAdVC6AK/z7Emz
        XDi0O6wSW8XQmJ4/ks2pYCyGPeinc1/kh/VxOwFINQ==
X-Google-Smtp-Source: AGHT+IFYfPGuFoc9TZeLp+hR3yvZR4SS9i76z2acWjsVd3QfptcaKByxxEZPVsJmqAjdUV1XgESIsg==
X-Received: by 2002:a05:620a:44d2:b0:775:9c22:e901 with SMTP id y18-20020a05620a44d200b007759c22e901mr31734685qkp.15.1699308531791;
        Mon, 06 Nov 2023 14:08:51 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y13-20020a37e30d000000b007759e9b0eb8sm3660393qki.99.2023.11.06.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 15/18] btrfs: move the device specific mount options to super.c
Date:   Mon,  6 Nov 2023 17:08:23 -0500
Message-ID: <691405bb49db78cc585dab67111835ddde69b2e7.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
index a99af94a7409..e67578dc48de 100644
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

