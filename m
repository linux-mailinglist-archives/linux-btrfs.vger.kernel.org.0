Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF63148945
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbgAXOd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:59 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45023 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbgAXOd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:57 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so970005qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=EcYeQXXP+rfA0o6IxiKn8mmKQ4jK3Wqw/O2qSk6+yoKxLlDYJmSTxMFJZrPnJ4tC16
         WenrTS51etCyB/hw+7S3F+pxiov1KHt4SklWCsgRzG5Rym6yIMuwTWUzADbndukID0WC
         P6YtxHm+KZEA2WZAVabYvRIC+GHYYqwhyZNmeuLGlq5lMXASxUShzgLRDJgBxPvM+O6g
         pQQhUpLGaxiPz8E6/ZR9EbmuP2hILXGrtf9NZwbMNZXtbvNUIFce1zmMz4rb3tN9w1Jt
         4GuEZk/YtPrBZt6bLc9e+ygHQGXMSTtGVfr+IDRW9N3YYjv1bw1CfkrGs/YTX0dfEwVC
         R+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4adHR5F024ZCFETalNl7qYodPCR2rclkM9ufEryDrI4=;
        b=I4HohjKPe1awFEUWjhekuNcKoVhSvYvxgbvnA9adS4HqGzLlfOqfxwgjR7l/ul2+i1
         flRvQaAtRmFJyTQqKHjY4dHjwi4E8aHFBs2EWgL2O7AbR0/9FyZ4xYVXK05abd5oy677
         23b8QvMlh1Btu5rMwy+kadK+zCH1qkZ3nsHnub01C2oG7pxf2LgdQi4jRl2K2tb39k/1
         oqX7RElSMvcmYmXTkVr9PSNFEYGvc4dcQsjNj/n/qB7VsMTo9un142HgCc7gYrE7zpIi
         yLQdprGzLrYxPJM3ePHdNmPqig25SBdqwFIEmxTZg3ily/Y3SYHLo4MpThoEhRBmu1EI
         PVuQ==
X-Gm-Message-State: APjAAAX2y9LC0ok0d2s+M9yd+4Iw3MjEr/zBWJV/mT0YzAAxS2CqzEbn
        +nk+C2awYfH2V2Pc91+Ct26LTm9uAPYo7A==
X-Google-Smtp-Source: APXvYqxr9CiTf6K0C9HJMYfbYUKUMoc2bS0G1chMiz1Lb5OjoaUW7cqRZg4uChnoD5AY8bYVN9zu7Q==
X-Received: by 2002:ad4:496f:: with SMTP id p15mr2905547qvy.191.1579876436570;
        Fri, 24 Jan 2020 06:33:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm3309852qts.64.2020.01.24.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 30/44] btrfs: hold a ref on the root in scrub_print_warning_inode
Date:   Fri, 24 Jan 2020 09:32:47 -0500
Message-Id: <20200124143301.2186319-31-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

