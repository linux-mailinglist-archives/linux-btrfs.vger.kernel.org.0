Return-Path: <linux-btrfs+bounces-11023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF9A1786C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BAB3A982B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8301B2EFB;
	Tue, 21 Jan 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WwR4dX3L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838141A8F8E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443707; cv=none; b=FR6nnZvC9cAxPOmWqdTEMbTMIMWetJBifeXFtlnj4seQ0wSZqJ56q4X9+9Py/d0SN/Xwh1NMz4wiXafcAG+K8PJ3DDRYi8yLRKOEAlIgNczJU/S6f5hS7xWXKbTqCUvCRSsRJiBC2eTsIHZH9uXDOz6ZyWHqHgZ8416VqA9aiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443707; c=relaxed/simple;
	bh=6e0Nxi7TomUXwp7H6wrlN+dsBEoRDWM5Hfsq+VMjYoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cix/mM3fWkY2P0OXr/k1LzPYL+MtZtPQs/PfU4GPCDB1XUAUSpxmkCvs8tap08UfX7/t0xPYwp5nGiugmMpCGX7hsrMZHzdJoCBlxN4kxW/NcYSoEKlvwhbSMeycllHZKCGduK6mt/pnx4mP+PBSDQOhh7hHixFVXog2pGBdcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WwR4dX3L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso5791138f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737443703; x=1738048503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Wdj3zm8s778Vox7cHpJQv9NkmsmeVnIRuHqt9dv3k=;
        b=WwR4dX3L9aSCn19GXprgV1ISvPQKEQLcrrmmykwdkxDj3qMyPket6JaMyMqzQ2pkVo
         K1ScQq8E+1tqNCrUeXDspUs4/iWjf7s3L+5z1OqrOSneTPl2W8R+h33N8+G3uzDfZOdS
         ELU6WysSxdFrqYa1aMEdn4ssB5jOYNEp53Ap3Z2DszquYl5q+qGBijCo//cw6vjCiTdB
         ZCUFLh4IVJWY+Gi3rLAmH+1F2pbzha9v9KLDaju1qnmxqAx0prz1OrwFcXaXcJwu+pzJ
         7tYSedI/Z5f8xvLBsX9tgQvG3gH5FsqSHTgzuWojjSSnKZoHcpIYC1fQuBtSP2xTJXho
         hX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737443703; x=1738048503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5Wdj3zm8s778Vox7cHpJQv9NkmsmeVnIRuHqt9dv3k=;
        b=vYfbiUd6fRi6/PZC9s5BiZ5PBaGro1nZNLpHxCYuZTq2BxWuUJJv2VCWE5aHE++l7d
         rochBOUc5ygkr07EinhcQ+LcX3lI/Ypd2IRvSleJRCq8ojvoXIKKnFxw6wq7aumIYXzp
         lnO0kmADnutvfLehhgo75Y6U7rPfmAwkzyLehuwP63d2xUQxj1lWDAdR6KmrvZeT3Qd6
         mrvM+Hdl6iz/lV+bLRaXiqiXAU/0fTewqb4Wzu/TQX/nlTBaDcTxIwmEoGB5UstNXs/s
         6nqh2X/lPiBDjwDo4pXOo8Ej5Av9NdYxoT7O/FYo8h1GpJYEr+KH2QjOwdvhuXeWgYb7
         mvbQ==
X-Gm-Message-State: AOJu0YxMZf6ydQL+IxYTzX0nhxzC1KPg7LJBP2IgdQAvZzst2y1Sfsap
	YTfJ+NBT2uEq+cZym9azt8PZEJgHt+0up3BMgd4JvYepRUXPHT4e9arMMsS2ionn2u8Px/Q16ir
	Hp1E=
X-Gm-Gg: ASbGnctqRhFGUSEvaWbfI8EovaY38Lh9W705JwbAiBXi5FgvDnlWMKpUCZJPO/qfUbn
	qx95xEoQNVOM9smAp70XPGUg/B2xyuDBIuvDhwDR9U9EBF7yjWToFH5xcuKOhIFvGFxFK1jT0lF
	TOtglj+6HzGZhnHWBemmEtThMHKRSczVmFWspUQOAydzCkSyiP/GDfnxPFNHac+UuDiZu2zDX0w
	t85y91h9cIDkAnJGOJfUJQnvgcHCEVoOJm/3YQirxGyGOHzlMzmTIUd5DvL3MAZWIhlzU0aOtz2
	0SxQWHhEfeBWvNWD/eaBtw==
X-Google-Smtp-Source: AGHT+IE3ArSYr/zjOeMh+hmDJVEL4jkC4hjlRWhKiiPZ/ghMXViAqDgOmsGszNezMoyGpgCGzEmH8Q==
X-Received: by 2002:a05:6000:1acc:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38bf55bbddemr14472261f8f.0.1737443702306;
        Mon, 20 Jan 2025 23:15:02 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a162sm9055677a91.2.2025.01.20.23.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 23:15:01 -0800 (PST)
Message-ID: <8713e41e-7811-4e6f-900d-52f1ee7277f5@suse.com>
Date: Tue, 21 Jan 2025 17:44:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: Fix some folio-related comments
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250121054054.4008049-1-willy@infradead.org>
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
In-Reply-To: <20250121054054.4008049-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/21 16:10, Matthew Wilcox (Oracle) 写道:
> Remove references to the page lock and page->mapping.  Also
> btrfs folios can never be swizzled into swap.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 8 +++-----
>   fs/btrfs/inode.c     | 2 +-
>   fs/btrfs/subpage.c   | 2 +-
>   3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d9f856358704..289ecb8ce217 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2189,10 +2189,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
>   			done_index = folio_next_index(folio);
>   			/*
>   			 * At this point we hold neither the i_pages lock nor
> -			 * the page lock: the page may be truncated or
> -			 * invalidated (changing page->mapping to NULL),
> -			 * or even swizzled back from swapper_space to
> -			 * tmpfs file mapping
> +			 * the folio lock: the folio may be truncated or
> +			 * invalidated (changing folio->mapping to NULL)
>   			 */
>   			if (!folio_trylock(folio)) {
>   				submit_write_bio(bio_ctrl, 0);
> @@ -3222,7 +3220,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   	}
>   	/*
>   	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
> -	 * so it can be cleaned up without utilizing page->mapping.
> +	 * so it can be cleaned up without utilizing folio->mapping.
>   	 */
>   	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fe2c810335ff..e6ea4f172b50 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2891,7 +2891,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
>   	 * We are already holding a reference to this inode from
>   	 * write_cache_pages.  We need to hold it because the space reservation
>   	 * takes place outside of the folio lock, and we can't trust
> -	 * page->mapping outside of the folio lock.
> +	 * folio->mapping outside of the folio lock.
>   	 */
>   	ihold(inode);
>   	btrfs_folio_set_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 722acf768396..6a8636c0ffed 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -72,7 +72,7 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space
>   
>   	/*
>   	 * Only data pages (either through DIO or compression) can have no
> -	 * mapping. And if page->mapping->host is data inode, it's subpage.
> +	 * mapping. And if mapping->host is data inode, it's subpage.
>   	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
>   	 */
>   	if (!mapping || !mapping->host || is_data_inode(BTRFS_I(mapping->host)))


