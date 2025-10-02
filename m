Return-Path: <linux-btrfs+bounces-17330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F2BB24A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 03:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3860C19C5A53
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E153A8F7;
	Thu,  2 Oct 2025 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uabua8fK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60246B5
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369791; cv=none; b=GNYCoChevxwiBRsdiiI2EqKoH6meRn5Ajsl/UCviMRVnUWpmlZ3Pq1O+0iVJalT7RUS2xdK2ESSTmA4DBZYZu2KHD6YL/g7mqazZ+BsmskVZmGJ/dDUnUpbyRZX0jbtmV5rNqDBrCv170B8HLFuhVjUqUEMVn+I96BocoXM1Vlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369791; c=relaxed/simple;
	bh=QoqQvwQxbJcoZOHA4Gc9y+aathZk+IW96xasoTmYVXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RXYDfRHz1ZS6srzWGFoZeDC6LeiDqFnhU+fe1A7f2PuCY73Oj5DgpRVAU7eGmt5rBqxZq9+Gu9LXd85LkjPABKL2ii7k/DPEPj9fHtQR3g6zEuIPJL9FBxyD8CFqbFNTLj8WixpfYMrbrVqKIwOYZoEhqtUNn4SHsXeeVncg4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uabua8fK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so372914f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759369787; x=1759974587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc5d8U66N7EZG89VDaIyXoDc0PX3bV30yaRngT8UOc=;
        b=Uabua8fKrubEbRg+UC+c518jSSjJhbamHltyUkGA43Qa6aUmmnGmqHUUbcM81GPUBt
         6bnz+63Luyt3Lk8iN7aVyNCp3Sz1G/5s0Eu+K52b5gBw9vxEiI6XXN+Y95532QJWwg2s
         Qsym4xLeLrafWqHO/qD//5Oyko7dwDDY5bglrWPFnOtdIglra0Ea/ePgjZoXIf7lmfVn
         dTGeDdIOOoX3x4WACfebqir1ndYnc1rv/o0fWb2GVogtpqibaTSEmhRE//qyT6Ed6DX4
         3WbnD2Lz9nuZ2n2M2avWSfpJmPOxR01yZ7UV8otlbL8XK220RqgnUoupPNHI6QeYdkhG
         P5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369787; x=1759974587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOc5d8U66N7EZG89VDaIyXoDc0PX3bV30yaRngT8UOc=;
        b=ulF+BnVUt4pr8VDu+m4BqUhOq70anTMnXAZxLHNsKc2iFq4+CSf+NZFwqj7Wuep2kQ
         HYRBoLRv7R4MzNN+FhY9U62tezwNa+NxK7zak3x1sW9o3Ikyq0RCsXnWQtdGEuUjTdi5
         2FYzjZ08+yGaufa4X/bxQ92V2ZxttPfskUCntw2ip+kRiVAZKrzQtFCw1/kVQjpyFKBp
         d6CXswa0i0kOTlWKaTMTkSrdadSw/+vlEIZvanE9imou1jfTZ2K4yT52/D2LKe30BWJC
         pFAD/gdWJuCi7kKyNswbOnnGkxeuR5X0Kf5uHJ+AA2+OS5jQQh4RV1aZNZvGo0aEf21d
         y0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUVutI3zy5ubqgHDKeb/3S/P2nm+avkRNrO1nfK2Ae6ujzcIRezGKsuv58pYOI/i2+gSCYlfYkaj/o2LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6aIzzsYLMo9reK3UEARcQBEgJyFd25WHqEGagFpKXqKxyd3n
	kyNKMWAnQpXckRWRq6+CqoY7sW4tpZ8GVHP3OSAUGHmMbhER8Q3Vm5rcPEBGUHP9S0JxyRe/oMb
	vxoGs
X-Gm-Gg: ASbGncuWk+fn9ta70EfQEEUtUGBtmOsuxucpgVMQM2MoP3uOmds4R/AkiQRYPfhdaoL
	EMq4MIhwQKT8boykuxcVGRTw/yKeWKFhaZDfyZKj7GuUULWW2TW9QSUrTVvwt/+jSmzHeKKzGw+
	ZMvv9oo5GFohyq8VtqT/YHtZpQuwtdJiOqQ9ydxU/I/JafFQQLi9wbuFny9z6jkJ48sKwO27LzO
	JqkuZ0UhDASCyKBSXGmp3KNuEianlGxWwDauhWjVd+AmWxW4TNKn4VPbO5uPUPTuz4p+F6n1ftb
	l+hnahm8Llnky50LLiSTTl9+LABZkTbfGkuXRJjzn2bU7E1oMYBem7TC81i132JX17glqZwhy5o
	OCNfn+oHtjw3lxZGnwyj4IDBFaeVnblzxBwHW6T9YC0jVLCYrggJGVAtgVa1btmpui4W/gp+FlZ
	s=
