Return-Path: <linux-btrfs+bounces-21905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBNJGy+UnmmXWQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21905-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:18:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2A1924D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87B28303FACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64332C15AC;
	Wed, 25 Feb 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnrLYDYC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDC199FD3
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000260; cv=none; b=ABm3+DzW2JxTWdD6o371+TC2S/Am5JACwbtO+nWDZpvJ+wHOLOZz42ZKUUSHhUiQZGfsHl9IN2QjGf+pzGIj5lzFWnJsL3QyLJ/jg+uzQg2OqK4twx3MSfX6dhrfVKLmHlFjPd3ATy8WHdP96Nd6oZs/wR6tav2x17TPzb0NUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000260; c=relaxed/simple;
	bh=pvr9qH2bqbP35Wd+owJmbTZ7Fg+AL1bHfKgrCXn3IRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEMxGZzfrusXQCURKr24Una/KsTHaHUwpb/if/h9zYsXfnpN+fXWmoFruJ4SupirE1gQKKinCLwungpgOLxdjdEWC4MOxs9PRrET2kNzKW72VkugM0Ycb2gN5+U+RK4S5nZ9IHptNlJgV9T/6HKYb/UUKa7adN8VhQjVBCHvMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnrLYDYC; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483ad568d68so4500615e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 22:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772000257; x=1772605057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Lml4s3WkJnBnwOnwr+d0MU68jowa/Sft8FTejev/Bo=;
        b=PnrLYDYCcq80oiRXhwVKJgW5hUNdOVMtJc2cxRUOA6lJs2p4wVsdtXZ6vbmpPsZqur
         hqoHjU+ep+UG3o1Iddq3in0IHoezViYXXwrLiD55Gu4ota/2ek3PsDvBF/RnePlyFlDj
         zTDBXzisCVqMuBzX277KGGEm4uR9Oj85hilz0OdbwD0owYr5sp0MncRBduQsLtuFR76Q
         oDIBVEDfYCvZl+LNF+a1SdCJetwR1MLi0vSKZSmaLCcUDOpMHuxp2fo++NHlBZeKnmbd
         SHK+PFPCV3I2wFn8Wok5ffIgp9aSzzbL+ZSbwBjxJFGnKG0rC8/c5xieL/C/LmNV57Wi
         lQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772000257; x=1772605057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Lml4s3WkJnBnwOnwr+d0MU68jowa/Sft8FTejev/Bo=;
        b=GYxciyB9QvI0TykKeUkaTnfJaJRnmsYiY4IH5PxuzvqZXH0LqRGhsWvFnI9AMkXeEG
         IwFhh2SpPHFnKh52uY2q+OZLRxUWA/OeDWKbh5NRPMThWrcqGmSSNGpOPi6PHmDDqyVI
         HatbENq1Wveh1c/GPPpkPZFVeBr7AByfvqkhRsA7F5tXcm1cE4nn9OP2Vsb0UljdVsfs
         R5s9orRlEQdaYj+C6CXzzbHklTORhdaELcoK/+GedWYPSv3KLPu/LLcKwQHJbYu/J1BL
         r3MnKX3nLrxq2TOGGAUySIzOjWYF2CijOkrjVfUegLBf2PzsewPCfOgoWW7au7Yzz+qg
         ABkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCjS1jisONhgcazQtHSXndYbOwHwLL6oBbqgSLgnSJT1vyCqIOi5a889b90cf8zdy9O0U83BMjM/B4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRnQDfuJuSgoGIU6BlVS6Sbjli4X/n27ls1APRcXUZLf3AevW
	YHB4CcdWHIQIGv6BDM1ko28+1FIUDkPE1VQEBhyOBIwOn4iX06i+9G70+B+LdYvRV+XjiA==
