Return-Path: <linux-btrfs+bounces-20650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AED38C29
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 05:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD403031CCF
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 04:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9B2D29B7;
	Sat, 17 Jan 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gwJcyF7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6923A9B0
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Jan 2026 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624166; cv=none; b=X4ZhY14xNLtmOgMrABAH2Sl7a822E7dqyqj4/hKompmvH2UGMPnjwaxj2wx0P7y34NLsZfDZn850MVRvqU9DtlcfeX7Ee3tVy9hIcsgavBhLWXNMFox7cVjP5csYYNsoCl2C+iFjts0uV7Ezs81BfUxzbzTZ+1HJVjn5n+mqlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624166; c=relaxed/simple;
	bh=5Rin5uoUUcLY/4cHrkHOgF9p0w0P/7JAONSj3ZotY8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=crQRnmymmzbQeNQ67bESZBkn5p+ZljVya+ijYr4k8cu3sXaO/4t9p0nzJDOiMSKNT90DpGd0eqNMmc8z6G3w1KPsPQRvRB5MlKltOFGiTkrkMHT+a98H5Bq3sMfmjTMeHPKF8zkLa2mxJwUMvFwGqYQe29uxaWeC4r7rbwAiiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gwJcyF7L; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee2715254so12536485e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 20:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768624163; x=1769228963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=trTlaKBIHkSVhdkGuoEczNu8J6C52wOUMg6NhMi7MTQ=;
        b=gwJcyF7LHEnGNGFLOg5tcRIngzpJo6VykTx4wXKlNhAXqpRNCSrdnPdfEfIJazGWvI
         HrKw0adzI3261P1tObXhXktWCS5aFrD4nIt1YcL1u774Lr2qU1VdZC7e1itwa5RAkOOI
         MH6W+lFKRPqSs+LkE9Oqu465s+CuQCgMKmnVGqoBaAGTKoU0wk8qw/bNBfN5u1stnrBE
         17OlUF1dnActo9upeaudxECcCDTC2z85T/Zcx/zo6MAajNw8zHxXBng+BEM4SmAUVESP
         x6/zw/bH3dwBDl/1yTjv7jv5E9CaHiYYJMtosMiiGOlsX98PujeuMZEn7uZyQd6w6cY4
         O2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768624163; x=1769228963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trTlaKBIHkSVhdkGuoEczNu8J6C52wOUMg6NhMi7MTQ=;
        b=oL1qOpKkDPBhC6N2clNGzs4v6Iaj2ROB6+toE2RvQplcKQ5otXvaFhFCVzMBxUFtqu
         lrzU2icMu8DYAkzeriz4H+i3tJJ9Ae13u0UbSnuvgHGvDXgmsP+NZDQ7KwnbtmNE0xaE
         grsEl7wqZuIWZjG9QlKBMhdpezIBi1BGse4HW6556QMLkbakdlfTGjRRVYGs6JDat1Of
         ekPhPQFdjH/ssTgD6KIsXQo3g2UZ/ko/qvT+byyH4q0Ti6HmAfAKmTrvad31NHnGpOWN
         fgOkmt7yf0K0Lh2ud94QCbBD+aP+f4aVayNoOia49tFz96v1ohJjJs0YumZ4vMLV8Dpq
         enEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe3Mfe7C4KSSu+dSu/LhzMHhcwg69YYeJU2j1B8vvGCZI6huuUdJnvJpgiLLyoQLqQsvrSqzc7F5PLKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywii1iU56xWdt5odOlWFB5CshgGjDLxwDGow2edtISIwWSnIVW+
	DjaYBOC55ZCFd1xIsMdHpGLsIrIdkgm5IADIvro2DdsatYyKH3aTbEhllUImkThkQbQWAse0Go4
	di4QScd4=
