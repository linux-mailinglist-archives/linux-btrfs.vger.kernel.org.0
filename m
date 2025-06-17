Return-Path: <linux-btrfs+bounces-14743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7FADD5DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08CE4027E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7C2ED854;
	Tue, 17 Jun 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbH1Cbev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BE2F743E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176806; cv=none; b=bLYpSr1f3HYaZwzQbsO/ww3A1s3lVwU6FdC0DHQ9JtaFPpu5oZ8EY0LBztmJ7pCv4SqKR5IMylAeu0qL3co5pvm6yK6wDzn5C8p0YZxePbTOFYtr5x0gqXTctzMls7v5N39kUd8s7p++qKyPoRadNoBW+xlpvfEPQHvR7TwGS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176806; c=relaxed/simple;
	bh=pJv1Cadqjm+y+IQD3PTNdNSC10gLNBYHfUjPRIAY5WQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNkZyw+DReu5MqT7sH4spQM53B7gyTOfndOd6b3ZwojCsZQ6u+a9yiklthpZXay7sQwee9fYaujmxl9r5kNxU73FabBW3DyWFh7FnMmsNZOQB2OFYn4mwyqpJglfdhDY1bKSBptvA8sU3vdmQpflc4ZDwv7oyxlnvIqf/FdVHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbH1Cbev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53522C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176805;
	bh=pJv1Cadqjm+y+IQD3PTNdNSC10gLNBYHfUjPRIAY5WQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CbH1CbevcPLw/nTtZ8VOexdW0jwbvhuPTYwHw+KGf3H6nXJ7cl6dcIorX2TORoAMy
	 BNn22dxVnoUoRh3hkSwFF4n5Pt4qK7fqr5MDc0i8G+8UKHzNWKAr5955tP7zoeQnM/
	 dwDzijZ8pTlxAh+PZK5yI9NxkRZsvreNKL45vBNp4TTTf/LSi1I1pdhxXKeXatgSVt
	 VXQKB/HAm3bUXy0KVjUWQV00bVAnZtjIGPzRf+Mj8Tgf8KaanYNhBMF3Ukhkxw7P1m
	 4tqiY5893/QQweYBi064MAdWXpu+xIDINylrVFtL1DdO5diTQYg8m2nLdYRo+OL5JY
	 LjqXIIR6rP5vA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: use fs_info from local variable in btrfs_convert_free_space_to_extents()
Date: Tue, 17 Jun 2025 17:13:09 +0100
Message-ID: <d8743bfdd9937148982fd888b4d0dc446d1a2edd.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to dereference the block group to extract fs_info as we
have already stored fs_info in a local variable. So use the local variable
instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index d5766e25f5dc..c85ca7ce2683 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -438,16 +438,16 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
 	btrfs_release_path(path);
 
-	nrbits = block_group->length >> block_group->fs_info->sectorsize_bits;
+	nrbits = block_group->length >> fs_info->sectorsize_bits;
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
 		end_bit = find_next_zero_bit_le(bitmap, nrbits, start_bit);
 		ASSERT(start_bit < end_bit);
 
-		key.objectid = start + start_bit * block_group->fs_info->sectorsize;
+		key.objectid = start + start_bit * fs_info->sectorsize;
 		key.type = BTRFS_FREE_SPACE_EXTENT_KEY;
-		key.offset = (end_bit - start_bit) * block_group->fs_info->sectorsize;
+		key.offset = (end_bit - start_bit) * fs_info->sectorsize;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret) {
-- 
2.47.2


