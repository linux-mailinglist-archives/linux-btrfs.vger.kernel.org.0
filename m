Return-Path: <linux-btrfs+bounces-6665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE093A964
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 00:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA58A1C225F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 22:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C6149002;
	Tue, 23 Jul 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Un+bygkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u64wbkxA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA61143C6B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774223; cv=none; b=A4kXd2mNB7RxxIwTSaULwFgCrXxxVinqEm6OZEqk9xj2uqZgjwAYUYc18aPcAgCqsjhgVYblAsfEFz7R7c8HYDxtWoKEG7Gd9k45EHIc+8MIrwQd1uIYXOvPU+yU/7uSXFzRUUk+GCMT4pvTo1YmRIRM341oU3YLDgZkvb3NTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774223; c=relaxed/simple;
	bh=Ke+iM9eq8f1rq8TrHxr0hqGJWuMgS4HAW5B1vbyj+w8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cd7TnXPmEi97vLTpaLzphxz0DihWwzfEgNMvylZyENwWvi5ABU7Ha0XpkFPfhV4PZvR3PZ81adKwRKAEMFczPgQUEzHnA1aWP1iJjKiXSd3H657IA71wqxGfg7eYRfkbZq+cPjv21XaehgAaTeLZCwWezeKciKeYRp8Taz5oTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Un+bygkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u64wbkxA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29ABA138014F;
	Tue, 23 Jul 2024 18:37:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jul 2024 18:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1721774220; x=1721860620; bh=IPDrBvpruZJOrwR1nsLcp
	y+iSJKmnmQvXaJaMFs02LI=; b=Un+bygkduZnhd0YynhiykFnfdjYXkoHfW2mSa
	XDQoZGA2yse42Gsk88V6cZeiTE20PBDG3Z1XnCW3JDFYYYhiqeETFvWXCBCGHyMq
	RsU8xb8L13mFhbc/SIj0+ETXEAF77/UhP+Ke4bov61MOrN5bAXmXFyp5ldedyeEZ
	o6awXdYHLL326eQ9eEeJ4ndaCbg9N68ySEsmQ+h82uUqxf7ouieMtSr3AG/CN2Bo
	FP8iRaqrU0pg5SXYhtRWwJA8NvtMGlJuEOzrpFPYXlkAKNcMN3WePDmdrkSdvlep
	sBMHAGpz4NGN5SftidWEcQ1mC/hUtsniKPn9B/PTbdgwR1q0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721774220; x=1721860620; bh=IPDrBvpruZJOrwR1nsLcpy+iSJKm
	nmQvXaJaMFs02LI=; b=u64wbkxAGIukZN5HsfuqxaBp355YLnbfppySY8nH5I3G
	LpQfrTfdaX1zuYweH7vwS4Zfv72AUVntYfPR59YGaa4FSuhlxK1i/L+b565pKtVh
	cP2BairqA1IFASj1tK3C5RUM1NLyVMyhJMvdmgDUezxC9yvYdEP+LrmR04F2zLt0
	8jqIPq/YiMtLHsOvzLhRVXdTO4giWkQJsGHAo/EVzmjb1pN9z6dfcbaCGNL+AdRP
	dz/wezMTtoLLW2Ug63WIvWhP92oWdSq8Zkm53L/UBhxphyAyZpA6OwnMhKnx41RN
	1mAN4/cyvGooyiTF+SchANxybWx4z6QNbpX0yeb+WA==
X-ME-Sender: <xms:izCgZi-zjvp0TADHgeij6Zmdqeq-1vUX_OS5yl2mEybGPRRQ8zE5Zg>
    <xme:izCgZiuhCB3dUbNN0pdgA2lgqDPBOPxwYO7xcqMJopgHzH-70YnOLoUh5Sjjr5lKH
    ldEbA7rs3sL913fLm0>
X-ME-Received: <xmr:izCgZoCZffKVvY_PSvvrLOO9c7L9-QzKMLPtQsOVnGT4hNyHTs9oQaVBXihuZPDAalPVupgCNWxJWTmkGuQnA7v2xF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:izCgZqfHRt6hNsMJ3OLtGt1mpX5fGk4J_zHpc3AaLlGzK9AvPKVMCw>
    <xmx:izCgZnPQulfmWv4iWJ4iQ7ombn54xwnXtV3PEa7laV3M0u0L2O-2mQ>
    <xmx:izCgZkmvvJYYbtfX6NSH7gyhcJU3xeKeoL5U0X9Qu1pgtb2hNgZqHg>
    <xmx:izCgZpvJuwsXUYQeFR_-WjFhpLNPz3mhkWc7FRRKi3BK7suznEzZgg>
    <xmx:jDCgZgZZ9qBN0AD43CCXHM8Lou-CBysMp3gMuW3q1oXquS_HrgLLzcBy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 18:36:59 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: make cow_file_range_inline honor locked_page on error
Date: Tue, 23 Jul 2024 15:35:29 -0700
Message-ID: <4830592782d102b8f15cb753824caee669e5d8a9.1721774105.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The btrfs buffered write path runs through __extent_writepage which has
some tricky return value handling for writepage_delalloc. Specifically,
when that returns 1, we exit, but for other return values we continue
and end up calling btrfs_folio_end_all_writers. If the folio has been
unlocked (note that we check the PageLocked bit at the start of
__extent_writepage), this results in an assert panic like this one from
syzbot:

