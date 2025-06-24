Return-Path: <linux-btrfs+bounces-14922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112EAE69B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DF24E12DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9002E0B7F;
	Tue, 24 Jun 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFt0xw+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7042D8797
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776153; cv=none; b=QcDjDfSSnKcKcEaZFsvF/htNBO4CJCtOhDD79ONOihnCE8SI8Ot3HeTblf/b3xUyj8gaeIXvj6trintljoeUtjy2ocJqozrVrszOihTc/shr/X7PJM0ZJygNfYa5joIDPFMiuAqYD0GhxUrmltopEssgvc/SdrEOoNc8Cd0Cn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776153; c=relaxed/simple;
	bh=keus9Q4wu97LRI7vAaAE4QOsbeadLpH0trEx2AxGxUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNMKvzOqYVrMbpqMQRlX0EypSg+PZB9y2KwrMM/YRLg8H2piC+mSz51GrxuWvuTkx6AqLXchiNNr4rgyMkRi1T5ByAl7gewdQhOf5OqXy8K5JTAMWUBDLTb1OkPEng0fIvLxQFRBmDhS6zIlIVuSZXi6ywVzUhIirPrULiAv2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFt0xw+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D901C4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776152;
	bh=keus9Q4wu97LRI7vAaAE4QOsbeadLpH0trEx2AxGxUI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fFt0xw+S7ztLiorwT0js0pr8063JXJ7OOZnD/FqM1OyKz27GHDMBhAeXryuSbEAOb
	 Ju4OfAqpB8zt/mTlXZ9uHFdyNXdDwYW/o5wbLG2MT+2WtJi7uHdxeFLHsi8mA01kEt
	 m2Ij27yyablc5p5Wf6KB5WhFQBd9X2s23y6ASLlHotQJKunjcZWr6ekthMhzQayyZ1
	 IPiaZRiinYGQhdreZdyhJY2hUlPFId4I9IaoAK4pWprSu9Dp+PljIRhFGSuA8JCC4F
	 v0aDwvnmGqYwKXxnnsjzRVJeKa5F+s4tA1Nfzj+ve+TFGv2aJV0q8Pbu5EAfe2Fo2i
	 vQ/2rlumtVvHQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during rmdir
Date: Tue, 24 Jun 2025 15:42:16 +0100
Message-ID: <cfd83c633ff032b9eabe4e71ec829151461bf168.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are setting the parent directory's last_unlink_trans directly which
may result in a concurrent task starting to log the directory not see the
update and therefore can log the directory after we removed a child
directory which had a snapshot within instead of falling back to a
transaction commit. Replaying such a log tree would result in a mount
failure since we can't currently delete snapshots (and subvolumes) during
log replay. This is the type of failure described in commit 1ec9a1ae1e30
("Btrfs: fix unreplayable log after snapshot delete + parent dir fsync").

Fix this by using btrfs_record_snapshot_destroy() which updates the
last_unlink_trans field while holding the inode's log_mutex lock.

Fixes: 44f714dae50a ("Btrfs: improve performance on fsync against new inode after rename/unlink")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 252271cbde28..12141348236d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4747,7 +4747,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 * deletes for directory foo.
 	 */
 	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
-		BTRFS_I(dir)->last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
+		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
-- 
2.47.2


