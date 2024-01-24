Return-Path: <linux-btrfs+bounces-1685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3E83AF85
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715A3B24E2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B381AA5;
	Wed, 24 Jan 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h1EsWj4R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042817E79D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116767; cv=none; b=uF2aghdiBVW7+v8frPJX3N9cNri6lS/yWo+d6iROVnGYiYbqq5nkPpbv/4k/mjr+lCGIEO+19UInon9XCkU5EH3NLSO0js3iDOkoE5KOkzKksX72FpO4OyCoYdrxes6+X36Ucy+ySII5diwV3JIuHMClkcw6URIcljyUdyFKkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116767; c=relaxed/simple;
	bh=eZne7HqhhXiufV0PXcYC5it68SFKId/5gP76TZ1Lfv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed+XKA/kneUXh01/gJZx3IW5FXjBFOEuv64cevRVOXgXnTfBkpeGfGPRVCMb4aVgB9l5CcuHcK5LsfizPoX189NfC7vgQairI6fYvGssz6ZyGTp7AY/rrWWdyvL/4uDQSKW+ojoRgPzKjxyS45tRtacjpNtOlRAakkigz8kvb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h1EsWj4R; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6002317a427so26656527b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116765; x=1706721565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wx2LTxH6RR4gk4E8SP8w9w53uVWI0FYojuhik/P720o=;
        b=h1EsWj4RlrhUjuL37js2qE2DW+7pd29NASOKE3/8o2Wb0EGf1Svl61BzyDk8vKu3zt
         NFZGL3wR0CBvACluMUQT4CM5MgYSQmJXR2hjggwz1UIqsaRHcBcM+d9s5fgHSBaxtdl3
         iMi2p/wyiddH0D6DmBPgm7HyXQRiXHWdxp7gF+el6eCgETzyK8Gfi7m+ecbPAWok82H1
         P8Alsdf4MDuFYL9xj95QBgsgY5enEWegmKNBw5MTnevZ38jayf1IKGxgFfd22Q2EFA+w
         Nmhsn5tevqW0Avk+t2svmulmQq6e266QR3zeB2B/VpZ2mqp+ehwaodKLh/5M7z1BAH6u
         +uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116765; x=1706721565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx2LTxH6RR4gk4E8SP8w9w53uVWI0FYojuhik/P720o=;
        b=YsuUeyq6jhVQhxguMsW6wX9QJ3PQ2YBIjhu/2MIv5QohwB98/3+r2T2bQ+J1I+w8js
         5jRMUVgXwp96L3gj//QWBDpFYk/t02yrzV62NjxG7VoN8ZlVQQ2dAGCx2fxoLDD5ntJ6
         2lngTqnBqApjC9PApjVeba88pSxtzK/otuwC2eP01IzXtO1jwfpiWqSye2W3mF8VClvB
         Xrx6cNyh/shTrSVS/BlGWh7nhokITpEyRiG+GJ/YhXFqWOuZBYdI//GenO6cil2AgpSN
         chWg/0mSIc/wKALd5zKYQ84GMoIfT2HPCkCcW/u0sl9/MPcNe8Wm1sZtudB+kP0Ihhli
         PkIA==
X-Gm-Message-State: AOJu0YyehQum9dnXpW4mml61AagRbsfh0bUnBnAMsO+++yPnBHe3my19
	mYMz2FtRc2DN06vPmGbYu2CFPk00gricR5l0ND+td3wrQk81liuNVdObOyfIpwHu/71pkC4hbn7
	/
X-Google-Smtp-Source: AGHT+IExPOwNP2rbnd1p3UUmOLkDQaqosENvfi4yeTgy73JlNSkfKwZf0nlKV3ySecQw5Va/aYGowQ==
X-Received: by 2002:a81:6d82:0:b0:5ff:abd5:c81b with SMTP id i124-20020a816d82000000b005ffabd5c81bmr1080496ywc.70.1706116764785;
        Wed, 24 Jan 2024 09:19:24 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fr5-20020a05690c358500b005fffb25df43sm65444ywb.22.2024.01.24.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 03/52] fscrypt: add a fscrypt_inode_open helper
Date: Wed, 24 Jan 2024 12:18:25 -0500
Message-ID: <4a372419c3fe6ad425e1b124c342a054e9d6db23.1706116485.git.josef@toxicpanda.com>
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

We have fscrypt_file_open() which is meant to be called on files being
opened so that their key is loaded when we start reading data from them.

However for btrfs send we are opening the inode directly without a filp,
so we need a different helper to make sure we can load the fscrypt
context for the inode before reading its contents.

We need a different helper as opposed to simply using
fscrypt_has_permitted_context() directly because of '-o
test_dummy_encryption', which allows for encrypted files to be created
with !IS_ENCRYPTED set on the directory (the root directory in this
case).  fscrypt_file_open() already does the appropriate check where it
simply doesn't call fscrypt_has_permitted_context() if the parent
directory isn't marked with IS_ENCRYPTED in order to facilitate this
invariant when using '-o test_dummy_encryption'.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/hooks.c       | 46 +++++++++++++++++++++++++++++++----------
 include/linux/fscrypt.h |  8 +++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..6b4291d5eb44 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -7,6 +7,38 @@
 
 #include "fscrypt_private.h"
 
+/**
+ * __fscrypt_file_open() - prepare for filesystem-internal access to a
+ *			   possibly-encrypted regular file
+ * @dir: the inode for the directory via which the file is being accessed
+ * @inode: the inode being "opened"
+ *
+ * This is like fscrypt_file_open(), but instead of taking the 'struct file'
+ * being opened it takes the parent directory explicitly.  This is intended for
+ * use cases such as "send/receive" which involve the filesystem accessing file
+ * contents without setting up a 'struct file'.
+ *
+ * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
+ */
+int __fscrypt_file_open(struct inode *dir, struct inode *inode)
+{
+	int err;
+
+	err = fscrypt_require_key(inode);
+	if (err)
+		return err;
+
+	if (IS_ENCRYPTED(dir) &&
+	    !fscrypt_has_permitted_context(dir, inode)) {
+		fscrypt_warn(inode,
+			     "Inconsistent encryption context (parent directory: %lu)",
+			     dir->i_ino);
+		err = -EPERM;
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(__fscrypt_file_open);
+
 /**
  * fscrypt_file_open() - prepare to open a possibly-encrypted regular file
  * @inode: the inode being opened
@@ -32,18 +64,10 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
 	int err;
 	struct dentry *dir;
 
-	err = fscrypt_require_key(inode);
-	if (err)
-		return err;
-
 	dir = dget_parent(file_dentry(filp));
-	if (IS_ENCRYPTED(d_inode(dir)) &&
-	    !fscrypt_has_permitted_context(d_inode(dir), inode)) {
-		fscrypt_warn(inode,
-			     "Inconsistent encryption context (parent directory: %lu)",
-			     d_inode(dir)->i_ino);
-		err = -EPERM;
-	}
+
+	err = __fscrypt_file_open(d_inode(dir), inode);
+
 	dput(dir);
 	return err;
 }
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4b3916d76dc7..22211f87e7be 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -393,6 +393,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
+int __fscrypt_file_open(struct inode *dir, struct inode *inode);
 int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 			   struct dentry *dentry);
 int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -737,6 +738,13 @@ static inline int fscrypt_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static inline int __fscrypt_file_open(struct inode *dir, struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static inline int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 					 struct dentry *dentry)
 {
-- 
2.43.0


