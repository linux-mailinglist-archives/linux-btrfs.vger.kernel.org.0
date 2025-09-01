Return-Path: <linux-btrfs+bounces-16547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC2B3D83D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 06:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6489B3A6C62
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 04:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0C22425B;
	Mon,  1 Sep 2025 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OJZ+H+uw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29131C6FE5
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700922; cv=none; b=dF+8bv7cdORHPkYtrDFr2zuJnpfiSCdfA2KuWzZNLaeB+XqHf28aWVKktLI4z482EQuSdWLMa2lfuHUTewVnxbQDH/emgCAhoU/L1ie7TzLYvaT8eBMTi2CcgEfhPQqFdiuaukCh260cxrDsd1bu7KlVEM7KFdYr0AM4uYDEdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700922; c=relaxed/simple;
	bh=x4IhaQ+jaRo88D7Vt6ChT9GPEQHZkkMOY3vkMke57vQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e86hKfGBwVL8W7/aZpS9cSeGzQE1umJPcHjCkcECB1dmB1xKuv63QKNuAe5zg+BaB+Iv/KuKjPnLCPtPlmzNIXSh9cQLq6KLp51go8RDhY5aMMUhe0DD9qRXdQQkkYyKx445JnPY4eqWpsvOjRr4VR9Zm78yWPkVVZWG+PB3yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OJZ+H+uw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ce47d1f1f8so2600594f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Aug 2025 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756700918; x=1757305718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5P5sdzs2XnJhbz6Eihyj7biLpg1KCfZLGVb+oAgonI=;
        b=OJZ+H+uwMhLz2EoKLwD/CAKWAkGrKWx+lZegen6LDnk1edkzJiQ/6mYxZH6/8WntyW
         XhnX2JM5OsDywkU+8HaD5ynBkFZT6UAUtMawAlq1s2iX5AQYF7gShwQPC7aqfLJqKApF
         JqGUQoP28lAeF/W0DKKmNsETFsYj3Jjj70/YSq/uZq0pbbvanR/7Zjznqxgq8YihlUZe
         W0kOIf7EsAVRnPDt1o1OB2EzzT9c4FMkPJSjPGJOLoBTdkMdAOauemTd29tMW8PltGi3
         CK63OD754Jy0mayyOhUY8mUyvAobkC6q5S1pS9xKXr6wcknk9jUkM6tfwkSZIm0lwAQz
         3UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756700918; x=1757305718;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5P5sdzs2XnJhbz6Eihyj7biLpg1KCfZLGVb+oAgonI=;
        b=O44HS1y2POjyR8Et2JXi1IraNRA55Od7E388bW6j8tIFiNEVavxu6SzspEIZYxVo+6
         baYjfZlXlDlJIt8CY0kUe9xBCDbbCoAGXpekKJFJtkx3CECKJuZEp9MpT2vktPxzYnDA
         Y0OLQUFWllXrOzoKQy59d/sOt9DTn0nAQKwbXYBm9hYmC17809OCQQHY4nSaeurrSyCO
         2g1/ACXdvRemsYTzsJ90XMsm7F4CPCfYOseLEeAgl57MX/A/+qSia7v1XsY6ZLyGvsaP
         AvTdvAEI+WJz6JgK74ZG9lqs+vqQXnt5MSpb/lx4tDNnosDZSaYYxhy/deEl5nHlGsCc
         P3wQ==
X-Gm-Message-State: AOJu0YyOf3xzUgyw03Yl/XbaKbSB9hPJjottaNSdJuoSssL0rBCqSzD7
	ecaxhhSfXPkj3Jhi4ZxQZvgvcvvQgauGDQ8D0MQgQSVHPMm9JzXQldll+oZMyO5SzhYobnrwcC4
	uq9LP
X-Gm-Gg: ASbGncukB6vbGClhBcIIBduxJoASbAGfecCfwz3bEXIBNWiK4UvXnsPHY5NwpzJzELG
	YmKTM3bPF5VhioFJIazD+BXCH1eUMhp0diAH4SnpBRfW/WoGOaPC9FmfO6ZCAi2WKB7JM+Xs43Q
	b5R677E+C9wQsGZhIVJdUVe6xIIom7nuA4ub4/ewMRuCXjtSWbu3C9oymJs7KsrmYsj/qrwSlF4
	m5TGFGT10P4G4Y7VwQtSskZZNf92zb/unvvFEx1jj1tBr/Q+tbi8i7gAViEHwCClPptJP8q3796
	6OlALaWtGPkhYFMfkZNcCI/6gsoWyD+gJL84n4J2dzV1uifVOYqh3Iz6WwnMkak9OhmmTuJAMvm
	Zkb5LF5vfEH/l/vxXVwuRdCVkItxRe3bBL2F9vokOBMTsFaYCcHA=
