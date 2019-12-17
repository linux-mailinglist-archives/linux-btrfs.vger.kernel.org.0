Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618741230B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLQPoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so6266349qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CmGiMKcsE2w/6LpKu+Tbv0XmRx8trZlor0ED5UxdMZc=;
        b=rES4lv/AwS6udkg13ENvnuHv9yNiN9skeLzpo5S8FHBYvcm43NNgmaOINISA6VFhWf
         htlYqf2jMyJG00bJyGPIs+f3NN8SPYDR7ne1jPLr2MdqTS9htBV4XqNinthdnmxJjHcq
         VXioq6pXYQ6Dwqpfc+Gs+UabNeCLBo7PQmiwBCnNoCE+lVFprnYG1QFXEKi/g5ZJn22r
         FSQ3Ua4w6wh8lIix5u/w8HipgkhmtMVpR6kk/qvlqdETIuKgGwL69wy9qdePrkWVmPXm
         fkhjZoH5hl0oE2yzFy8YqWXGAabSPSmWTLSwdbTwa7EnO8JiXdN3ffQ47dxT1vPtZ8QP
         NP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmGiMKcsE2w/6LpKu+Tbv0XmRx8trZlor0ED5UxdMZc=;
        b=qVsy0hQ0rxuanoNcRg5QqC6tLemgwRAoUdldplvRmZrDw86IfZSapunWe9QtTOmkca
         wjrHXD162Yp5GM27y/siqVIpzo0fWWLnNtI3mZNc7QiEVjwOhZJEUHOvL92GwTc0KfY7
         WnKtxE9d86491L5L6Mxg8yfkUNVVnB8GrIAdCI4ErPjfw5if6iPqKzBAx5KMZhCsG+Sq
         HnbJhnsm8DHyZKbu7prbXb+pd41QlNiYf8nDi9u75Utpg2GwQ7NVcwHIyvxF9U/5EwYh
         nN5Yo8gQw1666B03A1ktoAqLG8W9v+muFq8ILAjqPP8EpEJrn5N13SJf/itdl/nWHRxO
         DApw==
X-Gm-Message-State: APjAAAUala+3S67NuF7qWQO7mlaY8hEybDGs+9DG4R3GN4FQixAl1jIE
        f9xDvoBBNGEGOX10ERgkXwB8jt+YUz2wUQ==
X-Google-Smtp-Source: APXvYqxTKpWd2B11JTe6T9fYWVWIllb39q9psU1VEKW2tlB3rxxE85zfjTj4HO5dWTIdZlsGkvZkoA==
X-Received: by 2002:a37:a642:: with SMTP id p63mr5793950qke.85.1576597454314;
        Tue, 17 Dec 2019 07:44:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p185sm5349566qkd.126.2019.12.17.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: hold a ref on the root on the dead roots list
Date:   Tue, 17 Dec 2019 10:44:01 -0500
Message-Id: <20191217154404.44831-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the point we add a root to the dead roots list we have no open inodes
for that root, so we need to hold a ref on that root to keep it from
disappearing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 3 +--
 fs/btrfs/transaction.c | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cf242d3c1723..ac96214bb5d9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2082,8 +2082,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 
 		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
 			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
-		else
-			btrfs_put_root(gang[0]);
+		btrfs_put_root(gang[0]);
 	}
 
 	while (1) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..2252dd967ad8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1260,8 +1260,10 @@ void btrfs_add_dead_root(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
-	if (list_empty(&root->root_list))
+	if (list_empty(&root->root_list)) {
+		btrfs_grab_root(root);
 		list_add_tail(&root->root_list, &fs_info->dead_roots);
+	}
 	spin_unlock(&fs_info->trans_lock);
 }
 
@@ -2430,7 +2432,7 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 		ret = btrfs_drop_snapshot(root, NULL, 0, 0);
 	else
 		ret = btrfs_drop_snapshot(root, NULL, 1, 0);
-
+	btrfs_put_root(root);
 	return (ret < 0) ? 0 : 1;
 }
 
-- 
2.23.0

