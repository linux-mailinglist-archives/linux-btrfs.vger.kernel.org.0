Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5F2908E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410436AbgJPPwo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406328AbgJPPwk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761AC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i22so2276653qkn.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87Y4xx8k4l9SWKhBL5qDQEDmAjOFQT2JlqjhNy2ajUU=;
        b=SZDqU55q+S4evwkVjuXggrZ6ZQ/kbkJ5iWWaaj7hZ1k3WiBDCf+BSU3frh4V5wAUsQ
         6rR3s0PwiMySgoabfWwSJ8XGBfawj/R4XO4iP9Lkn4fawop1+/puLU0iZMHQZ2EUs8qQ
         JZ0Lv8H8dJ8alUVKjVrdZUQLFOGndr2ujL0m9VIHrXo5E1Ixiw57i2+ircp0iNJSfdf2
         hAOQvJ/kxIkvc1SRKjgeo13nlY3DYCyVxaraxzbUj6IBq/dch8eOcO0nLhkbKRrMwMjp
         wnG684P0W1wH6oWLBah6oXLfBAmrJoMXbQ0z95KxgAri3q3nzBgvoeJ4MjaCDKnFumc5
         D34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87Y4xx8k4l9SWKhBL5qDQEDmAjOFQT2JlqjhNy2ajUU=;
        b=D5B8rnAd/rcDlCnK0g1ZJKaVWe7/J4AvLvZucM+dqOR86rQ+zgX3EeoAcNSPuSI0+n
         +hhffw5zA5iheegg2zXbf3km/RknGcpBoNeTE/6HT1onJfNCVuXjwNUOgpeZ9C9gi+rc
         BktFygkhAvrvh1IE7+cWFgYhGBHKGlUuBRdzB9eG4e3oYuQWSsOjKW97MZMLqGnKstUJ
         DgXW2zvIoTK2GxwUEHRMhil0qsWng/FrPzq7h0TO2R+YcRROhoNJ6ocS4wPbPyNWCENE
         fNHuPmPU06EtQ8ZGFkC52O2RcwgDNLgBvdCQxg7lK38mnDeoBfoRwhIYJ2hig3yj2K2z
         7FQg==
X-Gm-Message-State: AOAM5310WI0CND1g9Gew8OtYdYnIWtqcBneYcCxxglwpsSxLyTi8sUvp
        M2q70cTp+BqS8PIoNrw+iTwvrU3qGlJX0aJ2
X-Google-Smtp-Source: ABdhPJx5kgJYbwxm968rJzwrHMl9DNzALlNp01T15BsN2z1umOFVlY42OPN26YUkuemVglqxESXLjQ==
X-Received: by 2002:a37:b283:: with SMTP id b125mr4119983qkf.407.1602863559163;
        Fri, 16 Oct 2020 08:52:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm992438qki.112.2020.10.16.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/6] btrfs: do not block on deleted bgs mutex in the cleaner
Date:   Fri, 16 Oct 2020 11:52:30 -0400
Message-Id: <f7adcf9a7a95a7e04ba566377e7c3be15052a11b.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
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
index 3ba6f3839d39..2b5f91b35032 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1333,6 +1333,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
@@ -1352,8 +1359,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
-
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
@@ -1499,11 +1504,11 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
2.24.1

