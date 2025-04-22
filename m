Return-Path: <linux-btrfs+bounces-13202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B2A95CCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 06:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4433AC5DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 04:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629451A83FB;
	Tue, 22 Apr 2025 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GULxeQfJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29F194124
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294954; cv=none; b=m+nURG+DH72h48jk3YJeyeOVQP6K0mJ8ZSvxEWKGrDgn72BnqBsieCUZu/Sq7y8gVAoQOBhesxh3cmJ79iWIQuXRPcfOIsDvxXlTdwLcgJxAB4qixgumuugYHdZ7o4wre5eS0VSQ/KJiIfuAHS8kMvgoOYffqMbLOCKSRhBVZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294954; c=relaxed/simple;
	bh=qooPPh7Sc4jDHmLmciL2D/TBKbArEcvN1N6OKR0BkSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn/2e53RlT7tk3kNbZE54Hc6sc4RF+Q061MKUvuMUfsaFEOyJBcLJrYJ7H9pyWnMb9RvHiVD5dbYeeM6QHF4we3PZ90xsuYS0s/BKsDuGqGKF4AqqR5n8lZ/QIrdAUrHFV9AK3YwdMpzfO697cJpxIm2ZeIzZNwKoApbEcfRhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GULxeQfJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso9981470a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 21:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745294951; x=1745899751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7UyT32oNdvI0B7CJmPYL80eqMQ3ZYwskCys7aLnpU8o=;
        b=GULxeQfJzytvUxAApg2DyGMnjp+IvcvYz1UizmWEAjpixnvz6EDEanBecToO4URAHK
         s4XbR67/ZxpGLOVyU1CZElEA6VV6EsaQqiB6AeyCT6yBM6tY5Fyv9OOkU/h6BLFo1lhu
         bE6s21CFo5uhbn8sAliwoI21y/k1uPRPqyNIPsrcP7/jUQN3zlwCABOCzdYNNQgGAkHO
         6jYcT9hvDUMTapdNzLLQua17ICruHm740JT0T5hkVDowUNpIdpe1LUcJcNmFi0kalKWP
         mE5gBGk7h5u8UW1BKrCdkmrYJTSJeJtILuoCfhNhDiD6UW/GXm2imDs97zNOu7x/PhXc
         P/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745294951; x=1745899751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UyT32oNdvI0B7CJmPYL80eqMQ3ZYwskCys7aLnpU8o=;
        b=fVYnTxlIfD7HCYNCf//dmDICLEBoV9NtmliRxTPTmefQwuZ58y1nC/cPODr//A1Bgn
         sWq8fDWh74PhhrYf8JTyAIaiBGQ/vqr0KqAtpWwWRtZubYhnMtA6I2/emiX31hi6RgNH
         t5pp/l3eG7SpK4Mi7e/e9aDwaHeAA6/YGO6MUw9QL5ZFqPhwfSddRrl41r1VIfs6nstq
         e42Evi0k6ild4tf/1xq5vjTZGZsN2Z+w+3xzgAhjn42hFoh+amyCK6A6pjwgOzOb0AEk
         7+9vMUjorD0op+0AI03nOZkJ/onDgvRAGno9crGSag+ORtaae0nfODH4vhfclZUe2xUA
         VjRg==
X-Forwarded-Encrypted: i=1; AJvYcCVWUONasoSxAs1w/FCwf/KlPzyhXf5LZQgyWBT3rUE2DL6j6S7Hmtn0hRX44T7l08IjdL//aYJmRL/+Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5Mj4+avw3auClLJwJBuZ25JjAMHbvmXaEwiZ70N2VpFQIRbj
	15uWE3wE0wFC/qmMJk5OfoGXU6vqpg+69S/LtU+Xy1g0/z5kytRb4FstgopBYZA=
X-Gm-Gg: ASbGncum0ZsuW3CJwUuLkxKL3bcqj2pXbZWc1JMsg+pYOiQvR4W3dTf97ZwVK4jp8Wl
	JlEL88Qmre77RSVUKfNNHRTTDCyATvaX9KtmP2LU7c0odSvbptm+8EG+9TiwWmmxJHenr92ahf4
	zkWX2c8fS9pDh137JSK19tvUXa/FhyGzJRSFLeKC1tlXxGpYc5g+7UQs56tNLCZt7IqkLI5B8AD
	hnE+JLwu6as3l6eqUXc4Y6fouKytlMIJbzPgVSiCPpkPweOZqvgG9fHYfgdmlR8KFYzzRrJRoNw
	bzMMrXyr3MmYJ7DQjknKIDd5Lnq9MBbCEue71QXhpxgyK+bXTyk3k567ts8ZSAu6IzsI
X-Google-Smtp-Source: AGHT+IHW+g0qw3gBtPQ/2pE0/fL0ihaAK6vaQaOak5PgSUwLDfg0R/nPaOQqt4C7h1YtIBSkKRbolw==
X-Received: by 2002:a17:907:3d9f:b0:aca:c67d:eac0 with SMTP id a640c23a62f3a-acb6e91e47fmr1536497866b.0.1745294950805;
        Mon, 21 Apr 2025 21:09:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58754sm7806905b3a.107.2025.04.21.21.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 21:09:10 -0700 (PDT)
Message-ID: <9f4851b9-b226-4639-abf3-a7fb650214d3@suse.com>
Date: Tue, 22 Apr 2025 13:39:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix the resource leak issue in btrfs_iget()
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9e7babf0-310f-40cd-9935-36ef2cebb63f@gmx.com>
 <20250421154029.2399-1-superman.xpt@gmail.com>
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
In-Reply-To: <20250421154029.2399-1-superman.xpt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/22 01:10, Penglei Jiang 写道:
> When btrfs_iget() returns an error, it does not use iget_failed() to mark
> and release the inode. Now, we add the missing iget_failed() call.
> 
> Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs_read_locked_inode()")
> Reported-by: Penglei Jiang <superman.xpt@gmail.com>
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>

Now pushed to for-next branch, with some updates on the commit message.

https://github.com/btrfs/linux/commit/cfcd9ed0108925c8071e27e6d5a300adb74c1839

Appreciate your bug report and fix. It would be even better if plan to 
continue your contribution to btrfs.

Thanks,
Qu

> ---
> V1 -> V2: Fixed the issue with multiple calls to btrfs_iget()
> 
>   fs/btrfs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cc67d1a2d611..1cbf92ca748d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5681,8 +5681,10 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>   		return inode;
>   
>   	path = btrfs_alloc_path();
> -	if (!path)
> +	if (!path) {
> +		iget_failed(&inode->vfs_inode);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	ret = btrfs_read_locked_inode(inode, path);
>   	btrfs_free_path(path);


