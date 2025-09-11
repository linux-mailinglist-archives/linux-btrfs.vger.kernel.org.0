Return-Path: <linux-btrfs+bounces-16789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EEB52877
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86A81C25625
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A572257827;
	Thu, 11 Sep 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Pz9RFLXp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF76178372
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570809; cv=none; b=Vpbk+Ur/XjCQscRJiNNzcaNyVcEC1AhFoQPfj791RNQhsTjU2g2u8a8E+xXKzTRy4W8+n31IcR8HIa3CUGOurnNHr+jc3VT3jS9TRRJn3JEV3ZL2VcWAQbOMmH+KvpTYA3cturPYJ+zmUmmDrV7s/sa1muSWAHVcseBRszTkp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570809; c=relaxed/simple;
	bh=56R0SdvFehcbaJyg4crgCIEGrS37k++fl+wLKe0I5ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sfi0cGKJSssilmu+ufQ34gdF/SFZI9qlvXmhdi1xPlHw1KVxRPSDANZOcPSA/7l+d600DrkoBFW2BrmQVUue4VBwqiuR4HkVBvisuwu9u43q6GK1/pJK6dDeZspLg3Eoy/Rz+ynMhnN3TtAiig0hNmvFXwMVqSWIuwz7Sv9w9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Pz9RFLXp; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-austinchang.. (unknown [10.17.211.34])
	by mail.synology.com (Postfix) with ESMTPA id 4cMnBR3ZxWzD01CVq;
	Thu, 11 Sep 2025 14:06:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1757570799; bh=56R0SdvFehcbaJyg4crgCIEGrS37k++fl+wLKe0I5ls=;
	h=From:To:Cc:Subject:Date;
	b=Pz9RFLXp166/+UvVsTrY0mE32O4Dc3eT/DLZnT96bEW3LuJGU8aWgKQrY9QHq7wGv
	 C+GV37Bf7fJOQSEFuwMM8UkwlK0hdjM6EN0KEIXJkp18vxTCncA9LO3pkll5eJ/ubs
	 kjd8BbiLdgNiXS8OcNj2kA467cN2o6WNoePY28eE=
From: austinchang <austinchang@synology.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: robbieko@synology.com,
	austinchang@synology.com
Subject: [PATCH v2] btrfs: init file_extent_tree after i_mode has been set
Date: Thu, 11 Sep 2025 06:06:29 +0000
Message-Id: <20250911060629.1885670-1-austinchang@synology.com>
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

btrfs_init_file_extent_tree() uses S_ISREG() to determine if the file is
a regular file. In the beginning of btrfs_read_locked_inode(), the i_mode
hasn't been read from inode item, then file_extent_tree won't be used at
all in volumes without NO_HOLES.

Fix this by calling btrfs_init_file_extent_tree() after i_mode is
initialized in btrfs_read_locked_inode().

Signed-off-by: austinchang <austinchang@synology.com>
---
Changelog:
v2: move the call to btrfs_init_file_extent_tree() under cache_index
label so that inodes from both delayed and regular inode read path
get file_extent_tree initialized.
---
 fs/btrfs/delayed-inode.c |  2 --
 fs/btrfs/inode.c         | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0f8d8e275..d953f7af7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1864,8 +1864,6 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32 *rdev)
 	i_uid_write(vfs_inode, btrfs_stack_inode_uid(inode_item));
 	i_gid_write(vfs_inode, btrfs_stack_inode_gid(inode_item));
 	btrfs_i_size_write(inode, btrfs_stack_inode_size(inode_item));
-	btrfs_inode_set_file_extent_range(inode, 0,
-			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
 	vfs_inode->i_mode = btrfs_stack_inode_mode(inode_item);
 	set_nlink(vfs_inode, btrfs_stack_inode_nlink(inode_item));
 	inode_set_bytes(vfs_inode, btrfs_stack_inode_nbytes(inode_item));
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9e4aec733..652c409ee 100644
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
@@ -3919,9 +3915,8 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
 	i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
 	i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
+
 	btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
-	btrfs_inode_set_file_extent_range(inode, 0,
-			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
 
 	inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->atime),
 			btrfs_timespec_nsec(leaf, &inode_item->atime));
@@ -3953,6 +3948,11 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	btrfs_set_inode_mapping_order(inode);
 
 cache_index:
+	ret = btrfs_init_file_extent_tree(inode);
+	if (ret)
+		goto out;
+	btrfs_inode_set_file_extent_range(inode, 0,
+			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
 	/*
 	 * If we were modified in the current generation and evicted from memory
 	 * and then re-read we need to do a full sync since we don't have any
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

