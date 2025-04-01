Return-Path: <linux-btrfs+bounces-12719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C346AA77A58
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1303A6726
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD6202F83;
	Tue,  1 Apr 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZfL4KNg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F83202F61
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509151; cv=none; b=eD2ydZ17I6nb8Ol2fofF3GsP6nH5j2UaflgPjtR3gfxHGfg6Nf0dGQtqvXG/OpnFDpf93TG8sV8J/DuBni4wwc+mLI3sgeqMtiq5kr//WJsf41UOYV/9JrpaDnYfp8W9mseFfkux4BjMysriU57zOjtf9L6+F9uYfk+lvLzPTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509151; c=relaxed/simple;
	bh=7wbYbugg6ZYVpEkA4oDYqRdd9oPIjzp6f2iMz/klY+A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqjwLPLI1OuXCbXfy8Iy6TL3pkmQg0R0v3f2VHCN8OHzJ+iZnznT8AyFUCEY31hVHXJCHiQQzW6TDJPFzGNHLorTZEbEoya8g8ckqyRhadvNVMMxgGvVx4sUVV+2ZWvAWwexSh+ixl7mnh7ijbfSbxs4+kg2eHj4Ow6JQn+jLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZfL4KNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE6CC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509151;
	bh=7wbYbugg6ZYVpEkA4oDYqRdd9oPIjzp6f2iMz/klY+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cZfL4KNg4UB7jbBnJPmbBZ1sJFKDerFeaZeMsgUOr8HYVWfokDuQMBU1y4UvTXj3o
	 7dEAIKKA19b0QqTkUU/RVLinwTbBRVcKlMs/rdd1IY0NIxHYsG++lz5SjaFTICtyHM
	 ryhL/HFllQCin0iRu++UT234m7FXNfprJ/adN2gcBY5YBPGeY8yWgObEb9ifgq5TZr
	 6rK9U+cSSUYuYB6b/Q+0dfdl2zyvjuJE732g2RdNCHfXkR2k01Wm/wnGrfTVmn7GnS
	 O+9Ske3/U3UyV8VRTXvv+6UJcET4LcXFanC+Lm6PwGF3IMRcdidkLsqRch/iDENBR1
	 B1M1GkQQSkmCA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
Date: Tue,  1 Apr 2025 13:05:45 +0100
Message-Id: <f220d4520f6eef59436eed674af6b8327062842c.1743508707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743508707.git.fdmanana@suse.com>
References: <cover.1743508707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using __clear_extent_bit() we can use clear_extent_bits() since
we pass a NULL value for the cached and changeset arguments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8c21c55be53..784d5a15ef29 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5508,10 +5508,9 @@ static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned in
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		__clear_extent_bit(&device->alloc_state, stripe->physical,
-				   stripe->physical + map->stripe_size - 1,
-				   bits | EXTENT_NOWAIT,
-				   NULL, NULL);
+		clear_extent_bits(&device->alloc_state, stripe->physical,
+				  stripe->physical + map->stripe_size - 1,
+				  bits | EXTENT_NOWAIT);
 	}
 }
 
-- 
2.45.2


