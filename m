Return-Path: <linux-btrfs+bounces-19421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1EC93371
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 351944E2C25
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C42E091E;
	Fri, 28 Nov 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N5b9+jdl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FB2DEA7B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366944; cv=none; b=rjfzu1U+l7z2Zio70usRbs7WXFfSMBkL/TPFzLOnvAuRffzOoCZIdWMSKf9GWj5tCzwZm8OTZVwJqHIn8x4TEyTtirSG0ZUEWLY/dzAWF7IKpQ4C1iFhtZUjib0hyn8k763PuKEKAlz8S8dVUHGlScgdiCWeIM7WTqcHCtt4o/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366944; c=relaxed/simple;
	bh=07oqf1+vrnAErt2NcfoFvvOI8Be1yaEhBJbC2rc5L/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4ZKu7VzLqiY3DoDpY6hbwQJQ7KIGEPKmoP15dS4eIX0JQ1WvHyUgzA1ZsjXpNTc2O7gzYGVlr0KGkA7+LhwejuZ1MY9B5iBjWmKI/PM2Kag6kBWosA7+Q4vHUdSzw7pDEWhmguQjPt35iXOtqFdSpjRy9Wl2RglTrPsAqm9mF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N5b9+jdl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so15040585e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764366940; x=1764971740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCigtqZnnJpWOTp7QgeRKFs1cLfFqjGFHOTE3J2Whf0=;
        b=N5b9+jdlQUjdJIiT8+raVInjz93YZ4PJQABGZKuwPlaTHq9es7R0ohy+k65fjykSSE
         P68dL0PBdrLn2ELG7PJ5JPDllCfKyLr3OCOgrXcc8vKLA2tfgzt9fsNqnynXfeK2xwOw
         rbqfJ3PD4/8pRBlsdN5StXO9oPz/G6zRfGASkS6FSfSCsgqFh3AfYbWOnmEOC+1KJPoB
         AWyMp8g5xLXiK9FkKvZA0+x0PuDrMie4D9+afa/Nn5LQklRo1mrdRq5PGR8Q3CqEb9YC
         SYLF3f7FUbBRGpOJEle0bN3B3WawfZ/okMEevkzbHWeBIXASrAoIRvAuFzmXqAkib2B8
         51Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764366940; x=1764971740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCigtqZnnJpWOTp7QgeRKFs1cLfFqjGFHOTE3J2Whf0=;
        b=r7NQBwHKLE/v3hloqet/zd2ut39HgW6fPKPfUz6MNucRVRPGy+i56Caa4PdcWeFS4x
         WVBKaW797OHaXmp6Ty3JfkwsZU2Px4/crSCllvMK64xz8O3DaQaLBjtWoMYIXQPGAmg1
         vj2xZHjWBLeclo04alzf+LWZugu4fG6TKblXaIv/kN3BALFWDIB9hLlxBCvDvP6RJ2OE
         dxRRODwCS/jgRYvR5d8MQcVcdeJrs4NBy5Np58G7ofFTRUGjecrPQUB2aQB+DUK7G2dW
         kJweLf27NV/z+HLABDekQpWovRA1EdJuXb7cKUgUBdycF4I66DoGA3Nj99kuy+NuNdJv
         6c9Q==
X-Gm-Message-State: AOJu0YxXILyn9YNTnWCnWxnLs5lD9C0IR2nWHoV9yyd+Squ6BH09DVs7
	NZladbiZ97EmbC3wGi/DMaBFOrlUE8uRuax75buGVXzvhK4YFro0hzrtdJKdKUDrFsI=
X-Gm-Gg: ASbGncsIVWS6SefJMlZaQ5x7887qTW6rXuEWTwcwrvuOq72FwySXg7wR7rM5PQGF3UZ
	bAurMn3PJrqujA5WF+OHdP6DPCbA0tUn0avdvsg/tkPHZ1ixrEmVV0dMHkqhXxlBnZXYFYt2Taa
	yF2Sao0Soc+6VFldwdsz3BWdeC/lnz70Ii5kX+KoDxminlqlO4Vf79QlezhXNDgYtUyllcCfsxC
	x4L6sn+TGJTaUc/2JqS0YcBgbsuwfOlLpy3n01u1U2PJkoY/ZCJRhRMF8puS6JlPbVjjq+BQIuw
	DB2OhmgXw6wQi/RoyyNdXosbi5eYXwC+NnZZTpVixvd7tzH6NgSHDMfBqIFfIK5N1fQv7yrQ32L
	P9F5OAGT/BdGHp3eLh0N07/owwRLFeukZZXKHija/kSeHX2Va0PEPrxJcZ4JICQjuRI7cyF6I27
	j5gCSfDV22fLyjaSEvB0IHXcrHBmKpiNYrogx+mp0=
X-Google-Smtp-Source: AGHT+IFJbOyiKt1fqbYdlETYQ9AMIzve+75diLMia5yqlMlk1UT+uX/RZAX/7+SWbh2RBITraCKS5Q==
X-Received: by 2002:a05:600c:1f0f:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-477c017ba5amr297951885e9.13.1764366940128;
        Fri, 28 Nov 2025 13:55:40 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm55326765ad.97.2025.11.28.13.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 13:55:39 -0800 (PST)
