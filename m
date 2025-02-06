Return-Path: <linux-btrfs+bounces-11314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD8A29F55
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 04:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50FB166B38
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3F14D6F9;
	Thu,  6 Feb 2025 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fuy3EhSw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FA70838
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812096; cv=none; b=pW3K+ovgeiFI4m0/lEC7Oyc8TDUbjTJj0Be+b3GizCoCot0+wWOp1oLS9rH0EM/5yF5zSs8XJe0K77hVMaMEK45mkotsPMwJqyAGJ2uVtiMMP9j1GHZ77OL6QSR5otzcjStGBHXH4qQ8ar6b/HXWDbwBhECm+A/cSc6/ao/EyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812096; c=relaxed/simple;
	bh=Ctzjv2+n08Gx3O+EJLX08yfStkzb2gOd9KrMasTBD44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fkpXpOCLVavXQi3o0x/ICO8aXfq2sgaVtMDAyxSx1X/8n92dS40ecimXvcLX7/0em7OhvbIUOQ+OtyVZ9gAKvOA0SuMRcQqHfRRcWpmZ+MsTGK4+5kU+a3ql1DFRojjFRrD4H7D3blat/G0UsQUPx9linO3dNX2H3rLgZgKuDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fuy3EhSw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38db570a639so197264f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 19:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738812092; x=1739416892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otQ7YcFBMLyn4YSaWodVGzQJ5Knc/pilECDT36mqiyQ=;
        b=Fuy3EhSwS93OTpnD34+BWzRtRL8cFOaVcMg80+xyKB+MEC/kBjKGop4h7LpfXq7DvC
         X3K5GkjGQifpZVqJikKD/9syk+kmeA6F9jdDgwlT2oeZNauPlg/gXH7WWZWUVKh6IFim
         IP6v/hbyYYhJ8kJIaDZAJRNnrg3+pg7YrQVMBtYCjd3fWZqUCjuhJ0HvPK1Z8RJduttF
         ItBymO5UGCWPOKa9VnMNBx0Kf/o7L1IOwKt3fqAiLXPwaInnh+afXp5tLAda/JsIChq9
         WtgwefgtjumfTeOPmIABd9KY55H31Tfet2dayEEbxebLNVVROTlf3oV+dRNzkwWwLRMm
         rbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738812092; x=1739416892;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otQ7YcFBMLyn4YSaWodVGzQJ5Knc/pilECDT36mqiyQ=;
        b=eG+WUCld/u0fU2elzHY2RM2AMiCwKrnLpon5mjMVYrK0HOUDD5+90KmwQ/g/ifMkl5
         aaN0dnVwDNg2Kl22qyI6hX3ISS1LLpFQ+fEsKOCqM8UcfhZHmwFwyjDNY7vRIeJRTV99
         LeVUr/D5QkV0tQl7nqGVhRi+T1GNlFe8cdsFx/s+dhD5zJZgCK3egrOoswQrY83YEvOS
         xKz+QLWpGEGJ+WMt9a7p4wHG2vMkGLhbLHjXYxGWFH3Y1qb6C76c9iLNf4ZPZuCUD3ik
         5gI9epj2QvyZfRZs5vfktdMzPKboj09iSsP5+iybiMjNb658DMkger5UjsOC2/QvdQft
         VZdQ==
X-Gm-Message-State: AOJu0Yws4x0eTab1sBxOpunXpOS6whahTRkkrm2yfkp1NRxdMiGT5mMA
	wrY85bMWj/gPdCP+AhoOdXv0y6fO65aZ6Kkoi4rhsX0zTKrQkH5RZ6YuLXd/BP6+buPpyw9IAKv
	CJck=
X-Gm-Gg: ASbGncvxjIEuu0379hOrjszIJGDLgzljOC5GKMwZNSB8jXO3eT5jiJsgaSJrqUENKNz
	OVaVWmx6FKrPlrxlbwYsyZY7LKgDOxB9wSlu4eIgfkCCk2/uDjQXGkThKEmaiXXhoBkxCZZY5TG
	xPrWiLUHQSTlQ1OEFQH5MTpd/ey9YTNwPytn3GPEoFMe4lXvjX+HPk0/sZexmS2CR72301yLUW5
	i0jy9lJCFRO2npxH2Ah5TtE3wDji8IM1QgiwBBAvb/jWpsSpwDEgw7uBBHld1sd5btAZhynYg88
	Ge8YKInj0Y/+YM1HbM8FZTGBqULJMGmf4qkKcrUKZsc=
X-Google-Smtp-Source: AGHT+IHFlXtvtAQ0avAA4ck4io6sdRkeLTWn1iaa2J2tqzChIU6x1T74n7KYGnTJbNVlXl6JzCagIg==
X-Received: by 2002:a05:6000:4009:b0:38c:24f0:fc28 with SMTP id ffacd0b85a97d-38dbb20b3d7mr788230f8f.3.1738812092114;
        Wed, 05 Feb 2025 19:21:32 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad5eebsm229163b3a.64.2025.02.05.19.21.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 19:21:31 -0800 (PST)
