Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6304123075
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfLQPg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44112 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so1703162qtr.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X+dDBN36nIO9Ue8qnQBxsC4EQZnEqI2HnSGzAQBPEHQ=;
        b=BWaBkXuNJ+DR2o9Ne5qWbzR7FgUZSDL8qHg8BPVWQ/AvW/Ot055vf1xP38FT9dsBYk
         490LQNBhX4yir4gX6U08XJwMZPF/c40J18xgGd0aWFV0NAnMxc9CInhM5mJILn7f7bM8
         iCHITdDWvvfrYQWGUykV3lrbysrc9M1VeZOUzNUZtCI45HYulc5oMOpZa/PO7KLGn119
         PpkGo2unDpzbO75QX/JnxjYNDmgEhCsRHfgsNdHj5DzSLL3jQkAyd19jidzxxQHoXn53
         +aGg4qo8HJRNeUXAfsGYgKot6v9p5X6f596kV8n+B5kGeu+ezJNxJ85yOONogrwu8fN0
         hUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+dDBN36nIO9Ue8qnQBxsC4EQZnEqI2HnSGzAQBPEHQ=;
        b=CmGOGfCQ+GrDL1HcLEpeYAchhR4qYCwVxKTuqxHL/FR5+Vg2ERYMa0Ni2oVjrR3BYD
         XcbyfIJOzTmOMNp2Q6U40kNy93YlqUQu7+C8bwKJvWCTsI8j4zPCKWhv7baKq8PwS8jQ
         XQPn+WWAmVAfNKNBWAyI7jNvMCgwIlHj3pYHC0JPX8gGTq4Vw9XTYLUC9KDJPQnL/try
         oeYCmIKUrgUeKXzLNsRzI9KQ/5aSZg0YfXKBjVtY/fi6DJMou7cmRVd6dmzf3pgyh0hw
         JkffIuz8C+fBLkj2c79ML3TgU4D6/IDe44C7QbW9nM44VSms+FxRu5UH4EjRrCNC8H5o
         WiAQ==
X-Gm-Message-State: APjAAAWqNfEbfaqU6rZAKwRt7vRKugiAaxPsBLqp75hHEP10LzCwXPJ8
        27DHyAa2f6uGcAz9pqLIaB1ZoFM1PIPo+g==
X-Google-Smtp-Source: APXvYqzYSEIEYjjRKHqgTpa6GvhhwReDPbCM1O+dqlQe9lJHXyjvAYnsHu/Yp7FJVFxUoGVHY2/a8w==
X-Received: by 2002:ac8:2bca:: with SMTP id n10mr5074863qtn.251.1576597016615;
        Tue, 17 Dec 2019 07:36:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z6sm7063100qkz.101.2019.12.17.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/45] btrfs: hold a ref on fs roots while they're in the radix tree
Date:   Tue, 17 Dec 2019 10:36:00 -0500
Message-Id: <20191217153635.44733-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're sitting in the radix tree, we should probably have a ref for
the radix tree.  Grab a ref on the root when we insert it, and drop it
when it gets deleted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4c55db4b3147..dfeeabfc341b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1515,8 +1515,10 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	ret = radix_tree_insert(&fs_info->fs_roots_radix,
 				(unsigned long)root->root_key.objectid,
 				root);
-	if (ret == 0)
+	if (ret == 0) {
+		btrfs_grab_fs_root(root);
 		set_bit(BTRFS_ROOT_IN_RADIX, &root->state);
+	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	radix_tree_preload_end();
 
@@ -3816,6 +3818,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
+	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
+		btrfs_put_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
-- 
2.23.0

