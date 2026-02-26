Return-Path: <linux-btrfs+bounces-22012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOqlHnVsoGk3jgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22012-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:53:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03501A926B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172EC321F9A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5143D5238;
	Thu, 26 Feb 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma0GNpeU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070A22F177
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119669; cv=none; b=DqKTd0hWMBsItZ5TRtjzbEqE8ucHoo33amCOSmeqBfdDH9lJWnuKbb6K/tlSy+TFAZcrh4nMSXf2E7mNUXbAOuMhv2anxpY6m2RhBT/RZeZHkmntDEIdQAgcn/f2YwyZqQlXiWpkQhckjyWYRXJRrNsb25OhliaK4Y7SDcxwjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119669; c=relaxed/simple;
	bh=P20Th8pYdo7y94PoVt4s2jdXmO9jbH9DZ5aGmkzaJ0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WNKV4Z7PluV4Spscb4gkPO+VpDUNuBpVb7OyMroZrHhL5z9httau/q/QFUj5I5vfvbulE1vsu19uejxt/4GicjF91wEv+j5rCf4Uko5jmfPMgKj6B4HKAgaJD0y8Jd7dbZ4SPGzfT6B6tW99i9+R7RHfOPFYD/Y92JNZ6MaHmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma0GNpeU; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806b8fca44so1379065e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119666; x=1772724466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEL2+Q5mTqR+yJsOQTBYIPKwTgwRuEoLKaiL9KWG4pA=;
        b=ma0GNpeU/PPumpEb53TaxtU1ZzjmCb3x+vqEO+T+eLVtu41jAWFG/d3qmSiEcfsvEX
         j+DhTeRJaJ1gFB9Z6WrWIAnkOPk4qjI/PI/2sBNKdJHhhuKtbg0n95P/Ot/GyYtkJ3oK
         ML2zNy3rKm3hmKCRlyLREzw0/mLMRFgXqgO2b0uK/dpSoz3vc0dbiNyhvdI4eQqNyi3n
         fpTpWRyKcbwJj2iEtwHQrwgERQjUWs3V2AOjdTtC+PnUgtX/qOv62SBm/lCYcQ2dR52r
         YORjMCz4fgofsFWvST05cnimVuzCos5rI2qdMbtJYScLMglq09xhPKFvVVlNTjVu2k+P
         g95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119666; x=1772724466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEL2+Q5mTqR+yJsOQTBYIPKwTgwRuEoLKaiL9KWG4pA=;
        b=LWi7eWeVZKXESPbHkmn4lpSv6Wux7wANe20QZoan+agCiCigKqF2vk7eBafz704+uZ
         854AYV4c4tGa0S/HZjnatyJPDoicbQI70zr8aPsUT4/Vp/1AY4EFUCB6O3/Y434qftiH
         2ZzlE2t7nB8naZV0on25u0RcLv7AqDmD5jvBZExeo7CQ0Fa6lCXjemncbKuQoLcpA8cJ
         tSRA/armH+DgwG82+blJynXn9I7cLP6EwUJ3EXLo/O8yComWAaC4U/DWprL8yAQqNUyP
         UylZlyBOFeGAn+DGcm2FbnCCnB9KNMt15+LL0Xe0dqSreQxLCy5NfBrlfwMmx1WziZow
         bSKg==
X-Forwarded-Encrypted: i=1; AJvYcCWJKt4Ej/9zfpg7RQhD6nid0TNSBFoXaN3oTcPKvhpHcCBOYGWwxpkQw1o7PPw0o9G4mqQXk+OkTv2aXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NnyEXRhIhQM91ycoRPWU6v4aG1sCeOWDR1RIvxusjzjN7fYi
	LU//PSD8VdtQeXeEkmm5Wdqul3zjz5rwodV0fz7ug2PR/NjcyFXz7zZI
X-Gm-Gg: ATEYQzwf6p1fHq28bKaQBcKX8K2gzvQl4HD8AVgDTVEZOscAJU14o0iXScr7KBUCSBG
	RdPashMV9LpGqzny1ceekVGn4++R4fACkWE+O6iIiaHYe7HfT/YepUI8aKjZD72cGigMUEzlaJt
	xsHoMstsGqHIiX/5dqrxBIaZNCKzEGWjxBiv3VB6lp6uMIxAbqoFg5RPH9Uykf7RxrlYN2/n1jl
	XtgQzExCMoyyNRMJpzKXXVV4w/y4be9cXnST1UWPM4x1Z/2VFrZyiDrfKXIMT6/3LlGugzDrkPJ
	ktkWxVOR1Zf87GOspWCYGOGMPZc07GpstJHDP2uD3+5uVacjJC6RQrhF7QPcmTVkb+2CX3WJBNw
	PVn8XJ0ETLHT79geNp3VshGjOWp+t1zlzyqqBvzQDBN3ZeCyhM3TGR236XdcvNqxvAoKHB6/DoE
	ptyHGP1DNwkU9LUijZdaW5t7L1TF38xWxMvu5ZPdYSoxOcXGwnJ2ITzd936TZJIYLAeUDXY57nw
	Wji5Infg7UFExw=
X-Received: by 2002:a05:600c:8b12:b0:483:8f10:4bc5 with SMTP id 5b1f17b1804b1-483a962e47bmr185188995e9.4.1772119665687;
        Thu, 26 Feb 2026 07:27:45 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:129b:a29:aa31:646a? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm59626345e9.3.2026.02.26.07.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:27:45 -0800 (PST)
Message-ID: <9f5f048b-df15-4852-a93d-8b6f98584d89@gmail.com>
Date: Thu, 26 Feb 2026 23:27:34 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] btrfs: inhibit extent buffer writeback to prevent
 COW amplification
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1772097864.git.loemra.dev@gmail.com>
 <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22012-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D03501A926B
X-Rspamd-Action: no action



On 2026/2/26 17:51, Leo Martins wrote:
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
> Also inhibit writeback in should_cow_block() when COW is skipped,
> so that every transaction handle that reuses an already-COW'd buffer
> also inhibits its writeback. Without this, if handle A COWs a block
> and inhibits it, and handle B later reuses the same block without
> inhibiting, handle A's uninhibit on end_transaction leaves the buffer
> unprotected while handle B is still using it. This ensures all handles
> that access a COW'd buffer contribute to the inhibitor count, and the
> buffer remains protected until the last handle releases it.
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

Looks good.
Reviewed-by: Sun YangKai <sunk67188@gmail.com>
> ---
>   fs/btrfs/ctree.c       |  9 ++++++
>   fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/extent_io.h   |  6 ++++
>   fs/btrfs/transaction.c | 19 +++++++++++++
>   fs/btrfs/transaction.h |  3 ++
>   5 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index ea7cfc3a9e89..46a715c95bc8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -21,6 +21,7 @@
>   #include "fs.h"
>   #include "accessors.h"
>   #include "extent-tree.h"
> +#include "extent_io.h"
>   #include "relocation.h"
>   #include "file-item.h"
>   
> @@ -590,6 +591,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
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
> @@ -617,6 +622,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>    * When returning false for a WRITTEN buffer allocated in the current
>    * transaction, re-dirties the buffer for in-place overwrite instead
>    * of requesting a new COW.
> + *
> + * When returning false, inhibits background writeback on the buffer
> + * for the lifetime of the transaction handle.
>    */
>   static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>   				    const struct btrfs_root *root,
> @@ -684,6 +692,7 @@ static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>   		btrfs_mark_buffer_dirty(trans, buf);
>   	}
>   
> +	btrfs_inhibit_eb_writeback(trans, buf);
>   	return false;
>   }
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


