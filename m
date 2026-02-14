Return-Path: <linux-btrfs+bounces-21676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LLfvJAvPj2l7TwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21676-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 02:25:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2A13AA41
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 02:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AC93040762
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C4284881;
	Sat, 14 Feb 2026 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT6Nu328"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A01A9F96
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Feb 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032319; cv=none; b=E8+bLadDTtx1PH0v6qE+33FSR1G6qE5ISYPGByitrwWAYbhvZC5FeGRCs7PVeUsSCcb567BQRimAXoT9KJShNI2tSMku6NG3MuX0B4n9qWZrVgvl/t1kazLZk1S1Th+HC0KPF5f5TmxfeQH02ZGe9svYMKIDzC0Gag3eP9VKryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032319; c=relaxed/simple;
	bh=LQ5Oh1YV4ofIxc6zVPKC4oq22El4Zl+/wYKBzv5PJfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=em1zoONjnGUmdKOwQoJT1iHVCRNRQXEJE1HzU/RURZEXV1AW8HF0Gy7igsXhY2YJ9309fdtQibdplxRnQAN+OaVB0P8E2zOPhNh3ynzNqF46FddgTZYnp2RdBogPABhYC9biUGOmi4/JK+ucVCDaFepd4//VA6+35YJ0naufiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT6Nu328; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so2092095e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 17:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771032316; x=1771637116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fi3iKz7gVqDNQPpY73oZXZ/w2lVJizTGlo8rBa+Mcmk=;
        b=cT6Nu328vz5mO7OXDIaDzi3K1xzWmLiTYwIn/TgikbM1hdiV33kwlzZrH7blNG+onW
         RlvbmTMRsXBLtOXry+SqVVazHRr+xak3reyDIZfo8avN8Gz+xnc04rpjR5Gmlaooy3mp
         cmNQwl1M0jDWFuksx7fglKPhcESQlGwPBp0MLlf6Nz2vTBWDvwpXnO/+K9+AgAzpjGm0
         MGO9envJwmis9AFLyBrerkKExXyz/+E4Zxv6kpiqPsFQsFnxMzh8n9X2WI0tEQ6aGHAV
         XcNLEwroePGV4k0eyup/hu6f8646uSl6Ny7YMYhtmK97Tv/dlEzLBFpXUx3EIYIcqfia
         dsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032316; x=1771637116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi3iKz7gVqDNQPpY73oZXZ/w2lVJizTGlo8rBa+Mcmk=;
        b=FYkUKjvJtO+sjgVOcJ+l3u9cGbegxso24aG8Rj5dBhDtQEWCwpsaUxS49kuHjVqKHn
         iTNzd24qHdi7Px1rH78CvnhcB0QsGNNX0er+HjcpA6Yo7SQ+tciP4Xs0xFbZ3RSVgT3K
         nDJgLgeXzRGtx5weGM0IQOcgt+MbMlq/Ekz8Go5HdP9Gz838EYB24VsxpYy9+r38oWoj
         kCjK+h65tJD4crpMl9hSifluuGdap+/BcGJ1elvbK/TSCI3eO0ZsEAAszPetdgyOX+IZ
         YUr8/6NExORJgWpaQPfEeqJb8/30j4DbS6SqZbFeBM/Vzc5t/c/Z5O33e0li/ut49jq5
         /6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vyZtMJ73Jj2xjoOyYxVDmlUDmVH0+ibTUUa/xSE9LQhBdg0eKv0uKcrWEMejiLZQ7YvwmWhUSnwPtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQrbdjaMuIuGM00JOPXJGS5AHGTZytvHu7C/P0i6Adanxz6s0
	3eWm/HyLG0GEzgVBQBFXbGRxDKn1Cvnam4lzlnl9M42LJpRSbEw3o0eD
X-Gm-Gg: AZuq6aK+5O19NUueyrnTi8hS1mfJuDHJpJIj9G8DC2ocfwB5/qfZ37kenFfPgUGaaM3
	wyb8shRWZqyovUHHCtM7pslVuJ21rHlCtT3574a16n0bmnRb5RTSMpEYOiFC4HWbd5dNpk/I7C3
	Vj47PAg2G1u9jrkqUibHzBcfh5A0jrc5mQ0xY/USCThuNsVUHkJPKQy63dCucyxHQ/F7BFbnQJ5
	0rIG630IC1aw+ZaqrteKj2kG4YcnPZ+KQipw04KqbbjRvO24TggfAaA0GxgLEjGFtHuSnvhJJiR
	/mG81vDQQJf0KRS9aVaCk/nPoEU77Xwnat6rj2XM8QG3C0iWI0jeNDPwqCoCmkgRz+j0GZkPFyt
	7yqdn/Jq2JQbzPB86gQIoKjATRjcgv8kZJYW0CU8PPhZMvr460Yxx2etOPuhami91Tg3jTOPJVi
	BZUH2IWDEdbYeewlSXtzgNBhR97tICS7K3T/2uKKolh4ElRbpwIA6ER/ZONkSs65HqXCijIJIk1
	L2R0A==
