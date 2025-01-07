Return-Path: <linux-btrfs+bounces-10769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A3A03FC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234FC1887E90
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BE1F2C5D;
	Tue,  7 Jan 2025 12:48:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CA1F03F0;
	Tue,  7 Jan 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254080; cv=none; b=h0il6G/fSrgYmx5VCAeVH7tzIAKYwNZ4taB0sEnGI+51e0rWtLK219lmf18lsKmNdjXh/J+DGxG2Gl622NL/5VmpKI3ZoAJBWPIqyde587zS+UAMPuvbWVKPQi2bLvA+dflNzyjOEbqGebWIm9v9tXeJ5RVeeUvk/HehDteK4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254080; c=relaxed/simple;
	bh=I85BPA74WANccPzPo7y6mE+E1q3qybDn2+rKMeMi5Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esG2gXA8Knjw5qklpZ0uYOx6LF6xsh4ytUjTTBjhAVILcuDSDp6PGvZazTW2FlBBynQOFYB4S6cpnN8bWQ/QmT4UeTssiuTZ6h4D+x6lhukredA12jfdZNQB6V/JXUBdBO8XM1vonrKRc+Eo1++PLgrzT16kLfD6yVei9HzbWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso106851975e9.0;
        Tue, 07 Jan 2025 04:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254075; x=1736858875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCFXJ4bPN7GjxGZnZEmd9wZjo3kp25RgFP16fnw213M=;
        b=PxBXnADAfNiIKcBKa3cV+i8A+Q5j/wx1KpfEiZe1SMAs7I7i43bpwF5gCN3lvNg8/Q
         Uf95x5wJGHduDvHC4+cK8OqK/a/ilg7QQ1yeTjKk3FMHtssXmWHDBpODCgjNQD4dsSkz
         rthdiWiYsRHRTg/zVLyvqtRY9crStQFl7+ESc9GAf7gng6jK6hdvsmfVvIoKHQwYRFYi
         KpExO7mT88+uoJGMTPLvsQFkcykQFSyG6EFYu/V+KU1x7Iv9wT1waInWxiMTWI7eVJ2q
         hMg9MWNf77WvAadqbi6VLNQejV5gevAztZbv1jxbMMyiAV7R9f8avL/O1TIHmyNFJwu5
         zqlw==
X-Forwarded-Encrypted: i=1; AJvYcCWIHzokOkq9n4lSB3kpa8cjM9nnKWi4mokIM3JB/qeu0etEwyJuiGtaguu3xAWYgU41bJxxc7Ioe8ZI9V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39N7RpKOiEKvM8cXDkIt/PhtxkHZEbyXsE7dtZc7R8GudUE5d
	2miyJm4MxwIem81te6Y6m/Xky0/WD6bJ+61qJHZKaPE6lLjLYARpWMGLBQ==
X-Gm-Gg: ASbGncuE1E4TfnfYyKWFCqy+DI3qPzo977gcPPZMYWxYHkv+PFYUdmE/wRBjri5GAP5
	YA4vsLBF4lkr8AW+CzJSLMRBNLiBaqAevYoj+l2+HKphChJRAlL3mN0KVeuL4gRbv5K4grpG7NI
	rHio9kKS6IEQHf2ARZiqUoiqBBP1phaEezqIvZ8MT3KZrWU92pskBCvF6pKCT6kAYXw105snTFv
	SVdK069xCdTrHUV1eCZa08FBRe/7Yv4sfopf0DsmNkUcUL27ZNrgx55TE6/HGGffo8eQeug6AYA
	LFFTHIbwgnvaMjFWZ8hX1oWJUW/wH5XhU90/
X-Google-Smtp-Source: AGHT+IFd6SW1E56yTMBIeAlZWFSGkFjqW3J8uGqWiUE08QZuh2t3tEtCRGvJ1wot5hm4B07VQPplYQ==
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4366790e3fdmr582778405e9.0.1736254074861;
        Tue, 07 Jan 2025 04:47:54 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:54 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:38 +0100
Subject: [PATCH v2 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650; i=jth@kernel.org;
 h=from:subject:message-id; bh=OYXWebrPVzfgGPih4xV3ZZ2/GhP86lPYcyXfDLrTdCo=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhVumZi0reXR2ksX6xcwfWCdEPJzxY3/KpkcMjfTW
 5+oz3y0qqOUhUGMi0FWTJHleKjtfgnTI+xTDr02g5nDygQyhIGLUwAm4rCT4TebdY9AQWlkTmNH
 mrPULcGIQ9/O/Q1dLv15os/D85acfJYM/yy1Xhkfirj5/O+U7lqhKT2hc4S+u7C+m/1g35WvN6U
 WzGECAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
stripe-tree as this can lead to corruption of the tree, which is caught by
the checks in btrfs_set_item_key_safe():

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

Instead copy the item, adjust the key and per-device physical addresses
and re-insert it into the tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index d15df49c61a86a4188b822b05453428e444920b5..a4225ad043216e5d7035a71eab6bcc49b242836f 100644
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
+	struct btrfs_stripe_extent *extent, *new;
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
+	new = kzalloc(item_size, GFP_NOFS);
+	if (!new)
+		return -ENOMEM;
+
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
 	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
 		struct btrfs_raid_stride *stride = &extent->strides[i];
 		u64 phys;
 
-		phys = btrfs_raid_stride_physical(leaf, stride);
-		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+		phys = btrfs_raid_stride_physical(leaf, stride) + frontpad;
+		btrfs_set_stack_raid_stride_physical(&new->strides[i], phys);
 	}
 
-	btrfs_set_item_key_safe(trans, path, &newkey);
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto out;
+
+	btrfs_release_path(path);
+	ret = btrfs_insert_item(trans, stripe_root, &newkey, new, item_size);
+
+out:
+	kfree(new);
+	return ret;
 }
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)

-- 
2.43.0


