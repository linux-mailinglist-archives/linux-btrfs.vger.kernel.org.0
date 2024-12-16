Return-Path: <linux-btrfs+bounces-10415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFC9F3751
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A247A693F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F36206F27;
	Mon, 16 Dec 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsVO1Ugz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA720764C
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369451; cv=none; b=MsbcI37ejZy1KA34pifnyGfnaeUWlOOSOLaa9IqbRN/Z1iiePMyef2oj1M86rjM1Z3wsVKc3HrkcsS4UlPE6CXnIbWcRG9wfhVrO0/DAmIc2aT64g1BptoR5ttE0u08MnVxxRNPfh3KKQd13M/414comNCTbDZMfpNMtcS/fnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369451; c=relaxed/simple;
	bh=syc3Osv6jDM27BPrwwZx0fYRc6h6k16GBN3Sle/H91s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlJU6/Zj17JauNQFt6Fx7sPCD1LZVbZaLVdLqRQ+eg3UzjSyAbAK3v/J0AAO+Fzaj16rq1tleNkQ6MOlUQFOhlvinIsdtlkY3qFDofoFXZYpJfExQmm5+Nz0t2n9KzuuNRq0g2POJhYzFzWHWcsLVwb05i1pEN2o+lS+XMiq5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsVO1Ugz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B3C4CEDE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369451;
	bh=syc3Osv6jDM27BPrwwZx0fYRc6h6k16GBN3Sle/H91s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VsVO1UgzpV+4c5d+5w5ath6UIOd/azTKcFtra/gDnuPLA0YRIkBxgBqhWOc/+DQEU
	 62pRilsZsLQTvmvMoSq7GoNa3EY5OSQqUJ4lssQy3kO4Jw6pIGZnZtNWJYrghYxM5W
	 LS35fZGGJWa3wa4HeuLoVLlnJcP4Rne19vfZB5Aw7MVLK+JgBA2PLrO1CukbJvX3qZ
	 rH/v8XfNE/HYlDu+gNilsWS7Gl5wQL3nEnWTDbGbO1YudkWmiG0qT6oWwUefJaFNIr
	 Nu5aTNvLXq8w0vPPWUgsGiqBZBEQMD0xnFNZ4szgC+bh1BapWs85gU7KuhK+FNgcRB
	 GGCJBH+vdxnkw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
Date: Mon, 16 Dec 2024 17:17:19 +0000
Message-Id: <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's a generic helper not specific to ioctls and used in several places,
so move it out from ioctl.c and into fs.c. While at it change its return
type from int to bool and declare the loop variable in the loop itself.

This also slightly reduces the module's size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1781492	 161037	  16920	1959449	 1de619	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1781340	 161037	  16920	1959297	 1de581	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.c    |  9 +++++++++
 fs/btrfs/fs.h    |  2 ++
 fs/btrfs/ioctl.c | 11 -----------
 fs/btrfs/ioctl.h |  1 -
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 09cfb43580cb..06a863252a85 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -55,6 +55,15 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 	return ARRAY_SIZE(btrfs_csums);
 }
 
+bool __pure btrfs_is_empty_uuid(const u8 *uuid)
+{
+	for (int i = 0; i < BTRFS_UUID_SIZE; i++) {
+		if (uuid[i] != 0)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Start exclusive operation @type, return true on success.
  */
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b05f2af97140..15c26c6f4d6e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -988,6 +988,8 @@ const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
 
+bool __pure btrfs_is_empty_uuid(const u8 *uuid);
+
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ede6a5524c2..7872de140489 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -471,17 +471,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int __pure btrfs_is_empty_uuid(const u8 *uuid)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
-		if (uuid[i])
-			return 0;
-	}
-	return 1;
-}
-
 /*
  * Calculate the number of transaction items to reserve for creating a subvolume
  * or snapshot, not including the inode, directory entries, or parent directory.
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 2b760c8778f8..ce915fcda43b 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -19,7 +19,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int __pure btrfs_is_empty_uuid(const u8 *uuid);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
-- 
2.45.2


