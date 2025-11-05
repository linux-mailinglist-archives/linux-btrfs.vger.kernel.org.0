Return-Path: <linux-btrfs+bounces-18706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7FC33C8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 03:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411BF189F1D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A922B8AB;
	Wed,  5 Nov 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="UgdMNdAY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB61E98E6;
	Wed,  5 Nov 2025 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310251; cv=none; b=QCUinN8zSn8CQj9B/S3e7lwST+zhr3Z+q6E2wYFC5c9WU8QA3YhvVXD9gnWpOTd2x5uDTOvuFSElWnpSbdXD0nRCd9/E9vTYfQNcBdyen/yaUoksZbPDc4AuM/qTiyeLogVybOlDg+EvPv94RIY9qrjmO2Oxbm48LZWzzn6oL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310251; c=relaxed/simple;
	bh=70wMsudLu92iZJkhBGj/feDzySuTgiU7h7claqI58/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQnfNiww2siAEfmhz0r8rs+0UkC4BWq65aTKq9pS4EX41E99etuQBg/aPdX8S5obV/jdG9dQIocI0mY6ST15dK/EHWbtBCRWu62BLG93yC79hHeLVnaJ6WZzP/s8MTkMtaz9sfleTxj7cUWTw4QTplGTNiFthuQM/IRFT5aCbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=UgdMNdAY; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 286a97d94;
	Wed, 5 Nov 2025 10:37:25 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: clm@fb.com
Cc: dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] btrfs: fix memory leak in data_reloc_print_warning_inode()
Date: Wed,  5 Nov 2025 02:37:22 +0000
Message-Id: <20251105023722.1820102-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a51e04c0e03a1kunmbcd364ac6d3048
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUtJVk4dTksfGh1PHUpMQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=UgdMNdAYVreH01a3WtGZZKmAyd1YDVdlZk+68dyEj/yIJCExwMr1+2vRN2uJZTmO9KzsFJ6on6Q1tQGoIMxfqfo52i/GxdlXQy95Z75mZgjRIrp02or9dypQGGBh2z9dKkwfOhLfwGUasaQw43DI4yzInyk1981d331H/UHATEA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=CThSGH+O+26R4HaHI9rrGN9sacwSX6I+q3+J9DIYatI=;
	h=date:mime-version:subject:message-id:from;

data_reloc_print_warning_inode() calls btrfs_get_fs_root() to obtain
local_root, but fails to release its reference when paths_from_inode()
returns an error. This causes a potential memory leak.

Add a missing btrfs_put_root() call in the error path to properly
decrease the reference count of local_root.

Fixes: b9a9a85059cde ("btrfs: output affected files when relocation fails")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3df5f36185a0..6282911e536f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -177,8 +177,10 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 		return ret;
 	}
 	ret = paths_from_inode(inum, ipath);
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_put_root(local_root);
 		goto err;
+	}
 
 	/*
 	 * We deliberately ignore the bit ipath might have been too small to
-- 
2.34.1


