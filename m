Return-Path: <linux-btrfs+bounces-21946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JTjOJzLUn2nZeAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21946-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 06:03:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329411A0F6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 06:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5920130391D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 05:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9892DECBF;
	Thu, 26 Feb 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EczCKAsf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8945C0B
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082220; cv=none; b=Wo/rOXxX5lZ5Hq4Y78lMVY0LXo49uNn3mOIIefeCS0CzVeLbEvpIv56hkR+U7Qw49OPkML5J0xkQFsNjr1dcj+lnxtLymV2X9IGS4T0V9V+hC8duNyS96svXyag4JO57uKHDQVcxZVFlXHAkGLiUZ5l1eow4WVcKxvgTwsmL6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082220; c=relaxed/simple;
	bh=520tmXDBh7zxnpVuEg1KJZ/3/AplwuCOkmO4E+KewTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmibz0PigWHaQzq2NheBq1PnKyIGWZqiBfS7Wsqu63ZOHV2/Fs2KfK9wnB0EfJqOeds3+6VhKkl+XMkvMVLGOVUPNhaVWkidoPKwELx5SKOuWNw0m2iLY7KU9Hzy1uo41JWR2NkgosCZDCH2pxgr8LUi/oD0WoVmtPNBP/aT5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EczCKAsf; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so588685e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 21:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772082217; x=1772687017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6agkUu1AJmePAHgXWPIGGibknIfKUrdVg8uwuOR4Jc=;
        b=EczCKAsfk24sh9vEP0o6a+Xk+XIs9aUNglsc+T4XMKrLyJeUfUUoWRA2o6MEWsCK1H
         F1JUwi/fP9gWZO4w9RwRpbYDWxJzm4LsraLfUIfWiRvCTygMeQIR7VPPpuTgQo0YFHMe
         mtkNT6AP8mMD+D0ed2uGCrLo2a/MeM8dLRG8tMQM4GnzJObYHyd9NjabdlWLG9+lCiSU
         eCQx80NLYz4Udt2KqIqz2beYdb+95GBkn2O5Oh3aYWk5uHhknwWXtWDsIAZZhHFShwQH
         fpcgF0Ru+9g97XJIvoOOXsfXnJrpAZ9D2Bq3QRk2PMaY15V046P0hSmSYE7Z4UciW1D+
         BiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772082217; x=1772687017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6agkUu1AJmePAHgXWPIGGibknIfKUrdVg8uwuOR4Jc=;
        b=ppei1kRJdjr9pCEmfquQwE+ueknYbza7lH8jPisxZUi9YTcmLtma4S3aBh/76U/dIK
         nOmPz2eDzFzwmlNZ7bwfctfKFVUfxcfGPTHSGye1/9MVo+89yDElns+R0r4ECUNDZsWZ
         6hEiT7SqGBXGehVyNg0VjFj34oLmHU6N5vdkFamci1gfAGZKlcbls4jMS8mj6Zel1XsD
         sGuvYJQEG1/ccyK/z3wFS1w8EGTT0WHJb7ej67hks1lgm+9eJYZ9Yj9pso1vMSPqoYLm
         boB+iUpREEIQ8h4PYToxqCtBdYN25M7rWxCY3uPTBB4OUhnfihI6GHR1W+hKpHiOxN7s
         u3aA==
X-Gm-Message-State: AOJu0Ywgcm2KIXgaN+sLiqjQDTpvWwK7YtggIrram5f0J6ovyvunYX5I
	cDbBkwQPc4aBGTUXnMT3H6uva8nihffPSMMRm2RklGLi5GZ6YnopFWgR
X-Gm-Gg: ATEYQzysL3OAHmZOt4Ngpu5q//rvZD/cbIlnrI75g2b2xqUfzKTcPHCqwSK5be1mRcu
	/Qs/xMZTOoQU9qsc1lX0SaULKLGg1e8uVqvz7AWaFUSp4C9EIJgi3ORt9vp/BggSOTojAm+uN1j
	oDvnsw9Wy7hFq8dpR4FqqO/JCITVhzH3Yc9VbxxNVT8TTAuU9SWxh55nvEWE8ynZXhEGfsUOgUv
	+l0LVcMvM8LbNteoa1Ta0YiueExBJ0zgBZqLPwKHBf7YJrDVtn+//+1Qu8KGxhieMH83zE1Imnq
	5HmoSQtPPGUeu62XxDyNoLIWuktf6O9LqihdGBlxEUj1eQhqSXfuCTSBqQYSoQ5xQzvCO//bu9S
	Cljtyk+p0vBcvuQM6yAIE/+WrZiy9kIuWOc7HkhRTQb5b7F6g2MYcjmQZ5v65mrfctH7lsaAjct
	CRUDjB1gDq9eTVUOQMP1WaUB+ntNC3m2WfBGo=
X-Received: by 2002:a05:600c:1988:b0:480:6612:253 with SMTP id 5b1f17b1804b1-483a962e4demr170537225e9.3.1772082216121;
        Wed, 25 Feb 2026 21:03:36 -0800 (PST)
