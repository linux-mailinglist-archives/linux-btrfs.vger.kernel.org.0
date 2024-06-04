Return-Path: <linux-btrfs+bounces-5436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92AF8FB0BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E2DB215B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DDE1459E0;
	Tue,  4 Jun 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwPsXN9W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5B145339
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499336; cv=none; b=UOa+1+Ku1zYE1fwRhQbT3atNDNfIYb4pIASMLsItLQ0XyLniSEZ6lnrNW3K5ElQZQIUdWRbRRvgBFktK1OGRYAx8O9a9/bXTXNi0k+6BojqWKgh5/zKoqqZHyTJ2aQqbenylpZxo7cghNyF0D4i3qXdvLPFgoe0LkjIpgVIuQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499336; c=relaxed/simple;
	bh=RCaNo/QBNEgLKRF4UxR7WrAayCos/eV6kpWbtoTeQOA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PH7qkwDVKBXvw2w6ApdJN949elOXURQjbaB4ZeJEjow/oONF/3ljLJL8NcrfZXu+T37bP2LIX2Ug63Gyknak7706WShv3EURs2GPmWWe/y8yjaSA4fBq3ToJM3ZsjGGpZXTFQD1n3JIpkqWlyn5CwRu+8Na1G2uvvgqP321mm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwPsXN9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256AFC4AF07
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499336;
	bh=RCaNo/QBNEgLKRF4UxR7WrAayCos/eV6kpWbtoTeQOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QwPsXN9W1Cf+hwR/cjvWfpRDPeve1bVFzTMfXjsg0te1UMeMAVIRDghdzbyIoH328
	 6BdfJ23Urr6Dsz3jWWInt1Afq2GFcq1A3w2RvwPWr1wSyULLp2j8VgJ5Bq+335cxGU
	 PmkdwBA1GUNQcra5syekQSrOgcSsnAeXZvw8XqxfjFvmC5UWQd/ZUflJFb5eHRvnbP
	 3eHx9eoY1OkOtKrGII9up4dTcGnTDm7NAuIQQUGO4NbNPTsiuJcuAg+wZp7ZzQrrY2
	 28q5Rm7yrxVUvg2Ak35/yy1W0cpdM7ohViKx9/kl42bskR8iVsAkKUUp9+cy/paArg
	 N2sljY6fsxrlQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: reduce critical section at btrfs_wait_ordered_roots()
Date: Tue,  4 Jun 2024 12:08:47 +0100
Message-Id: <efe86c39d01caabe6ebb6f64a5161dd8e48473af.1717495660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
References: <cover.1717495660.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_wait_ordered_roots(), there's no point in decrementing the
counter after locking fs_info->ordered_root_lock as the counter is local.
So change this to decrement the counter before taking the lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 65d0464cd646..15428a8d4886 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -829,10 +829,10 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 		done = btrfs_wait_ordered_extents(root, nr, bg);
 		btrfs_put_root(root);
 
-		spin_lock(&fs_info->ordered_root_lock);
-		if (nr != U64_MAX) {
+		if (nr != U64_MAX)
 			nr -= done;
-		}
+
+		spin_lock(&fs_info->ordered_root_lock);
 	}
 	list_splice_tail(&splice, &fs_info->ordered_roots);
 	spin_unlock(&fs_info->ordered_root_lock);
-- 
2.43.0


