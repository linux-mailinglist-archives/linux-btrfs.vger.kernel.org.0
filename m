Return-Path: <linux-btrfs+bounces-12273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CFA5FEA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308843BBAB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64C1EE03C;
	Thu, 13 Mar 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOIIkjGd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AA1EDA32
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888545; cv=none; b=EkU8RihNB2xG2cDeq5F8dhzDrr8A4V45rFjfKahJyO2B9ZR9H+R3nyDV0/wBCUVM5D75xSd00TVLiIeLXxHmUBGhp8h2sonefNooHM1uzWVnBkIOGQSl6XKsaTM84OgzSGbkeYUJ0dWWbpfiqLtzqzqTPhMUKBpvp6k2Zl1v12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888545; c=relaxed/simple;
	bh=gRBuMwKWovCkPNcPV1bwatuEGULqlmDYuBJOz+l18go=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJ3IAKY9DtJsasSVw0D4c7Ix/HS5GRKBlY+4la4K1nZ/Ih/+rI4qXfozeefH1IGSyfqtWb2JFwYqBgWfiTQTYscgULWH6YW31lF5VkdQo2WWLT5W9zKyLO90nPtE/44918JF9/Vo6+dRqeKMkItvkGaYhgRmMq16OtVEtpGqlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOIIkjGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32140C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888544;
	bh=gRBuMwKWovCkPNcPV1bwatuEGULqlmDYuBJOz+l18go=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GOIIkjGdYKyilXwI5pe/o09Xarw0bj01hKCcB5Vyg0npl89gjVdx1GiKdMGW4ipAC
	 cEofmJo7s3HPzFmvC+ESTgOHI/I5DT3PBus3OimKMDzoZv1/svnDLErI+ZznGhqOPy
	 gCh6OuElyU2v4VKsenM5C9gFuvwPqMzKeo1JHtx9wYWNOrW9nqQJ35hzZ5ABRmzJAN
	 N6P6aknTfzWjNqFnhMEXIpoXlzbyfbrdNO1ZBYacUgES2yEISM569YvfFH+uYQ3K3p
	 5N5R1Vk1EX5UkjNTawB+pIc56GpqwIEWL9i7UrsbbCqpvJmWpM6b3/Wmv1cVBkGyP9
	 OXf6es7TST9qQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: use memcmp_extent_buffer() at replay_one_extent()
Date: Thu, 13 Mar 2025 17:55:34 +0000
Message-Id: <d9aa316344b6c8c1e4a244ad1c46f3308a83890d.1741887950.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using memcmp(), which requires copying both file extent items
from each extent buffer into a local buffer, use memcmp_extent_buffer() so
that we only need to copy one of the file extent items and directly use
the extent buffer of the other file extent item for the comparison.

This reduces code size, saves one memory copy and reduces stack usage.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 889b388c3708..7e0339f5fb6b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -688,25 +688,18 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	if (ret == 0 &&
 	    (found_type == BTRFS_FILE_EXTENT_REG ||
 	     found_type == BTRFS_FILE_EXTENT_PREALLOC)) {
-		struct btrfs_file_extent_item cmp1;
-		struct btrfs_file_extent_item cmp2;
-		struct btrfs_file_extent_item *existing;
-		struct extent_buffer *leaf;
-
-		leaf = path->nodes[0];
-		existing = btrfs_item_ptr(leaf, path->slots[0],
-					  struct btrfs_file_extent_item);
+		struct btrfs_file_extent_item existing;
+		unsigned long ptr;
 
-		read_extent_buffer(eb, &cmp1, (unsigned long)item,
-				   sizeof(cmp1));
-		read_extent_buffer(leaf, &cmp2, (unsigned long)existing,
-				   sizeof(cmp2));
+		ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
+		read_extent_buffer(path->nodes[0], &existing, ptr, sizeof(existing));
 
 		/*
 		 * we already have a pointer to this exact extent,
 		 * we don't have to do anything
 		 */
-		if (memcmp(&cmp1, &cmp2, sizeof(cmp1)) == 0) {
+		if (memcmp_extent_buffer(eb, &existing, (unsigned long)item,
+					 sizeof(existing)) == 0) {
 			btrfs_release_path(path);
 			goto out;
 		}
-- 
2.45.2


