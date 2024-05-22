Return-Path: <linux-btrfs+bounces-5207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DB8CC351
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E928184B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F812942F;
	Wed, 22 May 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIcJrzP9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AF25753
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388604; cv=none; b=AiRxzqVKvlM8YBfzlBe/z2p2TSXVLeN7DZBPt0r3mxu8vhSBUnbiQzvy6Oej3mkZRAUFw4xqCEJpTAQzDDDWkRHfF2LxrXUI/fr5aN3SpJW3qgnTCiU8sdWLkOpNQGj92KT4STGZ+VsBIANksfW/4halbdCMwDS6Z0pYrG3VJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388604; c=relaxed/simple;
	bh=Jk2pLpQ4kQ62gRmVrx9XMVZ2M/g3S6QHiJjx6Mmh/B0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0qOXJ21HXDSjGhhrTcBvVd55E1Etzj657ffqVkL8zRWfn7OkNWF/8UHFol7KcnkPME41dqETNvRa6p8jhGvPXIn7AKA9cQqnxufxqHsyvPGwajvA3ZhTvRFq011Q8juojyvmi27ck2lYIFx3s390S1f9lmc438lGlnWeFO5Xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIcJrzP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38696C32782
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388604;
	bh=Jk2pLpQ4kQ62gRmVrx9XMVZ2M/g3S6QHiJjx6Mmh/B0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RIcJrzP9tq8UcQbVl+drSybzXYKdP9ZqbcSRBFhRoavR5m5e36FiCYYV+f2rMzOsK
	 GSGNkDHVdEJxvQUIWWd52C6THDsEEt1XJWcUrqpaozX3GORYUnHr/lb93zv8dwsN6T
	 VGgk8y+bXNZ82QCNZFMsXM8kaVRHCu3faAFXEDHMqYeH6BU1a03mTqQCB1lfjkI2Du
	 67rC8T86AXr0pEveJ8agx52hfLZGm6Bipv0k+qqYMO3nBAkCPaUwFAxX6GjfzKlfK0
	 v6E82R2ZnJiuQgm4gISml/94UYSVEM01hQesxPUPciPIeIqTsJmmMRMSxkLKvPn3bw
	 cRit327FuAlBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: scrub: avoid create/commit empty transaction at finish_extent_writes_for_zoned()
Date: Wed, 22 May 2024 15:36:33 +0100
Message-Id: <ee253f2941587230ad04dcb5386cfcd04e20066a.1716386100.git.fdmanana@suse.com>
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

At finish_extent_writes_for_zoned() we use btrfs_join_transaction() to
catch any running transaction and then commit it. This will however create
a new and empty transaction in case there's no running transaction anymore
(got committed by the transaction kthread or other task for example) or
there's a running transaction finishing its commit and with a state >=
TRANS_STATE_UNBLOCKED. In the former case we don't need to do anything
while in the second case we just need to wait for the transaction to
complete its commit.

So improve this by using btrfs_attach_transaction_barrier() instead, which
does not create a new transaction if there's none running, and if there's
a current transaction that is committing, it will wait for it to fully
commit and not create a new transaction. This helps avoiding creating and
committing empty transactions, saving IO, time and unnecessary rotation of
the backup roots in the super block.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/scrub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 376c5c2e9aed..6c7b5d52591e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2446,9 +2446,13 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 	btrfs_wait_nocow_writers(cache);
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache);
 
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


