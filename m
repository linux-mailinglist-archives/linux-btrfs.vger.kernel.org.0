Return-Path: <linux-btrfs+bounces-14882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC5AE53ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 23:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E6F3B730F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABB32222CC;
	Mon, 23 Jun 2025 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XDz9ReiC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97173FB1B
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715824; cv=none; b=k51cIJuE0lbdqBSDIv4KRoGOCEfOifuhNdvp2MW2g5oNUIsSSVKiuOo6g8AhqfXf7ItSPGpjkns9xXRy6H6nvEsbJGseNrchaOxj5h+EPdIvRTG+NB/JzqC3/HSb1FVwyABaZbHRbdAIO2qJ0R/b+W9FSc9XDEfXJ/jJOGrn0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715824; c=relaxed/simple;
	bh=+wDeB8/K1kb8baLCA7eDx4avQvCQRYEZfdyr7buzynY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jknrqv7otlLZLhk74bBCwnQQSTkeK/narcYDG6WCXIYC1q2deWWrmPwsx/MeutB/zL/jMqHu+WrOfql+V2b1UaI6a72ScVSNe5DqJYUha6lWne7t4CD/+ZJnYXdUNX4beG5ij3AtKk+eNEc+r7LIqRg2ukuZt8WV3iKLC/HIixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XDz9ReiC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a463so2584212f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750715821; x=1751320621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3F4Bwjew0sxrMlKQ/0tZSDDMaaPsRLzO++G95lMbAnA=;
        b=XDz9ReiCuT/mpMo4NJlMeOyLxwY6nMiOsGoYZaCI1J/dNRwh+T2suY1jIVG4sfC3c2
         kSlX1xEV2EpH1DjO2YzWmRBMgUyNBwyEv42JNGdoMtBt84YIBTt/tR6lZr/lPCDzC5vd
         mSgXH63sUXDQoGU60srkRhEltcWqIn5XcIdbe9ILrlNWrEZl1I5XrGDmmmuH8+XoKtqj
         4wmvz52n/a2AmbmXx2uYx/5CU2DkE9/1uy+30NK58xQb2o0JrJ64M+jytxSWVh2yf5s1
         xgiQ3PkADgZyeidVMKkSgGq8x18IaOTk2F9HeKIirAymUYC5+YWjOWnSxnPFPpRut1ki
         7XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715821; x=1751320621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F4Bwjew0sxrMlKQ/0tZSDDMaaPsRLzO++G95lMbAnA=;
        b=Sv1IEfYEX3dpYsjZiAFI3t2fNa2Q+Wk6/GgB5ryATnsGlCTCTtgkcsv4zyD6PBb5Vg
         KagpXKe/3qGPh9dYn9XbRciRGDkkATe9Kfyj5L3We5O9PpG3Nbne9pXHJkP8JIVzt+kG
         nlRSr3qjAOmINHFQmb7woQuBqCv8dBolvewTNE/SCkXLUYIIdZCOaBcFeltVSwGLSNTy
         SzB2WFXa2IuTp9wgwkVHOd2K4SwMsqQ+I1wXnw+SmRulPpbAaqYkv6+J8z/beorhsz1y
         Tpic26bdnQ/Zdn1UD2hAb4rV8Y50dfVCR+0nEQKcAXi9o8f2/ISoAztrcW0fnb1B2eUY
         Er9A==
X-Gm-Message-State: AOJu0YyrvsLVHudrJ1MlssWejinjyzRUH4HEHAy8KmENMz0Qz+8ZViVo
	CPiuXVfnHKPfLL3nVRq2u8C9Zf7mB5mXpjWStMdJcM8Xe70vEjsDjF35jDz7ouHe13E=
X-Gm-Gg: ASbGnctdTzmHRBnun6dDEiHB9XfFqIuuo3+Hb4w6Aq6hfGZt90wENqVnsnwvOX995Sb
	5BvahOvOQC/inockCRLBJysrDtXn0ygBmmc6jrQYlPQE+xBfuOX44VesP5pHvTs68E8mwrbkbXp
	wje3BTpEdFEmwpHj7uP+ky7/ItUThcWGCqDrMg0y3VWuWtNYuPwyqKJ+skaAwsVGCnEUwCGWfSb
	1IPr7CyYUPuqLbh6GdXJDvNvdB7LjnO26Oo6lhWpZwK4Ocg5B/d65pyN6GWy8LR+P0rQ7hpRZdf
	LrDhPFqm30ERSoh7kDwWCeE3ABrl7yDMY86sTrXQVNkvnAvJldjxea/d/yULobSSlGW2GwJoQw8
	zcUY8FrQFZKKqBQ==
X-Google-Smtp-Source: AGHT+IFZOZVNxfLCGHzI6TnJuIl7PiXI1yHyVrn1O9iN/Y5l82mkL2b7lb+UQ+fEvV97Liz8g4mCqg==
X-Received: by 2002:a05:6000:240c:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3a6e721c7famr774789f8f.29.1750715820721;
        Mon, 23 Jun 2025 14:57:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08d1csm141527b3a.13.2025.06.23.14.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 14:57:00 -0700 (PDT)
Message-ID: <450c2d17-8cda-4dc3-98eb-2c6a3f3b19ab@suse.com>
Date: Tue, 24 Jun 2025 07:26:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] btrfs: add comments to make super block creation
 more clear
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1750674924.git.wqu@suse.com>
 <c86ee5c7e8588b9755c66f6827dc5087de2fd910.1750674924.git.wqu@suse.com>
 <20250623151028.GB28944@twin.jikos.cz>
 <ade587d5-886b-42fb-be8d-1cef4486326d@gmx.com>
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
In-Reply-To: <ade587d5-886b-42fb-be8d-1cef4486326d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/24 06:53, Qu Wenruo 写道:
> 
> 
> 在 2025/6/24 00:40, David Sterba 写道:
>> On Mon, Jun 23, 2025 at 08:16:47PM +0930, Qu Wenruo wrote:
>>> @@ -1894,6 +1885,20 @@ static int btrfs_get_tree_super(struct 
>>> fs_context *fc)
>>>       set_device_specific_options(fs_info);
>>>       if (sb->s_root) {
>>> +        /*
>>> +         * Not the first mount of the fs thus got an existing super 
>>> block.
>>> +         *
>>> +         * Will reuse the returned super block, fs_info and fs_devices.
>>> +         */
>>> +        ASSERT(fc->s_fs_info == fs_info);
>>> +
>>> +        /*
>>> +         * fc->s_fs_info is not touched and will be later freed by
>>> +         * put_fs_context() through btrfs_free_fs_context().
>>> +         *
>>
>> There's a trailing space and this breaks 'git am' checks, and the line
>> is also in other 2-3 patches. It's a bit annoying to fix manually,
>> please fix it and resend.
>>
> 
> Weird, checkpatch doesn't give me warning during commit hooks.
> 
> And that's the only tailing white space exposed by standalone checkpatch 
> run.
> 
> Mind to share where the other tailing spaces are?

OK, there are 3 patches touching the comment are causing conflicts.

Will get it fixed here and resend.

Thanks,
Qu

> 
> Thanks,
> Qu


