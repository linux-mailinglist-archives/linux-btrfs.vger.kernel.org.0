Return-Path: <linux-btrfs+bounces-13908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07BAB4199
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196C319E2B25
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC8829993E;
	Mon, 12 May 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUEo4rib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D8298CA2;
	Mon, 12 May 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073073; cv=none; b=DszWDZxPwa5aleup5mHHhBvoVnmOlnnTwreXHzr0sACk2axEqU8PgxURLGghCtW0WHUz4tVJGF+GW7s3asAKOWrISw01nP0hSi2YvJTBBCKvVwsSQAerVq5amP6MEHQzoBkWvLvGDjZ3omBMV0gDx7MqelNntsXuZ/6ISyu8TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073073; c=relaxed/simple;
	bh=xStKnA6U9lcfKhZ6B+oTjTHUZ7Bca6fjfZlrc3KxMfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezB2cmFKoUgcJMh4uFxH3x3j14D8WIA26LciBWF68L+AbeHNTz/cp0Yll9sv7FiXmHYACiwm4owAbZF0IdA4fSO8EPS48dgr0lrGLnm+yYVto0K4gQsb5vB92uAR4+CpyPMgU3aFk7wAmxK0+eNgZEZDAcNUMhheSqpEbVQLv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUEo4rib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9013C4CEF0;
	Mon, 12 May 2025 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073073;
	bh=xStKnA6U9lcfKhZ6B+oTjTHUZ7Bca6fjfZlrc3KxMfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUEo4rib7EQg/oMjHZ67Xs6epRAgH5nR56umEtHd8v/yU7ceLfo1UAPYNTA5rqVbg
	 ouAnWILBX5K1P92KJz3quD4UtpxT2fR/U5XnxJRLMkKiYx3JdoORfgbAsPf79sjroE
	 I/GpXe33HO1KgN9cUBlPbrpspmVmBL8I5qf0kdbl+v5Rko21E4iC+NvMwtyhLcrKol
	 QOLiDaMcZM+IbtN7fVsTUsXYbCk1csytkoN9NzEe2cqcSoMBw8+yN8/v2h1tBOEe1s
	 UffmQvAMnIUEZyClbTBnA1km5hzgaBrqUOyUIq/LJYPv8uWnuEaVMLJJlw7MK69KXg
	 Qhmqn7j0clgtg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/11] btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref
Date: Mon, 12 May 2025 14:04:17 -0400
Message-Id: <20250512180426.437627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180426.437627-1-sashal@kernel.org>
References: <20250512180426.437627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.28
Content-Transfer-Encoding: 8bit

From: Goldwyn Rodrigues <rgoldwyn@suse.de>

[ Upstream commit bc7e0975093567f51be8e1bdf4aa5900a3cf0b1e ]

btrfs_prelim_ref() calls the old and new reference variables in the
incorrect order. This causes a NULL pointer dereference because oldref
is passed as NULL to trace_btrfs_prelim_ref_insert().

Note, trace_btrfs_prelim_ref_insert() is being called with newref as
oldref (and oldref as NULL) on purpose in order to print out
the values of newref.

To reproduce:
echo 1 > /sys/kernel/debug/tracing/events/btrfs/btrfs_prelim_ref_insert/enable

Perform some writeback operations.

Backtrace:
BUG: kernel NULL pointer dereference, address: 0000000000000018
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 115949067 P4D 115949067 PUD 11594a067 PMD 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 1 UID: 0 PID: 1188 Comm: fsstress Not tainted 6.15.0-rc2-tester+ #47 PREEMPT(voluntary)  7ca2cef72d5e9c600f0c7718adb6462de8149622
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
 RIP: 0010:trace_event_raw_event_btrfs__prelim_ref+0x72/0x130
 Code: e8 43 81 9f ff 48 85 c0 74 78 4d 85 e4 0f 84 8f 00 00 00 49 8b 94 24 c0 06 00 00 48 8b 0a 48 89 48 08 48 8b 52 08 48 89 50 10 <49> 8b 55 18 48 89 50 18 49 8b 55 20 48 89 50 20 41 0f b6 55 28 88
 RSP: 0018:ffffce44820077a0 EFLAGS: 00010286
 RAX: ffff8c6b403f9014 RBX: ffff8c6b55825730 RCX: 304994edf9cf506b
 RDX: d8b11eb7f0fdb699 RSI: ffff8c6b403f9010 RDI: ffff8c6b403f9010
 RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000010
 R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8c6b4e8fb000
 R13: 0000000000000000 R14: ffffce44820077a8 R15: ffff8c6b4abd1540
 FS:  00007f4dc6813740(0000) GS:ffff8c6c1d378000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000018 CR3: 000000010eb42000 CR4: 0000000000750ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  prelim_ref_insert+0x1c1/0x270
  find_parent_nodes+0x12a6/0x1ee0
  ? __entry_text_end+0x101f06/0x101f09
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  btrfs_is_data_extent_shared+0x167/0x640
  ? fiemap_process_hole+0xd0/0x2c0
  extent_fiemap+0xa5c/0xbc0
  ? __entry_text_end+0x101f05/0x101f09
  btrfs_fiemap+0x7e/0xd0
  do_vfs_ioctl+0x425/0x9d0
  __x64_sys_ioctl+0x75/0xc0

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/btrfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index af6b3827fb1d0..3b16b0cc1b7a6 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1924,7 +1924,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)
-- 
2.39.5


