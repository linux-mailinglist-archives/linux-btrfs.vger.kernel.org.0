Return-Path: <linux-btrfs+bounces-500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B18015FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B95D1C20AFC
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AC3F8E2;
	Fri,  1 Dec 2023 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="te1o93ld"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EA10F1
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:19 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d7084b6bb1so3014677b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468739; x=1702073539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=te1o93ldXA8bGPpTugHIdBQXZbUqnFxjPgdM+XseecIqy2KSdnC2xMk4JbyfOwZAru
         Uf4ggk70UcK8ULMamB+DXy1s+MLDu/oxLNyMMriy9s/FWPLiLdbsm7P8Shv2ZGbInaaj
         xU9bbF4TmJp5w/4cuqOS5nnSUnAyvsVYbfzKuA+z2TCB2+Io+hFyv+qEeiKKe35xQumu
         MfhYquLYoAxUFF8JigQKp1JIhVlFw2hCeWkK9rjBfOgtTI2qyKJ1PS4djrlyc37rXjvJ
         GEXmE4Gb3kwSQ19btVa52U4NMQassVSHd4ITwvHAQctlKpBxW5NAmCZ6f2hFUGGOd47s
         /3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468739; x=1702073539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/5d23+Piiaq9wfrRh434zM+tA72DN+x3v+pwhuqj8=;
        b=BZJ7Xx5GB6oZtRTqPI5bo2tE8nl4AeWaisaBmI4K2GY7xVn0fphEj7Z95QJLc+GDCg
         hvnk2uRgQKaHJaluWhBPFkcZBMQAR783c4lnqFEUOkHImi05X0w0wVw6ezkye1816PEU
         eK1sqb6Fc3N7FKqF93+WPU30tReFaL3D1shI6EsOuIMSyrgpy2mKHDl+mhSM78+BHkAj
         aZOY5721xlHvHDbLc0UEzEVARJWY8Tw/H4peIVCfXlIUTlPG9T7TItxOA5MCSdxGiSH1
         vmdmU/WG3BI0sKm/XyVKCBdbywV9OoiTeUZEXL6pHiElow+CDuvzZCEUU0I1Gwbuq1de
         P36w==
X-Gm-Message-State: AOJu0YzMxHOna+4uk3KRr9w8n9hiUgDmKBN1GAfpEhmbPuvuPeFQ9Fx1
	kFr/eWJf1ATMfIdn0FPUBSxMZpa/nnSubt3F17AtBA==
X-Google-Smtp-Source: AGHT+IGwKgKwJieuod2BvgdYGZbGi6RK3u0kD5BnpiTCasyQjPg9Qmn5EOtaFfHx3/XBEyUTpFupSw==
X-Received: by 2002:a81:99d4:0:b0:5d7:1940:f3f1 with SMTP id q203-20020a8199d4000000b005d71940f3f1mr149497ywg.89.1701468738787;
        Fri, 01 Dec 2023 14:12:18 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t7-20020a815f07000000b005d0fea7ad01sm1392549ywb.122.2023.12.01.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 18/46] btrfs: add get_devices hook for fscrypt
Date: Fri,  1 Dec 2023 17:11:15 -0500
Message-ID: <7d727ad8e77df8e05f8e1374abbd4745603221d8.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