X-Google-Smtp-Source: AGHT+IHuH6U08Ba+G7CUtB0gachpAJDaSQunIOwaZdMp60OO///A9/8izKAQw+rq5Jkcf+L13QKWpQ==
X-Received: by 2002:a05:6000:2f87:b0:3ee:13b1:d6fb with SMTP id ffacd0b85a97d-4255780b927mr3887769f8f.32.1759369787463;
        Wed, 01 Oct 2025 18:49:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b88c5sm9319615ad.70.2025.10.01.18.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 18:49:46 -0700 (PDT)
Message-ID: <4a575172-4984-46b3-a82c-c3e3ba42819a@suse.com>
Date: Thu, 2 Oct 2025 11:19:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0d1622fd106eeefff16ae7f2d1b75a3058c3fa66.1759367390.git.boris@bur.io>
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
In-Reply-To: <0d1622fd106eeefff16ae7f2d1b75a3058c3fa66.1759367390.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/2 10:40, Boris Burkov 写道:
>  From the memory-barriers.txt document regarding memory barrier ordering
> guarantees:
> 
>   (*) These guarantees do not apply to bitfields, because compilers often
>       generate code to modify these using non-atomic read-modify-write
>       sequences.  Do not attempt to use bitfields to synchronize parallel
>       algorithms.
> 
>   (*) Even in cases where bitfields are protected by locks, all fields
>       in a given bitfield must be protected by one lock.  If two fields
>       in a given bitfield are protected by different locks, the compiler's
>       non-atomic read-modify-write sequences can cause an update to one
>       field to corrupt the value of an adjacent field.
> 
> btrfs_space_info has a bitfield sharing an underlying word consisting of
> the fields full, chunk_alloc, and flush:
> 
> struct btrfs_space_info {
>          struct btrfs_fs_info *     fs_info;              /*     0     8 */
>          struct btrfs_space_info *  parent;               /*     8     8 */
>          ...
>          int                        clamp;                /*   172     4 */
>          unsigned int               full:1;               /*   176: 0  4 */
>          unsigned int               chunk_alloc:1;        /*   176: 1  4 */
>          unsigned int               flush:1;              /*   176: 2  4 */
>          ...
> 
> Therefore, to be safe from parallel read-modify-writes losing a write to
> one of the bitfield members protected by a lock, all writes to all the
> bitfields must use the lock. They almost universally do, except for
> btrfs_clear_space_info_full() which iterates over the space_infos and
> writes out found->full = 0 without a lock.
> 
> Imagine that we have one thread completing a transaction in which we
> finished deleting a block_group and are thus calling
> btrfs_clear_space_info_full() while simultaneously the data reclaim
> ticket infrastructure is running do_async_reclaim_data_space():
> 
>            T1                                             T2
> btrfs_commit_transaction
>    btrfs_clear_space_info_full
>    data_sinfo->full = 0
>    READ: full:0, chunk_alloc:0, flush:1
>                                                do_async_reclaim_data_space(data_sinfo)
>                                                spin_lock(&space_info->lock);
>                                                if(list_empty(tickets))
>                                                  space_info->flush = 0;
>                                                  READ: full: 0, chunk_alloc:0, flush:1
>                                                  MOD/WRITE: full: 0, chunk_alloc:0, flush:0
>                                                  spin_unlock(&space_info->lock);
>                                                  return;
>    MOD/WRITE: full:0, chunk_alloc:0, flush:1
> 
> and now data_sinfo->flush is 1 but the reclaim worker has exited. This
> breaks the invariant that flush is 0 iff there is no work queued or
> running. Once this invariant is violated, future allocations that go
> into __reserve_bytes() will add tickets to space_info->tickets but will
> see space_info->flush is set to 1 and not queue the work. After this,
> they will block forever on the resulting ticket, as it is now impossible
> to kick the worker again.
> 
> I also confirmed by looking at the assembly of the affected kernel that
> it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
> the assembly is:
>    andb    $0xfb,0x60(%rbx)
> and similarly for setting the full (1st) bit to 0:
>    andb    $0xfe,-0x20(%rax)
> 
> So I think this is really a bug on practical systems.  I have observed
> a number of systems in this exact state, but am currently unable to
> reproduce it.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/space-info.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 0e5c0c80e0fe..5c2e567f3e9a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -192,7 +192,11 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>   	struct btrfs_space_info *found;
>   
>   	list_for_each_entry(found, head, list)
> +	{
> +		spin_lock(&found->lock);
>   		found->full = 0;
> +		spin_unlock(&found->lock);
> +	}

Using spin lock for a bitfield member looks overkilled to me.

And it also means all accesses to that bit needs the lock, which looks 
impractical to acquire the lock.

Can't we put all the 3 bits into a bitmap so that we can use all those 
atomic bit helpers instead?
(Still a lot of change, but more practical)

Thanks,
Qu

>   }
>   
>   /*


