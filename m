Return-Path: <linux-btrfs+bounces-9147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB69AEBED
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A61F2363C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F611F80BE;
	Thu, 24 Oct 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIiXpNsI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA911FAEE2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787089; cv=none; b=qphqchXRmxhxKHcBwRv8YF+ZQrlXsWlO80ge4M5Fmm2FHPnhxNfBj5VSmmp1Yx9YigIkx347RCyXGSn+69m+OPSUqvon92JXdJZ6zwpXpx4FZP5D1qNOU+4/VY4dbd2tshg5m7jLXo0QyS66zaYSg8sHmUO0AScxW4kPvXHDty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787089; c=relaxed/simple;
	bh=nLGP1wPsHV/4naMJ4rKWrETcfNOA1CvzMFGob5RbxR0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEOPdiH74I4RnK9v7WqaMaqHrVTLqoVrCZsQjjjIWM8WHKk91qPbdB5mOn8kt9cjG5vc69AoowDgZquZ89ZE624Ifbm1S7QYqwcH5eauSwY3OTWFZb8j0vWQXyfVic/7T/UQvd58sqL7nbRify6aqBnrAVhlu6FAeuT/ylVXJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIiXpNsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335A1C4CEC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787088;
	bh=nLGP1wPsHV/4naMJ4rKWrETcfNOA1CvzMFGob5RbxR0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YIiXpNsI95bbGJInydmiYADzj7JeY0KIUkfEaXvDPBTqcclnKIfTsYpPET+AhfEB+
	 gkSxI+3DXXUjU1C61/fpa04K0VNCzGsP1MPA9jYVAXAXboJC10evWLHKoOvauJa+Vq
	 ITFFWg0LJlHTO6Ywitc+95GJJczt2RcMArSD+6KX1U1JBmrtBZuoYdqZBel1YkAPd8
	 YMvV+aCV/SfLQIOUpY9QcGUo3BhYH6Bd727n53FoWm4FF1ypwpGgW3UlXz8E/U3GDa
	 zqlWa+jv0Svf65uTUNTNlm4UkRnKldLI2QqWiZeGX0DXq20aaUanVO24BUY5b15/1a
	 tMJtdVDvIDxLQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/18] btrfs: remove no longer used delayed ref head search functionality
Date: Thu, 24 Oct 2024 17:24:26 +0100
Message-Id: <aaab121fdaec0c8baecc0e364894d5356451231c.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After the previous patch, which converted the rb-tree used to track
delayed ref heads into an xarray, the find_ref_head() function is now
used only by one caller which always passes false to the 'return_bigger'
argument. So remove the 'return_bigger' logic, simplifying the function,
and move all the function code to the single caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e4ca5285e614..7399be5fddaf 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -355,34 +355,6 @@ static struct btrfs_delayed_ref_head *find_first_ref_head(
 	return xa_find(&dr->head_refs, &from, ULONG_MAX, XA_PRESENT);
 }
 
-/*
- * Find a head entry based on bytenr. This returns the delayed ref head if it
- * was able to find one, or NULL if nothing was in that spot.  If return_bigger
- * is given, the next bigger entry is returned if no exact match is found.
- */
-static struct btrfs_delayed_ref_head *find_ref_head(
-		struct btrfs_fs_info *fs_info,
-		struct btrfs_delayed_ref_root *dr, u64 bytenr,
-		bool return_bigger)
-{
-	const unsigned long target_index = (bytenr >> fs_info->sectorsize_bits);
-	unsigned long found_index = target_index;
-	struct btrfs_delayed_ref_head *entry;
-
-	lockdep_assert_held(&dr->lock);
-
-	entry = xa_find(&dr->head_refs, &found_index, ULONG_MAX, XA_PRESENT);
-	if (!entry)
-		return NULL;
-
-	ASSERT(found_index >= target_index);
-
-	if (found_index != target_index && !return_bigger)
-		return NULL;
-
-	return entry;
-}
-
 static bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
 				   struct btrfs_delayed_ref_head *head)
 {
@@ -1184,7 +1156,11 @@ btrfs_find_delayed_ref_head(struct btrfs_fs_info *fs_info,
 			    struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr)
 {
-	return find_ref_head(fs_info, delayed_refs, bytenr, false);
+	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
+
+	lockdep_assert_held(&delayed_refs->lock);
+
+	return xa_load(&delayed_refs->head_refs, index);
 }
 
 static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
-- 
2.43.0


