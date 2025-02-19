Return-Path: <linux-btrfs+bounces-11569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0BA3BD43
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476673B873B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71751E8320;
	Wed, 19 Feb 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo597lbs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5A1E5B65
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965416; cv=none; b=S/kbaPsdnVsf5msrgkiNxU3Nh5sjrVhw7EWxDZxqDHwHhVD/48vjiyVhJjoqYH5sig3bzcRG0K16V4hYDMv5bLkgVGAfEL4ntlfSxgeHgz8wUMHcOZaTxJjngzgUV33Q5dGOfiYlvV2x2RSTT3fYpHpkECQDpH4/lc+tlSs/hDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965416; c=relaxed/simple;
	bh=nLZMehNoN9F5I0XHcpAhnK5JTMMzu8dFugV0exoQdf0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQt+5sHhBr4l/lTYvcqr65NrKm9zyFKvSR9Qe6pSA7qXR/HvyDaL3RbOBcIUuTBwqM/u6UnRzEwu7vRtbw2amEZryFgHFOOGYg/TR4+AMw+TTEf8dyMq5rpjYCQNltMrJPPKVFpxjDcn4YPCDQZFkJk70Wyl+gEhOPwX4XJu/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo597lbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D1C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965415;
	bh=nLZMehNoN9F5I0XHcpAhnK5JTMMzu8dFugV0exoQdf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zo597lbsIBmki4JFDf02QoNNd0WwCgc6mkpbD5ql+FLDbxk7YR3p0+/4EoiVR1dRp
	 nuA9iDDHHCgY9L3yiDOib7icwPL/N1JeIUQ2a7wunoTie0239QVAIsh38wFZdpHn9H
	 5c6CRx2EuhaurG/1VQbKOlvaFCWPp8mhUEu8ZAdnHzXQhgy0rPMA12+vMn48avYGvb
	 NN6k95nsETlnRy9SqX7Ec7/suGjezOhJKoS9xQYYXCo2IqmzdATAvsjAEFhQbv2Wp6
	 juhQ37TviwT1UwM/4hYVHBoMimuHV49+q8symCxBhnGD6psWZ/2peVVX0NHgio6G8U
	 NSWYJsPotJKvg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/26] btrfs: send: simplify return logic from fs_path_add()
Date: Wed, 19 Feb 2025 11:43:05 +0000
Message-Id: <3cabcc617f04d2182749e9a22c1fed64b4d63041.1739965104.git.fdmanana@suse.com>
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
index 535384028cb8..2203745569e0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -560,11 +560,10 @@ static int fs_path_add(struct fs_path *p, const char *name, int name_len)
 
 	ret = fs_path_prepare_for_add(p, name_len, &prepared);
 	if (ret < 0)
-		goto out;
+		return ret;
 	memcpy(prepared, name, name_len);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
-- 
2.45.2


