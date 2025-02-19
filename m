Return-Path: <linux-btrfs+bounces-11577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC4A3BD46
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC516E66F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADF1EA7E4;
	Wed, 19 Feb 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi2MoZQB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED01DED70
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965423; cv=none; b=dxMwB9Y4Y1mgTScsYveHpZv7FLfbSGnG6Xn8+Gd+LhRbK2H5KtPafI5Vcis8G2T1CocZ6WmlPcre8r4FuL5IBGthM3GFI1QFmmSKM23SEKqL3kS85U1fGJ75dDbGujIrU52OCyh34tsrGzziXTzsyDtG0IA+LvorTBLTIr0rJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965423; c=relaxed/simple;
	bh=GSRyDQepQ8nNM+59vyTKZf4Kiuw+8c2fQg4jvtw63aI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJwByqbwp0Cj9O9QosuQOQVayr6/o5Iy8eAkJ7THyaLbLxeu1DLCzvryZUASx2SNagl+ceP+EkydR8mMupSyiJwU+NG5XA/dquevV1cY25NXitsB0U55BZ3/PFVaaNedsQ/DcjpZjhYcByBsVVGf+GtT2hksemdIr9sHFDWJAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi2MoZQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12680C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965422;
	bh=GSRyDQepQ8nNM+59vyTKZf4Kiuw+8c2fQg4jvtw63aI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xi2MoZQBT20UWDBRxfM6S5BzBkPxeCfwLjZSFtJRA0e1kOeA2QCPdQirAvxiVyhgb
	 ifOZHxXt3l1HWR1JQ+AOSMTntNv9jSHunqi6hgqtbrI2121+UYmV2LQV2R5PhS46tc
	 px2DejLB4MlUck0ab520AM7GSZROem14AnRHMOElrHBdhVnOARbPfIgxVYirmrUate
	 oVN+s5NNO8yF0OJI5KTvJPV1tUeCo4DoRjNklRQI407YWJllNFmOtevVpCftLgQlxR
	 Zw6pc73pr8hx8QuxswadpLx0svhpcH6jvvwZaaqGzqrwWsXV3Wrglz+UwEmpYuZ3kS
	 V/bprNwEXu4/A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/26] btrfs: send: factor out common logic when sending xattrs
Date: Wed, 19 Feb 2025 11:43:12 +0000
Message-Id: <eef4b7ad9fede02efb9633b5acc720697cef5016.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We always send xattrs for the current inode only and both callers of
send_set_xattr() pass a path for the current inode. So move the path
allocation and computation to send_set_xattr(), reducing duplicated
code. This also facilitates an upcoming patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e0e24ac94aac..3aa2877f8c80 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4844,11 +4844,19 @@ static int process_all_refs(struct send_ctx *sctx,
 }
 
 static int send_set_xattr(struct send_ctx *sctx,
-			  struct fs_path *path,
 			  const char *name, int name_len,
 			  const char *data, int data_len)
 {
-	int ret = 0;
+	struct fs_path *path;
+	int ret;
+
+	path = fs_path_alloc();
+	if (!path)
+		return -ENOMEM;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, path);
+	if (ret < 0)
+		goto out;
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
@@ -4862,6 +4870,8 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
+	fs_path_free(path);
+
 	return ret;
 }
 
@@ -4889,19 +4899,13 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 			       const char *name, int name_len, const char *data,
 			       int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
-	struct fs_path *p;
 	struct posix_acl_xattr_header dummy_acl;
 
 	/* Capabilities are emitted by finish_inode_if_needed */
 	if (!strncmp(name, XATTR_NAME_CAPS, name_len))
 		return 0;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	/*
 	 * This hack is needed because empty acls are stored as zero byte
 	 * data in xattrs. Problem with that is, that receiving these zero byte
@@ -4918,15 +4922,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 		}
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_set_xattr(sctx, p, name, name_len, data, data_len);
-
-out:
-	fs_path_free(p);
-	return ret;
+	return send_set_xattr(sctx, name, name_len, data, data_len);
 }
 
 static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
@@ -5803,7 +5799,6 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct fs_path *fspath = NULL;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
@@ -5829,25 +5824,19 @@ static int send_capabilities(struct send_ctx *sctx)
 	leaf = path->nodes[0];
 	buf_len = btrfs_dir_data_len(leaf, di);
 
-	fspath = fs_path_alloc();
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!fspath || !buf) {
+	if (!buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	data_ptr = (unsigned long)(di + 1) + btrfs_dir_name_len(leaf, di);
 	read_extent_buffer(leaf, buf, data_ptr, buf_len);
 
-	ret = send_set_xattr(sctx, fspath, XATTR_NAME_CAPS,
+	ret = send_set_xattr(sctx, XATTR_NAME_CAPS,
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	fs_path_free(fspath);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.45.2


