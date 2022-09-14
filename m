Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F015B90CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiINXFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiINXFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EED5208E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c19so10149606qkm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=IJ8ywYZKmUwHnTrQRqY8oE7rBMDhidpHtuV4magLbVE=;
        b=MGiCSMWeQBTy+5F1IycbP/TXZp73zr4Vud1uV/jGV9H6BH+QUNLWTN24jtIYEZv7Dx
         0xEv3IBwI0fDl37J5QquO69jc+qh3PsJodK5vpgnPn4EPYzkUE+t9QyKULKUN2nas+OO
         hv6Xp5Hne8nIzmVLX8sbaUeNTXw9zwiVKrsCQUmwQ3G41T2f0U1bDh3F7WeflVPadZ2v
         ipNXAIShZDT9xYon6Oc6BU4VD9YUrNuLTCMZ11IaEllrm5VLVTSFbCPmS4OKVMTMmcui
         pAJpBALQOOeb+7FmvCGZZMqOq/r2r/Z3411U6l/xL1h0iniyW/yLpuIIEHGP+9zcwNEX
         otSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IJ8ywYZKmUwHnTrQRqY8oE7rBMDhidpHtuV4magLbVE=;
        b=37UyBcK0LiiRw6d3++RIYmQBNc4RxWTqqwrkt0GkAXJlPvHCjZQKaD2WjW8YDCx/Ys
         5zl7rUvYDNh3oANnsLOfU5kZW0ya7hVoW5BJAjlP5W8mXAcAH32QzSYwd/9woZ9+YB3w
         eDEGC2NTxEy82CTUpr1XhIdQFhGEUM0fz9lpz7+8PI23mzkqVuqV4TtIKBXcSo2JwUnC
         CpydGV9cOoWEygUG22YVqzWcNU6iecKK0E45NzPiXutI29ETibUPGeOGNOtf/VjzOKGD
         v2r9LfYGjjjArxWAOCmzGVRrLLTKMmuPiIx/y6a2xr5FV1GsjaEijji+dQZfKwPdDfQd
         SkdA==
X-Gm-Message-State: ACgBeo0pVSXLoJR6i+1lAcQL2tPizZ1fSKhEGG3tWKHx4crMbta/9Dj9
        GK2ybQ8ytJZxjkqM3R4ErsHQ7yvuKqVMfg==
X-Google-Smtp-Source: AA6agR5+ymwzKOHSkDNHJ16QZGRTQf7NMCpbPZDXLAsyww9k+5LMWq/Z3qsKsm8LYOHsFK9z6ClgDQ==
X-Received: by 2002:a05:620a:489a:b0:6ce:4014:5455 with SMTP id ea26-20020a05620a489a00b006ce40145455mr11853841qkb.716.1663196709575;
        Wed, 14 Sep 2022 16:05:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006bbe7ded98csm2739565qki.112.2022.09.14.16.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/15] btrfs: delete btrfs_inode_sectorsize helper
Date:   Wed, 14 Sep 2022 19:04:48 -0400
Message-Id: <030e2b0b061a8ae57037f810ae3bfb2b4c9b0f4d.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is defined in btrfs_inode.h, and dereferences btrfs_root and
btrfs_fs_info, both of which aren't defined in btrfs_inode.h.
Additionally, in many places we already have root or fs_info, so this
helper often makes the code harder to read.  So delete the helper and
simply open code it in the few places that we use it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  5 -----
 fs/btrfs/extent_io.c   |  4 ++--
 fs/btrfs/file.c        | 11 +++++------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 890c9f979a3d..b24f78145fa6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -251,11 +251,6 @@ struct btrfs_inode {
 	struct inode vfs_inode;
 };
 
-static inline u32 btrfs_inode_sectorsize(const struct btrfs_inode *inode)
-{
-	return inode->root->fs_info->sectorsize;
-}
-
 static inline struct btrfs_inode *BTRFS_I(const struct inode *inode)
 {
 	return container_of(inode, struct btrfs_inode, vfs_inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b1d57727be02..f5eb6c66911c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3925,8 +3925,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, btrfs_inode_sectorsize(inode));
-	lockend = round_up(start + len, btrfs_inode_sectorsize(inode));
+	lockstart = round_down(start, root->fs_info->sectorsize);
+	lockend = round_up(start + len, root->fs_info->sectorsize);
 	prev_extent_end = lockstart;
 
 	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c395bf8e7522..c418468428ad 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3010,9 +3010,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	if (ret)
 		goto out_only_mutex;
 
-	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
-	lockend = round_down(offset + len,
-			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
+	lockstart = round_up(offset, fs_info->sectorsize);
+	lockend = round_down(offset + len, fs_info->sectorsize) - 1;
 	same_block = (BTRFS_BYTES_TO_BLKS(fs_info, offset))
 		== (BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1));
 	/*
@@ -3214,7 +3213,7 @@ enum {
 static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 						 u64 offset)
 {
-	const u64 sectorsize = btrfs_inode_sectorsize(inode);
+	const u64 sectorsize = inode->root->fs_info->sectorsize;
 	struct extent_map *em;
 	int ret;
 
@@ -3244,7 +3243,7 @@ static int btrfs_zero_range(struct inode *inode,
 	struct extent_changeset *data_reserved = NULL;
 	int ret;
 	u64 alloc_hint = 0;
-	const u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
+	const u64 sectorsize = fs_info->sectorsize;
 	u64 alloc_start = round_down(offset, sectorsize);
 	u64 alloc_end = round_up(offset + len, sectorsize);
 	u64 bytes_to_reserve = 0;
@@ -3430,7 +3429,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	u64 data_space_reserved = 0;
 	u64 qgroup_reserved = 0;
 	struct extent_map *em;
-	int blocksize = btrfs_inode_sectorsize(BTRFS_I(inode));
+	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
 	int ret;
 
 	/* Do not allow fallocate in ZONED mode */
-- 
2.26.3

