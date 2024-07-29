Return-Path: <linux-btrfs+bounces-6842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E693F8B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A451F2263F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4615538C;
	Mon, 29 Jul 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgzCVM4a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D962154454
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264688; cv=none; b=gKcejjNQ7NI6p+1gC1h65rzELLcZJkRqvxqqEOOrpfEaTbAC7IHeF2mWxqGaS8sEkj9CVGNiJdU1o5fgqFykHsw6qa2FuGjhv4TkRYPwqq+eG4npiz2RUzh/EgGqnHELCaZ9DaqtIshn/ol9IuV7oz6j8D8t+wK5OntsTJ/8S5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264688; c=relaxed/simple;
	bh=I5p9hXI/BXEX9QMRkJKKBd5FSNIiVgtL7Mdx6VTAdSQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMBMcmqPnIuIfXUZfzY34KWBlmttu1bOxeg6AD034Q2c2CIhXwuZq5l1nS/D3sidLU1DbwZQXyA3sOxsTryDFfMoHHm6DT6HeEq3V9YiVnEo9a0kXy/YPG1IUBrI89a/vdkeOuErATQyIi1bg4K5JNRroRRGedYn8pngTvG3kyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgzCVM4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A67DC4AF0A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264687;
	bh=I5p9hXI/BXEX9QMRkJKKBd5FSNIiVgtL7Mdx6VTAdSQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dgzCVM4aLt5jV/knuGOW26yfn+9Md6E9BLKcI88k7HTHPzw8wxEVTQ47qHWEYHM2v
	 oVqOWoineZbdDZHksubgtRFo5RidzLb9uO/n0AO2oih28c2nEkY87r4HVYw3T8nrQy
	 DIY6vfNyLuMs5qk3qtt9bk6aAMq3uNy3b7jzlcdE1Oxmw4DSvBBPGj3SEW34a27FKc
	 n/KwHUrTYJVFJQhvKAiW6rRoxQ4dxgQvalJWRxpT6rlWTE/p+FLf26NiGZda+xawOn
	 2jCeRceKaRXs/2VT87oJ8MxUeYyAaz9j1mtDIQoOsqxlW6sXtTcSPhhCZZVYdpR7f+
	 E2Jx61M5wPwSw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: reschedule when updating chunk maps at the end of a device replace
Date: Mon, 29 Jul 2024 15:51:22 +0100
Message-Id: <e3c4aaf1800d85bd4ffc397c2a8b8c291818e286.1722264391.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722264391.git.fdmanana@suse.com>
References: <cover.1722264391.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At the end of a device replace we must go over all the chunk maps and
update their stripes to point to the target device instead of the source
device. We iterate over the chunk maps while holding a write lock and
we never reschedule, which can result in monopolizing a CPU for too long
and blocking readers for too long (it's a rw lock, non-blocking).

So improve on this by rescheduling if necessary. This is safe because at
this point we are holding the chunk mutex, which means no new chunks can
be allocated and therefore we don't risk missing a new chunk map that
covers a range behind the last one we processed before rescheduling.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dev-replace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f638c458d285..20cf5e95f2bc 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -827,6 +827,14 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 	u64 start = 0;
 	int i;
 
+	/*
+	 * The chunk mutex must be held so that no new chunks can be created
+	 * while we are updating existing chunks. This guarantees we don't miss
+	 * any new chunk that gets created for a range that falls before the
+	 * range of the last chunk we processed.
+	 */
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
 	write_lock(&fs_info->mapping_tree_lock);
 	do {
 		struct btrfs_chunk_map *map;
@@ -839,6 +847,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 				map->stripes[i].dev = tgtdev;
 		start = map->start + map->chunk_len;
 		btrfs_free_chunk_map(map);
+		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
 	} while (start);
 	write_unlock(&fs_info->mapping_tree_lock);
 }
-- 
2.43.0


