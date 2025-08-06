Return-Path: <linux-btrfs+bounces-15895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5815B1C4A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EC118A783C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5028B509;
	Wed,  6 Aug 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT+K7vBN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496628B4EF
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478700; cv=none; b=Ihx2Rip3m01uHZ1U5bWxXTttbizSiuNAVRl2H6xP/RJboWrc9xF9f5GLTwBSarU19ypNHrS7gWzcx9lu3aYTHD6vRaQJjr7SOCRXjN5ztkGPh/yL5KKkiA+We+0PGX8sNEwR5BcuIaxfCB7vyv37HwRajbKyNmIaZBI2ATIdey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478700; c=relaxed/simple;
	bh=9QvwMiYaa4OxL71ekWKPsDxO8tGjXORp1sx13BmMBsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV0wBMcHSxQe5KHCQM4sXvzGyGhxnA7APJ12EUGQjyIOHP969HtYh88EWDBqjOkycvcUsw08Bhl7GXAZAs8T/IV112DWyr44mZZYWXrwjo8ejSTq0VcJLa5Nt/NQWiqHV+uKacOPE9kUNZS7iupbsa+/Ts88L/NTMEAQJDhWpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT+K7vBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BEAC4CEF6
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754478700;
	bh=9QvwMiYaa4OxL71ekWKPsDxO8tGjXORp1sx13BmMBsU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CT+K7vBNLyJgc5oJwX6/v9Jf8aymuhcQKne21eGMfV+YeJ/1o3KZ9wK4GLbj6aZLR
	 5dzvqJ41pdiYuS7u7ImHy8Q6IVasjC0v/Bdf9RFKRZ9NeD4aBtN56MRdnhhD5jyTgj
	 PaE932PUhLhOHUwbOGVsWHjt6LsMpDi8188p4Y8+Jr8n6VBA1QHsoOu35op6k0UiLL
	 tGQ5J5IMeS2+ZkPvhVT0fU2Ei710bG8L4kOE8Tq5Ad1nY0ZhF4uxZKa04AfKi+2azw
	 QUoNcKx0qPO58tT6E42U/T7nTY31SHCVzZnPa9xflmwOikqhyQNfg7U7XYkyOgsO9m
	 4SojKH41AnjyA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: avoid load/store tearing races when checking if an inode was logged
Date: Wed,  6 Aug 2025 12:11:32 +0100
Message-ID: <963ec3b60aa3b6fa9b7192bc198cbee060d33ecf.1754432806.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1754432805.git.fdmanana@suse.com>
References: <cover.1754432805.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At inode_logged() we do a couple lockless checks for ->logged_trans, and
these are generally safe except the second one in case we get a load or
store tearing due to a concurrent call updating ->logged_trans (either at
btrfs_log_inode() or later at inode_logged()).

In the first case it's safe to compare to the current transaction ID since
once ->logged_trans is set the current transaction, we never set it to a
lower value.

In the second case, where we check if it's greater than zero, we are prone
to load/store tearing races, since we can have a concurrent task updating
to the current transaction ID with store tearing for example, instead of
updating with a single 64 bits write, to update with two 32 bits writes or
four 16 bits writes. In that case the reading side at inode_logged() could
see a positive value that does not match the current transaction and then
return a false negative.

Fix this by doing the second check while holding the inode's spinlock, add
some comments about it too. Also add the data_race() annotation to the
first check to avoid any reports from KCSAN (or similar tools) and comment
about it.

Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9e12447f3e0e..654d6912eb46 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3531,15 +3531,32 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
-	if (inode->logged_trans == trans->transid)
+	/*
+	 * Quick lockless call, since once ->logged_trans is set to the current
+	 * transaction, we never set it to a lower value anywhere else.
+	 */
+	if (data_race(inode->logged_trans) == trans->transid)
 		return 1;
 
 	/*
-	 * If logged_trans is not 0, then we know the inode logged was not logged
-	 * in this transaction, so we can return false right away.
+	 * If logged_trans is not 0 and not trans->transid, then we know the
+	 * inode was not logged in this transaction, so we can return false
+	 * right away. We take the lock to avoid a race caused by load/store
+	 * tearing with a concurrent btrfs_log_inode() call or a concurrent task
+	 * in this function further below - an update to trans->transid can be
+	 * teared into two 32 bits updates for example, in which case we could
+	 * see a positive value that is not trans->transid and assume the inode
+	 * was not logged when it was.
 	 */
-	if (inode->logged_trans > 0)
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == trans->transid) {
+		spin_unlock(&inode->lock);
+		return 1;
+	} else if (inode->logged_trans > 0) {
+		spin_unlock(&inode->lock);
 		return 0;
+	}
+	spin_unlock(&inode->lock);
 
 	/*
 	 * If no log tree was created for this root in this transaction, then
-- 
2.47.2


