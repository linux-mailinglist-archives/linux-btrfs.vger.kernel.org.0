Return-Path: <linux-btrfs+bounces-19890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63664CCF02C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 09:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 949AA300DCEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45232D5A01;
	Fri, 19 Dec 2025 08:43:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1B199949
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133818; cv=none; b=YH3j+A+GtUedJYRNhPdl4JfeDOVNLNAfkgckHRaQrehiWUkW+eJGOzwOPi1Lma2FpWJygKtakGLLop/nwypHg8a99NxCC9T5WigvHbnUmLyyimFriRr0CmYPwChyIZ6/tj3kRcqE28u1pf21BW/u1gHm93IC/qjaBQzRWkLkNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133818; c=relaxed/simple;
	bh=7IJ7mgh+i6/Bsq7FjTPGWAHP0BnbpNGEvw5ocwmF1pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuWVAwA202xbJ+9wklOsXLCWgxUBLVzvVoi/8u+sXdCCog3Jq0JV3uH0aZdDFZsm9PFFGnd9uEK+urG9EpUqdjuR6Rh4CbnuIKn6Iv09gsKCim4R+1dWiZz9qNSZBy0o9U8gaVsQB3RRWB5t3QIOpUmvOZKSrvk61rfCXqBvrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1490c421b;
	Fri, 19 Dec 2025 16:43:25 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: remove redundant inode NULL check in is_data_bbio()
Date: Fri, 19 Dec 2025 16:43:16 +0800
Message-Id: <20251219084316.1164580-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b35c731340229kunmb05fc06273ce81
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh5PVhoZSU0fTB5CSRlNSFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

After commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by
extracting it from btrfs_bio::inode"), the btrfs_bio::inode field is
mandatory for all btrfs_bio allocations. The NULL check is redundant and
can be removed.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb8..ce649e265b75 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -29,7 +29,7 @@ struct btrfs_failed_bio {
 /* Is this a data path I/O that needs storage layer checksum and repair? */
 static inline bool is_data_bbio(const struct btrfs_bio *bbio)
 {
-	return bbio->inode && is_data_inode(bbio->inode);
+	return is_data_inode(bbio->inode);
 }
 
 static bool bbio_has_ordered_extent(const struct btrfs_bio *bbio)
-- 
2.20.1


