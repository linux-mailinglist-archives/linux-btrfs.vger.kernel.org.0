Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77F115375
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLFOqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38386 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id 14so7344662qtf.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jwJhWMl33WBxBZPZsNUeTq/Ywm6VHshAJl9lKM0tdLc=;
        b=1JJkTFzOSwVRWj36pFab8gomTi9JxnE7jO2RLmknqMijQFMppUNE89luI8egnQfUio
         6QVsUpgMEgKhju+AMPTBAWLGGe3Ax7K12VLW877mlTuKyZuThWfwB8pkSZYAN7lOmx+o
         hwc7qiRjrZSf0/EufSFxD7Iuz3TkPQykkGYJkaHW8PgTr5nprsI7dyhp7HiRl24eJKVQ
         W+6cWbTwkSUxnLNWmegqQgpjVUWO5bfPVrK9449GCWDUcR/s9EM55zaGOHNndSzWTczg
         apJUTUwRmjjSNAj+GAaFptzLkudBkwvXi4+EPS4BzlRDZUIwea1TeH3Q3THa06EW02AO
         XfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwJhWMl33WBxBZPZsNUeTq/Ywm6VHshAJl9lKM0tdLc=;
        b=PKP9pK+XvjfiPeJc3kXfKz/lPp3xsYeQK+c5MUHKakPv+SY8Xe1NNJkulDOOITx9+x
         K85Un3CSpqiJm6vuUxnXqdV84rgBD8Iderce1UfXaO2ki8ZISZMEE84+dmtBtYxdpB2i
         vBlKWnGQhz0lSSJftBNJPqMqo9qdKMrtytZGPggFXMgqc4WmmyNNk/mKoxKr/RGPmLzz
         PRkAhiK/6bFq0tfCKr9t2hYT27t3WCm8b+HgYHkGxmwxpqz1DbmG7ZjiHCA/DpyPq0EA
         qdihdAeSTxvR2oPZf+UXwLpt3NrkVN7cuF0DZW0IyfMJrN3URlGhKN+gcufx2d71YiDh
         bsDw==
X-Gm-Message-State: APjAAAViqzIlM6EOhG1W+6dXtuwCdCoGUvhfUQqAoeJxx4DzYy8v+SSX
        BTdEri9FlWeWZgh0gO9YSGKHW6St7habbg==
X-Google-Smtp-Source: APXvYqwqlgBdIW+k6wsTU89PeopFF2xpuPXeA9Zd+ytJvFj80ohDpxH541f1PI/+hx2P4r2XnQjLtQ==
X-Received: by 2002:ac8:538d:: with SMTP id x13mr13187409qtp.375.1575643564827;
        Fri, 06 Dec 2019 06:46:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l31sm6414737qte.30.2019.12.06.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/44] btrfs: hold a ref on the root in __btrfs_run_defrag_inode
Date:   Fri,  6 Dec 2019 09:45:07 -0500
Message-Id: <20191206144538.168112-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are looking up an arbitrary inode, we need to hold a ref on the root
while we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8baa1b44d514..f8e16f44a970 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,11 +292,16 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
+	if (!btrfs_grab_fs_root(inode_root)) {
+		ret = -ENOENT;
+		goto cleanup;
+	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	btrfs_put_fs_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
-- 
2.23.0

