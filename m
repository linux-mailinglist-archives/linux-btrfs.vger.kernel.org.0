Return-Path: <linux-btrfs+bounces-12718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C39A77A57
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE67166254
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2999202F64;
	Tue,  1 Apr 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k92t2HKt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03499202C34
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509151; cv=none; b=U0O4Ac3x/vm4benbFq71zOxsHwpR8TM6VcjE8hCxQFZ1iIej701kpXytpkQG0WBVspXv73kAD/cZ19O630H5cNvLUEcbC2VrvMCydvyZ+GZQ6jHTQsd7/ulH6EUuKXd5rFFCiedXFCQxtnum62d2S+Yfta3LptJwZQCYXNil/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509151; c=relaxed/simple;
	bh=7LI6uFwYWYntxxhlwUtzuaRXHgbgZK8MiQMY7OaK/XM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxKdJMMpdNwPdfXsP/GpR80oWyLy0joeS9xiiHYW9/ytbM0j9FFY9125PZrslFW/rFKffyJoIKWT3NE+ROEd2O1pxFGHCyLouZog8vEhYMsu6Ymk+kJD699O1sRm6bWHuBMjZGTSz4E/i8CydCAGf6xDccG9/MQEJudMG3PlbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k92t2HKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41F0C4CEE9
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509150;
	bh=7LI6uFwYWYntxxhlwUtzuaRXHgbgZK8MiQMY7OaK/XM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k92t2HKtDtVPTDFbUCLKt+hhoEAfjMN3BonbyX7tdTmkJSgNvBHO92spSVIvsKn/T
	 UwnoWogxOQV495SaA0ieKVOovB8Z6QLrQKJHJUyINhNFfd42XgRqEiWzPQJbseRGOh
	 FW4c4zphCaI9RfUv7oa7IEO7vrAkfL746vnZoA/ynOG6Ozy/p537YTdqikUA6Zjjtb
	 mxdsD9j33J2+y3KgQyJXAgzxrGx13w0HZyJpp7m9+ap29iN8YVG0kotD2Ye3TyRRXf
	 n+JFdahM5YDzU7h5T0DWX6Ao+hZVqoFgo1UET2KDh8ASGrmR2yptVuf2OsRFDKRwpP
	 +j+v/bV3Yl7jA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: use clear_extent_bit() at try_release_extent_state()
Date: Tue,  1 Apr 2025 13:05:44 +0100
Message-Id: <c98bc026af2049be1c7db471651d3f36a5513ec4.1743508707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743508707.git.fdmanana@suse.com>
References: <cover.1743508707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using __clear_extent_bit() we can use clear_extent_bit() since
we pass a NULL value for the changeset argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19f21540475d..50b74531b745 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2651,7 +2651,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	 * nodatasum, delalloc new and finishing ordered bits. The delalloc new
 	 * bit will be cleared by ordered extent completion.
 	 */
-	ret2 = __clear_extent_bit(tree, start, end, clear_bits, &cached_state, NULL);
+	ret2 = clear_extent_bit(tree, start, end, clear_bits, &cached_state);
 	/*
 	 * If clear_extent_bit failed for enomem reasons, we can't allow the
 	 * release to continue.
-- 
2.45.2


