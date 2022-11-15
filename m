Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E12629D86
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiKOPcI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiKOPbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10592E9DC
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:36 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k2so9687012qkk.7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=OaaqXtMyh7O6rhF13kPh5zsvo0kFBHkPnhipBNIUSBqEUVZC+Pm9zuwvNxFeco/p92
         Ujf19SCfPjaDy/kl2yF8CXhXOA5xt9fLal03/chNRjCGQXdKRrYOL6tmFyPoIqe8gVpY
         wq9p1wYqgBFr2yQQwpwu39Q1hX1NpAqoaOjYP1oG4uoA8X0zTER5xbXrCI20TtIz4XRP
         Od9D3dleSttaWe0bPyrObrgG+Y7mAFF5/yxoNoqj01LafhJrjznjnmeW7rmR5vJdZAjD
         FwJfAxGK+SE4auC5blgYwaRx+3Rea956s+YCcYYQwIqwzsfwCUlK8EQj2SscI1yIGSMp
         JClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=TsgDwNn4b6hTnHJB6qvjt9ZhPN3KPYHI50Cs4cCRLosAJno5HZ0AmPwoAbuMeAI56g
         lR1sNKVCrbdcF0Df3ojSlVn0czSVFhGcv2/FnCXVcDst1OW3PcoAbNo5W8bV2vospN8R
         kga/lJ9uMqdW0RPUZ64stBxlFsH5ej2dMgbGsIpraRM4519/JM0M7zRM8rZHk+b6GYb4
         yFAo6ADpD+vdfpxJL5T3l4FIUxmIvm1Ob7Wdqtxc6xUEEFVDfntHoih2DZhF4r9jVMkG
         aFbNE5V+CxRiil3L1K22DDwo2w2jsX9/2Ztn6Kjx3VQFvU8CaOUnxTDYGMWd5LkKWjvx
         ovMA==
X-Gm-Message-State: ANoB5pnpUnkj4RYvi5bzfr+7NwfQYeHoU7B9bozxntdEG+QkkBuzEvYy
        n7a9dhTALGEjsjXcA7ZcMOC/ZT6Px83+3A==
X-Google-Smtp-Source: AA0mqf5nghDfSJnn2QyZXlxBWSrU0iBA8PqHlcRi2Opl2ZY8rnxvSVeVsuo395hO5q9VoQLBHzZ+qw==
X-Received: by 2002:a37:301:0:b0:6fa:93b1:8b6f with SMTP id 1-20020a370301000000b006fa93b18b6fmr15911605qkd.357.1668526295329;
        Tue, 15 Nov 2022 07:31:35 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006fa32a26433sm8529172qkp.38.2022.11.15.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/18] btrfs-progs: move btrfs_err_str into common/utils.h
Date:   Tue, 15 Nov 2022 10:31:13 -0500
Message-Id: <ee95d8e6dacb6f58befe5d1b2af730d9a51f2499.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This doesn't really belong with the ioctl definitions, and when we sync
the ioctl definitions with the kernel this helper will go away, so
adjust this now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/utils.h | 32 ++++++++++++++++++++++++++++++++
 ioctl.h        | 32 --------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/common/utils.h b/common/utils.h
index 5189e352..87dceef5 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -117,4 +117,36 @@ int sysfs_open_fsid_file(int fd, const char *filename);
 int sysfs_read_file(int fd, char *buf, size_t size);
 int sysfs_open_fsid_dir(int fd, const char *dirname);
 
+/* An error code to error string mapping for the kernel
+*  error codes
+*/
+static inline char *btrfs_err_str(enum btrfs_err_code err_code)
+{
+	switch (err_code) {
+		case BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET:
+			return "unable to go below two devices on raid1";
+		case BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET:
+			return "unable to go below three devices on raid1c3";
+		case BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET:
+			return "unable to go below four devices on raid1c4";
+		case BTRFS_ERROR_DEV_RAID10_MIN_NOT_MET:
+			return "unable to go below four/two devices on raid10";
+		case BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET:
+			return "unable to go below two devices on raid5";
+		case BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET:
+			return "unable to go below three devices on raid6";
+		case BTRFS_ERROR_DEV_TGT_REPLACE:
+			return "unable to remove the dev_replace target dev";
+		case BTRFS_ERROR_DEV_MISSING_NOT_FOUND:
+			return "no missing devices found to remove";
+		case BTRFS_ERROR_DEV_ONLY_WRITABLE:
+			return "unable to remove the only writeable device";
+		case BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS:
+			return "add/delete/balance/replace/resize operation "
+				"in progress";
+		default:
+			return NULL;
+	}
+}
+
 #endif
diff --git a/ioctl.h b/ioctl.h
index f19695e3..0615054b 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -935,38 +935,6 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
-/* An error code to error string mapping for the kernel
-*  error codes
-*/
-static inline char *btrfs_err_str(enum btrfs_err_code err_code)
-{
-	switch (err_code) {
-		case BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET:
-			return "unable to go below two devices on raid1";
-		case BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET:
-			return "unable to go below three devices on raid1c3";
-		case BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET:
-			return "unable to go below four devices on raid1c4";
-		case BTRFS_ERROR_DEV_RAID10_MIN_NOT_MET:
-			return "unable to go below four/two devices on raid10";
-		case BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET:
-			return "unable to go below two devices on raid5";
-		case BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET:
-			return "unable to go below three devices on raid6";
-		case BTRFS_ERROR_DEV_TGT_REPLACE:
-			return "unable to remove the dev_replace target dev";
-		case BTRFS_ERROR_DEV_MISSING_NOT_FOUND:
-			return "no missing devices found to remove";
-		case BTRFS_ERROR_DEV_ONLY_WRITABLE:
-			return "unable to remove the only writeable device";
-		case BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS:
-			return "add/delete/balance/replace/resize operation "
-				"in progress";
-		default:
-			return NULL;
-	}
-}
-
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
-- 
2.26.3

