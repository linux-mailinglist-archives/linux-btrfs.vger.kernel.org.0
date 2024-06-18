Return-Path: <linux-btrfs+bounces-5790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E924790C937
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069591C2301A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F014015DBA1;
	Tue, 18 Jun 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWN1PC53"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955C73478
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706125; cv=none; b=V5dhhapJziJAq+ks9g+8LRB7lEpRWnHCE0jBY9Xu+X6e+CBBd29ttXIBx28sK+6MJboGJgmDEXC+c3soLZmb849ClV7gnPhtJlLexUW1NJXsopm1NrKyWn14AbzFazUynqnqRoPPWQO6xuHoUI9pLhXAAmsRT7S4npxcK6GXBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706125; c=relaxed/simple;
	bh=DjHLiXxBttP5nqNb8/oYig4ZJwfRq0G7zB+Ov3JhWWI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vyeuo2YHrzHE4MagQe+1+VmtUDcNacQuKuJONnOMRFAOyIpLFvU7rI0BJhpwnTYWOFGe2w7LDd6Y5Rytk5wTwFI2UFzTWjuEOa34dbt/2JzzYTmtN6XOYvVRXa7KUd9iJAZcIb1Zqkfrr/z7gAMEOM/XUmINvPfO/TvRCZBQkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWN1PC53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DFEC3277B
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718706124;
	bh=DjHLiXxBttP5nqNb8/oYig4ZJwfRq0G7zB+Ov3JhWWI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cWN1PC53oGz4qkY+Jru0+NIixQv0aYrkGuY4us6jTLy6pbGhC2UmdD7SzrjBDlMHT
	 lV87951t/6SiTUIU9es+2BArMuA5SEEwEf0i48cvB30dMd9DVO4q+VKHsNPAXZM5v/
	 rns8blYeN2mUmj327L7oQecknQ+QgX4f/6S38U7eM342rWrzlwOrXxYbdvMdtUzW8y
	 DoPiTwDXf5Px42ArSXtzBABZIQBsodlmFPKHNSimeraPmgJRU+Iqz7SmnZcbeUPzNZ
	 O3wjpURenY8zwGyPhHh8je92KKuDt06rnaPfon2E79RJRewK1lr/Oc9il/dWZYyucN
	 GG8deFlWlgHPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: remove NULL transaction support for btrfs_lookup_extent_info()
Date: Tue, 18 Jun 2024 11:22:01 +0100
Message-Id: <a35d5db1edc40dff98f30a46ada610ec4604114d.1718706031.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
References: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
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

V2: Remove the transaction abort logic check for NULL transaction too.

 fs/btrfs/extent-tree.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 58a72a57414a..21d123d392c0 100644
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
@@ -171,11 +166,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			btrfs_err(fs_info,
 			"unexpected extent item size, has %u expect >= %zu",
 				  item_size, sizeof(*ei));
-			if (trans)
-				btrfs_abort_transaction(trans, ret);
-			else
-				btrfs_handle_fs_error(fs_info, ret, NULL);
-
+			btrfs_abort_transaction(trans, ret);
 			goto out_free;
 		}
 
@@ -186,9 +177,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		ret = 0;
 	}
 
-	if (!trans)
-		goto out;
-
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
@@ -219,7 +207,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
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


