Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB35B90D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiINXFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiINXFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D175208E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c19so10149645qkm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=lDeKs++bIBWyKbnlwC68WUE/KZoeEZt0DgP2cAcds2U=;
        b=IBv7+KaDCEcfS/EQuVVsEP+4CKwl5y0oXsSv9eJ0gt5MB5D2WuwnJDOO8uHY3qgRJi
         6N6S3RK+Badv2kfykccZLmPovgIGx8sx6aA1x4bz8GEp1nM4cUTQ/NYltY15F5Iywzs7
         7RWW5ZacjvRiTJLZ9UjIOD/yTfyfiN/5i0M3cq/ahNI+aCGna3wy1UlCOEJSmKPdFcIj
         +fr/ZzIzgrcNN2hu9eFMQfdqSivyG0jEFgFpZWMUWbU2csx6ehJ4VBjHu7lGzq1GooRe
         Wv+IN+rq7oPareaQA4tuu3bbxiezS6+HMkpUT8vCcbY/3BylraiRI2IRQsPLNTJ7dp6u
         Rljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lDeKs++bIBWyKbnlwC68WUE/KZoeEZt0DgP2cAcds2U=;
        b=IS90PXnBpgWEglbwXn+hqAOIwyK5EmAiWugDgwTFGpGeNx0L52SSgbwcUUzGblAJn1
         OoHG3zBWDF4Cp5HnR9f+Ov7MlrMVKaRqt/EfQd0EEddz8HtDrHP/UdyWyt+yIu0Fw9ty
         JoWhhEZaJzfMUbX77TjB0PYjPymd8aW8sI2X2ZDkdRwV8Qt6jaHEZ2GwERq1BrGvIajy
         1O1Ef9tFkp2FpBkDYuoJ3/fu2Odq0Jj11Djm7BLLeP772nxf6CMbg1Xq0ya5+WR2RX5C
         UUxI61rMFpJbjWNKXtt+EjDjRvjrc/Wryv8XfpLEWdvdY8yZR9FXe/arssAxUbIw01D7
         Rk+Q==
X-Gm-Message-State: ACgBeo3K8Lh7Yvm8/yR8TKNgTiP9CGxdQPH8eF+51Pwf4pMjfmeILWBK
        i1otymqR8Cb19Q5nFTkDDUfQGXgSe4R50Q==
X-Google-Smtp-Source: AA6agR6QbO8O9WlW79Gg+1ooDP/d8bx0W5QopELTbQmih5yrQnDjj0QMihWBjFXY1JtHwFEWMm+x3g==
X-Received: by 2002:a37:ef0d:0:b0:6bb:4ec8:b312 with SMTP id j13-20020a37ef0d000000b006bb4ec8b312mr27929926qkk.249.1663196711544;
        Wed, 14 Sep 2022 16:05:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o9-20020ac85a49000000b0035c11fd1b49sm2566040qta.80.2022.09.14.16.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/15] btrfs: delete btrfs_insert_inode_hash helper
Date:   Wed, 14 Sep 2022 19:04:49 -0400
Message-Id: <36293c3f222b706b007147efbba1f793793ae0cd.1663196541.git.josef@toxicpanda.com>
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

This exists to insert the btree_inode in the super blocks inode hash
table.  Since it's only used for the btree inode move the code to where
we use it in disk-io.c and remove the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 7 -------
 fs/btrfs/disk-io.c     | 4 +++-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b24f78145fa6..44edc6a3db6b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -268,13 +268,6 @@ static inline unsigned long btrfs_inode_hash(u64 objectid,
 	return (unsigned long)h;
 }
 
-static inline void btrfs_insert_inode_hash(struct inode *inode)
-{
-	unsigned long h = btrfs_inode_hash(inode->i_ino, BTRFS_I(inode)->root);
-
-	__insert_inode_hash(inode, h);
-}
-
 #if BITS_PER_LONG == 32
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 124c210c4e02..0f925b896fca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2227,6 +2227,8 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
 static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 {
 	struct inode *inode = fs_info->btree_inode;
+	unsigned long hash = btrfs_inode_hash(BTRFS_BTREE_INODE_OBJECTID,
+					      fs_info->tree_root);
 
 	inode->i_ino = BTRFS_BTREE_INODE_OBJECTID;
 	set_nlink(inode, 1);
@@ -2248,7 +2250,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	BTRFS_I(inode)->location.type = 0;
 	BTRFS_I(inode)->location.offset = 0;
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
-	btrfs_insert_inode_hash(inode);
+	__insert_inode_hash(inode, hash);
 }
 
 static void btrfs_init_dev_replace_locks(struct btrfs_fs_info *fs_info)
-- 
2.26.3

