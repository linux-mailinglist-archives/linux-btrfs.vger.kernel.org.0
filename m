Return-Path: <linux-btrfs+bounces-12587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF4A7107E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 07:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33C43AC409
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC898189916;
	Wed, 26 Mar 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+cZedty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFD176AC8
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969967; cv=none; b=sORij9RtxFV/7nfDSg3oL/J/JggiC19JzuAluREugUZbZozODPt9JmYffAvfqwoSBnEf6Hj1JXqA0ubWBHaOWF0vBMDILu2HV4fTvd1NpQlOh0CnzOgpjzwPppLm1Ef8V7ozCC4O6Y1HRMEzhGmUe2UUHoGUI+gZibLWlA7tWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969967; c=relaxed/simple;
	bh=ZDoYtZypwCnUqbIX7sKFYgsl1PK6UM8wHQnJjEMJ6WA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O0bJTUme1To48QaRa4pGyP+jZUa8h6x0J8tiVACl7YmD1Vu+WL9pEPfE2Gax98SxYmIogU+2sk0kw4nj2//v2hD0vFSlC1r82t1gmF1C1fcSQ5HIZHLoX6N11tV3pKOqiDSyikRF9qKH5TLPNG0Y8zU7yWCs1bj7hDo2mE8ARHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+cZedty; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3667635f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742969962; x=1743574762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yusxF91Wc3ISU7OaL86oTRMlkH4j2TEqKd8t8qa8hQI=;
        b=W+cZedtyoGPlX2sG+Oq+EoBjPAGnzT150htrNTRmzTdn7GtlFfmn+cnWWZgJPlDxIB
         p/cvU++KmX86PmhGo8xgPDmOrMmw0xVIQet6+oDwQE8ctbz54wAIezcl4KWnsR/UDS85
         5f0O7GTQkx2JtGo3HZM5AEu28x9ok+7StY5wHc/ktrtF7ejLNW68KiLGV0aLMRm+wV2I
         v/E86yqncEvd1fCTkqiQxUziS2CZzDvTKbo7rdAgCXYEkZWN1woaiM+knVDd8DA7ncFI
         Zg30c70JvXDE7wvpBvUf9qJpzu6cBA2h8boie0PAo81cg9WbB/w2eoVqGCY6OHJlPFZg
         x6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969962; x=1743574762;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yusxF91Wc3ISU7OaL86oTRMlkH4j2TEqKd8t8qa8hQI=;
        b=iCpQiSdxZkWCm9yBMMSAuJ8lwGg3xy8952DxDa378m6fEj8/6TP7mirnb+r259HXRg
         Kb8+o3b/C7Uy3dQwrqAx1aQgyzDlEiRZiYOe7SZG8LkHe1E1mOqfQjbrk92cjPIiO70/
         ZPmFi5Irx9P1HQd0Q4JjalQSKzSLEOICJZxzIYeo5pnbi3eOY6i3G6Nq46pzatPUgOiM
         AqeHIsDvaWPrmiLmNVJRX/bIkC1weGuuD08cI/3Waw0wPThZqtTM0/yt3V3iPGNGRA+Y
         yWw6LVyXaRTTjQDytC49xRGjbIYMQQ8dkJcQgjbZjVVKSswbiz1nV1kQ4oTckm7xX4Zq
         z0Mw==
X-Gm-Message-State: AOJu0Yw3YIfzrQbKvAFFlQRz0pSpzgkPvRBf5O+bmbmDuhT6eut6OE8x
	dkJGHF8f57wnWSTScOZGM/HO//yq9eKveTYb8da9+ghBVjUptdDxdse7OWHZe+Q/1oP+7eVtmdh
	2
X-Gm-Gg: ASbGncstNusqOc2QZAhmH5B8pPx1WuZc44NQ2ElgVeGJqXFj2PwXOTllShn/9beSU7c
	Dg5VAlfcLvcb2sr0Wvk7N/2+J3nuEmHJg+vDRpxIERfBVmdFEs0S1MTyJGseKjU30xvt8Ljuu6Y
	Zd2fWyc+WKoHFkjaY++KHACfMxK6gp2tasQU7JV+suS9BV0nMujCgGztCRoWtlWL3Y81dbA1pxP
	x63v4KyEcOgTQ2a+JtzQCOyX2ntvSbTuER5eoiuBPACZBKSur2d4QU/eYCj9U0TQCV30qkE0fVo
	rHI6bLnFLLY8n6v/I4s6jKpzfbCmIhT9PJ+4nd7PJ5enFnTXdAlTeHh86W88+obWEKKWJmts
