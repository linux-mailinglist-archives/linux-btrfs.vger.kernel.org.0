Return-Path: <linux-btrfs+bounces-12609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D0A73676
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65213B701F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20DB1A262A;
	Thu, 27 Mar 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rduBNpPk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FA1A238D
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092037; cv=none; b=BjDCTbrUfGuXSlJWJjDwpsJD76+kBnCMuBS999sFt7sB9EClQUSQNxOmQpK0E0QK+OnUGjYvQwa8HZmw1tEcgYV+JaLd9trr4kWd3HUvyaBZz0YFTzWAwcftyeouqneIaQ8dpoyu5OBzWgLfg1p4awiib+o92qBvcRjPAOX4SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092037; c=relaxed/simple;
	bh=i7261Us3yzii9//wu93/R0ILd9bENbjdeYg4d85OoTM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRTYptqWCTv3Wsj16GaDlu1Z7sIVgD1oFh/EjR47Nl4+zd75xr64jd2LWTQL14L87pF718nOakROtzSJpSPZmOGFmLu3YNIl7QEggYaGVudPTWeqyR+hh6f4e8JHslbxh6QiqejPpuqBDYX4QCOBn+HBzPuxk05G8X42tFZvQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rduBNpPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A268C4CEE5
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743092036;
	bh=i7261Us3yzii9//wu93/R0ILd9bENbjdeYg4d85OoTM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rduBNpPku4vvlf1zeexg+z7TIz4dvV8ad6ijU8dFT0u3P9wQcjEKiymZG1oNsdpzC
	 aylTNU3NdB/U6IIzXen9FL+cWnW1RANGw+WLzkMPVBUsYavHkwTeVaZlZFsB1UrBs6
	 dkPCP8Hm81LT1sfWQKb4esg7qP6Ly20ADT+FoGwzVPgqDpqOk7W8aRGez7D8P2PJPB
	 HCpkc3iBVoeE15oaGo6VGbo24Vxd9dCIw6PriLJBmKwiADeL6Su1jyB4c4s8ZYdg6T
	 tRAXCopxvHOobVRn1SVrDb4r85qW9rJy364nkZfHsToFjB5umxnJ7jVyfVVkgciYMy
	 ksN75gvoXwYZA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: update comment for try_release_extent_state()
Date: Thu, 27 Mar 2025 16:13:50 +0000
Message-Id: <7cee4c63c1fb8bc66efda5acb6257e504f3eb053.1743004734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743004734.git.fdmanana@suse.com>
References: <cover.1743004734.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Drop reference to pages from the comment since the function is fully folio
aware and works regardless of how many pages are in the folio. Also while
at it, capitalize the first word and make it more explicit that
release_folio is a callback from struct address_space_operations.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b168dc354f20..a11b22fcd154 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2618,9 +2618,9 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 }
 
 /*
- * a helper for release_folio, this tests for areas of the page that
- * are locked or under IO and drops the related state bits if it is safe
- * to drop the page.
+ * A helper for struct address_space_operations::release_folio, this tests for
+ * areas of the folio that are locked or under IO and drops the related state
+ * bits if it is safe to drop the folio.
  */
 static bool try_release_extent_state(struct extent_io_tree *tree,
 				     struct folio *folio)
-- 
2.45.2


