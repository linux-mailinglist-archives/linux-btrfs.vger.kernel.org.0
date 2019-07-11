Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CF64CC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGJT2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33959 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJT2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so1556756pfo.1;
        Wed, 10 Jul 2019 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZ7elc2UuS/FrboNoV7WD8dAaucbBsLM5Y4zkWcMIec=;
        b=qiCfx0rmc+8sLIBCZVBXWBshloWP9bWx9Q85U5m/78c5vqi7KwfuQl3wXQ0er2NMKq
         cnyPIzEt0dy+WgDXjj3vUzWKdUO2sbqFX9v0mbdvpak7wsrO6vFDYmVd+p2E2we+nF+X
         TsgaPawOW1GxWiMWLBAYHqDmxCcldeYpbrxA6oHbqFbPdCNZJw+pba5HkKPu8S+HRPKc
         1A6MmMaxaZdwrbyD+h9GiZUBuUQXicaNbuOAKshkXytGyXN1SEcwnmimMnB8kQA/hp8E
         CLGJ+mDDsBmw1baxWsEFwCG/dZWfHAwpZBAVeCCAdolAc9ASpRguth3hJeqhVd0+Xq+y
         V2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nZ7elc2UuS/FrboNoV7WD8dAaucbBsLM5Y4zkWcMIec=;
        b=RKRbkMYN/0/4XaINpfwrE9R3DnnFfq80C+Mlgw5C+ZNosUDZBrPDbiCBGyzik7aWns
         HKCCLmUnS5k5dSTH6ABVRbYfHl58vB1miwq8Y/WE6oXWH8rqzuMFDt2+jCuybVqhhRtk
         hW8+y5wb8uiDWlpSg+pO1c0Reo8HDC2O/Y75NeJX/ZilHH7EunDe6HzVZ6SStp8SRewC
         pjYgK9AmX5WzKBEYofm3amRiRL3jZPYJTeIlclpmotUgB3GmgwYr/mOE6OmiF812X+Vd
         kJHKkZbh0HGg7SFBFQOI+eXVO2TR0G4LQlWHAqYDjgq3oqZpPlbF9uaslpR+/hQTrVRa
         Bw4A==
X-Gm-Message-State: APjAAAUwVMGNd4zdyNLV9naw0x66/81DQCR/EBFDGPTEsbjH/XkNTBn5
        QidVAxxEvZqpRIRFS3AzkTw=
X-Google-Smtp-Source: APXvYqznLwyb8aAh4JJt/ZHzUO2evjmORiPsPxcjE79kOScSuoqih3fkZmwydf/5r6XJjfnllDF69A==
X-Received: by 2002:a63:18d:: with SMTP id 135mr38954916pgb.62.1562786910390;
        Wed, 10 Jul 2019 12:28:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id u137sm2963923pgc.91.2019.07.10.12.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:29 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] Btrfs: only associate the locked page with one async_cow struct
Date:   Wed, 10 Jul 2019 12:28:16 -0700
Message-Id: <20190710192818.1069475-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

The btrfs writepages function collects a large range of pages flagged
for delayed allocation, and then sends them down through the COW code
for processing.  When compression is on, we allocate one async_cow
structure for every 512K, and then run those pages through the
compression code for IO submission.

writepages starts all of this off with a single page, locked by
the original call to extent_write_cache_pages(), and it's important to
keep track of this page because it has already been through
clear_page_dirty_for_io().

The btrfs async_cow struct has a pointer to the locked_page, and when
we're redirtying the page because compression had to fallback to
uncompressed IO, we use page->index to decide if a given async_cow
struct really owns that page.

But, this is racey.  If a given delalloc range is broken up into two
async_cows (cow_A and cow_B), we can end up with something like this:

compress_file_range(cowA)
submit_compress_extents(cowA)
submit compressed bios(cowA)
put_page(locked_page)

				compress_file_range(cowB)
				...

The end result is that cowA is completed and cleaned up before cowB even
starts processing.  This means we can free locked_page() and reuse it
elsewhere.  If we get really lucky, it'll have the same page->index in
its new home as it did before.

While we're processing cowB, we might decide we need to fall back to
uncompressed IO, and so compress_file_range() will call
__set_page_dirty_nobufers() on cowB->locked_page.

Without cgroups in use, this creates as a phantom dirty page, which
isn't great but isn't the end of the world.  With cgroups in use, we
might crash in the accounting code because page->mapping->i_wb isn't
set.

