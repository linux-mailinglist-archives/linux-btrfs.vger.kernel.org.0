Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4155476383
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhLOUkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:21 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8CC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:21 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id gu12so21419714qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8MG4uDwmla5Lj4d5wOP0QAjU4ZTXVUA83IznF/I9GTs=;
        b=c/puuqr8x7n/BuMFInt62BMT4ZJ4xVgDCUAIfx/rbgZ4ZP627SuIKD9q1nHNbILFeS
         zBjfZ7IRUdt2q9R16GnDyW6Sp4AmYGY6KB5Q53CqmmTfOqAI9AlT9yRs5GGInspYlAE1
         UaPwszlE+fGYMgW1Ej9GmTf6GYpui3mQEe2xo8+/b9TVsgOAkrl0S9dkzlH4ld5x7Vhs
         VCbCpW8fk9QR+siHsPXSNfOG+ZbaADXUMjYRKA+FXy3/xz9nBVzrcRel7V102sWGtzF2
         Maw9HTWJp6JHmIw5UDWFZ+Qyud9ZWqwKbp/oPIv9K8uJfx3ejz8Jv2/dEGmo5OO/YHGM
         Ztbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MG4uDwmla5Lj4d5wOP0QAjU4ZTXVUA83IznF/I9GTs=;
        b=4RWRSdyGHBp82VZ3VxSW+w070CRxzYEQPwJLilf8TIwmSChk1Q7R/x/0Bj808Cresm
         a5DARhq9atCGsYwe2fKECTICFEKQ6jpK0pxeqSivbBkauWJGYkPr7T9RERzXmi6M2P3b
         ukDjd5fnnoO4zdb3sFXXULHKEQCoaoDlrz0oytvMmk6/izsSd102BgIrdxQ4RjWeoUDJ
         3WhgdmCh8SeUhOjTAztlskUQ4ZqrqCMFWrT5tKHcxJar7FknyiPV9Ac5gFgtwYD8Xea7
         ctVqVL/8d9wj0YSVNK/p3QOf1YMtC+IDo6kFCKYX5qbRj0YSTnLSnsYiepfkAd+BkXP/
         pnXg==
X-Gm-Message-State: AOAM530ACYgfguTbee21Xtjwziuf4PmIbJJ1NRTjmMTU5E+Bm2Z5aH1e
        ZehCFh37zmlmyMljaxGy370gwmRijsqKWQ==
X-Google-Smtp-Source: ABdhPJy7Z5UEV4b301v+L8/DffCo/2Jhgx6+/1LGnuOanhvdjG6r8RI9ae1rpRe8Oa/d1StSH8bDuQ==
X-Received: by 2002:a05:6214:2589:: with SMTP id fq9mr13400058qvb.38.1639600819897;
        Wed, 15 Dec 2021 12:40:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm1710616qkn.62.2021.12.15.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/11] btrfs: disable space cache related mount options for extent tree v2
Date:   Wed, 15 Dec 2021 15:40:04 -0500
Message-Id: <39a18beef7a0737542ed68ff3a004374b2a6e1f8.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We cannot fall back on the slow caching for extent tree v2, which means
we can't just arbitrarily clear the free space trees at mount time.
Furthermore we can't do v1 space cache with extent tree v2.  Simply
ignore these mount options for extent tree v2 as they aren't relevant.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..7c7c0c36f461 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -862,6 +862,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		case Opt_space_cache:
 		case Opt_space_cache_version:
+			/*
+			 * We already set FREE_SPACE_TREE above because we have
+			 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
+			 * to allow v1 to be set for extent tree v2, simply
+			 * ignore this setting if we're extent tree v2.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
 			if (token == Opt_space_cache ||
 			    strcmp(args[0].from, "v1") == 0) {
 				btrfs_clear_opt(info->mount_opt,
@@ -882,6 +890,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, RESCAN_UUID_TREE);
 			break;
 		case Opt_no_space_cache:
+			/*
+			 * We cannot operate without the free space tree with
+			 * extent tree v2, ignore this option.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
 			if (btrfs_test_opt(info, SPACE_CACHE)) {
 				btrfs_clear_and_info(info, SPACE_CACHE,
 					     "disabling disk space caching");
@@ -897,6 +911,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	"the 'inode_cache' option is deprecated and has no effect since 5.11");
 			break;
 		case Opt_clear_cache:
+			/*
+			 * We cannot clear the free space tree with extent tree
+			 * v2, ignore this option.
+			 */
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+				break;
 			btrfs_set_and_info(info, CLEAR_CACHE,
 					   "force clearing of disk cache");
 			break;
-- 
2.26.3

