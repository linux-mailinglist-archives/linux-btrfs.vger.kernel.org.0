Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2E636D4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKWWiK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiKWWhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:50 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84125E4
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:47 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d8so13461339qki.13
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=27wEPDnskH7pFmDUwMswKYuLhhuk3KXhNXr5kOjmC6oheICOVblUCJ2kQJCxvgmV73
         oiPjHgrSUcYdnTuJrl6RtXBn84JVY/9bvpNw8FdL1dSAYv+tyK/gNj7sMdwhQZIfpmjH
         7NvOV6PjhCz8vBnmnYizoou54OAn6baZbhMvBztmHhfa7q1OwdG1VJYBBkYMM+NtFing
         ZwLXkfU+S3pTR6TODyFsJeaSf6ugiuOCKZji6UgDr60B+KlmX43AnqnZLX+dBG2a0A8G
         BMrgeLF2TyjUj8EzXe1yQqmu8LgVN/gq25WBBHpvrK8xlvaaM+u6j5kmwgf9HkO1WXZu
         4Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfHKo9+wzg94hafVtLbprq1BBpsW0tQpOtW2wH6SmV4=;
        b=FnXdV3IGtc6TeUVz5Wlnzj6ztNkGYNP/kM2YQ8XAzyQDbQLCR8wBIMadfTflMREdMi
         PYiqStkzb5exc4azUwN0TwT4nQlIhI4NI2TSqJGxIdRNVmvRurt1ntue6q9yxEDDB18W
         LRz5K/vo0iPGPyQFJW9+aJBuTQhBUqp1koyI73siZNcv0bq1Ugs8KsX6EEHR3OxRycWZ
         WeYGSk9eUelmKa3TDoTmLmeCDDMZdYPZE/BLGbG7Hn+jxIOzeXoZmFgZHIsa/+3FafDw
         gbGjptFG8Mr9VH2AjXumAy+OwSt/aZi/fUIrCW5bsu0Fk7yuqJ0DokYipHq3AUXEa1YJ
         KsWA==
X-Gm-Message-State: ANoB5pmWaCqa+deHzqPwZ9GrznTg19yLn3aD9In7hc1PD0VpjQbxzEkj
        6WC+BCkTfEBF6RFaAdX5fsQSkqPwYb0uOg==
X-Google-Smtp-Source: AA0mqf5JDFmRRB/Gx3aEFNqvW7QYFGypDkU3qZ10cbEFq6wU2BujU5yRVPxiKccdi16ianWVbj79NA==
X-Received: by 2002:a37:5841:0:b0:6ec:b463:3b88 with SMTP id m62-20020a375841000000b006ecb4633b88mr26532481qkb.720.1669243065923;
        Wed, 23 Nov 2022 14:37:45 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006eee3a09ff3sm13021635qkp.69.2022.11.23.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 05/29] btrfs-progs: move btrfs_err_str into common/utils.h
Date:   Wed, 23 Nov 2022 17:37:13 -0500
Message-Id: <06076dba53813bbcb59b3dd9c070a3eeb249551c.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

