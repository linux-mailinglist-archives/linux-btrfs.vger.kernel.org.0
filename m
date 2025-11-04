Return-Path: <linux-btrfs+bounces-18648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44AC308AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 11:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D33BAB74
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FE2D5954;
	Tue,  4 Nov 2025 10:37:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F441D90AD;
	Tue,  4 Nov 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252622; cv=none; b=FJtx5IFQ8RiXdZQYWvJ1LRiixSnVXw1vKwg8irTzmMQ1l+c7bZ24ndzaOdFq8bT/Djuh8Je+A7D6cGxlBEz/inO5fh60oTluTda4641EZoJYY4mZCKZAhDsDwImUuZAFW+9VZcP0CsTy9bc2LcqnRtG555mvzUIAferTa5uOYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252622; c=relaxed/simple;
	bh=UDLERbZmhDe6kwSsrknaZ3EXYKwkpgVNTLkSD3ae/Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eUK2cDrKPivSrq3s1XSFJWNBWufsuEugeIsn2h7BBHg0h564iU2Co8590aCyEdYz7UKnkzXYM9ffdO+WUundqulhEKfD0b+QQmONilSiCfOZtXDAW+XUojF4d0TSccSJYZm0f5/1HRYfEyKi/Gzbkyuhdb6iCcIl3UX1qWzcClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1297852a4;
	Tue, 4 Nov 2025 16:14:24 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix NULL pointer dereference in backup_super_roots()
Date: Tue,  4 Nov 2025 16:14:16 +0800
Message-Id: <20251104081416.759194-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a4dee75ab0229kunm26e18c8288e27c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEtNVkxIHR8fSBpDT0geHlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

backup_super_roots() unconditionally dereferences extent_root and
csum_root pointers obtained from btrfs_extent_root() and
btrfs_csum_root() respectively. These functions can return NULL when the
corresponding filesystem trees are unavailable due to corruption or
other error conditions. This causes a kernel panic.

Add proper NULL checking and skip the backup operations for the
unavailable roots.

Fixes: 29cbcf401793 ("btrfs: stop accessing ->extent_root directly")
Fixes: f7238e509404 ("btrfs: add support for multiple global roots")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/disk-io.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..b54c79a1db14 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1670,18 +1670,22 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
-		btrfs_set_backup_extent_root(root_backup,
-					     extent_root->node->start);
-		btrfs_set_backup_extent_root_gen(root_backup,
-				btrfs_header_generation(extent_root->node));
-		btrfs_set_backup_extent_root_level(root_backup,
-					btrfs_header_level(extent_root->node));
-
-		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
-		btrfs_set_backup_csum_root_gen(root_backup,
-					       btrfs_header_generation(csum_root->node));
-		btrfs_set_backup_csum_root_level(root_backup,
-						 btrfs_header_level(csum_root->node));
+		if (unlikely(!extent_root || !csum_root)) {
+			btrfs_warn(info, "failed to get extent or csum root for backup");
+		} else {
+			btrfs_set_backup_extent_root(root_backup,
+						     extent_root->node->start);
+			btrfs_set_backup_extent_root_gen(root_backup,
+					btrfs_header_generation(extent_root->node));
+			btrfs_set_backup_extent_root_level(root_backup,
+						btrfs_header_level(extent_root->node));
+
+			btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
+			btrfs_set_backup_csum_root_gen(root_backup,
+						       btrfs_header_generation(csum_root->node));
+			btrfs_set_backup_csum_root_level(root_backup,
+							 btrfs_header_level(csum_root->node));
+		}
 	}
 
 	/*
-- 
2.20.1


