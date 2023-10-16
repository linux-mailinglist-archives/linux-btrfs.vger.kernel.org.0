Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE97CB25C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjJPSW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjJPSWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95189F0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:16 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-774141bb415so292032685a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480535; x=1698085335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=uq8ZhMCPcJr6rRMPF5HyYF0LbiA2rO3rQqoXej8oHEa4zpzD7C+1XR6QGDgrf0LJzG
         1PnE1g9xq4iDZ9zIxQs9ZPJiJzJ1SY2GMxhBPE9AJz2HFtnmCur7Bb9Ew6MNxOOQ1GDI
         BcAsFkN9m2K2U0g0kW2/1bvVyTvDC2g9FTmR9yp7nN5gXXeUuWZPpShIcFKE5R++J3gw
         9A53tGTwRnH91fO0SSrygsSjEEZpLD4hnXMMZVREOcvWrBgkRKrpg0Zj+YHaFRzs4A5Z
         DYbETliVlS3qKxCKYeyiGcX8lyxlOzke/yjhVZGlNm9kUOhCrtzZtj+Nawj4rKeNuCY0
         t05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480535; x=1698085335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=IOuEyqWHwLZbLjZbQLMY0CisSkLbYkrTTfRmbDsBBCXhpbtUwaxvNFVnw4cZ/U5EpJ
         2/3Kif+svZnEFhScFLVucT4CkYYQ9VDXETHnT4OGTqTp2jXCfR8fkIaJoKtfY1AGuG89
         2r+UYmbPv6yX3XvSvYrPoGCBxxjWYzCXudAiuvxotnD7+XxYi4dPgGskjNN7+QWzWeXA
         jmViBeg748XYmxIEZigOh/Zgil93Z2w/FlFILZ33NsraZHzI4aPmFGjFLVQpOxKLcHWH
         PYTaHmczW740ztm4s/P5GuYgZpf0gZoMHl+iPsaPz8FQdHvHY8QqyND4Y2zo9HmqrYJ2
         Qz2Q==
X-Gm-Message-State: AOJu0YzP0xF08pr7UADhFAp8EFWKI3Q5dvV9SnCXlfZ+HJ2H6k0sG8dv
        BuKmPsdEKArM5Oi20DlEAq9G8q6ZdjuKsvOJrjU+9A==
X-Google-Smtp-Source: AGHT+IFs82ZmaHGhlSJ4huGmFqllCxJ4+yO9pWjPj9PeYxwmlGkqpYcdalgbsGZbdS/J1et4lnufZw==
X-Received: by 2002:a05:620a:13cc:b0:777:27a5:d1e with SMTP id g12-20020a05620a13cc00b0077727a50d1emr16186008qkl.41.1697480535554;
        Mon, 16 Oct 2023 11:22:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m9-20020ae9e009000000b007671678e325sm3211350qkk.88.2023.10.16.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 16/34] btrfs: add get_devices hook for fscrypt
Date:   Mon, 16 Oct 2023 14:21:23 -0400
Message-ID: <26a91a3212f824a20ce5dd1b768305923fe2529b.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

