Return-Path: <linux-btrfs+bounces-7186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84709511FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 04:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8511E2824B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DE745F2;
	Wed, 14 Aug 2024 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs+0Wl8W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8955C3E;
	Wed, 14 Aug 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601702; cv=none; b=Wgacbxp6/YluHQvR6OjLkOtRR5Ax64V4GOdyhQ8u7HFGwww1FpjTjZt4wSwo5TW55RVzZ8THEdjdklxm/UzZNXeoUHL+MZIN/BXVGAheHJv8L8l21EeamStAoBSOV5zg/6bRLsplgkBc06cUStnQTvG3E0311c2jl1JfkAUcEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601702; c=relaxed/simple;
	bh=ecEEdzLzjsA3LapQNkdXzpnFwCyu6EmHCFx7CB+gMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUti/q6KbD1S4pSivOaqm/KmBtBitQlO+nfVIU13aRNcVcgSETWX52Pe+EeJNo7waa919RTxGTJ1wy/rAxSxXn1H+31oAAQ/CGnTGQI3J/OxWISsAJxWo23sRS8tUySQ/DVLfHaHceQHVPdO/emjH1UNjaGKgnbU7qD3JwMA2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs+0Wl8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E3C32782;
	Wed, 14 Aug 2024 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601702;
	bh=ecEEdzLzjsA3LapQNkdXzpnFwCyu6EmHCFx7CB+gMUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fs+0Wl8WXg1JxBS4vJwJoTEbjA+6fXPdKh5rJQXClnL/nhPKsExuyuDG4xGtWh55A
	 AzZRLiGlKUk74jHBArDVeYxdePyetIDye5O9YHK0z9gzYSqUPAqmHO6TDBBeeKs0Kt
	 ErnbxjMffe2HtPQx0khMJ5aiQcnjP0tZTXqgZcp3GSLZXdoxSjoSzsPXeWrIX7FvWW
	 UoFf4cYtaSZQ1vtQyKEsxvFdp84Fpz3oooHXRyPAfdSpV0UQPqSCROBSiIqX5j0qqz
	 VZvQUZNhgPMcNeNLRW9BhdM0A7IKnUyTJnZXzKNjePo21FtO6LOginZyeoPJbokATR
	 SUtrqo2qCBdew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	terrelln@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 07/13] btrfs: fix qgroup reserve leaks in cow_file_range
Date: Tue, 13 Aug 2024 22:14:38 -0400
Message-ID: <20240814021451.4129952-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 30479f31d44d47ed00ae0c7453d9b253537005b2 ]

In the buffered write path, the dirty page owns the qgroup reserve until
it creates an ordered_extent.

Therefore, any errors that occur before the ordered_extent is created
must free that reservation, or else the space is leaked. The fstest
generic/475 exercises various IO error paths, and is able to trigger
errors in cow_file_range where we fail to get to allocating the ordered
extent. Note that because we *do* clear delalloc, we are likely to
remove the inode from the delalloc list, so the inodes/pages to not have
invalidate/launder called on them in the commit abort path.

This results in failures at the unmount stage of the test that look like:

  BTRFS: error (device dm-8 state EA) in cleanup_transaction:2018: errno=-5 IO failure
  BTRFS: error (device dm-8 state EA) in btrfs_replace_file_extents:2416: errno=-5 IO failure
  BTRFS warning (device dm-8 state EA): qgroup 0/5 has unreleased space, type 0 rsv 28672
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 22588 at fs/btrfs/disk-io.c:4333 close_ctree+0x222/0x4d0 [btrfs]
  Modules linked in: btrfs blake2b_generic libcrc32c xor zstd_compress raid6_pq
  CPU: 3 PID: 22588 Comm: umount Kdump: loaded Tainted: G W          6.10.0-rc7-gab56fde445b8 #21
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
  RIP: 0010:close_ctree+0x222/0x4d0 [btrfs]
  RSP: 0018:ffffb4465283be00 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffffa1a1818e1000 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: ffffb4465283bbe0 RDI: ffffa1a19374fcb8
  RBP: ffffa1a1818e13c0 R08: 0000000100028b16 R09: 0000000000000000
  R10: 0000000000000003 R11: 0000000000000003 R12: ffffa1a18ad7972c
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f9168312b80(0000) GS:ffffa1a4afcc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f91683c9140 CR3: 000000010acaa000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? close_ctree+0x222/0x4d0 [btrfs]
   ? __warn.cold+0x8e/0xea
   ? close_ctree+0x222/0x4d0 [btrfs]
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? close_ctree+0x222/0x4d0 [btrfs]
   generic_shutdown_super+0x70/0x160
   kill_anon_super+0x11/0x40
   btrfs_kill_super+0x11/0x20 [btrfs]
   deactivate_locked_super+0x2e/0xa0
   cleanup_mnt+0xb5/0x150
   task_work_run+0x57/0x80
   syscall_exit_to_user_mode+0x121/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f916847a887
  ---[ end trace 0000000000000000 ]---
  BTRFS error (device dm-8 state EA): qgroup reserved space leaked

Cases 2 and 3 in the out_reserve path both pertain to this type of leak
and must free the reserved qgroup data. Because it is already an error
path, I opted not to handle the possible errors in
btrfs_free_qgroup_data.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39d22693e47b6..c2f48fc159e5a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1586,6 +1586,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     locked_page, &cached,
 					     clear_bits,
 					     page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 		start += cur_alloc_size;
 	}
 
@@ -1599,6 +1600,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     &cached, clear_bits, page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 	}
 	return ret;
 }
@@ -2269,6 +2271,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
+		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
 	return ret;
-- 
2.43.0


