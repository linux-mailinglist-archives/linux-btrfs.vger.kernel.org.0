Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC02DE9B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgLRTZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgLRTZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:11 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF4C0617A7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:31 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 143so3022725qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4cGrI/kuB/wlw/etjMUVBc2/pxhAu2KFAHUybSr4Hg=;
        b=x6oL4rSMnr5YVeoxQ8/LMzOz57iPVW6cidOPQDrZZ9CS6cq5w0Qlb2jc6mYAYEcT0F
         qnS2Y/OU2EXyU2tMQ7EbrAGO8rPPqMYdQr9GMUf6trVnPf2dxCzJNWHG8JDK87NjhxGX
         M4sAV6XSpsFvnPWq7vAGUpm8/NNxD4N1z3PRzGAZCBq0c6C8qQprE/J9dQluyqLiLe0S
         nKSQJX6iaFsBQeboaHqb2Vr38/TqoO3LF0swhDUUKSH4ZokMShzFy/Xle3q5lAL/CS/b
         igl2URv0hoRrtn6a1jZ+Awz9ZYempuvN70oMbYuH9iCCwrC0mPAu3+TNv+lApa12wJAl
         vCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4cGrI/kuB/wlw/etjMUVBc2/pxhAu2KFAHUybSr4Hg=;
        b=Lgl8RALpKwWZk+v6zGCTk6tUGkGRJ+5jUVGGwdzviPdLEN3rVr5HD5bBvSEf5La3CJ
         WNESj3owRRQX3tn4Kv/Dney1rDubtKgCZ0bVubpR56OAaJsaZNqURGdkAgsWgzpt8Ep7
         OWLjw5t96W3QivHvDKriaayqiklVyMN2ajdzZbM4Dp7oKQxCeJshyDRNV5KXWkKI0baS
         ZTdZa/ZpjmchjcYMtalo6ZOKdc3HJrNhnwqWWloxqOoLOPAWrP0CGUNOucIbdk8e32lE
         f4UNZftwfl4StlW4qzLlQZL5isuPrX+pu3af8y48lhW6laANKu1TjZmxWnselFHVfCAZ
         Q2OQ==
X-Gm-Message-State: AOAM532MXKU33jYkkGRKdYSugBPCpQfZwQgnOo1DGEzqVb/Upef+Usxe
        u9xjb/lE32Yo3phy411jWB1QeK+zgc2RMbYY
X-Google-Smtp-Source: ABdhPJy4Q+qxu0d+EY78A4CgZEgH8lS7QIsHs3g49RWbVyFyGSYv3qGg9Q+0bqTGFRJXURFcMkcJXg==
X-Received: by 2002:a05:620a:625:: with SMTP id 5mr6212072qkv.498.1608319469988;
        Fri, 18 Dec 2020 11:24:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 1sm6411606qki.50.2020.12.18.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 1/8] btrfs: do not block on deleted bgs mutex in the cleaner
Date:   Fri, 18 Dec 2020 14:24:19 -0500
Message-Id: <0c1995f8b35b44ceb0043ab2303b9e02a5517a46.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
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

