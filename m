Return-Path: <linux-btrfs+bounces-10861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8FA07B9C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8868E3AA68D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662E224894;
	Thu,  9 Jan 2025 15:15:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF621D5BE;
	Thu,  9 Jan 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435733; cv=none; b=au2YunWryrArJ9rbroLD6pTrnYHPaMdlg++IZRcYV78IJgJUaEhWqfWc1p8V1aDqilN660Ma4JCpvCCC+WdFT4Jwc6KkWJDca0wuGeqvpZQpIAWmuRJPwa6y6vuPoR7FyF50SqyZwLvgXkQUPv7XpBvdmi4Ma6ZVjawUUzaztU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435733; c=relaxed/simple;
	bh=iOUBr9vnm9rlrsY3YOAvgr1queRyQczGA5qSRr33m9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnuM0W4pIex9DSbZaKimxRbk9QueNtolVdcZZ0vY1ewAc4LTjFFyc0ZMdjfACXu7LCSCZK2cqYLBCxsFUZQ9ey2gNbEpb5k68zNhCEuYUckhp98tIjHsZPwvmFsEoeF3YORrpAINaXpi8+ZLjMBHEbMCdhwob9mKO+AHKEIa55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa692211331so199017366b.1;
        Thu, 09 Jan 2025 07:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435726; x=1737040526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pljSv7QY3Pirg6lfdP8PEgMpw5IukrzApLqHT3bx72M=;
        b=hs5+S4KhuSlrutytP+N9RX1kENSyPgtd1MrYWtO9rGSHyjaSQetV9759RFdu+r8Zc8
         2PXVpTuV9XNcnc1FmI+fGe7K6m/X47elsORJbAbpt2WD8JoguWgMzIvsvWAVKLL+BIkm
         vs7gZ7g/RlD1lRrgj51GBE/7C69az0XSblTcM4GUWI8p9+Ht2+/QfSBu3DHSdyYQNKO+
         uxyS6+mq/jhhGpABg1/CgSeceUYtY2T1fsy1H/z9n+N7CFsYYS+Ag5jI+FaEUPuF7xnp
         282prb+fKBzx0cGrpgWL9UDd9i20Q1rmFe4sN73G4FuOniKztvzTo5bkXTgl9pq1/H9m
         hHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoGX6rX92mmlisWdljDDFZfSMmKxPEM4Qc+GPiOl2mFKjAcONi+J72T4H8iUX+Fx/ta0qIbzjLpAQZoQ==@vger.kernel.org, AJvYcCXB8a7V6HgplKszlebvGKPzMSbTgCgFjzNMd8kT7hUtoIidHwC6AgUXM1nXzzKO0mSJs9fvBmaTXuNFptwq@vger.kernel.org
X-Gm-Message-State: AOJu0YxobkSQJEbZhKgq9zVVwjmwU3Wm5wLSw2/hwquY+oOaY5SaZUSa
	VNbo+lKo99nBGpTt2kIxYI7nggByDGgMYQTNadWHjdJDP7wuB1hP
X-Gm-Gg: ASbGncuG+mfZpElYGmpRidyrvEq4hA9sNMp+5fdEi0P6EBFcKvOvNsfEi0wpjRn+LKz
	AX0nlIObJoaugtsA8rFEezQeRWG+J4jX+WWU4jFw4yKdqAnOjxq+tdngfDnC1ukjVRU+khJBGyF
	6S4pjtr1E0LYxo8U1UYu95F+6lZS4u9imiZMsLH5yf+/6IfWmbHbDp0m6BpJ0Ol2M1ygYSbQ5qw
	+dub754BZovtqEqjGS1UN2Wizyu74JoDIljyeGIa9V2InUfiQy72Y0jolkGbaDs3qqSBWqHtzmA
	9trzGrxOqbB71CVlEcmqmpYoeadfb7SSg5C/
X-Google-Smtp-Source: AGHT+IEnsw+hDxcoSXj6T3wnTBcrwuatmJ/U3ynXMmNHmu4TpSUeH6lBUfT/aBdIYJfOfgo0cPY6RQ==
X-Received: by 2002:a17:907:12cd:b0:aa6:7c36:3428 with SMTP id a640c23a62f3a-ab2c3acf112mr270311666b.0.1736435726135;
        Thu, 09 Jan 2025 07:15:26 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:25 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:09 +0100
Subject: [PATCH v3 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-8-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=jth@kernel.org;
 h=from:subject:message-id; bh=z3Xi2x6xfSi2w+ggmz2oPWTKmTsszHxlh33hmMOG3kM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2DJOhlzopxtYS6Tzb1S7ornHZxhQUJ/Fi5guHS58
 N2e96VSHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjARjwsM/6MSfHo8O2RTZkme
 eZvq8un1o++OXsaWAsZazxYX2ZbGBjH8d/3I+8LfbM1Ltw1WL8pfHZ7x/LRHYsfuu7/uv+beb/a
 xlAkA
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
index e0bb95304dd51eb8e4bcf11281e65092e4551645..f07d898694c2f27a4ca59e4932556de7edf77a10 100644
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


