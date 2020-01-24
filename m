Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A644148921
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392765AbgAXOdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33675 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392760AbgAXOdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id h23so2224253qkh.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2WdbHxf3x/K7ZFWhJ+LPB3iVWaQkE0vPXMUKDv+efA=;
        b=bZJ2SoOWL+mEs7GataH2c289rUdNAt3G+bLB9+dcHr0XsLkfw3iV5RBkQwtY76bc6w
         EUYK4uJq6QLEik/hvIKLMJiK1H7mz+jTKV+qiTSgHTVO8eH7+AB6qB/2mtXAtynE/6XY
         3voId5hr59JJKUJr4MvB+TWtR4mxeYyKr2atxCkmA/cFV4qKVkayMm3q/tWs6Qj/Hytk
         6JBVKaLCQGd8tytKIiDrBqi1IoHB5a7a/jb2mbZUH4NY6NQkr5a7Jey78a0R5C/gP5YS
         qrgLtW3pGbOMrJjZGcbYObrJf753p4n9RbZDV1eLb9vmpTGtgAwvIzh0YJzaXCORyURz
         vLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2WdbHxf3x/K7ZFWhJ+LPB3iVWaQkE0vPXMUKDv+efA=;
        b=nPz2bR5h4TZF8/VCDecpLPjuh8EKxY1j6odv/O27ArCgBg+/WQP4p2wkXXGNqnd1/f
         oFrCH5XI0zW5njse1GunFaCLC9ZH4QTaKfOsI13W3rB7g1yat4EK0QoHAzZJVSbYiiUG
         8ExCfRQbDm/LR+ISUIEj+dCML86qvV+i/0qwWCnKLN8afwcu9i4M4ggXVWFQeLNJMUdO
         +1fwSKjyi4P2k9j3srT91kCrGqjkuN3MQ9X2JlbtyTM4QxL1lCpbE7Vz7bQ0Txg3IhFr
         gqFRni8jhTiFSWyjNkzAdxsC6YiUrQ6G6Q1wOS9hK97S65UsIHApD3WJhMWWTpzMG9P6
         kPtw==
X-Gm-Message-State: APjAAAXlm7GeVdy1ih98Ep3Qgl+/5khc1curft0MoBmNtL8qAjCoZJUD
        ekRKJyR536dk0IFdlqD73HrRxQ==
X-Google-Smtp-Source: APXvYqz9perD/BiNB4HpbbtOMUZpZf+UxyHeXSIqV/dh2x1PuMIjFeDfKcMnQwJT482ykBfOLsywVA==
X-Received: by 2002:ae9:f003:: with SMTP id l3mr2808187qkg.457.1579876390705;
        Fri, 24 Jan 2020 06:33:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d20sm1427685qto.2.2020.01.24.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/44] btrfs: export and use btrfs_read_tree_root
Date:   Fri, 24 Jan 2020 09:32:21 -0500
Message-Id: <20200124143301.2186319-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

log-tree uses btrfs_read_fs_root to load its log, but this just calls
btrfs_read_tree_root.  We don't save the log roots in our root cache, so
just export this helper and use it in the logging code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c  | 4 ++--
 fs/btrfs/disk-io.h  | 2 ++
 fs/btrfs/tree-log.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2d378aafb70b..136a4d9d5fed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1384,8 +1384,8 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
-					       struct btrfs_key *key)
+struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
+					struct btrfs_key *key)
 {
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info = tree_root->fs_info;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8c2d6cf1ce59..158fec0eeef2 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -58,6 +58,8 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 			struct buffer_head **bh_ret);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
+struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
+					struct btrfs_key *key);
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 				      struct btrfs_key *location);
 int btrfs_init_fs_root(struct btrfs_root *root);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a2bae5c230e1..e6e4b00cb46c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6101,7 +6101,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (found_key.objectid != BTRFS_TREE_LOG_OBJECTID)
 			break;
 
-		log = btrfs_read_fs_root(log_root_tree, &found_key);
+		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
 			btrfs_handle_fs_error(fs_info, ret,
-- 
2.24.1

