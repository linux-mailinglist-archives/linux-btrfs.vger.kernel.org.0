Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932477E2F71
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjKFWIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKFWIl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:41 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB8D47
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67089696545so31698236d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308517; x=1699913317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=VuEPCyVmiv47j8fjcgoD/1AfDaLySV+bMl1MCZY7D9nC/Z5dDqABGUw9pWSV0Qlfq5
         co/m7mQ6jpgwyp2TYP5NZg4/2eTdSpcw9UphCLPnt0kSWGBBjk5Utk5yMV2FOfOD8ywY
         DfqKPopxPBlIfTjs/xETE6dP4Iay+ZUlmVdjdLRiYBbEMZ4MydjRkN2cSR2Zd1SJjsE4
         S3f+B/dJNDu8j0SJDhF9OLHJZDb9WFkOA1EQKEXoR89b8Qreamv7vb2BwE4xJFlotRaz
         Z8krqKQm4JroWbmNV9/Xndac6bt1zjIidHkTVcBr98NC4Pq8mlUBKbTQjTF73AtlXM3K
         R7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308517; x=1699913317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=FTeK7lFYhOvLJV7z1dnbIT67RedGNnN6ayxeyE4Jt1Aj24CCd94KwNFQbyUCWywXEp
         JOyfXdlPBCT6e68TRWWUhZv3sCMGPnxYQMg+KVyH7QpsEz215HTlM+5DTi9516HjuMiL
         zB3xYVmBI/0FzxV7Stfn/8Igsf28y/YLqfXtfnGXx61LnhH5CJTBqp+iU+uE8TBHshTD
         EuLWlVHvB806yaN9CuIG4PhDd3SXneGUv04zTRuLttSNW7uk4ECquk4hLgNG0gOlmB1j
         bht/+Sw4Z3jX8+QYl2X8hTR9cA8BCi/hnUOT82L5GKhs7hmBrrbQ/YlhpwUjdkH47FpI
         pR/w==
X-Gm-Message-State: AOJu0YzyxTcyYd0HDTTFnsV0M/rappx9MEksNNusAxtxXvZI2zhi1zqU
        c5qLLakkHj48K1Ryiisb7orIUUA9pX6FaoFpYv4FAg==
X-Google-Smtp-Source: AGHT+IHTYcyj/yGwLeP8RSSKs+dngQ5QGF5T5Msr4rMOHiK6M/weyhgIwMWFNBolNUanVCRgzi5vpQ==
X-Received: by 2002:ad4:4ea7:0:b0:66d:1215:6e3 with SMTP id ed7-20020ad44ea7000000b0066d121506e3mr36732241qvb.10.1699308517534;
        Mon, 06 Nov 2023 14:08:37 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l8-20020a0ce848000000b0065d89f4d537sm3789905qvo.45.2023.11.06.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 02/18] btrfs: split out the mount option validation code into its own helper
Date:   Mon,  6 Nov 2023 17:08:10 -0500
Message-ID: <83e9157999dd0bc41ef1c267a6d6c0a83b36340d.1699308010.git.josef@toxicpanda.com>
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

