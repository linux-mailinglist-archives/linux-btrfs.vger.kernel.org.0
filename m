Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399F5B8B66
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiINPHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiINPHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299E177E8B
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id v15so11946884qvi.11
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=hVeEiFzUBicWQNEtZbrGjc9hHCWmhrrlQQAcHIcKd0w=;
        b=dBtodQZ1eVn67+RUhtYAQXI/GoFJTTRilBQo/9GXiKlo0YNRc+ZJdNiyMjgMwQAEPF
         Z7px/yk2MRFrSHC3IdW8nA0hPGptGmmkW5JCHML0OSxkRlEkX56yb1+j3/xTcngh0G9s
         TygeYmF61oB2nR0ZKMb3yW2oOOIB8qqIaVz69uA47dj5ElieesjJMRR5C3WGdcUKQkqN
         91R2V5uVG9Vpk69fEeBL0tbGQRau8vnx4tDKrhcC2mnmidSERUzwi3dsGuW+ROhXxWbJ
         bm3CBjc6wTsRLcGJzVJ9g2LquQ6GTNEmK3KxTZF4RoqIWO3thYxrsmQ+LHm/NV9lN3sa
         Odzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hVeEiFzUBicWQNEtZbrGjc9hHCWmhrrlQQAcHIcKd0w=;
        b=s5/xbMqnspEm96jfqjdEkvjSwpeh0k7/ze4mT3a/2C1Ac8VtX7ebXZrMiOf/GpeGTR
         WuEdOPUpJw7sXluyAKW5aXKzrli6fqKDLqpi5r5k7l5HSJF+cGfW4HDM90UnGo5zTmtE
         +HTa/HToqcvyGx2PLqAWYJZhKnMAx4JpS53lGvmfk77YPylwJSvALqEc6bhxQDyKQBuY
         mssuiYIxTs1gmtQCzL6XH7+K1wIew/31mPM9kfCjRnSJYPx4uw1WRcEIdIc4mmK90pF5
         +0nGR+iKlGYGfssiWiQbsndNJD/gNw4D0jmWLW1hIfgpqCLytbwR9dU4MEcMn3zgbXu0
         R21w==
X-Gm-Message-State: ACgBeo05MmhiyIoIGnJCJygXhhvUKnM6VFA4sYRTjE02lfkYQIdsE4hJ
        dtg23g/o5/Rr5+g+I6uEwQVwTmHcl67tFg==
X-Google-Smtp-Source: AA6agR5t6oXeGVs+/2xwdDGUJeOVNGSTOaJ7jlNJ/vsQduoXpvVqyZlz4phVo8Gq16n0Pbtq7RDPyw==
X-Received: by 2002:ad4:5bee:0:b0:4ac:d9d2:d630 with SMTP id k14-20020ad45bee000000b004acd9d2d630mr4401775qvc.65.1663168028673;
        Wed, 14 Sep 2022 08:07:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp12-20020a05620a458c00b006bb619a6a85sm1914324qkb.48.2022.09.14.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/17] btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h
Date:   Wed, 14 Sep 2022 11:06:41 -0400
Message-Id: <f86d4f92429b1efe41664e67405ce6266d7d2ea7.1663167824.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

These are wrapped in CONFIG_FS_VERITY, but we can have the definitions
without verity enabled.  Move these definitions up with the other
accessor helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 42dec21b3517..cb1ae35c1095 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2499,6 +2499,16 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_left,
 BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
 			 struct btrfs_dev_replace_item, cursor_right, 64);
 
+/* btrfs_verity_descriptor_item */
+BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
+		   encryption, 8);
+BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
+		   size, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
+			 struct btrfs_verity_descriptor_item, encryption, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
+			 struct btrfs_verity_descriptor_item, size, 64);
+
 /* helper function to cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type) \
 	((type *)(BTRFS_LEAF_DATA_OFFSET + \
@@ -3742,22 +3752,10 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 
 /* verity.c */
 #ifdef CONFIG_FS_VERITY
-
 extern const struct fsverity_operations btrfs_verityops;
 int btrfs_drop_verity_items(struct btrfs_inode *inode);
 int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size);
-
-BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
-		   encryption, 8);
-BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
-		   size, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
-			 struct btrfs_verity_descriptor_item, encryption, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
-			 struct btrfs_verity_descriptor_item, size, 64);
-
 #else
-
 static inline int btrfs_drop_verity_items(struct btrfs_inode *inode)
 {
 	return 0;
@@ -3768,7 +3766,6 @@ static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
 {
 	return -EPERM;
 }
-
 #endif
 
 /* Sanity test specific functions */
-- 
2.26.3