X-Gm-Gg: AY/fxX7wphZDMAV/INifJ80cYrQHmBSjmVKiKh/bnmntkSSO8fnE8IkvV74Y94x+Guk
	ie3wUWdkACWBFm4rZ/JHrSqZYataBzotChlot6aedrma1fU+YIfSAr0ATTmQZOICHJbgT2IVOZq
	UHyQK0wfhQPQSgONnx0c5w4EyKj3UQn71RtdzWzOemw4NHIswlH4xAJwlE+LQg1OF78q4biILMy
	0TS+wgWCNC1XfUL6W+Y9s6GrGNhzzsw2J1Nd7V1eeSXiEoehmW9frWU4KIhsC9wQkvbIWpmg1Qg
	vaTL83Ic+cK/Hpw7Vy3Vm5mzsXsqwxkE8UV2PnWEg9c//l/G4fSg/zBZsw+0Jx4JkeZRr7C+pDd
	V846xOzuGZrNy1KyNDsIMrnx7fo59FGIvNmNYOBgPY1hPRxjoo1dWKAp+c0PjtGpkE2XqfTsleo
	ck5gDZS+Lpll4JlyZAhleZTbFv6nBOl5rb55a03C8=
X-Received: by 2002:a05:600c:3ba8:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4801e2fddcbmr70767755e9.8.1768624162688;
        Fri, 16 Jan 2026 20:29:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412325sm33749625ad.86.2026.01.16.20.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 20:29:22 -0800 (PST)
