Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E22DD310
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLQOgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgLQOgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:36:47 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D1C0617A7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id h4so21616186qkk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4cGrI/kuB/wlw/etjMUVBc2/pxhAu2KFAHUybSr4Hg=;
        b=J1ot2JRUThyKZSFkd6CxWCN8V8aen/qYgqSAWcYfq/s/jFzcuhhTR1U/HcERQ1DJXS
         jGUPS6lHMnlAX+uSv/M4Ip0DR7wZ0Kt6hOPHaK+X7joEN0ytF1JRgJO5cz+uMKa1sdj7
         rxTTJXSd47Zc++0R6VNN6v12BdrnncQ2ZDpZp4hUyJcteKq0nBho1R5o/BHTiA438N5+
         nn6dYtWnXN2u/5hmBrUVTX9pcmLUeSRHQfH/3qk3Kq73PIxlw3dR1YM+O3pLwPaCaJ37
         ++q4nkVNHdNYVoVU1IIO2azPiTuaBnK4za0ZX0YwC1dIi8nIdMA6UIPfJ/uh4Z26qIk/
         pxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4cGrI/kuB/wlw/etjMUVBc2/pxhAu2KFAHUybSr4Hg=;
        b=dNQQnw5jyHP3ATbZt0NM79N/u9H8XHHow115mbtUDn2n7ODapegY5DZgBOQEUAPU0D
         8uhTbrXyJz3oxrpq3RRarqFmFkTneiYh4w8ulUqPVDw6s9GTzNwZQjcG1OhGwymh7CPO
         JrFeTwTrBjgECJkfvJ4ZxFIM8sYSg6IQ72mi9Y8L+S4euQcmIJ6QZVDHsU8alVH237dt
         O15shDf0ZAKQcZbCGvGd4ZQ3sWce2mvSYTkTAwcWARQUJSgmKpDS8jOJ3P1zXmbxRwMF
         cLWByOYkqYZuulBDmTYkTy/dgc49rOCzKMfHIFNn6yboLdajFc75iWDyATTr51Y1S19p
         8UAw==
X-Gm-Message-State: AOAM5321kq4N/OT+TCbJ4DwpApACavLCZNiRkgrOPOVyU/6sytHHw4QL
        SLjuHuxeYAFDLYIWSjc1mGBapH2TOrr/a+67
X-Google-Smtp-Source: ABdhPJzxr3XnDFds61Fbyu0YZh5xqjSJHyzWhKz3Z2zYvu6OkxVgr0XjSahk76/xb0qaww7IgLQh2Q==
X-Received: by 2002:a05:620a:4113:: with SMTP id j19mr50372683qko.301.1608215766351;
        Thu, 17 Dec 2020 06:36:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 141sm3619995qkn.53.2020.12.17.06.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 1/6] btrfs: do not block on deleted bgs mutex in the cleaner
Date:   Thu, 17 Dec 2020 09:35:57 -0500
Message-Id: <0c1995f8b35b44ceb0043ab2303b9e02a5517a46.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running some stress tests I started getting hung task messages.
This is because the delete unused bg's code has to take the
delete_unused_bgs_mutex to do it's work, which is taken by balance to
make sure we don't delete block groups while we're balancing.

The problem is a balance can take a while, and so we were getting hung
task warnings.  We don't need to block and run these things, and the
cleaner is needed to do other work, so trylock on this mutex and just
bail if we can't acquire it right away.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..f61e275bd792 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1254,6 +1254,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	/*
+	 * Long running balances can keep us blocked here for eternity, so
+	 * simply skip deletion if we're unable to get the mutex.
+	 */
+	if (!mutex_trylock(&fs_info->delete_unused_bgs_mutex))
+		return;
+
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
 		int trimming;
@@ -1273,8 +1280,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
-
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
@@ -1420,11 +1425,11 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 end_trans:
 		btrfs_end_transaction(trans);
 next:
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 	return;
 
 flip_async:
-- 
2.26.2

