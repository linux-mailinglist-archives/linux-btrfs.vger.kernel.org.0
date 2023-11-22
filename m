Return-Path: <linux-btrfs+bounces-307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745FD7F4E26
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DFFB21806
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0B58AA6;
	Wed, 22 Nov 2023 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zvCOagGX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073C197
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so10189276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673501; x=1701278301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9f/7IJL9HuJi7e0J8Xeyt7VmGdh90l2ExAlFN14VjDU=;
        b=zvCOagGX1Rrf0TbOPtOF8onkcz6rW7V5HPG8S08ZnNwQpadaOUV2CW5aMF7v9gN5fD
         FB+5n/Qwzw5jcOna0Z0HMTF/0Nra0YAPdanUFbL9UpVGhVaiOAcoy2HKSuT1ie6YMk+t
         0vLWxFjqIhDNtudDb7lHnJr3pLe43UgeOtUfSUiE9toi0spmANdv8jiLaFSIHQmGBG7t
         azOvbq2GEvIA/XJFCbvDPYnzV8mWzwAr6rD+RPIZNo03xnwf7TsrzZO0JnjvLUFCQZMn
         OWEib5DVbi9RaPBwb8VEwZgXBzUVhl6u3qQXzkrC/KyWehB7OL2Vbu9bYN0wmA3W/9C2
         1Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673501; x=1701278301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f/7IJL9HuJi7e0J8Xeyt7VmGdh90l2ExAlFN14VjDU=;
        b=UvPQwPxbEdkYp6v0E68Sj0ErGc+Z2jqv2AHmGa+yO3xgiOKxuzYh849K28aCIaNl/3
         okd2Q7rNX6H3fwHTDv2siB/VGgEAFuGelBhMaQzl4dGH74g9Zn7VlTZvBeqpkUQIuSk5
         6xXbJf3MZ/2gHSMOu5TDasZU76VjP3rNiwwnMW1FI/IWjyWKnoYt2AxB+cgFCq7DYUjK
         ICpXNfv4GWameKHJLsjoB+7fgSX0imN5Tz+Z6Q8eE21kL9Jq6nXQ6Wpzk1Q9r2X+T9Yk
         Jz51+ECeObx0z47L0dnrnPa7bshrcUQuFJdM+wt9iUx9vgV8kW8i2voKZitmdMw5bKg4
         rGgg==
X-Gm-Message-State: AOJu0Yx4rHq/GqxIv6gk7L8zZeZk/kOn1yn1QeEJ6x+R9A3V5fsxtOOK
	XM+bTeuaE6sTABGfTfJRJ+iQEbK6Nxd7AXeh4DBmyPN+
X-Google-Smtp-Source: AGHT+IFDbkBGOCVayyn3PCgTN/nhyKMLuFUowd19wl8yJnnGjAVJ/cZexlV9FpAYD1cX4jdmJYE4kw==
X-Received: by 2002:a81:5e83:0:b0:5cb:57da:e607 with SMTP id s125-20020a815e83000000b005cb57dae607mr3175311ywb.30.1700673501252;
        Wed, 22 Nov 2023 09:18:21 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m4-20020a0dfc04000000b005845e6f9b50sm3832508ywf.113.2023.11.22.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 17/19] btrfs: move one shot mount option clearing to super.c
Date: Wed, 22 Nov 2023 12:17:53 -0500
Message-ID: <916760deedbcd13112c16879c42e4f657dd78f89.1700673401.git.josef@toxicpanda.com>
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

There's no reason this has to happen in open_ctree, and in fact in the
old mount API we had to call this from remount.  Move this to super.c,
unexport it, and call it from both mount and reconfigure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 16 +---------------
 fs/btrfs/disk-io.h |  1 -
 fs/btrfs/super.c   | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 367bf31230df..c688eba0312f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2938,18 +2938,6 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	return err;
 }
 
-/*
- * Some options only have meaning at mount time and shouldn't persist across
- * remounts, or be displayed. Clear these at the end of mount and remount
- * code paths.
- */
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
-{
-	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
-	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
-	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
-}
-
 /*
  * Mounting logic specific to read-write file systems. Shared by open_ctree
  * and btrfs_remount when remounting from read-only to read-write.
@@ -3527,7 +3515,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		goto clear_oneshot;
+		return 0;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
 	if (ret) {
@@ -3555,8 +3543,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
 		wake_up_process(fs_info->cleaner_kthread);
 
-clear_oneshot:
-	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e589359e6a68..9413726b329b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -37,7 +37,6 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f5bf53f826ef..30603248b71c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -635,6 +635,19 @@ static int btrfs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
+/*
+ * Some options only have meaning at mount time and shouldn't persist across
+ * remounts, or be displayed. Clear these at the end of mount and remount
+ * code paths.
+ */
+static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
+{
+	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
+	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
+}
+
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info,
 			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
@@ -1878,6 +1891,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		return ret;
 	}
 
+	btrfs_clear_oneshot_options(fs_info);
+
 	fc->root = dget(s->s_root);
 	return 0;
 
-- 
2.41.0


