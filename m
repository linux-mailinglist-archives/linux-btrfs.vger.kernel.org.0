Return-Path: <linux-btrfs+bounces-1699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0483AF8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3218A1F27E2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAA8613D;
	Wed, 24 Jan 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sp6l0TS1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BA82D7B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116780; cv=none; b=g/nX/EXYknQeh+tLPmzc67d3Cq9HE8Vr+ZDQPTFn/s/ESIPWAPdS+tZsHs67es7SqwE52I3RAp69G13jbQScY+1G1MG06Fu5gypum1D4RDwwyO4WcYV+oHVax67czAI495CZVAJzbaouiUsULn645GDXjrVbBVT9tOZ1JGIpeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116780; c=relaxed/simple;
	bh=P49GXiyKc8W4Lrn+MTF92Id+QL/2VKmBbIUOPcqatzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/jXBJad+RqGeIyn1nmX1xxXW5XQx8VdfRTjjxs05V385uq8T+1/SIgXscsaZMTSymZvcxxRZt7Y8QfEp6IY2vm6kUFKxPzTIZSxUD4BTTkY+B/onoeXKBxKZi7+JdZSyztwIQgPwdG7q5KhkdiJa3oNR/EuPUBlLoMT3akngoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sp6l0TS1; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc371d6eb5aso1817750276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116778; x=1706721578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNKcKJc9HZ2bbZfCnXMb9oy7iE+uI1bDr5JHtenpe6U=;
        b=sp6l0TS15nSqm6GoOKrayel9pD+OH18RzenVRNDCGE//e6LVM2t+jdogbfCh8xOxu6
         Zl4ifFfU56lz2/+het0qW7LZ+uDL69Tfi5rmVPETGTE7KC6/Fx/jZCHl2sA7cZJ2aEIS
         622PUc6evGD4v8yVWfzQ840coe8MRQ/roECBV6tfpi74z8CbZL4Z68cnV6o5meXPWYIt
         FsdHlSfQHQCfll/mVangFOF0rS122RT+AjizD5Ss4QLptOMsYIqp2uc04yUzOezMCbxb
         7U3/DcD+vjAyLBbuKij/OvkowfUO8dW4Wn1+PLe/766urXyQ0MT2NEUTKLpMyoNZbUkH
         K9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116778; x=1706721578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNKcKJc9HZ2bbZfCnXMb9oy7iE+uI1bDr5JHtenpe6U=;
        b=a9WqBnvNw6aY5PT/cHA/yMB4VG19/dnhU2x2y5iZf6zxW8NnrKDv+fe7laRv4tykw5
         h+5AA73fSp+1Ng2J76rGzF3NLWG8YsGmIqvFyndxl+GQYTqfgFbCn3AblMz55r74NSCI
         qlVAn8b+nY1q5RblkQ8H0idtoReOEgv4iUIFyOKKUPsX668HrktMIzuieRXZ7ZatwjFh
         FKu0IEFEN+CW/LYBFXNEUcBNkcMtZya5zDAI5suy6az9X3LJ/zTT1SOUhM2WEFNKPTAz
         eTMtuNitr8dfzBBof3hjjT5eGwlFMm38gS2/iLzPOZ030jKKtVTcJAKt8BadhIWoaEYK
         Vilg==
X-Gm-Message-State: AOJu0Yx6v9/xReUt/XN/G73xJpA8d2pTWHFWGGgOJvOYelOMboTVOaBr
	vHFR6SWPkvgsz/sa9g2zfNLqio7JBK+IO2IndMCjvacJT9+XYKWva9ZF0okYDizAJ4BExFXZx6u
	p
X-Google-Smtp-Source: AGHT+IH8ht7DUP1Bie6l96yrNIxLySMaCSngiX1uLZt8JO16wy0dJeESEo3V8FMSogNpCH4ps62h/w==
X-Received: by 2002:a25:df10:0:b0:dbe:351a:5221 with SMTP id w16-20020a25df10000000b00dbe351a5221mr765313ybg.123.1706116778217;
        Wed, 24 Jan 2024 09:19:38 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s65-20020a25c244000000b00dc2310abe8bsm2959907ybf.38.2024.01.24.09.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:37 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 17/52] btrfs: implement fscrypt ioctls
Date: Wed, 24 Jan 2024 12:18:39 -0500
Message-ID: <6182b77868d0c9f9447641f869658ef017c1f467.1706116485.git.josef@toxicpanda.com>
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
index c333a49e5bad..07c9e04cd0d8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4595,6 +4595,34 @@ long btrfs_ioctl(struct file *file, unsigned int
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
2.43.0


