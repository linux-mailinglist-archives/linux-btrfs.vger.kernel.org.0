Return-Path: <linux-btrfs+bounces-21904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNroLY6RnmnTWAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21904-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:07:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58242192450
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DBAB3039DC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F82F2918;
	Wed, 25 Feb 2026 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIM5XuaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BC2D9EC4
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999625; cv=none; b=sCgiflZW9S0Q3dXVh/e0D4uGeeK/zDmlT0Su7/z/yiYzUeB+ggyRBZI8C9uURsEvE+ImyExYsNW+mvc2H9YIzl8Wg9StUr1yvuKCSM9cMw9TSWHZMvdnkLXd5sEKsbfk9npC3YZe2noc26V7UfDLve2dKgqPxdSbOFoHiu/of+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999625; c=relaxed/simple;
	bh=Q8MoV3esw6tldlzcn3PSTeLevvVyUBBS3Gu9GwUHGpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AWoz+sJV1pCzcGklMJSyJ5ZCxJ72+l3ugV55zIkCnsbWLXY7XsNC0xJLy2Yos1p5F/0srFWRzU21XCyYEyUOITXfhhkP0voya/S3er+eGezH3AHZ4TPyzgPj3Hj9uBBMx/ZbacKIURs+rp2PeVmRHEJCSYhpy1eoxr0KeqHd5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIM5XuaQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so7319585e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 22:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771999622; x=1772604422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuN9Dg3DNRfT5EYG1jOag3eiqgO92nSIK/H+MCfvhXY=;
        b=OIM5XuaQ8ysb0WvyEywDTqwk2S+xF6debv2izg0vb0wTvbBNfva1+42YxP07E6ICQM
         KYHwcejDEcQUcQYZy/xhbSk+TtClpuP8MgLOFsNobSfh27bPAZ7oC5ZkjDfYZl+ApXmW
         HJs8M8KbW6lxeJmD4xOuGpzDgTlTc6NghZFIDJ0kMviGCXyTSMIHCzFfZD5LnNJ+qokD
         rkz+VnJuO1vOsqVdihmUiFSjIdymo4vvehSbY/qlYXlcNN87eENt0FClAKWdpW4HZbDm
         fbfoHg/PqIoquwS5X2THhp65QZzy/+Y81WT8UnUu6+KWF8A91pI/S5zxmI0tM4iJ+1Z1
         eMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999622; x=1772604422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuN9Dg3DNRfT5EYG1jOag3eiqgO92nSIK/H+MCfvhXY=;
        b=OYOw1t91aEz2NEtbj8i7yUJlPVcq01YpPgokinGpfBgsQKv6ClwEwnO7O2+PNXcOYG
         LsTN7VEhkNMtxyEdCRfgmISwAS02nDRKBYUK7dmvBIqlUgJEXzuIwklqDOjGfIjFR8sH
         YY5zSBa0i4iD435yy+Uzoc1U/c03nZ7g8soJbWXYB70iaWN/A6buaWUSYKOUBuhH34lL
         cHdrgeBZB4hNZa50ljk3XlUbKot9s1H5SOOgoeLlcQNHUPKlrOozXGZjEwvUE0h9h8A5
         Xcay5fsifTc7Q9qg23cKnIWnrOO7cZfEFmcZfN6XZr5cQVWPsYJCLGNV/VC+Ww1DU+Lz
         Ml1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXNK3uJ5+aibePEceSKu3vFNATx1At7R4sbm5ijeaTnxpINC5k72HnEpV30e2WeIQD50Z6cN0XgrrTFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2K933Kj+lLor7BHoC9rEkux3xD77EcDCxmICDW4lhZEFUKqE
	o/c3qID55dAVxBamFJbEY33IB9Ebdye4lczjsBMT96ZscltdgoqI8+2W
X-Gm-Gg: ATEYQzyJhCYSkXKUN/toqvo2a55y1AssWhwwGfcTXOvkcQc/8i7eI6C4tWApYDLckf2
	lz2N9mfJrCBsVVzSv88FvjXhUAFzK7JvjFJsBs9M8bLnQQuWmD9Nv+TbcrvkUunHEWV+5Q7jumN
	/8HXnbgdDgDSRJJ6FRSdOTiCIGrtjwpR/gaE36wnI/7Dv1Jw6YZMD37SwTys9RmgR91BeXVDUZc
	/VB/WK0ZRZ0udrdEeKxEzwGpGHJD1PgTWzaRyA22/KZSE5INQuJWL9I5W4aHVzbn3U1QE80HG+V
	KuBBhgDBbY+DzAyxb4AsLIVVhJ747Zh6HU+Z/P9aMyyk3ijYTuHJ8mSVRze4E4IpEY9P/tG7BiQ
	0BixmvN/kjplLUZgpGeHJRIbz1RVQTkbkqmQXL1nfwmBQUCqxKFs1I0sM52/a8aGQGxgkhe5E1I
	g38Ft+p2iPaWCnfwSm9EiusRUrp+AQpzFTfpnabq3S+E4hyrlp9pErPyao8dSCVyqZJmk4xJA9p
	7RWag==
