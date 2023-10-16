Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E07CB25A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjJPSWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjJPSWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:16 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3FFA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:14 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66cfd874520so32289246d6.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480533; x=1698085333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgLb5y9ux6Y3nH3Dpo6jruzdTCArFvbtPwPabW0o0qU=;
        b=jjA+hlEPCTz53gZaZ9bH56fYbeNOglyO5hB2C9Olbe0GNbx64su63qt/F7l8K9FvJT
         iJy7LPtJVhhKTXtMUeq0QBfHrxmA3LQzqgCrCOYQ2lM/gtooBOlzQ8toRBmfzq0Ieqq/
         GvTuXFhCkK4vp9JICwYBHNtoAqVsGQE6WIbRkmwk+xbpp/sabYjVwSbu4uxCU4ETPDSi
         q9YSlaheDMaR/53ZKVjVPy5Y7G3fpkL0wfKGBCoj0XOhi4MJvkoMUQ8/vpa3JXTd+Tjw
         9dKbiybHOCcfdOGTgPTshaTuuABsIvqAdi61jlUgCIchn0w7WZC9+jsTw0EEFN9nJ9/8
         QSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480533; x=1698085333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgLb5y9ux6Y3nH3Dpo6jruzdTCArFvbtPwPabW0o0qU=;
        b=vTl3Qo0UiixO4hyRjkNumRnX6d4oJlJ6Eil+W6ScrB8rA41lhmHo5M5xGOzc9oNVkf
         57ftMaQQ0MMIRT7Pacg2m2pU4wiwZ4nslASzUbMgPG4NqPyYWopWWirSZGCgvjj1Crns
         MdvPq0R6krZmTWzZRFb4OvPLafjfEZJhEBXy7q3vjjXDHA7sKmZui/MD+MPnk82MP8Fy
         h0l2Wa7PB7/CzEFwOrN4v9q7Vlz4/jUcWW2h+zWhr0sejkn5o3jxFucTTaiFgtfHtN3b
         N2DPcilPdCWaLXoYHmmNdHhp/GVEzvR4isrTPKjxK58FK2WDWoeqkhaFPeyAxI5t1lhm
         LSPA==
X-Gm-Message-State: AOJu0Yx0nWIEhkGRDHErHpk4OfXupX5SzPVRCPJi094d35Feyclm4Q6J
        e3/ptX03Rz0KbanFAWXvVFZZDtgpC+cry94PAl2HnQ==
X-Google-Smtp-Source: AGHT+IE7N4b2D5O6j1juMqHxmC0zHEMa2cexyFya+PdKHGcrlOQfY/MD4He+DdrYEB8VfTmMg6V0iQ==
X-Received: by 2002:a05:6214:b6d:b0:66d:a40:13a7 with SMTP id ey13-20020a0562140b6d00b0066d0a4013a7mr178912qvb.47.1697480533125;
        Mon, 16 Oct 2023 11:22:13 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pz15-20020ad4550f000000b0065b1768556bsm3574981qvb.108.2023.10.16.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 14/34] btrfs: implement fscrypt ioctls
Date:   Mon, 16 Oct 2023 14:21:21 -0400
Message-ID: <bd50fcba50b78552b1c2f714717cb247715349fd.1697480198.git.josef@toxicpanda.com>
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

From: Omar Sandoval <osandov@osandov.com>

These ioctls allow encryption to actually be used.

The set_encryption_policy ioctl is the thing which actually turns on
encryption, and therefore sets the ENCRYPT flag in the superblock. This
prevents the filesystem from being loaded on older kernels.

fscrypt provides CONFIG_FS_ENCRYPTION-disabled versions of all these
functions which just return -EOPNOTSUPP, so the ioctls don't need to be
compiled out if CONFIG_FS_ENCRYPTION isn't enabled.

We could instead gate this ioctl on the superblock having the flag set,
if we wanted to require mkfs with the encrypt flag in order to have a
filesystem with any encryption.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1f1506280619..5938adb64409 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4575,6 +4575,34 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+	case FS_IOC_SET_ENCRYPTION_POLICY: {
+		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
+			return -EOPNOTSUPP;
+		if (sb_rdonly(fs_info->sb))
+			return -EROFS;
+		/*
+		 *  If we crash before we commit, nothing encrypted could have
+		 * been written so it doesn't matter whether the encrypted
+		 * state persists.
+		 */
+		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
+	}
+	case FS_IOC_GET_ENCRYPTION_POLICY:
+		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
+		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+		return fscrypt_ioctl_remove_key_all_users(file,
+							  (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.41.0