X-Google-Smtp-Source: AGHT+IFW0Unf+TVRfb6/noYdKkYLi/r8bhnO51aMSmw6qVHLGDvGRLqL+6d7vxAuXcJLzThFDYdTsQ==
X-Received: by 2002:a05:6000:2ce:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-3997f93c36emr21229719f8f.51.1742969961943;
        Tue, 25 Mar 2025 23:19:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611c950sm11654667b3a.104.2025.03.25.23.19.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 23:19:21 -0700 (PDT)
Message-ID: <95bc9f53-93c9-4a93-a892-62ec5519bfb0@suse.com>
Date: Wed, 26 Mar 2025 16:49:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: simplify the reserved space handling inside
 copy_one_range()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <75e2c5599917601879ad120425376d54e95cb49c.1742889641.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <75e2c5599917601879ad120425376d54e95cb49c.1742889641.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/25 18:31, Qu Wenruo 写道:
> Inside that function we have the following variables all involved to
> help handling the reserved space:
> 
> - block_offset
> - reserve_bytes
> - dirty_blocks
> - num_blocks
> - release_bytes
> 
> Many of them (block_offset, dirty_blocks, num_blocks) are only utilized
> once or twice as a temporary variables.
> 
> Furthermore the variable @release_bytes are utilized for two different
> operations:
> 
> - As a temporary variable to release exceed range if a short copy
>    happened
>    And after a short-copy, the @release_bytes will be immediately
>    re-calculated to cancel the change such temporary usage.
> 
> - As a variables to record the length that will be released
> 
> And there is even a bug in the short-copy handling:
> 
> - btrfs_delalloc_release_extents() is not called for short-copy
>    Which looks like a bug from the very beginning, affecting both
>    zero byte copied and partial copied cases.
>    This can lead to rare generic/027 kernel warnings for subpage block
>    size.
> 
> To fix all those unnecessary variables along with the inconsistent
> variable usage:
> 
> - Introduce @reserved_start and @reserved_len variable
>    Both are utilized to track the current reserved range (block aligned).
> 
> - Use above variables to calculate the range which needs to be shrunk
>    When a short copy happened, we need to shrink the reserved space
>    beyond the last block.
> 
> - Handle zero byte copied case and return immediately
>    Not all functions are handling 0 length correct, and to be extra safe,
>    just manually do the cleanup and exit.
> 
> - Call btrfs_delalloc_release_extents() for short-copy cases
>    This also fixes a bug in the original code that it doesn't call
>    btrfs_delalloc_release_extents() to release the ranges beyond
>    the last block.
> 
> - Remove the five variables we no longer need
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Do cleanup and return directly if no byte is copied
> 
> - Call btrfs_delalloc_release_extents() when short copy happened
>    Which is not done in the original code.
> 
> v2:
> - Fix a bug that can be triggered by generic/027 with subpage block size
>    The fix is to keep the old behavior that the first block will only be
>    released by btrfs_delalloc_release_extents() after
>    btrfs_dirty_folio().
> ---
>   fs/btrfs/file.c | 79 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 42 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index b72fc00bc2f6..0b637e61fdee 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1164,15 +1164,13 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct extent_state *cached_state = NULL;
> -	const size_t block_offset = start & (fs_info->sectorsize - 1);
> +	const u32 blocksize = fs_info->sectorsize;
>   	size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset_in_page(start));
> -	size_t reserve_bytes;
>   	size_t copied;
> -	size_t dirty_blocks;
> -	size_t num_blocks;
>   	struct folio *folio = NULL;
> -	u64 release_bytes;
>   	int extents_locked;
> +	const u64 reserved_start = round_down(start, blocksize);
> +	u64 reserved_len;
>   	u64 lockstart;
>   	u64 lockend;
>   	bool only_release_metadata = false;
> @@ -1190,23 +1188,25 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   			    &only_release_metadata);
>   	if (ret < 0)
>   		return ret;
> -	reserve_bytes = ret;
> -	release_bytes = reserve_bytes;
> +	reserved_len = ret;
> +	/* The write range must be inside the reserved range. */
> +	ASSERT(start >= reserved_start);
> +	ASSERT(start + write_bytes <= reserved_start + reserved_len);
>   
>   again:
>   	ret = balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_mapping,
>   						    bdp_flags);
>   	if (ret) {
> -		btrfs_delalloc_release_extents(inode, reserve_bytes);
> -		release_space(inode, *data_reserved, start, release_bytes,
> +		btrfs_delalloc_release_extents(inode, reserved_len);
> +		release_space(inode, *data_reserved, reserved_start, reserved_len,
>   			      only_release_metadata);
>   		return ret;
>   	}
>   
>   	ret = prepare_one_folio(&inode->vfs_inode, &folio, start, write_bytes, false);
>   	if (ret) {
> -		btrfs_delalloc_release_extents(inode, reserve_bytes);
> -		release_space(inode, *data_reserved, start, release_bytes,
> +		btrfs_delalloc_release_extents(inode, reserved_len);
> +		release_space(inode, *data_reserved, reserved_start, reserved_len,
>   			      only_release_metadata);
>   		return ret;
>   	}
> @@ -1217,8 +1217,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   		if (!nowait && extents_locked == -EAGAIN)
>   			goto again;
>   
> -		btrfs_delalloc_release_extents(inode, reserve_bytes);
> -		release_space(inode, *data_reserved, start, release_bytes,
> +		btrfs_delalloc_release_extents(inode, reserved_len);
> +		release_space(inode, *data_reserved, reserved_start, reserved_len,
>   			      only_release_metadata);
>   		ret = extents_locked;
>   		return ret;
> @@ -1235,35 +1235,40 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   	 * sure they don't happen by forcing retry this copy.
>   	 */
>   	if (unlikely(copied < write_bytes)) {
> +		u64 last_block;
> +		u64 release_len;
> +
>   		if (!folio_test_uptodate(folio)) {
>   			iov_iter_revert(i, copied);
>   			copied = 0;
>   		}
> -	}
>   
> -	num_blocks = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
> -	dirty_blocks = round_up(copied + block_offset, fs_info->sectorsize);
> -	dirty_blocks = BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
> -
> -	if (copied == 0)
> -		dirty_blocks = 0;
> -
> -	if (num_blocks > dirty_blocks) {
> -		/* Release everything except the sectors we dirtied. */
> -		release_bytes -= dirty_blocks << fs_info->sectorsize_bits;
> -		if (only_release_metadata) {
> -			btrfs_delalloc_release_metadata(inode,
> -						release_bytes, true);
> -		} else {
> -			const u64 release_start = round_up(start + copied,
> -							   fs_info->sectorsize);
> -
> -			btrfs_delalloc_release_space(inode,
> -					*data_reserved, release_start,
> -					release_bytes, true);
> +		if (copied == 0) {
> +			btrfs_drop_folio(fs_info, folio, start, copied);
> +			if (extents_locked)
> +				unlock_extent(&inode->io_tree, lockstart, lockend,
> +				      &cached_state);
> +			else
> +				free_extent_state(cached_state);
> +			btrfs_delalloc_release_extents(inode, reserved_len);
> +			release_space(inode, *data_reserved, reserved_start,
> +				      reserved_len, only_release_metadata);
> +			return 0;
>   		}
> +
> +		/* Release space beyond the last block and continue. */
> +		last_block = round_up(start + copied, blocksize);
> +		release_len = reserved_start + reserved_len - last_block;
> +		btrfs_delalloc_release_extents(inode, release_len);

This is incorrect.

The behavior of btrfs_delalloc_release_extents() is never as accurate as 
things like qgroup reserved space.
And it can not handle reserved space shrinking in this case.

It is only purely based on the @num_bytes, and it is always calculated 
based on the maximum extent size.

So for our current code, btrfs_delalloc_release_extents() will always 
decrease the outstand extent by one.

Thus if we do the following pattern, it will cause problems:

	btrfs_delalloc_reserve_metadata(reserved_start, reserved_len);
	btrfs_delalloc_release_extent(reserved_len - SZ_4K);
	btrfs_delalloc_release_extent(SZ_4K);

Thus the original code is correct, we should only call 
btrfs_delalloc_release_extent() once after the space is reserved.

I'd better find a proper way to make btrfs_delalloc_release_extent() as 
good as the qgroup rsv space.

As for large data folios, we have to over-reserve before grabbing the 
folio, then release the exceeding part before doing the copy.

Thanks,
Qu



