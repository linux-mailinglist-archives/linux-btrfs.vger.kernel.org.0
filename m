Return-Path: <linux-btrfs+bounces-19889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA17CCECE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E434A3016994
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0042D73B2;
	Fri, 19 Dec 2025 07:42:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com [117.135.214.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754C2D8360
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130143; cv=none; b=siImTXVWuXH6NiHhHtacbrXZXxONTi8m24rMdK7tTn06UZWhWmbFeA2vhMiRhNR7Tb/qVXqP2xa2pjLYHOBoe1u+K/jlZqWmNTFG+A72f2ZDfAFycTIlj0lKJgLlAcoKZJbOOmeq6YBEAtce0Y82MO4/cqL40olI/koCf4beVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130143; c=relaxed/simple;
	bh=9ZNvdB+PeR0/FF18jIEhe4pHMWXFj79HNf+CF1N+VNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+WXv6n8duSBVB+/HxSjRnsKOqw19mlN78hA17dUj9cVCfINHwbGGKFIop+K3VGuMJo/PVz3zUfa5qdKigeOoJx73FT/jDsQ8GAJDjZtcQxA/5KZzQZWU6Zkgx0KdmkB9gojF0+t4w3uoIe7zgjVwDVkVFmYPj1YkETDigIvAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=117.135.214.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 148fc7c94;
	Fri, 19 Dec 2025 15:37:01 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: simplify check for zoned NODATASUM writes in btrfs_submit_chunk()
Date: Fri, 19 Dec 2025 15:36:49 +0800
Message-Id: <20251219073649.1157563-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b358a66a50229kunma56a6fbe732fcc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThoaVkJKQ0geQh9DH0wZSFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

This function already dereferences 'inode' multiple times earlier,
making the additional NULL check at line 840 redundant since the
function would have crashed already if inode were NULL.

After commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by
extracting it from btrfs_bio::inode"), the btrfs_bio::inode field is
mandatory for all btrfs_bio allocations and is guaranteed to be
non-NULL.

Simplify the condition for allocating dummy checksums for zoned
NODATASUM data by removing the unnecessary 'inode &&' check.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb8..abe3e5e7c5d9 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -837,7 +837,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			if (status)
 				goto fail;
 		} else if (use_append ||
-			   (btrfs_is_zoned(fs_info) && inode &&
+			   (btrfs_is_zoned(fs_info) &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
 			status = errno_to_blk_status(ret);
-- 
2.20.1


