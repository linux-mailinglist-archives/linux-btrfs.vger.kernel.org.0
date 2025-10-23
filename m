Return-Path: <linux-btrfs+bounces-18210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10199C0249B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB33AC407
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A41274B28;
	Thu, 23 Oct 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVTQeXMO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546629AB03
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235227; cv=none; b=V+Kudl8au4lSgKXZ2S/baGZlPJJBekB/68QMdOsyImOdpW33Q8NT8vOHbjTNEkYsN+prNJu1/dd1I7KhJlwH0C7htDNwCeBfbfE9jt7poF1i/sNgmM1lHigJS9ozjMR2tOr9R5j82UG7pfORL1pHdM4RX9SQdHLIXzMXoa1j53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235227; c=relaxed/simple;
	bh=14MQECk7j4g0Niq4sNy+gUcIQhHER89lZ7qnR6ip6As=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfNTAyA5OB5pXxIP57xSs/Q5mBnpxw2WrDZ81K5oBzJhbtphA/cGvPsbgEnZyglEsYfjLCGA2XxtF8wytWX+lz8ZUOMiyjVCAsg4Rq/mz/yEuaMdsKkvdhKnHcE5FSfifixLy8/LAwvuYvz0B6O3w5YpV1yvcMwm/Km8FPI2e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVTQeXMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3408C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235227;
	bh=14MQECk7j4g0Niq4sNy+gUcIQhHER89lZ7qnR6ip6As=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EVTQeXMO95u2QOnVoVgyk0p4KmaszW8aXex9PdzvvBgZbvIQd25sBueIMNsnt4CkH
	 Kqx0lKGzdKF62+IK3ImdC7rESonxVwejWDiIKUPucmKlj+w9dcFqxLSbKeRqqZqkmb
	 UlVp/xFo35kp6koAOpKjWKVuzGQV0sRkkc1J9G5s1cz3GnDmHZ63q25KW7IzKqfch8
	 /8TU2C3ZMm5B8doLVifatqkoFY2GI6F/ioVqPleeqMwyXAWFX42VspwbYQZaADPiTW
	 i8fCnG87arbdTzeBv96LP+xasciiQ46WF6+oD3v5TnMuKBn+mWXlfAwvrkKTdNRgGi
	 HJmwbnTqRvKVw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 23/28] btrfs: reduce block group critical section in unpin_extent_range()
Date: Thu, 23 Oct 2025 16:59:56 +0100
Message-ID: <2d7f6ce7b2d184ab9e9ff97ffae27a0cfc60bdae.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to update the bytes_pinned, bytes_readonly and
max_extent_size fields of the space_info while inside the critical section
delimited by the block group's lock. So move that out of the block group's
critical section, but sill inside the space_info's critical section.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36963b4a6303..d839d8d32412 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2747,13 +2747,12 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 	struct btrfs_free_cluster *cluster = NULL;
 	u64 total_unpinned = 0;
 	u64 empty_cluster = 0;
-	bool readonly;
 	int ret = 0;
 
 	while (start <= end) {
 		u64 len;
+		bool readonly;
 
-		readonly = false;
 		if (!cache ||
 		    start >= cache->start + cache->length) {
 			if (cache)
@@ -2797,20 +2796,21 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 
 		spin_lock(&space_info->lock);
 		spin_lock(&cache->lock);
+		readonly = cache->ro;
 		cache->pinned -= len;
+		spin_unlock(&cache->lock);
+
 		btrfs_space_info_update_bytes_pinned(space_info, -len);
 		space_info->max_extent_size = 0;
-		if (cache->ro) {
+
+		if (readonly) {
 			space_info->bytes_readonly += len;
-			readonly = true;
 		} else if (btrfs_is_zoned(fs_info)) {
 			/* Need reset before reusing in a zoned block group */
 			btrfs_space_info_update_bytes_zone_unusable(space_info, len);
-			readonly = true;
-		}
-		spin_unlock(&cache->lock);
-		if (!readonly && return_free_space)
+		} else if (return_free_space) {
 			btrfs_return_free_space(space_info, len);
+		}
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.47.2