X-Google-Smtp-Source: AGHT+IGD57oZTxLL0n/XLgH0UP+rzT0XB1dOe1/1k1PJFajwn/8mJdXJkghIxU+CrXxSHQDO24ItbQ==
X-Received: by 2002:a05:6000:268a:b0:3d4:2f8c:1d37 with SMTP id ffacd0b85a97d-3d42f8c2014mr4012405f8f.26.1756700918175;
        Sun, 31 Aug 2025 21:28:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490373eb17sm89846995ad.54.2025.08.31.21.28.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 21:28:37 -0700 (PDT)
Message-ID: <ab36aaed-6336-4195-a082-a69276a19edc@suse.com>
Date: Mon, 1 Sep 2025 13:58:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3] btrfs: extract the compressed folio padding into a
 helper
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>
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
In-Reply-To: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/21 15:00, Qu Wenruo 写道:
> Currently after btrfs_compress_folios(), we zero the tail folio at
> compress_file_range() after the btrfs_compress_folios() call.
> 
> However there are several problems with the incoming block size > page
> size support:
> 
> - We may need extra padding folios for the compressed data
>    Or we will submit a write smaller than the block size.
> 
> - The current folio tail zeroing is not covering extra padding folios
> 
> Solve this problem by introducing a dedicated helper,
> pad_compressed_folios(), which will:
> 
> - Do extra basic sanity checks
>    Focusing on the @out_folios and @total_out values.
> 
> - Zero the tailing folio
>    Now we don't need to tail zeroing inside compress_file_range()
>    anymore.
> 
> - Add extra padding zero folios
>    So that for bs > ps cases, the compressed data will always be bs
>    aligned.
> 
>    This also implies we won't allocate dedicated large folios for
>    compressed data.

Unfortunately this is not going to work with bs > ps enabled.

There are two problems:

- btrfs_csum_one_bio()
   It needs to iterate through each block.
   For uncompressed writes, it's pretty easy as each block is backed by
   large folios thus we only need to switch to multi-page bvec code then
   we can handle each block as usual.

   But if using the current method, the compressed data is always in page
   size, meaning a block can cross different pages (thus different bvec).

   I have a working prototype to handle it, but it kills all the
   simpleness using block by block iteration.

- btrfs_check_read_bio()
   Again it will work flawlessly for uncompressed read. But a completely
   different story for compressed read.

   It's the same problem, a compressed block can go across several
   different and physically discontiguous pages.
   Requiring quite some changes to the whole data checksum verification
   code.

So I'm afraid we have to apply the same minimal folio order for all 
folios, no matter if it's compressed or not.

Thanks,
Qu

