Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C51446A09
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhKEUtF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhKEUtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CCC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x10so7898906qta.6
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WJv7oHdbm/3jGPHxCCKOpP9ppVEdt53QbnwPt2wirfU=;
        b=NwNRZMsKum9XXL9KZPmfTdhVS5Nzkbbs9UxKosdojRO+zuz/vIrxg3psLCiGnfBkJq
         ul/PaetEe7Pf93/mm+HcDP9z4RWmTNEvDEADzpSKHYauuy2bppB9ZN8c6OAlgCc850x6
         +fW7vzW1IJfYUoZGDweEAJ7SN1L02uzHgq8HWl0UZWN6dstlRgY9zI0m4+W/deQpHK71
         fVLkDMFyb81hYblUpFDbg02lT/XefhRZWeOBcYC1ue9TLRax/wFDuvSGYA+Mz32mnKqz
         aFDgIPc97+D++jcUBwyKlV4k9Q2dxR8BRfyPlYnhQW90ax+CYvGHr9xjOic/WO4/YgKs
         x70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJv7oHdbm/3jGPHxCCKOpP9ppVEdt53QbnwPt2wirfU=;
        b=NHQbTVqaBjOuaGfDe1M77wgXkcYRlUo9oaMe5XohIzP9xEc3UosfJgfQcr5QPZQLZa
         M2kgJqhotJCdNwDqzgnnI57RAANv7FMQv8SKiHfb8ShDYd/bvwmYEX9T/IQpEeh8MJNQ
         II9S3yyU/rWICaI779OJ3vv1UKSCNpuyLsg1E8G1gDK1Kyr/CbGdWXPDJbXW/oz5wmff
         tgKAAAVFIvh50UjZHy3vWkJyU8k/NzXotx/2T91uQo0TlGyxAFYuIjQSU/Cys+9Pplob
         4+cu2O3YsQ1E5WHmT5ci/905rEia5sfrLLtZi+873G3LurxK9h4Sc4Nv0wWvankuWrc+
         l8Ww==
X-Gm-Message-State: AOAM532TjQg3IfdWOVLlJyXLNGgr2+AgAItFROv/0jN0hMIa7AWWkU/b
        9pz+TP1rWfTZNSF2UmR9nz2ICI6/wX1HEQ==
X-Google-Smtp-Source: ABdhPJzWo6C+MuEs/GdzOGjm6uzdggvAXSWDv9VGy8pLK2wGB+3hbN5Glk79dhrr7CTYZqNG8T3vYQ==
X-Received: by 2002:ac8:57d2:: with SMTP id w18mr28906450qta.200.1636145182056;
        Fri, 05 Nov 2021 13:46:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w22sm6088747qto.15.2021.11.05.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/25] btrfs: set BTRFS_FS_STATE_NO_CSUMS if we fail to load the csum root
Date:   Fri,  5 Nov 2021 16:45:47 -0400
Message-Id: <4cc384d51e895b2aaaaf302b909f5eec39a06adb.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a few places where we skip doing csums if we mounted with one of
the rescue options that ignores bad csum roots.  In the future when
there are multiple csum roots it'll be costly to check and see if there
are any missing csum roots, so simply add a flag to indicate the fs
should skip loading csums in case of errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 3 ++-
 fs/btrfs/ctree.h       | 2 ++
 fs/btrfs/disk-io.c     | 5 +++++
 fs/btrfs/file-item.c   | 3 ++-
 fs/btrfs/inode.c       | 4 ++--
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1d071c8d6fff..a76107d6f7f2 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -156,7 +156,8 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	struct compressed_bio *cb = bio->bi_private;
 	u8 *cb_sum = cb->sums;
 
-	if (!fs_info->csum_root || (inode->flags & BTRFS_INODE_NODATASUM))
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
 		return 0;
 
 	shash->tfm = fs_info->csum_shash;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dac5741cb6fa..13bd6fc3901a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -143,6 +143,8 @@ enum {
 	BTRFS_FS_STATE_DEV_REPLACING,
 	/* The btrfs_fs_info created for self-tests */
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
+
+	BTRFS_FS_STATE_NO_CSUMS,
 };
 
 #define BTRFS_BACKREF_REV_MAX		256
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1ada4c96ef71..898b4ff83718 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2475,11 +2475,16 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
 				ret = PTR_ERR(root);
 				goto out;
+			} else {
+				set_bit(BTRFS_FS_STATE_NO_CSUMS,
+					&fs_info->fs_state);
 			}
 		} else {
 			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 			fs_info->csum_root = root;
 		}
+	} else {
+		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
 	}
 
 	/*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 359f3a047360..4904286139bf 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -376,7 +376,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
 	int count = 0;
 
-	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
+	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
 		return BLK_STS_OK;
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9e81fd94ab09..6d14dd2cf36e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2516,7 +2516,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
 	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
-		   !fs_info->csum_root;
+		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -3314,7 +3314,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
-	if (!root->fs_info->csum_root)
+	if (unlikely(test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)))
 		return 0;
 
 	ASSERT(page_offset(page) <= start &&
-- 
2.26.3

