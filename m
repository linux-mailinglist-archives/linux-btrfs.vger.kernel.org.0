Return-Path: <linux-btrfs+bounces-1696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11C83AFDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3862FB2BA94
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA885C49;
	Wed, 24 Jan 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Er8S1GNR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82282D7B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116777; cv=none; b=R5efgI/UZUj6jPgLtRFTqzGIUgdGZJzCFehBcpBz9PydrP8HUGyLPGGHqxSclKq6yuQ+zJntzcOiF0oBE8+cjr0WNGBi/GwN7UCUPVcNahB57T2PiJJcXGNpzBo5d37F5J3dNq6e9UeTHPV/bexnL2F745GKSCsBgQ+cG5GSjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116777; c=relaxed/simple;
	bh=OlBHhKisUlPCrNnx9U+0wXpi8lJXa7vJWPFez8vMs0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cdbvicgbw0iTkIYs2iYcHZZ2w0zwwTvgx8gXuecrFwIF4lqG1lcVtFLr2aIcve+w+UvsejlwfMTynAWNkwNB9bYXnnLVRrF+7jH2qTyvZpFYACw8+MrL3OQKft1BplzR/Mt2GhhueeoOVqsRJXAFkj00xz71zU3x2y/O4hETCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Er8S1GNR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff7dd8d7ceso50975497b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116775; x=1706721575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B90h+ogtiYX77+oD841lDmSgsgTD/UgNO6cKltWxjdk=;
        b=Er8S1GNRgQra2W8Ef3HyhC2TVcPX3WKq0UXzRCDVgLMGewpmMHRenSegkxdwNm7N7r
         DjyZWiqpe7Pga5AE+RiBGwpNYfxg8vHKceDbpm94xni2O2WEr0WRUcBx5zaekEaT6hSU
         zjhcMBurLqTsFvKleAwnJOU6GAqleBjLzrnQrsj3nMw4ZRFTcde4mQ7P911NjIH+LPda
         mz7E70NbTJCXGd7lPHaorqRwcQr1gUqSwgJTMJJj8iZf34zHHkfQJusqbclSm/xbndP4
         LZNlYmL2JD04CrSSjy6aJkV3Pkzguinop6dv3UE+BtO4L7LrTOPmuuF1s9Y/VSNkmne3
         lj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116775; x=1706721575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B90h+ogtiYX77+oD841lDmSgsgTD/UgNO6cKltWxjdk=;
        b=Iq2UpM+Bs7S0HRy20Mg54jMsv5ih8Ow7Xgg/t6h6kT5622AMhaeVP7+CAmHZz7JJDA
         2iCphsQRZLGZxoZeUznNFzct4kXErUYFHfn0EfpW9voOpJFK5wtLnsxbXSzbIlvEiRZ8
         L/S/hXaa/k+ZT2RfLKJg5eotLJCpQqDBNdK7FIntxAzNbkZCduscGhZ2HSvCI0lhj+ym
         uKptlyq5U8Chsb4ojTWHKSTVvBLyGe4m2E0ESBJe2IO0Q44r4W9+rkGQBJShYBauxsJ7
         xwr3O5SWjXjzdHvHOAFq8HRxF+b232KfbOe1W/1uu3FWO7uY5vAu97UXhZTiaViNoeX4
         4Lcg==
X-Gm-Message-State: AOJu0Yx5+FtLbaHNSQUlpuYvFOPfZtcNC0iGURN77vSF9WMunN9POAmT
	fE21j6pjRZPYxTBhZGMnbYBtj/5zjSgCw6HK5jImnRfIWuWklyOjUo5+Blcf7+lMRhGOlZt88gL
	1
X-Google-Smtp-Source: AGHT+IE1JyRcZiCAeKUgBbJG3dRYafar61HDbvkTbNI+ammluJrx9CCeQW/xUVVzPOGQ7OYo41REug==
X-Received: by 2002:a0d:e0c3:0:b0:5ff:7a74:412e with SMTP id j186-20020a0de0c3000000b005ff7a74412emr1147444ywe.38.1706116775115;
        Wed, 24 Jan 2024 09:19:35 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ft9-20020a05690c360900b0060026481ad9sm73325ywb.0.2024.01.24.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:34 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 14/52] btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date: Wed, 24 Jan 2024 12:18:36 -0500
Message-ID: <ccbea52046c1dadbbef926bfc878cc23af952729.1706116485.git.josef@toxicpanda.com>
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

From: Omar Sandoval <osandov@osandov.com>

As encrypted files will be incompatible with older filesystem versions,
new filesystems should be created with an incompat flag for fscrypt,
which will gate access to the encryption ioctls.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h              | 3 ++-
 fs/btrfs/super.c           | 5 +++++
 fs/btrfs/sysfs.c           | 6 ++++++
 include/uapi/linux/btrfs.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..1340e71d026c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -232,7 +232,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 
 #else
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 33bd29fa2696..28fbe366717e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2438,6 +2438,11 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=yes"
 #else
 			", fsverity=no"
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+			", fscrypt=yes"
+#else
+			", fscrypt=no"
 #endif
 			;
 	pr_info("Btrfs loaded%s\n", options);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..f75b00805462 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -304,6 +304,9 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+BTRFS_FEAT_ATTR_INCOMPAT(encryption, ENCRYPT);
+#endif /* CONFIG_FS_ENCRYPTION */
 
 /*
  * Features which depend on feature bits and may differ between each fs.
@@ -336,6 +339,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+	BTRFS_FEAT_ATTR_PTR(encryption),
+#endif /* CONFIG_FS_ENCRYPTION */
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f8bc34a6bcfa..25b01cf0a3b4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -334,6 +334,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
-- 
2.43.0


