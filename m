Return-Path: <linux-btrfs+bounces-11644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A79A3D7B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568D53AC3C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539A1F37D4;
	Thu, 20 Feb 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5fwQZF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B91F30A4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049497; cv=none; b=qnF6mqD12hGaJoo2NYVVcAfwrzwsx1LccpWSmTIyekUYvcSqVsbohboTDNs5R9qu3CyO+LtGZV4KaAZaKYzJjqM4XO9KHaT4pcTQGfuNz/lQKV7g9wiL3jjRNB6OGV8ouJkyuXVc2wuMlzIWhZWAenBTyHEbkUEJuwztMm58/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049497; c=relaxed/simple;
	bh=ChBKnQAulfXbutwRNaXkCCJf8hYyc7teGSzKCz2J0jg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbbdgb46v4aG9WFLahGpalWeEQqqlQBWzhK5jfzpvDQCQ8i34lvjl8dr3NnGXce1KhaAqBObHOgCaah5a5AB72ckB3Mg5uDmrFcFuY1wYg1wV08Z5qtHk2IQA3WZMLNaK3yHGRPP6yxohu+/B6y68kbd6kLOiuCVrB6Q6mGVf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5fwQZF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDFC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049496;
	bh=ChBKnQAulfXbutwRNaXkCCJf8hYyc7teGSzKCz2J0jg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q5fwQZF9JwZIkVsDMA5KVmmU6+pzodZ2Z/ME+N40yR9mHxXueK0hDCxO//zPfobD9
	 y14Ag/tlEp735z+hgMEXy6VXx27zW9aQhbvPGTqeE0ei7puAuz95sdbFOpXJuLR1DK
	 5WpS4HXRgCu10Okftugl0DmDLGr7bXNY65Vyqu7CJ5mt7zdYwHPmiQwlCzE42L+FOW
	 3ecKBoTSuEvE3kScfJLoy4YLvffJDVkvo7uo8x2IieDZXPVgNC6HG4eOXPFFNXeVeC
	 2KGqwK0GC478KT1/70j5Omdbj9WA2GHU515tVNR/Two6coYi54/4dZwGV/m3uia/M8
	 6B/kRLbtTjpzw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/30] btrfs: send: simplify return logic from __get_cur_name_and_parent()
Date: Thu, 20 Feb 2025 11:04:22 +0000
Message-Id: <9383ea4c0470479ba972cb7422dc3698d96b9fb6.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index dcc1cf7d1dbd..393c9ca5de90 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2309,9 +2309,8 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 			*parent_gen = nce->parent_gen;
 			ret = fs_path_add(dest, nce->name, nce->name_len);
 			if (ret < 0)
-				goto out;
-			ret = nce->ret;
-			goto out;
+				return ret;
+			return nce->ret;
 		}
 	}
 
@@ -2322,12 +2321,12 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	 */
 	ret = is_inode_existent(sctx, ino, gen, NULL, NULL);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (!ret) {
 		ret = gen_unique_name(sctx, ino, gen, dest);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = 1;
 		goto out_cache;
 	}
@@ -2343,7 +2342,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 		ret = get_first_ref(sctx->parent_root, ino,
 				    parent_ino, parent_gen, dest);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/*
 	 * Check if the ref was overwritten by an inode's ref that was processed
@@ -2352,12 +2351,12 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	ret = did_overwrite_ref(sctx, *parent_ino, *parent_gen, ino, gen,
 				dest->start, fs_path_len(dest));
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret) {
 		fs_path_reset(dest);
 		ret = gen_unique_name(sctx, ino, gen, dest);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = 1;
 	}
 
@@ -2366,10 +2365,8 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	 * Store the result of the lookup in the name cache.
 	 */
 	nce = kmalloc(sizeof(*nce) + fs_path_len(dest), GFP_KERNEL);
-	if (!nce) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!nce)
+		return -ENOMEM;
 
 	nce->entry.key = ino;
 	nce->entry.gen = gen;
@@ -2387,10 +2384,9 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	nce_ret = btrfs_lru_cache_store(&sctx->name_cache, &nce->entry, GFP_KERNEL);
 	if (nce_ret < 0) {
 		kfree(nce);
-		ret = nce_ret;
+		return nce_ret;
 	}
 
-out:
 	return ret;
 }
 
-- 
2.45.2


