Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924567CB267
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjJPSWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjJPSWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:18 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95577E8
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:15 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457c2d81f7fso1420089137.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480534; x=1698085334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87dZSqgSaXj4ytyfF35JvwlP3e7S7MAiVwyt9dp8ebs=;
        b=d95LY6ci8Z1SBdf4koPIBPeRJy62OdxTX51wB0aaPpRPAiXAuhIk34UYlWvKgPUa9+
         q23BMJx10x18HVZh+TlM+gWMtmu/a8kklQkdEgszlSi+vyacvJubWboEH5+3rTTvv0hX
         tL6AHN+SglQ6Qe0lw0XQnyt/1B/bvB3qbokXqnlAirxZ4b68KUoZ3mtvuWBW+vl2cUtm
         17htLMZ3xzhCJzAJciOR/h5BvIO8Mj+wGPyMsdvtZhkGHR2mLYhCuotuwpeYqkq9ZsYv
         MIlJoGKcdBPK2NzsQFurzeHi6A4wa/ESrTYeZ4aAzXXhm/YxTvA30dSRUTlcILJX2+Bz
         VG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480534; x=1698085334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87dZSqgSaXj4ytyfF35JvwlP3e7S7MAiVwyt9dp8ebs=;
        b=E/HkjeEHXENxbmHPEBQC0PZzF7aBYCXtxmzyXKzwjEffsf46QbhSA6mDpGIO6maGE3
         9p34x+V1iWSta8tTHXyRXCH+vKoCNw1l84AR44exkmqtCN9Gta3+4deExyU4n4cW1giQ
         +cKkskSWDdI0s0Fzk7GhcqERBqjBTiFT8Q0F1+y5+nNrvoL5Q1BdqoC+cNxHxUQREP7u
         663nOFeR69F26BS6DaY1p+0LHFvlN73GT7yjMhcSyatmlP3i7icaJYeRPZthj3xNwXPw
         qqqGo/LKhOn7DqnVosPJdGGeVCUgLxWxL1FtjmVmO7y/DyucFEZlb/TSusDvCmwdh2JY
         3gyg==
X-Gm-Message-State: AOJu0YwgXl9ItXYGe2ahXMymyRzW5gFWlhkGUntDACp6YEX1ju4zGWGO
        74FT1I8cD/lrmbc9PXoCUTxhw6Va34vDT1RmEKK+IQ==
X-Google-Smtp-Source: AGHT+IGX4OZmPGJbNkao92J5e+RbZj7bsF2l4pM5XCw+vVNI1ES/YkVCLl9sYFMP2mEYo/C6QuJNiA==
X-Received: by 2002:a67:e08c:0:b0:452:bf74:bcec with SMTP id f12-20020a67e08c000000b00452bf74bcecmr118762vsl.10.1697480534396;
        Mon, 16 Oct 2023 11:22:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m13-20020ac8444d000000b004195faf1e2csm3195505qtn.97.2023.10.16.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 15/34] btrfs: add encryption to CONFIG_BTRFS_DEBUG
Date:   Mon, 16 Oct 2023 14:21:22 -0400
Message-ID: <da7ef81eb79d8e8d969b08d672d970dfaf16ab1b.1697480198.git.josef@toxicpanda.com>
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

Since encryption is currently under BTRFS_DEBUG, this adds its
dependencies: inline encryption from fscrypt, and the inline encryption
fallback path from the block layer.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5938adb64409..c56986031870 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4575,6 +4575,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+#ifdef CONFIG_BTRFS_DEBUG
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
 			return -EOPNOTSUPP;
@@ -4603,6 +4604,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
+#endif /* CONFIG_BTRFS_DEBUG */
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.41.0

