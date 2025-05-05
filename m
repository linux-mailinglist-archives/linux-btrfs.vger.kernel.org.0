Return-Path: <linux-btrfs+bounces-13695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1BAAABD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6551890749
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC93B5B3D;
	Mon,  5 May 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4v1CglM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC23984B8;
	Mon,  5 May 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486449; cv=none; b=QGJEf57VIk4+UtJ4tdcw+ww2wNdHw1vrtirnc0KEvbODX2xtghRjlsbixL5hJTrsWo3ol+iJOrpH2EF1KvPHoQ4LHkquwvzLQ21iqmBB+bjV0WFDBeAPEkKMPUxwhJETqpENLMurxVmotcAy7MddQHxhMfhGgNwbDyaLP3/P0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486449; c=relaxed/simple;
	bh=6K1W7Zy3vyBKZTLpth2DPhBesAHtGw1EAG+78Ae1Obo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZLS0/a11x0a3MTZIqNL0Y5lvNRxqqm0yGkyL0BNjQmRglfYtmboo4nVX0OCrp5wrvN35DJMpHubFEStytRwPgSN2IYEabPZir4PUtcPHd54D4WoADKsnImYOUw6guJxFMCcW8nt9uMLWDU8fAuilrgwUXSw5XYhHBTvRkNHPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4v1CglM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05709C4CEEE;
	Mon,  5 May 2025 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486448;
	bh=6K1W7Zy3vyBKZTLpth2DPhBesAHtGw1EAG+78Ae1Obo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4v1CglMjj9QI7XfmZmBDS1uA1qKhnSwcQ4b/Ghd0fYlelsurt0FsZU1b7niGnHE7
	 hrimtXkpmsy9KwHklaNY4Cvy3crWR4M/Rdrthq4A2tYRPkVXDWjKtItb42jD+FftvT
	 YohhtMV92Z4OqQhY5LHhRmAUOA1YJ7UXCCkpKnb3L21oDxVmvOzdtfdr5STWInIRRJ
	 cqO530/uZ4lvWd1/0ZeA576goYDgju4bIV97Folz0BX6/euV3PQddQtMbYq9LDKcCv
	 gTasmdvLLIZz+ougye/hUsm5gKb6ocECaTd1zgFaPoyqV3nQ/af+Lb96GaMejn3e2B
	 hCwVFhX1m3hVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 034/212] btrfs: make btrfs_discard_workfn() block_group ref explicit
Date: Mon,  5 May 2025 19:03:26 -0400
Message-Id: <20250505230624.2692522-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 895c6721d310c036dcfebb5ab845822229fa35eb ]

Currently, the async discard machinery owns a ref to the block_group
when the block_group is queued on a discard list. However, to handle
races with discard cancellation and the discard workfn, we have a
specific logic to detect that the block_group is *currently* running in
the workfn, to protect the workfn's usage amidst cancellation.

As far as I can tell, this doesn't have any overt bugs (though
finish_discard_pass() and remove_from_discard_list() racing can have a
surprising outcome for the caller of remove_from_discard_list() in that
it is again added at the end).

But it is needlessly complicated to rely on locking and the nullity of
discard_ctl->block_group. Simplify this significantly by just taking a
refcount while we are in the workfn and unconditionally drop it in both
the remove and workfn paths, regardless of if they race.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/discard.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index bd9dde374e5d8..3ddd0c24a94ea 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -151,13 +151,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_eligible_time = 0;
 	queued = !list_empty(&block_group->discard_list);
 	list_del_init(&block_group->discard_list);
-	/*
-	 * If the block group is currently running in the discard workfn, we
-	 * don't want to deref it, since it's still being used by the workfn.
-	 * The workfn will notice this case and deref the block group when it is
-	 * finished.
-	 */
-	if (queued && !running)
+	if (queued)
 		btrfs_put_block_group(block_group);
 
 	spin_unlock(&discard_ctl->lock);
@@ -243,9 +237,10 @@ static struct btrfs_block_group *peek_discard_list(
 			block_group->discard_cursor = block_group->start;
 			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
 		}
-		discard_ctl->block_group = block_group;
 	}
 	if (block_group) {
+		btrfs_get_block_group(block_group);
+		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
 	}
@@ -469,9 +464,20 @@ static void btrfs_discard_workfn(struct work_struct *work)
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
 					&discard_index, now);
-	if (!block_group || !btrfs_run_discard_work(discard_ctl))
+	if (!block_group)
 		return;
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
 	if (now < block_group->discard_eligible_time) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
 		btrfs_discard_schedule_work(discard_ctl, false);
 		return;
 	}
@@ -523,15 +529,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
-	/*
-	 * If the block group was removed from the discard list while it was
-	 * running in this workfn, then we didn't deref it, since this function
-	 * still owned that reference. But we set the discard_ctl->block_group
-	 * back to NULL, so we can use that condition to know that now we need
-	 * to deref the block_group.
-	 */
-	if (discard_ctl->block_group == NULL)
-		btrfs_put_block_group(block_group);
+	btrfs_put_block_group(block_group);
 	discard_ctl->block_group = NULL;
 	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
-- 
2.39.5


