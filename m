Return-Path: <linux-btrfs+bounces-11574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B33A3BD42
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A99717290C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891C1DB546;
	Wed, 19 Feb 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYxz0Mwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85D1E8351
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965420; cv=none; b=eh+pny2gZbpY/J4/En7Nyv3fjCjGaW7ICUbolHpPmL7vt8Nr+WfPslWLyhejQW3VSfpfWixCdRemy6oKeOKMBoGBgBSi8L3Djf7CXC9bqoUzsM4iNaJJHO7o4kJJETMO3KHQDhdA4WL2bilqdWOEgVE8sNa8g8kwCoFKWMfxhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965420; c=relaxed/simple;
	bh=ChBKnQAulfXbutwRNaXkCCJf8hYyc7teGSzKCz2J0jg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NczY3C2EoW8e+LCzDPJ5teK0vy0NGWT/aYXY0UIchb0EV+0IQVGL2gvfWzMVNtRTUXo2rQqRJGndSR2OiJHpW1uRzuCsk12R34pbVv9IJ+7zjk7k4iX+RCMSAbtpvKBmN4f/GrliCkZGT+itsbmtGZTblMrotw0KH22zIuK+Ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYxz0Mwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039EEC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965419;
	bh=ChBKnQAulfXbutwRNaXkCCJf8hYyc7teGSzKCz2J0jg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HYxz0Mwx966aZurJEVXxqz3jS04S4EWB2J9pKF9CWBfAlBr5wG+v7rT5cxQmM5XM+
	 JJrDCKW8UKnBaIx++zDNBQZCEdxt2R5bgrj7UIZlzVYRzn8uLhKNipl9z3k/Ji+Moq
	 1hiTq6Z3eFJhjS6nVzY1KS5yhv5yfysNeLSETcBII2XMPULRnlM6e13IA0qrG6b1q/
	 cHFrq+RfKdSLHUgqpCKdpAHFf7FI/VcZz8//ya5T4nji3pKRFuH8Wpx2mIY29ZtaHA
	 HUSbZX9tw2Al9oRLeQ+jiAxOkUGq+8xjREAxP6F1S2M622R06Pss6/9Ub21No+McAr
	 xOoYfJdm2JGLA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/26] btrfs: send: simplify return logic from __get_cur_name_and_parent()
Date: Wed, 19 Feb 2025 11:43:09 +0000
Message-Id: <a98e793d3f0d8ee0c2152e429696f61e3e1aa9fb.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
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


