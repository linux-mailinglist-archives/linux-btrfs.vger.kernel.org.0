Return-Path: <linux-btrfs+bounces-12081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF98A56135
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6473B4DFC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B411A01B9;
	Fri,  7 Mar 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V6sygi7u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C01632D9
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330341; cv=none; b=FEQmf/xsdcD4HBed9Kvq5L9q4852ZsDD9IvBbdZHYhRX+fL/7aQnAM7FRqoX/LkLXOpyfL7pUIoPrufCZLqLpDrWxt2eILyk/diwuYD0mi+4H1j/0IC+PdNQFCmuXtt8QMwdGgbWhFLrTzIp0bw/89ySz7wZnz+18N97A2VuwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330341; c=relaxed/simple;
	bh=4jTwg5Z27PGjlcYMen9tn+vq8aVccab9yWvgW1eGskU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GYmZ1LNZo6wWUK4EpQ66MN8FGXMnuXDZVdL/FtoIxeyKCj3KVnJ7ACzMFJJysQC0VYcN0hjwfTRU5Q70KBBSI6DtruhhHbWa9RVyUyB/VM6+VkVBOAs1JDAa+tZxBqTpQV9MJsPp5oK3sw/6Q8xM8TcF72RS3edUhlRFWp3ia+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V6sygi7u; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390f5f48eafso838592f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741330336; x=1741935136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UtFSCgGKEC63AKuUD9let/9mYR+SJnuPNeQI3crW9OA=;
        b=V6sygi7uFiZlbvJAzWQnsI1ar9gcU0mD2NjN8O8m9Sf0woOfSVuuc7bmhrDYo+X7VA
         UbW+DNsnEItHqFkRTiEjnIq128URji6w3LH4gqCLvS6bpaybxZOcOnFTgkncFGHvhTHg
         f3J2cTrSP6KqxoLtQjbq0PrChkj2vx2fB/PWtwE57OSOSDRXdv6zrQroI7E9hYVGmJsD
         tCzceM95A3nZnptQnoSuNGpuhiewWbymwWLLJETWf3LRJPFiNIu63SC6I+8ZyFk+cRhp
         4JpNgzSFMI3ci6tUX8tePyTFkP45VI6r0bbdg4k1y6y1Gv8WMqyP8W+u5eSQPtWM1pix
         IpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741330336; x=1741935136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtFSCgGKEC63AKuUD9let/9mYR+SJnuPNeQI3crW9OA=;
        b=MTZdzoZ4jfkP5crnm98W6ZgjdBG2uOo1LujBiOviPaiHaVLnI8r/qNR5cnH3F5++s7
         rseOmbDQv/XvJ168ELPP8a/Eu9AnvVK3fO2cEU+jyZqkof+tTsBUm4wDaPpMZwnwhetn
         34uV3tV6bgF5pAAnlXyM6oh58BP/8A+g3y+y9Wxvmzh5YWo09Uxkwd0pK0xEQNvu0mk4
         pdTF/NpSKVZT8jXMS488XKgURA2eHbmtUPznIDtYjAhVbbstspMaJqqzPKBCh9a/vjl8
         5juFStzIOJAd3aqjzioJIfMn7p+V5ShJATHgaCpxWnYsC5enB1MEoYtlWfGXsPIR5rGO
         0pSw==
X-Forwarded-Encrypted: i=1; AJvYcCWzo0q0m+adqY4dCUrYPH9hbn78ukmdLmGJ+csLZTREGJXNDirDOT1KDhwbt9Jb/x862xfTCqD+9AeyUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvkTgvBvLhypGlS5N46ZtMSf73i7O2fR6syE1Oiy279AXX51o
	ORVFB5P/I++sEmlRP66uInnfpYm6n8rjg54u37qBNhuFtB51JqWwGJqOHGxyJyA=
X-Gm-Gg: ASbGnctWblzGp1NHRIZRmkV6lxVuYGAshWA1F25ZaYzt0pgVtGGwp0ML4s3L1iilM4B
	YblgwzsmJfGKpWeBmRDWiMcqRSqKCvqNGwtb7IdjtGwOvFZeTHOWMO79lN3zMgj5P2MMRg3GAZS
	vU6BpAOKOJ8YUYbUpHojDgkprDn4BAaV7G8MnJzaJb2OuMDEkKKJfQb0B6KKsOkEhIoV4DMg+Ns
	w0qTokz/tDwjxl2CCn/G6gHlwtzrdxOWi2G+JcwzdzWH+JeErxCLiWbZLwtpmyRrJiE2dNKEJvf
	wmcK54TRubmj8+oVwjTMMFXhueoEE5oFRA4e0zHRY9CJ20LrIB3tKS2iUODmQnj4lrvDxjbD
X-Google-Smtp-Source: AGHT+IFfQ1fKLQb4WhvEQ7JBpu2B/wTYMgfQ5dBj4Rf+vRGZYOe1kHxExYWe8vYTuA70Sf0y3b1V9A==
X-Received: by 2002:a5d:6d8c:0:b0:391:ab2:9e71 with SMTP id ffacd0b85a97d-39132d8b608mr1012761f8f.20.1741330336255;
        Thu, 06 Mar 2025 22:52:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810930b3sm2304387a12.29.2025.03.06.22.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 22:52:15 -0800 (PST)
Message-ID: <255a304e-8ad9-4964-a627-1529abca0017@suse.com>
Date: Fri, 7 Mar 2025 17:22:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: fix bg->bg_list list_del refcount races
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1741306938.git.boris@bur.io>
 <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
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
In-Reply-To: <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/7 10:59, Boris Burkov 写道:
> If there is any chance at all of racing with mark_bg_unused, better safe
> than sorry.
> 
> Otherwise we risk the following interleaving (bg_list refcount in parens)
> 
> T1 (some random op)                         T2 (mark_bg_unused)
>                                          !list_empty(&bg->bg_list); (1)
> list_del_init(&bg->bg_list); (1)
>                                          list_move_tail (1)
> btrfs_put_block_group (0)
>                                          btrfs_delete_unused_bgs
>                                               bg = list_first_entry
>                                               list_del_init(&bg->bg_list);
>                                               btrfs_put_block_group(bg); (-1)
> 
> Ultimately, this results in a broken ref count that hits zero one deref
> early and the real final deref underflows the refcount, resulting in a WARNING.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-tree.c | 3 +++
>   fs/btrfs/transaction.c | 5 +++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5de1a1293c93..80560065cc1b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2868,7 +2868,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>   						   block_group->length,
>   						   &trimmed);
>   
> +		spin_lock(&fs_info->unused_bgs_lock);
>   		list_del_init(&block_group->bg_list);
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +
>   		btrfs_unfreeze_block_group(block_group);
>   		btrfs_put_block_group(block_group);
>   
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index db8fe291d010..c98a8efd1bea 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -160,7 +160,9 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
>   			cache = list_first_entry(&transaction->deleted_bgs,
>   						 struct btrfs_block_group,
>   						 bg_list);
> +			spin_lock(&transaction->fs_info->unused_bgs_lock);
>   			list_del_init(&cache->bg_list);
> +			spin_unlock(&transaction->fs_info->unused_bgs_lock);
>   			btrfs_unfreeze_block_group(cache);
>   			btrfs_put_block_group(cache);
>   		}
> @@ -2096,7 +2098,10 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
>   
>          list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
>                  btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> +	       spin_lock(&fs_info->unused_bgs_lock);
>                  list_del_init(&block_group->bg_list);
> +	       btrfs_put_block_group(block_group);
> +	       spin_unlock(&fs_info->unused_bgs_lock);
>          }
>   }
>   