> 
> Finally since we're here, update the stale comments about
> btrfs_compress_folios().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> RFC v2->RFC v3:
> - Fix a failure related to inline compressed data (btrfs/246 failure)
>    The check on whether the resulted compressed data should not happen
>    until we're sure no inlined extent is going to be created.
> 
> RFC v1->RFC v2:
> - Fix a check causes more strict condition for subpage cases
>    Instead comparing the resulted compressed folios number, compare the
>    resulted blocks number instead.
>    For 64K page sized system with 4K block size, it will result any
>    compressed data larger than 64K to be rejected.
>    Even if the compression caused a pretty good result, e.g. 128K ->68K.
> 
> - Remove an unused local variable
> 
> Reason for RFC:
> 
> Although this seems to be a preparation patch for bs > ps support, this
> one will determine the path we go for compressed folios.
> 
> There are 2 methods I can come up with:
> 
> - Allocate dedicated large folios following min_order for compressed
>    folios
>    This is the more common method, used by filemap and will be the method
>    for page cache.
> 
>    The problem is, we will no longer share the compr_pool across all
>    btrfs filesystems, and the dedicated per-fs pool will have a much
>    harder time to fill its pool when memory is fragmented or
>    under-pressure.
> 
>    The benefit is obvious, we will have the insurance that every folio
>    will contain at least one block for bs > ps cases.
> 
> - Allocate page sized folios but add extra padding folios for compressed
>    folios
>    The method I take in this patchset.
> 
>    The benefit is we can still use the shared compr folios pool, meaning
>    a better latency filling the pool.
> 
>    The problem is we must manually pad the compressed folios.
>    Thankfully the compressed folios are not filemap ones, we don't need
>    to bother about the folio flags at all.
> 
>    Another problem is, we will have different handling for filemap and
>    compressed folios.
>    Filemap folios will have the min_order insurance, but not for
>    compressed folios.
>    I believe the inconsistency is still manageable, at least for now.
> 
> Thus I leave this one as RFC, any feedback will be appreciated.
> ---
>   fs/btrfs/compression.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/inode.c       |  9 ---------
>   2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 3291d1ff2722..9cd9182684f3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1024,6 +1024,43 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>   	return 0;
>   }
>   
> +/*
> + * Fill the range between (total_out, round_up(total_out, blocksize)) with zero.
> + *
> + * If bs > ps, also allocate extra folios to ensure the compressed folios are aligned
> + * to block size.
> + */
> +static int pad_compressed_folios(struct btrfs_fs_info *fs_info, struct folio **folios,
> +				 unsigned long orig_len,  unsigned long *out_folios,
> +				 unsigned long *total_out)
> +{
> +	const unsigned long aligned_len = round_up(*total_out, fs_info->sectorsize);
> +	const unsigned long aligned_nr_folios = aligned_len >> PAGE_SHIFT;
> +
> +	ASSERT(aligned_nr_folios <= BTRFS_MAX_COMPRESSED_PAGES);
> +	ASSERT(*out_folios == DIV_ROUND_UP_POW2(*total_out, PAGE_SIZE),
> +	       "out_folios=%lu total_out=%lu", *out_folios, *total_out);
> +
> +	/* Zero the tailing part of the compressed folio. */
> +	if (!IS_ALIGNED(*total_out, PAGE_SIZE))
> +		folio_zero_range(folios[*total_out >> PAGE_SHIFT], offset_in_page(*total_out),
> +				PAGE_SIZE - offset_in_page(*total_out));
> +
> +	/* Padding the compressed folios to blocksize. */
> +	for (unsigned long cur = *out_folios; cur < aligned_nr_folios; cur++) {
> +		struct folio *folio;
> +
> +		ASSERT(folios[cur] == NULL);
> +		folio = btrfs_alloc_compr_folio();
> +		if (!folio)
> +			return -ENOMEM;
> +		folios[cur] = folio;
> +		folio_zero_range(folio, 0, PAGE_SIZE);
> +		(*out_folios)++;
> +	}
> +	return 0;
> +}
> +
>   /*
>    * Given an address space and start and length, compress the bytes into @pages
>    * that are allocated on demand.
> @@ -1033,7 +1070,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>    * - compression algo are 0-3
>    * - the level are bits 4-7
>    *
> - * @out_pages is an in/out parameter, holds maximum number of pages to allocate
> + * @out_folios is an in/out parameter, holds maximum number of pages to allocate
>    * and returns number of actually allocated pages
>    *
>    * @total_in is used to return the number of bytes actually read.  It
> @@ -1060,6 +1097,9 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
>   	/* The total read-in bytes should be no larger than the input. */
>   	ASSERT(*total_in <= orig_len);
>   	put_workspace(fs_info, type, workspace);
> +	if (ret < 0)
> +		return ret;
> +	ret = pad_compressed_folios(fs_info, folios, orig_len, out_folios, total_out);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0161e1aee96f..b04f48af721a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -864,7 +864,6 @@ static void compress_file_range(struct btrfs_work *work)
>   	unsigned long nr_folios;
>   	unsigned long total_compressed = 0;
>   	unsigned long total_in = 0;
> -	unsigned int poff;
>   	int i;
>   	int compress_type = fs_info->compress_type;
>   	int compress_level = fs_info->compress_level;
> @@ -964,14 +963,6 @@ static void compress_file_range(struct btrfs_work *work)
>   	if (ret)
>   		goto mark_incompressible;
>   
> -	/*
> -	 * Zero the tail end of the last page, as we might be sending it down
> -	 * to disk.
> -	 */
> -	poff = offset_in_page(total_compressed);
> -	if (poff)
> -		folio_zero_range(folios[nr_folios - 1], poff, PAGE_SIZE - poff);
> -
>   	/*
>   	 * Try to create an inline extent.
>   	 *


