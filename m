Return-Path: <linux-btrfs+bounces-13615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57ECAA6FA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4501F1BC7534
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D4243371;
	Fri,  2 May 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4oYftZ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD85242D8B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181836; cv=none; b=OZQFoPHoWk7BBrcg/q8czS8lga3HAMJXxHfigaWU1CMpntV/wsMRMb+FG2W85OKnhqWJfDqMln1VDWDG9OoN9QqnLURsl8mohbiN5N0JeeTUkAAYHGno9v2Hh9hKPeXcRYBKeyJyl2KL7pqdGPj5DzdavmoJ0YgKA+WOS12JLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181836; c=relaxed/simple;
	bh=fhC2rRVMmQ0HpbG37wQ7wRClTpeMvvdc9w40nJJC4gg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHDJBqxh/dbI9rJxEAh+tM3LZQi+xqBacE4U8s82gUn7/HFbW5SPZ52lcjqM9BH6mJN5+2NPdCurcnWShs800Ju/NFLfjt8ec3uvmn4DGmcRzHFCKg7edFtxDSf8qAFWwAJrww++sHdFRtrCaDPFtO5QzHCsUEidm8DWUULKUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4oYftZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F62C4CEEE
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181836;
	bh=fhC2rRVMmQ0HpbG37wQ7wRClTpeMvvdc9w40nJJC4gg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B4oYftZ6nAtaxNx6ptAzr7c3CJobKp4q5Tp/EDWjdTYcqNcp8q/k9hF+luJRtMp2Z
	 JTeCHAQbH0qKhOqAYbneDrumpW25Yb8n0IwtbbbtGR1QYvXOgTLi/BYLpYmhZPnwcG
	 AnZruLntYFprzIx4OpHubY8shShgbB7w7OtAetVfu701kesCWPokjGEftjH5nyTAwN
	 nzixbvOsyS634bdlSakC8wk+SHoLDaVYlPcUk32hM/f60jzp/8FW5Vx5gfL8tw30tb
	 P4/lR7UGQaftHr+iBMNQGfBBNEHX9QgI1vt2T3Eoi+ih8xCQNf/+AfL/ck2XmPbDsf
	 fqGxrTQC0n+Tw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: raid56: use list_last_entry() at cache_rbio()
Date: Fri,  2 May 2025 11:30:24 +0100
Message-Id: <14c81b801f468ad3d4d1ed9aada49d8c79a2f077.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using list_entry() against the list's prev entry, use
list_last_entry(), which removes the need to know the last member is
accessed through the prev list pointer and the naming makes it easier
to reason about what we are doing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid56.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index fd96b5040584..c01d0ab80f3b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -577,9 +577,9 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
 	if (table->cache_size > RBIO_CACHE_SIZE) {
 		struct btrfs_raid_bio *found;
 
-		found = list_entry(table->stripe_cache.prev,
-				  struct btrfs_raid_bio,
-				  stripe_cache);
+		found = list_last_entry(&table->stripe_cache,
+					struct btrfs_raid_bio,
+					stripe_cache);
 
 		if (found != rbio)
 			__remove_rbio_from_cache(found);
-- 
2.47.2