Message-ID: <ef997c75-868a-4099-8f68-06b8304b7113@suse.com>
Date: Sat, 17 Jan 2026 14:59:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use the btrfs_extent_map_end() helper everywhere
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <69ddaceff63e94c5c1b94f12c52a83a798a9f037.1768561288.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <69ddaceff63e94c5c1b94f12c52a83a798a9f037.1768561288.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/16 21:33, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a helper to calculate an extent map's exclusive end offset, but
> we only use it in some places. Update every site that open codes the
> calculation to use the helper.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/compression.c       |  2 +-
>   fs/btrfs/defrag.c            |  5 +++--
>   fs/btrfs/extent_io.c         |  2 +-
>   fs/btrfs/file.c              |  9 +++++----
>   fs/btrfs/inode.c             |  2 +-
>   fs/btrfs/tests/inode-tests.c | 32 ++++++++++++++++----------------
>   fs/btrfs/tree-log.c          |  2 +-
>   7 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4323d4172c7b..4c6298cf01b2 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -519,7 +519,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   			folio_put(folio);
>   			break;
>   		}
> -		add_size = min(em->start + em->len, page_end + 1) - cur;
> +		add_size = min(btrfs_extent_map_end(em), page_end + 1) - cur;
>   		btrfs_free_extent_map(em);
>   		btrfs_unlock_extent(tree, cur, page_end, NULL);
>   
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index bcc6656ad034..ecf05cd64696 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -792,10 +792,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>   {
>   	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>   	struct extent_map *next;
> +	const u64 em_end = btrfs_extent_map_end(em);
>   	bool ret = false;
>   
>   	/* This is the last extent */
> -	if (em->start + em->len >= i_size_read(inode))
> +	if (em_end >= i_size_read(inode))
>   		return false;
>   
>   	/*
> @@ -804,7 +805,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>   	 * one will not be a target.
>   	 * This will just cause extra IO without really reducing the fragments.
>   	 */
> -	next = defrag_lookup_extent(inode, em->start + em->len, newer_than, locked);
> +	next = defrag_lookup_extent(inode, em_end, newer_than, locked);
>   	/* No more em or hole */
>   	if (!next || next->disk_bytenr >= EXTENT_MAP_LAST_BYTE)
>   		goto out;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bbc55873cb16..cd8c505d92f5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -970,7 +970,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
>   {
>   	const u64 ra_pos = readahead_pos(ractl);
>   	const u64 ra_end = ra_pos + readahead_length(ractl);
> -	const u64 em_end = em->start + em->len;
> +	const u64 em_end = btrfs_extent_map_end(em);
>   
>   	/* No expansion for holes and inline extents. */
>   	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5d47cff5af42..1759776d2d57 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2195,10 +2195,11 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
>   
>   	/* Hole or vacuum extent(only exists in no-hole mode) */
>   	if (em->disk_bytenr == EXTENT_MAP_HOLE) {
> +		const u64 em_end = btrfs_extent_map_end(em);
> +
>   		ret = 1;
> -		*len = em->start + em->len > *start + *len ?
> -		       0 : *start + *len - em->start - em->len;
> -		*start = em->start + em->len;
> +		*len = (em_end > *start + *len) ? 0 : (*start + *len - em_end);
> +		*start = em_end;
>   	}
>   	btrfs_free_extent_map(em);
>   	return ret;
> @@ -2947,7 +2948,7 @@ static int btrfs_zero_range(struct inode *inode,
>   	 * new prealloc extent, so that we get a larger contiguous disk extent.
>   	 */
>   	if (em->start <= alloc_start && (em->flags & EXTENT_FLAG_PREALLOC)) {
> -		const u64 em_end = em->start + em->len;
> +		const u64 em_end = btrfs_extent_map_end(em);
>   
>   		if (em_end >= offset + len) {
>   			/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index be47aa58e944..7a28b947f4a3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7161,7 +7161,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
>   	read_unlock(&em_tree->lock);
>   
>   	if (em) {
> -		if (em->start > start || em->start + em->len <= start)
> +		if (em->start > start || btrfs_extent_map_end(em) <= start)
>   			btrfs_free_extent_map(em);
>   		else if (em->disk_bytenr == EXTENT_MAP_INLINE && folio)
>   			btrfs_free_extent_map(em);
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index a4c2b7748b95..6bd17d059ae6 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -313,7 +313,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   	 * unless we have a page for it to write into.  Maybe we should change
>   	 * this?
>   	 */
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -335,7 +335,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("unexpected flags set, want 0 have %u", em->flags);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* Regular extent */
> @@ -362,7 +362,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("wrong offset, want 0, have %llu", em->offset);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* The next 3 are split extents */
> @@ -391,7 +391,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   	}
>   	disk_bytenr = btrfs_extent_map_block_start(em);
>   	orig_start = em->start;
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -413,7 +413,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("unexpected flags set, want 0 have %u", em->flags);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -446,7 +446,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   			 disk_bytenr, btrfs_extent_map_block_start(em));
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* Prealloc extent */
> @@ -474,7 +474,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("wrong offset, want 0, have %llu", em->offset);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* The next 3 are a half written prealloc extent */
> @@ -504,7 +504,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   	}
>   	disk_bytenr = btrfs_extent_map_block_start(em);
>   	orig_start = em->start;
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -536,7 +536,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -569,7 +569,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* Now for the compressed extent */
> @@ -602,7 +602,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* Split compressed extent */
> @@ -637,7 +637,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   	}
>   	disk_bytenr = btrfs_extent_map_block_start(em);
>   	orig_start = em->start;
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -663,7 +663,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("wrong offset, want 0, have %llu", em->offset);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> @@ -697,7 +697,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	/* A hole between regular extents but no hole extent */
> @@ -724,7 +724,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("wrong offset, want 0, have %llu", em->offset);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
> @@ -756,7 +756,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
>   		test_err("wrong offset, want 0, have %llu", em->offset);
>   		goto out;
>   	}
> -	offset = em->start + em->len;
> +	offset = btrfs_extent_map_end(em);
>   	btrfs_free_extent_map(em);
>   
>   	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6cffcf0c3e7a..e1bd03ebfd98 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -5160,7 +5160,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
>   	if (ctx->logged_before) {
>   		drop_args.path = path;
>   		drop_args.start = em->start;
> -		drop_args.end = em->start + em->len;
> +		drop_args.end = btrfs_extent_map_end(em);
>   		drop_args.replace_extent = true;
>   		drop_args.extent_item_size = sizeof(fi);
>   		ret = btrfs_drop_extents(trans, log, inode, &drop_args);


