Return-Path: <linux-btrfs+bounces-1702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6B83AF93
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F92E287827
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A48614D;
	Wed, 24 Jan 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sPvIB5bA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B598614E
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116784; cv=none; b=F/7GSG6jnis1pj8V8z52YVT2+3rw1Jyf3sNBLtFoWyRVOFiTU+zvtEupLQf9WfF85p/aIPFQ1/71+UygOIPLCXUXv9yNYGLgZ2sowjNaSf6PMb8D/Bk9NBGMHjqVVgBc9EsbFV0/6nuEqnQ28rYdmFgoFV/3snPUbZDvgCUR2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116784; c=relaxed/simple;
	bh=zBS4tj7p6wdi2S2c9rzrJwH3Pnq2y1YRCgBE8bZkkOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTGHMfdoL+0dAysyVVf9UXRLFMBvl5W1mYqW8t3YXZjRUmD4VvNquHY0/aNrSP2Q2TxwiQONHZ4alMe8k5NqP8WaJnWvkYpvh+4dQdZAmotvWcOYe6GetyEFh7DaD3M3DmyahlB3gqGSlTsjScjU9vT0mRwxMofVuMgyIDQxMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sPvIB5bA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-600094c5703so31879267b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116782; x=1706721582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RsNjk6X+NawRnX4gaFC9qEi6vvGwYRfRvQ1fbFNQbQ=;
        b=sPvIB5bAIaP26/Kcf6iR9fffeRkyJmjtFwocgKjoFoc4holea6ZaRhiTd4dsnpPeDj
         colDLs/xg+vURHhDHEH9V00XqKyIL33evxrHVkIYx4539L6AnakKjSMTJybwK+uV3hmJ
         XYbXxzV64EqgETgnOm2xtabTTRu1cQMphs7Alu3jrVmHgXEcLsDNtVa0o18aNJWR7X+1
         VXV4ItR5PK+qYDjzEvAl5gdfhFqBe/Luj14aIy98hb8AJuR8r7JmGgTcd+qtzZAMZgQG
         XQc9uoNXKxtmzUIv92CSHO+ABw1S2ktnYvVTOpWlCoUMUqxjoJuwaaTprMavP0UnwRvQ
         K96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116782; x=1706721582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RsNjk6X+NawRnX4gaFC9qEi6vvGwYRfRvQ1fbFNQbQ=;
        b=PuJl0Rpo6ytiJpfKYpPm7fCnExI8tCVJCWwKZV+yt7oae+XXKP+9fCxKIPhSQDIhmp
         4Rucm1eAf32Ux1oM7q8EjZZH+cxLfLvAtrG0YhnJEvS8T1I2xNmxChNWT5fox1QMw9cp
         rjKG4LbtT3dN9yW3FqMfgSCcbe+eYvMaGM8tc1V4rG7IOQK2Cp5DxXBgFarmSIsgEUus
         DmMaByfVER8uHqBeh0Vz2D+jIJAvcg9bxAyfEJ+8qx6yuYODYTdoFxXCI9q/X3om1CR6
         W2JIe4z/7xAkmntpaFp0we+WgpPd6GpAHmdBXeAaRGaoRoHvB5wqvmoSbGfsZ+HAej5Q
         hlTg==
X-Gm-Message-State: AOJu0YwsNfzsILYfRxecPdkMGdvrSjX9D2a6Jbcg3MaeVNT1sEXE9D0c
	7aOVKvOH1fxk1OkWQe2VXeJR4MjIsgqRUfEHOq8w+/3Umtcap2cHVnG1Rw/sh7uyLXnqKCPY6nS
	L
X-Google-Smtp-Source: AGHT+IE/AlZ3SPRnMrjGAmpNTbkbQy4qzD5lIG3ZFfzV247v051CN4gHVFV7OWSh9/skCP14OXRU/Q==
X-Received: by 2002:a0d:d504:0:b0:5ef:463c:8eea with SMTP id x4-20020a0dd504000000b005ef463c8eeamr997894ywd.20.1706116781603;
        Wed, 24 Jan 2024 09:19:41 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ci26-20020a05690c0a9a00b005ff6419ec70sm60316ywb.109.2024.01.24.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 20/52] btrfs: add get_devices hook for fscrypt
Date: Wed, 24 Jan 2024 12:18:42 -0500
Message-ID: <47ff044fae65cb2b06a6bb6ffc91027511c4d1f4.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
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
index c38e12eee279..7129a6ce0780 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -12,7 +12,9 @@
 #include "ioctl.h"
 #include "messages.h"
 #include "root-tree.h"
+#include "super.h"
 #include "transaction.h"
+#include "volumes.h"
 #include "xattr.h"
 
 /*
@@ -179,8 +181,43 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
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
2.43.0


