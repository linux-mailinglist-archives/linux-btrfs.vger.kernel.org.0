Return-Path: <linux-btrfs+bounces-6871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52A940FFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD2EB2BE56
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7E1A2C27;
	Tue, 30 Jul 2024 10:33:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6421A255A;
	Tue, 30 Jul 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335610; cv=none; b=bZX161U96ZqlNrX4mZXPOG67z/IC5/PhQPxLWTfZz/4xjeBm3OYTZLvqJhT3EDcxpb1MYJWZeCLOe/YjQGs1l6dNmGdS37A5G17qlxJBAQ059nDgLuk0w6WXlugQl4P+MsX0ImmikCeEgzIDE+60jOqiASPAu5qhWFa/TAyEQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335610; c=relaxed/simple;
	bh=inXac3o0DMNwtWuz/S+UQ8nNGZTrTw9eBeIrM2lygBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtikOeosfWU8Rwrb+GMSxi2ylsLsOtsCPvWNxoTNkIBBFBJXHbYFkvhPQxIeXElsxid3YeoZQstVd/zKfWxKmbLXjozQjK0YqQSTi0ZeRPw1ZSHK4xoDvUGjghfoZfqUAwtgtgdW4mr7BYHKmlK4IBqhiiMDDJherXYwlzwafNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9e25008aso571508766b.0;
        Tue, 30 Jul 2024 03:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335607; x=1722940407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JXRICrVSgwEXzupbqfI6N6cbUtwrkjonRVE0qX8bW0=;
        b=LpO2K9kdt4RW+032fWZhvlJke8BW4TjXgVXPoamMbmMIPJ6VlQnH7X1FQ0Z9Saw+d8
         4XRYQ9ffniFu4LQHC33VhNQqXWEKn0LCeeUsKBac8REh8WwCn8Jz6uanlPFZUjJ2cJZD
         FC6xZOnXP5fSdv04cMBokz/VZ/E8K8C5nJb4ObbbXq1lBcF/GBetgujyhL04TL9nDzjW
         GW4xx0GIaUarcirIhe5wDazxRYhXZfpqCRip8+plRADL6NoSDal7QVpSmKSS0MZRrPEX
         0CHs9ri+A+T6JVrUMgtIYY5ij7BBTl/+9B9znp6ZgMHtuSK9R4VAUp3haoypTqRoSvGz
         Y/qA==
X-Forwarded-Encrypted: i=1; AJvYcCUXpnRKxcnF4c80hYKUWDewxUqjM1u/KHlunZIA6bW+n0X7Wt95tFFzYxhz1TxqbU89sSo2O+DDBQV0FHzehtDmo9TrkH6q0LL4jghv
X-Gm-Message-State: AOJu0YwX8bt0IrGmxaRz8C/SvDKlZChtoPTvuiGNZAm/n4nMWw1/qf4Z
	NPpP/CG/FVUR8yr5QJmGR3zpWFzfKjhtw9RhNMA6aR8J8KwpZQXjpaqYCQ==
X-Google-Smtp-Source: AGHT+IE3h/RAYumh9bRKQMeW38yf55/++7hMbfZeT4ue92SxlAfRGOpLoZrRW3YA8/JQpEHE+5sJEw==
X-Received: by 2002:a17:907:944b:b0:a77:e7cb:2982 with SMTP id a640c23a62f3a-a7d40074761mr687079166b.26.1722335606405;
        Tue, 30 Jul 2024 03:33:26 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:26 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 30 Jul 2024 12:33:17 +0200
Subject: [PATCH v2 4/5] btrfs: don't readahead the relocation inode on RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-debug-v2-4-38e6607ecba6@kernel.org>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <jthumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=jth@kernel.org;
 h=from:subject:message-id; bh=8m/cLckIEbQtJPusx/1iIS9tmFdurtQoeVckBLSN0yo=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStOFgg6yqidSzC7daGb+0OZ02c19+asOPecrNSuY8F/
 zZZV7se6ihlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJyDkx/K/dynm7e+2xNNXd
 fk4ab/4aBYq8ldTbX53jEfPpuE57yCKG/5H2tycc/5cbynqkRXG534SZC/8EtZzyvvn8xbqlGxS
 l1vAAAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <jthumshirn@wdc.com>

On relocation we're doing readahead on the relocation inode, but if the
filesystem is backed by a RAID stripe tree we can get ENOENT from the
lookup.

