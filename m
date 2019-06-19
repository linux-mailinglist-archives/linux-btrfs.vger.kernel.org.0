Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B968E4B1FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfFSGQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 02:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfFSGQR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 02:16:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF836AE56
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 06:16:13 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: delayed-ref: Fix memory leak and
 use-after-free caused by wrong condition to free delayed ref/head.
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190613073340.19851-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <927951dd-7416-56e7-854c-e56f0e90fdf1@suse.com>
Date:   Wed, 19 Jun 2019 09:16:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613073340.19851-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.19 г. 10:33 ч., Qu Wenruo wrote:
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  delayed-ref.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/delayed-ref.h b/delayed-ref.h
> index efc855eff621..2ccfd27c2b95 100644
> --- a/delayed-ref.h
> +++ b/delayed-ref.h
> @@ -161,7 +161,7 @@ btrfs_free_delayed_extent_op(struct btrfs_delayed_extent_op *op)
>  static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
>  {
>  	WARN_ON(ref->refs == 0);
> -	if (--ref->refs) {
> +	if (--ref->refs == 0) {
>  		WARN_ON(ref->in_tree);
>  		switch (ref->type) {
>  		case BTRFS_TREE_BLOCK_REF_KEY:
> @@ -180,7 +180,7 @@ static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
>  
>  static inline void btrfs_put_delayed_ref_head(struct btrfs_delayed_ref_head *head)
>  {
> -	if (--head->refs)
> +	if (--head->refs == 0)
>  		kfree(head);
>  }
>  
> 
