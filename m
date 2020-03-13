Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2A1850AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgCMVMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:12:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37168 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMVMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id l20so8866887qtp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WVMm7wdWhCQgfPweZ1hhzYSFlQnBqdeVLcWBx4hU9sY=;
        b=k4mrb/XFjXA7pWN4kmM9jiXcux/6uBlZlrc3AcWEvHtGxwV93WP6JCb4R7e16XwWQz
         HHCZ9itk0XlScLwjqoOv/Sr7qlBBmcjfZgFA7bwU/tD8kslFKptFIy35dsF9I/nLt9kz
         xhsXnGfJRVz5xz21tQztSrrrygkDzNFCgWSXsowO+VQ3D3BtxjHnQujTV2Ru1G66xYC2
         G6wQ8ABuWko//6NvcIcwRktc1ZXKI/cMy3KpA2nv1NzjoWcg91+JXkCwCfT6pGAMKd1R
         T/VYe8Q17WTbhzjxlSvBxK5u+AKHyIY2TVdg9ECzwhOXb7DOc+/DwnSv01NCcEfaDXpF
         EFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVMm7wdWhCQgfPweZ1hhzYSFlQnBqdeVLcWBx4hU9sY=;
        b=IsZ7cGYN3HPVNyTnTPxrjGKDX8yWAdsrr7bravwHt6moei5m2boaimi1H6+XoOYJ6a
         Gb7KqoTWAlGS2bn9kJARKj4oZK/y1JNxnxxmJjvtlLSd2htLw6oFB9tMAVDImqbp7Oy6
         LeHY3KWNiZkddqnxWwTCg/L/X7lQXL6diUR4pxYEyHmTvwK84jmHL+YwRofYDpYcO3aU
         iYxzdiIhTJLAJSYr30EUqTIGQHMXB9W2CmzSO3+HmgsapM4409sgaQJ+zfGxA8VQacuY
         2miUxly4jrruk+7BFe4TnyIKoGUHxuX2mpg/Mmyv9LMh3nIjIFTeRyje75nk8njQxHzp
         CYZw==
X-Gm-Message-State: ANhLgQ0G1ryIKpbIbyF8keWMUWxYjHsLlgFslE3lL/FZJL0bwAaX1hi+
        JpHde1uaQLQ6yz621miI7UJBpSApHw4ZUg==
X-Google-Smtp-Source: ADFU+vvZoN0VYKmb+OHQi9Tg/+yroXAC8HveQFIeeTWqk4a0nOoiJp7ykc2SEPMCHg+eZOpB+MrQtw==
X-Received: by 2002:aed:3f87:: with SMTP id s7mr14319577qth.313.1584133952038;
        Fri, 13 Mar 2020 14:12:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e130sm30633402qkb.72.2020.03.13.14.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:12:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: stop running all delayed refs during snapshot
Date:   Fri, 13 Mar 2020 17:12:20 -0400
Message-Id: <20200313211220.148772-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211220.148772-1-josef@toxicpanda.com>
References: <20200313211220.148772-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added a very long time ago to work around issues with delayed
refs and with qgroups.  Both of these issues have since been properly
fixed, so all this does is cause a lot of lock contention with anybody
else who is running delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c3b3b524b8c3..8d34d7e0adb6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1184,10 +1184,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1205,10 +1201,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1223,15 +1215,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
-		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-		if (ret)
-			return ret;
 	}
 
+	/* Now flush any delayed refs generated by updating all of the roots. */
+	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	if (ret)
+		return ret;
+
 	while (!list_empty(dirty_bgs) || !list_empty(io_bgs)) {
 		ret = btrfs_write_dirty_block_groups(trans);
 		if (ret)
 			return ret;
+
+		/*
+		 * We're writing the dirty block groups, which could generate
+		 * delayed refs, which could generate more dirty block groups,
+		 * so we want to keep this flushing in this loop to make sure
+		 * everything gets run.
+		 */
 		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 		if (ret)
 			return ret;
-- 
2.24.1

