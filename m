Return-Path: <linux-btrfs+bounces-14096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89264ABA567
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 23:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668FC3BB61A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CCD272E4B;
	Fri, 16 May 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EMiYM3D8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B822F746
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431499; cv=none; b=M70SNCpOTcKwsraaGHZT0yOhQ/+dPRKaVcB5uSaHLR0u5tTGDx/L+8JnLBIDDTNY7rV8Zzan3EtIzjz2rXL+lFS7wl21BAXEELA7jUUT+QlrHykEtmcvFBGYko3MblvtaQD6M+jMLgF0sni5jHhPJO+kwLp5/JWJNL8KlCZLp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431499; c=relaxed/simple;
	bh=jCepQ6diNui46sELzj7WJo/CT3GQWTAejPRUzjNpMG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hdbXCu1bXdVE28TXtJ36CVjHg5/WpDh8ioX+j7mQcYgPg8v9Iho+jnMBopqV4bUIW7D8Qgf9acP9xvE+8FYiacrOslPUJODu3SKBy+mv2ifP2kB1lNynWaMwTK217XEHsxG5DQ4Hc/fL+ibttT03PMPJnOYBZqz53kbxpDGKvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EMiYM3D8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b9af89f2so1680599f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747431495; x=1748036295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4uL34yY3xX1px3CXaESiKRoPXqhnPYln1THb50l70Go=;
        b=EMiYM3D89A6RMR7qcyBS7Vw1L0xuzNiRMeQtzU3P7WmBkrlydd+pM5HBqPxZ7gI+0t
         8P1+GZFgYy5M4x3kdRns+ZOh6S2dgvbDVGqu4p6BUACh7MBwWU9aGz5IjrYunZqkohTd
         ggIBDcduHKQAdd5pckdQXSXHBxSpEKObMqdlORSKAaPSn5d2sAShg+evKSvraQV/7BXv
         WOFbSpYz7mE0VWkrWxveuv++Rmc6apljuo5t35Jw4bf2NKmtdruSeIP5QcTV/QxPxmes
         Tvfliey75DJBUS1l5RTiuJ+sWfUgZp8QBaR5lEaRjek/7gVdEKmdw3HD/LF+zByJD24O
         egIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431495; x=1748036295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uL34yY3xX1px3CXaESiKRoPXqhnPYln1THb50l70Go=;
        b=joQOtcjlU+FpOd8DkM1b4D+Xyz3A7ohY4RZmzVISZbWftNHzdnRximBESK565u2Akg
         ermEvV8jHOwV6ZoC2hwuAMqQxNPLfnzucc+yQ4dRkaCvgMZDHFounRFdkJnrtZCnBmFb
         BXVDZW/Kj+wf8rTq0Elmzkp64QJ4ZfNb5mNwe23/+FK1ffVZ6tHJS5UqN6CaPHuN5zLY
         ks4v531tXp/+RqH//zT5dVa1Wx0MYJXwEdrrUBL0wbkudkQn4H51o35LFcAFMAt60WrJ
         e84Q7Jve84gl10nycahKeKx2OLm7HyYH55HApaCNYC77jpY2ydRrGXUQq6e15y8D/2po
         C2uA==
X-Forwarded-Encrypted: i=1; AJvYcCVY3rNw4pKRsskDnJbYmf9qgVebcJMM3uo4+8MX79WmZhZ84Tn3sAJxKBqaDapKzX0EwtjVoZpyJp9IEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ye9USQwMKBkW1sWlbe01GMuoIQk8lKHVl1+sRUly8sP/uvOd
	SZcumHkccMyASXADlLzfNFUdk14zAITpayiiDZ1sphgxS+1CQHapsx/o8/vJrWy29JNHdn0unJB
	Mwe6g
X-Gm-Gg: ASbGnctsS7Gun/LmtYy3yCIWmSl9tHPQbkhdFZ7Wi+KB1sr4rQWPoJHAFlP6B8ntwuZ
	GCSO2cJGKKQ5zPW9n2+OiFLmiyOmOmzwCYaq9JN1OuVow/CnU1tLRWrCkLXYg46hCKpGX4MuATr
	5RkN9Or/4PrN2azBNwm6spUxMifHkFC7ojc/Cu9+OLsUzI3co8VfAW1CSrY9fuzNQYuufdsUNtp
	C0JemoiCyihgdRO0XTak0ihRUMcasHaxbXRYqZCBYDBiH3psqEm45g7baGBzzZ6ItVYTWRGKAEk
	rLtlhGLjLa32kntWpXdR3iMKxbLGhLaO7chHhfogka6GSWYdsiPom5pCZn34LvNEjnpD2vBW/vu
	+Ch4=
X-Google-Smtp-Source: AGHT+IEQg3FJdeNJgUwFcGvqhXA7GJJawxA857guoe1+JaCAZsdwVjWe8EZpmpcrYIec7ZWxu0+iHg==
X-Received: by 2002:a5d:4885:0:b0:3a3:5c40:2000 with SMTP id ffacd0b85a97d-3a35fe67b89mr2907742f8f.13.1747431495058;
        Fri, 16 May 2025 14:38:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97fa6sm18601755ad.135.2025.05.16.14.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 14:38:13 -0700 (PDT)
Message-ID: <35458eaf-f176-471a-8248-30471342c919@suse.com>
Date: Sat, 17 May 2025 07:08:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction aborts at
 btrfs_create_new_inode()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
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
In-Reply-To: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/17 01:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> btrfs_orphan_add() failed or when btrfs_add_link() failed, move the
> btrfs_transaction_abort() to happen immediately after each one of those
> calls, so that when analysing a stack trace with a transaction abort we
> know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c0c778243bf1..7d27875600d6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6610,13 +6610,17 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>   
>   	if (args->orphan) {
>   		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto discard;
> +		}
>   	} else {
>   		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
>   				     0, BTRFS_I(inode)->dir_index);
> -	}
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto discard;
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto discard;
> +		}
>   	}
>   
>   	return 0;


