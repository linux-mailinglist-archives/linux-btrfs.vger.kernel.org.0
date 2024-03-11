Return-Path: <linux-btrfs+bounces-3180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874FD8782DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418CF2831A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C245010;
	Mon, 11 Mar 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg34+JUg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF444C68;
	Mon, 11 Mar 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169951; cv=none; b=pdquxHNRAtoabXQLSJzs3c4JBMKwjbGu0nqjxdWOmFNxx00FyhKjY+5whxCwiFTzW7a1+RnSLE7cHOfCj7YtfstvCSe+v4nw+fJRJ59jX92AxajZzVY9Cyrx6FyQCi4b1KxqMAy3FS6jIfYjA5N91p27wXUWPPPx8B6JM6SpG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169951; c=relaxed/simple;
	bh=vOIDdeDxdOI0karp+xCw4ebzSWVXYKI3oMsxVYitKmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnLGRP/cvRo3LtHMBWMsu3I3DZyd+eyisS7fE3Nx7FM1AvQ2zyVp2p037rpYB2RVKT4h+J4omHOmbW7XtvnH0HCQrJAYJwcu79Zvc7dXH4m0Xp0f/gTh0hINDKxPsSxvE5LSBsiTptS8DJcijNeeSfDvoVZA3K1r3igljCWjWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg34+JUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA97C43394;
	Mon, 11 Mar 2024 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169950;
	bh=vOIDdeDxdOI0karp+xCw4ebzSWVXYKI3oMsxVYitKmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kg34+JUgfJcQ2KuVY8TzIVPkiOp83BrY9C4dyktfb3tkO4uCiein0a9UvM5IwWAPt
	 Nc0fpqXheKCEYGs4GS7MBusK6TbQZYhZpA9liy6lAi813yMiZG4qxA5L0gKlVWOCyx
	 rrCprssliDJ/N81NvedUe3tpR4rcpvy5AzHv7KhoOBWNj88vIWJJ8OVYmKOubYu+A/
	 4jYXb5Oz2feo+YEn40zoTkXG/tJZyYGkl3wOG+KkNpKo7Ll3O+6eWlY3hOqI1Mz+tf
	 xDlBWymz3zQHgFUvF6MciQ4alMojrG+C0RByjNSRlwVNnXfLGJdI3wuZXPmHRg5IxR
	 1FUZoneZBqFTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	HAN Yuwei <hrx@bupt.moe>,
	Boris Burkov <boris@bur.io>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 04/23] btrfs: zoned: don't skip block group profile checks on conventional zones
Date: Mon, 11 Mar 2024 11:11:44 -0400
Message-ID: <20240311151217.317068-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 5906333cc4af7b3fdb8cfff1cb3e8e579bd13174 ]

On a zoned filesystem with conventional zones, we're skipping the block
group profile checks for the conventional zones.

This allows converting a zoned filesystem's data block groups to RAID when
all of the zones backing the chunk are on conventional zones.  But this
will lead to problems, once we're trying to allocate chunks backed by
sequential zones.

So also check for conventional zones when loading a block group's profile
on them.

Reported-by: HAN Yuwei <hrx@bupt.moe>
Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe/#t
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3779e76a15d64..524532f992746 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1661,6 +1661,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
+	/* Reject non SINGLE data profiles without RST */
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
+	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
 	if (cache->alloc_offset > cache->zone_capacity) {
 		btrfs_err(fs_info,
 "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
-- 
2.43.0


