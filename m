Return-Path: <linux-btrfs+bounces-13859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A3AB1EB8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD151C003D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9025F7BB;
	Fri,  9 May 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CKpWdOXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07F25F7A0
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824914; cv=none; b=CEuvjc+coyJBOsWWdcNpb5XB3/G5YtFQfim3IOtbwAig4G86pHUrsxOMHC6Fyw5BBZDUHZpyQzr0xTPe+mIrHFCcC0DWL0yBbS3qUdKlMukbrsZNg1gUsavql/tOV4R2B5AcXl2KNzDMe1tCm3e6yzQ1Sj0HzkHjpoVQhL470bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824914; c=relaxed/simple;
	bh=MXTMO/9Ut/mep5/XevXAMY1Csd241Eiswlq6bwAF26s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BhL/BLcp6lxAPwsxUoOjbHQHAei3NFsPFH3k3JnRZNkP+LYYy+G0vgAIC+nmICI52AmXZrp2i128KfxF68ZecSOJV1QSmw+vqRHRfovXEPRKkeLaFHiucY8nQzARNzLwIVTYBbRFSIFSiYq6JLUKjExuYQS0lzyUtj4XHJ3rpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CKpWdOXX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so25491205e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746824910; x=1747429710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fV5sNRyGGzlBgi9UTBfeQUdSiPaoKTbIEiwxSLBDTFU=;
        b=CKpWdOXXOhP2Vcn0uuKPch+HSnyZsKIDx2bIxKHsOtoiGTj6nKTgNNcR4Ub+WrssaV
         5vgl+G2xlGA1i9CGOfV0Qnt+Bdc5OZpj2Xdv9x4EO/RRTWFq76oV2htwyP/JmdI7uMj+
         y0VkU3HPhcNM5f1O1KoctGKknUUurAYhbgvb9uURznKt8DfcpGDUVoyCJxwvon7JoA6q
         Db1D0Ujj3AqkgOjnmHqBN8UHrBd29hXkDApsiZlF0YbBuASDcpBVufGSDOFJz2hgACA2
         X4xwE/mW6o80jzloQQETw6Hux9VSEyvi+p5xR1wZ0lx5YjLSFTL/DdAQql14pff+q5+b
         Qr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746824910; x=1747429710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fV5sNRyGGzlBgi9UTBfeQUdSiPaoKTbIEiwxSLBDTFU=;
        b=TU5jH/eZOTcfJwHXyyd/ayVUWQ7MKQ/atsgVR0MVontDcuU4bZ16hN7iObx4dJbu9B
         umOAE4EYoRRmtzRvD8wnr9QOfnIs5toZAIh4Gf+Yr/ZEBb8PC/8jhAlS1F9N3sSOKLeA
         CfLU4/x51uDqq/fl5cffoH17tOVgcbQxWawxXYx1RdlhIHhGclSmNhPgZYMfxD/GXoLw
         da2svDJp/NowRqtaJpTKWEt6s+tJQJyuljOQk2bcnOwVwaEvNm0T/1OCTEzZKIB7QHI0
         dmQjaskWzRQiE0dFrPrjUdatrzAVHl5o3KfEaHIliLv0znKcQR0dBdbWuVuWFWmw9nB5
         QfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJdGOXz5gRs/vRvHLjQrHmMvdzBheNjpcW0h9sjATsTa+lzNmQG4WzdR0oTMxOFd42Ha/a53ukOfPJRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywKkeMQS6/BobH7OhRb6PUHj+0pwTSlEdtpMMjEnEW0hwHQ5Hs
	LUC/E5NcN8Lc+U7n40qqk0VJJX/8Y6mA9Q6ggPE23P04HCGvDgXGV2fEYMu+3j8=
X-Gm-Gg: ASbGnctJVZaxlIQd3iCWugpMtg1rH1TJaXn50F42ofD9FcLykhBciYQnmN3aHSXKn1d
	qHt4QjSf+5Gfvvv0nbvPMCUVb0qcGwjWtFR7hXVfUnjCd5FGAK/2MVNr+/XoboBLiuDVE7xHxYZ
	FI9jf0aF0GeVKefNW+XfFsaHRj7rWKJIkQlLCvfkOqhplV+2OXmieDW/EwT3YyiqVAhqJISsQEI
	W5pOBQmWUUwJOP7xKUzrSXP6CQVTs2gmSiNU9ywXW4rQ2Z570P5jtldZ1GxhXZ5qOC1mWkrb3Uu
	iDLiv4jbC/jDDEIMwdcPgPpNFIMe16MUhqtXu35jaAsp4UIpF9Vx0YhESRYOiPqHAUolfpXUOwc
	4gLk=
X-Google-Smtp-Source: AGHT+IFeJMmfyORrc3PeL0189Tp3SewR0gM8eLxNaDLxHn3oLFly1Bfu2qA0ctrbXOqm66tE/7oAeg==
X-Received: by 2002:a05:6000:22c2:b0:3a0:9a02:565a with SMTP id ffacd0b85a97d-3a0b98fcd90mr7220880f8f.3.1746824909762;
        Fri, 09 May 2025 14:08:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82c0210sm21638405ad.253.2025.05.09.14.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 14:08:29 -0700 (PDT)
Message-ID: <1397dae4-d022-4418-b5b1-6b0119cd7135@suse.com>
Date: Sat, 10 May 2025 06:38:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove superfluous return value check at
 btrfs_dio_iomap_begin()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <77971c6472d403679457a3d241e4c70df45eff4c.1746808801.git.fdmanana@suse.com>
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
In-Reply-To: <77971c6472d403679457a3d241e4c70df45eff4c.1746808801.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/10 02:35, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the if statement that checks the return value from
> btrfs_check_data_free_space(), there's no point to check if 'ret' is not
> zero in the else branch, since the main if branch checked that it's zero,
> so in the else branch it necessarily has a non-zero value.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/direct-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 546410c8fac0..fe9a4bd7e6e6 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -439,8 +439,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   						  start, data_alloc_len, false);
>   		if (!ret)
>   			dio_data->data_space_reserved = true;
> -		else if (ret && !(BTRFS_I(inode)->flags &
> -				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
> +		else if (!(BTRFS_I(inode)->flags &
> +			   (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
>   			goto err;
>   	}
>   


