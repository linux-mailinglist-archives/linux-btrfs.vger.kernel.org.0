Return-Path: <linux-btrfs+bounces-13872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22024AB30C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADDF189B2E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43A2566E8;
	Mon, 12 May 2025 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKcbOuF/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04F42A9D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036094; cv=none; b=qdzA7qjGVUJ8701i6Acqk+QaWWzbP/CBE6cae6vxVgeSx45uR5SviF1X3O7EpbDecgaG+oIZITFWRfnD8FDPGmbVcjCs+iTOn9PB6CiBrWh7A24/r3tuc/KkbhwfDqPKfGawd8c8VXlBS0CSj2xC34di7g/FBQUX21LSXtUsOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036094; c=relaxed/simple;
	bh=oiLzHAM9cyqpLOVBpxRV6hwRZvc8tLWS2O+QLEnMS+U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IsHR/JJEMrILSMu4y+bQ+BhWRd856t0XXfH2mtlRWTN9IV7r2KNOxy0iMvJp7UYlJy82OfMbhdjt6E0fx89Gxq/Awuuw0TvASV0QFc1m+AFK3lLNguYQIbfU3BZ0386x7aHGt8qU344gv3qA6Tl1WmJMzaHFlqb0B65rzOxJOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKcbOuF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E2AC4CEE9
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036094;
	bh=oiLzHAM9cyqpLOVBpxRV6hwRZvc8tLWS2O+QLEnMS+U=;
	h=From:To:Subject:Date:From;
	b=HKcbOuF/Y0KeWuXfrbOBwE8GUr4dzSCEgbRJ3zg/gsII7hUKB5zCctHaKPpdwlxaH
	 5zVnPh05NlJ5PPKg2l4y7Q4/y6e/hwUwLBaRgfzdcnXyOH8+kvm4MzE7i/WNORyd01
	 NmJNhtqsm1KQ2MVD9YkzsXFiGOo8zto6t3CF+e6V8nldWNQwX98YsuKTk15u+3Ssaq
	 b0L6hBLW7gweH9iW1YoMMXEX42NP3hZIrJtkPRDcZ37Vlp9Vcpb2qp2dPJpchv9piA
	 7PG2LbCeyj/D/i62Msew1yioT46kcjfzLyGrrYYwtjcbDq0gfunsMlRd0CPc62ES9B
	 zGu6PewJlXOWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: simplify error return logic when getting folio at prepare_one_folio()
Date: Mon, 12 May 2025 08:48:10 +0100
Message-Id: <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to have special logic to return -EAGAIN in case the call
to __filemap_get_folio() fails, because when FGP_NOWAIT is passed to
__filemap_get_folio() it returns ERR_PTR(-EAGAIN) if it needs to do
something that would imply blocking.

The reason we have this logic is from the days before we migrated to the
folio interface, when we called pagecache_get_page() which would return
NULL instead of an error pointer.

So remove this special casing and always return the error that the call
to __filemap_get_folio() returned.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c9a3e75befb9..8d6a4a835bfa 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -866,13 +866,9 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 
 again:
 	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags, mask);
-	if (IS_ERR(folio)) {
-		if (nowait)
-			ret = -EAGAIN;
-		else
-			ret = PTR_ERR(folio);
-		return ret;
-	}
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
-- 
2.47.2


