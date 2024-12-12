Return-Path: <linux-btrfs+bounces-10300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8EB9EE0AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB40188950C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22020B213;
	Thu, 12 Dec 2024 07:56:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABD20C475
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990166; cv=none; b=qZW02X2JHv2cowlyDs+2pnfaIAlfMQX0DKC68XF1/Ej0UdgGaFU3XJx9xJITzhB7y3ACcc8ovMYRIKQ5SB2Qafa9qNWQUUnOCmCbDC/uo4Up0uQK9GNwuOAZ77MO/dxF3y9liqgGsrE3ayEoxBQE6mWH6qmdqhydnDhHYnVEFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990166; c=relaxed/simple;
	bh=4QqCu13Uy5cHu+8lHHKkGF5lSxstAF4etbLQpPYmRw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGeAzy1/B6k0DWN6I6fyM8EiKaOXOy5f6Up6aFfGEy5icLplDZuy5GKpjV3y9AQdR6EQDt0cfGWBQgqsniZlH1/zt/6/j4ogJ5fj787N3mWaWiOUzdwoHGp+5TaIUKdl9otgHTbStt6/4DiV6VfQKMqYjptQ4zYPcgH9vxiqYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa662795ca3so287551066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990163; x=1734594963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2oADBldU/duH3ovVq73sYfZwo8nJgfMtsDB3Avxygk=;
        b=FUb2/jCb1bXXc35f8yl7XY5ppFOA9mSnqsk1YPst4D74OvlThlLiklYTOzJPCipfU3
         nV4vAdM/ILEmgEQ+G296/CDm7b2WUoVdCXIanWPAnZBmCCimTv13pQp3wPdGDfG8jvgS
         OrE18qjmyIa9qlAkYNQZvW7F/KJpIEtLpjBixUPuUMm/2rnOlRvCNXBIdP0S1JmFli4b
         vwYuVgpVIsA/grj1my7CnyHumPGk71fhBPhx12eig0OlGdQ+sFiVYjz8/kCneFMvcG0G
         8D0sHfhK5nQdBiqarOtvP+6QHt9uOr6GObW1KyxaDGrkFFAvZpmg2Ry9/5GCLNxUiG2W
         7jhg==
X-Gm-Message-State: AOJu0YwWDLDhZbV3OBR2vdWtlR2u8qq55l6BVfE6eBUFNPG5xdvbOC/A
	Q/DK0bIW5lWG4Ehj2yGlnXJIZiMTTSdwE4UNXMFu+vzk2NiurISOZUYVGoSf
X-Gm-Gg: ASbGncv8AfVE0JUh2ClUWBS8O0B4FM2cyRBZvkyJV1rn39+Yj4h2WdG7K+CNrs1a6Jf
	MgsTLz/G60b7N8T/TjZmuM0bvCi6u4xSRQ52oOeCwVO2omW3s2AlGM0hNfgUvyCfxE/RdYCeUN1
	bqkCrztAdr1x4Hq+E6J20qyN0jCJ37qfWuCD5jmPG+cfHRVzHXPNZ/8ADBlgO4vcB2YyGDXFegA
	KddqF+1OJUmuq28E1HXJxCVD4FPqOQ1KJxhvfTvXYYROxVZImCJlLKD/8bliIpaEI7a3aYPP8hm
	RuWNE1hlCji48jFZdvvOPFteu/xgjGAPZahk9gs=
X-Google-Smtp-Source: AGHT+IEDKPVkHPZ4ik8fz1UGuF1sq9O09O1nKpnLIuKHB0rqrsC1bjB50ETzWRnF2EpxZ4k19ETF2A==
X-Received: by 2002:a17:906:9555:b0:aa6:50ee:d44c with SMTP id a640c23a62f3a-aa6c4131cdcmr180151266b.15.1733990162821;
        Wed, 11 Dec 2024 23:56:02 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:02 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
Date: Thu, 12 Dec 2024 08:55:27 +0100
Message-ID: <1b225c76de3d41571e080a03d971a961de26d9bb.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
stripe-tree as this can lead to corruption of the tree, which is caught by
the checks in btrfs_set_item_key_safe():

 BTRFS critical (device nvme1n1): slot 201 key (5679448064 230 32768) new key (5680439296 230 1028096)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.c:2672!
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
index 6ec72732c4ad..f713d8417681 100644
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


