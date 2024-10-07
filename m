Return-Path: <linux-btrfs+bounces-8591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A1993155
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C071F242E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871D1D8E17;
	Mon,  7 Oct 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCZMuruq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751E1D2714
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315291; cv=none; b=Q3IYk1vfmrb7B/UsZDHWxy+24MgyAepXIeGuzagCmGi6tpR1zuY6tcm5Fm0jM6x0+kprwfjG9PkFCilU1MUwy0dh5cekN7jCKn86qokf0jZHEHRf2yrR/GrmbP0rrff3ZMZzhhmEGswXaACEplKYnr7qa/chUKd0ONzvuV7xKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315291; c=relaxed/simple;
	bh=klqBF/JyD13M9xF/27vkVng1AJibZAdiT4K9gQDbA5A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=smj47q8tPY6hLL3tzTDL14/udxHoEMrJdrPCUsQh5n/pRR4vNZrDpQmQfVZh8TV21ceSQ2N2V6UghyHZBU6YzHVnLdUDx7uD7XjMeLPR6OifU6t3y5/RfXUdXHrapBE+CrPBVhoAI71VrxhJNFg3X63tGpKnD4mvC5OB4Cro8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCZMuruq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242DBC4CEC6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315290;
	bh=klqBF/JyD13M9xF/27vkVng1AJibZAdiT4K9gQDbA5A=;
	h=From:To:Subject:Date:From;
	b=nCZMuruqj9SEv4jDxZjyLQQdrwiIF0CwZBrGHjo2xKhAGWS842nGqp9pwtMtRKH6b
	 TIg3HwjFy9DR2ymg2tWF/zkLGMxQfAtIkWI+2K2qxI4A4nh7+Ratlvsg8sehx7Br0w
	 m6nyCCbXw06b2t5VtNIVrLVcgk6UfA6t+Wfr5fKH72hysuLAOmp4lxM2CSdWq4Y+vQ
	 lDQ45jokYlJjk8KjiqH6j1GvvehOqpDbpi9+HY2mkOnJC9+ZmlIjBtW30+dV9LwDSB
	 RGjM5Q1tmxlOu7cbJnFP91cwebdwjZ4DmD4GE/ST0lHfEaslXeZggUTbKa5Ry64xPy
	 eBv/cRkZ3tGDA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: run delayed iputs after ordered extent completion
Date: Mon,  7 Oct 2024 16:34:47 +0100
Message-Id: <2efe2794ecbfbfab1545a9341d3a1fb7464dc048.1728315195.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When trying to flush qgroups in order to release space we run delayed
iputs in order to release space from recently deleted files (their link
counted reached zero), and then we start delalloc and wait for any
existing ordered extents to complete.

However there's a time window here where we end up not doing the final
iput on a deleted file which could release necessary space:

1) An unlink operation starts;

2) During the unlink, or right before it completes, delalloc is flushed
   and an ordered extent is created;

3) When the ordered extent is created, the inode's ref count is
   incremented (with igrab() at alloc_ordered_extent());

4) When the unlink finishes it doesn't drop the last reference on the
   inode and so it doesn't trigger inode eviction to delete all of
   the inode's items in its root and drop all references on its data
   extents;

5) Another task enters try_flush_qgroup() to try to release space,
   it runs all delayed iputs, but there's no delayed iput yet for that
   deleted file because the ordered extent hasn't completed yet;

6) Then at try_flush_qgroup() we wait for the ordered extent to complete
   and that results in adding a delayed iput at btrfs_put_ordered_extent()
   when called from btrfs_finish_one_ordered();

7) Adding the delayed iput results in waking the cleaner kthread if it's
   not running already. However it may take some time for it to be
   scheduled, or it may be running but busy running auto defrag, dropping
   deleted snapshots or doing other work, so by the time we return from
   try_flush_qgroup() the space for deleted file isn't released.

Improve on this by running delayed iputs only after flushing delalloc
and waiting for ordered extent completion.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f68a26390589..bbc54dd154ec 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4195,13 +4195,20 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		return 0;
 	}
 
-	btrfs_run_delayed_iputs(root->fs_info);
-	btrfs_wait_on_delayed_iputs(root->fs_info);
 	ret = btrfs_start_delalloc_snapshot(root, true);
 	if (ret < 0)
 		goto out;
 	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
+	/*
+	 * After waiting for ordered extents run delayed iputs in order to free
+	 * space from unlinked files before committing the current transaction,
+	 * as ordered extents may have been holding the last reference of an
+	 * inode and they add a delayed iput when they complete.
+	 */
+	btrfs_run_delayed_iputs(root->fs_info);
+	btrfs_wait_on_delayed_iputs(root->fs_info);
+
 	ret = btrfs_commit_current_transaction(root);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
-- 
2.43.0


