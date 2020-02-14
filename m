Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6815F875
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbgBNVL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:11:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33188 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbgBNVL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:11:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so7956902qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PcN9QmDSePETznHY2Dq50vka60gBcbGc6DE2jrMKxwY=;
        b=cjyf2+fWeoWgRb9TnLCcp8CNxpJ84nv0mc9+vp+XDuGNij+rrZwSMul79jhtF+/3OR
         xomcbozlJs+jX2MYcxFFnioPmh05Hbb57P4eBCSKlp5We831UlIKlC0Lmhk7PlCLWnpS
         f00I6fB5OwtTtxibD7Wza93z176K3pzCbfr5/aX1+H6tqMJviETKMBR0X1BVf2UMbwQV
         X6aFUCtgGhLYbgnX+eVk0L08Bap7rmXMA9e25VhPXjNlqKh8fH4b8RNzRvLmaTAnmsFA
         IiUMe2HZTZNGNE4Uw0tNd54yTLDQexQdrURwA7P8fE9OX7KP5CCZFrZBEGC0Gz47gDv5
         Pczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcN9QmDSePETznHY2Dq50vka60gBcbGc6DE2jrMKxwY=;
        b=iDurSDzq74dPiq74c1YtSOt8VDSGBXvYiAFLhqTqqwrE0omSN8eEwtug4/l32i909s
         fKkfn+iYJ/Ay5HSHuxx7AvcjYoMlYfp1+yDK2oBuCSuDWLPzz8i7/H7KsFPH3Zc+yDWt
         PDoxrzvX2W+0oUt2Ui03toeURU9/bOJ3pLTBYW2HbgbjvS87g2INGntYV+oujV3HWHnu
         y/s2zc1icuD37ludjb6SPVMBJuiAhdw1YyU58kL5elklj5G+WxzXRm4kNeLngaoXsd70
         6Ub04xFvJbGZyom5dicE0xEcoXBl0Zu2eQBF6T2Jb+8j74HYbzWwQvVb2Vq1dB0xHiRG
         OYvA==
X-Gm-Message-State: APjAAAUHIdP2VXL/Gi1SavDx0H5qRgTHpdD+71qxr7lCa1b9jcsSvwYY
        zj21CH5CdmuKR+26D8x+8twTpoKpTTA=
X-Google-Smtp-Source: APXvYqzSIz/cNlLx/XtNK5u2UWRMMXvpHwAbviNpM4kEf/aVpnBCQJlLOUfsDiD2A7rw3GAxxdxwhQ==
X-Received: by 2002:aed:3022:: with SMTP id 31mr4138357qte.282.1581714716489;
        Fri, 14 Feb 2020 13:11:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r37sm3934023qtj.44.2020.02.14.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: make inodes hold a ref on their roots
Date:   Fri, 14 Feb 2020 16:11:43 -0500
Message-Id: <20200214211147.24610-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
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
index 953190b03043..26eb1564028d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2142,7 +2142,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
 
-	BTRFS_I(inode)->root = fs_info->tree_root;
+	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	memset(&BTRFS_I(inode)->location, 0, sizeof(struct btrfs_key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	btrfs_insert_inode_hash(inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 20a6ee83f709..338283bb66f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5234,7 +5234,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	inode->i_ino = args->location->objectid;
 	memcpy(&BTRFS_I(inode)->location, args->location,
 	       sizeof(*args->location));
-	BTRFS_I(inode)->root = args->root;
+	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
+	BUG_ON(args->root && !BTRFS_I(inode)->root);
 	return 0;
 }
 
@@ -5315,7 +5316,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	memcpy(&BTRFS_I(inode)->location, key, sizeof(*key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
@@ -5883,7 +5884,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
 	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
@@ -8898,6 +8899,7 @@ void btrfs_destroy_inode(struct inode *inode)
 	inode_tree_del(inode);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
 	btrfs_inode_clear_file_extent_range(BTRFS_I(inode), 0, (u64)-1);
+	btrfs_put_root(BTRFS_I(inode)->root);
 }
 
 int btrfs_drop_inode(struct inode *inode)
-- 
2.24.1

