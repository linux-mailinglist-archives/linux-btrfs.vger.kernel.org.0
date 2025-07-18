Return-Path: <linux-btrfs+bounces-15567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635AB0ACAA
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 01:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B855E189DD99
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 23:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39AB22DA0B;
	Fri, 18 Jul 2025 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Jxcel2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC48A923
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883028; cv=none; b=RVmoqxSdcOkOVNnAkQniFKKhfxNF99XaJsz70MPcBQTLCODGr5qNUZ4L5oDfQ/TwpE3pMzKYgF2bm9DuZ9XWPappBzzUMe3fFaJ7vwa0vXXXCC2b4tXoZ4x34jX4z7WCDAdHdPgocUMWjtYTZYFLOXQa1HGgfYEtCbyrP1/SQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883028; c=relaxed/simple;
	bh=aVsRi7wc35RkzV3ANnqeVSByK6fS3hdXJ2GVcxOcLlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qqEu08yT+jGt55hfFZ2P9AMh7Nj353xSfc7M0BGmZzRFJGaFBeg1xXS2YCqXMqU2fH/u15I7zPlU4ZjVxZ6yBUdQHObdWOrwLd0yB/9zeKCO3Ym02P6bEMYdnBGYMQgaw9q+R1n6RbbfBIjhCK7hj5u7iNBxDdt6fudxD1oD2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Jxcel2; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8d7ad77e4cso1229884276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 16:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752883024; x=1753487824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9+/OKrR5u7IFsbIQsDPn40RMM+OBIQ2bQjHy650uPg=;
        b=G3Jxcel2GiBw3WIlN3y1OsMTm6IDWX4QRyAcsuLjD9JIUjLAfe7cchjjhsojjKa6oz
         FJ4skdpxp56XpyMOaK3qwG20IOhlbMdMPm+QZ/Bv3l2Ml2LQnTns8n66CU9Et6a/WOnP
         wQ7PycTFGaDl/TmRoV9Ca3H2zXGypYl44RoaL8UCj5GxBdEmYMmLajw/rxSvxClYt7EI
         P6Fvf/CQ5IZpn7Jp+6NQIs2KfZZKs/ak1UrbS9wjqGrbI6Zh/IIcyqc1SG/tm96LRQ6W
         ag6aHraqYbQ8VfRPPxsAE2ImCMQDuIIU23Yo0UqJubmZxXtNujkDxZ0ZUvlgARoX5r/0
         LgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752883024; x=1753487824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9+/OKrR5u7IFsbIQsDPn40RMM+OBIQ2bQjHy650uPg=;
        b=kweRpqyA6f9mkHnNdwALwO8VYnHO32BCgN2cOUGJwsTRN110SczDiwHJOfCICi70ML
         7G5+ZBPP8YguPIcYPy+eXpwNkqK40wUywiAMDdtN0oTMkdK3DxNYSvKrdS7pgtqKcFic
         ueom8c+GPYd0RSdwNfqwbHCdB11DhA0dP0EMrxwVXqv5S1/42Or63o8mAl311ukXgdk0
         TwfU/jRNSmtKvZtNPhyf9tAwWrl78dQMsZlzwlvv8SEvECZa3/y/nfGbsL61devtRKQ9
         53tiOE3ejYuG9kBF9noUOJfQ5JDqjn/ZBUpBbpT53nwtE5R0CmfJSQMEwzUA36styLF8
         AiGA==
X-Gm-Message-State: AOJu0Yx2I8bOWIFccqhi1q9NBA2GD00vhFS5urCScD8J21OHkDNunLu8
	Wxs/GC1oqQGw0mwWbM99kBEfRFCTw1tSAcGAGgvZkEqeyqxdLd7V8Debyq1p+3YM
X-Gm-Gg: ASbGncsDRPfYgq69SeFZUrygVNFANw16uObYjxTeRNTAoL7sJYupV4AzPyUNGlteX22
	RvY7ctuVhtc55fzKEXRz1n8PkHTWQ/Y/ujxGLp8uUmG62lB4TSl90Ynt2+io9kLWo3FhB3A7KoM
	GC+WMzkqWvHF5dh9E++CkNWyfoWGGLDUsxgbAOewVsXCnwrMc1AzTdUrImXDHnNEp1t+1qJIi8B
	bV9uUu85b5lVZyX4aQSeaiSCHdTFFnqlDzZU1lG3LenHZe3uK/Y4UnsCXkqVTwgqkgU0+fb2TS4
	jjBvOCSHLAt9fr6g0IdnkPXY6QK0lrHJTpKRFMBfnbo7qw1gJ60+N1L1jCLeiGOYnTzWSTR7vah
	unFLr82NPT/KNpMnE
X-Google-Smtp-Source: AGHT+IHACp7+GRXmM0Fh81GsppsXRxGlKxRHSyT8FFhH3i7jCh6hz/vS1GgHmbqBxZzPRXvNynROPA==
X-Received: by 2002:a05:6902:18c9:b0:e8d:7bc5:38a with SMTP id 3f1490d57ef6-e8d7bc507fcmr4632225276.1.1752883023764;
        Fri, 18 Jul 2025 16:57:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce4cf1bsm698444276.41.2025.07.18.16.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 16:57:03 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix subpage deadlock
Date: Fri, 18 Jul 2025 16:56:48 -0700
Message-ID: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential deadlock that can happen in
try_release_subpage_extent_buffer because the irq-safe
xarray spin lock fs_info->buffer_tree is being
acquired before the irq-unsafe eb->refs_lock.

This leads to the potential race:

