Return-Path: <linux-btrfs+bounces-5531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77B900293
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D780EB2575B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76219066C;
	Fri,  7 Jun 2024 11:46:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8E18FC87
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760808; cv=none; b=iE4noPw4FWJYXaNI92hQiOk5LqPsZDcf5sZ26h4s7Ws9ToMaJmvGk03yIO5lenx46hkCeDaCFIeuR6Lox6pHvy9b8fKdAy2ikwVlEq9zG/WYbkPetqU5WKR7LS2aKZBvKkPVSvb65NulIvBgJwQC6KHXcSYHUyFLnsDfbekjJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760808; c=relaxed/simple;
	bh=IKv1Riy61ZJBdS8JOhL11JDO7WMArJzMpkeZgF9D+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObHlTf9Id7eJJki3JvHkHYOwSOnMWfUhVyeGvI+sVkMwwva1PFTlSiB7FmOHjFYap1N51osx4FnvCe/XzPaoTeoCLd05Vdh68iMWE3SXnSDhLws3VsU7H1faeS6+E9RfbGg+vo5c6PRPGVXlL/xawl5YtXPFf0sAY4htC95BsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68b54577aaso261677666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 04:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760804; x=1718365604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0f/N5uUdEF1m/ht38ES/rfa9fQqXzF4DY0+9F7YfA8=;
        b=cuwXAPu25kFGoIg8bKBLQ+YR8VoTLLu/zDgoGfiUWWiswG+LOor3fBKjDBU2lwSb4n
         IGEkDCAT6irA8PwoayDiaDxzO4sZl6B3w64ONzF8ONJe9wgkwflOmXvuJskfhbVwj2Tl
         64MuUK3vClU54UdWdplBmJUHAvhnUzwbxhFCw1H285xfI1lYsKaSvmZan7AaN8B/SPZh
         UpogoxYthTFYbkxZ/4M2YfVex0KxQ35pO5xEjmbHbkrcCxxekBUAPzS0p7lvMHFnBWHJ
         jKbDBYsU0ivonfrRUp+XFYhDjm9Y/scctRRq2X6HS/Jj6Y/ZZXDEbAc5Yo95/ZOa2Ex9
         iyuw==
X-Gm-Message-State: AOJu0YxIYt2bDDU3P1zW2hZaABih6Y6SFk+4NBB+or7o7kTjf4A5cEsO
	lRClj809gjbAc5KcECU33IrOxLraDmeopIjwLE/Fn/aNsfEg9XKL4LUFsA==
X-Google-Smtp-Source: AGHT+IEDUr5Ifn+GY5O72ON2W4xr/v6TQMC15neXfwG8qxK+X1M09nOuoZo7GVz55YqD0DLTHqzxyw==
X-Received: by 2002:a17:906:a850:b0:a69:1219:2e2d with SMTP id a640c23a62f3a-a6cd76a939dmr158801166b.35.1717760804211;
        Fri, 07 Jun 2024 04:46:44 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6eb5f04dbbsm37466966b.169.2024.06.07.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:46:43 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes
Date: Fri,  7 Jun 2024 13:46:28 +0200
Message-ID: <20240607114628.5471-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Shin'ichiro reported that when he's running fstests' test-case
btrfs/167 on emulated zoned devices, he's seeing the following NULL
pointer dereference in 'btrfs_zone_finish_endio()':

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
 CPU: 4 PID: 2332440 Comm: kworker/u80:15 Tainted: G        W          6.10.0-rc2-kts+ #4
 Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
 Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
 RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]

 RSP: 0018:ffff88867f107a90 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff893e5534
 RDX: 0000000000000011 RSI: 0000000000000004 RDI: 0000000000000088
 RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1081696028
 R10: ffff88840b4b0143 R11: ffff88834dfff600 R12: ffff88840b4b0000
 R13: 0000000000020000 R14: 0000000000000000 R15: ffff888530ad5210
 FS:  0000000000000000(0000) GS:ffff888e3f800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f87223fff38 CR3: 00000007a7c6a002 CR4: 00000000007706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? die_addr+0x46/0x70
  ? exc_general_protection+0x14f/0x250
  ? asm_exc_general_protection+0x26/0x30
  ? do_raw_read_unlock+0x44/0x70
  ? btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
  btrfs_finish_one_ordered+0x5d9/0x19a0 [btrfs]
  ? __pfx_lock_release+0x10/0x10
  ? do_raw_write_lock+0x90/0x260
  ? __pfx_do_raw_write_lock+0x10/0x10
  ? __pfx_btrfs_finish_one_ordered+0x10/0x10 [btrfs]
  ? _raw_write_unlock+0x23/0x40
  ? btrfs_finish_ordered_zoned+0x5a9/0x850 [btrfs]
  ? lock_acquire+0x435/0x500
  btrfs_work_helper+0x1b1/0xa70 [btrfs]
  ? __schedule+0x10a8/0x60b0
  ? __pfx___might_resched+0x10/0x10
  process_one_work+0x862/0x1410
  ? __pfx_lock_acquire+0x10/0x10
  ? __pfx_process_one_work+0x10/0x10
  ? assign_work+0x16c/0x240
  worker_thread+0x5e6/0x1010
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x2c3/0x3a0
  ? trace_irq_enable.constprop.0+0xce/0x110
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x31/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 ---[ end trace 0000000000000000 ]---

Enabling CONFIG_BTRFS_ASSERT revealed the following assertion to
trigger:

 assertion failed: !list_empty(&ordered->list), in fs/btrfs/zoned.c:1815

This indicates, that we're missing the checksums list on the
ordered_extent. As btrfs/167 is doing a NOCOW write this is to be
expected.

Further analysis with drgn confirmed the assumption:

 >>> inode = prog.crashed_thread().stack_trace()[11]['ordered'].inode
 >>> btrfs_inode = drgn.container_of(inode, "struct btrfs_inode", \
					"vfs_inode")
 >>> print(btrfs_inode.flags)
 (u32)1

As zoned emulation mode simulates conventional zones on regular
devices, we cannot use zone-append for writing. But we're only
attaching dummy checksums if we're doing a zone-append write.

So for NOCOW zoned data writes on conventional zones, also attach a
dummy checksum.

Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for zoned writes")
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 477f350a8bd0..e3a57196b0ee 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -741,7 +741,9 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
 				goto fail_put_bio;
-		} else if (use_append) {
+		} else if (use_append ||
+			   (btrfs_is_zoned(fs_info) && inode &&
+			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
 			if (ret)
 				goto fail_put_bio;
-- 
2.43.0


