Return-Path: <linux-btrfs+bounces-11572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EEA3BD47
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E71189C024
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C21E8339;
	Wed, 19 Feb 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlbZO9KN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B1E8331
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965418; cv=none; b=lmSDYoOh+nPkNv8aYcj5U9Qlv27YNfBvjTYTRGnD86RtnlzPccix2NgsKoBWWELB87iNKjcWzf7kYizmZmzNj8sG7LELeIcXAxvKDer8YDD/JzPJTT9EOjDjLUFblHjmWOOhviCZnUG3pnjXf12fHpprQpuPCEFhxSahsPRUTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965418; c=relaxed/simple;
	bh=TU4XK2ZNfLY7/Ncb2aX2uSF786rE++vnCm1jmieZQ44=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V760nuc/djciNNdbkvyOYkiR3UDp6kA7jX/NHLhCyIevke7A/eoqBp2ki/h+8cIbb07cL/mBnIEtRCtGbNoBl9Fc67jU/QDwaflkF59hF92cVFDl62/vuKftGrHUsYhvvg+QBnfFcZhtZqxVFdSQiQA2K5eCR9fInCwJJMlSbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlbZO9KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF6DC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965417;
	bh=TU4XK2ZNfLY7/Ncb2aX2uSF786rE++vnCm1jmieZQ44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AlbZO9KNJK4p/IGZb/05rZ3di5wkIyd4MaxziSxYa2oWyfCA2/HvWwguI5lo5SbLT
	 nX29Fitp6CteVdVFySuq6J8Yqd6NTOCsPfs2CBzOL+AISmjRN6DhsRuCm7s5coHFcv
	 +0TAH+D8EdaEMx/rv/lvfMsRPULsnMIAXXe/mJIB7K8XbnpL8ouwU1veLRla4tgNFF
	 Zub61DAF9+ZHYFVC4atam+gBZUIBaPrsRBYtDrdI/OJHWSjvfsdV2kJBUP3qoyuC0o
	 gowcG+y2vyN2kE7huM+euIdFLK3VIiooStUokTWCprpkHpXUPRiL8D+bylxCgJnNAs
	 wyB08x8ZNNNLQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/26] btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
Date: Wed, 19 Feb 2025 11:43:07 +0000
Message-Id: <3b345a8f4e091bc5a3e2cd8a55180d54d48b3dec.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7a75f1d963f9..b9de1ab94367 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -580,12 +580,11 @@ static int fs_path_add_from_extent_buffer(struct fs_path *p,
 
 	ret = fs_path_prepare_for_add(p, len, &prepared);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	read_extent_buffer(eb, prepared, off, len);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_copy(struct fs_path *p, struct fs_path *from)
-- 
2.45.2


