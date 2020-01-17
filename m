Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970FB1412EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAQV1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:02 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43480 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgAQV07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:59 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so11358414qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=oCMnBHiTV2bQ388AV+PmeEp2t9cqqOryr+tXI8pM3vYB4I2HzlL6pPwe7Lwug7zB5m
         vQOzGoBvRN/e5UniDbIslzKBcao1ykGg7vXsRAat+ZpzRFpmZgewdG/a5isRgjeOslX8
         4yNZIe+2B3EOtGZMN0bEnVSLfttIAwCT2+9W7M1XzypX5lycYuQKHKy3eCU1UVRNn+wl
         0l3K6rN+L1O+BqZNuC4W/YNVVoRrqfwLttEM0pRbPgy5BZulVhnTG4AfMuS+kqXd3SAT
         pH/MYfXlr5zG2Uy2+35Uk6eQa9cQIiaLk+qoUN7gizlImOMVUahQP+YfvCK8lzWzo3Zg
         pmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=kmC53xAhwQ2KrgScaLOW0de1QS6yQNR6G4B4ub18QS9cawWfy53eOIb9wdttgfsX3X
         aYSenWJME1VD4lrdjGVkwelw1CdgjKvkGbtF/kt46ypAp8aGPH0djn7M1ua2RRVfpzE0
         xuOM8gyRUg/sxzuggoHpwYG0CVeF4ZT2gWA+L3EOZhIyQt5SmArLG4uCGzl1VMJ7b/uy
         xQ9UrDzLPxnhCeTnPD9ycD+hWyxE5EiD2Hq7s25qfyCIWx+uvFUdgkQ90jk09ov6B7re
         36LzjSAun45y2vEAbjCQEH0WB+zzzNABCu60F4DstkUWHek2Teo+viocEPtCER1OJQw/
         AD6g==
X-Gm-Message-State: APjAAAWBXk1g3O6HS27gReHHn5CFCg+3lH80N+82AtLAzMzcwQRwZWrS
        WfpgkQPY3dByDMyEfY0bbiOcsOiDJgxeTA==
X-Google-Smtp-Source: APXvYqyDe+Vd9jIR9kF1TzRV17I2NOH8N24uTSN75VvQSi9tVhBy12Jl++jo9Z6t3HgydPfiSP4jZg==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr9535778qvi.225.1579296418311;
        Fri, 17 Jan 2020 13:26:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r12sm12318378qkm.94.2020.01.17.13.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/43] btrfs: hold a ref on the root in scrub_print_warning_inode
Date:   Fri, 17 Jan 2020 16:25:49 -0500
Message-Id: <20200117212602.6737-31-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the root for the bytenr that is failing, so we need to hold a
ref on the root for that operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b5f420456439..f9ee327d7978 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -658,6 +658,10 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
+	if (!btrfs_grab_fs_root(local_root)) {
+		ret = -ENOENT;
+		goto err;
+	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
@@ -668,6 +672,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 
 	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
 	if (ret) {
+		btrfs_put_fs_root(local_root);
 		btrfs_release_path(swarn->path);
 		goto err;
 	}
@@ -688,6 +693,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	ipath = init_ipath(4096, local_root, swarn->path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(ipath)) {
+		btrfs_put_fs_root(local_root);
 		ret = PTR_ERR(ipath);
 		ipath = NULL;
 		goto err;
@@ -711,6 +717,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				  min(isize - offset, (u64)PAGE_SIZE), nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
+	btrfs_put_fs_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
-- 
2.24.1

