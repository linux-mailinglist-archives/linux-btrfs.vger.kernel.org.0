Return-Path: <linux-btrfs+bounces-18114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA858BF714A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E24252F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D0339B5C;
	Tue, 21 Oct 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="wjOMsl4l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CB1EDA1E;
	Tue, 21 Oct 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056907; cv=none; b=g74if+gi3QwjrJWTFXvxxPhKrrPjj9kIqZVlqcxnW6tCfduNP4ESluIlZ/D3XU6Ok8xw5h/RClxwnfkdOweI2deUEkcBn9708PI++dUnWcxRmBHGPpeWYwYyYxfMSJHVFT+zLSHp2otQv80RpHdO8oW9ciu7CMKhIn8Fi+uoVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056907; c=relaxed/simple;
	bh=TVUUCnjng9lxzyy0qq+GzVmU/aLF6wLcZy0qlWhCrbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0qtob5HSmX3Xvu8THTyVsAoyfmuulGsKIoUQB0lDnMMk9z2qcTGApvzJqoaNCgc1Sb/3mCL9ZyZ17Jv/fe71063LfBWJ/WwENs8OeZSKcDmQHlSPcV6ezQ/2/5zSTT0uYAzaTZBtHz9W2uBR/RDqvvYXeHsYVcfrerlw6uaI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=wjOMsl4l; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4crZQp1ls0z9ttm;
	Tue, 21 Oct 2025 16:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761056898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uilBc+Gi0c4GQOo+svzYnBLdiIGJkGSGTPDGvTOpCSM=;
	b=wjOMsl4ly+IxaO7XsArq5z/P+9ALd6VFPof1tX0GTT82Q41UMTVLKTkcntS0JUa3CzNf4A
	bwj0crvRFFPxaMtjzJ8RpXf13ogZ3kR+IRdWcz1ea05vVYGPkYjtpA9iSqtS17NLyuHRsR
	3JYNDIhELaWFA8cunpSwJ0XWC3sr8PEXaFX7nMnU+tT+wR2QmMC20IrxnJyAubOX4SLP6D
	5MSDI0vxAbgvMxjcDrvPhjQg5F8NILYY6ptLfM0qJFrtQ+D6hvYDDtnaTACVjWbwyb2QuV
	lmCpLIcLlvE5j+okbI8ZdA0MBuFeVvf48P7ud5YzImFLxUH0BlSt+gPYnFHF3A==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	neal@gompa.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 1/4] btrfs: declare free_ipath() via DEFINE_FREE() instead
Date: Tue, 21 Oct 2025 16:27:46 +0200
Message-ID: <20251021142749.642956-2-mssola@mssola.com>
In-Reply-To: <20251021142749.642956-1-mssola@mssola.com>
References: <20251021142749.642956-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This transforms the signature to __free_ipath() instead of the original
free_ipath(), but this function was only being used as a cleanup
function anyways. Hence, define it as a helper and use it via the
__free() attribute on all uses. This change also means that
__free_ipath() will be inlined whereas that wasn't the case for the
original one, but this shouldn't be a problem.

A follow up macro like we do with BTRFS_PATH_AUTO_FREE() has been
discarded as the usage of this struct is not as widespread as that.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/backref.c | 10 +---------
 fs/btrfs/backref.h |  7 ++++++-
 fs/btrfs/inode.c   |  4 +---
 fs/btrfs/ioctl.c   |  3 +--
 fs/btrfs/scrub.c   |  4 +---
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e050d0938dc4..a1456402752a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2785,7 +2785,7 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
  * allocates space to return multiple file system paths for an inode.
  * total_bytes to allocate are passed, note that space usable for actual path
  * information will be total_bytes - sizeof(struct inode_fs_paths).
- * the returned pointer must be freed with free_ipath() in the end.
+ * the returned pointer must be freed with __free_ipath() in the end.
  */
 struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
 					struct btrfs_path *path)
@@ -2810,14 +2810,6 @@ struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
 	return ifp;
 }
 
-void free_ipath(struct inode_fs_paths *ipath)
-{
-	if (!ipath)
-		return;
-	kvfree(ipath->fspath);
-	kfree(ipath);
-}
-
 struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_backref_iter *ret;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 25d51c246070..d3b1ad281793 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -241,7 +241,12 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 struct btrfs_data_container *init_data_container(u32 total_bytes);
 struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
 					struct btrfs_path *path);
-void free_ipath(struct inode_fs_paths *ipath);
+
+DEFINE_FREE(ipath, struct inode_fs_paths *,
+	if (_T) {
+		kvfree(_T->fspath);
+		kfree(_T);
+	})
 
 int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 start_off, struct btrfs_path *path,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79732756b87f..4d154209d70b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -130,7 +130,7 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	struct btrfs_fs_info *fs_info = warn->fs_info;
 	struct extent_buffer *eb;
 	struct btrfs_inode_item *inode_item;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(ipath) = NULL;
 	struct btrfs_root *local_root;
 	struct btrfs_key key;
 	unsigned int nofs_flag;
@@ -193,7 +193,6 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	}
 
 	btrfs_put_root(local_root);
-	free_ipath(ipath);
 	return 0;
 
 err:
@@ -201,7 +200,6 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 "checksum error at logical %llu mirror %u root %llu inode %llu offset %llu, path resolving failed with ret=%d",
 		   warn->logical, warn->mirror_num, root, inum, offset, ret);
 
-	free_ipath(ipath);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 692016b2b600..453832ded917 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3298,7 +3298,7 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 	u64 rel_ptr;
 	int size;
 	struct btrfs_ioctl_ino_path_args *ipa = NULL;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(ipath) = NULL;
 	struct btrfs_path *path;
 
 	if (!capable(CAP_DAC_READ_SEARCH))
@@ -3346,7 +3346,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 
 out:
 	btrfs_free_path(path);
-	free_ipath(ipath);
 	kfree(ipa);
 
 	return ret;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e..74d8af1ff02d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -505,7 +505,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	struct btrfs_inode_item *inode_item;
 	struct scrub_warning *swarn = warn_ctx;
 	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(ipath) = NULL;
 	struct btrfs_root *local_root;
 	struct btrfs_key key;
 
@@ -569,7 +569,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
 	btrfs_put_root(local_root);
-	free_ipath(ipath);
 	return 0;
 
 err:
@@ -580,7 +579,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 			  swarn->physical,
 			  root, inum, offset, ret);
 
-	free_ipath(ipath);
 	return 0;
 }
 
-- 
2.51.1


