Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA062639E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiKKVa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiKKVaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A6E02A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:24 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a27so3398692qtw.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=JT2+4ZCjsBVEKjf9Hh79tWY9kpPPwQb6fzMXbo6URBZ5s3DXVJhFumwkXD6rf+CMeO
         WHRkWPojY4CVR3wdnfmL5c1kqv2EozL9UciXLywFyrPKbV9A0FPUcsCbLszzNriggUxa
         b0c1u/EkgZrffMYeqzFRpdHtcsTFMhgW7GV6XdK1oQdBY7lezrkc++ocWvAgqEWeHX8J
         PM5ROjL/e2C/QGHVhsfvCukB7hIzPxKZQHFUnRVVwy1Kf/SsftxvPRmve7L+Zhc67mEE
         3Kp17sTy2VvCEBQ9AWU29ErWDNRo6NvJ9Xj6bsSgopFVMgUveb9tP5qq2GnhZ5040InM
         Ap9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=NOcHTBkc/KzkRHH8EvXl7PsHvHyYgk3kkGtDK2lRfns/oRtHxNqfj/9MzIOEXGpUf6
         7bT42XpFv1ECx5VLqA5DnXcwoDNRS6GaeO/sP3lE/tv5J5l7NNT/qYzHTU9iQEYZM/l2
         Us3ay5wHOvG0pJdLEnu595FYMPskOGHIlyVmhe1ZZYdfaswIklanDswzjhh1OOz5hQts
         XyxiP70vo5r5ejpBg4kMq/Wzib1+ZwSbO87Ie9ZkprelT8na+vSKf+SjTXCL4siM3liA
         KSKi86GvwDSR/8NTRqGK6/z3O/xhjK+OA0yV1r3IoKXc7kBcMkAoWBSRVpHI+96IfH8A
         pqiQ==
X-Gm-Message-State: ANoB5pmYFf/8akCRu/sShYPBpSQSrGRrokcPRiDyGA9hVUtf22Bj2sY+
        zHRxM7P03C3azIhaKeeqCJzMthOgJDufLA==
X-Google-Smtp-Source: AA0mqf5Zq2lFUuhrCDw8dr5kfRUol1N01ADbGUjz7iErLsG10v8Mz/cqzUG2/kF6ceKMg9bhtMwhNQ==
X-Received: by 2002:ac8:43d1:0:b0:3a5:280d:31ff with SMTP id w17-20020ac843d1000000b003a5280d31ffmr3106036qtn.646.1668202222913;
        Fri, 11 Nov 2022 13:30:22 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006cfaee39ccesm2081521qkp.114.2022.11.11.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/14] btrfs-progs: move btrfs_err_str into common/utils.h
Date:   Fri, 11 Nov 2022 16:30:05 -0500
Message-Id: <ee95d8e6dacb6f58befe5d1b2af730d9a51f2499.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
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

