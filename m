Return-Path: <linux-btrfs+bounces-19857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE25CCBC8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720E130413DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560932E73C;
	Thu, 18 Dec 2025 12:27:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com [117.135.214.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FB322B93
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060869; cv=none; b=F+gY3yocAR6G6xwUrQuiUoUMaNogk/dG3gYHZG3qt/PX9BWtbbYWeJ0XxfYF0Mew0Yl18sJoa5lVAg33WIk1+0UaInGDtcjkaKD+X+wdRiVLKAxcRs/GpsSk4VUF6QGai0kgEVUW72SvUthe/s2sxtT+19RuMh+aBnnqGfHr+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060869; c=relaxed/simple;
	bh=tBCW3SHUlKal+89QeGRMYtBhzHi/Eul6ICRwm6US6m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2rQ5psP02pN0UDS+fG7sHlmz7UBaaTuaYq14wYPQQ8ld9GhnMBe4J4cSVdNj96cHL+Q4OC4/VQBtm95RfFuDJ7csdJlNAh9clpmyOGVXtc6aTRGuumu/vmq+jMRSh6+jksBbUnd/CH8WPqJUNC/6aGwD4hWcRjESfF2PBmUxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=117.135.214.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1487183b4;
	Thu, 18 Dec 2025 20:22:23 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com,
	wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: remove assertions after btrfs_bio struct changes
Date: Thu, 18 Dec 2025 20:22:15 +0800
Message-Id: <20251218122215.1044381-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b31694e630229kunmec2502006cb07f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0gdVhlKHx9CSE5CGkhPH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by extracting it
from btrfs_bio::inode") modified the btrfs_bio structure to make the
inode field mandatory, making these assertions redundant:

- btrfs_check_read_bio(): inode is validated by btrfs_bio_init()
- btrfs_submit_bbio(): condition always passes since inode is never NULL

Remove these obsolete checks.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/bio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb8..2b6a97fba1b2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -307,9 +307,6 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	phys_addr_t paddr;
 	u32 offset = 0;
 
-	/* Read-repair requires the inode field to be set by the submitter. */
-	ASSERT(inode);
-
 	/*
 	 * Hand off repair bios to the repair code as there is no upper level
 	 * submitter for them.
@@ -899,9 +896,6 @@ static void assert_bbio_alignment(struct btrfs_bio *bbio)
 
 void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
 {
-	/* If bbio->inode is not populated, its file_offset must be 0. */
-	ASSERT(bbio->inode || bbio->file_offset == 0);
-
 	assert_bbio_alignment(bbio);
 
 	while (!btrfs_submit_chunk(bbio, mirror_num))
-- 
2.20.1


