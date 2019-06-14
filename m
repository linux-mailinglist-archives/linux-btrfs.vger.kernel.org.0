Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435A246394
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNQC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 12:02:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNQC0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 12:02:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14258ACE1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 16:02:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB80EDA897; Fri, 14 Jun 2019 18:03:13 +0200 (CEST)
Date:   Fri, 14 Jun 2019 18:03:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: delayed-ref: Fix memory leak and
 use-after-free caused by wrong condition to free delayed ref/head.
Message-ID: <20190614160313.GC19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190613074959.20163-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613074959.20163-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 03:49:59PM +0800, Qu Wenruo wrote:
> [BUG]
> When btrfs-progs is compiled with D=asan, it can't pass even the very
> basic fsck tests due to btrfs-image has memory leak:
>   === START TEST /home/adam/btrfs/btrfs-progs/tests//fsck-tests/001-bad-file-extent-bytenr
>   restoring image default_case.img
> 
>   =================================================================
>   ==7790==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 104 byte(s) in 1 object(s) allocated from:
>       #0 0x7f1d3b738389 in __interceptor_malloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:86
>       #1 0x560ca6b7f4ff in btrfs_add_delayed_tree_ref /home/adam/btrfs/btrfs-progs/delayed-ref.c:569
>       #2 0x560ca6af2d0b in btrfs_free_extent /home/adam/btrfs/btrfs-progs/extent-tree.c:2155
>       #3 0x560ca6ac16ca in __btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:319
>       #4 0x560ca6ac1d8c in btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:383
>       #5 0x560ca6ac6c8e in btrfs_search_slot /home/adam/btrfs/btrfs-progs/ctree.c:1153
>       #6 0x560ca6ab7e83 in fixup_device_size image/main.c:2113
>       #7 0x560ca6ab9279 in fixup_chunks_and_devices image/main.c:2333
>       #8 0x560ca6ab9ada in restore_metadump image/main.c:2455
>       #9 0x560ca6abaeba in main image/main.c:2723
>       #10 0x7f1d3b148ce2 in __libc_start_main (/usr/lib/libc.so.6+0x23ce2)
> 
>   ... tons of similar leakage for delayed_tree_ref ...
> 
>   Direct leak of 96 byte(s) in 1 object(s) allocated from:
>       #0 0x7f1d3b738389 in __interceptor_malloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:86
>       #1 0x560ca6b7f5fb in btrfs_add_delayed_tree_ref /home/adam/btrfs/btrfs-progs/delayed-ref.c:583
>       #2 0x560ca6af5679 in alloc_tree_block /home/adam/btrfs/btrfs-progs/extent-tree.c:2503
>       #3 0x560ca6af57ac in btrfs_alloc_free_block /home/adam/btrfs/btrfs-progs/extent-tree.c:2524
>       #4 0x560ca6ac115b in __btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:290
>       #5 0x560ca6ac1d8c in btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:383
>       #6 0x560ca6b7bb15 in commit_tree_roots /home/adam/btrfs/btrfs-progs/transaction.c:98
>       #7 0x560ca6b7c525 in btrfs_commit_transaction /home/adam/btrfs/btrfs-progs/transaction.c:192
>       #8 0x560ca6ab92be in fixup_chunks_and_devices image/main.c:2337
>       #9 0x560ca6ab9ada in restore_metadump image/main.c:2455
>       #10 0x560ca6abaeba in main image/main.c:2723
>       #11 0x7f1d3b148ce2 in __libc_start_main (/usr/lib/libc.so.6+0x23ce2)
> 
>   ... tons of similar leakage for delayed_ref_head ...
> 
>   SUMMARY: AddressSanitizer: 1600 byte(s) leaked in 16 allocation(s).
>   failed to restore image ./default_case.img
> 
> [CAUSE]
> Commit c6039704c580 ("btrfs-progs: Add delayed refs infrastructure")
> introduces delayed ref infrastructure for free space tree, however the
> refcount_dec_and_test() from kernel code is wrongly backported.
> 
> refcount_dec_and_test() will return true if the refcount reaches 0.
> So kernel code will free the allocated space as expected:
> 	if (refcount_dec_and_test(&ref->refs)) {
> 		kmem_cache_free();
> 	}
> 
> However btrfs-progs backport is using the opposite condition:
> 	if (--ref->refs) {
> 		kfree();
> 	}
> 
> This will not free the memory for the last user, but for refs >= 2.
> Causing both use-after-free and memory leak for any offline write
> operation.
> 
> [FIX]
> Fix the (--ref->refs) condition to (--ref->refs == 0) to fix the
> backport error.
> 
> Fixes: c6039704c580 ("btrfs-progs: Add delayed refs infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, added to devel.
