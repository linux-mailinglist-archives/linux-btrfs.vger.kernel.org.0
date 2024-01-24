Return-Path: <linux-btrfs+bounces-1728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4283B015
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F728B2DDF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2987129A83;
	Wed, 24 Jan 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qq+Mdwiq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5270129A70
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116809; cv=none; b=fLncLDhYxUk/17AvhkRmD2iEEOIAyrq+4jx7cseFnDJNBcNb318197odXBM3KA9fAbKRa4cIcnI8bMFmgEkxnIYeqP+5f75X80hP4AAB7kk0tAjtV6YgmuxE3jMAggx8zlUvAblYteSO75VO+eZ0olQRL6UXtNTJs3+LbFw3kYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116809; c=relaxed/simple;
	bh=kzmOd9qyz7M2etU/KVmWeC7D+NI/SjPjhbFCjZ+6xyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upKlNA772Cm6yvJtsxRrxwwi18SA00atHbD3XweBpQyvJqkHzREp0gOyyCm3h3zYe6FELZWfl+SrlO7LccI4Va+xqmXtWjk1ydA11W76fhOUPoYEu/mbTayVe9ciRGRmUAXA+sS3P96IwOkwZCkRa2CLreooE1WLX92EccCVTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qq+Mdwiq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc371b04559so2138673276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116806; x=1706721606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrViysrUVeEpvnxyPZhhVVPp6sfxzEf76UzZnKax2mI=;
        b=qq+MdwiqUjObx8sT5NhydMc2RbKQcmEbQKT64Pdw5RpDvJN76ZSScVKJK/fySS1V2s
         DrEYjm8tOM8GtyslMhAHqMmXF4NhOqMYIKvDBsqPG8i9Vn6WQKZUDh47cMb5p3OFpTv2
         ovqaSHYfTdVOh6VulpnLzfQFUcaJnKRPrfvYbeAE47Mm5Q5xa5PldlVYiJd3Yslit9id
         WuWkFGxSwcZ3YFylc4V+4Vwvx0B1I0P+JKfaz4sZzqWbAG53Iu2VgnTbtaPRqn3pCgdZ
         oc2EGdD2UqCwNA6TOmCeD9iL00KnIb+pwGUncyMbqx+09+hPNNlC+nCqt7Y+0a44B91c
         8Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116806; x=1706721606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrViysrUVeEpvnxyPZhhVVPp6sfxzEf76UzZnKax2mI=;
        b=gqp7HNsIOluTOl8zNmXWCF/3ZozeuoNJSHccJf9DnCYD3OvuXqWnap4xDnJjrpwi2E
         /8AIbkz9vuOmrdq9HJZy7ibM8cQLmIBsfITgjMMX+XhRIB/qFqB9NfnkDYfrYVW46tXT
         FlKwkCh1PKjPue6qNFQFOgduCqBiNp6D7syVAMMiw6IX+ep3j8Gd+kyv59J31ZC+vXVi
         FsB4tdBHqNGdVoPy23UfGGcEzMxVAJH37sH1aj4MvWZiwU7zRqQ0K/nHgmgjY2MvsNti
         /WVLD2ZjApKAasOqswBs5xdqosirRjteMc6w+YOUtC7DzMlDabu8dbyAzjRqHpWjEfVs
         rrOw==
X-Gm-Message-State: AOJu0YxPo/pc9Q1mySQGq4B/oWdYxLKz0GF9SJkWbhBA7kLI/bJt1Dep
	BluK8QdjX65BwDMZ3/qQp0J2vJg2sKxrBqhQ4pJa4LOC2txX5PdjFKawihZpLSxG0A3aVAa1X24
	x
X-Google-Smtp-Source: AGHT+IG4w5TZVU0JwYrvt9/UVIwDpe4yRSbQQ0sjbe7NXg/fPu2VI1SL4lOuPjKs3uaA6BK2OMLycw==
X-Received: by 2002:a05:6902:348:b0:dbd:be40:2191 with SMTP id e8-20020a056902034800b00dbdbe402191mr894755ybs.42.1706116806623;
        Wed, 24 Jan 2024 09:20:06 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m187-20020a2526c4000000b00dc2324b3cddsm2950153ybm.37.2024.01.24.09.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 46/52] btrfs: decrypt file names for send
