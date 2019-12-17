Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0790712306E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLQPgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37920 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so6244867qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AnrtVS26ct5BFRG9vT41BcI4OdIfQkucKsgxtAfxakQ=;
        b=jQu7GOkZ71hweF1qQ0XeblcOTOFH8kr0u8eEnJFELO8giNrwqrVyMAmosX8SQOvLMF
         BNtJPvva77VIHtTiW8T0VEnKdnMnNraZj+qgB1MW+cbrms3PRwOQO42hIw4T9EyZ9RwZ
         KiENwujosObCKsddmhGoURVgKYPNGP1II4KTQpF1z9kmVCAtz3OdQNXRI9vnI8U3IbgY
         ZWQbPYWpS47kT79NqMve3m6GHLYv/5Eo6F0vcoiJte7m9OULBfL3c3PiDGGS05UiYjIe
         AQnc2eewnSuoDvnivrfqXSNBGLVKZ5+C4TRfVUQykhviI+A22Jaaz0QznA4prpQKDY23
         85Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnrtVS26ct5BFRG9vT41BcI4OdIfQkucKsgxtAfxakQ=;
        b=DmvW7xw9f05J6sJg87KwV6YyCQN95EQ/x/enm71rURtpfW/0jCJO4TP6/ZPBxApH/z
         cOkRPkXUdeAGNk7z3uJIQi9NW0ujsZv5xkqWQOvOjO5AaPk7og7Gdub2rfyooslpwVVF
         og86G1IoTX43U24ls/tKIA3yx+KiUIVBE0YJ2gvNkoKjXy8G5sXQfygkxVpsqqJ8rNx4
         Xze1RTE+iFLfSCA2L9AAQaNdLzyCEqAUXlv/Fi+wW4o+hKhw0e9wiUyV1z1SSWXfjxfB
         xD8pvhDDGyoCLKv1NR5o37klhUx9FGghU7NyfQehSgQfVpsL7zSqrETQa0Vr6mTeHbDN
         7+JQ==
X-Gm-Message-State: APjAAAUblpMw3aTOmLvQv/qKDV5t3wWi7R4FfKglup32hjHKbrKTVzUu
        EqnIOkheOy0NB7lfz/79PdeKl+G/fPVSkA==
X-Google-Smtp-Source: APXvYqw8e9+M+g9I4HUWsCARx7L/VKvaohkJ+sMloLdSxW1OFQgIrqHaT9Ug9eBqLRO66ncI6zDt8A==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr5875652qkh.408.1576597005679;
        Tue, 17 Dec 2019 07:36:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y91sm8208008qtd.28.2019.12.17.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/45] btrfs: export and use btrfs_read_tree_root
Date:   Tue, 17 Dec 2019 10:35:54 -0500
Message-Id: <20191217153635.44733-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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

