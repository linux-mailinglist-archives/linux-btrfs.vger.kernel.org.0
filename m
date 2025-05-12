Return-Path: <linux-btrfs+bounces-13912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7BAB42C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7CD7A1B47
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23429C330;
	Mon, 12 May 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA1rIAW9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40AF29B8FD;
	Mon, 12 May 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073099; cv=none; b=P8LJ1sn5S9L4qGB6IKll+C26aE8x6MrIyIBmzu2mH4RX1hESg4yiZoWPgudaJ/LHp06uuJc85kk7y5CBtktTchGFjn4u+hLtiYVGeXw9nmFbtz7a0x8ExpNtYol52FDJlSPNIc1WJL9YYxPW0N6ptafqYnpLpYBmvzycpJnTVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073099; c=relaxed/simple;
	bh=UCnHjw6AMlh96+0g3s1wWA2J2KlhdmrNkFn6QL6vA24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHS3jLNgi9nJovV5CyXo5SWsBNLHXJCklddJJIqAb5JlLQ81HTKy8G7QEcDJGhIwakOmPy2W3OVjd1en4ACIt6jAS3XU6+a24KojClbjaeT+S1CZiegBfUYBRAbrGFlYpcJI2G0mewf1B2S55YU5TzoVyvOkmY/BdZtmSTi3koE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA1rIAW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D56C4CEE7;
	Mon, 12 May 2025 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073098;
	bh=UCnHjw6AMlh96+0g3s1wWA2J2KlhdmrNkFn6QL6vA24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NA1rIAW9WMyFdHejF9vJLeJok5Xs4yMEQB3HSrkKFHimLxib5D+jaV6FoTlbDnl7Z
	 3cmRFMp3LP9+xwWKrFEN/5rCqXhvY1n18+QgAVpk9ydSTAi/fAUkZKakUMrDbA6Tr+
	 QmXixCPtn/9Un7rMdyfO/OmJYsrBlXFiKkVmVDQQtLJTX6JHJLYsCP4pWcUCt48EK+
	 HtPIEkANK4RONEuwQ5uorr2/Ud6yPM0Lb30YsvEiaBvPJETARlMv2VMKaXMl4zI0xQ
	 zVn/zvPN9N1+XamAHxgTCxQVvBHYD9Y7o9zP8/eQ+rlFDkY+fQZ38GzUpqMZ9TDt/1
	 W/x9q8u+QykCA==
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
Subject: [PATCH AUTOSEL 6.6 2/6] btrfs: avoid NULL pointer dereference if no valid csum tree
Date: Mon, 12 May 2025 14:04:48 -0400
Message-Id: <20250512180452.437844-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180452.437844-1-sashal@kernel.org>
References: <20250512180452.437844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.90
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
index 6be092bb814fd..da49bdb70375b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1538,8 +1538,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
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