Message-ID: <d88af6af-725e-4409-811b-1a26f2f54099@suse.com>
Date: Thu, 6 Feb 2025 13:51:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs: simplify btrfs_clear_buffer_dirty()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1738127135.git.wqu@suse.com>
 <9d46f48d978dd85977e3e67bcfc74574ac448333.1738127135.git.wqu@suse.com>
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
In-Reply-To: <9d46f48d978dd85977e3e67bcfc74574ac448333.1738127135.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/29 18:07, Qu Wenruo 写道:
> The function btrfs_clear_buffer_dirty() is called on dirty extent buffer
> that will not be written back.
> 
> In that case, we call btrfs_clear_buffer_dirty() to manually clear the
> PAGECACHE_TAG_DIRTY flag.
> 
> But PAGECACHE_TAG_DIRTY is normally cleared by folio_start_writeback()
> if the page is no longer dirty.
> And for data folios if we need to clear dirty flag for similar folios,
> we just call folio_start_writeback() then followed by
> folio_end_writeback() immediately.
> 
> So here we can simplify the function by:
> 
> - Use the newly introduced btrfs_meta_folio_clear_dirty() helper
>    So we do not need to handle subpage metadata separately.
> 
> - Call btrfs_meta_folio_set/clear_writeback() to clear PAGECACHE_TAG_DIRTY
>    Instead of manually clear the tag for the folio.
> 
> - Update the comment inside set_extent_buffer_dirty()
>    As there is no separate clear_subpage_extent_buffer_dirty() anymore.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 45 ++++++++++----------------------------------
>   1 file changed, 10 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8da1da43aa74..e4261dce2e31 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3319,38 +3319,11 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
>   	release_extent_buffer(eb);
>   }
>   
> -static void btree_clear_folio_dirty(struct folio *folio)
> -{
> -	ASSERT(folio_test_dirty(folio));
> -	ASSERT(folio_test_locked(folio));
> -	folio_clear_dirty_for_io(folio);
> -	xa_lock_irq(&folio->mapping->i_pages);
> -	if (!folio_test_dirty(folio))
> -		__xa_clear_mark(&folio->mapping->i_pages,
> -				folio_index(folio), PAGECACHE_TAG_DIRTY);
> -	xa_unlock_irq(&folio->mapping->i_pages);
> -}
> -
> -static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct folio *folio = eb->folios[0];
> -	bool last;
> -
> -	/* btree_clear_folio_dirty() needs page locked. */
> -	folio_lock(folio);
> -	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, eb->start, eb->len);
> -	if (last)
> -		btree_clear_folio_dirty(folio);
> -	folio_unlock(folio);
> -	WARN_ON(atomic_read(&eb->refs) == 0);
> -}
> -
>   void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>   			      struct extent_buffer *eb)
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	int num_folios;
> +	const int num_folios = num_extent_folios(eb);
>   
>   	btrfs_assert_tree_write_locked(eb);
>   
> @@ -3377,17 +3350,19 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>   	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
>   				 fs_info->dirty_metadata_batch);
>   
> -	if (btrfs_meta_is_subpage(fs_info))
> -		return clear_subpage_extent_buffer_dirty(eb);
> -
> -	num_folios = num_extent_folios(eb);
>   	for (int i = 0; i < num_folios; i++) {
>   		struct folio *folio = eb->folios[i];
>   
>   		if (!folio_test_dirty(folio))
>   			continue;
>   		folio_lock(folio);
> -		btree_clear_folio_dirty(folio);
> +		btrfs_meta_folio_clear_dirty(fs_info, folio, eb->start, eb->len);
> +		/*
> +		 * The set and clear writeback is to properly clear
> +		 * PAGECACHE_TAG_DIRTY.
> +		 */
> +		btrfs_meta_folio_set_writeback(fs_info, folio, eb->start, eb->len);
> +		btrfs_meta_folio_clear_writeback(fs_info, folio, eb->start, eb->len);

This is causing weird problem at generic/437 for x86_64, that some folio 
in the metadata inode is completely wrong.

Will fix it by still doing the open-coded PAGECACHE_TAG_DIRTY clear, 
which proves to be fine in my test environment.

Thanks,
Qu

>   		folio_unlock(folio);
>   	}
>   	WARN_ON(atomic_read(&eb->refs) == 0);
> @@ -3412,12 +3387,12 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
>   
>   		/*
>   		 * For subpage case, we can have other extent buffers in the
> -		 * same page, and in clear_subpage_extent_buffer_dirty() we
> +		 * same page, and in clear_extent_buffer_dirty() we
>   		 * have to clear page dirty without subpage lock held.
>   		 * This can cause race where our page gets dirty cleared after
>   		 * we just set it.
>   		 *
> -		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
> +		 * Thankfully, clear_extent_buffer_dirty() has locked
>   		 * its page for other reasons, we can use page lock to prevent
>   		 * the above race.
>   		 */


