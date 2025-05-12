Return-Path: <linux-btrfs+bounces-13911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A31AB4208
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5C97B6EB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30029B8E7;
	Mon, 12 May 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhoKODdH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236329B8D0;
	Mon, 12 May 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073097; cv=none; b=TZI14UeMwrUVNeqCb38zjAjwcCRzA9N97E8ToO69J9C5Xuo0ughcrU+9YIht6wgDzW6tZEo12a80guu8dwJGZZfh4/NVO275KrLHbKNDFdvSjqTCRVUCKCz3M/5VgNkUCAyxJxNntFunEBKo+w4vDT9I2aOQp+ydVCnhftb+3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073097; c=relaxed/simple;
	bh=7mDPZUktq6Nd9HT2mM48jlNdx8YT1qRVgsR70+8BShQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYBepwoKmR0Lzo+YN5+/dtn5j1Grd/VvjDmAWlTNpt+JWRAU24Ds7YvVefIkbN2LJQobyUtaJ/XtmSl6PsbtfPuaSM8dvB6JTnWnWv4IXslEGckhx4GSzRv4FZCy08DckZ58nSGukVJFkw8lj9I8i91+PB3U4nFKT2+c/8Xwil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhoKODdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4277C4CEE7;
	Mon, 12 May 2025 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073097;
	bh=7mDPZUktq6Nd9HT2mM48jlNdx8YT1qRVgsR70+8BShQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LhoKODdH3ujv1zMBu+EoIwT1qxeKsSBrEokD/QBqSelLoFrfGRJoNUQ5VVXlH+kYR
	 a3v/yDMcjwlmW2qiynDOb5q1vvwqTlKZs4HrD4sNJBsXLW64cgj+Dy6bzjlzJcCGtQ
	 Ue9olwSdZbxNRANmf0F9phMfZbM22UopPRCosM+9q1rDLI6A1S0uH8YtXPRh80GTyO
	 eburh2GBQaIbsWdzILZp8SWIca7iY0FXic/b8sHtsK1wqT1jz4kLRSeAYOzMOVQk2S
	 zmfb3vQLluTuew9IvPCDK17/3xC5heU5W2SccQ7HFDn4QQ1LLk28LRXMrl6bwcmKah
	 /xyGz+vqpfNfA==
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
Subject: [PATCH AUTOSEL 6.6 1/6] btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref
Date: Mon, 12 May 2025 14:04:47 -0400
Message-Id: <20250512180452.437844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
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
index 3c4d5ef6d4463..8ea1674069fe8 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1956,7 +1956,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)
-- 
2.39.5


