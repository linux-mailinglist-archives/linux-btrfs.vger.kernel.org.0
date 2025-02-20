Return-Path: <linux-btrfs+bounces-11638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960FA3D7AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658E4189D129
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842451F1524;
	Thu, 20 Feb 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe92Ckb8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DB1F12E0
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049490; cv=none; b=TBnkE7dszS3c4bHZaZ0OffkEIShwlarXogCiRd/79reCrRYAkBysk94VUAbsA8aaryy1slOLKkD25dCv0fJgazdMTzVWN/MUpRUZZyrOGwyaBGrkIUgMUa8PC18Cw9n+1CkgGQtAamEnDgy9rrLaQZ46bQ6QqXSwhk6A1x+9V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049490; c=relaxed/simple;
	bh=qw0g4x9hg7TAw+pEdZ+odymNejfMhtMSkua0gV5gkeQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwnO9+LwUMVQIcbtTo3GuEsUZ0KJCJagrhHpqkYKcoLepQvqV+QPu3F4Kx5CJNu6Ii8RHLRiiC5a+QL4MJuNTfxdxusqxSTX1sglN3D8muOsaaVRrPARqiDrurE+AhHjCvseZ6YapzrsNQBHUgAeQNUd/P++KpXBaRaAacx1Abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe92Ckb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231FCC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049490;
	bh=qw0g4x9hg7TAw+pEdZ+odymNejfMhtMSkua0gV5gkeQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Pe92Ckb8M3fCYF3/wVzV0gijuHoDh2FTQq7jJ0KSDMxyBzCxNzeWzgHBwon04JxRK
	 uJwr4LpLTPBG7t9QnGVXrpRpBbewuGyUEkliAy8ADVh6iCRq6ByEwVYSljFORj+2w8
	 XuE7DQxMpQCQEWPdmzMieto7f9wT6sVCx++7ITGOrR4GVX/av0yJ6n1kls1pNo7o6K
	 MFxlJDN+Ugy8blFdG84xDfKW2b2FWCr0zoqdrtY854xWujRG4bqZ6U1vCEJcfNIlY7
	 OUscsg7dydDbubHTGomPcTwBT0ZjmSuEarargGkEezNuSp63ilHd39l34O2fp5373M
	 0asfJE2Qf9nFw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/30] btrfs: send: always use fs_path_len() to determine a path's length
Date: Thu, 20 Feb 2025 11:04:16 +0000
Message-Id: <d7dbaad7ea5ff4db1510466d22c60f4e3288c792.1740049233.git.fdmanana@suse.com>
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