[ 8308.523110] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d0
[ 8308.531084] IP: percpu_counter_add_batch+0x11/0x70
[ 8308.538371] PGD 66534e067 P4D 66534e067 PUD 66534f067 PMD 0
[ 8308.541750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[ 8308.551948] CPU: 16 PID: 2172 Comm: rm Not tainted
[ 8308.566883] RIP: 0010:percpu_counter_add_batch+0x11/0x70
[ 8308.567891] RSP: 0018:ffffc9000a97bbe0 EFLAGS: 00010286
[ 8308.568986] RAX: 0000000000000005 RBX: 0000000000000090 RCX: 0000000000026115
[ 8308.570734] RDX: 0000000000000030 RSI: ffffffffffffffff RDI: 0000000000000090
[ 8308.572543] RBP: 0000000000000000 R08: fffffffffffffff5 R09: 0000000000000000
[ 8308.573856] R10: 00000000000260c0 R11: ffff881037fc26c0 R12: ffffffffffffffff
[ 8308.580099] R13: ffff880fe4111548 R14: ffffc9000a97bc90 R15: 0000000000000001
[ 8308.582520] FS:  00007f5503ced480(0000) GS:ffff880ff7200000(0000) knlGS:0000000000000000
[ 8308.585440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8308.587951] CR2: 00000000000000d0 CR3: 00000001e0459005 CR4: 0000000000360ee0
[ 8308.590707] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8308.592865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8308.594469] Call Trace:
[ 8308.595149]  account_page_cleaned+0x15b/0x1f0
[ 8308.596340]  __cancel_dirty_page+0x146/0x200
[ 8308.599395]  truncate_cleanup_page+0x92/0xb0
[ 8308.600480]  truncate_inode_pages_range+0x202/0x7d0
[ 8308.617392]  btrfs_evict_inode+0x92/0x5a0
[ 8308.619108]  evict+0xc1/0x190
[ 8308.620023]  do_unlinkat+0x176/0x280
[ 8308.621202]  do_syscall_64+0x63/0x1a0
[ 8308.623451]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The fix here is to make asyc_cow->locked_page NULL everywhere but the
one async_cow struct that's allowed to do things to the locked page.

Signed-off-by: Chris Mason <clm@fb.com>
Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5106008f5e28..a31574df06aa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1838,7 +1838,7 @@ static int __process_pages_contig(struct address_space *mapping,
 			if (page_ops & PAGE_SET_PRIVATE2)
 				SetPagePrivate2(pages[i]);
 
-			if (pages[i] == locked_page) {
+			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
 				pages_locked++;
 				continue;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6e6df0eab324..a81e9860ee1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -666,10 +666,12 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 	 * to our extent and set things up for the async work queue to run
 	 * cow_file_range to do the normal delalloc dance.
 	 */
-	if (page_offset(async_chunk->locked_page) >= start &&
-	    page_offset(async_chunk->locked_page) <= end)
+	if (async_chunk->locked_page &&
+	    (page_offset(async_chunk->locked_page) >= start &&
+	     page_offset(async_chunk->locked_page)) <= end) {
 		__set_page_dirty_nobuffers(async_chunk->locked_page);
 		/* unlocked later on in the async handlers */
+	}
 
 	if (redirty)
 		extent_range_redirty_for_io(inode, start, end);
@@ -759,7 +761,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 						  async_extent->start +
 						  async_extent->ram_size - 1,
 						  WB_SYNC_ALL);
-			else if (ret)
+			else if (ret && async_chunk->locked_page)
 				unlock_page(async_chunk->locked_page);
 			kfree(async_extent);
 			cond_resched();
@@ -1236,10 +1238,25 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
 		async_chunk[i].inode = inode;
 		async_chunk[i].start = start;
 		async_chunk[i].end = cur_end;
-		async_chunk[i].locked_page = locked_page;
 		async_chunk[i].write_flags = write_flags;
 		INIT_LIST_HEAD(&async_chunk[i].extents);
 
+		/*
+		 * The locked_page comes all the way from writepage and its
+		 * the original page we were actually given.  As we spread
+		 * this large delalloc region across multiple async_cow
+		 * structs, only the first struct needs a pointer to locked_page
+		 *
+		 * This way we don't need racey decisions about who is supposed
+		 * to unlock it.
+		 */
+		if (locked_page) {
+			async_chunk[i].locked_page = locked_page;
+			locked_page = NULL;
+		} else {
+			async_chunk[i].locked_page = NULL;
+		}
+
 		btrfs_init_work(&async_chunk[i].work,
 				btrfs_delalloc_helper,
 				async_cow_start, async_cow_submit,
-- 
2.17.1