Message-ID: <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
Date: Sat, 29 Nov 2025 08:25:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.comi,
 dsterba@suse.com, terrelln@fb.com, herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
 qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
 weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
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
In-Reply-To: <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/29 05:35, Giovanni Cabiddu 写道:
> Add support for hardware-accelerated compression using the acomp API in
> the crypto framework, enabling offload of zlib and zstd compression to
> hardware accelerators. Hardware offload reduces CPU load during
> compression, improving performance.
> 
> The implementation follows a generic design that works with any acomp
> implementation, though this enablement targets Intel QAT devices
> (similarly to what done in EROFS).
> 
> Input folios are organized into a scatter-gather list and submitted to
> the accelerator in a single asynchronous request. The calling thread
> sleeps while the hardware performs compression, freeing the CPU for
> other tasks.  Upon completion, the acomp callback wakes the thread to
> continue processing.
> 
> Offload is supported for:
>    - zlib: compression and decompression
>    - zstd: compression only
> 
> Offload is only attempted when the data size exceeds a minimum threshold,
> ensuring that small operations remain efficient by avoiding hardware setup
> overhead. All required buffers are pre-allocated in the workspace to
> eliminate allocations in the data path.
> 
> This feature maintains full compatibility with the existing BTRFS disk
> format. Files compressed by hardware can be decompressed by software
> implementations and vice versa.
> 
> The feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL and can be enabled
> at runtime via the sysfs parameter /sys/fs/btrfs/<UUID>/offload_compress.

Not an compression/crypto expert, thus just comment on the btrfs part.

sysfs is not a good long-term solution. Since it's already behind 
experiemental flags, you can just enable it unconditionally (with proper 
checks of-course).

[...]
> +int acomp_comp_folios(struct btrfs_acomp_workspace *acomp_ws,
> +		      struct btrfs_fs_info *fs_info,
> +		      struct address_space *mapping, u64 start, unsigned long len,
> +		      struct folio **folios, unsigned long *out_folios,
> +		      unsigned long *total_in, unsigned long *total_out, int level)
> +{
> +	struct scatterlist *out_sgl = NULL;
> +	struct scatterlist *in_sgl = NULL;
> +	const u64 orig_end = start + len;
> +	struct crypto_acomp *tfm = NULL;
> +	struct folio **in_folios = NULL;
> +	unsigned int first_folio_offset;
> +	unsigned int nr_dst_folios = 0;
> +	struct folio *out_folio = NULL;
> +	unsigned int nr_src_folios = 0;
> +	struct acomp_req *req = NULL;
> +	unsigned int nr_folios = 0;
> +	unsigned int dst_size = 0;
> +	unsigned int raw_attr_len;
> +	unsigned int bytes_left;
> +	unsigned int nofs_flags;
> +	struct crypto_wait wait;
> +	struct folio *in_folio;
> +	unsigned int cur_len;
> +	unsigned int i;
> +	u64 cur_start;
> +	u8 *raw_attr;
> +	int ret;
> +
> +	if (!acomp_ws)
> +		return -EOPNOTSUPP;
> +
> +	/* Check if offload is enabled and acquire reference */
> +	if (!atomic_read(&fs_info->compress_offload_enabled))
> +		return -EOPNOTSUPP;
> +
> +	if (!atomic_inc_not_zero(&fs_info->compr_resource_refcnt))
> +		return -EOPNOTSUPP;
> +
> +	/* Protect against GFP_KERNEL allocations in crypto subsystem */
> +	nofs_flags = memalloc_nofs_save();
> +
> +	in_folios = btrfs_acomp_get_folios(acomp_ws);
> +	if (!in_folios) {
> +		btrfs_err(fs_info, "No input folios in workspace\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	cur_start = start;
> +	while (cur_start < orig_end && nr_src_folios < BTRFS_ACOMP_MAX_SGL_ENTRIES) {

This function get all input/output folios in a batch, but ubifs, which 
also uses acomp for compression, seems to only compress one page one 
time (ubifs_compress_folio()).

I'm wondering what's preventing us from doing the existing 
folio-by-folio compression.
Is the batch folio acquiring just for performance or something else?

The folio-by-folio compression gives us more control on detecting 
incompressible data, which is now gone.
We will only know if the data is incompressible after all dst folios are 
allocated and tried compression.

[...]
> @@ -165,6 +216,20 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>   	const u32 blocksize = fs_info->sectorsize;
>   	const u64 orig_end = start + len;
>   
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	if (workspace->acomp_ws && len >= 1024) {

The length threshold looks way smaller than I expected. I was expecting 
multi-page lengths like S390, considering all the batch folio preparations.

If the threshold is really this low, what's preventing an acomp 
interface to provide the same multi-shot compression/decompression?


And please do not use an immediate number, use a macro instead.

[...]
>   
> @@ -418,6 +468,20 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>   	unsigned long max_out = nr_dest_folios * min_folio_size;
>   	unsigned int cur_len;
>   
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	if (workspace->acomp_ws && len >= 2048) {

And why zstd has a different threshold compared to zlib?

Thanks,
Qu

> +		ret = acomp_comp_folios(workspace->acomp_ws, fs_info, mapping, start,
> +					len, folios, out_folios, total_in,
> +					total_out, workspace->req_level);
> +		/*
> +		 * If hardware offload succeeded, or if there is an expansion,
> +		 * return. Otherwise, compress in software.
> +		 */
> +		if (ret == 0 || ret == -E2BIG)
> +			return ret;
> +	}
> +#endif
> +
>   	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
>   	*out_folios = 0;
>   	*total_out = 0;


