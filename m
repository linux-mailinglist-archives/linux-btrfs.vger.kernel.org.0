Return-Path: <linux-btrfs+bounces-5785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFE90C5F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB091C2131A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964413BAD4;
	Tue, 18 Jun 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOMnrlqN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9373478
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695979; cv=none; b=MvkyAn0/82+lnqSwMBgKlJcafxBHwNE0zkC2WHx3CV8jBRiVcBDgTFTbsBY5QYqGG5iuVeqicRIMXd9/3I+MZj1EABA+XxuQZw9zlJsWG+H3VgHbL90Xc+RtfX7KYAyZ7Ym2mwpjqfkCVhh14Aapi5X1sgUE7wYN90ugLUSIWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695979; c=relaxed/simple;
	bh=IHaCVm5LFddJTdDPSsMmGWZd8v6WGAhxHtJUEheYfj4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NyMwrmTCanCIOGgeTQe+BoZ6De+r8D9pQmtyn5/aquZrUPy/hwu6RiatUkq1CVHobJviMDSQ4K6BJ+io8QxYLz3B/+GBz9ifUSRIx3qOgXrl/48ASzomypBjPciKHSlZE5ARgni5bS5i0f7maTCskRAKdBcWmvZAbNxA/vViG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOMnrlqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B498CC3277B
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718695979;
	bh=IHaCVm5LFddJTdDPSsMmGWZd8v6WGAhxHtJUEheYfj4=;
	h=From:To:Subject:Date:From;
	b=tOMnrlqNTa7bXusteI4R6tMjKPWSSplwPQhA9/va6Iwn7Y8tycgzPooH7HmxfNaek
	 ttFdDGLo3Z9dFzAkP9RdTSIaCKk9xnxN7Wh8iUNWmXKueluNXIQ8ppYZ5LN+heqJ4v
	 0z1W/3jFdW3GkNgfwnqkABMfyhyuPNZLYX9TnlcKWJ8bTHHF6oCzwd+p1OMBVsaMs4
	 80miUsvUFjxXp6fqLCx0fiZG1MKASUasvz7WBPZGGXJoKqSSO6kZjQHqqP3NUEhyuQ
	 DqIMLEZATAG3BKOVKgugZYyIMgzB+3nNXL3pzB40P6EzFdDBvkU5zUqSCWpVE7WOjC
	 oG4p+Z+a7arnQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove NULL transaction support for btrfs_lookup_extent_info()
Date: Tue, 18 Jun 2024 08:32:55 +0100
Message-Id: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are no callers of btrfs_lookup_extent_info() that pass a NULL value
for the transaction handle argument, so there's no point in having special
logic to deal with the NULL. The last caller that passed a NULL value was
removed in commit 19b546d7a1b2 ("btrfs: relocation:
Use btrfs_find_all_leafs to locate data extent parent tree leaves").

So remove the NULL handling from btrfs_lookup_extent_info().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 58a72a57414a..a52e52144fa2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -126,11 +126,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	if (!trans) {
-		path->skip_locking = 1;
-		path->search_commit_root = 1;
-	}
-
 search_again:
 	key.objectid = bytenr;
 	key.offset = offset;
@@ -186,9 +181,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		ret = 0;
 	}
 
-	if (!trans)
-		goto out;
-
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
@@ -219,7 +211,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		mutex_unlock(&head->mutex);
 	}
 	spin_unlock(&delayed_refs->lock);
-out:
+
 	WARN_ON(num_refs == 0);
 	if (refs)
 		*refs = num_refs;
-- 
2.43.0