BTRFS: error (device loop0 state EAL) in free_log_tree:3267: errno=-5 IO
failure
BTRFS warning (device loop0 state EAL): Skipping commit of aborted
transaction.
BTRFS: error (device loop0 state EAL) in cleanup_transaction:2018:
errno=-5 IO failure
assertion failed: folio_test_locked(folio), in fs/btrfs/subpage.c:871
------------[ cut here ]------------
kernel BUG at fs/btrfs/subpage.c:871!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5090 Comm: syz-executor225 Not tainted
6.10.0-syzkaller-05505-gb1bc554e009e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 06/27/2024
RIP: 0010:btrfs_folio_end_all_writers+0x55b/0x610 fs/btrfs/subpage.c:871
Code: e9 d3 fb ff ff e8 25 22 c2 fd 48 c7 c7 c0 3c 0e 8c 48 c7 c6 80 3d
0e 8c 48 c7 c2 60 3c 0e 8c b9 67 03 00 00 e8 66 47 ad 07 90 <0f> 0b e8
6e 45 b0 07 4c 89 ff be 08 00 00 00 e8 21 12 25 fe 4c 89
RSP: 0018:ffffc900033d72e0 EFLAGS: 00010246
RAX: 0000000000000045 RBX: 00fff0000000402c RCX: 663b7a08c50a0a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900033d73b0 R08: ffffffff8176b98c R09: 1ffff9200067adfc
R10: dffffc0000000000 R11: fffff5200067adfd R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001cbee80
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f076012f8 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__extent_writepage fs/btrfs/extent_io.c:1597 [inline]
extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
btrfs_writepages+0x14d7/0x2760 fs/btrfs/extent_io.c:2373
do_writepages+0x359/0x870 mm/page-writeback.c:2656
filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
__filemap_fdatawrite_range mm/filemap.c:430 [inline]
__filemap_fdatawrite mm/filemap.c:436 [inline]
filemap_flush+0xdf/0x130 mm/filemap.c:463
btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1547
__fput+0x24a/0x8a0 fs/file_table.c:422
task_work_run+0x24f/0x310 kernel/task_work.c:222
exit_task_work include/linux/task_work.h:40 [inline]
do_exit+0xa2f/0x27f0 kernel/exit.c:877
do_group_exit+0x207/0x2c0 kernel/exit.c:1026
__do_sys_exit_group kernel/exit.c:1037 [inline]
__se_sys_exit_group kernel/exit.c:1035 [inline]
__x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
x64_sys_call+0x2634/0x2640
arch/x86/include/generated/asm/syscalls_64.h:232
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f075b70c9
Code: Unable to access opcode bytes at
0x7f5f075b709f.
RSP: 002b:00007ffd1c3f9a58 EFLAGS: 00000246
ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f5f075b70c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI:
0000000000000000
RBP: 00007f5f07638390 R08: ffffffffffffffb8 R09:
0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12:
00007f5f07638390
R13: 0000000000000000 R14: 00007f5f07639100 R15:
00007f5f07585050
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

I was hitting the same issue by doing hundreds of accelerated runs of
generic/475, which also hits IO errors by design.

I instrumented that reproducer with bpftrace and found that the
undesirable folio_unlock was coming from the following callstack:

folio_unlock+5
__process_pages_contig+475
cow_file_range_inline.constprop.0+230
cow_file_range+803
btrfs_run_delalloc_range+566
writepage_delalloc+332
__extent_writepage # inlined in my stacktrace, but I added it here
extent_write_cache_pages+622

Looking at the bisected-to patch in the syzbot report, Josef realized
that the logic of the cow_file_range_inline error path subtly changing.
In the past, on error, it jumped to out_unlock in cow_file_range, which
honors the locked_page, so when we ultimately call
folio_end_all_writers, the folio of interest is still locked. After the
change, we always unlocked ignoring the locked_page, on both success and
error. On the success path, this all results in returning 1 to
__extent_writepage, which skips the folio_end_all_writers call, which
makes it OK to have unlocked.

Fix the bug by wiring the locked_page into cow_file_range_inline and
only setting locked_page to NULL on success.

Reported-by: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
Fixes: 0586d0a89e77 ("btrfs: move extent bit and page cleanup into cow_file_range_inline")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f38eefc8acd..8ca3878348ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -714,8 +714,9 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offse
 	return ret;
 }
 
-static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
-					  u64 end,
+static noinline int cow_file_range_inline(struct btrfs_inode *inode,
+					  struct page *locked_page,
+					  u64 offset, u64 end,
 					  size_t compressed_size,
 					  int compress_type,
 					  struct folio *compressed_folio,
@@ -739,7 +740,10 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 		return ret;
 	}
 
-	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
+	if (ret == 0)
+		locked_page = NULL;
+
+	extent_clear_unlock_delalloc(inode, offset, end, locked_page, &cached,
 				     clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1043,10 +1047,10 @@ static void compress_file_range(struct btrfs_work *work)
 	 * extent for the subpage case.
 	 */
 	if (total_in < actual_end)
-		ret = cow_file_range_inline(inode, start, end, 0,
+		ret = cow_file_range_inline(inode, NULL, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
 	else
-		ret = cow_file_range_inline(inode, start, end, total_compressed,
+		ret = cow_file_range_inline(inode, NULL, start, end, total_compressed,
 					    compress_type, folios[0], false);
 	if (ret <= 0) {
 		if (ret < 0)
@@ -1359,7 +1363,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	if (!no_inline) {
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, start, end, 0,
+		ret = cow_file_range_inline(inode, locked_page, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret <= 0) {
 			/*
-- 
2.45.2


