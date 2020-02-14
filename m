Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE615F873
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgBNVLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:11:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34185 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbgBNVLy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:11:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so10619988qkm.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ivnVxspgJXLs/YH7lMpaLw4T7MjD6K1/7WV3Hf0ZpVU=;
        b=g182pYyTCx4XTg0sNjv8qrQ+hdkN8fKDiQjjUz3qbrMt5Q1jmNQRIqn6pHL25lAHm9
         j1/UzbJqBh2D8wVnkTyvVleS1B6V82EVJBDMCAmHc0RxSaAE5uvdtJVNUqd8NRcqpQgr
         wWbeQIp9Smoy5Ivsq2QnCYnSL/KTNn14qPilPHT0iU/eoCSXLR+ub936cg5+xAXjzzVS
         ZK8Fwe8tNFX/WpGum3MyLF009aubC3AsbX1M35zdWOYyFrRMo9G3BbQ/+wvC/yJWxH0Y
         7fskiRthv8OfdVqVzpmOnRWs8pAnyXAWaR+RzyFYPmrVgZwdUSe96+LL6vIi5t28M2zH
         9rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivnVxspgJXLs/YH7lMpaLw4T7MjD6K1/7WV3Hf0ZpVU=;
        b=NG60ojIr4E2E2ZH6qSs5PsDQNKzAyOhgGU8wftj21M7B6wJYADM+QTKOFR/7a0Stxk
         In2Vv1Es5OthArNs/kpjkQ43/UeAh9Rq+PXpSI4DrsUKT3ncYh1O/t1MGWAJHUboU28x
         cd2zlvJ9vfcxq+DNOwYuX9+soGhp9zs9AmKBXckLJRvI3xjpwTOJ9gfKIN092lPbf1wv
         13GzLtkFfWgL8qUq6N315WRxAsJIS7W3EHxsBW5vcY8RjTr8dFJE7VzNxOhYWaSp0eWW
         SH8JrsU/A4Kl6AlgZbfhYI7h7xTZP4UpyXjDUCiedvgahBk3wE4Y6vHgTzwF2UUbZ+eH
         fPOg==
X-Gm-Message-State: APjAAAUJ8af9zC2TEFcN1KKVIJOJ3HKjh8JLgwNuzLlVYX/bAfa2v+ky
        sL98ATYt5Dg49MGjtfU8aql7+UpX1EI=
X-Google-Smtp-Source: APXvYqxMDL9r79MQjb8hoF9w2htmmH9dkYNXFK+wHt6p6U2aqfE6cgYSaO7KF2oD4JnRu9x5MtT30w==
X-Received: by 2002:a05:620a:857:: with SMTP id u23mr4701447qku.161.1581714713168;
        Fri, 14 Feb 2020 13:11:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 21sm3827301qkf.4.2020.02.14.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: move ino_cache_inode dropping
Date:   Fri, 14 Feb 2020 16:11:41 -0500
Message-Id: <20200214211147.24610-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to make root life be controlled soley by refcounting, and
inodes will be one of the things that hold a ref on the root.  This
means we need to handle dropping the ino_cache_inode outside of the root
freeing logic, so move it into btrfs_drop_and_free_fs_root() so it is
cleaned up properly on unmount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 5 ++++-
 fs/btrfs/transaction.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2a237aecc6d7..b7d6b4436f7d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3904,12 +3904,15 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		__btrfs_remove_free_space_cache(root->free_ino_pinned);
 	if (root->free_ino_ctl)
 		__btrfs_remove_free_space_cache(root->free_ino_ctl);
+	if (root->ino_cache_inode) {
+		iput(root->ino_cache_inode);
+		root->ino_cache_inode = NULL;
+	}
 	btrfs_free_fs_root(root);
 }
 
 void btrfs_free_fs_root(struct btrfs_root *root)
 {
-	iput(root->ino_cache_inode);
 	WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
 	if (root->anon_dev)
 		free_anon_bdev(root->anon_dev);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c2fff16842ac..3ffeb9a2c6e6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2433,6 +2433,10 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 	btrfs_debug(fs_info, "cleaner removing %llu", root->root_key.objectid);
 
 	btrfs_kill_all_delayed_nodes(root);
+	if (root->ino_cache_inode) {
+		iput(root->ino_cache_inode);
+		root->ino_cache_inode = NULL;
+	}
 
 	if (btrfs_header_backref_rev(root->node) <
 			BTRFS_MIXED_BACKREF_REV)
-- 
2.24.1

