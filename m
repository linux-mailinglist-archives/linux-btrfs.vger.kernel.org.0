Return-Path: <linux-btrfs+bounces-14022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1AAB7780
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 23:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2419E2846
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21C221F31;
	Wed, 14 May 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aN4I3ymF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F021D3F8
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256547; cv=none; b=KudMjo9FwMyo59CAkWBtRltzZquHx9zKsrOMmvP/9jlFzYduv/p6xkFnWzYkvbTmjb6VCKzJoAhYe3kiFH6Zzzyq/lwKyxUbQibqfXmx7EQewwp/w2HixHdRQsYev1ypHq+77RTYbgxdhvnIN481CPri7wPE7HSaNUP0NW8leOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256547; c=relaxed/simple;
	bh=rnhwmfn4rlTQ6DtkyNYg10AwrDGQxuTkJUArjH1nouM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XpuiaPLZSw/x41pg74Re1xvN1JjClsoW/i+OiPJO7qlapFYbjCDgVctYKEXsQFyVI09pxQsIPqEb0YPHzB40HhBEXhYa9CwTYWC4YygIisvehBpdHjmJ3FasdgL8NXacRp3w5xTM8rytQkPgnYViSRy5K48l5rmj4kAJsJs/StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aN4I3ymF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441c99459e9so1638975e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747256544; x=1747861344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mb4UlklDLlrY3NL0nEaPcyxQyg6atcDO3rAHLPopKg=;
        b=aN4I3ymFYK3eyJ5jgYk6IqpmZsKsc6peLE1ZKjrv/OUoUvRh5QIamcg9AuHl0lg+kY
         vpyAVQcBADuCpmWt76+lkdIgLV24kIhg2WxbT1yrZZA/LZf/1crAxPZzIUWlDYTNG3sF
         LMHlx2Mhliv5SsTsRE8IR0fEZaJJ+oxrbHZWlmlejJfErwS4aQ9Cq6KQukP7qKBqvq5u
         PLu5q00gkzgrAu2k6fDQH1eTegel8600srZyu9HbYD7QMxvFnJ1YNsrXWZ8u3DDMZhM2
         e6ojlTUAf3MdTIKzyPOZyuLOQ+XRj6t4jiVmufVFq8D/pdtDSO85eXpeWu1e/DFVMokm
         S50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747256544; x=1747861344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Mb4UlklDLlrY3NL0nEaPcyxQyg6atcDO3rAHLPopKg=;
        b=OcZi8f4JtKa7w/cX2YJZdso2Vj8SMF3I9lnJoYvr1YxANdtgj/ybmj7EMhjtZw7H7l
         tlc+r43BGvyhjRg9S+RoxF1YtMTMb/xJvn6ExDNJcusAVCaUrd/AD3JSGsmHhEkW9tpq
         qZ3mxRS0Z8+UOfE8bDWFr5w6JtzvmBgUlcPuaTQCss8HUkzjEwghJ19haOEhwe0OCCY6
         AXQHjycns6IL0BfPoimJaSSblLyX4QRqxSridJNqWoZHUuu0HRco/dBITyRWV+v/N5zI
         2aQ8UfdI4aQ0vwLR5Ba1IloDP8uvX9uyLZMbHYF87XkHz8kjcIxpaeCxcpzcf2//ZzFz
         cCNw==
X-Forwarded-Encrypted: i=1; AJvYcCWLsPEgzEFkSFr67/ovDTD4vj9Ll4GePAFb1N5oqOB8Gm7FXOmPVqt1yznfb0hJtCFcY73A1e15UijKfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGg0OZ/7F+iEczHJ1qQvCzrC9XYmXpOQQaWRGoihN8Vhejd5v
	wnY1nrjQyfvrmabbz0FjlGXG72p8fyrioyo1xamFmHYzIDD8ctYtNlNw5iedSoNad3deizXgREI
	S
X-Gm-Gg: ASbGncsoYRCAR5JZmhbV3w2jvkDPqcGZRM2O/eH4s4wgRwgeGSWk7CKxjv61L1T0VbY
	+OeIw1CKn22XPKaccY9ibAaf9E1NtIGwhhxLo+J1M5dveFsd/MCNxjlNrolWy4imp1Lath+OIzc
	5Zctj/zOo6II7hdAn3asuoSC7uIx/MbhVznptQgDWx6+HAnPDhnTAeFfg8v7AiN1zvbqLzh6IN/
	c8sqUXjubE0Vjbe2/5xX/mV6au8bmL02bblE2O79AoB2HOV6X3Pj7pjTDiLS4Vv4IeAo/pMxqN1
	jctkDk7/x9LBvAitBE6wQLK29imAZeqgTuSGEgVZj0kjkkNIU1Ds7+5mcVuHLzpJ2K93oA630oM
	/A70=
