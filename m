Return-Path: <linux-btrfs+bounces-2289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83084FB6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B978DB26B43
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DE84FDC;
	Fri,  9 Feb 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cybKJ4QB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDA84A50
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501662; cv=none; b=A3b6NUsAlvvh5qoI9I+GudR0ahbaOZH48PxICZsxqO5pIEC1LJD/oTorfeyDViddwo5bYPe4cUc8HQabINKDxa3eRyJeMJbJ4BrncjXEfUIm5VJQXTtcu7SlxRyoLXu94ihg58IW1WADkXFzfkAXtNQdt94y6na/7YewD1XrswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501662; c=relaxed/simple;
	bh=KyZYmRr35FRutdng6Fsir0uaIiWxu8JekCZB+fmcnjY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYTzNWZHhm0nui+qq2m/E+Dq4czWYXLv7Kjz2XgeScpdSb3hgU/BbmLRz170vyEwoTw506YALMjzxrmVCBidClwWIPN6X6DMKX2AQF3+t6bLZVVFx2CTcu6T4ejcOjjBBfn+wXRjduLpGme6StCTgi6OiTo4kTFGmYxrKgXclPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cybKJ4QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EFCC433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501662;
	bh=KyZYmRr35FRutdng6Fsir0uaIiWxu8JekCZB+fmcnjY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cybKJ4QBS3bvq3n7UMm/cSaicrnNVNY7KHjd9/ChYDr88k0nLEMpRYXwSBntm3l7f
	 CvXbCqq3Y7gWEd/4nsLkAXDQHk1TNAN/TNQrdSvxWlCFWu/zRqGBCLDpEtqMOf+tAu
	 CaoG8b9LPxO5pmhfytyOXdgtm8DessEPNctug+GcDu2gDXPEX7cIux85QU3WwAk/jU
	 G5Rc+JbTMoaToNtTRCy08CenzqvNMoE7enCw4M6WJnfNfw9UV9eyJITpCjTy/hDGSU
	 42Pl7sYYaZNfz1GbFp1wzxDDwIapi0AYJ4OlMDbmA7A2el8skz4pZMVL/Z859jSsjA
	 2NGrmbQMvfQeg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: remove do_list variable at btrfs_set_delalloc_extent()
Date: Fri,  9 Feb 2024 18:00:50 +0000
Message-Id: <f8cf816e7c4d397c41bb2872ef75cd1fa7bdfd44.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The "do_list" variable is only used once, plus its name/meaning is a bit
confusing, so remove it and directory use btrfs_is_free_space_inode().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fe962a6045fd..17b6ab71584a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2462,7 +2462,6 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 		u64 len = state->end + 1 - state->start;
 		u64 prev_delalloc_bytes;
 		u32 num_extents = count_max_extents(fs_info, len);
-		bool do_list = !btrfs_is_free_space_inode(inode);
 
 		spin_lock(&inode->lock);
 		btrfs_mod_outstanding_extents(inode, num_extents);
@@ -2487,7 +2486,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 		 * and are therefore protected against concurrent calls of this
 		 * function and btrfs_clear_delalloc_extent().
 		 */
-		if (do_list && prev_delalloc_bytes == 0)
+		if (!btrfs_is_free_space_inode(inode) && prev_delalloc_bytes == 0)
 			btrfs_add_delalloc_inode(inode);
 	}
 
-- 
2.40.1


