Return-Path: <linux-btrfs+bounces-13906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA356AB417B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7DC4A1129
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBE297B8B;
	Mon, 12 May 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU9HgGKY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE6296D3F;
	Mon, 12 May 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073048; cv=none; b=SIKJtCBZcIgosql+cRibKvxdPzXwDDxFcHa20rGI5mhlSUgEGdr6ETe6KTl6RdxtxkcABwJTr0JWvWjvfY5t+5Rg3oGB7zb7YQHYIK9ukgRvvbGWJQ1pasah3D/t5VnWjRmATQbGjxOfWXG3r3ZTl4i+yMnKso7jI/qkJT5/SmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073048; c=relaxed/simple;
	bh=dKqeAJXq/3/rZgFh2vJLxh7XbUeyoCvhR1C434bI6lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgIdzUvhVb+ViTlcECrUFlxLhEud3hMfYQVcIo8ckZ+dxQLGg65H4MjeRlsATAQiB3aNrnJ8tnsFwYU5dyicp52FCbpVJsVtKZM3pLANoPa0eHXldevouGGnKQY2Cy2rGQBSWZXyvZFniQ3QcdwjDkfEAljNA8JhzkDOONRkmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU9HgGKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1005C4CEF4;
	Mon, 12 May 2025 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073048;
	bh=dKqeAJXq/3/rZgFh2vJLxh7XbUeyoCvhR1C434bI6lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HU9HgGKYRJQ1nWnmo+N4d92aHK+gdSmUgEElJCmMTL4B0m5J9Xb87tL5VLimiAD/O
	 ejnhWGjci7p7qHjopJkALE8kxr83GhERrOhg4byoQ1bi2DWMnsPrggmtYpIzGwNoH/
	 W+SOLqXi6Y1ASeMIkg9gLPI6wAGQV8UQ5zQhlZjJPDYGAn1uL16LcL3QPFxd368R+B
	 yAiifcwI97CTYuTSA1urWGd0r2dR0DvHFIBsuyIGZ8bsBJUTB2725jSj/F7xccmY41
	 O3wkaZ0EIkxGnJQEYGhczkxCgmklVUsKt8ciJrTvXYcicASoiGlX0RDp98oh/kFbCL
	 NDTT46tjBQUJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 07/15] btrfs: avoid NULL pointer dereference if no valid csum tree
Date: Mon, 12 May 2025 14:03:42 -0400
Message-Id: <20250512180352.437356-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit f95d186255b319c48a365d47b69bd997fecb674e ]

[BUG]
When trying read-only scrub on a btrfs with rescue=idatacsums mount
option, it will crash with the following call trace:

  BUG: kernel NULL pointer dereference, address: 0000000000000208
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  CPU: 1 UID: 0 PID: 835 Comm: btrfs Tainted: G           O        6.15.0-rc3-custom+ #236 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
  RIP: 0010:btrfs_lookup_csums_bitmap+0x49/0x480 [btrfs]
  Call Trace:
   <TASK>
   scrub_find_fill_first_stripe+0x35b/0x3d0 [btrfs]
   scrub_simple_mirror+0x175/0x290 [btrfs]
   scrub_stripe+0x5f7/0x6f0 [btrfs]
   scrub_chunk+0x9a/0x150 [btrfs]
   scrub_enumerate_chunks+0x333/0x660 [btrfs]
   btrfs_scrub_dev+0x23e/0x600 [btrfs]
   btrfs_ioctl+0x1dcf/0x2f80 [btrfs]
   __x64_sys_ioctl+0x97/0xc0
   do_syscall_64+0x4f/0x120
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

[CAUSE]
Mount option "rescue=idatacsums" will completely skip loading the csum
tree, so that any data read will not find any data csum thus we will
ignore data checksum verification.

Normally call sites utilizing csum tree will check the fs state flag
NO_DATA_CSUMS bit, but unfortunately scrub does not check that bit at all.

This results in scrub to call btrfs_search_slot() on a NULL pointer
and triggered above crash.

[FIX]
Check both extent and csum tree root before doing any tree search.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 531312efee8df..5d0060eb8ff4c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1541,8 +1541,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	u64 extent_gen;
 	int ret;
 
-	if (unlikely(!extent_root)) {
-		btrfs_err(fs_info, "no valid extent root for scrub");
+	if (unlikely(!extent_root || !csum_root)) {
+		btrfs_err(fs_info, "no valid extent or csum root for scrub");
 		return -EUCLEAN;
 	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
-- 
2.39.5


