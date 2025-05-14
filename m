Return-Path: <linux-btrfs+bounces-13998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD2AB68CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F2B1B41CDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43F270ECB;
	Wed, 14 May 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So1uPnpM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244B270EBF
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218569; cv=none; b=Lcj4tDTuNAyd8E0o6h0in44tUsZntcVhWxHOrTDCob/YU4TqneyaxU/kC+vJ2JeisRMr8SOrxp6S1w0yLWvuoztclXZAnLQwAen5sctP5rSUyV6c9vEekDZtGbcZbU3GzJZVuDcbIYAJu3Anf+NIrkii+w7Z3zzu2VxRHjmtMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218569; c=relaxed/simple;
	bh=6dfi9aV3CkVif3ix9Bimwigq8dKiYGQ5DnEQyuUuszw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrAf7QI5tJXZfuSGRZWNbnSIWHwuZXwIaZYmkp62FcTIP3rRRM5TDeTkHQRsuZGE0xNjUJ7zRi4eDkqbKccuIfIn4y1ovGJjpp5XwclbSyFs5TNhTHY7xJgLp2sbi8FPsJ5cSVkN8TrhTBcuHfGbMHaToR1jGg48f+8zAZ05ysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So1uPnpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D256C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747218569;
	bh=6dfi9aV3CkVif3ix9Bimwigq8dKiYGQ5DnEQyuUuszw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=So1uPnpMzQybU47gTol6z/BEVJQJrhVKLE/nbn6xohEx6M1AUKSdIMMmvi9QFVSGz
	 htH1FVTVWQoOtRTgWcXmyHzeqJaiUKreKBsWDRpJ9QVK64rFNk8vUon/dtVEt3PSTN
	 v3ocvbmNlZJruZS33gQWr3aR2SaG9RNsXz5KrIWnyt7LQDF0OJFlr4+xwuyN6TPdKA
	 qo2xrot5W7dnEBCadwMRTup3Q+p43rIkSrsawU8ugmlU/28iUz6zYDKJAtey+77xd5
	 hvwFMi6Qs06a2Q7NO/QSVC8nYDMMLfYYyuwSC2qB/2kxLOfc5jYMEQ8RlBvBgifDI9
	 g3QzOrRxl0QNQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
Date: Wed, 14 May 2025 11:29:21 +0100
Message-Id: <b0fb503be36f4f51025b901b0c808412949b0a94.1747217722.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747217722.git.fdmanana@suse.com>
References: <cover.1747217722.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the last call to btrfs_delalloc_release_space() where the value of the
variable 'ret' is never zero, we pass the expression 'ret != 0' as the
value for the argument 'qgroup_free', which always evaluates to true.
Make this less confusing and more clear by explicitly passing true
instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 32aad1b02b01..a2b1fc536fdd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1971,7 +1971,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
-				     reserved_space, (ret != 0));
+				     reserved_space, true);
 out_noreserve:
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
-- 
2.47.2