```
// T1                                   // T2
xa_lock_irq(&fs_info->buffer_tree)
                                        spin_lock(&eb->refs_lock)
                                        // interrupt
                                        xa_lock_irq(&fs_info->buffer_tree)
spin_lock(&eb->refs_lock)
```

https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A

I believe that the spin lock can safely be replaced by an rcu_read_lock.
The xa_for_each loop does not need the spin lock as it's already
internally protected by the rcu_read_lock. The extent buffer
is also protected by the rcu_read_lock so it won't be freed before we
take the eb->refs_lock.

The rcu_read_lock is taken and released every iteration, just like the
spin lock, which means we're not protected against concurrent
insertions into the xarray. This is fine because we rely on folio->private
to detect if there are any eb's remaining in the folio.

There is already some precedence for this with find_extent_buffer_nolock,
which loads an extent buffer from the xarray with only rcu_read_lock.

lockdep warning:

            =====================================================
            WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
            6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N
            -----------------------------------------------------
            kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
            ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560

and this task is already holding:
            ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
            which would create a new lock dependency:
             (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}

but this new dependency connects a HARDIRQ-irq-safe lock:
             (&buffer_xa_class){-.-.}-{3:3}

... which became HARDIRQ-irq-safe at:
              lock_acquire+0x178/0x358
              _raw_spin_lock_irqsave+0x60/0x88
              buffer_tree_clear_mark+0xc4/0x160
              end_bbio_meta_write+0x238/0x398
              btrfs_bio_end_io+0x1f8/0x330
              btrfs_orig_write_end_io+0x1c4/0x2c0
              bio_endio+0x63c/0x678
              blk_update_request+0x1c4/0xa00
              blk_mq_end_request+0x54/0x88
              virtblk_request_done+0x124/0x1d0
              blk_mq_complete_request+0x84/0xa0
              virtblk_done+0x130/0x238
              vring_interrupt+0x130/0x288
              __handle_irq_event_percpu+0x1e8/0x708
              handle_irq_event+0x98/0x1b0
              handle_fasteoi_irq+0x264/0x7c0
              generic_handle_domain_irq+0xa4/0x108
              gic_handle_irq+0x7c/0x1a0
              do_interrupt_handler+0xe4/0x148
              el1_interrupt+0x30/0x50
              el1h_64_irq_handler+0x14/0x20
              el1h_64_irq+0x6c/0x70
              _raw_spin_unlock_irq+0x38/0x70
              __run_timer_base+0xdc/0x5e0
              run_timer_softirq+0xa0/0x138
              handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
              ____do_softirq.llvm.17674514681856217165+0x18/0x28
              call_on_irq_stack+0x24/0x30
              __irq_exit_rcu+0x164/0x430
              irq_exit_rcu+0x18/0x88
              el1_interrupt+0x34/0x50
              el1h_64_irq_handler+0x14/0x20
              el1h_64_irq+0x6c/0x70
              arch_local_irq_enable+0x4/0x8
              do_idle+0x1a0/0x3b8
              cpu_startup_entry+0x60/0x80
              rest_init+0x204/0x228
              start_kernel+0x394/0x3f0
              __primary_switched+0x8c/0x8958

to a HARDIRQ-irq-unsafe lock:
             (&eb->refs_lock){+.+.}-{3:3}

... which became HARDIRQ-irq-unsafe at:
            ...
              lock_acquire+0x178/0x358
              _raw_spin_lock+0x4c/0x68
              free_extent_buffer_stale+0x2c/0x170
              btrfs_read_sys_array+0x1b0/0x338
              open_ctree+0xeb0/0x1df8
              btrfs_get_tree+0xb60/0x1110
              vfs_get_tree+0x8c/0x250
              fc_mount+0x20/0x98
              btrfs_get_tree+0x4a4/0x1110
              vfs_get_tree+0x8c/0x250
              do_new_mount+0x1e0/0x6c0
              path_mount+0x4ec/0xa58
              __arm64_sys_mount+0x370/0x490
              invoke_syscall+0x6c/0x208
              el0_svc_common+0x14c/0x1b8
              do_el0_svc+0x4c/0x60
              el0_svc+0x4c/0x160
              el0t_64_sync_handler+0x70/0x100
              el0t_64_sync+0x168/0x170

other info that might help us debug this:
             Possible interrupt unsafe locking scenario:
                   CPU0                    CPU1
                   ----                    ----
              lock(&eb->refs_lock);
                                           local_irq_disable();
                                           lock(&buffer_xa_class);
                                           lock(&eb->refs_lock);
              <Interrupt>
                lock(&buffer_xa_class);

  *** DEADLOCK ***
            2 locks held by kswapd0/66:
             #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
             #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560

Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent_io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6192e1f58860..060e509cfb18 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/rcupdate.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
@@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
 	int ret;
 
-	xa_lock_irq(&fs_info->buffer_tree);
+	rcu_read_lock();
 	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
+		rcu_read_unlock();
+
 		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
+			rcu_read_lock();
 			continue;
 		}
 
@@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * check the folio private at the end.  And
 		 * release_extent_buffer() will release the refs_lock.
 		 */
-		xa_unlock_irq(&fs_info->buffer_tree);
 		release_extent_buffer(eb);
-		xa_lock_irq(&fs_info->buffer_tree);
+		rcu_read_lock();
 	}
-	xa_unlock_irq(&fs_info->buffer_tree);
+	rcu_read_unlock();
 
 	/*
 	 * Finally to check if we have cleared folio private, as if we have
@@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		ret = 0;
 	spin_unlock(&folio->mapping->i_private_lock);
 	return ret;
-
 }
 
 int try_release_extent_buffer(struct folio *folio)
-- 
2.47.1


