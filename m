Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDA7AF222
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjIZSDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjIZSDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318E10A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-418201cb9e9so20202281cf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751412; x=1696356212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1ut1eGlCPCmMqejgBLg5HxIEK1EjS+ponZAJUh/G80=;
        b=Uks2nXAmEsqrJQh8sVM19oeXDuI7hcFAsG5HTKABJvy+uuVfuQUv+Vz8aqt9n5/Kp2
         iv9PxhkAiLSy5kpbNKlC3wHL2NqoVDvaJaOVvv781BkM6Z8SxNP40xf063hDWnmIiGDg
         2oSXDfPfhyLsdOUUUgN5t38C6tgHzrYToEnR3HCq7ZAoWDzHsZy9eCTovSax/lsasSSz
         yIpRruE/BcSlYRT1Cc93EN6x4EQEE9xchhjkkWwN7ayFYeMQVkuoSTzLglEhkjnh8lOz
         JgdFwtfrqPtUNZ56wHTXpr51Cy5UZ3yUrYedfJT9RDNOQ+a2Kri0lOpBNmg2451w6Nrn
         7UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751412; x=1696356212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1ut1eGlCPCmMqejgBLg5HxIEK1EjS+ponZAJUh/G80=;
        b=NxfT+/IzfJpsilkEOUxqS5oGQxlvlpWAKIe9eq9gAUnUY55EAp4bkTntGD4ey3PbAp
         feP7VTOx/1+iZGXMRX8Tl4Xg6GHj4fJAMlxPi79cn+IUhLuQ3c1VhZBcpxenpQDgEhi2
         TlID5FPWMzx4ZgBA/9qjIEnXz0ffYm31wyDnPIOh5WQ8mOq4zRkuo+JMuwH+Kox1Ij+y
         lFu1own3MFMB61Nwnjfj54jzL6MPy1achrjFYYyaQzIjYAb2PMHb+alyEutl3UQkis1B
         QR29EwMafCeYlUhLVSwIjnLYfavqfS6GB6J3Kh/r5+fqGYNMc/PiB6F4WX7eCsRaY1vY
         XR+w==
X-Gm-Message-State: AOJu0YzN9MGWcLGtvq1QkQtSvwbYlWQKjWH3wDisU/TLJUGJkXRcLB/Y
        4p6iDiIZ6X60HKJ8FNc7hUAZAAemOOAinYOjr431DQ==
X-Google-Smtp-Source: AGHT+IGDD3CLb6BKRvIxHljcisUPwdgauW3IXylDs1wlrx2+biHroD+EcrAiMFJi2EDWZyxRJJeRjA==
X-Received: by 2002:a05:622a:182:b0:417:a209:c250 with SMTP id s2-20020a05622a018200b00417a209c250mr12291473qtw.36.1695751412714;
        Tue, 26 Sep 2023 11:03:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jx18-20020a05622a811200b004180fb5c6adsm2631371qtb.25.2023.09.26.11.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 17/35] btrfs: add get_devices hook for fscrypt
Date:   Tue, 26 Sep 2023 14:01:43 -0400
Message-ID: <5d485b376693246af86f30f859efabc62e5e37af.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
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
index 254e48005aec..4fe0a8804ac5 100644
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
@@ -178,9 +180,44 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
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
 	.key_prefix = "btrfs:"
 };
-- 
2.41.0

