Return-Path: <linux-btrfs+bounces-14734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFAFADD5F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281762C1EAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EE2EE278;
	Tue, 17 Jun 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRnKNtO6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91102EE270
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176796; cv=none; b=OWlD/u+yojn4gpJV1en0UlfGm8P2LoIXFd4FbJmbuAhnyCu4dgBKyt84m+t0aXdzuQpJKa9/2uJMBBG+91zGs6wEyLHd/fwx9Kv924DkeyDeEOH94Ip6YWt87l+rcJnjFNKkaJPTDH20mXcnJZloh1lU03ZquzRAlJBSrFZzlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176796; c=relaxed/simple;
	bh=VRzpWFpBjDK6EzAEYEOoV9g2Lgw4x/ksaujVk+xQCH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVS2Ohz27zKspI+KK8yxu4jfIk/V9GT11pcmhSevhGOYwqU0V8jJGlULvORf3DDlqGX6MJy4+kYX4KPUTnXexWA66c9c/4o21BquFdrUNGors6m7tazgn0Y0TyV2brzpSBxSGQ6gwDZrMScatYjjanpElVlKmGnVO97i254t7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRnKNtO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C5C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176796;
	bh=VRzpWFpBjDK6EzAEYEOoV9g2Lgw4x/ksaujVk+xQCH4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cRnKNtO6WE8etJ6/m2klWjO3JMA66mA+xfXsRyjAPv44NW5hIKbZV4+vfnG31gDie
	 57tzwzGbG4xAl2fUR3mqJi7/p2auvPhgCVwsO4SLEyV9XHK8iI5kVgOU/G0fuY0Q5K
	 5OsQLGm5WuKED1AFWD/kCcp4ObrqSDW0rVwvCySaIJ+pOoRSzS0a/f5icAUTQWwE5K
	 LyL0VQWy8DYDPezrgcqfeLIycYTu0hH4rTw7E9hF+C8Vo2YZwwvKEksr93w40CCuWh
	 MH08LRCVrcnEMlK3H/O44mm0jeijErj0r1aCBBAEsq96tCu2UxnS8VtwWyUDM86vya
	 8CNvamGeFmKdw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: remove pointless out label from modify_free_space_bitmap()
Date: Tue, 17 Jun 2025 17:13:00 +0100
Message-ID: <df2d3a94e098fcde8e43a5d692ae123666b10b05.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All we do under the label is to return, so there's no point in having it,
just return directly whenever we get an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 4cd1f46cd694..a4909393840a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -630,7 +630,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_search_prev_slot(trans, root, &key, path, 0, 1);
 		if (ret)
-			goto out;
+			return ret;
 
 		prev_bit_set = free_space_test_bit(block_group, path, prev_block);
 
@@ -639,7 +639,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 		if (start >= key.objectid + key.offset) {
 			ret = free_space_next_bitmap(trans, root, path);
 			if (ret)
-				goto out;
+				return ret;
 		}
 	} else {
 		key.objectid = start;
@@ -648,7 +648,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_search_prev_slot(trans, root, &key, path, 0, 1);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -664,7 +664,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 			break;
 		ret = free_space_next_bitmap(trans, root, path);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -677,7 +677,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 		if (end >= key.objectid + key.offset) {
 			ret = free_space_next_bitmap(trans, root, path);
 			if (ret)
-				goto out;
+				return ret;
 		}
 
 		next_bit_set = free_space_test_bit(block_group, path, end);
@@ -706,11 +706,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_release_path(path);
-	ret = update_free_space_extent_count(trans, block_group, path,
-					     new_extents);
-
-out:
-	return ret;
+	return update_free_space_extent_count(trans, block_group, path, new_extents);
 }
 
 static int remove_free_space_extent(struct btrfs_trans_handle *trans,
-- 
2.47.2