But readahead doesn't handle the error and submits invalid reads to the
device, causing an assertion in the scatter-gather list code:

  BTRFS info (device nvme1n1): balance: start -d -m -s
  BTRFS info (device nvme1n1): relocating block group 6480920576 flags data|raid0
  BTRFS error (device nvme1n1): cannot find raid-stripe for logical [6481928192, 6481969152] devid 2, profile raid0
  ------------[ cut here ]------------
  kernel BUG at include/linux/scatterlist.h:115!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 1012 Comm: btrfs Not tainted 6.10.0-rc7+ #567
  RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
  RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
  RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
  RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
  R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
  FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000002cd11000 CR3: 00000001109ea001 CR4: 0000000000370eb0
  Call Trace:
   <TASK>
   ? __die_body.cold+0x14/0x25
   ? die+0x2e/0x50
   ? do_trap+0xca/0x110
   ? do_error_trap+0x65/0x80
   ? __blk_rq_map_sg+0x339/0x4a0
   ? exc_invalid_op+0x50/0x70
   ? __blk_rq_map_sg+0x339/0x4a0
   ? asm_exc_invalid_op+0x1a/0x20
   ? __blk_rq_map_sg+0x339/0x4a0
   nvme_prep_rq.part.0+0x9d/0x770
   nvme_queue_rq+0x7d/0x1e0
   __blk_mq_issue_directly+0x2a/0x90
   ? blk_mq_get_budget_and_tag+0x61/0x90
   blk_mq_try_issue_list_directly+0x56/0xf0
   blk_mq_flush_plug_list.part.0+0x52b/0x5d0
   __blk_flush_plug+0xc6/0x110
   blk_finish_plug+0x28/0x40
   read_pages+0x160/0x1c0
   page_cache_ra_unbounded+0x109/0x180
   relocate_file_extent_cluster+0x611/0x6a0
   ? btrfs_search_slot+0xba4/0xd20
   ? balance_dirty_pages_ratelimited_flags+0x26/0xb00
   relocate_data_extent.constprop.0+0x134/0x160
   relocate_block_group+0x3f2/0x500
   btrfs_relocate_block_group+0x250/0x430
   btrfs_relocate_chunk+0x3f/0x130
   btrfs_balance+0x71b/0xef0
   ? kmalloc_trace_noprof+0x13b/0x280
   btrfs_ioctl+0x2c2e/0x3030
   ? kvfree_call_rcu+0x1e6/0x340
   ? list_lru_add_obj+0x66/0x80
   ? mntput_no_expire+0x3a/0x220
   __x64_sys_ioctl+0x96/0xc0
   do_syscall_64+0x54/0x110
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fcc04514f9b
  Code: Unable to access opcode bytes at 0x7fcc04514f71.
  RSP: 002b:00007ffeba923370 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcc04514f9b
  RDX: 00007ffeba923460 RSI: 00000000c4009420 RDI: 0000000000000003
  RBP: 0000000000000000 R08: 0000000000000013 R09: 0000000000000001
  R10: 00007fcc043fbba8 R11: 0000000000000246 R12: 00007ffeba924fc5
  R13: 00007ffeba923460 R14: 0000000000000002 R15: 00000000004d4bb0
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
  RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
  RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
  RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
  R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
  FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fcc04514f71 CR3: 00000001109ea001 CR4: 0000000000370eb0
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled
  ---[ end Kernel panic - not syncing: Fatal exception ]---

So in case of a relocation on a RAID stripe-tree based file system, skip
the readahead.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b592fc8cf368..5a6066f6db42 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -36,6 +36,7 @@
 #include "relocation.h"
 #include "super.h"
 #include "tree-checker.h"
+#include "raid-stripe-tree.h"
 
 /*
  * Relocation overview
@@ -2965,21 +2966,26 @@ static int relocate_one_folio(struct reloc_control *rc,
 	u64 folio_end;
 	u64 cur;
 	int ret;
+	bool use_rst =
+		btrfs_need_stripe_tree_update(fs_info, rc->block_group->flags);
 
 	ASSERT(index <= last_index);
 	folio = filemap_lock_folio(inode->i_mapping, index);
 	if (IS_ERR(folio)) {
-		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
-					  index, last_index + 1 - index);
+		if (!use_rst)
+			page_cache_sync_readahead(inode->i_mapping, ra, NULL,
+						  index,
+						  last_index + 1 - index);
 		folio = __filemap_get_folio(inode->i_mapping, index,
-					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					    mask);
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);
 	}
 
 	WARN_ON(folio_order(folio));
 
-	if (folio_test_readahead(folio))
+	if (folio_test_readahead(folio) && !use_rst)
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
 					   folio, index,
 					   last_index + 1 - index);

-- 
2.43.0


