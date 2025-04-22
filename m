Return-Path: <linux-btrfs+bounces-13254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095BFA97AA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 00:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DD07A5E91
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5F922F752;
	Tue, 22 Apr 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BypCCTJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FB1EDA2A
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362077; cv=none; b=YR83M2oUKrry2avuEecdZ8O6iNVmyHrarlTZlI9vRmPcpVXLiJj02U+uFZV6sLliL/VC1LXE7Pcy1IPofVqGPUY5rKkXlSkJTdw04nRdRDybpf0Pwg7C3BQA55iUoiGUfLBuf3rZiQgOTF0rC555I6qkwrCmz+1SUqsp7DD7Z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362077; c=relaxed/simple;
	bh=oeNHeCg38qkVZO+yE/eNbvw2M2eZDblFsbU9tIxENF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JTiVcqw4dAYHO95fuwBlPfPQpt4SvvILzWs1oYx70L8GYbBQ5UZ1RW2/VaPUPMQrrMrGElykkl3ZI0wMjHXEEtFGewFMxfF4ovHq3GA6By+7vkFClbOZEQzw4nxnYGEIE9hFT0ATZQL6XCfWv+r6+ZzroOnCk7aHrF19ccxIdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BypCCTJS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso875925666b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745362073; x=1745966873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER/GHClW2J4ci2lAP8EFgMqdebY0g7Ijic+GGlfY97c=;
        b=BypCCTJSUAQftF+fAJPWkJVRZ27iUPaQtlil+Ec0NNajnUNpkmVt0L5Ax9B3DduF5u
         O71nx0sQah20/oqD8K/u/5Em2LQAFK9sVVUqbq1VwyK0E5QgE/Ip/h7nqfJ5+ScxgkNq
         wC7TJIMIlvs+QNYX5lt/iPBnNIygfPQrynqR4kknqTHkpgDNZtInZIMUdF76TtliR2lF
         dd+7nKgoYzSU6uEi60RtIAmFwmPEDYDmFRjTdpDguUz/inlf+fGHxPxfqUB010NhjSVa
         8hvcd35s+bxSIXlLTAqEu3ycQMFVobwemZKyeREXLfFMjSiABo9uzIpFroHoBg1F48WQ
         EWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362073; x=1745966873;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER/GHClW2J4ci2lAP8EFgMqdebY0g7Ijic+GGlfY97c=;
        b=pDx7wKA7p3gB1tqTHS0ahbNfuRfxJTcUz4lxl+vI4RarJZF88wPqs90H4CSXt6UTkW
         6aETb4ImdWXksx/2tFA6fjflwCBJsVu+p6l6F0oNW5JZogN0PSWiNQNKPZgSZetRiz6K
         806zL34+QSTFYTfi3DwW4Qh0pQvub8ZvsYnzlI87B2PTzsO/CixEtd7R1LduJ+fNw2F+
         p9C0J5N+oiJeJYOJKsOPD0K/LycM2gQmhOtU9xakOEazmIjXAHnRhUgPjeRKZON3yu/4
         qmndzptdzCEHueQGnhxZP1luAt7d22gf+4xny+VEt0hOrL5YchS07Kad8aPWZDnGASQR
         tYMA==
X-Gm-Message-State: AOJu0Yx4YLLzmYlO+cHADkgWv5o1TTdWS3YL6L5O/xIok9TOoOm87iQq
	0deX2D15vVpz53Rc8mkYi8tqrfVpkzBEXEHkfW8T+4jaXEZ4ca55gJTnFTdvLC5us/eMwv7ZgJl
	p
X-Gm-Gg: ASbGncs7WjRjVwxdB3uUiwVA4ZC8pkcgKRRyMZkbV1l1Isvr2xUpPEd7Ngpb5JRmFZO
	M3yHclP1RbRP6nWEUQEiXkpzERhF0Rpkupv2HOiBTCyLLmpo/IxSdI6lVluVewvBsqXrwkoCpzc
	nxb6bwKFgYRl9RGCvVVQpcKIAq+yV12UH1L64OzpPlJUC8cnMZr42gSeGRW0Wc3+jT3urjtBhyQ
	voTzRTpKalGEWfyQyzwdPcxfPDV89d4a9+NrXyyXfv9viwsTRi4RVLDpqdkICGEs+yGMUvKGzLE
	iG+RrwEYi/UvBmOeKhRRZUxNGApcatVsPqDY/abDaiOO8YFG5EyA9Rg1NoOMa+MqYAgS
