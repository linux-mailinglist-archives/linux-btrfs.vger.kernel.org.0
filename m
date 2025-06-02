Return-Path: <linux-btrfs+bounces-14368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D74ACAC85
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117B01960656
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03452046A6;
	Mon,  2 Jun 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZhEiufA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308F202984
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860401; cv=none; b=BRvwjK7bMA/UWunw1ZGHFbuJOtDn9Duw4qRQgjl/FGwfVuKLDDcVqS32n1UzNCTxZlytvUieJeaylyST0ARw+Ng1tlnSUMYwrk9Pxr9EKqhNiA4MCFP7LN+g38wdBmfAOvCoZPaXCJs2IrkcY5DaKawVtWU41zRViP9tVAgOIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860401; c=relaxed/simple;
	bh=NO88n1tVWSvZDXLzMhlH5xq7AsQDEgCow+JnJohUOcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDGGYgz/8dHoefxNzLUeRl30ZyIhVb4ZqouiaRw0kDtW4nDrhy7hN7KXDY7Pox6R5fL8lWhvLRweS3vsaT43Sshz/1QPUCcieHFWep3cvvcQZCUl4fq21phqwv1YgKUC2EH5y1TNMX1LInl7Nufq1zzcRYQcLoS1Dv9rt789ODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZhEiufA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1911DC4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860399;
	bh=NO88n1tVWSvZDXLzMhlH5xq7AsQDEgCow+JnJohUOcs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oZhEiufACGqOQs7GHH+FwV8b20iVPXbTWfUvLu21GyyvmKEp1trDBeTG4HUFlJ/N0
	 OR+A/uljvBKLfQF/bCwZ6gciAJ07Uoxea7pJVhhG9rXa3PwfSoWCdqn1ozrKre5Xnf
	 KZ/uNFkSS3rCsVywfA6B7rQWebtcZ6a493G1Pd3hC5CU/1xXPLSOmI5eb0aXL88vd9
	 GGq47y7kSF7A23vVKfqzwwHVdSRPQ0VSloKsWYtALEe7YQwXe28keZRJm/gQRg3gr2
	 nqErtherJx5qgySsDhafFEZREWdXA5AtPvNLtSRYJafLWsHoqNPD25LH3uUcYvNgxr
	 8JzVQZJOStJww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs: assert we join log transaction at btrfs_del_dir_entries_in_log()
Date: Mon,  2 Jun 2025 11:32:58 +0100
Message-ID: <938300615359149f88d9738f53792183ad7e9ebe.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are supposed to be able to join a log transaction at that point, since
we have determined that the inode was logged in the current transaction
with the call to inode_logged(). So ASSERT() we joined a log transaction
and also warn if we didn't in case assertions are disabled (the kernel
config doesn't have CONFIG_BTRFS_ASSERT=y), so that the issue gets noticed
and reported if it ever happens.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4f0a86805dc2..14506a09f28e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3473,7 +3473,8 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	ret = join_running_log_trans(root);
-	if (ret)
+	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
+	if (WARN_ON(ret))
 		return;
 
 	mutex_lock(&dir->log_mutex);
-- 
2.47.2