Received: from [192.168.1.13] ([193.122.84.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd765604sm103808285e9.15.2026.02.25.21.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 21:03:35 -0800 (PST)
Message-ID: <f5788abc-f4de-4f3a-9ab1-7aaa579c89c9@gmail.com>
Date: Thu, 26 Feb 2026 13:03:21 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: inhibit extent buffer writeback to prevent
 COW amplification
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
 Filipe Manana <fdmanana@suse.com>
References: <20260226023050.2138594-1-loemra.dev@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260226023050.2138594-1-loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21946-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 329411A0F6E
X-Rspamd-Action: no action



On 2026/2/26 10:30, Leo Martins wrote:
> On Wed, 25 Feb 2026 14:17:24 +0800 Sun YangKai <sunk67188@gmail.com> wrote:
> 
>>
>>
>> On 2026/2/25 03:22, Leo Martins wrote:
>>> Inhibit writeback on COW'd extent buffers for the lifetime of the
>>> transaction handle, preventing background writeback from setting
>>> BTRFS_HEADER_FLAG_WRITTEN and causing unnecessary re-COW.
>>>
>>> COW amplification occurs when background writeback flushes an extent
>>> buffer that a transaction handle is still actively modifying. When
>>> lock_extent_buffer_for_io() transitions a buffer from dirty to
>>> writeback, it sets BTRFS_HEADER_FLAG_WRITTEN, marking the block as
>>> having been persisted to disk at its current bytenr. Once WRITTEN is
>>> set, should_cow_block() must either COW the block again or overwrite
>>> it in place, both of which are unnecessary overhead when the buffer
>>> is still being modified by the same handle that allocated it. By
>>> inhibiting background writeback on actively-used buffers, WRITTEN is
>>> never set while a transaction handle holds a reference to the buffer,
>>> avoiding this overhead entirely.
>>>
>>> Add an atomic_t writeback_inhibitors counter to struct extent_buffer,
>>> which fits in an existing 6-byte hole without increasing struct size.
>>> When a buffer is COW'd in btrfs_force_cow_block(), call
>>> btrfs_inhibit_eb_writeback() to store the eb in the transaction
>>> handle's writeback_inhibited_ebs xarray (keyed by eb->start), take a
>>> reference, and increment writeback_inhibitors. The function handles
>>> dedup (same eb inhibited twice by the same handle) and replacement
>>> (different eb at the same logical address). Allocation failure is
>>> graceful: the buffer simply falls back to the pre-existing behavior
>>> where it may be written back and re-COW'd.
>>>
>>> In lock_extent_buffer_for_io(), when writeback_inhibitors is non-zero
>>> and the writeback mode is WB_SYNC_NONE, skip the buffer. WB_SYNC_NONE
>>> is used by the VM flusher threads for background and periodic
>>> writeback, which are the only paths that cause COW amplification by
>>> opportunistically writing out dirty extent buffers mid-transaction.
>>> Skipping these is safe because the buffers remain dirty in the page
>>> cache and will be written out at transaction commit time.
>>>
>>> WB_SYNC_ALL must always proceed regardless of writeback_inhibitors.
>>> This is required for correctness in the fsync path: btrfs_sync_log()
>>> writes log tree blocks via filemap_fdatawrite_range() (WB_SYNC_ALL)
>>> while the transaction handle that inhibited those same blocks is still
>>> active. Without the WB_SYNC_ALL bypass, those inhibited log tree
>>> blocks would be silently skipped, resulting in an incomplete log on
>>> disk and corruption on replay. btrfs_write_and_wait_transaction()
>>> also uses WB_SYNC_ALL via filemap_fdatawrite_range(); for that path,
>>> inhibitors are already cleared beforehand, but the bypass ensures
>>> correctness regardless.
>>>
>>> Uninhibit in __btrfs_end_transaction() before atomic_dec(num_writers)
>>> to prevent a race where the committer proceeds while buffers are still
>>> inhibited. Also uninhibit in btrfs_commit_transaction() before writing
>>> and in cleanup_transaction() for the error path.
>>>
>>> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/ctree.c       |  4 +++
>>>    fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
>>>    fs/btrfs/extent_io.h   |  6 ++++
>>>    fs/btrfs/transaction.c | 19 +++++++++++++
>>>    fs/btrfs/transaction.h |  3 ++
>>>    5 files changed, 94 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index 0e02b7b14adc..d4da65bb9096 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -590,6 +590,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>>>    		btrfs_tree_unlock(buf);
>>>    	free_extent_buffer_stale(buf);
>>>    	btrfs_mark_buffer_dirty(trans, cow);
>>> +
>>> +	/* Inhibit writeback on the COW'd buffer for this transaction handle. */
>>> +	btrfs_inhibit_eb_writeback(trans, cow);
>>> +
>>>    	*cow_ret = cow;
>>>    	return 0;
>>>    
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index ff1fc699a6ca..e04e42a81978 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -1940,7 +1940,9 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
>>>    	 * of time.
>>>    	 */
>>>    	spin_lock(&eb->refs_lock);
>>> -	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>>> +	if ((wbc->sync_mode == WB_SYNC_ALL ||
>>> +	     atomic_read(&eb->writeback_inhibitors) == 0) &&
>>> +	    test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>>>    		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>>>    		unsigned long flags;
>>>    
>>> @@ -2999,6 +3001,64 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
>>>    	kmem_cache_free(extent_buffer_cache, eb);
>>>    }
>>>    
>>> +/*
>>> + * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction.
>>> + * @trans: transaction handle that will own the inhibitor
>>> + * @eb: extent buffer to inhibit writeback on
>>> + *
>>> + * Attempts to track this extent buffer in the transaction's inhibited set.
>>> + * If memory allocation fails, the buffer is simply not tracked. It may
>>> + * be written back and need re-COW, which is the original behavior.
>>> + * This is acceptable since inhibiting writeback is an optimization.
>>> + */
>>> +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
>>> +				struct extent_buffer *eb)
>>> +{
>>> +	unsigned long index = eb->start >> trans->fs_info->nodesize_bits;
>>> +	void *old;
>>> +
>>> +	/* Check if already inhibited by this handle. */
>>> +	old = xa_load(&trans->writeback_inhibited_ebs, index);
>>> +	if (old == eb)
>>> +		return;
>>> +
>>> +	/* Take reference for the xarray entry. */
>>> +	refcount_inc(&eb->refs);
>>> +
>>> +	old = xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_NOFS);
>>> +	if (xa_is_err(old)) {
>>> +		/* Allocation failed, just skip inhibiting this buffer. */
>>> +		free_extent_buffer(eb);
>>> +		return;
>>> +	}
>>> +
>>> +	/* Handle replacement of different eb at same index. */
>>> +	if (old && old != eb) {
>>> +		struct extent_buffer *old_eb = old;
>>> +
>>> +		atomic_dec(&old_eb->writeback_inhibitors);
>>> +		free_extent_buffer(old_eb);
>>> +	}
>>> +
>>> +	atomic_inc(&eb->writeback_inhibitors);
>>> +}
>>> +
>>> +/*
>>> + * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers.
>>> + * @trans: transaction handle to clean up
>>> + */
>>> +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans)
>>> +{
>>> +	struct extent_buffer *eb;
>>> +	unsigned long index;
>>> +
>>> +	xa_for_each(&trans->writeback_inhibited_ebs, index, eb) {
>>> +		atomic_dec(&eb->writeback_inhibitors);
>>> +		free_extent_buffer(eb);
>>> +	}
>>> +	xa_destroy(&trans->writeback_inhibited_ebs);
>>> +}
>>> +
>>>    static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>>>    						   u64 start)
>>>    {
>>> @@ -3009,6 +3069,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>>>    	eb->len = fs_info->nodesize;
>>>    	eb->fs_info = fs_info;
>>>    	init_rwsem(&eb->lock);
>>> +	atomic_set(&eb->writeback_inhibitors, 0);
>>>    
>>>    	btrfs_leak_debug_add_eb(eb);
>>>    
>>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>>> index 73571d5d3d5a..fb68fbd4866c 100644
>>> --- a/fs/btrfs/extent_io.h
>>> +++ b/fs/btrfs/extent_io.h
>>> @@ -102,6 +102,8 @@ struct extent_buffer {
>>>    	/* >= 0 if eb belongs to a log tree, -1 otherwise */
>>>    	s8 log_index;
>>>    	u8 folio_shift;
>>> +	/* Inhibits WB_SYNC_NONE writeback when > 0. */
>>> +	atomic_t writeback_inhibitors;
>>
>> I might be missing something here, but I'm curious whether this atomic
>> counter can ever go above 1. If not, and it's strictly binary, perhaps
>> using atomic_set(1/0) instead of atomic_inc/dec would make the intent
>> clearer?
> 
> You're right! It looks like the counter will never go above 1 as we're
> only increasing the counter when we actually COW the eb in
> btrfs_force_cow_block and that will only ever happen once per eb.
> 
> This opens the door for:
>   1. trans_handle A wants to modify eb Z, COWs and inhibits writeback
>      on eb Z
>   2. trans_handle B wants to modify eb Z, does not COW because same
>      transaction generation and not WRITTEN, does not inhibit writeback
> 	on eb Z
>   3. trans_handle A finishes, uninhibits eb Z
>   4. trans_handle B still modifying eb Z with no inhibition
> 
> This leaves the door open for COW amplification. The correct thing to
> do is inhibit writeback not only when the buffer is COW'd, but
> whenever the handle resuses a COW'd buffer without re-COWing.

Oh, I've just got the idea. It's inhibited per trans handle. Then it 
makes a lot of sense.

There might be some ebs that were inhibited due to tree rebalancing or 
tree walking and are no longer used, but I don't think this is a blocker 
for this patch.

Looking forward to your next patch version :)

> Will send out an updated v4 shortly, good catch!
> 
>>
>> Otherwise looks good. Thanks.

