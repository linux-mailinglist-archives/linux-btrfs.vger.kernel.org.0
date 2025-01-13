Return-Path: <linux-btrfs+bounces-10949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356AA0C185
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F916BE1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC51F9433;
	Mon, 13 Jan 2025 19:32:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725C1D5CFD;
	Mon, 13 Jan 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796723; cv=none; b=e/yzauoA+aYU/fdLQHuvRu9zAcTdq+3msqtNQ9g9/ToQ4ODMUMtfv6swpfCR2EmOpqt6pxZRVusjaQ6Bq3qm0MApVMzd/dlrsHncucFYCB/vCIRxGVPCXVRWIcBumgIQQXCZDyb1UwwUeHUdW/L0eyzQVgE8HknAlHw/RH5UxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796723; c=relaxed/simple;
	bh=O82KFeFW8NSShxFoXcxPlu5/R6MAVIb/w3nv/RCbFuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V028w9Tl7l5U8LLijz1geAWGSqOkoZjepaYpfJM633q1FU/pvF5OwlFO6YAG90K1u/e380lDOIeC2kcw13oZlyDnpVsSx+Q40U87Ksj0IlpUwPc5QkAGQH8xyPL4bkyyEcvOxL7VStgpFzzCTzMwAi0ezGNYS68nTAaH+UsXdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43624b2d453so49118665e9.2;
        Mon, 13 Jan 2025 11:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796718; x=1737401518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV5IpmvSzypxFoaN7RsKRkmHAYNYQyXRvoPh6kZbF2Y=;
        b=VVVxwdb/MYJPgTSSCashG4sSbyXv8jdNoCnVp2AxepHH2TgQxHwRV9wu3Xe+oc3cJ/
         PXTDPkkovmjUozu+k6Nj0BAS1ywyAb7H8VzXs6VpB485btaIgAgdxTFsH26eSfvR5FE0
         j8xVuSAQr5SdwcJmhvlSpBmb10I6Yun6EBDcdaQ+jyoMzBVSNsMhNccE4lRVFM3fbyxp
         JM42PHTS3AbshhZO8Jxg6bWaK07Dsu7Cj8Z1CmLrNP8XL0Cx1B9yeGxC7oVT7vnaoyXE
         4KnepsK9qHfoAVzhsJaJ/Wr/OLwKeLZy+i4UCaorOH00FnevxP3c40ZZ5ECbDE+RRYay
         8//w==
X-Forwarded-Encrypted: i=1; AJvYcCUIPPzVwxvqO85l+frul2vGOIbE/yGBDLOH8VejldrL7xD8NcK3xdZYrbZIIkTTMdFUUNmlnIr36+hsOxYG@vger.kernel.org, AJvYcCXY4Mpzsl05F43lr0y6ov1q7FUcfD7PD3Z7H7gQiAD2cI6UfmlZEnY9D79RP1olvPk0IBNmhWLeVgybwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycEhOjll1EfVwrC5cDkM9l6Meyv0zBXy9wYg/UTs/7CnvUyjeC
	Id2zMZli6Vs+JV+vkghflLwJbi9Lb4zWP4tEY2TWxJaa8m+9VqRM
X-Gm-Gg: ASbGnctP+q21cEFpzrlth/7lCjUTVosZnHR/6p/bCHm1UO/zpu9clKJC4NllYUpANpg
	EEynlVtIZL0B4M3RRHrbDTEBtSfqTwAqazYlucH9cxfmsFDJsSvs55VDhe4nAGBCFL1Lj6tG8oD
	1aU4IMSPcEkfWISB3vd9W8M6Hi9pLUpC4zKs6SeWBpHE4Y/HyS83mrO52GJTCk9vdmBKcrivcJI
	FhDoqU8eUg5fOPoraaF/JvSEpN81AhWSJUIq0ZZbnpAp7eedeNEohWcZJGvK5rQ394Lbh/QN1JR
	Dr8Jap6rF/G2ZepdiVZcufX0opkbTpf9+g1/
X-Google-Smtp-Source: AGHT+IEYLm32Ve0ngCgebfXxVIdp0LGD+a7JoKzmquP0MvVMtPKP8816+q2P4sz3E5UwvybYuX1DbQ==
X-Received: by 2002:a05:600c:1f81:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-436e26995b8mr207760305e9.9.1736796718254;
        Mon, 13 Jan 2025 11:31:58 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:57 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:49 +0100
