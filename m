Return-Path: <linux-btrfs+bounces-18668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA8C31359
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA92518814DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62132145A;
	Tue,  4 Nov 2025 13:21:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81770320CB8;
	Tue,  4 Nov 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262486; cv=none; b=iNTfnmxMS1XZ+tbZAWT75FSo4vxHFvlRWvrxsQlvKLV/ZRHmoDLYdNBK3b3f5IBBneQo5+E8M6z/hnwUp1O0o+40jx++mXSaMUg3NkoYgmZ78couboyLWiOvrIGZHwIv+pN84c1MgKBwY6m2uV1sRwDUDKBa4B26wEY4xELPSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262486; c=relaxed/simple;
	bh=bhme5LPsQEL76IPnQydIxT8lEORIQp0L7xT+cm+phYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NyCIczpGXfhtE+N4UysRCQlveGe/Wnj64gsGcmKWdSstGu1XE7xRVu1Vwzd88+HAo7GgQaXvZyU37u5GolM7NiFv2ta03Kg//eeZ6a0C6u9VRjng6Yz2gMHfs29VFGz7C4OHZjP9Yka+ZKteQHqq/rNyFjOlhz7Y9Whe0G++u+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12981dac7;
	Tue, 4 Nov 2025 16:45:18 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix resource leak in do_walk_down()
Date: Tue,  4 Nov 2025 16:45:09 +0800
Message-Id: <20251104084509.763078-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a4e0abde10229kunm68649e30897822
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0tLVhpNHk4YGBkYGUhCTVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

When check_next_block_uptodate() fails, do_walk_down() returns directly
without cleaning up the locked extent buffer allocated earlier,
causing memory and lock leaks.

Fix by using the existing out_unlock cleanup path instead of direct
return.

Fixes: 562d425454e8 ("btrfs: factor out eb uptodate check from do_walk_down()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dc4ca98c3780..742e476bf815 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5770,7 +5770,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	ret = check_next_block_uptodate(trans, root, path, wc, next);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	level--;
 	ASSERT(level == btrfs_header_level(next));
-- 
2.20.1


