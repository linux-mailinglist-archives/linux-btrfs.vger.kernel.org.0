Return-Path: <linux-btrfs+bounces-12270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E44A5FEA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398B33BB7FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3B1EB1B8;
	Thu, 13 Mar 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiJrgqWe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F91E9B26
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888542; cv=none; b=lMgcxetwMKqsxAOqYcxm64e9GH3vFJ4Sef4zVOhtgDQ78pZdkXqf+vj/mh7Z7CgeMCDoAIYzouzWv2WEDeSkoRSP3hO1ypFap1oTQcZYQKPDELzn8Af9PGn86yYgWDOVlu1hiVy8K5vxU346nGZoj8smBITgxBP4u3bxP631534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888542; c=relaxed/simple;
	bh=Bw1/L/CeCO9LrjO4acgWC8W+Y/FFVnIFZfPMoml4oko=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0XsEvMBFVlMXWoarxUvGGE1VOIjtWv3VDTQxsMfAQmk1dpyzl2w/MlKtlAHboLp7m60YaEy+PADB1eGxfjNTTCN9MUlMAhqfkqPWajTja041MwlJnn1/FY5jnhWQIdKgZERvq/haQzzTrqwOhv46Jb0WIKzcIRQ5XgD3uFwmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiJrgqWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C70CC4CEEA
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888541;
	bh=Bw1/L/CeCO9LrjO4acgWC8W+Y/FFVnIFZfPMoml4oko=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eiJrgqWeiWv1zHGezp0ie6WlAupbmQH+qk7ENcguRJS3xWwECfgsUMd/rHd2G1oxr
	 lVeUNteJ22E8QKBBpl89kbkG4f54zddJzg2lLVznRE0Wqzzbwr05VjFyzDyxuIOgbU
	 4ZEEGaiG0CwAMUcuFvortkUMJG0Hj4jwKsnEzUdprQKDum47cKOjrvfHkcfeymTqcE
	 8lizT4XV7keTwS/q21dqrEaoh94LJsPkr7sc0lKkBgZ3cdOaFgBMypMU90p7awMWdQ
	 A83H2nvSHsCtiGvkg59sYEBt64a6ANhx4lCfHxPCuO9Kew5efJrpyCEEPjyG5lb5yN
	 PG1qY+UIvBn+w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: avoid unnecessary memory allocation and copy at overwrite_item()
Date: Thu, 13 Mar 2025 17:55:31 +0000
Message-Id: <879a3362577693b50500e8dc08ba576eade8fd5e.1741887949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to allocate memory and copy from both the destination and
source extent buffers to compare if the items are equal, we can instead
use memcmp_extent_buffer() which allows to do only one memory allocation
and copy instead of two.

So use memcmp_extent_buffer() instead of memcmp(), allowing us to avoid
one memory allocation, which can fail or be slow while under memory heavy
pressure, avoid the memory copying and reducing code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2d23223f476b..91278cc83bd4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -422,7 +422,6 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 
 	if (ret == 0) {
 		char *src_copy;
-		char *dst_copy;
 		u32 dst_size = btrfs_item_size(path->nodes[0],
 						  path->slots[0]);
 		if (dst_size != item_size)
@@ -432,23 +431,16 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 			btrfs_release_path(path);
 			return 0;
 		}
-		dst_copy = kmalloc(item_size, GFP_NOFS);
 		src_copy = kmalloc(item_size, GFP_NOFS);
-		if (!dst_copy || !src_copy) {
+		if (!src_copy) {
 			btrfs_release_path(path);
-			kfree(dst_copy);
-			kfree(src_copy);
 			return -ENOMEM;
 		}
 
 		read_extent_buffer(eb, src_copy, src_ptr, item_size);
-
 		dst_ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-		read_extent_buffer(path->nodes[0], dst_copy, dst_ptr,
-				   item_size);
-		ret = memcmp(dst_copy, src_copy, item_size);
+		ret = memcmp_extent_buffer(path->nodes[0], src_copy, dst_ptr, item_size);
 
-		kfree(dst_copy);
 		kfree(src_copy);
 		/*
 		 * they have the same contents, just return, this saves
-- 
2.45.2


