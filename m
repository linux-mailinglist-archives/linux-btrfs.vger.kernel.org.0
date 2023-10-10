Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38667C4195
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbjJJUlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbjJJUl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ADB91
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f6492b415so2463417b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970484; x=1697575284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=zmFAfCyBFhEb3caIdmOULX0jWmJlK1g3XB/Srysh+2LNbdvha5aFMWGly+7i3/oz3x
         DvQfY9TAjWyPDovBHUTedxUHHnDwec/VLC0OBurBevGG3pSNHxeawRxsS4ZO59baMyp1
         3/aw/FgQrDpR77GCRAFP2I3JhvVem522xJ9plBL8CkhAZj5gT4T9HbKQmrc1a97+k1eC
         /BfO2QAqP5kQ/scHieIpnmQK3bH3PzSCBx8Zxib+KSLVdsuefR2qtG1Uq3+Ulvk1ur4L
         8kjgPHjcs1w0W9SlGoXJvR1wnYV8Xawv82HnlV9clUsHp2niPgUuuiD0Ww+y7wmsMSId
         7JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970484; x=1697575284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=NeYvyDfes7dAE1W2r6PU1DhuECDr6k1yTY3zwfv8NSjEpdfQlZX4ik/IOATOS12dSA
         Fxsaf2I0q/JOccDAhWZ74cXvb6CW34ac+F7xuAcki4NhtBN23rk581OOX1lxNrNorlO4
         FfX5o2jLo1ZybJLDYdYyi0NeqVsCslnJ80Q8Az9OwYro0gkkYBFkpBXQgsoRYPpeTJIs
         Lij1fNBhDsRBU3l/Ye2B6MMgIOPBqzCRyGVt9s55JQ6JeWSeH7k4q+TUJ89MypzGMzJU
         70kyquKCtE7loMGmG6qspwoirN5fFxilSojYtahwrHaAtNCHgs+edEB3qBAMs4hHIM7C
         Iypw==
X-Gm-Message-State: AOJu0YxYssr1/FZOod/tv8UdkEhwzAVdyjbN1VsHh8a7OBM2MeR6yWYv
        jriGEjhHLWQ6tFKFstj5Z+cves/jlkvrEVPBewa8IA==
X-Google-Smtp-Source: AGHT+IE+pTDSAYCF/HlGbl+2jDt61Pxzj8VSRBlo6mYOzIJvcDB5o257HarTdfcxopAfSRtHDcz1+Q==
X-Received: by 2002:a0d:e813:0:b0:59f:699b:c3b3 with SMTP id r19-20020a0de813000000b0059f699bc3b3mr10419621ywe.0.1696970484152;
        Tue, 10 Oct 2023 13:41:24 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g68-20020a0df647000000b0059f766f9750sm4674820ywf.124.2023.10.10.13.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 18/36] btrfs: add get_devices hook for fscrypt
Date:   Tue, 10 Oct 2023 16:40:33 -0400
Message-ID: <c9e0b88a64346ce17f98b922997705bd9dfe9544.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Since extent encryption requires inline encryption, even though we
expect to use the inlinecrypt software fallback most of the time, we
need to enumerate all the devices in use by btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fscrypt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 9103da28af7e..2d037b105b5f 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -11,7 +11,9 @@
 #include "ioctl.h"
 #include "messages.h"
 #include "root-tree.h"
+#include "super.h"
 #include "transaction.h"
+#include "volumes.h"
 #include "xattr.h"
 
 /*
@@ -178,8 +180,43 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
 	return inode->i_size == BTRFS_EMPTY_DIR_SIZE;
 }
 
+static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
+						       unsigned int *num_devs)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	int nr_devices = fs_devices->open_devices;
+	struct block_device **devs;
+	struct btrfs_device *device;
+	int i = 0;
+
+	devs = kmalloc_array(nr_devices, sizeof(*devs), GFP_NOFS | GFP_NOWAIT);
+	if (!devs)
+		return ERR_PTR(-ENOMEM);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
+		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+						&device->dev_state) ||
+		    !device->bdev ||
+		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+			continue;
+
+		devs[i++] = device->bdev;
+
+		if (i >= nr_devices)
+			break;
+
+	}
+	rcu_read_unlock();
+
+	*num_devs = i;
+	return devs;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.get_context = btrfs_fscrypt_get_context,
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
+	.get_devices = btrfs_fscrypt_get_devices,
 };
-- 
2.41.0

