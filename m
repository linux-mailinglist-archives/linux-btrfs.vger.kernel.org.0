Return-Path: <linux-btrfs+bounces-12338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45CA65502
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C6F1729CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F02459E5;
	Mon, 17 Mar 2025 15:04:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEC21C194
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223859; cv=none; b=p1PZWzFqHLjxsHIWdZUXn1aBwajcM//fGA/TohJGpy4zFzEG/DZ7jdxMDXCg1Oq8vvZaG+QUDaabz6MH4a2+PoZ0gl35ClK3ya8kEvb9OUoNatj5Q5zr5vy2QSGesO5l9QyOdqxYvZb42oOFy+2zk4zOltX0XPIB9apFW9dxE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223859; c=relaxed/simple;
	bh=q04Db7S4eldjnUNNiBO5smfMPJwCaCK7T9PDmCqsJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kt4guYkjxAOdrE6lO0wSXlM7GGOpaDnnkIaPsfhmY9vpz+bPST7CLi7CmafoUxm8wbsNN/nLIqCzCbxnuldRNRzTkqslTpEhoZLrt8+WdZzUj9fOIB/cWcJku6o+Nfb37Cqj23TiyS7kkXWrthcpJt3kpsitV+YmkyUNihghpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3965c995151so3073753f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 08:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223856; x=1742828656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASQe8lDOQ23qUVHhcC6JJtQXzS0YiCy9PrUwvQzUClE=;
        b=nArUD5sIWi5dsjoh3FuvMVPmeVLfFyHE0HWC/TI8FWcM4lp4gVaCA1n2TGrXrLvizy
         qD98XScaKxtlxO/iID0GYq8we3xw692SXT/T99yKwRrZg9Nqdm2k4g/ugSeTxLgzumXD
         KrKkjVkrvN8qLWJTEuU88+dt5CrjNUqZV1x6u5l2cORiNXvmOYs7S4Aczf6nNqdeh2u2
         s3OVoZCOhaNZtJs6LFLJ6QOmjVfv67mftYlO7ltgISEBWfgyS7RmrGXmZFNCOzhhqEk5
         7j9lTlJmm4ukfpjrqAzLKxnHb3sQqrNOpnhWJVBLlVmqOgTqCXzCyAuXrpvX3O/+RCdP
         zBAA==
X-Gm-Message-State: AOJu0YwaidzAFzOIgvLv5u758vEnUdzV9K68vcsZ55vLtaVSooluRiKx
	Ph/Sc5epm6ByLYdI7tl/QjW3I5pZtJj7BjozYHt3rnaQuz0z2fug6tlyIw==
X-Gm-Gg: ASbGncurzY8WFffQW0xFMsMYXxQ9klxfH4QffN/7m+SZbSEmdetkw/5bUCDj7kUem89
	W8XEaEd+43dM4Cia9llDTrPO7okrb0QPLxll44k756UWtjODz57+Akx3tXjkOwpY8Ot18XKXk7Q
	2tWirscW0svZp13Hy/IUpmrChVBFYx4T72+D82l80yudWCV6zmsCwNUup9OVui4rJ+5BlyLEAXM
	YLGrZI2y/Sz1numUNaJZmQUyr2XK+TMH+dNxjiKh4sOsmQYwBtNbav79MRwgwnBuvZXxlB42Bit
	98Vu/lDXqRjuN+7Nxz+zFNos1xFvun1SNIENJdNEG/SoBVQVWMYgsmr/dSAAOnyILYFfaJrxJ5A
	pq6RPr5Zy6U4vfjfFLMrOgQQQ9r4=
X-Google-Smtp-Source: AGHT+IG/to55uIEr1IgMhzfbjImPdAbJEUTw4T8JTU7p4R/JNpO+Y7rmyeaABaBkhSKtQwCLRhNSZg==
X-Received: by 2002:adf:9bc4:0:b0:391:4052:a232 with SMTP id ffacd0b85a97d-3971f7f9ac2mr11224767f8f.55.1742223855319;
        Mon, 17 Mar 2025 08:04:15 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71d1000fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71d:1000:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60d37sm107025355e9.27.2025.03.17.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:04:14 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	=?UTF-8?q?=E8=A5=BF=E6=9C=A8=E9=87=8E=E7=BE=B0=E5=9F=BA?= <yanqiyu01@gmail.com>
Subject: [PATCH] btrfs: zoned: return EIO on RAID1 block group write pointer mismatch
Date: Mon, 17 Mar 2025 16:04:01 +0100
Message-ID: <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

There was a bug report about a NULL pointer dereference in
__btrfs_add_free_space_zoned() that ultimately happens because a
conversion from the default metadata profile DUP to a RAID1 profile on two
disks.

