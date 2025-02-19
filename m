Return-Path: <linux-btrfs+bounces-11590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD876A3BD58
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C92189C0D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3A1EEA2A;
	Wed, 19 Feb 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWW9fytB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603E1E0E14
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965436; cv=none; b=Wrn5AHitptICjpishCy0D8YqigoeTAeAULbJX8ifcrcOE3a4i/qVl3XlCe6ZRJ24Wqhp/4EuZ7PFUpoXXpYSqPB5mO3YPbN/lQRbnPfFHov6685h3OBFPvX/YDPKbVfDOoAYfhS5iqUtivm6zDgqUpG8LcGrMo/SjbOJEm57moQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965436; c=relaxed/simple;
	bh=qZLXRMol7cKJAATfbXYqjE89kDD+9HX1zG+TvSu0SSA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/eZCqpm1gZ4LUW7hRRBej1auWqtQw2E6T0fCzOwTznVBHPVo8r27EFdYy2aH0eRbV6Tx2DmD2iiy8LwWRlTBkYFGUVRhVc+2z3zM4ELZaZ7pZjYukHREDkOtLkIcv4h+Sy4CFmDJEqPA8oQmlk0r9mFbI3dASbCWEIiWRxvb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWW9fytB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F30C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965435;
	bh=qZLXRMol7cKJAATfbXYqjE89kDD+9HX1zG+TvSu0SSA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jWW9fytB3Z5SQZn94Q8MqNiTU9DImevH+yOn0Q+QYJpnjHzFtAli5fAunbkiYdaM5
	 8DBHP4/snaTN7RcdpumjimsfOwU41TKHklB4HbLAiocBqM7ERwTEh81G8SFZfFuqHr
	 h0lLuLBaP0EaRY+ZhOLBCHNUqZ8xRqs1LlCFo4G/aVHww6GID3eXlDAnihVKP//hRN
	 KKx5KaNmaFsxRfFP+d7MZCs9UN0d5H3Bp76HMe/MP6IBtoJHJ1GJOLDGS7BJFlMnnh
	 7z5++IuvsmdVUWsZRHRirRxLUqX2aAStD2Qr61mrcXdSnOPPQoMhZEjSEpFfLB6GeL
	 GbXd4zuwoFUFg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 25/26] btrfs: send: avoid path allocation for the current inode when issuing commands
Date: Wed, 19 Feb 2025 11:43:25 +0000
Message-Id: <f773dff4d45059b4f1f16ad261fa570f65817831.1739965104.git.fdmanana@suse.com>
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

Whenever we issue a command we allocate a path and then compute it. For
the current inode this is not necessary since we have one preallocated
and computed in the send context structure, so we can use it instead
and avoid allocating and freeing a path.

For example if we have 100 extents to send (100 write commands) for a
file, we are allocating and freeing paths 100 times.

So improve on this by avoiding path allocation and freeing whenever a
command is for the current inode by using the current inode's path
stored in the send context structure.

A test was run before applying this patch and the previous one in the
series:

  "btrfs: send: keep the current inode's path cached"

The test script is the following:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0

  mkfs.btrfs -f $DEV > /dev/null
  mount $DEV $MNT

  DIR="$MNT/one/two/three/four"
  FILE="$DIR/foobar"

  mkdir -p $DIR

  # Create some empty files to get a deeper btree and therefore make
  # path computations slower.
  for ((i = 1; i <= 30000; i++)); do
      echo -n > "$DIR/filler_$i"
  done

  for ((i = 0; i < 10000; i += 2)); do
     offset=$(( i * 4096 ))
     xfs_io -f -c "pwrite -S 0xab $offset 4K" $FILE > /dev/null
  done

  btrfs subvolume snapshot -r $MNT $MNT/snap

  start=$(date +%s%N)
  btrfs send -f /dev/null $MNT/snap
  end=$(date +%s%N)

  echo -e "\nsend took $(( (end - start) / 1000000 )) milliseconds"

  umount $MNT

Result before applying the 2 patches:  1121 milliseconds
Result after applying the 2 patches:    815 milliseconds  (-31.6%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 215 ++++++++++++++++++++++--------------------------
 1 file changed, 97 insertions(+), 118 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0d0f073a9945..77cedde3b57b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2592,6 +2592,47 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	return ret;
 }
 
