Return-Path: <linux-btrfs+bounces-6172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDBB9263C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DADB2A5F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86917DA3E;
	Wed,  3 Jul 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCg4rPZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08B1DA319
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017948; cv=none; b=kP8iQDyPbYU6FCl+bciW5MzC4abOlWqcBhN09NMK+kT7Px8pImlEigjn6uFeFxmt2ofCGVsrCZrxL86n8/QgHQdO8yxmsEEUBl7RqYjBdSmCAb3EoR1MaqVJlT3kze6p0g7mbVW6ZG6/lYySKTB8h+qAxdJ9mg3a0IyQsBMjMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017948; c=relaxed/simple;
	bh=rtJvFo0EIC1KL5+T8dVUIcFmgU1E2eABv0ax2ijFgRE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Vz2eiI/uvKRMgGEXMd0uUG3neo/Q4FWsUEFfxAXQOg/hPYHMa3KtL6sDORFCMlsft9AKRSnJGhUNCNhKMkrY1MvP5544NGLRHevndrnvZDpRSydHT3aa8Q/YvrMhuQWycKjhOHsqMJ6RpEdwRxlQWtotZF9BDiWzNGKIl17f/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCg4rPZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40EDC2BD10
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720017948;
	bh=rtJvFo0EIC1KL5+T8dVUIcFmgU1E2eABv0ax2ijFgRE=;
	h=From:To:Subject:Date:From;
	b=PCg4rPZ1AXeq3HyFjQh1eXUj2yk7cpbtZp1qNseFeADE66rpFRJbklVysX1BPi4MW
	 agyNb40VrMLMEXGf91PJQTdWrsdoyA8TiWaN/XwlwP6n0+omsgxmTJxbZV0hDmV7Pv
	 Rfmz4kVs72WYJyq3KIqubtwbxeUhSDJRRGxQIrfDxClyB7aOo8vBq3PHhdxqAVqDKy
	 Ea5VpYFXX8DawlONvtuCOM4BGrTBv0UuOG7StOG6ULv6+uiDwpQUisEZIPV4y+5dOf
	 hw3ywvbCip6RM9wSB4GZlm5OBFNF1maG+kKrhaSYNK6pmDFIj+294qIDuc6Sgxb6nd
	 nTbYfX1Cn0Isw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Wed,  3 Jul 2024 15:45:45 +0100
Message-Id: <548b562c2432cbc591b50fad1ea24ae87dd50627.1720017904.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we failed to link a free space entry because there's already a
conflicting entry for the same offset, we free the free space entry but
we don't free the associated bitmap that we had just allocated before.
Fix that by freeing the bitmap before freeing the entry.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dabc3d0793cf..5007dabc45d3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -858,6 +858,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0