Date: Wed, 24 Jan 2024 12:19:08 -0500
Message-ID: <fd8b1d5f395a890dbdf8281a52fbaaa920c7b726.1706116485.git.josef@toxicpanda.com>
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

In send we're going to be looking up file names from back references and
putting them into the send stream.  If we are encrypted use the helper
for decrypting names and copy the decrypted name into the buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 51 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 747d7d192b19..f4680f72e148 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -33,6 +33,7 @@
 #include "ioctl.h"
 #include "verity.h"
 #include "lru_cache.h"
+#include "fscrypt.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
@@ -585,13 +586,42 @@ static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
 	return ret;
 }
 
-static int fs_path_add_from_extent_buffer(struct fs_path *p,
+static int fs_path_add_from_encrypted(struct btrfs_root *root,
+				      struct fs_path *p,
+				      struct extent_buffer *eb,
+				      unsigned long off, int len,
+				      u64 parent_ino)
+{
+	struct fscrypt_str fname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
+	if (ret)
+		return ret;
+
+	ret = btrfs_decrypt_name(root, eb, off, len, parent_ino, &fname);
+	if (ret)
+		goto out;
+
+	ret = fs_path_add(p, fname.name, fname.len);
+out:
+	fscrypt_fname_free_buffer(&fname);
+	return ret;
+}
+
+static int fs_path_add_from_extent_buffer(struct btrfs_root *root,
+					  struct fs_path *p,
 					  struct extent_buffer *eb,
-					  unsigned long off, int len)
+					  unsigned long off, int len,
+					  u64 parent_ino)
 {
 	int ret;
 	char *prepared;
 
+	if (root && btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return fs_path_add_from_encrypted(root, p, eb, off, len,
+						  parent_ino);
+
 	ret = fs_path_prepare_for_add(p, len, &prepared);
 	if (ret < 0)
 		goto out;
@@ -1074,8 +1104,8 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 			}
 			p->start = start;
 		} else {
-			ret = fs_path_add_from_extent_buffer(p, eb, name_off,
-							     name_len);
+			ret = fs_path_add_from_extent_buffer(root, p, eb, name_off,
+							     name_len, dir);
 			if (ret < 0)
 				goto out;
 		}
@@ -1792,7 +1822,7 @@ static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino,
 	off = btrfs_file_extent_inline_start(ei);
 	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
 
-	ret = fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
+	ret = fs_path_add_from_extent_buffer(NULL, dest, path->nodes[0], off, len, 0);
 
 out:
 	btrfs_free_path(path);
@@ -2090,18 +2120,19 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 		iref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_inode_ref);
 		len = btrfs_inode_ref_name_len(path->nodes[0], iref);
-		ret = fs_path_add_from_extent_buffer(name, path->nodes[0],
-						     (unsigned long)(iref + 1),
-						     len);
 		parent_dir = found_key.offset;
+		ret = fs_path_add_from_extent_buffer(root, name, path->nodes[0],
+						     (unsigned long)(iref + 1),
+						     len, parent_dir);
 	} else {
 		struct btrfs_inode_extref *extref;
 		extref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 					struct btrfs_inode_extref);
 		len = btrfs_inode_extref_name_len(path->nodes[0], extref);
-		ret = fs_path_add_from_extent_buffer(name, path->nodes[0],
-					(unsigned long)&extref->name, len);
 		parent_dir = btrfs_inode_extref_parent(path->nodes[0], extref);
+		ret = fs_path_add_from_extent_buffer(root, name, path->nodes[0],
+					(unsigned long)&extref->name, len,
+					parent_dir);
 	}
 	if (ret < 0)
 		goto out;
-- 
2.43.0


