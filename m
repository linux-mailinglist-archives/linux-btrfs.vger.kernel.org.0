Return-Path: <linux-btrfs+bounces-35-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EF7E5E35
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310051C20C17
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812437160;
	Wed,  8 Nov 2023 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uRyDClvv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0B37141
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:18 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72CF210E
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cda69486eso373521cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470557; x=1700075357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=uRyDClvvXhHd3k7M/RgCwZz65rhYU4WYWaoinyTl+3EgPHDgq5LmGZ0hALxCsK1Cmt
         w4mDpsEouceT7079kc/vcOdsrZoEW4kSw20jdl3QxZdjjY8WMr3tP2V8vLqMrkHaP6AS
         9nUkck5pjQomLzf4QT6QqU31IFbuG0pggbd0NqTevookLm55nokHt1v2sfxDIkMLchBf
         M1SusJbJwiNIz7gKPTgkDDs21gfMZ3nQWjUVQL+PREZjbH8xoJBPW1+p2vkHBY1mRYc3
         EqwDm2sDnOgCDuNPwgLUsK2cbxZi/VDUCeenIG23oJwDrgUXL6LnKAXxwlx27OZCXM6S
         EzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470557; x=1700075357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=trNqEuBvHKoZ8LN8E5lpMu+l5ApWA0lyY/hdEj1or0BDVRgsowsQPgIU+2fiTApoSy
         5DDm7emAlrWzq1Krdvp93l2JEWsaBwLvA/spvOGmPak82KPuk0k8bUHkqWVGq2teBZK4
         RLLcXevDuNmJnXTGzU3+Wsi7NZoTPL9kgS/a8X2tA27uzFtDDDXRSDMFNyRsjQ+fKRPF
         D0Ul6FwDNd6ZngGOjKgM7ppunus0ePrrxDHjhXCkT9h/e24fSkxByl2HbdyBks8njfvR
         Fshbfab7+dJwEThEqM5S1CULAcjvQZO1n1SPjmXiNnwE1NlsNunN59V5e+GPfO8hx2Z5
         aeww==
X-Gm-Message-State: AOJu0YzHQGGYL35NSxGau46RkhGKgzohQnKq+HxFCyqBYqSdZoSxUXKz
	AnGN1V1DRXn3LH3zn8TwJ/c6/udLb/K5FU4enFzK9A==
X-Google-Smtp-Source: AGHT+IHt4Oah385KFQK1VKUiP11Y0nIjrdVQdzbBfpnhvKSUfnu4hGAFWaasI8rWrjaOuYukVVTA3A==
X-Received: by 2002:a05:6214:5183:b0:66d:17a2:34cc with SMTP id kl3-20020a056214518300b0066d17a234ccmr2598056qvb.64.1699470556747;
        Wed, 08 Nov 2023 11:09:16 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dy7-20020a05620a60c700b00770f2a690a8sm1337020qkb.53.2023.11.08.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 02/18] btrfs: split out the mount option validation code into its own helper
Date: Wed,  8 Nov 2023 14:08:37 -0500
Message-ID: <f30ace3052a298c6536453fed66577c308c72d2f.1699470345.git.josef@toxicpanda.com>
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

We're going to need to validate mount options after they're all parsed
with the new mount api, split this code out into its own helper so we
can use it when we swap over to the new mount api.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 64 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6ecf78d09694..639601d346d0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -233,6 +233,39 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
+static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+{
+	if (!(flags & SB_RDONLY) &&
+	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+		return false;
+
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+		btrfs_err(info, "cannot disable free space tree");
+		return false;
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		return false;
+	}
+
+	if (btrfs_check_mountopts_zoned(info))
+		return false;
+
+	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			btrfs_info(info, "disk space caching is enabled");
+		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+			btrfs_info(info, "using free space tree");
+	}
+
+	return true;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -311,7 +344,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
-	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -330,7 +362,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	 * against new flags
 	 */
 	if (!options)
-		goto check;
+		goto out;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -774,35 +806,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		}
 	}
-check:
-	/* We're read-only, don't have to check. */
-	if (new_flags & SB_RDONLY)
-		goto out;
-
-	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
-		ret = -EINVAL;
 out:
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
-		btrfs_err(info, "cannot disable free space tree");
+	if (!ret && !check_options(info, new_flags))
 		ret = -EINVAL;
-	}
-	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
-		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
-		ret = -EINVAL;
-	}
-	if (!ret)
-		ret = btrfs_check_mountopts_zoned(info);
-	if (!ret && !remounting) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
-			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
-			btrfs_info(info, "using free space tree");
-	}
 	return ret;
 }
 
-- 
2.41.0