X-Gm-Gg: ATEYQzxpXLrzVlEolFLZ8tOwtewfyqXbf4xQT5OcwSkRTyyZamBI6kx++j5aqXDM/ww
	tp38/Jb/hQctMHveGN/RFxbGnxsjdkjCxbQsnQARNfiE5p8enlF/QZkkFVS/vaP7lE0Tnzzh5AR
	IPCWf1NCXm/5hDsWZ+IzaXXk7rbQQQEzC019lByqTBKXQQZtYkkfKll46eDOoWLqq35+9ARGCv4
	Jor8XO6o4Dy9L8HjAblNNr7vmT445o0SKRL7p2yuzVi0Cs1KMueHyrVfPUYPjrVDJnii8jdXE10
	ds1oOAvTRTLxjsWVE16KPP766NKuGVv7gNYBxy99uuZhuX5hAlETzYBrK0ErrKPNHGjmG697VuV
	StW8vmUCiJDXOOaI8hzyStuWhVzqdlPuNQbhYZ3wFpvkf1hr67fF7zoA6wlOLUWBjNfP//3u6ue
	ek/17zSjpVM3Cw/JL207Ps7MHkTQ3G9CegirpSNZPqVu5NHazYMLAjKDnW48/kPPCkUqXfQBFIY
	mu4fA==
X-Received: by 2002:a05:6000:2008:b0:439:909f:c596 with SMTP id ffacd0b85a97d-439909fc8e6mr577356f8f.2.1772000256719;
        Tue, 24 Feb 2026 22:17:36 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:18a9:8974:b792:9a40? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43987f3ed03sm10811221f8f.16.2026.02.24.22.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 22:17:36 -0800 (PST)
Message-ID: <8b4f2be8-169d-4e10-a47f-b534ab0ebac6@gmail.com>
Date: Wed, 25 Feb 2026 14:17:24 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: inhibit extent buffer writeback to prevent
 COW amplification
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
References: <cover.1771884128.git.loemra.dev@gmail.com>
 <cc847a35e26cc4dfad18c59e3c525cea507ff440.1771884128.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <cc847a35e26cc4dfad18c59e3c525cea507ff440.1771884128.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21905-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 09F2A1924D2
X-Rspamd-Action: no action



