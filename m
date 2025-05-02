Return-Path: <linux-btrfs+bounces-13614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A38AA6FA4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DFE1BC7C0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605D242D7A;
	Fri,  2 May 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndcf2PQk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10723C500
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181835; cv=none; b=p7wcuTLa521HUPh3YpE0kd30iIrfcKDubPljULm5qXJH2O10eCfmA0Vyr0TkwdykFrPHNP1BeC/ysF3szDq0T2RlehVZunDPy0Hnl65pjaKWdhYOhk7J1SCqFrFd3tb5GsAGum5uF7sy/6e/njSo2HhfF0z1D6lkMlR07sBmWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181835; c=relaxed/simple;
	bh=/FtFwF1sMIYivS9d52yZjGobz1vv74vkMPHO8GPoUVs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHPuwla4FfEX9ZpMNXGlmR2RG/q9UCtXd24vIFTYjmV/PI/RpwN94pxTo/IXUzHA04+nxW5QXqswIZoNFcP2g+7pDexUzTXL1MdajqynvWiGQea7T4ArnZfCKPeRTRVHwRKryJOXj2lGFAAGmc2HQMp7u1+xLNy0fkBDG2F3k1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndcf2PQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC390C4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181834;
	bh=/FtFwF1sMIYivS9d52yZjGobz1vv74vkMPHO8GPoUVs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ndcf2PQkxZ0+bunP1jDSHQPFHFozIXl/jcXDE2QX6y1o4bRqCOpbIVd7u2O5FXN4v
	 qRAmkuZbPcE1hJI/ifvF81qaDzBNFOdEVJu8aKNLPZXCStMhBnROsX8p/nZIcEgbfd
	 PXHLsJvrOaCfsKMdJijGtwpERNBfrH+zXES58mk16ayNku9qZtbn4rnSxQQaQrQW7d
	 yVE7ygBKeAuzc0iJbemuvfy7+3tahnbhNvEKOQx7qC4Xceq/oM7xKPKq4aLY826zjJ
	 fbTk9g7Teg0eG3Ibasaa0wXpzUKeiJnzKDAT69EfVk+d7IClFTDB8TYbyLqq5GLDqx
	 MOWYvWv7C1heQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: simplify getting and extracting previous transaction at clean_pinned_extents()
Date: Fri,  2 May 2025 11:30:22 +0100
Message-Id: <2407e8ba35d8e3bcdc740daa101f9d36531d7dde.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of detecting if there is a previous transaction by comparing the
current transaction's list prev member to the head of the transaction
list (fs_info->trans_list), use the list_is_first() helper which contains
that logic and the naming makes sense since a new transaction is always
added to the end of the list fs_info->trans_list with list_add_tail().

We are also extracting the previous transaction with list_last_entry()
against the transaction, which is correct but confusing because that
function is usually meant to be used against a pointer to the start of a
list and not a member of a list. It is easier to reason by either calling
list_first_entry() against the list fs_info->trans_list, since we can
never have more than two transactions in the list, or by calling
list_prev_entry() against the transaction. So change that to use the later
method.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e3b912d539e2..a41ca673ad1a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1418,9 +1418,8 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	int ret;
 
 	spin_lock(&fs_info->trans_lock);
-	if (trans->transaction->list.prev != &fs_info->trans_list) {
-		prev_trans = list_last_entry(&trans->transaction->list,
-					     struct btrfs_transaction, list);
+	if (!list_is_first(&trans->transaction->list, &fs_info->trans_list)) {
+		prev_trans = list_prev_entry(trans->transaction, list);
 		refcount_inc(&prev_trans->use_count);
 	}
 	spin_unlock(&fs_info->trans_lock);
-- 
2.47.2


