Return-Path: <linux-btrfs+bounces-497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D038015F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EFE281C27
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4661FD4;
	Fri,  1 Dec 2023 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1XvDMNHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC6BD50
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:17 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c08c47c055so29080417b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468737; x=1702073537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJBhhgJ+1T9YX1Azl50SzieInTuno7x/kRfcGFlFKhk=;
        b=1XvDMNHjmsg1O2b89cOD0fX2jISRqcWq9WFoV5788CPayCC0YPtDi3wANdjWo2LTV8
         XPM4bBE2jC8wQzJ1GChUs+AFRFURxzb/T+bZ+U0COEFF8s2pxOR3r1pSaJBSj/KoA+Dv
         yzp6WUX4xbR3jEmsL/ZHUOu59RPUzDJYJLuoueAl5VedMDvlub7wkzeFXwCnOGoXFa3r
         Q8Is/ofhHaLgXJCZUW4C38olJGVhcqa0go3YwgVQRVWugvvbsri83XC5sJr2MitO0BAQ
         drOBV401QkF1B9L9VRz7ROkM9NNifBhGjLeEATWmcR+gCAgegs3JSbVQxJLXBDx3iMN1
         BZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468737; x=1702073537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJBhhgJ+1T9YX1Azl50SzieInTuno7x/kRfcGFlFKhk=;
        b=v2kkaPVgviLfnN/TA5xl+29DGINbwyVeWrh3mWgkDmUY7by8B3bMql54JEhcHTHS0X
         JNKGq7pLK8zRsUWy914dhES8hHy7o4ES1NtlXVpimuozjgwuXTEHn1UuLAm+1wyu9tKS
         ddEViqvdeqTBEktxJQqmFyZjJ2rvjeOfubNLbrtOganAzP2w5eK5wejWAL8aKjhxEMHl
         YMsaT0OIFpsa6+21Lqm4DMRaz3LLsBGMzMzDGtm2IhEZIoU1EGfsI5scJ/Yfl1Qoss7c
         3OKsUgxHxKH36XD/xAFHfsyqi25JeZ+fTFrUZVTuLccNgLHm808KUdlr9Y5kjU+Yxz+p
         lcwA==
X-Gm-Message-State: AOJu0YxZ6EKnw/xAnkkkjgyteOfiOK4MpFlw5pzTt3Ph/HZn0tu7rMwn
	AmvN2gBzEuQ3TBTC7vsjhpd/3s4yLPfmXFYntp057Q==
X-Google-Smtp-Source: AGHT+IEpiSNvOiaKjibA/IViu1TIx8ICi0Ven/x7rIS7LMv7zL85hNSe7A2i3HsIVEp7yzw53XnwMg==
X-Received: by 2002:a0d:c985:0:b0:5cd:6d0e:5369 with SMTP id l127-20020a0dc985000000b005cd6d0e5369mr378564ywd.34.1701468737049;
        Fri, 01 Dec 2023 14:12:17 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h13-20020a81b40d000000b005d1b2153b7bsm1365091ywi.18.2023.12.01.14.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 17/46] btrfs: add encryption to CONFIG_BTRFS_DEBUG
Date: Fri,  1 Dec 2023 17:11:14 -0500
Message-ID: <162cd559b6a47e1df6e49b15acb24942577280f5.1701468306.git.josef@toxicpanda.com>
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

Since encryption is currently under BTRFS_DEBUG, this adds its
dependencies: inline encryption from fscrypt, and the inline encryption
fallback path from the block layer.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9968a36079c4..0e8e2ca48a2e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4573,6 +4573,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+#ifdef CONFIG_BTRFS_DEBUG
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
 			return -EOPNOTSUPP;
@@ -4601,6 +4602,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
+#endif /* CONFIG_BTRFS_DEBUG */
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.41.0