On 2026/2/25 03:22, Leo Martins wrote:
> Inhibit writeback on COW'd extent buffers for the lifetime of the
> transaction handle, preventing background writeback from setting
> BTRFS_HEADER_FLAG_WRITTEN and causing unnecessary re-COW.
> 
> COW amplification occurs when background writeback flushes an extent
> buffer that a transaction handle is still actively modifying. When
> lock_extent_buffer_for_io() transitions a buffer from dirty to
> writeback, it sets BTRFS_HEADER_FLAG_WRITTEN, marking the block as
> having been persisted to disk at its current bytenr. Once WRITTEN is
> set, should_cow_block() must either COW the block again or overwrite
> it in place, both of which are unnecessary overhead when the buffer
> is still being modified by the same handle that allocated it. By
> inhibiting background writeback on actively-used buffers, WRITTEN is
> never set while a transaction handle holds a reference to the buffer,
> avoiding this overhead entirely.
> 
> Add an atomic_t writeback_inhibitors counter to struct extent_buffer,
> which fits in an existing 6-byte hole without increasing struct size.
> When a buffer is COW'd in btrfs_force_cow_block(), call
> btrfs_inhibit_eb_writeback() to store the eb in the transaction
> handle's writeback_inhibited_ebs xarray (keyed by eb->start), take a
> reference, and increment writeback_inhibitors. The function handles
> dedup (same eb inhibited twice by the same handle) and replacement
> (different eb at the same logical address). Allocation failure is
> graceful: the buffer simply falls back to the pre-existing behavior
> where it may be written back and re-COW'd.
> 
> In lock_extent_buffer_for_io(), when writeback_inhibitors is non-zero
> and the writeback mode is WB_SYNC_NONE, skip the buffer. WB_SYNC_NONE
> is used by the VM flusher threads for background and periodic
> writeback, which are the only paths that cause COW amplification by
> opportunistically writing out dirty extent buffers mid-transaction.
> Skipping these is safe because the buffers remain dirty in the page
> cache and will be written out at transaction commit time.
> 
> WB_SYNC_ALL must always proceed regardless of writeback_inhibitors.
> This is required for correctness in the fsync path: btrfs_sync_log()
> writes log tree blocks via filemap_fdatawrite_range() (WB_SYNC_ALL)
> while the transaction handle that inhibited those same blocks is still
> active. Without the WB_SYNC_ALL bypass, those inhibited log tree
> blocks would be silently skipped, resulting in an incomplete log on
> disk and corruption on replay. btrfs_write_and_wait_transaction()
> also uses WB_SYNC_ALL via filemap_fdatawrite_range(); for that path,
> inhibitors are already cleared beforehand, but the bypass ensures
> correctness regardless.
> 
> Uninhibit in __btrfs_end_transaction() before atomic_dec(num_writers)
> to prevent a race where the committer proceeds while buffers are still
> inhibited. Also uninhibit in btrfs_commit_transaction() before writing
> and in cleanup_transaction() for the error path.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c       |  4 +++
>   fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/extent_io.h   |  6 ++++
>   fs/btrfs/transaction.c | 19 +++++++++++++
>   fs/btrfs/transaction.h |  3 ++
>   5 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0e02b7b14adc..d4da65bb9096 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -590,6 +590,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>   		btrfs_tree_unlock(buf);
>   	free_extent_buffer_stale(buf);
>   	btrfs_mark_buffer_dirty(trans, cow);
> +
> +	/* Inhibit writeback on the COW'd buffer for this transaction handle. */
> +	btrfs_inhibit_eb_writeback(trans, cow);
> +
>   	*cow_ret = cow;
>   	return 0;
>   
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ff1fc699a6ca..e04e42a81978 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1940,7 +1940,9 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
>   	 * of time.
>   	 */
>   	spin_lock(&eb->refs_lock);
> -	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +	if ((wbc->sync_mode == WB_SYNC_ALL ||
> +	     atomic_read(&eb->writeback_inhibitors) == 0) &&
> +	    test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>   		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>   		unsigned long flags;
>   
> @@ -2999,6 +3001,64 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
>   	kmem_cache_free(extent_buffer_cache, eb);
>   }
>   
> +/*
> + * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction.
> + * @trans: transaction handle that will own the inhibitor
> + * @eb: extent buffer to inhibit writeback on
> + *
> + * Attempts to track this extent buffer in the transaction's inhibited set.
> + * If memory allocation fails, the buffer is simply not tracked. It may
> + * be written back and need re-COW, which is the original behavior.
> + * This is acceptable since inhibiting writeback is an optimization.
> + */
> +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> +				struct extent_buffer *eb)
> +{
> +	unsigned long index = eb->start >> trans->fs_info->nodesize_bits;
> +	void *old;
> +
> +	/* Check if already inhibited by this handle. */
> +	old = xa_load(&trans->writeback_inhibited_ebs, index);
> +	if (old == eb)
> +		return;
> +
> +	/* Take reference for the xarray entry. */
> +	refcount_inc(&eb->refs);
> +
> +	old = xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_NOFS);
> +	if (xa_is_err(old)) {
> +		/* Allocation failed, just skip inhibiting this buffer. */
> +		free_extent_buffer(eb);
> +		return;
> +	}
> +
> +	/* Handle replacement of different eb at same index. */
> +	if (old && old != eb) {
> +		struct extent_buffer *old_eb = old;
> +
> +		atomic_dec(&old_eb->writeback_inhibitors);
> +		free_extent_buffer(old_eb);
> +	}
> +
> +	atomic_inc(&eb->writeback_inhibitors);
> +}
> +
> +/*
> + * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers.
> + * @trans: transaction handle to clean up
> + */
> +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans)
> +{
> +	struct extent_buffer *eb;
> +	unsigned long index;
> +
> +	xa_for_each(&trans->writeback_inhibited_ebs, index, eb) {
> +		atomic_dec(&eb->writeback_inhibitors);
> +		free_extent_buffer(eb);
> +	}
> +	xa_destroy(&trans->writeback_inhibited_ebs);
> +}
> +
>   static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   						   u64 start)
>   {
> @@ -3009,6 +3069,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>   	eb->len = fs_info->nodesize;
>   	eb->fs_info = fs_info;
>   	init_rwsem(&eb->lock);
> +	atomic_set(&eb->writeback_inhibitors, 0);
>   
>   	btrfs_leak_debug_add_eb(eb);
>   
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 73571d5d3d5a..fb68fbd4866c 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -102,6 +102,8 @@ struct extent_buffer {
>   	/* >= 0 if eb belongs to a log tree, -1 otherwise */
>   	s8 log_index;
>   	u8 folio_shift;
> +	/* Inhibits WB_SYNC_NONE writeback when > 0. */
> +	atomic_t writeback_inhibitors;

I might be missing something here, but I'm curious whether this atomic 
counter can ever go above 1. If not, and it's strictly binary, perhaps 
using atomic_set(1/0) instead of atomic_inc/dec would make the intent 
clearer?

Otherwise looks good. Thanks.

>   	struct rcu_head rcu_head;
>   
>   	struct rw_semaphore lock;
> @@ -381,4 +383,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
>   #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
>   #endif
>   
> +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> +			       struct extent_buffer *eb);
> +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans);
> +
>   #endif
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f4cc9e1a1b93..a9a22629b49d 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -15,6 +15,7 @@
>   #include "misc.h"
>   #include "ctree.h"
>   #include "disk-io.h"
> +#include "extent_io.h"
>   #include "transaction.h"
>   #include "locking.h"
>   #include "tree-log.h"
> @@ -688,6 +689,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   		goto alloc_fail;
>   	}
>   
> +	xa_init(&h->writeback_inhibited_ebs);
> +
>   	/*
>   	 * If we are JOIN_NOLOCK we're already committing a transaction and
>   	 * waiting on this guy, so we don't need to do the sb_start_intwrite
> @@ -1083,6 +1086,13 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>   	if (trans->type & __TRANS_FREEZABLE)
>   		sb_end_intwrite(info->sb);
>   
> +	/*
> +	 * Uninhibit extent buffer writeback before decrementing num_writers,
> +	 * since the decrement wakes the committing thread which needs all
> +	 * buffers uninhibited to write them to disk.
> +	 */
> +	btrfs_uninhibit_all_eb_writeback(trans);
> +
>   	WARN_ON(cur_trans != info->running_transaction);
>   	WARN_ON(atomic_read(&cur_trans->num_writers) < 1);
>   	atomic_dec(&cur_trans->num_writers);
> @@ -2110,6 +2120,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
>   	if (!test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
>   		btrfs_scrub_cancel(fs_info);
>   
> +	btrfs_uninhibit_all_eb_writeback(trans);
>   	kmem_cache_free(btrfs_trans_handle_cachep, trans);
>   }
>   
> @@ -2556,6 +2567,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	    fs_info->cleaner_kthread)
>   		wake_up_process(fs_info->cleaner_kthread);
>   
> +	/*
> +	 * Uninhibit writeback on all extent buffers inhibited during this
> +	 * transaction before writing them to disk. Inhibiting prevented
> +	 * writeback while the transaction was building, but now we need
> +	 * them written.
> +	 */
> +	btrfs_uninhibit_all_eb_writeback(trans);
> +
>   	ret = btrfs_write_and_wait_transaction(trans);
>   	if (unlikely(ret)) {
>   		btrfs_err(fs_info, "error while writing out transaction: %d", ret);
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 18ef069197e5..7d70fe486758 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -12,6 +12,7 @@
>   #include <linux/time64.h>
>   #include <linux/mutex.h>
>   #include <linux/wait.h>
> +#include <linux/xarray.h>
>   #include "btrfs_inode.h"
>   #include "delayed-ref.h"
>   
> @@ -162,6 +163,8 @@ struct btrfs_trans_handle {
>   	struct btrfs_fs_info *fs_info;
>   	struct list_head new_bgs;
>   	struct btrfs_block_rsv delayed_rsv;
> +	/* Extent buffers with writeback inhibited by this handle. */
> +	struct xarray writeback_inhibited_ebs;
>   };
>   
>   /*


