Return-Path: <linux-btrfs+bounces-12061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF3A553B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68033B55EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6926AA99;
	Thu,  6 Mar 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBGFIDLk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231C26A1BE
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283763; cv=none; b=qxaKzvTMJ/SFDrjRDKSe0m8TDepZZllXKLQzeu6oFUFfZD06ony0DLl6eU7iJg8q5KLof1TDMvE81BJPprgzT1fwabaYhN6f25tDlCz9HqwGizjCi/H6MDR3+rgCmr6V+TFr9bJk1zYDAxLeD4FuZ1S3z3D7W+IQZzXwf276on0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283763; c=relaxed/simple;
	bh=mtjN1JVjvQuafxMFfIGM8MGXz+2owKhsFy3n4P6zDL8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxq3jCt1S2A1T7ozKvarYES/jV9ExwO284XSS/pNOmQljJ7bZON97e0PqVZ1Zy9HGH9st/BO4AOtw4sDuuKaWjJxlgF/hubJN66VpIcYFU63FOkZ/eUNO07YynCdD+49lpM5Feg/0Up+3KP6pVGKqyZ1Nh8wi8aZAqmDAuO8pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBGFIDLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC39C4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283763;
	bh=mtjN1JVjvQuafxMFfIGM8MGXz+2owKhsFy3n4P6zDL8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XBGFIDLkYCgk1u2I+qxqVu6ktnThsZJ9Ffe6Kka4qwmHeiZIjWiWl9Nb8ov81M9rE
	 eeNzRld3gZdANC0VxbklNI6lZD4iioooYgqlhBnJ3/8Obi+jZLnLyLrHtHixaGo3jd
	 tBSmvttRrLJMBtXIhYHwv5wl27b1bV98IUkvAz0x2m8/xAciO7vb3LeEIAi1jkKL3p
	 BPUvnq/FW1XS+nVfoChfNQnT2B0xbsw1oOX7mRKjDKqs72vvYIMOUzUem8vwSrBphg
	 HQrR9vWaxhOleRpdCzjVRqC+aDk5mFtqpusX0kJ6LXccCN2ZlRcZNMsO971YM64SCL
	 3NBOosfURCw1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: send: simplify return logic from send_encoded_extent()
Date: Thu,  6 Mar 2025 17:55:54 +0000
Message-Id: <a708738482f9f68dc80ff967bd6910fc645d018a.1741283556.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741283556.git.fdmanana@suse.com>
References: <cover.1741283556.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The 'out' label is pointless as we don't have anything to cleanup anymore
(we used to have an inode to iput), so remove it and make error paths
directly return an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 41e913e01d49..31f9122eaac9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5532,14 +5532,12 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	int ret;
 
 	fspath = get_cur_inode_path(sctx);
-	if (IS_ERR(fspath)) {
-		ret = PTR_ERR(fspath);
-		goto out;
-	}
+	if (IS_ERR(fspath))
+		return PTR_ERR(fspath);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
@@ -5555,12 +5553,12 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	ret = btrfs_encoded_io_compression_from_extent(fs_info,
 				btrfs_file_extent_compression(leaf, ei));
 	if (ret < 0)
-		goto out;
+		return ret;
 	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
 
 	ret = put_data_header(sctx, inline_size);
 	if (ret < 0)
-		goto out;
+		return ret;
 	read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
 			   btrfs_file_extent_inline_start(ei), inline_size);
 	sctx->send_size += inline_size;
@@ -5568,7 +5566,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