X-Received: by 2002:a05:600c:4687:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-4837106417cmr46034265e9.6.1771032315798;
        Fri, 13 Feb 2026 17:25:15 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:7ef5:5763:2b66:78ee? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b4cdsm10288749f8f.8.2026.02.13.17.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 17:25:15 -0800 (PST)
Message-ID: <bcde0730-b3d4-4aa2-88f9-7fee861601cc@gmail.com>
Date: Sat, 14 Feb 2026 09:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] btrfs: skip COW for written extent buffers
 allocated in current transaction
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1771012202.git.loemra.dev@gmail.com>
 <04eca407999f1db58a4af9f4d88397aa2edd2d3c.1771012202.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <04eca407999f1db58a4af9f4d88397aa2edd2d3c.1771012202.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21676-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBB2A13AA41
X-Rspamd-Action: no action

Thanks for your working on this and I've expecting this for a long time :)

On 2026/2/14 04:30, Leo Martins wrote:
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
> btrfs_init_new_buffer() when the block was first allocated, but
> background writeback may have already written and cleared it.
> 
> Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> correctly pins the block if it is freed later.
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
> ---
>   fs/btrfs/ctree.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..a345e1be24d8 100644
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
> @@ -621,8 +621,55 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
>   	if (btrfs_header_generation(buf) != trans->transid)
>   		return true;
>   
> -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +		/*
> +		 * The buffer was allocated in this transaction and has been
> +		 * written back to disk (WRITTEN is set). Normally we'd COW
> +		 * it again, but since the committed superblock doesn't
> +		 * reference this buffer (it was allocated this transaction),
> +		 * we can safely overwrite it in place.
> +		 *
> +		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> +		 * persisted at this bytenr and will be again after the
> +		 * in-place update. This is important so that
> +		 * btrfs_free_tree_block() correctly pins the block if it is
> +		 * freed later (e.g., during tree rebalancing or FORCE_COW).
> +		 *
> +		 * We re-dirty the buffer to ensure the in-place modifications
> +		 * will be written back to disk.
> +		 *
> +		 * Exclusions:
> +		 * - Log trees: log blocks are written and immediately
> +		 *   referenced by a committed superblock via
> +		 *   btrfs_sync_log(), bypassing the normal transaction
> +		 *   commit. Overwriting in place could corrupt the
> +		 *   committed log.
> +		 * - Zoned devices: require sequential writes
> +		 * - FORCE_COW: snapshot in progress
> +		 * - RELOC flag: block being relocated
> +		 */
> +		if (!test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) &&
> +		    !btrfs_is_zoned(root->fs_info) &&
> +		    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
> +		    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&
it seems we need smp_mb__before_atomic() to see the FORCE_COW bit?
> +		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) {
> +			/*
> +			 * Re-register this block's range in the current
> +			 * transaction's dirty_pages so that
> +			 * btrfs_write_and_wait_transaction() writes it.
> +			 * The range was originally registered when the block
> +			 * was allocated, but that transaction's dirty_pages
> +			 * may have already been released.
> +			 */
> +			btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> +					     buf->start,
> +					     buf->start + buf->len - 1,
> +					     EXTENT_DIRTY, NULL);
> +			set_extent_buffer_dirty(buf);
why use set_extent_buffer_dirty() instead of btrfs_mark_buffer_dirty()? 
I don't see any other callers doing this.
> +			return false;
> +		}
>   		return true;
> +	}
>   
>   	/* Ensure we can see the FORCE_COW bit. */
>   	smp_mb__before_atomic();

And I wonder if we could have something more readable like this:

	if (btrfs_header_generation(buf) != trans->transid)
		return true;

	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
		return true;

	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
		return true;

	/* Ensure we can see the FORCE_COW bit. */
	smp_mb__before_atomic();
	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
		return true;

	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID ||
		    btrfs_is_zoned(root->fs_info))
				return true;
		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
				     buf->start,
				     buf->start + buf->len - 1,
				     EXTENT_DIRTY, NULL);
		btrfs_mark_buffer_dirty(trans, buf);
	}

	return false;

Thanks,
Sun YangKai



