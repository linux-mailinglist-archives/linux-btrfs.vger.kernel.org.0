Return-Path: <linux-btrfs+bounces-18887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1FC50C1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 07:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76D0F34B121
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42854265CA6;
	Wed, 12 Nov 2025 06:49:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com [220.197.32.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521935CBC5
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930157; cv=none; b=j0OmLAfxbX5YkCxnLKYTsCyw3azXlAXYB9KC7rp8qLLLywuwKM70jdRQ7AE2ntSrapIKCQM1tRVuRdaIG7Nbp9ocrbOLGBVPTJ7QQiOMxF9kvL10XkVBVe/uo2SP+W+Luo+01I3BgGmn/vBTGt5A0YDlm7hf6kB9h4b/FEdEDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930157; c=relaxed/simple;
	bh=9963MolIpCjVpmRw/nmkRdv1o+hgAYdf7uHiXKSc3B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nCP5mg40DJL+HXJN2qIWOCCdc2Dr7fk/gvCrJnuvmlcdPJOf4s6HHD61EjiARLIjgpA5zPmoI8heMuWqntCUsa3FkaiYQjS6q3c47S8iQXs3vKehPzcHLSIwLxTP+1fmhmQ+2KXXPwxtHaDMTYs76kAxy+5IWQ8ao1HG+k/ZaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12f5e0fd4;
	Wed, 12 Nov 2025 14:49:01 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: Remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 12 Nov 2025 14:48:53 +0800
Message-Id: <20251112064853.1822908-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a76d32a6f0229kunmcf03c2dc1102c1e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGR5NVkIeTRodHUtNQ0NJH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

When btrfs_insert_empty_item() succeeds, the leaf has already been
marked dirty automatically through two mechanisms:

1) COW operations: btrfs_search_slot(cow=1)

2) setup_items_for_insert() → btrfs_mark_buffer_dirty(trans, leaf)

Therefore the explicit call in btrfs_insert_item() is redundant and can
be safely removed. This removes unnecessary code verbosity, reduces
overhead, and aligns with the cleanup done in commit 1ca4e15f41f2e
("btrfs: volumes: remove unnecessary calls to btrfs_mark_buffer_dirty()").

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 561658aca018..719eb5127f3a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4324,7 +4324,6 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		leaf = path->nodes[0];
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		write_extent_buffer(leaf, data, ptr, data_size);
-		btrfs_mark_buffer_dirty(trans, leaf);
 	}
 	return ret;
 }
-- 
2.20.1