X-Google-Smtp-Source: AGHT+IHKrt04ich4ornipGi8F1JtmxSfIDE7Z3OlpYTxAARUfgur4eoeFMSwbwHdZtCTsx7S2w7RGw==
X-Received: by 2002:a5d:5f4f:0:b0:3a3:52a2:6669 with SMTP id ffacd0b85a97d-3a352a26906mr182873f8f.53.1747256543564;
        Wed, 14 May 2025 14:02:23 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828939asm103122535ad.164.2025.05.14.14.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 14:02:22 -0700 (PDT)
Message-ID: <2d54e2cc-b874-4aea-b848-be92ed5a968d@suse.com>
Date: Thu, 15 May 2025 06:32:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: use a single variable to track return value
 at btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747222631.git.fdmanana@suse.com>
 <b3a84d4894aebd5d3e7097fb7f07892fcf1b2316.1747222631.git.fdmanana@suse.com>
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
In-Reply-To: <b3a84d4894aebd5d3e7097fb7f07892fcf1b2316.1747222631.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 21:08, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have two variables to track return values, ret and ret2, with types
> vm_fault_t (an unsigned int type) and int, which makes it a bit confusing
> and harder to keep track. So use a single variable, of type int, and under
> the 'out' label return vmf_error(ret) in case ret contains an error,
> otherwise return VM_FAULT_NOPAGE. This is equivalent to what we had before
> and it's simpler.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/file.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f6b32f24185c..8ce6f45f45e0 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1841,8 +1841,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	unsigned long zero_start;
>   	loff_t size;
>   	size_t fsize = folio_size(folio);
> -	vm_fault_t ret;
> -	int ret2;
> +	int ret;
>   	u64 reserved_space;
>   	u64 page_start;
>   	u64 page_end;
> @@ -1863,21 +1862,14 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	 * end up waiting indefinitely to get a lock on the page currently
>   	 * being processed by btrfs_page_mkwrite() function.
>   	 */
> -	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
> -					    page_start, reserved_space);
> -	if (ret2) {
> -		ret = vmf_error(ret2);
> +	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
> +					   page_start, reserved_space);
> +	if (ret < 0)
>   		goto out_noreserve;
> -	}
>   
> -	ret2 = file_update_time(vmf->vma->vm_file);
> -	if (ret2) {
> -		ret = vmf_error(ret2);
> +	ret = file_update_time(vmf->vma->vm_file);
> +	if (ret < 0)
>   		goto out;
> -	}
> -
> -	/* Make the VM retry the fault. */
> -	ret = VM_FAULT_NOPAGE;
>   again:
>   	down_read(&BTRFS_I(inode)->i_mmap_lock);
>   	folio_lock(folio);
> @@ -1891,9 +1883,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	folio_wait_writeback(folio);
>   
>   	btrfs_lock_extent(io_tree, page_start, page_end, &cached_state);
> -	ret2 = set_folio_extent_mapped(folio);
> -	if (ret2 < 0) {
> -		ret = vmf_error(ret2);
> +	ret = set_folio_extent_mapped(folio);
> +	if (ret < 0) {
>   		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
>   		goto out_unlock;
>   	}
> @@ -1933,11 +1924,10 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>   			       EXTENT_DEFRAG, &cached_state);
>   
> -	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
> +	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
>   					&cached_state);
> -	if (ret2) {
> +	if (ret < 0) {
>   		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
> -		ret = vmf_error(ret2);
>   		goto out_unlock;
>   	}
>   
> @@ -1974,7 +1964,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	extent_changeset_free(data_reserved);
>   out_noreserve:
>   	sb_end_pagefault(inode->i_sb);
> -	return ret;
> +
> +	if (ret < 0)
> +		return vmf_error(ret);
> +
> +	/* Make the VM retry the fault. */
> +	return VM_FAULT_NOPAGE;
>   }
>   
>   static const struct vm_operations_struct btrfs_file_vm_ops = {


