Return-Path: <linux-btrfs+bounces-11369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C1A30063
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 02:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB5318861B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD551F0E35;
	Tue, 11 Feb 2025 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bds69DQr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139F1F03FB;
	Tue, 11 Feb 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237456; cv=none; b=gS4A/gP8epCyd4iGDqkYyMc9y9Q6Lu+xzvZiEGbakA4qMmlXNMOKYklaZEJgX9PqTj+6KTPOzGXfxXXigYt/cF1G+CLPNkNc/85pdygUrNouWEl7uh++CH5Z4UUilDQenGpWErrvWi9xvinVJ7FXraCTLHs1E1ZK2/PTMDm3SEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237456; c=relaxed/simple;
	bh=WVNXBusgGVJ6fi3CBC6UXvcYQ1dn530rgquMYqU08SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkV8rGz/JP/ajxzj5gWzTzZEpa7XAaDEgCguTKvUcBcHGg/mV0mkiMzgFRcMYd+ldxLzW6l/07FToBqcdZIrPqGBJSkh62U1xGc7F8S/mNwclnlTIbvZxGP8C6DrdXaUr7qTgcmaRP6G9pQ+XKm80nInEOnoMbR7ovkMSCs4Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bds69DQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10870C4CED1;
	Tue, 11 Feb 2025 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237456;
	bh=WVNXBusgGVJ6fi3CBC6UXvcYQ1dn530rgquMYqU08SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bds69DQrhWFbDNMdp3/EKckvQb6X9a3buMIfu/bwgGLS39kOp5LscY6Ri9jnaEPfD
	 BIklQRL6ALnBiH1c3RB/Vh2aUTbCVxugr0Aup2/dVIjMAfqbaw4OxJv2+iGgRE1qVS
	 nuz7e462dWPUpmIWIP9mekd7tZ4M9t37UUaSkyqs/HPAyccn/RePRMo6zJ0/NCyr+J
	 WDxHsX6yX4fEx2HjbZ9AU3C+f0+KSOj8K75zNSISU9Uf2lvSFxsvLb1H5ejCyCe6SA
	 Y6RtsXaAWf05H3V419+X551AjMQSGTqnEUX9k1E15euesHMzpQDmqVXznInymogn5e
	 J5D5yMfa5PF1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/19] btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop
Date: Mon, 10 Feb 2025 20:30:33 -0500
Message-Id: <20250211013047.4096767-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit fdef89ce6fada462aef9cb90a140c93c8c209f0f ]

At btrfs_qgroup_cleanup_dropped_subvolume() all we want to commit the
current transaction in order to have all the qgroup rfer/excl numbers up
to date. However we are using btrfs_start_transaction(), which joins the
current transaction if there is one that is not yet committing, but also
starts a new one if there is none or if the current one is already
committing (its state is >= TRANS_STATE_COMMIT_START). This later case
results in unnecessary IO, wasting time and a pointless rotation of the
backup roots in the super block.

So instead of using btrfs_start_transaction() followed by a
btrfs_commit_transaction(), use btrfs_commit_current_transaction() which
achieves our purpose and avoids starting and committing new transactions.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4fcd6cd4c1c24..887e34559a1fa 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1899,11 +1899,7 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info, u64 su
 	 * Commit current transaction to make sure all the rfer/excl numbers
 	 * get updated.
 	 */
-	trans = btrfs_start_transaction(fs_info->quota_root, 0);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_current_transaction(fs_info->quota_root);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


