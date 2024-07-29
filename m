Return-Path: <linux-btrfs+bounces-6830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF093F4C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7331C220EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E211487DA;
	Mon, 29 Jul 2024 12:00:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C711474D9;
	Mon, 29 Jul 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254418; cv=none; b=t6ViAYozRL+RyZkcO3jrtxAFOp2EP0WqyiOTcjzoq4g1s8v6tEYsW+dIly18h6PX85Tsh7LQHd9Mr+wHP0ydVUFTOm1zFtvNXUjH3K0JMSdE8yroQNTMB5L0MYbkDtYVXVCct46b0qJh4PeejF2/pGzDTTLvOrd9QODSU3XXBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254418; c=relaxed/simple;
	bh=inXac3o0DMNwtWuz/S+UQ8nNGZTrTw9eBeIrM2lygBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEsBubLnYfSTMYcNlP4Ah+/3rhjVvoNZm5VqaVRdVydampNnRtCZ/P4djVFmnBPeYSf+BcYiP4MqAr7FEArSBoAsljWn6r6bqgEMxY6OGV/XtUaoO3IfJcn4SrhYyIqPnEgpn3StQUK6/aSQbJJ/nVkNkFmNRc4k1mNB6QIdDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efbc57456so3515086e87.1;
        Mon, 29 Jul 2024 05:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254414; x=1722859214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JXRICrVSgwEXzupbqfI6N6cbUtwrkjonRVE0qX8bW0=;
        b=dTs9S5ZipmfLpIchfyovdLcoI1Zj3cIWdXx9TA6e/HT19JDtqxo9YBKEMW6b35tyr/
         esm/bsBNS3kngTnDngM8T/rasW7SUURDnMrmcPfvvS05jwjeokQUSL3IOdfb88CVVI5F
         A5Wu1Afcf0pJBexaDf/FFcOjKAYAQyEJBobkmBFFMaoPN/wvQ35uj66ymvMjRXyXi3wx
         mj0BsIB7r0Us5bLRRIanV1rnrisoBZ3aw2H/9SPRxbnaCHEqvFSwB+zEuUKquDFM/rTj
         V0+QMxB8BKooGik46u8RcSPts7tPgvKuauDSEYZHzxKtTUyf8MZX5zqaOVjXRrUI6Uz0
         2rMA==
X-Forwarded-Encrypted: i=1; AJvYcCXZKGraBC3CoM12lga1f/KIA5IfWum40wkOXQCXUgdaYRILJy5ClMm1z6Wvi36IAUtAYnJacqFNdysBDy8SksykRHgR73xcUocs03uY
X-Gm-Message-State: AOJu0Yz3qG9p990qISzrCM+5kxUKNg9hXH9JX7urQWu6XZ8DUsHxrNW8
	0vH3jiyvI9aYQaLCxEn/GLx/NJdVrdSkzMHB+4O/Kv/CPy5IBEPFsUirLQ==
X-Google-Smtp-Source: AGHT+IFYlL2IQFhyuBafJblUyBmfmGapaaK+5VmhiLUrObv8+5c9f1lSgoPrQmYmRLyvetwDiwXlRQ==
X-Received: by 2002:a05:6512:1043:b0:52e:987f:cfc6 with SMTP id 2adb3069b0e04-5309b2ce440mr5150158e87.51.1722254414462;
        Mon, 29 Jul 2024 05:00:14 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm508136266b.18.2024.07.29.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:00:14 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 29 Jul 2024 14:00:05 +0200
Subject: [PATCH 4/4] btrfs: don't readahead the relocation inode on RST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-debug-v1-4-f0b3d78d9438@kernel.org>
References: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
In-Reply-To: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <jthumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=jth@kernel.org;
 h=from:subject:message-id; bh=8m/cLckIEbQtJPusx/1iIS9tmFdurtQoeVckBLSN0yo=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQtb/EMW5KS/oHFtUYr/OOiRXm7ErbrXb4qpdC03y135
 my32XXmHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRN0kM/93ECq6qG9b0FpcJ
 Z72t+FfSEvC4dYv8t3e+tzib7exUDjEyPLjw2vLN0qR/7lGm67ja1rGVyP2tto67qBMSZdz4YaU
 EFwA=
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


