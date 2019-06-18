Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF54A4A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfFRO7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 10:59:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45821 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfFRO7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 10:59:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so8737012qkj.12
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=xLcfPFxfhKM11IGnUkfBylPZqW26QYGp6dsgJrhwFU0=;
        b=aJZ2SDRW0axpoDTba0qGRFDSv09Ly6eO4nSAYJ+TNO7nNubu46sspqn73GqqptUcDt
         jZGcdM+S1/Z75ZCGc+CtuZSb4kFh9j/J8f32hAWhVVE1epiZHD2ph8x7FnsKle83i+CW
         dxSrbz9ENQ8/2Nm2Tx9/fBg/Xz4q+q/RHGLe63L+mIXJ0p0Jo9z+CfbQ+MQs9pR2PSPm
         OAoSFjnwAc7bWXtJjPPJYdBx3jAbghKwKjmI7vQc08st7pzCpswpHGIC2AHFIVoTtmgx
         /gxlJsTYeT20JD2NH304t/OFKdwUMBnB7oowMfHXpS1GqdGOu4FuxrSos4edzLz5nAu6
         TR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xLcfPFxfhKM11IGnUkfBylPZqW26QYGp6dsgJrhwFU0=;
        b=rAt0ad+VUhq8JCjCAKWxTRz6XaOVTjcadx+5U2c2H6w1aZGzE3Y4DuSW0P+6CmRHyt
         NUJ/54d2HDAhdKUNqWH7ikfdH33ULtuMLoPOqtKHiCZdmWPJjRp5AoDC7oI4BnWCxIod
         LLIvHCp+gaqK8PbI3K2AnoOAu1z9OuublvM79sgG/jAXfVK5X4SqtrI2u+vhX75q0Whl
         IryuHNIpZBmwW2NidIFGTQeUIp455GKu3R5U+u1bnjfD4zIQKNJQoU3/4xrNj6O4aasj
         OcnH9MeWV86Fs7Yo25Mm4V1+ls8Vifb/7uiwX0cMe2j99EaHbGQjwnKYsUjnZCZZgnC8
         CPIA==
X-Gm-Message-State: APjAAAUSLL5V2VdOeTYWlWygKXNsciTPRGMKUo9b3TGJeglSAvcgzbH5
        sPeQ1Wgr1X0mvjhA+EWEjWaxRktUwHkCWg==
X-Google-Smtp-Source: APXvYqz92egreelkoVbZTUmr5ihHZ+OjrKo21yjuLbOOqQ426TZ09t6zHZ3wFWC9YnMRWZfIDaa/EQ==
X-Received: by 2002:a37:4a8a:: with SMTP id x132mr70428162qka.42.1560869960372;
        Tue, 18 Jun 2019 07:59:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j25sm6103726qkk.53.2019.06.18.07.59.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 07:59:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH][v2] btrfs: run delayed iput at unlink time
Date:   Tue, 18 Jun 2019 10:59:18 -0400
Message-Id: <20190618145918.12641-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have been seeing issues in production where a cleaner script will end
up unlinking a bunch of files that have pending iputs.  This means they
will get their final iput's run at btrfs-cleaner time and thus are not
throttled, which impacts the workload.

Since we are unlinking these files we can just drop the delayed iput at
unlink time.  We are already holding a reference to the inode so this
will not be the final iput and thus is completely safe to do at this
point.  Doing this means we are more likely to be doing the final iput
at unlink time, and thus will get the IO charged to the caller and get
throttled appropriately without affecting the main workload.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- consolidate the delayed iput run into a helper.

 fs/btrfs/inode.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 33380f5e2e8a..c311bf6d52f4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3326,6 +3326,28 @@ void btrfs_add_delayed_iput(struct inode *inode)
 		wake_up_process(fs_info->cleaner_kthread);
 }
 
+static void run_delayed_iput_locked(struct btrfs_fs_info *fs_info,
+				    struct btrfs_inode *inode)
+{
+	list_del_init(&inode->delayed_iput);
+	spin_unlock(&fs_info->delayed_iput_lock);
+	iput(&inode->vfs_inode);
+	if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
+		wake_up(&fs_info->delayed_iputs_wait);
+	spin_lock(&fs_info->delayed_iput_lock);
+}
+
+static void btrfs_run_delayed_iput(struct btrfs_fs_info *fs_info,
+				   struct btrfs_inode *inode)
+{
+	if (!list_empty(&inode->delayed_iput)) {
+		spin_lock(&fs_info->delayed_iput_lock);
+		if (!list_empty(&inode->delayed_iput))
+			run_delayed_iput_locked(fs_info, inode);
+		spin_unlock(&fs_info->delayed_iput_lock);
+	}
+}
+
 void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 {
 
@@ -3335,12 +3357,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 
 		inode = list_first_entry(&fs_info->delayed_iputs,
 				struct btrfs_inode, delayed_iput);
-		list_del_init(&inode->delayed_iput);
-		spin_unlock(&fs_info->delayed_iput_lock);
-		iput(&inode->vfs_inode);
-		if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
-			wake_up(&fs_info->delayed_iputs_wait);
-		spin_lock(&fs_info->delayed_iput_lock);
+		run_delayed_iput_locked(fs_info, inode);
 	}
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
@@ -4045,6 +4062,17 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		ret = 0;
 	else if (ret)
 		btrfs_abort_transaction(trans, ret);
+
+	/*
+	 * If we have a pending delayed iput we could end up with the final iput
+	 * being run in btrfs-cleaner context.  If we have enough of these built
+	 * up we can end up burning a lot of time in btrfs-cleaner without any
+	 * way to throttle the unlinks.  Since we're currently holding a ref on
+	 * the inode we can run the delayed iput here without any issues as the
+	 * final iput won't be done until after we drop the ref we're currently
+	 * holding.
+	 */
+	btrfs_run_delayed_iput(fs_info, inode);
 err:
 	btrfs_free_path(path);
 	if (ret)
-- 
2.14.3

