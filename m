Return-Path: <linux-btrfs+bounces-11568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619CA3BD41
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A063AD17B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A71E048F;
	Wed, 19 Feb 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAgTj/3i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A861E0084
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965413; cv=none; b=l2FCLZe4EzHlrMH7WBRW1PgE1N6yKuInKt+ME4p8tRU4AmN1xwVZzU8fI8v6tVA6vEYcTv88PdH3BU42XvzAW1XBaCgP8pRpYJuGaisFgGoWGv3LlHZgmxjVKKdIj3TzJWERwgGvu55ch6RExSB0XeVkgkk/pilI2vbj6AR0Zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965413; c=relaxed/simple;
	bh=qw0g4x9hg7TAw+pEdZ+odymNejfMhtMSkua0gV5gkeQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHcfbOo1AAp3+oN/yzb2KXGZh0oUVUVEmK/Ad/kvsDI/cWb7gs633ac6pVPdZ3r2iJXOo/I6gCWgtRPliAntNZC1kquss6nd+Hsep/JZzr0p8cyN+7ELdomqhEL3IOJw16LuSr3VcxC2lZi475qK23bjp/zzooQRD2Q4tL99E8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAgTj/3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94F5C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965413;
	bh=qw0g4x9hg7TAw+pEdZ+odymNejfMhtMSkua0gV5gkeQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pAgTj/3ibamuvdFVRl1JKA507gLVv6hK/YGx/gzN1CD3ac+GAq9iuUAEvFbcHoZRg
	 ymUFX5CMX4Lcra6L6jVFRrGOtyGagJ+kPWxiGtpSiTkklN0JpOQJ6Mgl6U9f3XnE38
	 WeoiyViv8HMFopk+mmNczrds16soCtTrIr+/3ZM9eAH3S0SBA523SK5q42laMWTZSd
	 +iPhaP0jz/6JXJqxZHytgqV2Gz+0aKQGFL+VY74dvC2cdAEkB9hi63sp7yp5A0Gk3Z
	 lYlK7mbgty7vDqEQnGsUpcAkNc6uLgWjazEMTYX4G7xAEVz97PU0oc1BUdt/E/aBjQ
	 lnMH+loZmuIbg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/26] btrfs: send: always use fs_path_len() to determine a path's length
Date: Wed, 19 Feb 2025 11:43:03 +0000
Message-Id: <cc0e07d7863566a85288fb270c6ec213d154a7a0.1739965104.git.fdmanana@suse.com>
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

Several places are hardcoding the path length calculation instead of using
the helper fs_path_len() for that. Update all those places to instead use
fs_path_len().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4e998bf8d379..9f9885dc1e10 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -489,7 +489,7 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 		return -ENOMEM;
 	}
 
-	path_len = p->end - p->start;
+	path_len = fs_path_len(p);
 	old_buf_len = p->buf_len;
 
 	/*
@@ -530,7 +530,7 @@ static int fs_path_prepare_for_add(struct fs_path *p, int name_len,
 	int ret;
 	int new_len;
 
-	new_len = p->end - p->start + name_len;
+	new_len = fs_path_len(p) + name_len;
 	if (p->start != p->end)
 		new_len++;
 	ret = fs_path_ensure_buf(p, new_len);
@@ -571,12 +571,13 @@ static int fs_path_add(struct fs_path *p, const char *name, int name_len)
 static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
 {
 	int ret;
+	const int p2_len = fs_path_len(p2);
 	char *prepared;
 
-	ret = fs_path_prepare_for_add(p, p2->end - p2->start, &prepared);
+	ret = fs_path_prepare_for_add(p, p2_len, &prepared);
 	if (ret < 0)
 		goto out;
-	memcpy(prepared, p2->start, p2->end - p2->start);
+	memcpy(prepared, p2->start, p2_len);
 
 out:
 	return ret;
@@ -616,7 +617,7 @@ static void fs_path_unreverse(struct fs_path *p)
 		return;
 
 	tmp = p->start;
-	len = p->end - p->start;
+	len = fs_path_len(p);
 	p->start = p->buf;
 	p->end = p->start + len;
 	memmove(p->start, tmp, len + 1);
@@ -737,7 +738,7 @@ static int tlv_put_btrfs_timespec(struct send_ctx *sctx, u16 attr,
 #define TLV_PUT_PATH(sctx, attrtype, p) \
 	do { \
 		ret = tlv_put_string(sctx, attrtype, p->start, \
-			p->end - p->start); \
+				     fs_path_len((p)));	       \
 		if (ret < 0) \
 			goto tlv_put_failure; \
 	} while(0)
@@ -2364,7 +2365,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	 * earlier. If yes, treat as orphan and return 1.
 	 */
 	ret = did_overwrite_ref(sctx, *parent_ino, *parent_gen, ino, gen,
-			dest->start, dest->end - dest->start);
+				dest->start, fs_path_len(dest));
 	if (ret < 0)
 		goto out;
 	if (ret) {
-- 
2.45.2


