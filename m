Return-Path: <linux-btrfs+bounces-16636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7599B453F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B6A7BC02C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84F27A90A;
	Fri,  5 Sep 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="EqeCU4zE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D0276051
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066469; cv=none; b=H2QIV/OjyN3Faqu2qWEKvyjn7qlqV1frfAMydaeYPxCdLrYFp3ZRXhFtBRwfsQhTkxegizoEXLGavTPOCpAH/SMJkTk7dAbHq54nxHiw0vayM2+Lg4Ex6ib0cb2WT3Xc9oxHwvJ7XNPrtbxmpZ4FXx2bZws66VbXk65Egh9puGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066469; c=relaxed/simple;
	bh=8qSbdaIy/tXA62DWWDqEJXUlSactneJJdOlBtolJ9p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IMQzkdrDVFN58KsYqIqyBdplG54EeMrvEnMRF9fqgWIwfy6aTRDNrVAc9FuWNAFwHR4X6mMbkIisEYZVUOWmauWToKs6jlR0RlE5c0kdORd2YWhMEtsfmC/XnlMjJqmisCFSRhw+8V5W05XRVbkwIA79Jqvi2+mACWdxyM3GCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=EqeCU4zE; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-austinchang.. (unknown [10.17.211.34])
	by mail.synology.com (Postfix) with ESMTPA id 4cJBXt3yfwzCsBCsW;
	Fri,  5 Sep 2025 17:55:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1757066110; bh=8qSbdaIy/tXA62DWWDqEJXUlSactneJJdOlBtolJ9p0=;
	h=From:To:Cc:Subject:Date;
	b=EqeCU4zESo9qAfpjaeTkqegYLEDNa55TJIbgmrkb6L/MGJUcFOxko3xWiAY4FTRF4
	 HFonerTaZimLKxXrepFJ6LEJxQ7j3rtczmaYC1SE9EBE+PuPe7l7PATccoFIzRQ5pU
	 8l3iYiu0br3C+trG2Qrhc48yBOpb4OjIsx5FLcUU=
From: austinchang <austinchang@synology.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: robbieko@synology.com,
	austinchang@synology.com
Subject: [PATCH] btrfs: init file_extent_tree after i_mode has been set
Date: Fri,  5 Sep 2025 09:55:03 +0000
Message-Id: <20250905095503.1812090-1-austinchang@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain

btrfs_init_file_extent_tree uses S_ISREG() to determine if the file is a
regular file. In the beginning of btrfs_read_locked_inode(), the i_mode
hasn't been read from inode item, then file_extent_tree won't be used at
all in volumes without NO_HOLES.

This patch is based on version 6.17-rc4. It moves the initialization to
where i_mode has been set and before the first time file_extent_tree is
used(btrfs_inode_set_file_extent_range).

Signed-off-by: austinchang <austinchang@synology.com>
---
 fs/btrfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9e4aec733..5731cd296 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3885,10 +3885,6 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	bool filled = false;
 	int first_xattr_slot;
 
-	ret = btrfs_init_file_extent_tree(inode);
-	if (ret)
-		goto out;
-
 	ret = btrfs_fill_inode(inode, &rdev);
 	if (!ret)
 		filled = true;
@@ -3919,6 +3915,11 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
 	i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
 	i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
+
+	ret = btrfs_init_file_extent_tree(inode);
+	if (ret)
+		goto out;
+
 	btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
 	btrfs_inode_set_file_extent_range(inode, 0,
 			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