+static struct fs_path *get_cur_inode_path(struct send_ctx *sctx)
+{
+	if (fs_path_len(&sctx->cur_inode_path) == 0) {
+		int ret;
+
+		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
+				   &sctx->cur_inode_path);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	return &sctx->cur_inode_path;
+}
+
+static struct fs_path *get_path_for_command(struct send_ctx *sctx, u64 ino, u64 gen)
+{
+	struct fs_path *path;
+	int ret;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		return get_cur_inode_path(sctx);
+
+	path = fs_path_alloc();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	ret = get_cur_path(sctx, ino, gen, path);
+	if (ret < 0) {
+		fs_path_free(path);
+		return ERR_PTR(ret);
+	}
+
+	return path;
+}
+
+static void free_path_for_command(const struct send_ctx *sctx, struct fs_path *path)
+{
+	if (path != &sctx->cur_inode_path)
+		fs_path_free(path);
+}
+
 static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 {
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
@@ -2600,17 +2641,14 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 	btrfs_debug(fs_info, "send_truncate %llu size=%llu", ino, size);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_TRUNCATE);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, size);
 
@@ -2618,7 +2656,7 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2630,17 +2668,14 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 	btrfs_debug(fs_info, "send_chmod %llu mode=%llu", ino, mode);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHMOD);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_MODE, mode & 07777);
 
@@ -2648,7 +2683,7 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2663,17 +2698,14 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_FILEATTR);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILEATTR, fileattr);
 
@@ -2681,7 +2713,7 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2694,17 +2726,14 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 	btrfs_debug(fs_info, "send_chown %llu uid=%llu, gid=%llu",
 		    ino, uid, gid);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHOWN);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UID, uid);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_GID, gid);
@@ -2713,7 +2742,7 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2730,9 +2759,9 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	path = alloc_path_for_send();
 	if (!path) {
@@ -2757,9 +2786,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
@@ -2771,7 +2797,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -4889,13 +4915,9 @@ static int send_set_xattr(struct send_ctx *sctx,
 	struct fs_path *path;
 	int ret;
 
-	path = fs_path_alloc();
-	if (!path)
-		return -ENOMEM;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, path);
-	if (ret < 0)
-		goto out;
+	path = get_cur_inode_path(sctx);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
@@ -4909,8 +4931,6 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(path);
-
 	return ret;
 }
 
@@ -4967,23 +4987,14 @@ static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
 				   const char *name, int name_len,
 				   const char *data, int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_remove_xattr(sctx, p, name, name_len);
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-out:
-	fs_path_free(p);
-	return ret;
+	return send_remove_xattr(sctx, p, name, name_len);
 }
 
 static int process_new_xattr(struct send_ctx *sctx)
@@ -5209,21 +5220,13 @@ static int process_verity(struct send_ctx *sctx)
 	if (ret < 0)
 		goto iput;
 
-	p = fs_path_alloc();
-	if (!p) {
-		ret = -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p)) {
+		ret = PTR_ERR(p);
 		goto iput;
 	}
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto free_path;
 
 	ret = send_verity(sctx, p, sctx->verity_descriptor);
-	if (ret < 0)
-		goto free_path;
-
-free_path:
-	fs_path_free(p);
 iput:
 	iput(inode);
 	return ret;
@@ -5345,31 +5348,25 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
 
-	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
-	if (ret < 0)
-		goto out;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	ret = put_file_data(sctx, offset, len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5382,6 +5379,7 @@ static int send_clone(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct fs_path *p;
+	struct fs_path *cur_inode_path;
 	u64 gen;
 
 	btrfs_debug(sctx->send_root->fs_info,
@@ -5389,6 +5387,10 @@ static int send_clone(struct send_ctx *sctx,
 		    offset, len, btrfs_root_id(clone_root->root),
 		    clone_root->ino, clone_root->offset);
 
+	cur_inode_path = get_cur_inode_path(sctx);
+	if (IS_ERR(cur_inode_path))
+		return PTR_ERR(cur_inode_path);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5397,13 +5399,9 @@ static int send_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_LEN, len);
-	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, cur_inode_path);
 
 	if (clone_root->root == sctx->send_root) {
 		ret = get_inode_gen(sctx->send_root, clone_root->ino, &gen);
@@ -5454,17 +5452,13 @@ static int send_update_extent(struct send_ctx *sctx,
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UPDATE_EXTENT);
 	if (ret < 0)
-		goto out;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
@@ -5473,8 +5467,6 @@ static int send_update_extent(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5503,12 +5495,10 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, end - offset);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto tlv_put_failure;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
 	while (offset < end) {
 		u64 len = min(end - offset, read_size);
 
@@ -5529,7 +5519,6 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	}
 	sctx->cur_inode_next_write_offset = offset;
 tlv_put_failure:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5552,9 +5541,9 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5562,10 +5551,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
@@ -5594,7 +5579,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5619,9 +5603,9 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5629,10 +5613,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
@@ -5700,7 +5680,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
-- 
2.45.2


