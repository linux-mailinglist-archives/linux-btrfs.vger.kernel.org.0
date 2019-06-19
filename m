Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B904C029
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfFSRrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32942 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSRrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so57714qtr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GueFs4REnk8q4/zpbegZhcMKAOARtIldzH33f8atb7Y=;
        b=o/emcaMHv4RmShmxT+wzmNB2Q0I9aaKrN2xlkvVXiR0lCMiutHe9XcgfnAzG8YWODU
         QT3ke3sWXIHFUIUCrdEvYadgnbSAgW1L3WVBIhK9Xut0YhzGI2eKR2uB/2UWnENbAxlB
         LXEvBscVCdNcDg3gU312MhPfvIqlaCdqHNso2Hh0XzxJtv9xs7T5MfM98Ucln52+breD
         o+3pFXteW7dOiZmmGCT2uXCitZPaHbRoFlB3aQXeV7IUDjD354cfXF8+d+7DsJHqsYbx
         /mjotPAzYjLieh6dD6o+X9DNdlvOp4QtO4cquM9iF5HK/4CdjZxEpktW4PaPILT4Wti/
         j5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GueFs4REnk8q4/zpbegZhcMKAOARtIldzH33f8atb7Y=;
        b=XD+CHU1eOoxxEjLtFKeI1/39qwM49TZjsDFYr3a7CN4+mIvQX0C9YsBxI1nm05Xz5X
         bc0zgh/t3j4XYDWG96zZ0pJzYjIlmNmRlfN60LYrKBAVW0nGjWitwq4ZvmHZsSfngU3a
         L9rJoSt9Vfx1+dloYHTDqrycSXEo3NaRKMjDFnvW+1uzIP2teArJPQjqDNQpU/HXz5cg
         9V3uZPAvszBAmUBLOWGLfoBReuYvcFzYBnutBzP6ZBoaw9pg5nGf9q+hsRXVqd48ZkGD
         DdSW6/aSBbf8Wu62iIz0dleLkhNPZyk+Oa7riQQzktAxRTwKDlNtaEZitoz/xogNw/SJ
         LYIQ==
X-Gm-Message-State: APjAAAVdtna/QC36XyU/sI6lQoyE9KyEuKem9q0OMfuwj72gQz7yps9A
        AZ2ZIUyKqZ7v8CCzVn8ZWG7OaJChPjMn3g==
X-Google-Smtp-Source: APXvYqzN0+3v62lj93udaIjtWQ3XcJJcJfJfgP9SRdTVVqKdy3fdlYok4h8UwocM40boQHCAffjUyQ==
X-Received: by 2002:ac8:282b:: with SMTP id 40mr76217978qtq.49.1560966451317;
        Wed, 19 Jun 2019 10:47:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a11sm9709780qkn.26.2019.06.19.10.47.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: export btrfs_block_rsv_add_bytes
Date:   Wed, 19 Jun 2019 13:47:18 -0400
Message-Id: <20190619174724.1675-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in a few places, we need to make sure it's exported so we
can move it around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.h   |  2 ++
 fs/btrfs/extent-tree.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 13f5ab02a635..1ddc0659c678 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -78,4 +78,6 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 			     struct btrfs_block_rsv *block_rsv,
 			     u64 num_bytes);
+void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
+			       u64 num_bytes, bool update_size);
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2e128ecc95f7..2c81c546f0fc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4385,8 +4385,8 @@ int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
 	return ret;
 }
 
-static void block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
-				u64 num_bytes, bool update_size)
+void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
+			       u64 num_bytes, bool update_size)
 {
 	spin_lock(&block_rsv->lock);
 	block_rsv->reserved += num_bytes;
@@ -4418,7 +4418,7 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 		global_rsv->full = 0;
 	spin_unlock(&global_rsv->lock);
 
-	block_rsv_add_bytes(dest, num_bytes, true);
+	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
 	return 0;
 }
 
@@ -4501,7 +4501,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 					   num_bytes, flush);
 	if (ret)
 		return ret;
-	block_rsv_add_bytes(block_rsv, num_bytes, 0);
+	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, 0);
 	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 				      0, num_bytes, 1);
 	return 0;
@@ -4573,7 +4573,7 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
 	if (ret)
 		return ret;
 
-	block_rsv_add_bytes(dst, num_bytes, update_size);
+	btrfs_block_rsv_add_bytes(dst, num_bytes, update_size);
 	return 0;
 }
 
@@ -4626,7 +4626,7 @@ int btrfs_block_rsv_add(struct btrfs_root *root,
 
 	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
 	if (!ret)
-		block_rsv_add_bytes(block_rsv, num_bytes, true);
+		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
 
 	return ret;
 }
@@ -4671,7 +4671,7 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 
 	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
 	if (!ret) {
-		block_rsv_add_bytes(block_rsv, num_bytes, false);
+		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
 		return 0;
 	}
 
@@ -5062,7 +5062,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_unlock(&inode->lock);
 
 	/* Now we can safely add our space to our block rsv */
-	block_rsv_add_bytes(block_rsv, meta_reserve, false);
+	btrfs_block_rsv_add_bytes(block_rsv, meta_reserve, false);
 	trace_btrfs_space_reservation(root->fs_info, "delalloc",
 				      btrfs_ino(inode), meta_reserve, 1);
 
@@ -7439,7 +7439,7 @@ use_block_rsv(struct btrfs_trans_handle *trans,
 static void unuse_block_rsv(struct btrfs_fs_info *fs_info,
 			    struct btrfs_block_rsv *block_rsv, u32 blocksize)
 {
-	block_rsv_add_bytes(block_rsv, blocksize, false);
+	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
 	block_rsv_release_bytes(fs_info, block_rsv, NULL, 0, NULL);
 }
 
-- 
2.14.3

