Return-Path: <linux-btrfs+bounces-5204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBE8CC34E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6A1F243C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914521362;
	Wed, 22 May 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7u41+zW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C720DE8
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388602; cv=none; b=fYmxpQfGI4EgU0FbUuD02gBujTeLGoGBNwz3w8HOVaRbaoHAHpfeU2n6+41EwzGcKsvBzojsDKZIbBmcLXqZ2AGUGiEz40Vtjp9k2sjW6BGSKOteIflM98ErVuetfTF/1m1mkRBggS6c9TYZK0z/lbcbqUEQeDc+uSR8X4O84N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388602; c=relaxed/simple;
	bh=AlaVMhrGenbjgIxhogKFEKh3SPgAjYjsyy9wZ077veE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqOVpSGDcuLTa6qp57llyg9L5lUdj0ypYythEInYNCxQ3eFcMNoy9HYluX60bDPqCWZ5Y+fH8tTaLQmyE5qEwmFhTc9d31jq1E0D0dvES3l7p4hLGtUh+sftc1VZ207ErsQVtXue8A2ep02vpFkLn5KlW5K3f4uVtQyP60G5kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7u41+zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD4DC2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388601;
	bh=AlaVMhrGenbjgIxhogKFEKh3SPgAjYjsyy9wZ077veE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e7u41+zWnwvIjF+FGb4xQuYEpNg9dPSYNsyu8mzSCpPGL/hlEiwiNLzYDNg/84c1G
	 OLzG65hVxDgcfQssWuQ2af5iJdrrqlrdDufDyApwgGjtCFZCzEgYTTFQ4IuEotz0Uy
	 r6xF4TBVtPUAvNpkj0L3NGwKz1LixnBJ33PGN57ZX+hKxaoWC9oqjM6IptIr0xESXF
	 toAfO+K36Pg064pi/zbsPkJ3kilEScoRRHgeU3sF/PbZpkIF9vcod1TAJjeVJwvLwT
	 oDdmp2H2Rt4tVCkcBkEXrXDx+4I4gB36J+nRHGxPcmUZprfpIcFmWBGtIXV5zOELdB
	 kqsgev4LUC99w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: avoid create and commit empty transaction when committing super
Date: Wed, 22 May 2024 15:36:30 +0100
Message-Id: <89d1791f11c327236ff63ae24327b5e58522ce3d.1716386100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>
References: <cover.1716386100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_commit_super(), called in a few contextes such as when unmounting
a filesystem, we use btrfs_join_transaction() to catch any running
transaction and then commit it. This will however create a new and empty
transaction in case there's no running transaction or there's a running
transaction with a state >= TRANS_STATE_UNBLOCKED.

As we just want to be sure that any existing transaction is fully
committed, we can use btrfs_attach_transaction_barrier() instead of
btrfs_join_transaction(), therefore avoiding the creation and commit of
empty transactions, which only waste IO and causes rotation of the
precious backup roots.

Example where we create and commit a pointless empty transaction:

  $ mkfs.btrfs -f /dev/sdj
  $ btrfs inspect-internal dump-super /dev/sdj | grep -e '^generation'
  generation            6

  $ mount /dev/sdj /mnt/sdj
  $ touch /mnt/sdj/foo

  # Commit the currently open transaction. Just 'sync' or wait ~30
  # seconds for the transaction kthread to commit it.
  $ sync

  $ btrfs inspect-internal dump-super /dev/sdj | grep -e '^generation'
  generation            7

  $ umount /mnt/sdj

  $ btrfs inspect-internal dump-super /dev/sdj | grep -e '^generation'
  generation            8

The transaction with id 8 was pointless, an empty transaction that did
not achieve anything.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eec5bb392b8e..2f56f967beb8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4156,9 +4156,13 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 
-	trans = btrfs_join_transaction(root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	trans = btrfs_attach_transaction_barrier(root);
+	if (IS_ERR(trans)) {
+		int ret = PTR_ERR(trans);
+
+		return (ret == -ENOENT) ? 0 : ret;
+	}
+
 	return btrfs_commit_transaction(trans);
 }
 
-- 
2.43.0


