Return-Path: <linux-btrfs+bounces-14183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB81AC15DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0330C7A6592
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5502550C1;
	Thu, 22 May 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U+FURS9H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC6254B1D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948949; cv=none; b=HzAoOATJsAIdXIzW5YaMHnh/Jr5Eh6RWbrlLa8Bwf4aA1xNxXsL93r4QLwALXiayVbsLM2Pic3gbD5s/ukiqj/b+E8dyxNxudoJbDA3fFTror42lzqNnLen4M/p11kiaHX3f306GzYCKN+5MNeA14tg1HxNsRFTmt0GOFElKWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948949; c=relaxed/simple;
	bh=Vn8hWQEyN4lYhxNmDUcSgSmm2PhVI+oXkiFWaLLCjUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fZwb0UWu1hcq+9CFkTIa0sU+GNzN/k258WWNMLc5niW0tPmZNNHuYHCRleOXZ7xq8b++dbM9ugc56usXt7PxL/agPmdhnhgIsBrCtpDD41EV9cuBRxLnlWN5Q2bjyA4k5xNuZPUm6C1PNAIn1erZAx7qejwnCidzDh1q8nE1GgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U+FURS9H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a36748920cso5652873f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747948946; x=1748553746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R4ZptdEAZmLkRXbRm3Dray4wuZQIaLm4W6NZzsaRWIs=;
        b=U+FURS9HPSvk3zYvoxSeWV7h+4IDj1ZLuwDubtIoNXrswDD5/KHeru139TUiyfzLDP
         tMpNBWSAbKI0h2IdTAZBeZP8aH6dbseLnJCvsS4mx2iyXQRlfuT0BRS5xCyl3b1u4KNB
         OvHlaJt+hYr3f+CFx1GDN2Li5Tg8uVXx3ge+E9XtJsKA5A7RIpSnVDM0JgWCrdGCLOnd
         tvqE4o79pXvYczpinxh36uqF7/FeEX2aHGXm1KF1wHOleCdl/sd9DSW1IW0F6T+PND89
         O3HE+PR5P2Ih7M6j58yBtZv7fn4/d9ZIKkUJ4EygdiJrQju8X2Vroq1HeHfg/6ITGLl7
         uQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747948946; x=1748553746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4ZptdEAZmLkRXbRm3Dray4wuZQIaLm4W6NZzsaRWIs=;
        b=NQMmTlvbFcPYf1JJHKVEwAVlGYeU5zdi2krrSIUi+sPRnkSNMRH0dw4eQjZ7gh6OMj
         g0z0E4wdsS0ueL99rzatYcP6hCKgN7nQ1OCjh7rVFErCPCfCWmNgSaMOQ1B4LwxiVPGl
         suQAe4JXqcHZEBtphk4pMnPo9hPrnxFoDKVjezdvJEtRD7U2vtXbjYyCGIIivjCRS12F
         gfO0sxX89vzfPNyfUHctiLCOUAdOL3AV2N5Ik9c99umU2sv7uhdv9kU7znkKX1MMn0Zp
         BTEmbB0268CTbpGU+IThX1BHVJjAzoYDObe5x85qXldxwislXbcIn+j1/grr0jMAoUBu
         FDZA==
X-Forwarded-Encrypted: i=1; AJvYcCWev2dTO3flKOwhVdc1XsSODAXbdZi0wH/O5uc77LCe80Cvjx0rSdurDPLYuJboEeAymretinrNGyGSrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvksV7DCm55lv9dDKRgd4iRxIk4Qe7sf+G9dcdIfQY4tcGvysr
	zPyehEoKlS6VmqNn+I/skp/GiDJwJLuorRRXeM38aTiZZLaf8n+Z7xIYUli+ipGg5lOi+8Bsk7N
	P8Yls
X-Gm-Gg: ASbGncvGuUr7wDVii9aCKB+9O31lc7Noc7PcTMD7mGKtTCOddXN0bRWx+nIVz/zW3gF
	y/keJXyXQp0JEqRHO8Gmy1eJT+0UFLjryU/OY3+yK0kM7G6YJHjDKTcL5XvrxhXfiBbe0XudvCR
	syjE0Jy6bkiuYXgqcwQeOHauZPAs6e/wpwzc/AHlXSiZ+7eUHxWZD93xmUCaPyWnW15sf688oVj
	ZJ8aZwQEmfxysM0szvQmLa0BykW3LYL3/3vY9xL/a6oHqw2ZXdFF56C1cyC8Uzo7SPkHJ+4MkGt
	A8Yc1wa90fulCZ0r3IL65sOeKqq3hknuxQWtWQqbmIfnKXvtMxQY/DyE9KvN5wj/wm7rCg/GHYl
	shc8=
X-Google-Smtp-Source: AGHT+IGeTo/E2x/ct29VppCzDOkOMVnDquvAx7DEkwm8ZUuS9gBdOxMvj96Ozs5T/fahA3yIUDfIEw==
X-Received: by 2002:a05:6000:2407:b0:3a3:4baa:3ea3 with SMTP id ffacd0b85a97d-3a35ffd2ae4mr22804157f8f.41.1747948945599;
        Thu, 22 May 2025 14:22:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365c4f84sm6452214a91.14.2025.05.22.14.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:22:25 -0700 (PDT)
Message-ID: <443f664e-58ac-4191-acaa-1336475b0eaf@suse.com>
Date: Fri, 23 May 2025 06:52:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: some cleanups for the log tree replay code
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747848778.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1747848778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/22 03:14, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A set of trivial cleanups after running into a bug I'm debugging where
> replaying directory deletes is failing. Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (4):
>    btrfs: unfold transaction aborts when replaying log trees
>    btrfs: abort transaction during log replay if walk_log_tree() failed
>    btrfs: remove redundant path release when replaying a log tree
>    btrfs: simplify error detection flow during log replay
> 
>   fs/btrfs/tree-log.c | 64 ++++++++++++++++++++++++++-------------------
>   1 file changed, 37 insertions(+), 27 deletions(-)
> 


