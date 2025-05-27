Return-Path: <linux-btrfs+bounces-14261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D3AC5CD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C5F1BA6EEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF620A5D6;
	Tue, 27 May 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LihQowat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641B1A08A6
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384196; cv=none; b=kOm56ZUkY9d2dt8LedgofMdvAAb1/k+6RfVYvxFnOWbZR2WGtToYjqf5A/dQsaZq4WJ53HsD5kfng4heMTrpfGwb6Fe38DVa2NHreEtUDOHMHyC0y4wHbHfZz8I0Bsks2zzn0scqwOTbQDu1D9Ta/btZE5JNpVsV0kyV6UFh3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384196; c=relaxed/simple;
	bh=heMDwyG03mt6u/8diRqokEJjAy9NydlIrBZHGR0WynM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uI5trDnsCqjmYcJZEiFJ8D7lTNsw3gY0uaJXDQVYFtjsBsASgMnHFUQ4AyMjqsT89a4VsD+LbBdiT4LtUCEfCGFrU6ipTqNC+YlsfG0G1/CQViiwvjarV3eIQlMjy0OuZiLe+1qligQ5SmVjZBWL7LH5C1Y+//iM40VWxxnpRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LihQowat; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so36292255e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748384192; x=1748988992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pQIdSyw4CnQgbqiDyyu7UU6QktQuGR0b7ypXAEqxs/8=;
        b=LihQowateN5Iz3RDJDWZcB5Fnocio+4r94dlo2TnnFINHk2aRfcL9S5O/XRI8jFtGu
         OrjoPNmymxksXOaOyaq/UJ1XAqswnAwjkId1oYMBTrFvBNlLHaQu6kzmyCGMnRsO1kde
         f5uqe74OZgPWEg04BJrvz2cDZsm7JRoVGDCmi5rsrbXZ7sbP+24ihzwsQsoe2NRt3zm6
         eydqt+zYb4ubAx/wu8l1O3U0OWUJaVUTC+G1KN9gXIFYYONjIKh7nimLw0e8yfVJCqpv
         FCvKEKBxCs+F0X+s6hxXYldXbFVEbsZy1FUmluTY968Sd6PfC0nJbep+nJL+lhTgEpdc
         7mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384192; x=1748988992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQIdSyw4CnQgbqiDyyu7UU6QktQuGR0b7ypXAEqxs/8=;
        b=MbGAh0aIO/qNJKk2jgpRgt3l52M8HoFzb25NylpVx1PrQJaZEYRrl2d2l1cM/pZEEW
         1ABv2nRUMv+/b4Gw52tm6Wzx5Gy49nrCM+2K7hfM7ptPmOsVGuPV55uZHmtmmFXtsoXI
         tYZWUZAw7lIU9MoZXeROe2esaax/XvA1XLU0SVS3tgh0gU3uX0h9tkwKXaZRc1rMpZNZ
         p8lfQF2wac+zs9n2n8hEl8f3K61i0nUH4MfvPnKtwIl/F3LY+lvmAuZq3EO4Eg5DZnOE
         cAjkqpTKisw+vwbY/mwEFWKgFWhUeTG2InOD2nYRO/aIkLTi4wpAWlTYVJ8TRhtYlNid
         QvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq/u4LAOLq0jQhBY3IDD98wAhmU3QoL3va9wkAW6eWbaOKjvF0+8oOrd3Pam1TDxVZFFMmWGn4xa4D3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPET7WVUeUylC3lqxV4IcVv4p8qb/ZiA/SgzCH+ijKj1iSR4E
	7cPW5GwKRtZgBEXnFW5gDyAxSue6q8Y9ngBzIeeLWsunjENlKC0mXXvjqOV6umiyp6c=
X-Gm-Gg: ASbGncvItav6CWJufrf0DF0Ziks8AvQtGF7+5PWi6syMifH8P1+2wtdQYIDlPoWL/m7
	0dMMBHUGvhC2lSeizDdZjs+Q5EMC4xIKshOQsWMNT23wHIBtV8S9QwFrTaybxqwC3WCo1sHBLx3
	ZoOALTWwoeWSnFCOsidTfZE1jDxkN4coLCmpDoOWzO1qeOdxeG78bQBJgw+Py586YtTegryU6bj
	wTQ9UQL8xUkbbUqSfBCuD0hc4wjZCioKn8EGAYjkQzrmP8/Fl3Hx8IGWA6K6SZGpchGIa7bIRwS
	KzcnW6ctbx0X8If95pibsK9dNSz/Bcj1wVWR8q8p87DSiC6tFWiHsmrmG4pQgc9KfU0jpaRbw4d
	HAnv5ii3iyUMWsQ==
X-Google-Smtp-Source: AGHT+IEadGd2KVXoL6V1wFvp0tN8VImKLleqIq/ouRaBjpvBuQnYeOyg9D03kpusQdLmEypa3DBV+g==
X-Received: by 2002:a05:6000:3103:b0:3a4:c81:a075 with SMTP id ffacd0b85a97d-3a4cb49dde4mr11116208f8f.45.1748384192116;
        Tue, 27 May 2025 15:16:32 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7465e648986sm85539b3a.7.2025.05.27.15.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:16:31 -0700 (PDT)
Message-ID: <aa0db803-55b9-422f-a2c4-977ed93b92eb@suse.com>
Date: Wed, 28 May 2025 07:46:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: fix refcount leak in debug assertion
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1748373059.git.loemra.dev@gmail.com>
 <1696139274b2bd4327c008ed6df6f58cb5a8569e.1748373059.git.loemra.dev@gmail.com>
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
In-Reply-To: <1696139274b2bd4327c008ed6df6f58cb5a8569e.1748373059.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/28 04:58, Leo Martins 写道:
> If the delayed_root is not empty we are increasing the number of
> references to a delayed_node without decreasing it, causing a leak.
> Fix by decrementing the delayed_node reference count.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>   fs/btrfs/delayed-inode.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c7cc24a5dd5e..f4e47bfc603b 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1377,7 +1377,12 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
>   
>   void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
>   {
> -	WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));
> +	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
> +
> +	WARN_ON(node);
> +
> +	if (node)

Just like what Filipe has pointed out, one line "if (WARN_ON(node))" 
will be good enough.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> +		refcount_dec(&node->refs);
>   }
>   
>   static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)