X-Received: by 2002:a05:600c:1988:b0:480:6612:253 with SMTP id 5b1f17b1804b1-483a962e4demr132745175e9.3.1771999621484;
        Tue, 24 Feb 2026 22:07:01 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:18a9:8974:b792:9a40? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm5509575e9.6.2026.02.24.22.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 22:07:01 -0800 (PST)
Message-ID: <060df404-3e39-4637-88f4-ffd42fcddc26@gmail.com>
Date: Wed, 25 Feb 2026 14:06:51 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] btrfs: skip COW for written extent buffers
 allocated in current transaction
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1771884128.git.loemra.dev@gmail.com>
 <4ce911a475b998ddf76951629ad203e6440ab0ca.1771884128.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <4ce911a475b998ddf76951629ad203e6440ab0ca.1771884128.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21904-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58242192450
X-Rspamd-Action: no action



On 2026/2/25 03:22, Leo Martins wrote:
> When memory pressure causes writeback of a recently COW'd buffer,
> btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
> btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
> the buffer unnecessarily, causing COW amplification that can exhaust
> block reservations and degrade throughput.
> 
> Overwriting in place is crash-safe because the committed superblock
> does not reference buffers allocated in the current (uncommitted)
> transaction, so no on-disk tree points to this block yet.
> 
> When should_cow_block() encounters a WRITTEN buffer whose generation
> matches the current transaction, instead of requesting a COW, re-dirty
> the buffer and re-register its range in the transaction's dirty_pages.
> 
> Both are necessary because btrfs tracks dirty metadata through two
> independent mechanisms. set_extent_buffer_dirty() sets the
> EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
> mark, which is what background writeback (btree_write_cache_pages) uses
> to find and write dirty buffers. The transaction's dirty_pages io tree
> is a separate structure used by btrfs_write_and_wait_transaction() at
> commit time to ensure all buffers allocated during the transaction are
> persisted. The dirty_pages range was originally registered in
> btrfs_init_new_buffer() when the block was first allocated. Normally
> dirty_pages is only cleared at commit time by
> btrfs_write_and_wait_transaction(), but if qgroups are enabled and
> snapshots are being created, qgroup_account_snapshot() may have already
> called btrfs_write_and_wait_transaction() and released the range before
> the final commit-time call.
> 
> Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> correctly pins the block if it is freed later.
> 
> Relax the lockdep assertion in btrfs_mark_buffer_dirty() from
> btrfs_assert_tree_write_locked() to lockdep_assert_held() so that it
> accepts either a read or write lock. should_cow_block() may be called
> from btrfs_search_slot() when only a read lock is held (nodes above
> write_lock_level are read-locked). The write lock assertion previously
> documented the caller convention that buffer content was being modified
> under exclusive access, but btrfs_mark_buffer_dirty() and
> set_extent_buffer_dirty() themselves only perform independently
> synchronized operations: atomic bit ops on bflags, folio_mark_dirty()
> (kernel-internal folio locking), xarray mark updates (xarray spinlock),
> and percpu counter updates. The read lock is sufficient because it
> prevents lock_extent_buffer_for_io() from acquiring the write lock and
> racing on the dirty state. Since rw_semaphore permits concurrent
> readers, multiple threads can enter btrfs_mark_buffer_dirty()
> simultaneously for the same buffer; this is safe because
> test_and_set_bit(EXTENT_BUFFER_DIRTY) ensures only one thread performs
> the full dirty state transition.
> 
> Remove the CONFIG_BTRFS_DEBUG assertion in set_extent_buffer_dirty()
> that checked folio_test_dirty() after marking the buffer dirty. This
> assertion assumed exclusive access (only one thread in
> set_extent_buffer_dirty() at a time), which held when the only caller
> was btrfs_mark_buffer_dirty() under write lock. With concurrent readers
> calling through should_cow_block(), a thread that loses the
> test_and_set_bit race sees was_dirty=true and skips the folio dirty
> marking, but the winning thread may not have called
> btrfs_meta_folio_set_dirty() yet, causing the assertion to fire. This
> is a benign race: the winning thread will complete the folio dirty
> marking, and no writeback can clear it while readers hold their locks.
> 
> Hoist the EXTENT_BUFFER_WRITEBACK, BTRFS_HEADER_FLAG_RELOC, and
> BTRFS_ROOT_FORCE_COW checks before the WRITTEN block since they apply
> regardless of whether the buffer has been written back. This
> consolidates the exclusion logic and simplifies the WRITTEN path to
> only handle log trees and zoned devices. Moving the RELOC checks
> before the smp_mb__before_atomic() barrier is safe because both
> btrfs_root_id() (immutable) and BTRFS_HEADER_FLAG_RELOC (set at COW
> time under tree lock) are stable values not subject to concurrent
> modification; the barrier is only needed for BTRFS_ROOT_FORCE_COW
> which is set concurrently by create_pending_snapshot().
> 
> Exclude cases where in-place overwrite is not safe:
>   - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
>   - Zoned devices: require sequential writes
>   - Log trees: log blocks are immediately referenced by a committed
>     superblock via btrfs_sync_log(), so overwriting could corrupt the
>     committed log
>   - BTRFS_ROOT_FORCE_COW: snapshot in progress
>   - BTRFS_HEADER_FLAG_RELOC: block being relocated
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Thanks! Looks good now. Currently we only early return true in 
should_cow_block(), making the overall logic easier to follow.

