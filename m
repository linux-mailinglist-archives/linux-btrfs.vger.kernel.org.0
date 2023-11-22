Return-Path: <linux-btrfs+bounces-295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723867F4E15
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA79A1C20B5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828A58AB1;
	Wed, 22 Nov 2023 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NJaq8b63"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2A219D
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:05 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cc636d8a21so8986367b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673485; x=1701278285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wcEQjma5KAu0u3aa0GBWyEj4pLCTyUpOPwDIPpwmFI=;
        b=NJaq8b6374V/5vZnvJN/aJXqcNDIvOFl66FjZd6nLWe1GeLDyAw4W2OiJiaUGJrrGQ
         zLD22W2ueO9U4AEWNEvnnJTq+UD95hoJKa5yAHsaPhT0wXJx7kUaMgdLwOIGc2UqRR8D
         zDKKjFsG3xpDK+LnhKhajnFPBqTC0TNfAnZufQEskbNCTCLV1lY5tMwvgvsGpx+UPP7F
         aXEqmvPuU4Xyv1el1ZuRF0urlTGaCONui8v3Bj2MLCj/ZCUsyGsPlae7vpIKlQLog53n
         oI5aP1kP2M+cpbV/Wi1l7w+lrGYzvDkSGJ/PzhlP1Vr6jIDxGJxsz3Ax2RL0svy8AXxa
         Tzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673485; x=1701278285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wcEQjma5KAu0u3aa0GBWyEj4pLCTyUpOPwDIPpwmFI=;
        b=kJrP9EGhQTVyLZRjMZ1AzilE4ZO82kiyac3md6qUs297zXh75EYQrvAEH8P2R3SsLi
         8FunuxxtEl1l8k23EKyIoFJ80RldCLFxd08fAp7E6bn8P5blI6DQqOWUGwLeqm4qh3Ml
         ZnlDvTybFyAF7WIwqO+dL1gzc6urvhjkQ7EvcOnPXHOKkSb/07f4vrMdx7slCN3MQgMV
         SP/N6rSCBpa6IWBuiMRoaYtI3KH5ElnbcyrmQomvwwHGjI3DqM2K9IlI3NWyRSSyd4Hs
         7A2SFoB8s8HV18YRaFNaM3mVa1k+49pz4ZTBxIa3mxGusSg1ljacMp86dljOXwMg4p+A
         hatA==
X-Gm-Message-State: AOJu0Yy0vQzbWGZ8lsbp9EpBSEepBnz1txecNxHdnsCbDK0QsIAZZDWc
	0OCE5RXd/DW1NQUIA0p5P+x6pnCTEEO+slr/Hf7HZO5M
X-Google-Smtp-Source: AGHT+IF2oa1Y617bqKgJ+T+OHErQBcgDqNjBq3d6C0xa5Zn+ahFBtAqVPPas9VhVPSnhAgXvDyNi3g==
X-Received: by 2002:a81:9148:0:b0:5ca:c869:8df0 with SMTP id i69-20020a819148000000b005cac8698df0mr3108926ywg.4.1700673484774;
        Wed, 22 Nov 2023 09:18:04 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h7-20020a81dc07000000b005cb331f463esm1520371ywj.8.2023.11.22.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 02/19] btrfs: split out the mount option validation code into its own helper
Date: Wed, 22 Nov 2023 12:17:38 -0500
Message-ID: <75d5596daec83241f5cb6dc4cf5d2541346917b5.1700673401.git.josef@toxicpanda.com>
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

We're going to need to validate mount options after they're all parsed
with the new mount api, split this code out into its own helper so we
can use it when we swap over to the new mount api.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 66 +++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ef256b944c72..008e027fea15 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -236,6 +236,41 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
+static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+{
+	bool ret = true;
+
+	if (!(flags & SB_RDONLY) &&
+	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+		ret = false;
+
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+		btrfs_err(info, "cannot disable free space tree");
+		ret = false;
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		ret = false;
+	}
+
+	if (btrfs_check_mountopts_zoned(info))
+		ret = false;
+
+	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			btrfs_info(info, "disk space caching is enabled");
+		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+			btrfs_info(info, "using free space tree");
+	}
+
+	return ret;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -314,7 +349,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
-	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -333,7 +367,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	 * against new flags
 	 */
 	if (!options)
-		goto check;
+		goto out;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -777,35 +811,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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


