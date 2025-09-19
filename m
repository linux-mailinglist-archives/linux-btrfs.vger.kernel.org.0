Return-Path: <linux-btrfs+bounces-17003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5DB8B703
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Sep 2025 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FECC7AE451
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 22:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01228467B;
	Fri, 19 Sep 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzMbs32R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3436B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319473; cv=none; b=dQSFvFCI1+W8RpXhq/4r57rWUcJzFsFCsW8vVcxxpi0ZPzHK+rVqz3sgnxPcNqkcZeDVZzNzUwVSYuTxL6e/wgGIUCZRBRhABFq55H+QyamGdSwbSRitEHBYl6FYp9ybBs9FkCrLY1b97vS0Q55INGOo9na67R9lxxQmDDdSIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319473; c=relaxed/simple;
	bh=6w1GKyUNWK4wmF6sM7eSJor9ljreSMzg0nwT/fFL1y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hXXNlyjjbB73cGsIGDeXoFYIK56CH9ZPeVGk2lk9e7Vt8L+ejNPUqw4rVfxPWdaPmwuPhoDN1/JIlLgGSnVV2xaRcXaCWxY55R63uaKCfmkoZuXU24WEZcLlpifuGCeibyaxG/8GnEd2d/XyF7BTb8DYVFrl1gskxT7hKTE5pAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzMbs32R; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f3a47b639aso98600f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758319470; x=1758924270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0m+fotKr9YVVy699B5LNZUJUxWWbnBBlVk7g5f5PNHY=;
        b=bzMbs32RzAJe4VXi94O/6VQ8b4RrvRGXA94pbDGd/TzIKPFWSZ+SY/ZPNKZhY3d5QQ
         jlUeE2Ru1f3QXkIOfgFk1C9kUfbcBwpDoJdlKdudLf/uQX/ZF55rAdgI5mtdc5hgJkxH
         +l63FjHbSsQr4Yhh9RN9smT5pHSkWa09A06bUoyypAFDfkUVFQxx3FIM+poK6dnwIM6V
         uwphYXisJ5dQtDRPpDs00BCWKuEPWlrw+I8rsEGA/2vxc6t22lGAY5AMHhj57Fkz8FkW
         joOx2+vonBjx303ogGetgOOXOyd8u0yWclNMJP+vdV1dAMK/JwVJe2oYHQs2EAzh0HpF
         A12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319470; x=1758924270;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0m+fotKr9YVVy699B5LNZUJUxWWbnBBlVk7g5f5PNHY=;
        b=HoU1n0Vc3PD/vEkBwDdhc8qMKroeVgBXLatHgdPOMgTccJq8w6IbJWca8E2cFG0JpG
         s/FLrV6MXle2LhZ0LpcoIyd8dln0E5aUe6eUNILJMnKe8KWQY54IpSLfUZkLWs2nwTbR
         cGnqbvPbYI84w3ptC+hBdpsDdodm50oUs47UaeSIfQSb0V54uIgPqtCRv61R5bFzydxv
         gJUAZjiPgypCdssbAJOilahZaWX1WWrkA7lHmbWnLrAOyoKuaz9KkalQB1QQGTUxj5HA
         sRVyQM6KaNt5F9MI9Pc6PS2I9oohw/Bq1PdmC3AJ59EkikJ91rmPL9L0t2VOBj2OUgeX
         5OZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnf+KrQk8WThv+fvHJZmnD65WpuaQ68f3NWgt1W9zJ2QhIR0YT7X/p8nzqw6gb+2MHaOKbAtDktVyixg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlm5JS97HZKidNisVIVkmJQWSCscakXTemNkClg6hF+kCVivx
	rXM5gnW/F1m8doA8cinM9Zrqr0Aeq2ZR6MtIHEQGAzXg5O+rCX+HJWttLuRcYyKLZK9GBCkRnhM
	Ncx+k
X-Gm-Gg: ASbGnctUq83d/+dTuhT4W+8gF8quI65BN6sPj6Alhu67bcUeuJar+B9uyHxzM8Bw5df
	Gf3uDYJL4kkQ/dAxPMmEHmEmcBRXJ/k5MkY8BmVUJgUtMod4WeOxdSnb9QfAql5DNMV5qIWn0TJ
	M8alSVzKRO/mDk2xRwjsaKHFYcdY0LsIhmfXcbjLYzJwr99QDTxkdMpz9n4rC4Emz+5ox18Gn+h
	LzlI7hg534QJA9jsXAkCJoTMAxbirMj3fIq/C7UAwOdszhs4d1ezfjfVwLfB9+9Xeb8J68uDx4X
	Hgh3vqUSqWnT04VVMQ5m2lWYNa+jTDODYqNoxHKITWOv4+bzvuaE0YUHxk+qOjXEW8fnKLrcivm
	DmbR996n0G+7PXhkdl1yE+5LSR7n+Tt9+AYV4nSJk33AVSSejsFQ=
X-Google-Smtp-Source: AGHT+IHk1UMakCda7SbHn217bmgNYZQPpsqcVctVvUkFEXzi4X/UnGN4v/9flvEV7/bRX/cTPK4cEA==
X-Received: by 2002:a05:6000:613:b0:3ee:23a7:5df0 with SMTP id ffacd0b85a97d-3ee891b2bf8mr3827959f8f.54.1758319469644;
        Fri, 19 Sep 2025 15:04:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607e9475sm6413673a91.19.2025.09.19.15.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 15:04:29 -0700 (PDT)
Message-ID: <91f7c75b-cc3a-4458-9d48-d4f9480966bc@suse.com>
Date: Sat, 20 Sep 2025 07:34:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove pointless key offset setup in
 create_pending_snapshot()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4083805be692c64632388cef096ab43ff77932dc.1758300462.git.fdmanana@suse.com>
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
In-Reply-To: <4083805be692c64632388cef096ab43ff77932dc.1758300462.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/20 02:18, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in setting the key's offset to (u64)-1 since we never
> use it before setting it to the current transaction's ID. So remove the
> assignment of (u64)-1 to the key's offset and move the remainder of the
> key initialization close to where it's used.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/transaction.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index d04fa6ce8390..febf456a9ab0 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1694,10 +1694,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   			goto clear_skip_qgroup;
>   	}
>   
> -	key.objectid = objectid;
> -	key.type = BTRFS_ROOT_ITEM_KEY;
> -	key.offset = (u64)-1;
> -
>   	rsv = trans->block_rsv;
>   	trans->block_rsv = &pending->block_rsv;
>   	trans->bytes_reserved = trans->block_rsv->reserved;
> @@ -1810,6 +1806,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   
>   	btrfs_set_root_node(new_root_item, tmp);
>   	/* record when the snapshot was created in key.offset */
> +	key.objectid = objectid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
>   	key.offset = trans->transid;
>   	ret = btrfs_insert_root(trans, tree_root, &key, new_root_item);
>   	btrfs_tree_unlock(tmp);


