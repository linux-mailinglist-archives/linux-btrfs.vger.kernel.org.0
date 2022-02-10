Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD104B15E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiBJTKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiBJTKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA162110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y8so9221897pfa.11
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8m2h/Layt/oGDX9jxdwkU6c4xbJMzjOpl2iC5A6mjQo=;
        b=ZCBvEhvR9jFaSN62oKt9ev1GvVrSt63z/C7xcEqh/KFeRZnwxEv+MjPHUUq9bW/kWi
         uHYrnpAgyPpEAbjcy92R19/YZWiOy6GIoth/OedcghpeMl0NK5FuasZt66wKOOORhk1R
         NTaP9IyZJRuUdX2e3gY7FUzjnBZMbVhLnTViwlpYgoN8nCVGAupUwDiIjpsKU3Bz2O1/
         kr3I6EB/FR3FQyPdwVvlq2fY7jzyt0PrNGN+deg5sWrXN7ezKDPSzpeIhgf35XICzc7R
         vAnj3SR2UMTSHZQaWF4wdGa0AYODVsNwWmnNp9hdI/ynz3yv3yyljY4IQoFsbN9Rtys6
         otJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8m2h/Layt/oGDX9jxdwkU6c4xbJMzjOpl2iC5A6mjQo=;
        b=rSJyPAGsmOI8kd2QnvPqFMn97OZ327xCZwmcraCW65i5WkKxEnyNKiX1jqD90FJQV5
         nHQYrPEcqZ3TelaNIm1nEj7hBYeFae6r2qX0lqNuadHJp/dzx7i+8aECdMoAgnWA5C2E
         j7Nm4uYcP1sME9dllcA8VG9fCkMD7dyMc6RbEITAhFQCIN/KMMWeNMnRkgamT43uM3kn
         IH3FkaozT41xNWCgPaKMx7GDV1kUR/SNp90zkBbe/TJG9oJQ34i0PlFavjaXmap2j6vh
         d7owP1FwVCT95nE5c0GRlMOgAQEFJweLQJ/0yOgnHFA12lb2xaRSMEnC3QLmn7foBhLH
         HF5w==
X-Gm-Message-State: AOAM531wXjQWi9BZOwX1KXR72Oh86OVyP3QJOtpebG5Vl+D5xgKIwvu3
        x/hYqjdsbx0Ma6rXZw5e3wfSAIZpGrQ3uw==
X-Google-Smtp-Source: ABdhPJzQ5kzrVEpBOiOTKvltHpgdPufkCuqlmP1Q/JpB4X77pqqGhtz4OXScIm32hxjLNpQrrqvxxw==
X-Received: by 2002:a05:6a00:16d3:: with SMTP id l19mr8915359pfc.7.1644520230998;
        Thu, 10 Feb 2022 11:10:30 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:30 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 01/17] fs: export rw_verify_area()
Date:   Thu, 10 Feb 2022 11:09:51 -0800
Message-Id: <f1366f49ca8ca4bc2656234de393d18d1a510efb.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I'm adding Btrfs ioctls to read and write compressed data, and rather
than duplicating the checks in rw_verify_area(), let's just export it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/internal.h      | 5 -----
 fs/read_write.c    | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 8590c973c2f4..711bdc00ec7c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -157,11 +157,6 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 
-/*
- * read_write.c
- */
-extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
-
 /*
  * pipe.c
  */
diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..4d60146243df 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -385,6 +385,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
+EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..4deb42c326ba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3173,6 +3173,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
+extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 extern int stream_open(struct inode * inode, struct file * filp);
-- 
2.35.1

