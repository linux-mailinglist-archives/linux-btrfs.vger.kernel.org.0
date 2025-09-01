Return-Path: <linux-btrfs+bounces-16557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD7B3DC58
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26C37A1673
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F02F39A3;
	Mon,  1 Sep 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fpb1GfAn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAB259C9C
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715338; cv=none; b=orozHzwinanlJJR5QAsgoj7uxE1CPlkAGBXmbqjq2Z/oM3U14zOYIedCuyPhTK96DaHxxF859dHRAyD9curEiCOAOj9i1bWHlaC+w9s/EjBVjixZvzKMCWIr82Cuou+QH+e2kxwg8oF4PhSeCx4JMxO5GqlMH8d4egaQOEaI39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715338; c=relaxed/simple;
	bh=r7jUTa/qP2c35jWmfPD/5JaT3ao8SZPp8Z19wK2Gwxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bG2FykKlqL6ljx7tglHGQbzjNvhT+IZUHWysIUvLWWjBrJPGaib3V6WEITNWMdHkaO0RKkZ5D/3Q7GQyAIh0iBZ7D77VE4OgBCT2oQi/OBtLpp7nE9JLOQBo9hq/N66mGj0Xe9lZZfQXUCoYfLZaGDuCoZRHhYvOm/o37xVboW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fpb1GfAn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d1bf79d6afso1247993f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Sep 2025 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756715334; x=1757320134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cCmsMFt6Dzmp2yYk1YbAPQ6XtbvsG71RTflB9X+IyG8=;
        b=fpb1GfAnKvejd+nqLaOWuh06HmYE93hvw1acpyIXINxXunJYro249ufEDPtJql7JyR
         MOyf4kO8VG+hJiDyRHiJ3PHFxSAvx785pDvcIY3iLU6HYBSopVUIWjp6og4bHMDz1e77
         ebpGxQSoCMbt8OjRj6BkKb3hMMziHynnvtIaK1EGWX79PcH/N9vUAlN8V9ff1WHEqNDG
         V+GJ4X50XLIdZ+cJDqrk6MEn8jpBdQzuIzFkFgoQ9S1KDgd+Z8l+mx62SyenRY7kKQXk
         WelF7zuIMCswfhEaJKOPGL3s1VP6ZxzLmLgzpckvJ9seH9TvjN3yWsDJBhNYqOZFR9tp
         Zc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715334; x=1757320134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCmsMFt6Dzmp2yYk1YbAPQ6XtbvsG71RTflB9X+IyG8=;
        b=XmXflD6iTrnSMDlpPd75vtFhezry30J953vrdmnj/pr4N9k20tAt/m3UKhjIEn1lrA
         szwZn/SV6r16UGZ7OYEzAJrlL/zDlMXAOUBBdIf1SOuV2GjiYH5fCdPW51Sc6FwSOzo8
         vvXLRGamTlHtwR74czYtuGIi16J0aTSY7U2QEu1P0jOH7PyCf4+mIRKKayE5G9PnR2V0
         N/Na4KQsQGaiw76fDOah3LtHy4ZRq1B6SiI87EKw+A646zwc1CVCa5TW9182Hrac9k98
         5P6alASrjDMreYz668/+pOxlr/WAQLxGeUJ/Pm/tT2ysz98BJNNl1cENIIyT/FSrssK/
         MvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqvYIWRu4XKbICPZuauhQuv1cJIpExyig1BjjgRQPYqEnFuxm0PytR1pBU9lV243RAlyhWMnNcQ8r6sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdx7kGVgHnsDlng2UkbRusL+XLrBUcTML6K1FzjZJK4hLOSRD
	I2FHQuJYZHSeQ09cSmLHhsojr3PWe9NChTcxqag/IEEiOzSV5Wih+RjkXebJS3a8+Hf0Caa9MDw
	LC2ZT
X-Gm-Gg: ASbGncstQhC6MeeTQe49COYoEFdI5F38FjJurOs7UcTnuFWKdh10ucyDi2aFM5I79mj
	xQ9jd7N8jSVpw0eoTW4sCjLVdurkhQ63XX+L6FI7EoWiQC/SYakqRXb7umlqUt5nTo8FZUHiep8
	8GkUd5Xlq4mrOXtOsY1jtl2EIC6APpT5Mouu+5IgH4Iy0jlw7xpIIBkW6c/VAOjuDELDKeo4sdw
	JuzZaZVeN8qWWYsTNEXdFvLlOXUCer9O2PpeVSYSvOB79/kEifgTBaksQmy2L5GygCNBeGconyv
	zaL6B/sKBDJAEuMwEVB4Lqu48sC814m0MQAGwYNKdhJ42Rni8s0JPSDRDGbZ3M53GYN1/HmRpZ5
	DcRK6Gaf5nYdvCiKKiacQipT2x90lL/7AY0YkHFJr2m0zTH3NvRnCvrBWKgu70w==
X-Google-Smtp-Source: AGHT+IEA+XgfshFBiNgLqWsPodLRieqxfienv4joPrIJ8xuWT5eDmuZ2G8zywz14mGEUA9N0IxqwAw==
X-Received: by 2002:a05:6000:23c4:b0:3cd:14be:6937 with SMTP id ffacd0b85a97d-3d1dfa19a58mr3686811f8f.36.1756715334081;
        Mon, 01 Sep 2025 01:28:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeec547sm10510811a91.28.2025.09.01.01.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:28:53 -0700 (PDT)
Message-ID: <7e86289e-aeef-4ecc-999d-ac79778863b4@suse.com>
Date: Mon, 1 Sep 2025 17:58:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: recow strip tree as well
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com
References: <20250901073826.2776351-1-naohiro.aota@wdc.com>
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
In-Reply-To: <20250901073826.2776351-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/1 17:08, Naohiro Aota 写道:
> We need to recow the stripe tree as well. If not, we leave the tree node in
> the temporally SINGLE profile block group, and we cannot remove that SINGLE
> metadata block group.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Can we add a test case inside btrfs-progs? IIRC regular mkfs with DUP 
metadata and rst should be enough to trigger it.

Thanks,
Qu

> ---
>   mkfs/main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f0d2e42421e6..34a4ee4fd6db 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -337,6 +337,11 @@ static int recow_roots(struct btrfs_trans_handle *trans,
>   		if (ret)
>   			return ret;
>           }
> +	if (btrfs_fs_incompat(info, RAID_STRIPE_TREE)) {
> +		ret = __recow_root(trans, info->stripe_root);
> +		if (ret)
> +			return ret;
> +	}
>   	ret = recow_global_roots(trans);
>   	if (ret)
>   		return ret;


