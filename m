Return-Path: <linux-btrfs+bounces-18684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F6C32F2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 21:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954593B91A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B22ECD3A;
	Tue,  4 Nov 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NF4B26cu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA22E92D2
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288967; cv=none; b=SgjCk+BPAOIucc61Yhzhe+5H6HBwHsKoRxdp+onDH4U0Rfu9JaDMrIbkCOueTh5QoCtHgbrTwliqouRGmF0/i5PilTJ7Wx+NmGgUW784nxAqsjF5NjdPcdwbwmNsfoYqMYWAdoGyJip68dIx6M1vYkj5T2q1uqZDc1XI7B1pJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288967; c=relaxed/simple;
	bh=JGsJhmJeF5q8J7Ype2nL15gIcp7qqgcNpRYXX2zKA1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hpn/jMg5uyUPdUzYPOIszUK8eZzBc4s2K291XEF6kdic1IsKo4mJE1QFh17osuggix6Ex4G9ZXOxMHJWhAD3l8mUxP/Kah6zN/GOQmVVLWLWaSGtYUQqmC9s5AD8LgAeXeC77AR96ZncTcaxRWHZB1PrEVUQa7hFWXSdvBNOGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NF4B26cu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7e438a8so897741f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Nov 2025 12:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762288964; x=1762893764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3/I2a0uZTAnglwIVDCoK1EV+nWMPjHOXPCZYdwAgCYY=;
        b=NF4B26cuPHjv3gz17Rsd4oUx/nd3H2cVMGfdAtWNrXbFRIn90kvaIWFt3FX9h1quZJ
         kLLp5i6VaIXIirF0hn9FPubdMMfmwIMNzylZN3OiRuxw32b2UMKihBm8DYldouUrhFym
         2tqjhuNCieP75phG/5Dlp3EO/UP3JX5c/ckIbEo/zfl/KaTbCzNlVwJ8zwHt+CIsG2xM
         BbHYPVW3s4uJC6BrZ1ZN58sX2ZOp21+aJX+ytIjJG5vkbyhnIn9xz/tD7NXW599Y3jpK
         v8PhPVLh8vmgGdnZqIE6CobxZEn+jhXyhzFecnCon9lim+OttiR3GX6GdmzS77ICPWGM
         RCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762288964; x=1762893764;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/I2a0uZTAnglwIVDCoK1EV+nWMPjHOXPCZYdwAgCYY=;
        b=CxAwpyMWwbIdEwVvVtarv8EZLCjmFWJSl6WOrMr+InoRUwV/8+Q7Ibp5k6LjSstHAW
         wjqsuM6p/O3ektku01DwfAKg2Wtmcr3vS0+UAh8l/93SFT2i/BKVv7k2/2kDPh+lGLBX
         y8opwx0DxjD7Ohtr9R21qQlm2hQxArIUnaRRDGdM0caulxA3IzJexe8dXMIjpZMHLS5T
         syASeK3Eomp6+qTiiDudq3BYCz1xSuZorWARRyywKeurq83KrmJqk5pOy2JWDKH+Kf7N
         zNKEfyWqZDxyR3VEAxqVfF4sn2dqOX2hbQBQqWYgrYdTXu3+1UkgQzS0L337MA1/h0v2
         ZRHg==
X-Forwarded-Encrypted: i=1; AJvYcCVmGtYiJoGnK+tERrkCJa9yDUPgiABC9Jo/p9BG94bcKKF3DVK9prllZa2RIDfGlBb0DW9NWo0VzokgfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOseamYsXk1vpJqGTOfjTo5u/002Oldbj087mGso/cbdHcIQvj
	tWMHqPUkpwjjVfVeGzS3pK6M4CQT4Gn2Itobk9ek0840bY+TeiscxS8LYqBHXddV5yw=
X-Gm-Gg: ASbGncvSHTMhvqeaG8TydScVeJoQBviLhPI3155Zh24z5xZ2HnF9SdtFsd3rfGyRam8
	octw6zJBpTNeqRD1osva5aQTvr3F3FAf/1odv/Qb4g173cV60crpIp6DCS76LPGZfPXsZ8/zQ+u
	InxGhjekp14P12nF4wNSD8OdL7AFWWsEnKL7N0ZlqKtce/7ORfmEyiQpMH9Pkaw/Xqapf2mu257
	Fg34UF+JZGTk+NUQJmPjkiEf3P1wga1Is/PQRyDZy8aN2bdvopMwqBOJ0mxZfmFjM5FKiq3I9Bo
	/ZNBTKw1oWY4zDFK4uKf0mXs3g63IQxwBIk3/gGIr9q/tErTlxBpq1psQSp0pj+NnMZeswrY3Wo
	a7zuRCt7JHk9NopP20RATssYJbBavjtluBq5r6rKfS1n7v+b8Ybwvd3YMvTJEyOq7BkULhAmRKD
	oVRUsLXtFv8T0RVEg4FTbfQCwUcfT5
X-Google-Smtp-Source: AGHT+IG8Z203PhFCyhJhz48A8l8UhXjLU1AaikFIf0iJkmfVY5x+Gi/GZMr6bL+04r89yb9RlNQzVA==
X-Received: by 2002:a05:6000:26d3:b0:429:c851:69bc with SMTP id ffacd0b85a97d-429e32dd761mr472461f8f.8.1762288963767;
        Tue, 04 Nov 2025 12:42:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3246e7bsm3976191b3a.8.2025.11.04.12.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 12:42:43 -0800 (PST)
Message-ID: <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
Date: Wed, 5 Nov 2025 07:12:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] btrfs: use super write guard in
 btrfs_reclaim_bgs_work()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-2-5108ac78a171@kernel.org>
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
In-Reply-To: <20251104-work-guards-v1-2-5108ac78a171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 22:42, Christian Brauner 写道:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/btrfs/block-group.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5322ef2ae015..8284b9435758 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1850,7 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   	if (!btrfs_should_reclaim(fs_info))
>   		return;
>   
> -	sb_start_write(fs_info->sb);
> +	guard(super_write)(fs_info->sb);
>   
>   	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
>   		sb_end_write(fs_info->sb);

This one is still left using the old scheme, and there is another one in 
the mutex_trylock() branch.

I'm wondering how safe is the new scope based auto freeing.

Like when the freeing function is called? Will it break the existing 
freeing/locking sequence in other locations?

For this call site, sb_end_write() is always called last so it's fine.

Thanks,
Qu

> @@ -2030,7 +2030,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   	list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   	btrfs_exclop_finish(fs_info);
> -	sb_end_write(fs_info->sb);
>   }
>   
>   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> 


