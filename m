Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D408140BB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAQNws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36772 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so21808932qtr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YLCQJujjBgd3n3RPrL3ysYn8199a76pKc4DOh/S7EWk=;
        b=iThus/pw6wk950NJve59KGQdEHI3xkXBA9+x3fbAK3a3/2KXK9ygydIvHPh1EZGJfq
         7+GzlofWQhsowvt3WPSTQzCHQaOWILYjqiWcgDpkt7wTi0O3Sx3HCwicb+hYtK3ZbJQ8
         RTIEQRPUXZoIrBJg39a2+4lbJq+Hgybiav7+Zw8y916Vh1UYQ4dUyA9UnLgyUrNlVDJa
         soMazWQVnPlkH4V0CWyMSrZKuPvYOzXsL8eGQWZzee782ymTbSJ54d0UmUXS/8b5XqpM
         Plfr1L5ilqyQnud6+oORl39vY+ppEKG0ZmJ5026Enk0/WDo8/mbFxTuaGjaYCKTckE24
         7ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLCQJujjBgd3n3RPrL3ysYn8199a76pKc4DOh/S7EWk=;
        b=YIHxTDe0MCKF/cF7X2Z/JHJeK7OCPT16biy1JCWWRRkupAYhbFcJkh52d1iTDO5KI8
         02JYZzg/2kGDeT2zz0bP6GBqBSvycw4V1QVuk3Tiv+VqLpUXdb0GJT9RVty3cNgM8bvO
         x9JYnoeb9UM/pdsQAVFAgb3w4Xz7pflsoW6tqVEU/10nWMQ0mZwnV0K1OMnQzZtrv2bp
         pELLreuaYgP7BpUJ+lab2ggCgJ8UUqlrvGMTa0ThIT0z18/C3rguocJM+Mp0+5fLkGXr
         RnTKTBajkN5j2tdsD+gIy3EMWFQ4JxC4zEf9VJ4eXMFviacW6grE05Nwsf8mG7ZE4dTN
         cJOA==
X-Gm-Message-State: APjAAAUrtnkChcr9wS5yAp3mQgaOgGz64LeGH0aS/HJzw6ZLA5EnD8Qs
        fDcSeROZ4oZ3GUoq2biYmTtIbC1YM/Cr6g==
X-Google-Smtp-Source: APXvYqxR00jkYzA31Qb6wfSlDeJySynrz9Mb/2+RKoe/IncX2sGdrqF4TSrN4b2+eXI8f0XaH3/QYg==
X-Received: by 2002:aed:27de:: with SMTP id m30mr7586920qtg.151.1579269167216;
        Fri, 17 Jan 2020 05:52:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t3sm13246400qtc.8.2020.01.17.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: make inodes hold a ref on their roots
Date:   Fri, 17 Jan 2020 08:52:34 -0500
Message-Id: <20200117135238.41601-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117135238.41601-1-josef@toxicpanda.com>
References: <20200117135238.41601-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we make sure all the inodes have refs on their root we don't have to
worry about the root disappearing while we have open inodes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/inode.c   | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d2a6f6355331..ca474f87aba5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2144,7 +2144,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
 
-	BTRFS_I(inode)->root = fs_info->tree_root;
+	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	memset(&BTRFS_I(inode)->location, 0, sizeof(struct btrfs_key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	btrfs_insert_inode_hash(inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cbbe72d0600b..f7afa44d7cf3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5102,7 +5102,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	inode->i_ino = args->location->objectid;
 	memcpy(&BTRFS_I(inode)->location, args->location,
 	       sizeof(*args->location));
-	BTRFS_I(inode)->root = args->root;
+	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
+	BUG_ON(args->root && !BTRFS_I(inode)->root);
 	return 0;
 }
 
@@ -5183,7 +5184,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	memcpy(&BTRFS_I(inode)->location, key, sizeof(*key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
@@ -5751,7 +5752,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
 	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
@@ -8765,6 +8766,7 @@ void btrfs_destroy_inode(struct inode *inode)
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
+	btrfs_put_root(BTRFS_I(inode)->root);
 }
 
 int btrfs_drop_inode(struct inode *inode)
-- 
2.24.1

