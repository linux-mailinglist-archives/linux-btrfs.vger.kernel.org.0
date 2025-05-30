Return-Path: <linux-btrfs+bounces-14302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F02AC85AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96C69E7D65
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F28F40;
	Fri, 30 May 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g5zYLA5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C444685
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564885; cv=none; b=o4BU3mQV+JbPmvStzJMdR/P1VNgsmTOQQ6cRL79wSisEog1OSBk8ZK4UO0dkeRTpnpOH8EsEpdg3ELWBFOLrayuh7VNkjDn4SExZBFCuKMfwmU2DCk3LC2nXPyDBrE2UaJk6GV7hx5H64VkGwL2Ju26YMZqMpGEuWT7KSGNIn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564885; c=relaxed/simple;
	bh=+PjNLrf3ufLhgjsEMy7GHdPYdJYSsYnlv4UVmrxMkhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gPelthFy/rdnYEb4V7oZ3jKZHAurpx9nrdL16Sggm7K03SVTRXYvycHmOJiQex2r/qjcMRLl0+gPm3+V+cEKUTZb5HT96BDjHXwqoaKKfxexkHhSe6k/ecu0lECdP8FNX5wNr5YrbUX9X7ghAsnkPvH37t6NX8RT35kwL1+mIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g5zYLA5d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so10958745e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748564880; x=1749169680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZeTMWwGKuZb2rDfhOGtyMx2xjHvnDVOhwHavRdrdQI=;
        b=g5zYLA5dCc/Bx9RUm6LDtm43XHBhJwY1W2sMq6t88DFJPtOM/Zt0IvdYENd3rVJeXn
         RH9dTP2l6lIqPGg7NayttC7Q7MVG0SDtBo79yhfZvw+M0xQ+RNGEbVjcorIa9zE9PLeK
         l1vVMoVvOhIDY34a8bsb4/cWFzEYyYDCJnTsSPKC/wtbdGiZP2O+hXQDn4hxRc8lZ6j0
         J1ry3Cndmx5cuhAzSKgCxdKndfMbjZ7tNnbmObUHrWMvDos4Uk3qprhRZEJghCdUubYo
         m2iKMaYL25Nknl4fj3i788bd/yT0XxNy2vGsimfA/Maa+VHkZ/QW5l4Jnyy4hOCrZT3p
         raXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748564880; x=1749169680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZeTMWwGKuZb2rDfhOGtyMx2xjHvnDVOhwHavRdrdQI=;
        b=mpl2fWWl8dlAOw8haCTSn2rLFyCxTgYpZOXO1lrtnc2fXIZAJkl38j1FGOA6FutWXK
         9+VdFJOhiT4hBlVxfy/WxTwRa7gIlTZwPu9Pmsu02aleejo7Bh1LZO/7qdg081CJlVx0
         763D62gHF/GZ33u6PlZ7nxapMliJYFEfaT7DdYWOebR4bnec/O/Q/sXaBmH/Cp/1Nt3h
         Stt8Mj9fsZgRSMOUm3jEIcI7PTiuSLizD/nu+sJzFh6M17cWzq6IqH9yqIbXWeEZpx8T
         Mf1NK8LAvllh6EMvIhXX2H+ErzamE+Gu6NVcYZc0i0qNexMSXcOGOgiiMR7Ddnkrp9qH
         Sk6A==
X-Forwarded-Encrypted: i=1; AJvYcCWHgPNRC6bKTHnXIotFSEfbkEOvkBABDoiovSX6TUwts+LmPuUIujHoTVKOyHGiFTcbS5ENY7fXSiWjgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+oQIwR/UQC3kPHvBpN8mKrHwxHLE7TXTVoeki6wJQ3YYeU+C
	IvGiyeYN7mfr8ol5Gbsrt/qq/h1tAT1uQJEgMpY6E51a9U1b+piZKlbJRqwrjzP/jeOWeM4t90d
	7ScX7
X-Gm-Gg: ASbGnctsYJtjgo3PmbqDfdeLYjW2Ndi/LozWlPPfULy2NKXj+Dz2hulRG4DTfLw1DQK
	iGI6nPnrDgUDpxvss1k0KXu99c/xTUhQgvP8VCMcc+SD7n5Aq99L+6wRgVg5yQYHJHU3pyg3KUo
	Q3YSx7sM0Ww3k0dHrPZwyLWuJziCEc/eKwFqUJIYW9T6xftkrKmFs9J7WlZvqiwjyij5SmOPUdj
	ALuQlEvpRfprS8mKQkGwGJ0mKzc/hlbZwUotzeYwg3YsVNnAcg9km9NqXbsKSzOdtNtoXEumL/x
	28WByBfPEnG7J1IIkE8V6/8W64nwrNdxE9p17eTDp7EyqQJPZ79QixIm+kgBRqlPlF8LA1aLLdX
	dZcg=
X-Google-Smtp-Source: AGHT+IHDdZkJE4aEREjGyanNCwBldB2/Hhan2SCWuUFO7i4LEAzELs7dMoxLcGHPD/JhVryTpdhrcA==
X-Received: by 2002:a05:6000:2485:b0:3a4:f52d:8b05 with SMTP id ffacd0b85a97d-3a4f89d354cmr167403f8f.35.1748564879766;
        Thu, 29 May 2025 17:27:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3221a4sm115253a91.42.2025.05.29.17.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 17:27:59 -0700 (PDT)
Message-ID: <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
Date: Fri, 30 May 2025 09:57:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does defragmenting break reflinks?
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>, linux-btrfs@vger.kernel.org
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
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
In-Reply-To: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/30 09:22, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 写道:
> BTRFS-FILESYSTEM(8) says "defragmenting  with  Linux kernel versions < 
> 3.9 or ≥ 3.14-rc2 as well as with Linux stable kernel versions ≥ 
> 3.10.31, ≥ 3.12.12 or ≥ 3.13.4 will break up the reflinks of COW data 
> (for example files copied with cp --reflink, snapshots or de-duplicated 
> data)." Why does defragmenting not preserve reflinks and why was it 
> removed?
> 

Defrag means to re-dirty the data, and write them back again, which will 
cause COW.
And by nature this breaks reflinked data extents.

