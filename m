Return-Path: <linux-btrfs+bounces-15057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A122DAEC4F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 06:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B53316DB05
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 04:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6A1A2541;
	Sat, 28 Jun 2025 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vhv2pZ1+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519981720
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086092; cv=none; b=UF7kQ8WnMaB/Up/VoQwPdBWF1X5hcbURoZw7TUDl28jtsQDSkbTonj/x7x6JP2W1TwDmwLqIQObJXzY1xf5Jr6pPqWgZcJuMdOmvLziEyySwBN8Z2FHyd5pjXcx9Z0RTF9pz0Kz0Qn3SApbLTceMZBw2di/0jyoXSwynQpAn/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086092; c=relaxed/simple;
	bh=B5Pn09+Ho8sZg1JGFA1Exg0+AmzzKLgmb9GeiTazc10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtOl8TJt5ct4gdOLWnJOraqe9Tvbi/MF1nXusxSA4xloOBMqvplBccf9qXCiyBACqdb9xwKEyp9bCnDXqoElpf6TTcipmON41+Bq+BDhW+k/Bl4GUR/upT9JT3FD4xoccucSaoS7VL09AuXG+PjWe5TTsEYIUrFpCQf16wEH7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vhv2pZ1+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1530638f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751086088; x=1751690888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3pOdb7vkaoZ2ojSybxNJlVg/xXJ4xkyAki8K90GztNY=;
        b=Vhv2pZ1+OMGBl/iPzhgvJ9SH6wj8iVMhrP/CFqEONMyyohX25OmEbJPX3OT3mdeRgu
         2wgCCvxKSYAQpyQtEinZ6E2lIl2JZJXlkOk5fajjxrIoipVMyUiXIJlKcM8WGgj7LwU7
         ITWTvk59Ncb7M8DEiXt2dYUOpkfN/143FQTfeUwf8Nfmyb16Vlb3CltI7wqw3ay2bGB2
         MQQUssWk3pBw/iojs5az/FhuF9HEn3om3v46NfSlG8OXeEXtcX63qag+QQXLttVwJHND
         x3jZYbcFSloG/gDJoAQFt2GX0yWSxT4nkmnfO3q+kdZJFQz8E0fWKJ4OgfJpn9aRNNlU
         r9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086088; x=1751690888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pOdb7vkaoZ2ojSybxNJlVg/xXJ4xkyAki8K90GztNY=;
        b=dRMoYlZcJmJQOKGK4rUrygGbiNGmqLIE53V3b1/YnBYPC8FOE+5qs54KyvNcCOVf1z
         dS9fhMcTQQJuW06R8K+wcADIWFgjiv0mYOBleo6Gm3sGqxOVjmL9l1x+LLMc+TqWS4fQ
         VBmx1nxGTsnkb0uG3jKiv7Yznn0DP7ScnW8jPKbmIpIpg31PYitOamBBJS8fsr1U4oOl
         l77CDxadtvNOgXXcBBSiWQlv+CPeMo6c4Z5peYG7XiRhQ7lQpINOyXXVljvez4nmm2I/
         fG1mG+Ok/mQ3frKt6xkJFwebmmrei0DtCP4+lzXuRnhWuISp2dLnPwXOybienBf2/nL+
         Yskg==
X-Gm-Message-State: AOJu0YzmKccQVX8sZQjVlcAzx53yoq7wKMXjgHzVU6dZWs2jcD3Z/OgZ
	Ten7hkc0gIL97pjRRqkbSAwkRvWYL+3k6HlgSppKQhrRF4j3ikSP49PqIlI38XAvcIU=
X-Gm-Gg: ASbGncufe2YmaRPoenwTPD0sW3f3svZnQyKd3XJ3Jl3WGumwOmv0btBzxsP4yCtwT3m
	s1g4If/HvwJ3N0EaW4K8jG6oiUbYeoBvGTkWZCZb9n6cyd0GB2fE99DZdqgd7BS6c7Ed3p/n+g6
	ATov1zz7bGV+vQdQO22y8G5hVfvfAyvLxyjesGdzTZC+bB5dxOt39Oea274fpUb5vYMJrfk4uFx
	bRLQJKFxm6Ubk7bICYB0hd2pqQJqYPxXcNntvHUlQsn9ZmVunVFDieukKLvn4odj7SrmrYaeUw9
	p17C7OhLzLTuuZWiDBntrpWWZ3L77U0pJzbFFBMBOKNCZ5MhTMI1q74FmgAOkX3MiTQQMMZ/84S
	y2PEIXC+38AeMrgeKvV/DVI61
X-Google-Smtp-Source: AGHT+IG6RY6s9pOfviGEaWn8f+6ILurq5R+1HmPSqY8/p4o3Ed04Mq5knETyuC0AKQCAM+bmp7yXNA==
X-Received: by 2002:a5d:5f55:0:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3a90b8c9779mr5849874f8f.57.1751086088127;
        Fri, 27 Jun 2025 21:48:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f2183sm30874435ad.75.2025.06.27.21.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 21:48:07 -0700 (PDT)
Message-ID: <669773b7-4428-43ca-ab80-d7ed1c71886c@suse.com>
Date: Sat, 28 Jun 2025 14:18:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace nested usage of min & max with clamp in
 btrfs_compress_set_level()
To: George Hu <integral@archlinux.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250628043235.29900-1-integral@archlinux.org>
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
In-Reply-To: <20250628043235.29900-1-integral@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/28 14:02, George Hu 写道:
> Refactor the btrfs_compress_set_level() function by replacing the
> nested usage of min() and max() macro with clamp() to simplify the
> code and improve readability.

Can you please only touch the "level != 0" branch using clamp()?

With a not-that-short expression used in the conditional operator, I do 
not think the final result is easier to read.

Thanks,
Qu

> 
> Signed-off-by: George Hu <integral@archlinux.org>
> ---
>   fs/btrfs/compression.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48d07939fee4..662736d94814 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -972,12 +972,7 @@ static int btrfs_compress_set_level(unsigned int type, int level)
>   {
>   	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
>   
> -	if (level == 0)
> -		level = ops->default_level;
> -	else
> -		level = min(max(level, ops->min_level), ops->max_level);
> -
> -	return level;
> +	return level == 0 ? ops->default_level : clamp(level, ops->min_level, ops->max_level);
>   }
>   
>   /*


