Return-Path: <linux-btrfs+bounces-18283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1776C061C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8637F35B717
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F02DC771;
	Fri, 24 Oct 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua98Syci"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B12D7D3A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306730; cv=none; b=JDwjG7VZPsShBlNndDFdT/ueS8MKmDfWtgCXXapsJ9DEH43nj0wzhYMQET09w5MqMvs278A+VlBjCLJCbp4HJd1DRcn1Q34yMbFxet0ItkPSPQuGgYPeZ0ufUe1dsuw05iDRQ6fzmYEMBnmeGBsXIT9ATn7D9+0Y78IadB5dSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306730; c=relaxed/simple;
	bh=O0E7Ui+a8h/19npSscqfmyMgcz7SPu7QmdHp8SAYBCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t6pEqO2j8s63KFWVNFE0TqEKnIo+y91dcJx8Loa7B4218VnONlBbFyV63GmzdDOlCpPq6tXueLHsENpu4C3+leEGFp9QAcK9pA7yTqhuBn321ULGVPPCe+/hSOAxNVnVumxdqTzUBYI77QxJtR3ExaRLN5cUs4jql9Ca0etyH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua98Syci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E9C4CEFF
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761306726;
	bh=O0E7Ui+a8h/19npSscqfmyMgcz7SPu7QmdHp8SAYBCo=;
	h=From:To:Subject:Date:From;
	b=Ua98SycidCrFI7UCh6B6VixmL1yWoS93iNPfQf5HGgca0vsw3tWStndZkkotrimYY
	 Gns0BMr5OlCDhEyPHhfWb+mGbPd8z9nlvB3VBAM/D8Pitdo+4HM8Z3Mhiqi1N8qcCu
	 ykTaIUxQZDQQDPV4pu7h2kCIO0W/i8TtPKmut39nwSaGXuAXOoo9K9r0oI0R1eOhUm
	 uHmqzYxtU0EkYve+KN7VPUxD38FEfNCOE5Zxz3dWVNYufr92tWIshwLR26aYFyI69Z
	 0hTQuz7H3500PyZgA12C1BEfEaj2/InfpWmoY0KvbRdu8KynaTDoV3z/21LyZCoqHS
	 J7p+9TIGgcnNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name
Date: Fri, 24 Oct 2025 12:52:02 +0100
Message-ID: <cf3df42390ff83be421dcdc375d072716a67d561.1761306236.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we are logging a new name make sure our inode has the runtime flag
BTRFS_INODE_COPY_EVERYTHING set so that at btrfs_log_inode() we will find
new inode refs/extrefs in the subvolume tree and copy them into the log
tree.

We are currently doing it when adding a new link but we are missing it
when renaming.

An example where this makes a new name not persisted:

  1) create symlink with name foo in directory A
  2) fsync directory A, which persists the symlink
  3) rename the symlink from foo to bar
  4) fsync directory A to persist the new symlink name

Step 4 isn't working correctly as it's not logging the new name and also
leaving the old inode ref in the log tree, so after a power failure the
symlink still has the old name of "foo". This is because when we first
fsync directoy A we log the symlink's inode (as it's a new entry) and at
btrfs_log_inode() we set the log mode to LOG_INODE_ALL and then because
we are using that mode and the inode has the runtime flag
BTRFS_INODE_NEEDS_FULL_SYNC set, we clear that flag as well as the flag
BTRFS_INODE_COPY_EVERYTHING. That means the next time we log the inode,
during the rename through the call to btrfs_log_new_name() (calling
btrfs_log_inode_parent() and then btrfs_log_inode()), we will not search
the subvolume tree for new refs/extrefs and jump directory to the
'log_extents' label.

Fix this by making sure we set BTRFS_INODE_COPY_EVERYTHING on an inode
when we are about to log a new name. A test case for fstests will follow
soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 1 -
 fs/btrfs/tree-log.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79732756b87f..03e9c3ac20ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6885,7 +6885,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	BTRFS_I(inode)->dir_index = 0ULL;
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     &fname.disk_name, 1, index);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 65079eb651da..8dfd504b37ae 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7905,6 +7905,9 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	bool log_pinned = false;
 	int ret;
 
+	/* The inode has a new name (ref/extref), so make sure we log it. */
+	set_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
+
 	btrfs_init_log_ctx(&ctx, inode);
 	ctx.logging_new_name = true;
 
-- 
2.47.2


