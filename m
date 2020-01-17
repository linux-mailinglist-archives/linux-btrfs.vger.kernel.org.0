Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0350140B63
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAQNsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41334 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so22666101qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Y4R9rmJXTT7cwohKAVvF/8eoKZiVBpMg25xl4LibPc=;
        b=BajNb/mI25uIAlVVwKFqbn3yVYSy4yWHENE9GPX6hIIth50Yt4gSVC34Qvk/vIfEbg
         Ztzd2lCMPMpVZS1vSFV+JyLv3HT4/zDGqDWaOMqLbD9T23K3/9cfv6crF5xMAyZ5ZELW
         k7gmosMPq4c93/molad5DvCWkgHthPabzG6KNlq1/SphISi4ftQbzGo75OSwNw7zw9Sg
         1gtMGDjGHcRpw5bZsCGBxu3tiObszFwRDwsJ2NWW6pGkZ9HGv2N/fdI61eUNEWXbRW/m
         9dFsgjMha4fDwbJRQq5zbaE3CFgHwHb2J5T5U8VaSMEND7FR+QRQvm86Ug0dBcd2uUd2
         8BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Y4R9rmJXTT7cwohKAVvF/8eoKZiVBpMg25xl4LibPc=;
        b=CV4caXTG6R1gwb7e56cMnK/9dI4MjYLLYRQVE8V6loYA7WXOupXwl4gue6vOqBzDjt
         X64dTyK+g2Bt1MjL/Q5xHkocs0pCpo+td0j2KUA1w9D9OvO/hOxMzUZejk30E9zv0Mju
         HOZyl6aSEuhO3aW7c5+4KVZg7Ps0mHhMqGjMNuc4yfS6oW7r8yVXl26nGtcbW1KGYBRM
         Y/+1qcr+htH3Kq3ByX/PM+CwPcJkVdIcxnUmcFqPP5lHBs3FudrFT4uDdEPHJpceCzIu
         rgdrtVu82c9PTqWp682YIZaCfir/gaHlJIIzMipomNoo5iSyNLu3BeqrMFOVjv01k5Ru
         slpQ==
X-Gm-Message-State: APjAAAVl5APZYf81xPkeGNcs513aUqmuBbhUVG3EIV1OkS4qK2jz0JzD
        pCf/RgchBlpnCqvbYeJvfwlIg4aU47gbnA==
X-Google-Smtp-Source: APXvYqxS5bUJz5AsDNbOiR213ysefKIyiHtEAoXx/vVkbB465FhRy0MlDGNL7OhED2fjzERLhqD+3w==
X-Received: by 2002:a05:620a:a5c:: with SMTP id j28mr33081415qka.218.1579268887389;
        Fri, 17 Jan 2020 05:48:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 2sm11779752qkv.98.2020.01.17.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/43] btrfs: export and use btrfs_read_tree_root
Date:   Fri, 17 Jan 2020 08:47:19 -0500
Message-Id: <20200117134758.41494-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

