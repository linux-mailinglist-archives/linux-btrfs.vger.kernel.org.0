Return-Path: <linux-btrfs+bounces-11368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38247A3001A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 02:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6331886EF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C41DA0E1;
	Tue, 11 Feb 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEEyZt+b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA311D6DC4;
	Tue, 11 Feb 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237403; cv=none; b=jkpOLKghiM8kRlUqOnGIed2Sh7tkweb2hulPeDK/pW4x7p6uoep22i8LYSDwm47eeXCjITw0L+D3Ia3cx4A+uXsqeVl8e8E6RZXyRTh/Tm2DAtUiKV15+oi7dm+8ZBlTjxtWREe6NX91r3oACtnVWFwJ7KsbKbwJZSbGpEDsGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237403; c=relaxed/simple;
	bh=gKW0kP7yL+Rw5rf7hyeBNDzaJZGvcYRZqN4DEP2WTwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWiISYbCxCvWFTxgxYAjUGhCW8NB6xgsYjPTAAUVCqWjJ4KoWMT5fA4UE35MfSVm3vnEDP5tGwrHTBGlvHYwAHGnk4YDq5Y7HMt62RVE2QH6kR9VzjUAAPe97vnHlr4eNFUkRrueiG/Nm6fKw2Ja3WfUHPulM/JxwLM2jpGVpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEEyZt+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B4C4CED1;
	Tue, 11 Feb 2025 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237402;
	bh=gKW0kP7yL+Rw5rf7hyeBNDzaJZGvcYRZqN4DEP2WTwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEEyZt+bvCqhzRYgyDprGq+l3FtwxopigNYZCiVqIQ9mfwkzjqOv7f1Ri46TiPnyo
	 Hx22O11HLdWp92zf5RlltoPa7kfXBnDvrCsSjeCIdD2AAV1FO6PmrNrAkbfRCptU8P
	 a3IvRv5MYDJ8L7Ku6XKqjoHlZ3SLo9Up2sXpIrKVyVFWLXWYk8zq7805nkKUaEnNQn
	 wwVSspdILX/9loPpdw/wRFaZGcafc9TbfqbVJS581q++G5riXA/tdvEkdoIgnFnggx
	 4c9kdqJI/UJ0BexALfUivQ/yrsdqkU0Ok+qUccmvSfOZD70QwK5BD6kFWgs3yoOV3E
	 YJ7cIfW8zRKdA==
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
Subject: [PATCH AUTOSEL 6.13 05/21] btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop
Date: Mon, 10 Feb 2025 20:29:38 -0500
Message-Id: <20250211012954.4096433-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
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
index 993b5e803699e..f6a024744ba0e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1898,11 +1898,7 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info, u64 su
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


