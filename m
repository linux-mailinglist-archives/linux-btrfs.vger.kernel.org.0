Return-Path: <linux-btrfs+bounces-18773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A69C3AC2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CE274E757D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976D310650;
	Thu,  6 Nov 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="h/ztx85c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCC2DAFBF;
	Thu,  6 Nov 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430312; cv=none; b=aGrqv1S8iA9gAqP2OhvuY/9b+b5qgYyV82qMm9uqVbQYvfHVdxSlQ08ti5kNgAlrB+eMNXOiMrW1gWa4mLENgZQ+cFwvAAqLZzZbR1FDcNJ0nYvvGW0aWay6hht0YBdOYU3g6QzfnTqtRFg89wJyGFi6oV2s5iJ4pgGNj+R5LE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430312; c=relaxed/simple;
	bh=M/uhW6CfAw2MLDz8vTpduubG/uOVFe0jqSk9Ynx3ZjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ciBRBN35hgbzuVPtQvnFlIV8p1DuDv02lnQ88nI7CeyYlyhQEGyCRM2DoLr3Pg0k3k7BvmUw1Yu28hZ+jXjOp0g8bMtabxuDtMiyuwEltjvP8wVlSMCuLJuchV/uQUzK0TwSHF4qAijKljc7NKu+gzhZTDzdpgX442Xy6UIt1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=h/ztx85c; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28a5e7ee7;
	Thu, 6 Nov 2025 19:58:19 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: clm@fb.com
Cc: dsterba@suse.com,
	fdmanana@suse.com,
	neal@gompa.dev,
	boris@bur.io,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] btrfs: avoid redundant cleanup when device allocation fails
Date: Thu,  6 Nov 2025 11:58:15 +0000
Message-Id: <20251106115815.3635405-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a59082ad503a1kunm26a292ab7a4446
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR8ZVk9MHx5ITExOGh1MTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=h/ztx85cc6iey7T3aeTLYXjgd89FOu4GzbMicrcUCHMqT1d+eiWnA99m6N0G8875ZMdZZwvA2DaRsa0S+JLFPNcR6bw1l9yuiKzvK0H+J9wVdbppdMXMMX47embKUqOD2+Tlufdu/ftCfqs4DsL/2/cXwMIGwgHjpNEKjNCMQPk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=uw4dxLTV+p9YbEVcKU4Hy/PdsNRbXcaQFe6PcMz/gCk=;
	h=date:mime-version:subject:message-id:from;

When device allocation fails, the chunk map has not been added to the
mapping tree, so locking for cleanup is unnecessary. Simply free the
chunk map as done when adding it to the mapping tree fails.

Fixes: bf2e2eb060fa2 ("btrfs: Add self-tests for btrfs_rmap_block")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/btrfs/tests/extent-map-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 42af6c737c6e..e227cfff1e8d 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1036,7 +1036,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		if (IS_ERR(dev)) {
 			test_err("cannot allocate device");
 			ret = PTR_ERR(dev);
-			goto out;
+			btrfs_free_chunk_map(map);
+			goto out_free;
 		}
 		map->stripes[i].dev = dev;
 		map->stripes[i].physical = test->data_stripe_phys_start[i];
-- 
2.34.1


