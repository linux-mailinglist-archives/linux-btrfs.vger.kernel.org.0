Return-Path: <linux-btrfs+bounces-19848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F3CCA2F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 04:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 348A530220C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E072F657C;
	Thu, 18 Dec 2025 03:31:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079562FF66B
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028661; cv=none; b=WzN926JqX8pHOpWt2AlCP2lsAKXXTzcI/cBZiVWJHLmSo1OMX1Aw1LH2uNS+LlEslhHF7KZuQrVXspIJ2QxRafDGoscVvG+BoPMvozxfII6++Y5f63AREAObBnem4sfw3l6W4F3fsMP8LVGZvjh0OGohqXM7iq6Ooi/87K+Fi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028661; c=relaxed/simple;
	bh=fmYQc/dOJD6Q+PSGhwhQhFBD7xn/R/67Excrh1b3mDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOrvDl2heLBZj4LAmpY8BuKQQxy97QKtAz5PhlOnVckQqbSMhcNoU99cNcNySQHZdEmDFPfWpWWK5SxwPbfRTIGG+MXjVRa06qOKeKjdamJerTh9p3rjXA4yY3Uaw/2rqRKRq2Ty8R0EmyObTvSzyAmujEL9JO9FRpHirP3/VZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1480a3ac9;
	Thu, 18 Dec 2025 11:30:46 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: remove unreachable return after btrfs_backref_panic
Date: Thu, 18 Dec 2025 11:30:37 +0800
Message-Id: <20251218033037.983058-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b2f8297700229kunm5848f2a568ac91
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGRkZVksfSkJCTBkdSRlCT1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

The return statement after btrfs_backref_panic() is unreachable since
btrfs_backref_panic() calls BUG() which never returns. Removes the
dead code.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/backref.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 78da47a3d00e..9bb406f7dd30 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3609,10 +3609,8 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 		}
 
 		rb_node = rb_simple_insert(&cache->rb_root, &upper->simple_node);
-		if (unlikely(rb_node)) {
+		if (unlikely(rb_node))
 			btrfs_backref_panic(cache->fs_info, upper->bytenr, -EEXIST);
-			return -EUCLEAN;
-		}
 
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 
-- 
2.20.1