And the commit message and comments are quite detailed and helpful.

Reviewed-by: Sun YangKai <sunk67188@gmail.com>

> ---
>   fs/btrfs/ctree.c     | 56 ++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/disk-io.c   |  2 +-
>   fs/btrfs/extent_io.c |  4 ----
>   3 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..0e02b7b14adc 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> -static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>   				    const struct btrfs_root *root,
> -				    const struct extent_buffer *buf)
> +				    struct extent_buffer *buf)
>   {
>   	if (btrfs_is_testing(root->fs_info))
>   		return false;
> @@ -621,7 +621,11 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
>   	if (btrfs_header_generation(buf) != trans->transid)
>   		return true;
>   
> -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
> +		return true;
> +
> +	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
> +	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
>   		return true;
>   
>   	/* Ensure we can see the FORCE_COW bit. */
> @@ -629,11 +633,49 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
>   	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
>   		return true;
>   
> -	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> -		return false;
> +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +		/*
> +		 * The buffer was allocated in this transaction and has been
> +		 * written back to disk (WRITTEN is set). Normally we'd COW
> +		 * it again, but since the committed superblock doesn't
> +		 * reference this buffer (it was allocated in this transaction),
> +		 * we can safely overwrite it in place.
> +		 *
> +		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> +		 * persisted at this bytenr and will be again after the
> +		 * in-place update. This is important so that
> +		 * btrfs_free_tree_block() correctly pins the block if it is
> +		 * freed later (e.g., during tree rebalancing or FORCE_COW).
> +		 *
> +		 * Log trees and zoned devices cannot use this optimization:
> +		 * - Log trees: log blocks are written and immediately
> +		 *   referenced by a committed superblock via
> +		 *   btrfs_sync_log(), bypassing the normal transaction
> +		 *   commit. Overwriting in place could corrupt the
> +		 *   committed log.
> +		 * - Zoned devices: require sequential writes.
> +		 */
> +		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID ||
> +		    btrfs_is_zoned(root->fs_info))
> +			return true;
>   
> -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> -		return true;
> +		/*
> +		 * Re-register this block's range in the current transaction's
> +		 * dirty_pages so that btrfs_write_and_wait_transaction()
> +		 * writes it. The range was originally registered when the
> +		 * block was allocated. Normally dirty_pages is only cleared
> +		 * at commit time by btrfs_write_and_wait_transaction(), but
> +		 * if qgroups are enabled and snapshots are being created,
> +		 * qgroup_account_snapshot() may have already called
> +		 * btrfs_write_and_wait_transaction() and released the range
> +		 * before the final commit-time call.
> +		 */
> +		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> +				     buf->start,
> +				     buf->start + buf->len - 1,
> +				     EXTENT_DIRTY, NULL);
> +		btrfs_mark_buffer_dirty(trans, buf);
> +	}
>   
>   	return false;
>   }
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 32fffb0557e5..bee8f76fbfea 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4491,7 +4491,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
>   #endif
>   	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED). */
>   	ASSERT(trans->transid == fs_info->generation);
> -	btrfs_assert_tree_write_locked(buf);
> +	lockdep_assert_held(&buf->lock);
>   	if (unlikely(transid != fs_info->generation)) {
>   		btrfs_abort_transaction(trans, -EUCLEAN);
>   		btrfs_crit(fs_info,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfc17c292217..ff1fc699a6ca 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3791,10 +3791,6 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
>   					 eb->len,
>   					 eb->fs_info->dirty_metadata_batch);
>   	}
> -#ifdef CONFIG_BTRFS_DEBUG
> -	for (int i = 0; i < num_extent_folios(eb); i++)
> -		ASSERT(folio_test_dirty(eb->folios[i]));
> -#endif
>   }
>   
>   void clear_extent_buffer_uptodate(struct extent_buffer *eb)