X-Google-Smtp-Source: AGHT+IEXtROkcnY4vtCOHmaqin3wLeDplBDchRxLMqxPsfqlusd6RF4HGzMDxxrTIV2UAaGONUtvNg==
X-Received: by 2002:a17:907:6eaa:b0:acb:34b2:cb5b with SMTP id a640c23a62f3a-acb74e102c6mr1516758966b.58.1745362072499;
        Tue, 22 Apr 2025 15:47:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaeadd5sm9551955b3a.171.2025.04.22.15.47.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:47:52 -0700 (PDT)
Message-ID: <6a920a2d-1537-477e-b921-826a40d9627e@suse.com>
Date: Wed, 23 Apr 2025 08:17:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: get rid of filemap_get_folios_contig() calls
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
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
In-Reply-To: <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 12:17, Qu Wenruo 写道:
> With large folios, filemap_get_folios_contig() can return duplicated
> folios, for example:
> 
> 	704K                     768K	                          1M
>          |<-- 64K sized folio --->|<------- 256K sized folio ----->|
> 	                      |          |
> 			      764K       800K
> 
> If we call lock_delalloc_folios() with range [762K, 800K) on above
> layout with locked folio at 704K, we will hit the following sequence:
> 
> 1. filemap_get_folios_contig() returned 1 for range [764K, 768K)
>     As this is a folio boundary.
> 
>     The returned folio will be folio at 704K.
> 
>     Since the folio is already locked, we will not lock the folio.
> 
> 2. filemap_get_folios_contig() returned 8 for range [768K, 800K)
>     All the entries are the same folio at 768K.
> 
> 3. We lock folio 768K for the slot 0 of the fbatch
> 
> 4. We lock folio 768K for the slot 1 of the fbatch
>     We deadlock, as we have already locked the same folio at step 3.
> 
> The filemap_get_folios_contig() behavior is definitely not ideal, but on
> the other hand, we do not really need the filemap_get_folios_contig()
> call either.
> 
> The current filemap_get_folios() is already good enough, and we require
> no strong contiguous requirement either, we only need the returned folios
> contiguous at file map level (aka, their folio file offsets are contiguous).
> 
> So get rid of the cursed filemap_get_folios_contig() and use regular
> filemap_get_folios() instead, this will fix the above deadlock for large
> folios.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is causing ASSERT() triggered in generic/524.

And thankfully the fix in filemap_get_folios_contig() has already landed 
upstream, we can safely drop this one.

I'll remove it from the for-next branch.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c             | 6 ++----
>   fs/btrfs/tests/extent-io-tests.c | 3 +--
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f0d51f6ed951..986bda2eff1c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -207,8 +207,7 @@ static void __process_folios_contig(struct address_space *mapping,
>   	while (index <= end_index) {
>   		int found_folios;
>   
> -		found_folios = filemap_get_folios_contig(mapping, &index,
> -				end_index, &fbatch);
> +		found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
>   		for (i = 0; i < found_folios; i++) {
>   			struct folio *folio = fbatch.folios[i];
>   
> @@ -245,8 +244,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
>   	while (index <= end_index) {
>   		unsigned int found_folios, i;
>   
> -		found_folios = filemap_get_folios_contig(mapping, &index,
> -				end_index, &fbatch);
> +		found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
>   		if (found_folios == 0)
>   			goto out;
>   
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index 74aca7180a5a..e762eca8a99f 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -32,8 +32,7 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
>   	folio_batch_init(&fbatch);
>   
>   	while (index <= end_index) {
> -		ret = filemap_get_folios_contig(inode->i_mapping, &index,
> -				end_index, &fbatch);
> +		ret = filemap_get_folios(inode->i_mapping, &index, end_index, &fbatch);
>   		for (i = 0; i < ret; i++) {
>   			struct folio *folio = fbatch.folios[i];
>   


