Return-Path: <linux-btrfs+bounces-18271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD852C058D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EDB1AA04FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2030FC17;
	Fri, 24 Oct 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="flhPnHJW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8B30F808;
	Fri, 24 Oct 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301353; cv=none; b=t96nKTf5l3cfA4OTQFvB5331HjubkvB9nLDLCpr/GAU2Qdi3tA5SPKEKRGEadhKNYp5d2Vn8ayr8WLB2PJ/7DxnFIrC4LrqKu6LbOU7Yf9KLzHzaPV/zoLTx7ruatW+z3v9oLm+WeGVhgTnZb1Xm+MDndWQNUZ9rl1cfGTD72qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301353; c=relaxed/simple;
	bh=c71nAgtZEwYwr/Xb1hy8wiAuRLeKp2bV0BRppPPjFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyAgrLjgplLzXq+BuREVhgYI1s7p05wYLkul0ceAmmNyne6q7xLL2PhD9UIJUE0xdsCNgeAStgh0Eb8tFeZ7z79ibZhfD1WR/hDNXsYhlfc6kScijZSy2z+ISRC+2DlpebY7EUMMyu2uj4OvjYmLVibtlC4KNcDl/J53NvdAnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=flhPnHJW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ctJqj6G9Hz9tlw;
	Fri, 24 Oct 2025 12:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761301345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkO8Z9YMpnZxb4tpF0jgCNPp6scHTvIUwxqCdezCx+E=;
	b=flhPnHJWSYYi8sU5Nr1rQKl2Mb0oO5pyNAv+Q4zlacP4iYK+36BLwuaDXn+XgGBDjgcBsK
	gp4UppmNnFh9XXshK63taY8QKp90XnP9BcGA8q7ONTlL/4hEOsXX9UxEW0jrTxfqVKskte
	aH2+EIAE/RX3HhHFBjTGnRfhxJEurXzVKuxShX/1JMhv0EBHvQfBGbycX3iCBEWQS2qGQX
	caJjdggze97efmqiCiy44Tx6gYgd0lMgvjn/3TgTJ6y3JYWbg1XOflV3Gh5yVWo3wjqtKw
	J6D7/qZAZ6sawBeSWCfV3taxraEIiTpf4gaiF/0HgHHZzrtwx/ibQU/xdrbj6w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 1/4] btrfs: declare free_ipath() via DEFINE_FREE()
Date: Fri, 24 Oct 2025 12:21:40 +0200
Message-ID: <20251024102143.236665-2-mssola@mssola.com>
In-Reply-To: <20251024102143.236665-1-mssola@mssola.com>
References: <20251024102143.236665-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ctJqj6G9Hz9tlw

The free_ipath() function was being used as a cleanup function
everywhere. Declare it via DEFINE_FREE() so we can use this function
with the __free() helper.

The name has also been adjusted so it's closer to the type's name.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/backref.c | 10 +---------
 fs/btrfs/backref.h |  7 ++++++-
 fs/btrfs/inode.c   |  4 +---
 fs/btrfs/ioctl.c   |  3 +--
 fs/btrfs/scrub.c   |  4 +---
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e050d0938dc4..eff2d388a706 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2785,7 +2785,7 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
  * allocates space to return multiple file system paths for an inode.
  * total_bytes to allocate are passed, note that space usable for actual path
  * information will be total_bytes - sizeof(struct inode_fs_paths).
- * the returned pointer must be freed with free_ipath() in the end.
+ * the returned pointer must be freed with __free_inode_fs_paths() in the end.
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
index 25d51c246070..1d009b0f4c69 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -241,7 +241,12 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 struct btrfs_data_container *init_data_container(u32 total_bytes);
 struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *fs_root,
 					struct btrfs_path *path);
-void free_ipath(struct inode_fs_paths *ipath);
+
+DEFINE_FREE(inode_fs_paths, struct inode_fs_paths *,
+	if (_T) {
+		kvfree(_T->fspath);
+		kfree(_T);
+	})
 
 int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 start_off, struct btrfs_path *path,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79732756b87f..b9116a40ee9c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -130,7 +130,7 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	struct btrfs_fs_info *fs_info = warn->fs_info;
 	struct extent_buffer *eb;
 	struct btrfs_inode_item *inode_item;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(inode_fs_paths) = NULL;
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
index 692016b2b600..a65b67dab055 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3298,7 +3298,7 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 	u64 rel_ptr;
 	int size;
 	struct btrfs_ioctl_ino_path_args *ipa = NULL;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(inode_fs_paths) = NULL;
 	struct btrfs_path *path;
 
 	if (!capable(CAP_DAC_READ_SEARCH))
@@ -3346,7 +3346,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 
 out:
 	btrfs_free_path(path);
-	free_ipath(ipath);
 	kfree(ipa);
 
 	return ret;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e..317858844413 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -505,7 +505,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	struct btrfs_inode_item *inode_item;
 	struct scrub_warning *swarn = warn_ctx;
 	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
-	struct inode_fs_paths *ipath = NULL;
+	struct inode_fs_paths *ipath __free(inode_fs_paths) = NULL;
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


