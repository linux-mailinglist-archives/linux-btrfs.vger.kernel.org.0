Return-Path: <linux-btrfs+bounces-11664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40EA3D7CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BAD19C10D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379621F55F2;
	Thu, 20 Feb 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADQ0cG++"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1171F5438
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049517; cv=none; b=tsPCX0Y4kOdvAu9ylmLNWor3R2z5xYHY/F8AHBU9TcbHkdpJvb5fT3BnuCMSf11GTSLdg92E6VJZ3Q9aM0VBJ8P7dxRm1wQBAgahWQgVD7n+QzuH27x5HbboKJugax+2kU/SjeRAg9r4NKGEUUi3GZsndu4sMHwz/951oHEzN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049517; c=relaxed/simple;
	bh=UiMze5NXCd0hBLLOT5ruU/CXc4k2KLMweo+TBBh1rrc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATX5BbQiHrDFUVS5u/v7Xq1KPydXqz8u4tQNQB1AkYOiFz24EgAbkTiUWDTUS3isU6xylOpnoUn8DLcEMV0nv59pNhLH29OYOQ+J6QGt7yYmh5WgVE5bZ/NJt0Pm5o6IlwTZEjhr00kCfrckOaOrGZoZPZyo244knXHvcJegWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADQ0cG++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F6EC4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049517;
	bh=UiMze5NXCd0hBLLOT5ruU/CXc4k2KLMweo+TBBh1rrc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ADQ0cG++wHuvyaOidD82AdIyi1LsA6pFT5JUMDsC2bOvnWHny/My9MowUU14okQ8/
	 n0Ru5vEWbKKXH3HwqN6057QRUpU302nr9ux5zNyhiWn/z1kt5dKcYZJXKOKpBISHTO
	 faTHzeB9V9gCja3OokNFfv45BSbQ4m57kV818lMgquBoQimHWaqfX3kfCs48pgo0rQ
	 wAdDMVWDLqWPAH6gsRMYDMh4N63nBlgd3ZIBv1xrgFlIj6HA4B76+7FYmpc/+eoM6m
	 69PJjApz1JPdV8XvnT8qP4tRCYO6tfqdZY9N4gCa+yHK3kZ1cA8vbUEKdkuDxyn1BP
	 1piWLxfck51mg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 29/30] btrfs: send: avoid path allocation for the current inode when issuing commands
Date: Thu, 20 Feb 2025 11:04:42 +0000
Message-Id: <ee6096bb782502c2587d4b14d6bd412bc45e2b02.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
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
index e811c9237e9e..2c1259068b76 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2588,6 +2588,47 @@ static int send_subvol_begin(struct send_ctx *sctx)
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
@@ -2596,17 +2637,14 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
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
 
@@ -2614,7 +2652,7 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2626,17 +2664,14 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
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
 
@@ -2644,7 +2679,7 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2659,17 +2694,14 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
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
 
@@ -2677,7 +2709,7 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2690,17 +2722,14 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
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
@@ -2709,7 +2738,7 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2726,9 +2755,9 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	path = alloc_path_for_send();
 	if (!path) {
@@ -2753,9 +2782,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
@@ -2767,7 +2793,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -4885,13 +4911,9 @@ static int send_set_xattr(struct send_ctx *sctx,
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
@@ -4905,8 +4927,6 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(path);
-
 	return ret;
 }
 
@@ -4963,23 +4983,14 @@ static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
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
@@ -5205,21 +5216,13 @@ static int process_verity(struct send_ctx *sctx)
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
@@ -5341,31 +5344,25 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
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
 
@@ -5378,6 +5375,7 @@ static int send_clone(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct fs_path *p;
+	struct fs_path *cur_inode_path;
 	u64 gen;
 
 	btrfs_debug(sctx->send_root->fs_info,
@@ -5385,6 +5383,10 @@ static int send_clone(struct send_ctx *sctx,
 		    offset, len, btrfs_root_id(clone_root->root),
 		    clone_root->ino, clone_root->offset);
 
+	cur_inode_path = get_cur_inode_path(sctx);
+	if (IS_ERR(cur_inode_path))
+		return PTR_ERR(cur_inode_path);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5393,13 +5395,9 @@ static int send_clone(struct send_ctx *sctx,
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
@@ -5450,17 +5448,13 @@ static int send_update_extent(struct send_ctx *sctx,
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
@@ -5469,8 +5463,6 @@ static int send_update_extent(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5499,12 +5491,10 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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
 
@@ -5525,7 +5515,6 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	}
 	sctx->cur_inode_next_write_offset = offset;
 tlv_put_failure:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5548,9 +5537,9 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
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
 
@@ -5558,10 +5547,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
@@ -5590,7 +5575,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5615,9 +5599,9 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
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
 
@@ -5625,10 +5609,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
@@ -5696,7 +5676,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
-- 
2.45.2


