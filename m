Return-Path: <linux-btrfs+bounces-19579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF845CAE25C
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D367300B33D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512B28750A;
	Mon,  8 Dec 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cGuTp1f+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E52236E3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225157; cv=none; b=Kl1D/MzH6pFoUxTB6Dp7SHpHO9UbNhzlFYAd5N0H5veXIB9subCxT34B6On5V9L7s31RE6A9IBqebVM7IwjnQQQVx9qVfoHjXhW6mqr+0lVDA6xgEbEf7+cmhlusTJpmfli2Sj1uFSH+tV+YNbSn+lFxfDVsZmJCWX8/O+rrkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225157; c=relaxed/simple;
	bh=9p12sB92oPH4gzrV3tu266AoAzXV9Zc9MNekahsOqJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+m8ql5Nhz1jJ+mzte7WBzWTMCQUSn/f6LT+2Hwbi71Y4m9WDYI/BnOXPdPOKJx1KNwjdYXFn53sxYyQI2iYoZZd6jHvxz4ENn67BHVZmE09vxLxOxHIMe613iTFqJ8kz+aRw/4XvJhMJe5aI+xHdxZoee1+vl19p/2dQEarK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cGuTp1f+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso2892431f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765225153; x=1765829953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7FHJmygbcwhVHlDzhafnQD0TGYsW3qLvxXuiy6nIo84=;
        b=cGuTp1f+gJtxK59Rhfh6+AjSZV9lMMN/NflKuIa8HVoObntBe8YFEFazj3Rk/FvvoQ
         Bazzmbjy1UMLG6NoFACO2zYNngML0UDJJLs3m/q7bIwT5XUIO0gmQZPSopNxHoHBAj/l
         /IMmnbzOMzM9RddXNtmqNXPXtwZSVdsG/8x7PxXePErplH+FwtVKfvYVuNyeIMhRiDhN
         qQEnimj9kQ056J3qpIiKhMqN4mtSggrtEseAMTZEdm6JHlLiZNpfe8pURp1bU2+Gkmr6
         LdhZv0eOQAJ+EqnoCI9O5H4ynlCOP26jUkZiRgGIdljj6bqx1VnWLCApZs+RuMDWuCrb
         387g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765225153; x=1765829953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FHJmygbcwhVHlDzhafnQD0TGYsW3qLvxXuiy6nIo84=;
        b=tLiPdxOl8rjjz295cSwsBTxJPovudTv5CHQ2U9C8+u7vQpNJ3xEC3hVvYz/XjaQZtC
         voqSe0dkBdMHojL+vVEeCWntSRzCH0yAbNAaFj2X9W64QR9Jw9vVKYRi9NqJiiXTtGyN
         zz1VsjsGoOUfn1hUp5uQtfdGDX9Sr4Tpt+ZGun8mwsHId93ZnDzDZ+8I1qQhYDnB4bH7
         8z99iGQu3tnrjTtluGkRxGfJo2pZjNbdQ7mlddHNKgXarx8ckMuqc2a7DWGoRMMHacYg
         0uqz+VTTr6prS8ISTd51zaw1hDq03zuThDmiq09rcjq3jwm5lwSS4fhXtTx5w+TQcMiJ
         +EaA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoKoPgLzB4towZEFQILPttblGULekIbmhlxaH357k7LOfwVTHzSuUQ7LFMpmLVqMTCUxIBxHMu44YWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDiUWDydKa1KMoofnsjPySuvNAa7CTTPZZHOwkZFYW5r6U2wz
	xiERUBSZQ2FSjCoUdilmycarJO+PX74crzwG8ZWzynqLJAX1ZRHWPfMan8F524EFEiU=