The stacktrace has the following signature:

   BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile
   BUG: kernel NULL pointer dereference, address: 0000000000000058
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page
   PGD 0 P4D 0
   Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
   RIP: 0010:__btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
   RSP: 0018:ffffa236b6f3f6d0 EFLAGS: 00010246
   RAX: 0000000000000000 RBX: ffff96c8132f3400 RCX: 0000000000000001
   RDX: 0000000010000000 RSI: 0000000000000000 RDI: ffff96c8132f3410
   RBP: 0000000010000000 R08: 0000000000000003 R09: 0000000000000000
   R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000000
   R13: ffff96c758f65a40 R14: 0000000000000001 R15: 000011aac0000000
   FS: 00007fdab1cb2900(0000) GS:ffff96e60ca00000(0000) knlGS:0000000000000000
   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 0000000000000058 CR3: 00000001a05ae000 CR4: 0000000000350ef0
   Call Trace:
   <TASK>
   ? __die_body.cold+0x19/0x27
   ? page_fault_oops+0x15c/0x2f0
   ? exc_page_fault+0x7e/0x180
   ? asm_exc_page_fault+0x26/0x30
   ? __btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
   btrfs_add_free_space_async_trimmed+0x34/0x40
   btrfs_add_new_free_space+0x107/0x120
   btrfs_make_block_group+0x104/0x2b0
   btrfs_create_chunk+0x977/0xf20
   btrfs_chunk_alloc+0x174/0x510
   ? srso_return_thunk+0x5/0x5f
   btrfs_inc_block_group_ro+0x1b1/0x230
   btrfs_relocate_block_group+0x9e/0x410
   btrfs_relocate_chunk+0x3f/0x130
   btrfs_balance+0x8ac/0x12b0
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? __kmalloc_cache_noprof+0x14c/0x3e0
   btrfs_ioctl+0x2686/0x2a80
   ? srso_return_thunk+0x5/0x5f
   ? ioctl_has_perm.constprop.0.isra.0+0xd2/0x120
   __x64_sys_ioctl+0x97/0xc0
   do_syscall_64+0x82/0x160
   ? srso_return_thunk+0x5/0x5f
   ? __memcg_slab_free_hook+0x11a/0x170
   ? srso_return_thunk+0x5/0x5f
   ? kmem_cache_free+0x3f0/0x450
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? syscall_exit_to_user_mode+0x10/0x210
   ? srso_return_thunk+0x5/0x5f
   ? do_syscall_64+0x8e/0x160
   ? sysfs_emit+0xaf/0xc0
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? seq_read_iter+0x207/0x460
   ? srso_return_thunk+0x5/0x5f
   ? vfs_read+0x29c/0x370
   ? srso_return_thunk+0x5/0x5f
   ? srso_return_thunk+0x5/0x5f
   ? syscall_exit_to_user_mode+0x10/0x210
   ? srso_return_thunk+0x5/0x5f
   ? do_syscall_64+0x8e/0x160
   ? srso_return_thunk+0x5/0x5f
   ? exc_page_fault+0x7e/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   RIP: 0033:0x7fdab1e0ca6d
   RSP: 002b:00007ffeb2b60c80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdab1e0ca6d
   RDX: 00007ffeb2b60d80 RSI: 00000000c4009420 RDI: 0000000000000003
   RBP: 00007ffeb2b60cd0 R08: 0000000000000000 R09: 0000000000000013
   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
   R13: 00007ffeb2b6343b R14: 00007ffeb2b60d80 R15: 0000000000000001
   </TASK>
   CR2: 0000000000000058
   ---[ end trace 0000000000000000 ]---

The 1st line is the most interesting here:

 BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile

When a RAID1 block-group is created and a write pointer mismatch between
the disks in the RAID set is detected, btrfs sets the alloc_offset to the
length of the block group marking it as full. Afterwards the code expects
that a balance operation will evacuate the data in this block-group and
repair the problems.

But before this is possible, the new space of this block-group will be
accounted in the free space cache. But in __btrfs_add_free_space_zoned()
it is being checked if it is a initial creation of a block group and if
not a reclaim decision will be made. But the decision if a block-group's
free space accounting is done for an initial creation depends on if the
size of the added free space is the whole length of the block-group and
the allocation offset is 0.

But as btrfs_load_block_group_zone_info() sets the allocation offset to
the zone capacity (i.e. marking the block-group as full) this initial
decision is not met, and the space_info pointer in the 'struct
btrfs_block_group' has not yet been assigned.

Fail creation of the block group and rely on manual user intervention to
re-balance the filesystem.

Afterwards the filesystem can be unmounted, mounted in degraded mode and
the missing device can be removed after a full balance of the filesystem.

Fixes: b1934cd60695 ("btrfs: zoned: handle broken write pointer on zones")
Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
Reported-by: 西木野羰基 <yanqiyu01@gmail.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fb8b8b29c169..7c502192cd6b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1659,7 +1659,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * stripe.
 		 */
 		cache->alloc_offset = cache->zone_capacity;
-		ret = 0;
 	}
 
 out:
-- 
2.43.0


