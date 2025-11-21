Return-Path: <linux-btrfs+bounces-19252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81AC7B0EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 18:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C360C4E1182
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C629ACE5;
	Fri, 21 Nov 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/DwpTEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012152836F
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745871; cv=none; b=RYmZd4ffyBa680YWYZeKxO/AC7ODsy1cPzTQWRwdTUFNEa8ohXPyPp508BjK45AETGF+ZY0CS20Rr97cU+WDuoXseNcmPTG6Ro1GEVs8Mz76WJFr6VF4tW3ELjHmwWDHVn+piH490aVo6V4pDdNlE0qFUz/x9VV8yZJvLzRIwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745871; c=relaxed/simple;
	bh=DTcmgKNhacvehcAwEopUplUOlXXMNQXtNPFwabff0/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mCUlcoTOQUTZwlqwY899yNUqcUSh7NG8xLEM8SCZY/0rKRAZN0HXQLKMqoxEiw+W1d17tNgWnLyo+HJqCbqrKYxEUG/9gfT3xXfkm2aQD/l1vcF4fVotDvqIFEi79EfOt9BHQhqAGRtq2nIDwF6u3YIhfJp9bjvGIbCWdREinws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/DwpTEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BBEC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745870;
	bh=DTcmgKNhacvehcAwEopUplUOlXXMNQXtNPFwabff0/4=;
	h=From:To:Subject:Date:From;
	b=l/DwpTEBu2GFtlonijP4RhlMpgTDBn3Pa+EFzFjxKTDeKSOwCEBboTEi3pYBydYQO
	 qDPEUEkEceXWZjRohXjN8MVZkCQWXUDW79HZjruygRdxneETu9IcEgtqvHONjk7RXW
	 319jUjiEiGKgXCXoS2crCuHWY9BDz/dInwIZCBOCi8HGjhlBOtM3Lljm2eaYtXIqRh
	 vBQn7IcrAe2eWNvSmYE2Qq6G2cNWhBtpP8EhXT+DdFuvrHM4HN1hrY02uPJfcSBguv
	 pdgSkYhLEvDCqnJ6htSyzvHUwO5cM4iS1j+RY7WN6VaArLVAxLTEuNmQ7mvR9ySPTP
	 fS7H36KOo8fNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unnecessary inode key in btrfs_log_all_parents()
Date: Fri, 21 Nov 2025 17:24:26 +0000
Message-ID: <d52f0087209f98c146645cea0fd3f1ab29d29a3b.1763745035.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are setting up an inode key to lookup parent directory inode but all we
need is the inode's objectid. The use of the key was necessary in the past
but since commit 0202e83fdab0 ("btrfs: simplify iget helpers") we only
need the objectid.

So remove the key variable in the stack and use instead a simple u64 for
the inode's objectid.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 42c9327e0c12..4ec6d7b52a53 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7203,28 +7203,24 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		item_size = btrfs_item_size(leaf, slot);
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
-			struct btrfs_key inode_key;
+			u64 dir_id;
 			struct btrfs_inode *dir_inode;
 
-			inode_key.type = BTRFS_INODE_ITEM_KEY;
-			inode_key.offset = 0;
-
 			if (key.type == BTRFS_INODE_EXTREF_KEY) {
 				struct btrfs_inode_extref *extref;
 
 				extref = (struct btrfs_inode_extref *)
 					(ptr + cur_offset);
-				inode_key.objectid = btrfs_inode_extref_parent(
-					leaf, extref);
+				dir_id = btrfs_inode_extref_parent(leaf, extref);
 				cur_offset += sizeof(*extref);
 				cur_offset += btrfs_inode_extref_name_len(leaf,
 					extref);
 			} else {
-				inode_key.objectid = key.offset;
+				dir_id = key.offset;
 				cur_offset = item_size;
 			}
 
-			dir_inode = btrfs_iget_logging(inode_key.objectid, root);
+			dir_inode = btrfs_iget_logging(dir_id, root);
 			/*
 			 * If the parent inode was deleted, return an error to
 			 * fallback to a transaction commit. This is to prevent
-- 
2.47.2


