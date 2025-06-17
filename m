Return-Path: <linux-btrfs+bounces-14740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9810ADD5E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C2400DC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB22F7423;
	Tue, 17 Jun 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm2weEsb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102182F741D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176803; cv=none; b=iXXYIzqTJ5LVAnxfY4FQWMVARnYbMvQ1KqVy09cEwUkDjb7QlGHboTr8ci1GA0Q7Zg+aIIuoSWwwEbXzO2TxP7KO07Jp18QX7Oi+78h/cz35MV1lnxYIyxQO8O/FWvLcz50zr3VwPrLAElTg44F20bLRIEAPp+5Isg9veHZ+6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176803; c=relaxed/simple;
	bh=PFuO4i+Vrg64zzZFHynSIwuyILLksnqhEb7uxMGmvbI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgV4olneOHJV2nseivQLWOylOjbzSo6iQDu2oerMPP74M1zaJKeeJJPFAI0GM1PdctG91O5cbOy6BFcwlcibkKKUHQ9RO5sXk9W34YBM2XNXgM7To7MQ+WvDArKz1qXgoAXHmXG1PpqMx6affje5X7g2h8qw2IKPzmvqTtua8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm2weEsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4918DC4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176802;
	bh=PFuO4i+Vrg64zzZFHynSIwuyILLksnqhEb7uxMGmvbI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wm2weEsbHxJu4q3t/TIHSpy0vQvo5R++pIKcls7ETmc7cnJL+/eYclXy6ALtfhwfA
	 KjpB6ZCPTg9Qi0D3Nd8VOqqiyP5WP740rdJ4wFJbon17HcmVcWma4Lw9sKgWjoEzOp
	 LhhX1v/yLjjsrjsCmz7yxyiJapNIx91ANVLxtGSRL91d1EzPg37OsYHuS/r0ZN3hn5
	 8MMS0wSwZJcq/bVBstt3ny875VoqO0KoexW++0ay3Bqte5SExGWvNuvSHzhdZgrj9C
	 SxBOn1sqDIapKKn0Sc7uAK7pW2qHdUBqyFVO12Eq4naso4d+gXFz6PFTWosOTj+NBI
	 IbTsOUEKd6SzA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs: rename free_space_set_bits() and make it less confusing
Date: Tue, 17 Jun 2025 17:13:06 +0100
Message-ID: <c385b6436e8274d630bd883eda8f50ef22d53348.1750075579.git.fdmanana@suse.com>
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

The free_space_set_bits() is used both to set a range of bits or to clear
range of bits, depending on the 'bit' argument value. So the name is very
misleading since it's not used only to set bits. Furthermore the 'bit'
argument is an integer when a boolean is all that is needed plus it's name
is singular, which gives the idea the function operates on a single bit
and not on a range of bits.

So rename the function to free_space_modify_bits(), rename the 'bit'
argument to 'set_bits' and turn the argument to bool instead of int.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 1794fdf06586..a0b51543e83e 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -535,10 +535,10 @@ bool btrfs_free_space_test_bit(struct btrfs_block_group *block_group,
 	return extent_buffer_test_bit(leaf, ptr, i);
 }
 
-static void free_space_set_bits(struct btrfs_trans_handle *trans,
-				struct btrfs_block_group *block_group,
-				struct btrfs_path *path, u64 *start, u64 *size,
-				int bit)
+static void free_space_modify_bits(struct btrfs_trans_handle *trans,
+				   struct btrfs_block_group *block_group,
+				   struct btrfs_path *path, u64 *start, u64 *size,
+				   bool set_bits)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct extent_buffer *leaf;
@@ -562,7 +562,7 @@ static void free_space_set_bits(struct btrfs_trans_handle *trans,
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	first = (*start - found_start) >> fs_info->sectorsize_bits;
 	last = (end - found_start) >> fs_info->sectorsize_bits;
-	if (bit)
+	if (set_bits)
 		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
 	else
 		extent_buffer_bitmap_clear(leaf, ptr, first, last - first);
@@ -658,8 +658,8 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	cur_start = start;
 	cur_size = size;
 	while (1) {
-		free_space_set_bits(trans, block_group, path, &cur_start, &cur_size,
-				    !remove);
+		free_space_modify_bits(trans, block_group, path, &cur_start,
+				       &cur_size, !remove);
 		if (cur_size == 0)
 			break;
 		ret = free_space_next_bitmap(trans, root, path);
-- 
2.47.2


