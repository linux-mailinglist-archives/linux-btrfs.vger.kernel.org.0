Return-Path: <linux-btrfs+bounces-12509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B68AA6D457
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 07:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138BF7A5DC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0719F12D;
	Mon, 24 Mar 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M9K118b9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59119F111
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797930; cv=none; b=QWbzZuvfcZnvFLgrXsmBUlI0cAbsvBSwms/rhWm+x/UrE0IDpKvSlk3WlvJPZToQL7sc0bkcT0i9IRIXnHV33BjA7TbyjmXAKMPOJRjeUdXKmDVxtdcwd+tNS3i5zWstx//JVUR9VPQF0UYGLdM/MUsY6dLWVM6p6qlAAWCHNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797930; c=relaxed/simple;
	bh=EHBEoDzF00/31D95eVsKYWLxl0H0+xQvwwiBIaEkRBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZKMOOMSLqNF6isGwxaGuc9DbnE/dfC2OS+xWuiF1kCFEEXm2+O0nvjVFmmzkDbXEsswTrNu4pIps5jAjr0eBzWWE6ooiEWNgsk/2fw+dAlWOsoHNDE9eXqcZabY/RHqkSPwGlN5FH32JyWQvWd7OQcPPLvyNz1UmDMf6rV8bl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M9K118b9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3169345f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Mar 2025 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742797926; x=1743402726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pqie7HCAD51+pQa38Vs9kqa6hR7XJMjbClr4B+0EadI=;
        b=M9K118b9CfPlt/MdpM3plXFAhfoyauU2RRtfXp1Us7hnSibUx4ejarbgbiwKYVVRdi
         UZ1lCXrPw2I9BI+roPQPWQQGtC+4bIljwPBr7YQAPxOIwoG2WymUwTwZSQ5sfPhZC+5b
         bEZp8Tg+Q2UDbe2h0uRTuR8AbLmA0YwMR+BjabF5xoC1/s59D9hdbDmKGZGkowqhi11m
         q3lc2GMuyqqKPwXwEcycHaqEHdI8+0fJFAg9mEGyR3dvvo9qzknpcjLKrVNYVD/D8Joo
         kwHHf7yrNBul7gWhL+Twrz/C6ApJPp7X6/kMz/0/nC0DbP3rwvnI6Cl9SqR8bmzNbNdu
         BA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742797926; x=1743402726;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqie7HCAD51+pQa38Vs9kqa6hR7XJMjbClr4B+0EadI=;
        b=CK0mEYrdnaVgnCVHMRp6T5dOrhZRE1USmBOupL6hXVBnwIm4++E2UevFWUj9Svqg31
         Z9t7wdOntBu495tpCuAx7OonULc4D5tHmfWbtgWz6n/wIaKfmATl2F9qJbB85UOwbH9/
         Zm6BZaVSECGESPgJ0f0tIUpeKO8ZYbz5znd6v593A+2MtTOw1QxtEuuSZ+6rrrUhUNOA
         fMOrqgP80LuosYK3JzM8Ph6fORpARqGumMcRUsCMZrWMafYvIrl2EXsWVCjoItdnRJCU
         ing2UZuybZV3JS2Cco7x2D4ZNeCYrpTAfWcBt9jyg1OfjXaSE3twaCx0cbj1AH4J7uYm
         6Vfw==
X-Gm-Message-State: AOJu0YyGBp+HBwjP1VQ4lOpBD+R6XNANw1CYWGlE7p36MqMmQXkg9cbM
	q0CWTKdlyQ7hZGcLjdMJ7KFqvFCDnCpcbWXItFnx470tKfyc8wKKAop+6r2wg4R6gESibOKDTXP
	N
