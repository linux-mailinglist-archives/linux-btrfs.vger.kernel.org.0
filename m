Return-Path: <linux-btrfs+bounces-20309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A088D068CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 00:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FAE3301D30C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B016330B3B;
	Thu,  8 Jan 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBRF8La0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A04280332
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767915129; cv=none; b=uoFvQrG5ndBkTf8curnQq6s1mLZZF3AfDXiKTyKrWnelg2bJTKn2IcsmDVw38VKyEBoTLWdakYdwjTUPyPJX9j033vbJqJp1rPIOJybSCBqfuZ7x1X/5468cRr8sQaC1RJqvnu+hVkrRvSAMDaj5Hs7NwxGMrHH7ao6qQ9rSe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767915129; c=relaxed/simple;
	bh=wUDXBVCSOQwGN5GoH2RCRevG1fPKOmnYeAJ/8jtHt3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3l9Q0EXKc1mS1zCNLP3fu8a8XOqNmhDQxOqfupoYElLZpmPbnh0X12f6YTSaARu7Ss2+K9oB3PlpqU6JxB5DZzalmaq+arT9Iko/B1g4zCHsnLerHyVSv9tRWHChkQ9XFHXyiQ99qqowo1Ro4TtRfenQPL8kvLnLCraDBPAU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBRF8La0; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so32249105e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 15:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767915126; x=1768519926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oWXcEhGywsWuDYYR3tOiobnYKRPFfO3mcIr9ycZTJ8I=;
        b=bBRF8La04y/LfyxCceyRMO8ED0nkAvM/ngk2O9TXcSbK1N4gObnl+ku4AII2V1n4gI
         rMn4Hy/HW3QPc7E9DZbwnjS00H5kpJDnTIwQbZFuLW1wZdeqTDn4+QGZZDOo1wNPk6u+
         mxqYiSUf/90ejXEQxOfH7k82O9Sf42spHJ6eX/8drfktOIcieCJSxO4QgX6EtiA7NDwA
         pyQDruDaQ14/gzsBvF9DIVktSXIH+rUv6kdwkc13/g5gn7jMrgHOC7/cgOLGS3Ukl5QJ
         YsVD2q9t5TQKDogp7mY1c7T0kJCV9p+VM4Md2sfzQy84R86oHSPxo7195NBZ4ZT3XMff
         sa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767915126; x=1768519926;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWXcEhGywsWuDYYR3tOiobnYKRPFfO3mcIr9ycZTJ8I=;
        b=bJV+iALPvJ5OLY2/g6BGWL3jC6QG8YXmI7hOczvMS6bOp76cD6sDNMqBLIhmSUzRLh
         UkyYEy627EUlAWtvf3sl1RjszWtmFQu23r1bSwY68UtlTF4zQpx+3wSv5C4EfX40/siT
         PXwcBpMyYOpm2AoacXSPOTA3OENbMsxc4JOCDYV3nPdung2zfNzM/t8HZW2vU81s7zuW
         B3/vT5tOt+FtL7GVgDYabVtUEFe4bFj0NcV4pn2FY9p9nAlzeSYfkkRidjLkxuGOcFRE
         mnbBdPLb1petQeH6J8r1h0YznFJgHcYQUVT8Du2HSnuQvVAWTwQ87GVvRh3dKtCyZgsj
         cnpA==
X-Gm-Message-State: AOJu0Ywu+ebz5sBs6eEoyWuuXUD+eredI855otEVkGYfIJXX4yc/uJc6
	2Auvv9J94ML1GkXlU0nAHnXcFT4ZenqaMvvmYs5BhDBgXAkTL+h8wa6TTWOszKZdfFY=
X-Gm-Gg: AY/fxX7YuiHiV/4kqC0/o/s1pB1mc5tlUAAJ2R6kpg2JR6WOhbJYokqZe+kFsP0zexh
	Z7o36OcdolQ6qnujMbuxj8jQ5+SHMN7UndPEDFvKaeSa4KMRAthNflnn1ZJbB2+w31dUOnL4N87
	uoiVkHPZhPmdnitCGgQ1EYklH6gD0XO5AEfXTzuncBpvAxixYp1F5WSMYiAHUOb6xJ/wOc3LGQE
	kraTr7B4vTNJbvS6St86eUQpLWOiacxAHUU9+UDoqfegeQubrAVnYZbvEn9YD2ZArEqLgX/jjMa
	71h7YyuJbBrfPFewkWjxmWvmPBxpGFuvvyJ9UVfkmBdQrdutZPiKeQN7Z/rYMPy6P8uIVju69hf
	d14l+4qfqxyPKfr7zs7G2tfQs2raAWfqALerGAb/YvNIIkqNXhCB7JcNKgjDTd0+lS5x/jwYAse
	RxTfzj8TWdLPhFXeChzrNlw/FSpdSNmPz+w6rm7g==
X-Google-Smtp-Source: AGHT+IEYJB0myzR3n9wB4QbUlOmvbhNZIWPTqgTTqDTgLJM7a7Ie7z/aoF81MDltK67u2nUsF2iWdQ==
X-Received: by 2002:a05:600c:c117:b0:477:b0b9:312a with SMTP id 5b1f17b1804b1-47d84b0a293mr67565485e9.7.1767915126338;
        Thu, 08 Jan 2026 15:32:06 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b88d984sm2561639a91.3.2026.01.08.15.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 15:32:05 -0800 (PST)
Message-ID: <3a9648fa-49c2-4f07-84ee-50a1c7d7196f@suse.com>
Date: Fri, 9 Jan 2026 10:02:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add missing ASSERT for system space_info in
 reserve_chunk_space
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108194502.653-1-jiashengjiangcool@gmail.com>
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
In-Reply-To: <20260108194502.653-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 06:15, Jiasheng Jiang 写道:
> In reserve_chunk_space(), btrfs_find_space_info() is called to retrieve
> the space_info for the SYSTEM block group. However, the returned pointer
> is immediately dereferenced by spin_lock(&info->lock) without validation.
> 
> While the SYSTEM space_info is expected to be present during normal
> operations, direct dereference without checking creates a risk of a
> null pointer dereference. This deviates from the coding pattern seen
> in peer functions like btrfs_chunk_alloc() where such returns are
> validated with an ASSERT.
> 
> Add an ASSERT() to ensure the pointer is valid before access, improving
> code robustness and consistency with the rest of the block-group logic.

If you know how system chunk works, you must understand without a system 
chunk a btrfs will never be mounted.

The ASSERT() looks unnecessary to me.

Thanks,
Qu

> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>   fs/btrfs/block-group.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..f4229ee4f573 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4313,6 +4313,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
>   	lockdep_assert_held(&fs_info->chunk_mutex);
>   
>   	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
> +	ASSERT(info);
>   	spin_lock(&info->lock);
>   	left = info->total_bytes - btrfs_space_info_used(info, true);
>   	spin_unlock(&info->lock);


