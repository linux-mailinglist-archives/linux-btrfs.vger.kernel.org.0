Return-Path: <linux-btrfs+bounces-16720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5240B48933
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3597A9C90
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030562FC893;
	Mon,  8 Sep 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CumfBwWE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470662FC025
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325234; cv=none; b=Zyvra9Qlx9c7bSguSHhTObYciS/ipfYxQjIYR+EtPW4DglXhEZ9keAAaru7Mqnhbeq6O3eohCzxkgqjzjrPCJgVzuoC1SpRvW3aqGHxOfCnFrjWpbgbLOCAOtYbsXOsPlw8QcBQ5NGfcY/ksIwT5XRWyr4mdm1nOZ3jbRds3e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325234; c=relaxed/simple;
	bh=HT3X/DitzgDCdtjzQErmHJjrkNJGn/qUHuNGLS7EJN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaRoEnB9+H3oXiaT2UIdx+jp/9mHacMTtJyTTgHpMDICP2UG3x0qnGP+Ry+2KaexJiajx1eYuGCq1/jg35N6q+e3G+14qtmvnr3/6lXQ6/+3B3nt6UkfD0hN+03jW45SpJa1J4Fp6VQ0OS/PuPgzZdfZijIWTbfIciyD5PBkSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CumfBwWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6838C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325234;
	bh=HT3X/DitzgDCdtjzQErmHJjrkNJGn/qUHuNGLS7EJN8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CumfBwWEVH+eOUc3vIkeRrpAnYHOxR3/Zi63X9fWswoojUbQvDXGMqK2bDB/uAeRs
	 K8oUftot5saxl8dN8FMXDKaii5+zsaV3Wt54rhgGE2Xkz92+af9v8InuFQ9i8YO1m3
	 NJhtj3Tc4hItyCXvpIcH1KpWHiAXkDG3mYpbd5NNI/UYMvHsN0UvaCAni3Y+JVUh/t
	 GwoyZmx+UUR/YXchcfbYIb893qRS239hWLGoHnzPJDljKY96kZmkaIv1qMXejaYQaF
	 qDsNR5nKpkQEwJ5YZ/Fp7OG4wsYx5dW4K0xf1k805a7pYq32Pc0XzD5rJjosp+r3u5
	 LXDmL2tIyNrtQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 25/33] btrfs: avoid unnecessary path allocation when replaying a dir item
Date: Mon,  8 Sep 2025 10:53:19 +0100
Message-ID: <c7c3a8eb373ab6b35c537ba399ea153ca388d3db.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to allocate 'fixup_path' at replay_one_dir_item(), as the
path passed as an argument is unused by the time link_to_fixup_dir() is
called (replay_one_name() releases the path before it returns).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a912ccdf1485..de1f1c024dc0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2147,18 +2147,10 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 	 * dentries that can never be deleted.
 	 */
 	if (ret == 1 && btrfs_dir_ftype(wc->log_leaf, di) != BTRFS_FT_DIR) {
-		struct btrfs_path *fixup_path;
 		struct btrfs_key di_key;
 
-		fixup_path = btrfs_alloc_path();
-		if (!fixup_path) {
-			btrfs_abort_transaction(wc->trans, -ENOMEM);
-			return -ENOMEM;
-		}
-
 		btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &di_key);
-		ret = link_to_fixup_dir(wc, fixup_path, di_key.objectid);
-		btrfs_free_path(fixup_path);
+		ret = link_to_fixup_dir(wc, path, di_key.objectid);
 	}
 
 	return ret;
-- 
2.47.2


