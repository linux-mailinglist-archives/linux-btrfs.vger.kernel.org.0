Return-Path: <linux-btrfs+bounces-17137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B1EB9AED2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEBA32486E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B1313289;
	Wed, 24 Sep 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkMnH1nb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BE313D68
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732901; cv=none; b=ir+Q5m7xlihrn+Um/HfanjSVQlIFmotoAx1LRa1mcXQbZROXa5sO+fJWP0zMTLH7XLS+QX7visPcfTOhZuk4ao+mTkRfZzSqwU7eGnKObyrOAuFs1nzWw1o8V1JZRimWsQOS9xQJUakDapl/F3/3seGsA6dx2QBmDdcqc1P56yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732901; c=relaxed/simple;
	bh=gcQPrF1NxtEahCJTnK1OysOrIzn+6tg1fDuls6rKAtc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9BbOb2Rk1+6gDHOpMp2vozjDJ8lgwCMwWDYImDJoDyLq3J9WyCSQ5gN+yfSFRDvQqfJT7SyHzkTup0ZlgvCAA/qlnxIcDusy2JvGvYOLTdO+CAPHTYHWjw5JZqJep0KRKgpiYYpQP3VXToazRgAPNfcQyzzNR+L7LN9eSpz4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkMnH1nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C352DC4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758732901;
	bh=gcQPrF1NxtEahCJTnK1OysOrIzn+6tg1fDuls6rKAtc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kkMnH1nbvVRq3nBrvheAtYeQFPcPu3sMrhlH9QhQOEvSMGwyXYoEK+G/RURs54fRk
	 GPAWFMVMcxBOyNjMXX4LncPVAEGCywRhqbrkTwdKw9MKcbJcweyzzBtVRLSk3RxLat
	 SygPe2tLEkfdi9r9fFqIkpC4RAJa3wEPuXo7uZfZn9pqoPaupBc5eu2ha4G3OIXwNH
	 VGeY4c3mEXTVG3FEVHfCB2mZK1oRpJpKFpwBNm/kTkYJipFR5/cgaa7vHdnqWSBtmB
	 Kf+2xlkKel759urDs/vOTkOftU/8W52D7i0gNDSKXNyquMV0hzUECH5k4TR7UN9o2S
	 4hNiuMU/omqOA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
Date: Wed, 24 Sep 2025 17:54:55 +0100
Message-ID: <ae43088c97c0423deee961c58e9eca4c4aff2e88.1758732655.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758732655.git.fdmanana@suse.com>
References: <cover.1758732655.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When starting relocation, at reloc_chunk_start(), if we happen to find
the flag BTRFS_FS_RELOC_RUNNING is already set we return an error
(-EINPROGRESS) to the callers, however the callers call reloc_chunk_end()
which will clear the flag BTRFS_FS_RELOC_RUNNING, which is wrong since
relocation was started by another task and still running.

Finding the BTRFS_FS_RELOC_RUNNING flag already set is an unexpected
scenario, but still our current behaviour is not correct.

Fix this by never calling reloc_chunk_end() if reloc_chunk_start() has
returned an error, which is what logically makes sense, since the general
widespread pattern is to have end functions called only if the counterpart
start functions succeeded. This requires changing reloc_chunk_start() to
clear BTRFS_FS_RELOC_RUNNING if there's a pending cancel request.

Fixes: 907d2710d727 ("btrfs: add cancellable chunk relocation support")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8dd8de6b9fb8..acce4d813153 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3780,6 +3780,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 /*
  * Mark start of chunk relocation that is cancellable. Check if the cancellation
  * has been requested meanwhile and don't start in that case.
+ * NOTE: if this returns an error, reloc_chunk_end() must not be called.
  *
  * Return:
  *   0             success
@@ -3796,10 +3797,8 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
-		/*
-		 * On cancel, clear all requests but let the caller mark
-		 * the end after cleanup operations.
-		 */
+		/* On cancel, clear all requests. */
+		clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
 		atomic_set(&fs_info->reloc_cancel_req, 0);
 		return -ECANCELED;
 	}
@@ -3808,6 +3807,7 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 /*
  * Mark end of chunk relocation that is cancellable and wake any waiters.
+ * NOTE: call only if a previous call to reloc_chunk_start() succeeded.
  */
 static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 {
@@ -4023,9 +4023,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
+	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
-	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 	return err;
 }
@@ -4208,8 +4208,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
-out_end:
 	reloc_chunk_end(fs_info);
+out_end:
 	free_reloc_control(rc);
 out:
 	free_reloc_roots(&reloc_roots);
-- 
2.47.2


