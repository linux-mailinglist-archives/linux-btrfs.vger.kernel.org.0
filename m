Return-Path: <linux-btrfs+bounces-12207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745F4A5D1B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 22:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F143B3C26
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD30264A87;
	Tue, 11 Mar 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RiNhOKG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981E264A7E
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728325; cv=none; b=MEG8acml0iCKfNGXlC47MBgHuwybhSVq6/ID+Si6CI47DpWH+D+BL8500YZ+vlWTKP6v7HE4P3/izZLw84FqIzeRKUmXqxDMMmrBe6aHiFSIrrt7r7r8wgq+tISyyjv6Q2r1kc9dO4R9j5IAxEWZJulcLY5sK3Zbq3ib5ab23Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728325; c=relaxed/simple;
	bh=jIbQyReptliY/rQpv8m4MGXgD6egq7IVxGiQe3tDfrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pq+vjN8DNqwh5RC85pxFvJjQoG1C5QtrCEgiBTVaA7h8AHiUkOmb0zy7P1kVtSffeQR4AjJXxs/SO8wpXk6bjS9QA++yKASMIuJY05zql4yGP4KYLAt1fhtBRyIKDqDXQWVqHe+7JwvfWKuOf+1CX4how8yiWSFyL4oSOSXw+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RiNhOKG2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f403edb4eso3287096f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741728322; x=1742333122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NfjDQTibouecQnOL2rDVTBTr+PSiJSzX53iIR5TzWT4=;
        b=RiNhOKG24S/WtQAoGJhUfCcsnJwk9TUBpsxx6ji13b3/bodoFXEXvBXfJIBzn/ns9D
         iSdNiL0hAYQvJEIi9Tvxcx3XRUsxKtHjJY1I1kqRQ4dqduAf5CA1AhM9h+hvNl2fOvW6
         44GoiG/ZmE6IiIA6fski70XrkDLlgjH4GR9p5aZfJamQ3Kl/X413bzJXyYXAW28Wd3CP
         UL3jz2StTX+232eGD29PJxRA0jDpLIWMKVSbMO7JjfvKmh2DaPJKo0FQBMF/Bqsrj8Ko
         LMP7v3/h89zi4FKhajjYIXQx9K00/ccg7bvvy2mq6t+RaITdpErTnw4/XY+cWCnbcSE4
         FHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741728322; x=1742333122;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfjDQTibouecQnOL2rDVTBTr+PSiJSzX53iIR5TzWT4=;
        b=RCpeSBsJgyxDsxb+1xMzDAXtUWKciJyVylIMMi7Vta1eSJkB71aBFL9ut9xoh8Vvog
         810XhxkEeT7nBSQAh7CtW0lQ+VkzX1cr1R0A1J0j3zecRMnKa8Nmb9tsAU1zjw7vzGuB
         V4ZavdMg9auSiggeYGG1mEtkC0lapsIidQXaHGj6FFx277r5Bnx/AYnIkd/4Xtjc1Vyh
         94xwb4Ua0AkDEpMoIPBqcaqm30kHolSJ4diP2AcpBgdq/S74dNtNawe0ttDiAlCIf3a7
         4GQ7piiiRcUaBSkd6/aWSxPKZOdID0eImbsCWnhRCWR/Id4mFCgx88F+S9SQD3VJlQTv
         Fs7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvoxX0/opzDqlYa0lBVbD/jmEFke6gzffkoPULYQ7ai+lwDP/57K0VwxaDhzaHGUYBR/JAUyIr0pI7mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ibb4jsKEaALNzBORgd5oXXLaz5bGqHADEN3dDwnK8Vw1Gc89
	kZuocaMy/EdGW1KuvIlp0KV4k3pxQrjQSSdQJeuR0GfgMfTjfPShlYzgzc0s0PFp4uVU9dsiLp7
	B
X-Gm-Gg: ASbGncsr6I1XFRk+szywArNHMsjz/tbWOVsgw///iyfQsX22wAfgvS7cK3QyXr9NKb3
	IIfCMaA+VP67WViCuCcjqKRTRAr1lJ9zWaa8aQjGKmZUOOjPeYO2xWdeSi0gSEupcdu6ugEfN3v
	JpMbWhvzlmCXOmBrr0d20f5SI0ykPrqjE+Y4Wa2CQcMZI4/VNGKuzGdVCBxI4kgVaQHWGHDN3z9
	HXzy4m+Ou2bPu0JMG7bNtogut0u0p3o+tcGgsDBZd1Iy50ULq5cvifmU1WMQ5mEBiReezRiEfwQ
	ceBmz1gSbeD45c/mylDWKPwS6/WLNx0xMkJAmSRK2WGcDZY4GBb35UwNeYbd0KyIy8jRY8f5
X-Google-Smtp-Source: AGHT+IFYZl7cuz4wvvGJK+r++d1wC4XDuf2ABys64TVzQlqie7ynMEYfbQKoEhFxBCNVczplulCI8g==
X-Received: by 2002:a05:6000:18a7:b0:391:40bd:6222 with SMTP id ffacd0b85a97d-39140bd638bmr11618118f8f.22.1741728321779;
        Tue, 11 Mar 2025 14:25:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ef3a05c7sm2111745b3a.92.2025.03.11.14.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:25:21 -0700 (PDT)
Message-ID: <79938ae8-eb2b-45da-af35-d4e63e09064c@suse.com>
Date: Wed, 12 Mar 2025 07:55:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tests: fix chunk map leak after failure to add it
 to the tree
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f05862e33146ef046f6d377b8b2663b69f2c2e84.1741709026.git.fdmanana@suse.com>
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
In-Reply-To: <f05862e33146ef046f6d377b8b2663b69f2c2e84.1741709026.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/12 02:36, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fail to add the chunk map to the fs mapping tree we exit
> test_rmap_block() without freeing the chunk map. Fix this by adding a
> call to btrfs_free_chunk_map() before exiting the test function if the
> call to btrfs_add_chunk_map() failed.
> 
> Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tests/extent-map-tests.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index 56e61ac1cc64..609bb6c9c087 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -1045,6 +1045,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
>   	ret = btrfs_add_chunk_map(fs_info, map);
>   	if (ret) {
>   		test_err("error adding chunk map to mapping tree");
> +		btrfs_free_chunk_map(map);
>   		goto out_free;
>   	}
>   