Subject: [PATCH v4 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-8-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5791; i=jth@kernel.org;
 h=from:subject:message-id; bh=Wk/SePVaY9KJFyHv7vnAuJtNbOOn8eIkKNcDPrSyOJM=;
 b=kA0DAAoW0p7yIq+KHe4ByyZiAGeFaiWjQvQVenMH+pIWgYGkPD3SSIaeGehR7dpsgiu5anjbe
 oh1BAAWCgAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAmeFaiUACgkQ0p7yIq+KHe5KNwD9HiP1
 /tret06ZkZLXQ0YjZFNBcqeACYZCJlq097B771gBAIZMGZVwda6w2oBSX6E1p5aF8M9WB15nC7v
 vsLt51kEH
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
stripe-tree, as this can lead to corruption of the tree, which is caught
by the checks in btrfs_set_item_key_safe():

 BTRFS info (device nvme1n1): leaf 49168384 gen 15 total ptrs 194 free space 8329 owner 12
 BTRFS info (device nvme1n1): refs 2 lock_owner 1030 current 1030
  [ snip ]
  item 105 key (354549760 230 20480) itemoff 14587 itemsize 16
                  stride 0 devid 5 physical 67502080
  item 106 key (354631680 230 4096) itemoff 14571 itemsize 16
                  stride 0 devid 1 physical 88559616
  item 107 key (354631680 230 32768) itemoff 14555 itemsize 16
                  stride 0 devid 1 physical 88555520
  item 108 key (354717696 230 28672) itemoff 14539 itemsize 16
                  stride 0 devid 2 physical 67604480
  [ snip ]
 BTRFS critical (device nvme1n1): slot 106 key (354631680 230 32768) new key (354635776 230 4096)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.c:2602!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 UID: 0 PID: 1055 Comm: fsstress Not tainted 6.13.0-rc1+ #1464
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 RIP: 0010:btrfs_set_item_key_safe+0xf7/0x270
 Code: <snip>
 RSP: 0018:ffffc90001337ab0 EFLAGS: 00010287
 RAX: 0000000000000000 RBX: ffff8881115fd000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000ffffffff
 RBP: ffff888110ed6f50 R08: 00000000ffffefff R09: ffffffff8244c500
 R10: 00000000ffffefff R11: 00000000ffffffff R12: ffff888100586000
 R13: 00000000000000c9 R14: ffffc90001337b1f R15: ffff888110f23b58
 FS:  00007f7d75c72740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa811652c60 CR3: 0000000111398001 CR4: 0000000000370eb0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x14/0x1a
  ? die+0x2e/0x50
  ? do_trap+0xca/0x110
  ? do_error_trap+0x65/0x80
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? exc_invalid_op+0x50/0x70
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? asm_exc_invalid_op+0x1a/0x20
  ? btrfs_set_item_key_safe+0xf7/0x270
  btrfs_partially_delete_raid_extent+0xc4/0xe0
  btrfs_delete_raid_extent+0x227/0x240
  __btrfs_free_extent.isra.0+0x57f/0x9c0
  ? exc_coproc_segment_overrun+0x40/0x40
  __btrfs_run_delayed_refs+0x2fa/0xe80
  btrfs_run_delayed_refs+0x81/0xe0
  btrfs_commit_transaction+0x2dd/0xbe0
  ? preempt_count_add+0x52/0xb0
  btrfs_sync_file+0x375/0x4c0
  do_fsync+0x39/0x70
  __x64_sys_fsync+0x13/0x20
  do_syscall_64+0x54/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f7d7550ef90
 Code: <snip>
 RSP: 002b:00007ffd70237248 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
 RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d7550ef90
 RDX: 000000000000013a RSI: 000000000040eb28 RDI: 0000000000000004
 RBP: 000000000000001b R08: 0000000000000078 R09: 00007ffd7023725c
 R10: 00007f7d75400390 R11: 0000000000000202 R12: 028f5c28f5c28f5c
 R13: 8f5c28f5c28f5c29 R14: 000000000040b520 R15: 00007f7d75c726c8
  </TASK>

While the root cause of the tree order corruption isn't clear, using
btrfs_duplicate_item() to copy the item and then adjusting both the key
and the per-device physical addresses is a safe way to counter this
problem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index a5dc97210b16701a23549204bdadea0c554b6bb9..9ea07a98eda3d52449c96c6921afe4cc94c38e6a 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,12 +13,13 @@
 #include "volumes.h"
 #include "print-tree.h"
 
-static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 					       struct btrfs_path *path,
 					       const struct btrfs_key *oldkey,
 					       u64 newlen, u64 frontpad)
 {
-	struct btrfs_stripe_extent *extent;
+	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
+	struct btrfs_stripe_extent *extent, *newitem;
 	struct extent_buffer *leaf;
 	int slot;
 	size_t item_size;
@@ -27,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.type = BTRFS_RAID_STRIPE_KEY,
 		.offset = newlen,
 	};
+	int ret;
 
 	ASSERT(newlen > 0);
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
@@ -34,17 +36,31 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	item_size = btrfs_item_size(leaf, slot);
+
+	newitem = kzalloc(item_size, GFP_NOFS);
+	if (!newitem)
+		return -ENOMEM;
+
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
 	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
 		struct btrfs_raid_stride *stride = &extent->strides[i];
 		u64 phys;
 
-		phys = btrfs_raid_stride_physical(leaf, stride);
-		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+		phys = btrfs_raid_stride_physical(leaf, stride) + frontpad;
+		btrfs_set_stack_raid_stride_physical(&newitem->strides[i], phys);
 	}
 
-	btrfs_set_item_key_safe(trans, path, &newkey);
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto out;
+
+	btrfs_release_path(path);
+	ret = btrfs_insert_item(trans, stripe_root, &newkey, newitem, item_size);
+
+out:
+	kfree(newitem);
+	return ret;
 }
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)

-- 
2.43.0


