Return-Path: <linux-btrfs+bounces-15698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758FB13242
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8CF3B4A6F
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEE24C676;
	Sun, 27 Jul 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Stld28ov"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE51C6FF6
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655790; cv=none; b=k24gMwoj0BeVPOB3766uAEUiFbFaYieTMEz7tTokYqEk4oSfNX2sSy+/cAMKJaifDHnaelCLWoPSSFqd2LKvhemQ61f5vdeLbP1UUXQ3gq9skZ7Lm/2ToDewTCEfUvGCoeqCPBY796ynMM+NZFxNZgkcAK70CX8G3nL+Fldwe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655790; c=relaxed/simple;
	bh=9bmpwMAdMG4T9c0dc7YE2uGpgDLWdEgM5l2YCyWTzyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n6l2FIGwWqVreB4JrqUAY7Eexeq/7o+1KQgSJ2dq4w7whVGohfzyxnhzuSSM9M3l29VfMbj9eBzhNjc3NZDksC95vIvrmqeCJ7Tnl+1SATYms0uuADKew5QpQ6YalWsaEqWUb0rY89CaFpa0foeshR0TiEXUFqKlG6SfuisSLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Stld28ov; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7886bee77so365437f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753655786; x=1754260586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvl+Ratj+gir8baKf4t4gPDpPBVdfnD/vtP96pA0cPw=;
        b=Stld28ovC00lgc4z3UzXQPC33eHGYef+oo+Zk+4i6W4KRN3fc4XxtxH/vRrJT3rvmR
         0qvoSJyJx9kC27A6L/RdXqruuuC5k6pd/mJh8e1nbYWkTCduksVsWOb61ahfopGMu9Lj
         HYdPdGYtT7cU7qOSNsz71BmwBN0qrOTYR9DcExr8hiN2x4i8Ov1JNqP+5mVE5yLW3UOS
         ThM3rn/gElBuLODurgqAry2JyMvr9j8FqzvX3CA7XJXXNv/99QQfOboTCWO2RByt+UeI
         zNQczv0MxwTBCJRoK9X6y/hY3e9FzFm6UdYmlZ6Wvyd2IgPOGhbXUOVMkpdf4SRbsLBD
         MmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753655786; x=1754260586;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lvl+Ratj+gir8baKf4t4gPDpPBVdfnD/vtP96pA0cPw=;
        b=qYifK3wSAKnOZnqHYF7XBaMGQgpBJrEXkwy4DQ9yC+dfaDc8pgEbx/r1sO7O6orh4j
         J+pbuoa7pjNktw7Q6iSb31sTlKB9XEL5WesZ38bG6KfzorVR998fsi5/3UvlNAn+p13j
         baDZaXmFlhOb+atZvu+t76QzzraXBubgPda/Vf1mGJIx83P4MvmzgJavrTRFriYr2cxW
         SQI2MZD4xqGhTaH8AZbEsr9Cd0ac4hq76wsu1A1ftYFjxQOZAX+HQM+tdXScFGjKUpfM
         YGaeCYIAbLcBDkEQXVmjUjbGmLXR14o0jJCQAV8wnUyBZR+kwx6LlGNBNha5OTtqFAAv
         buKg==
X-Forwarded-Encrypted: i=1; AJvYcCXCU3C5FBT3eX1DKcRmaAbP3nT7YURCQfKUVFBTdhiTwgnyCV872iRuLiq2YHnV4fTuRR3knUWfpUKy7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7MHr1ghge0wnIa1u97z7Ah03EtwNCYu38aP3eN/XqzxLAl0c
	xcl9Vc+KacuviEpCrEPxXuF/uNfj1NLEGx2oKJGK7gvuXKPYuBCyP8CxvNunt4x9fIY=
X-Gm-Gg: ASbGnctke1NC9L7gl+JOEpXJSHzo4L5/xMR9qk/pIum5ovrGQR+bD36fOBG347lT2FG
	LoDGbXtfJmLhXY09EeppG452t8HtX5VgunJznnhHVEE8rw0G5uhrr9t1prE+bOt8td4HteQCbB8
	Pr2WwEOAe7aLGIjv1Ebg5/JYhLNsusdKIiATodeg1h51GD3aosvc1sjTE5Q1pI3tnjJrVfPYH6M
	MGj7DyhIYPXprGez4bP3kCo0DhVYobjqsfM+QVhd7bTf+WOidaZzEBziB71ovDbd1V3UOjQf9m2
	hrxCQ72YajaMMGctXfKCDPjTjR7VUMnKHdOKSkYqhNtQ2a81Y8QQquttjstxz0qSckI2fIi6ocj
	+/GwO36yTaOPmrus19H43JJ11HiCzALI1FAA/EmdiEVakKMr5Ig==
X-Google-Smtp-Source: AGHT+IEVH198dXCrmmv5K7sG0A34jvL10HCTacAWR/iz4S8ZK8uYsi7xyN+VO12l9dEGorCSVma0vQ==
X-Received: by 2002:a5d:584e:0:b0:3b6:17c0:f094 with SMTP id ffacd0b85a97d-3b7765ec9c3mr6561374f8f.14.1753655785790;
        Sun, 27 Jul 2025 15:36:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5aac459sm36238415ad.105.2025.07.27.15.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 15:36:25 -0700 (PDT)
Message-ID: <d738f9b1-2717-4524-b5de-3c5636351b44@suse.com>
Date: Mon, 28 Jul 2025 08:06:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cannot read default subvolume id?
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250727174618.GD842273@tik.uni-stuttgart.de>
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
In-Reply-To: <20250727174618.GD842273@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/28 03:16, Ulli Horlacher 写道:
> 
> Why is there a "cannot read default subvolume id"?
> 
> tux@quak:~: btrfs sub create xx
> Create subvolume './xx'
> 
> tux@quak:~: btrfs sub del xx
> WARNING: cannot read default subvolume id: Operation not permitted

It's a warning, not an error. And you can see on the next line, the 
deletion happened without any problem.

You're running as a non-root user, meanwhile default subvolume id search 
is done using tree search ioctl, which require root privilege.

Thanks,
Qu

> Delete subvolume 292 (no-commit): '/home/tux/xx'
> 
> tux@quak:~: df -H .
> Filesystem                   Size  Used Avail Use% Mounted on
> /dev/mapper/nvme0n1p5_crypt  2,0T   64G  1,9T   4% /home
> 
> tux@quak:~: mount | grep /home
> /dev/mapper/nvme0n1p5_crypt on /home type btrfs (rw,relatime,ssd,discard=async,space_cache=v2,user_subvol_rm_allowed,subvolid=257,subvol=/@home)
> 
> tux@quak:~: btrfs version
> btrfs-progs v6.6.3
> 
> tux@quak:~: uname -a
> Linux quak 6.14.0-24-generic #24~24.04.3-Ubuntu SMP PREEMPT_DYNAMIC Mon Jul  7 16:39:17 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 


