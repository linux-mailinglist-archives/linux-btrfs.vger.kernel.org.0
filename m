Return-Path: <linux-btrfs+bounces-14920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB7AE69C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633BE4E0307
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF122E0B53;
	Tue, 24 Jun 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fms6Bq2Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB62E0B6A
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776151; cv=none; b=aiL0QluUgcICTOhn1Y0Ny2f8qNBlgnV8dv+H45GAY4JvWdl7zB7rXKrqFMxiNC5QtmKt8mQwaexicBwnup6D4HrXMPb4PEWhivGPBbIqjbwxFl6RJ8EwF44v7p1JO2fJHNvoflhlFsKjmcLgKytxvwia8LDg8U6uQOVOH3C5nbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776151; c=relaxed/simple;
	bh=/6cXQq04PDsqKNozr1Zs2szmjUqgC95jeo6UDpqWATI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp+87OZRT9vRO1ZQUwvd+fTbiksg78OvzkdVCvELoz3lJUcptUcREqKqKztw8ZOAxE704RHLrBUGm3eO5+G4OmAfxcVqmISiH7lM2dB+3XIaBCgR3aF8M+gAc8IwCRVzif2hWHIRuPH2xfB+GqZ36eyXHqi32QlnMalFhQ3VunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fms6Bq2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E39BC4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776150;
	bh=/6cXQq04PDsqKNozr1Zs2szmjUqgC95jeo6UDpqWATI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fms6Bq2YkguId2OjtlYz/JE921//0f6f0u/3fG/APzwiFywck5E4LuI/Rh4d/oRLT
	 EQpeJ7qy2mHoa95dxXo7j8lnhPy//6IunCb9/gZmOHz+hm+bHyHGuWldfoMqix0hEm
	 yRIGMW7wcWRZ3SeL+IBm7jZ4BFF6rk5qtuwA90XnoFMbwBvHbQ1YWLAwxK7OFsePxS
	 fDTVHGVbtYP6VBa7wz1mCfd5xCgvDqQ6vv5jsF0FCxWJ1Avt7PAwk7vE3RDuVRvw6U
	 RIHBXfU2R6i16TBSw/fXlQ36NqRm2frkYChNh8UXAlVYIV27GJibiEVJHTErcsZ4LH
	 ZgS9OiOXYTxQA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: record new subvolume in parent dir earlier to avoid dir logging races
Date: Tue, 24 Jun 2025 15:42:14 +0100
Message-ID: <5d51d6c1f411655e67c7af87c9336ccaf5ccd6a2.1750709411.git.fdmanana@suse.com>
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

Instead of recording that a new subvolume was created in a directory after
we add the entry do the directory, record it before adding the entry. This
is to avoid races where after creating the entry and before recording the
new subvolume in the directory (the call to btrfs_record_new_subvolume()),
another task logs the directory, so we end up with a log tree where we
logged a directory that has an entry pointing to a root that was not yet
committed, resulting in an invalid entry if the log is persisted and
replayed later due to a power failure or crash.

Also state this requirement in the function comment for
btrfs_record_new_subvolume(), similar to what we do for the
btrfs_record_unlink_dir() and btrfs_record_snapshot_destroy().

Fixes: 45c4102f0d82 ("btrfs: avoid transaction commit on any fsync after subvolume creation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c    | 4 ++--
 fs/btrfs/tree-log.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5068f1fa86f6..aa8cefadf423 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -666,14 +666,14 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	btrfs_record_new_subvolume(trans, BTRFS_I(dir));
+
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	btrfs_record_new_subvolume(trans, BTRFS_I(dir));
-
 	d_instantiate_new(dentry, new_inode_args.inode);
 	new_inode_args.inode = NULL;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 95b89ed9fd6c..7ccf513d7ec8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7454,6 +7454,8 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
  * full log sync.
  * Also we don't need to worry with renames, since btrfs_rename() marks the log
  * for full commit when renaming a subvolume.
+ *
+ * Must be called before creating the subvolume entry in its parent directory.
  */
 void btrfs_record_new_subvolume(const struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir)
-- 
2.47.2


