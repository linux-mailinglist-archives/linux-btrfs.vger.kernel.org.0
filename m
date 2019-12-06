Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE10711536C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFOpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46559 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id f5so6611959qkm.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AnrtVS26ct5BFRG9vT41BcI4OdIfQkucKsgxtAfxakQ=;
        b=hOStE/40E/PSnC5QCXWEfxytxMwjjo8rP6OMP0/aiEoZaAPRL8B9zm+yokGqZSole7
         mOZDkd8pk4LrlQOviPXo6dpifeusEfZ01xJI3ScfgEQUMcbamu7PaK3o1d7X3lrtqDS6
         6tKHmuuYUzd9UcBp4duSzlXQdSbj8sqOT2oYGoIgwe7lneai2sfKgKWxXWz3MYQqe+e7
         co8RLpcV75Uvy/vLzdYCljFG0Plft9lXOtDqcRjJ+7dty/PHCedb6eo6cFAPc+dIscK7
         tIR3zOZhXbltS3oxbuKqMjr9U97QJhKv1gi90PF5vMWamU8uKpflBt8F8yEIXyDLgBot
         aJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnrtVS26ct5BFRG9vT41BcI4OdIfQkucKsgxtAfxakQ=;
        b=Xlxl/OO/LwwP0SOJ76xe2fB4U2huLkfxqTljSTgyD/cIIx/BrUw2dZ8DBpzlhUqce8
         bjpE6obWhLfC/dPT7YPEi6OlFutMdUW93ehgN5FchuTi2bk0R7CboeuBXWUrxa8h9ciU
         +f36XvcjM9MS9lTa5S81NFuot2AuR11Qh0BJ6B/4yfSoCB0lEgY2zxin3rHZkn1psutG
         M8Ii74HSosMImCShftDfxPB2uGwT2lcXV32It2N1WSYJmDYt7IYMRdTg4OQZl7zooVeH
         y+V5PHYbNvh44hUNU8LZL77CrYWjyJoxEodwPjfsPNlM62s1SPRt0vhRJnLqf3+SsZ1I
         ZY5Q==
X-Gm-Message-State: APjAAAWAMdDySeO17TZP2D8VlZKLegwGNw8nrjRg0G3ZkTMVyRe2JWvj
        XbG3jdUBKqQo7y8M9D+tOjMWEwRZ0J6Fwg==
X-Google-Smtp-Source: APXvYqyk1ErC1C4gkUFCFKsaugshmA9c2cf0abJEQeXnPaFkj+hEeXTD3qvabDYwMQCBYyMIVI0kfA==
X-Received: by 2002:a37:6087:: with SMTP id u129mr13772918qkb.219.1575643548522;
        Fri, 06 Dec 2019 06:45:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y200sm6021807qkb.1.2019.12.06.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/44] btrfs: export and use btrfs_read_tree_root
Date:   Fri,  6 Dec 2019 09:44:58 -0500
Message-Id: <20191206144538.168112-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index c65825029553..2b91c40df27a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1386,8 +1386,8 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
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
index 76f123ebb292..cb12dd4825da 100644
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
index 4bbb4fd490b5..881d117a07db 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6279,7 +6279,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (found_key.objectid != BTRFS_TREE_LOG_OBJECTID)
 			break;
 
-		log = btrfs_read_fs_root(log_root_tree, &found_key);
+		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
 			btrfs_handle_fs_error(fs_info, ret,
-- 
2.23.0