X-Gm-Gg: ASbGncsrKyfvzgksE9mA1PIMX40x/pZt2KCW2iRgslu6xzO3ytz9Ycea0/zT7VNz62O
	MVIOpNbuwe6qVPVzxEpqnCgB4jlGs7V0Jx5/laC0HEtHhzkWV4XQpYrBEVLHcnM/IoK9HuRmnY+
	wU6e5E/ic1uUwYUeUgPXLM5+fdf2MdeJgw5Z8ywFl66yk/CtmWaJRZql6E8LdO0IaZbb2XqKHfR
	IjQ7G9X+JgiIpD8rMA+lwJJWenFkOimUtJeFwMNiJrM8TgraEH1Togl+rjfnbEXtOKW4BKSktF8
	zoCeZgkOibYSk0HwfPM4922JbWZFSy35iH39dh++RnDB5rkGe5WdCtlpANDRNtSdYqMF/Qn2
X-Google-Smtp-Source: AGHT+IHyiiPytH5iTwVwcglxiKcBk3A6ZVzuv2HFM1L+MmdT8PX7LxA+n7O5MLFRLFfqrQ2lpzns5A==
X-Received: by 2002:a05:6000:4027:b0:391:241d:a13e with SMTP id ffacd0b85a97d-3997f9405famr10493572f8f.48.1742797925585;
        Sun, 23 Mar 2025 23:32:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73907b36bfasm6835591b3a.2.2025.03.23.23.32.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 23:32:05 -0700 (PDT)
Message-ID: <c821b371-de96-4174-83f4-0d3e75e518f3@suse.com>
Date: Mon, 24 Mar 2025 17:02:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify the reserved space handling inside
 copy_one_range()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <dd15d8ede1b17f86d2be14390c3927b1633b1a72.1742776906.git.wqu@suse.com>
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
In-Reply-To: <dd15d8ede1b17f86d2be14390c3927b1633b1a72.1742776906.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/24 11:11, Qu Wenruo 写道:
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
>    The range to be released is always [@last_block, @reserved_start +
>    @reserved_len), and the new @reserved_len will always be
>    @last_block - @reserved_start.
>    (@last_block is the exclusive block aligned file offset).
> 
> - Remove the five variables we no longer need
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/file.c | 71 ++++++++++++++++++++++---------------------------
>   1 file changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index b72fc00bc2f6..4d83962ec8d6 100644
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
> @@ -1190,23 +1188,22 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   			    &only_release_metadata);
>   	if (ret < 0)
>   		return ret;
> -	reserve_bytes = ret;
> -	release_bytes = reserve_bytes;
> +	reserved_len = ret;
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
> @@ -1217,8 +1214,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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
> @@ -1235,36 +1232,32 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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
> +
> +		if (copied == 0)
> +			last_block = round_down(start, blocksize);

This changed the release range for short-copy.

Originally for a zero-copied case, we only release from round_up(start, 
blocksize) to the end.

And the current block is later released by that "release_bytes = 
round_up(copied + block_offset, fs_info->sectorsize);" line.

But now we release every range in one go.

Normally this should be fine, but later btrfs_delalloc_release_extents() 
itself can not handle zero length properly.


So the fix is pretty simple, just skip the 
btrfs_delalloc_release_extents() call if our reserved_len is already.

Thanks,
Qu> +
> +		/*
> +		 * Since we got a short copy, release the reserved bytes
> +		 * byond the last block.
> +		 */
> +		if (only_release_metadata)
> +			btrfs_delalloc_release_metadata(inode, release_len, true);
> +		else
> +			btrfs_delalloc_release_space(inode, *data_reserved,
> +					last_block, release_len, true);
> +		reserved_len = last_block - reserved_start;
>   	}
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
> -		}
> -	}
> -	release_bytes = round_up(copied + block_offset, fs_info->sectorsize);
> -
>   	ret = btrfs_dirty_folio(inode, folio, start, copied,
>   				&cached_state, only_release_metadata);
>   	/*
> @@ -1280,10 +1273,10 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
>   	else
>   		free_extent_state(cached_state);
>   
> -	btrfs_delalloc_release_extents(inode, reserve_bytes);
> +	btrfs_delalloc_release_extents(inode, reserved_len);
>   	if (ret) {
>   		btrfs_drop_folio(fs_info, folio, start, copied);
> -		release_space(inode, *data_reserved, start, release_bytes,
> +		release_space(inode, *data_reserved, reserved_start, reserved_len,
>   			      only_release_metadata);
>   		return ret;
>   	}

