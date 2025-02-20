Return-Path: <linux-btrfs+bounces-11603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F1FA3D17C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 07:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED8716C649
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CC1E3793;
	Thu, 20 Feb 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tge4Ovco"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9331C5D5E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033784; cv=none; b=VXa97dWzn8D+2233uRRxnawIjYJWQ1xF/Z8QZIB/Q/Bs8QrpNgobR9+W3OvrwtKmrDHPmcnD39+gg4y6QL+oM4SO/nW11clKJMxel1aPP08JQ4Gc799k+K9CP2hN3SKs7gIGvcFKlJv8U8+PlUlwK8IgTUZZhz/MMIZz748cCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033784; c=relaxed/simple;
	bh=Eokg2V3Yvp2KSEhFD5KjBl02HUTMrmJ4lXkAdk8qm8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpTvjYJRrnP5dQeJ//b/8wfyfPRuZHg3o/3gbQR+i8YxyAcEwtG0FIZTUoryuXVQWON/ARBE13Ev/tLziB3mwrx2gLd3XDdvYD8s2DM7g9xbMhLo2OjqZSu9sY+5f2UgnVVEeZtNsZ9yPnB2bVz9rY68UDcJeSd7h9OUGaTm3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tge4Ovco; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f5fc33602so302153f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 22:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740033780; x=1740638580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zTuDDf5qpxS8YpPXcwb6yMNEAv+LYFNJ0jetRHnbsXA=;
        b=Tge4Ovcotz1HEOdb4+wwV4xmGZ4f1vs6w6dT+rW7OywhaRbNLOIfI1TpyKVzQXVAba
         rL3nvvU59WTpn+X9pps9bmgwkhobx5cYPQ7H86ajPRgEmZeeWeKPcf13tZB7xFJlPLvx
         xQ24BziKBwDgMUxqwNxQ8QlQRFeT63WuYXveZOGqRJ7GoiNmdTkhdPnFjKaiR+NXpfTT
         wsghjzCAg4t81g8+Nhft3RUmVlEnyslQXK8XiOyIcOmzdIRjAj/X8qo9ssNF0AVdjKXO
         lAt6cOhtmI3b6YS9RgOrAta38WX3tmWx8LW5tE7AUyaWGFgP6BobWJ/KCKe052UxbKXw
         SagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033780; x=1740638580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTuDDf5qpxS8YpPXcwb6yMNEAv+LYFNJ0jetRHnbsXA=;
        b=l58/t/ha5F/IVRS36I4uZRlh/iCljJrQTPE+Uw2jSYJAufGyjzUkICggo9TA8eAoa1
         Krm3zGLXUFcvuHWItJ+lywgtBFkm6rU7Gc7XHFc1iJMwCHs2mG6pONvyRA51UOoCsShj
         aRTT+qZAZSDaa7OtfwXCv/l7asHzpYu8ph2rvqg10tFLbJoG+wklR/6D+2nryURCvnxC
         5QLjtgWKjakaVKpeTDyd8hX8aI4akkHaGEr+qDMeBK5OKwG8s9Mrem7s1UjxnKbLRhlr
         FwTECRUQxsbJD41R/Zzg5e41bMQRPtbVxwWaM3GqUhapRSIPmAhZvLfkMHyvC4UJGso4
         o+5g==
X-Gm-Message-State: AOJu0Yz2O7XKaz+qmdF5bSeXAz1ZKtmuPNqhbQ9W+gtjbugEtx3tQj9u
	mOXt1nd980oIsHtZAHPQBk/0lymgdNV5U/DPMHZUzFt8ydr0/SELRE2HguWusbb3ZV5mhV/0gKE
	G
X-Gm-Gg: ASbGncuEQyXOu1jLYRA711/B6iTEcXAzy2P95AWo5hEK8O4myBWPWMYmH62EfCsdvIw
	lbd+/3GUf3+WM4iCcSyQXAopZaywLKp82cGXZYwDeHM8iQa6idWZmi5KPRFfVAe2LIOf374vcmc
	0ONiDF91+FInczCxXURxI6OC0zRyefN318CHVcSiTlueqQLIYzW6IXk3uCbIhGVcjQWTcGieLgK
	v7O9uazk35nctmC7+IV/vOqZcLmRGGjslbBAiZLyM5yv2LMgnh5HXEdqDsFvOnrFwX5Du5HQz34
	QUcv4tVaee7qEEcjfE4uW5J2ysg6Mg1f6sRqhvxY+zI=
X-Google-Smtp-Source: AGHT+IEOEm6JeMzmk7lcl1VWh43gUSbAMqXnq19unBySFr650AW8WP2D18yi2cq4DEl8oelEiD46IQ==
X-Received: by 2002:a5d:59ac:0:b0:38d:d8f7:8f75 with SMTP id ffacd0b85a97d-38f6160f9a0mr1374208f8f.17.1740033779878;
        Wed, 19 Feb 2025 22:42:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55b6ab7sm114091555ad.132.2025.02.19.22.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 22:42:59 -0800 (PST)
Message-ID: <3d281b8c-13c4-40ed-abaa-e3b98416d90e@suse.com>
Date: Thu, 20 Feb 2025 17:12:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: a couple fixes for btrfs/254
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1739989076.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/20 04:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fixes for btrfs/254, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Filipe Manana (2):
>    btrfs/254: don't leave mount on test fs in case of failure/interruption
>    btrfs/254: fix test failure in case scratch devices are larger than 50G
> 
>   tests/btrfs/254 | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 