X-Gm-Gg: ASbGncvIAWuzHkdWeqU/XSZ/1SEpkB7xz+iH8jE+e4+QtvEjpzY0PWXxmphnZRG12Sk
	1ipTSg3YKANIUN29pCoF33vhomgOHeJtDUu5ogBB0ylAnw9wlL17DsIZRulQHBPmg/2b1fPi3JZ
	Y7ItSgaeEJgQVT+aHvssHeeSSrj04uZ6kiLbq5zTD5H6FIcXZaH7m2dbe6gwyt7LZXxRwaOFnWG
	Jk+aJcN6s7f2OLnNiPDb3JwxwTsCDVjZ18s7Lv59AkDpUOHtF3YuCju2C4TYdoP0AgHm0VUxLwR
	LMwcyqYN0BqnzEgaDkb/KNWg+cC7bygHlxsqjbISQsd4GJbrRaS7OTDs9XfhwbsM0tgXFy8tLAz
	J1qBXK1iTFXuB+Xns0WJI2VDJGSW3L6gRKZL4VTN6YZfBg39eGf2zCBbNbN8aP6BVD+kMHrYjWY
	sB/QDecIwrrlXbgSbR2tLW04fzWYRB26wEF54HjMs=
X-Google-Smtp-Source: AGHT+IG3Ih3Qt01HVR+RenzqAIb/whVG755qHOqjuRl8M1XcsVe72fZ+hSsCd+woGu6kKYQJlHt5fg==
X-Received: by 2002:a05:6000:613:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42f89f6f794mr9079169f8f.41.1765225153152;
        Mon, 08 Dec 2025 12:19:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a47c184bdsm77582a91.2.2025.12.08.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 12:19:12 -0800 (PST)
Message-ID: <a9b53a9a-ddcb-4113-8769-40a918223ecf@suse.com>
Date: Tue, 9 Dec 2025 06:49:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Optimize the timing of prealloc memory allocation
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <693683ba.a70a0220.38f243.0091.GAE@google.com>
 <tencent_0974B3778967163D1736C0971436F24B5C09@qq.com>
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
In-Reply-To: <tencent_0974B3778967163D1736C0971436F24B5C09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/8 21:35, Edward Adam Davis 写道:
> Too many abnormal exits can cause the prealloc assertion to fail, as
> reported by syzbot in [1].
> 
> Move the prealloc memory allocation to before it is actually used.
> 
> [1]
> assertion failed: prealloc == NULL :: 0, in fs/btrfs/qgroup.c:3529
> kernel BUG at fs/btrfs/qgroup.c:3529!
> Call Trace:
>   <TASK>
>   create_subvol+0x5ad/0x18f0 fs/btrfs/ioctl.c:570
>   btrfs_mksubvol+0x6e4/0x12c0 fs/btrfs/ioctl.c:928
>   __btrfs_ioctl_snap_create+0x2b2/0x730 fs/btrfs/ioctl.c:1201
>   btrfs_ioctl_snap_create+0x131/0x180 fs/btrfs/ioctl.c:1259
>   btrfs_ioctl+0xb4d/0xd00 fs/btrfs/ioctl.c:-1

There is already a full revert, and your fix misses all the other error 
cases.

https://lore.kernel.org/linux-btrfs/20251208195407.GC4859@twin.jikos.cz/T/#t


> 
> Fixes: 252877a87015 ("btrfs: add ASSERTs on prealloc in qgroup functions")
> Reported-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b44d4a4885bc82af2a06
> Tested-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/btrfs/qgroup.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9e2b53e90dcb..ac5380520152 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3289,10 +3289,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   	if (!btrfs_qgroup_enabled(fs_info))
>   		return 0;
>   
> -	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> -	if (!prealloc)
> -		return -ENOMEM;
> -
>   	/*
>   	 * There are only two callers of this function.
>   	 *
> @@ -3388,6 +3384,12 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>   		}
>   	}
>   
> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> +	if (!prealloc) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>   	spin_lock(&fs_info->qgroup_lock);
>   
>   	dstgroup = add_qgroup_rb(fs_info, prealloc, objectid);


