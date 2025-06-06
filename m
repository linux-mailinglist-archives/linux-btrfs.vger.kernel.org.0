Return-Path: <linux-btrfs+bounces-14525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3CACFE18
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0383C16FA6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94A20298E;
	Fri,  6 Jun 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rgo9o+Ts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8B1C27
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197889; cv=none; b=XO1frYtWl4+0+adHjCuIyQGNH+8Y0krZjUafu5IdIBrpCNdjtj/ohCOJx6AVDzUYbY6BDK482o/6psN9oNDogIOaj5lVDbmz5Q4aDDPjNEtywZ7+wPeLPdwasnKGew9bOZERKorYVB35OynQKc0EB8QfwVpu79gHOZI05aoVATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197889; c=relaxed/simple;
	bh=HY9XUAVUGRHYD/1A9Pg6u17m5oiBwAF/r3r/0EKthwA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cvLRwlIzsVk7Nki/o67NfX7Jbl0gbSoGgr1kg4ayPEmtf1p0975y/qJjOm2dFK3pAMBFAGWTzEyKIbX8AnK5OGCekosP5/hD9Ayh4p+1VBCD40agPu+/lWDSud5ebiGAV1p8eHIOO2mlQngKreoIl+o2Gp5kTGfH+c9VnSoYwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rgo9o+Ts; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1227242f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749197884; x=1749802684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFpnIkrQ58c1X09JYR4jJJ4/M/KVD7D+moLaQVK+9YY=;
        b=Rgo9o+TsXbCkPGvVIEek/sra9jOPYVuT0f8ybP0F4mF5yrDhSasdxDtaeZGmlUny0t
         Ulc7JHtKGAQSgrKzPUGeZwcdhhegVP31K7BWEYjZ0G6O7XkZ7oHHNs++BwjPvphwBxi6
         Zqs14gpIc4IaZwF8LLITL2BvKPlpJNT51qKSgNJ9iI88sOkdcleaMdOxsbZx0UQQlj48
         4XfeziaSJ8CsGdE1HF4XiORWbET+jgNDyta1azcM9CXjzqE3b8mjMqTue1XrqEN1IFRy
         Ko8pFq73ulHn+P7v9fvfWxKe8iM0j+aqTrv/5n79fyYmBne/lIyHv0/9Y7M0JBdawKvw
         x6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749197884; x=1749802684;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFpnIkrQ58c1X09JYR4jJJ4/M/KVD7D+moLaQVK+9YY=;
        b=KTUrEohkc7ZOJ+YO01j+Jh/W6ltoB/pcDFM1a+vScloOF2TLSfIaVCog0M/e4Gi4KD
         so3ysJ0OE/ObIB+6TkcFqox5DxJFgZ64TMvj7gBc1H+u/JbL7MCHlAhI9qzhIr78r/2L
         dffo2AhK/rF1UKzM1Htjsel1620FgAWmyCum3WqVvPf7GnYA5234mZ/RyKGCmc+/TplF
         t8kxZ60lUC7ZwvpG4cVSuuSOAf8QbvBXVwkE+FcAX5qLvRZCtvzNfuz3u1N5B/UNCkpL
         jlMEErPoq73wtlCmAEOpZwb/Uyk9IQoUAvf2YkaXN2dkw7vQ0z0XolQp02bV8P9JkmjD
         bgxA==
X-Gm-Message-State: AOJu0YwtooiMWbWQlOgPoYFpzY7aeQGTBLazEI70rtH3Lcksf7GDfV0S
	KK3WfVCYd7q3xmJ8RGIcNHhAce1ItrwzveyEeaANdNYY01ruP9znWZO/OjdS9+eD0hZDmbtsfOn
	8vqcl
X-Gm-Gg: ASbGnctLuxP143aWuRbfY37NNwQLcQE5LIMWHJwt8IGTRgBSCCaXBRTDQ4HrOKMBV2m
	uAWPynb4JbmbNDXfAQ0j1H5lRfbYLNnKergAOwq3GXHStHTpUvGg0N/VrQHkUbbp4o8wYBHpxLy
	4hQ7tldARP5aEEtU4OJPD3n0BW5h0mYMxz0jm87MW830VIz141czilp0SY4xDbXejIcGPq5z6UY
	ndjvACe3x5Wksr4fovxRPXlZaEwq+BUTqXCtNs90lwMs2XKal85ZQ40vlhxY6xNNwYh09jb7R8k
	L9e97XS54fwULD6dtxIvM8yMx6XsD8Nt3ch5XzWVuJDk2eZrz8nYEBHa1pmGLhDgdrND2IUVETB
	O1mE=
X-Google-Smtp-Source: AGHT+IG/ythL3hhyYoojXbOnUQfA/jAw2YKdtjFGY2G4sxGf4J0SSXBPm2GBj01pph3y8YmN0Dw2QQ==
X-Received: by 2002:a5d:64ed:0:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3a531cea4camr1853479f8f.43.1749197884123;
        Fri, 06 Jun 2025 01:18:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032ff05esm7448035ad.135.2025.06.06.01.18.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 01:18:03 -0700 (PDT)
Message-ID: <48e45924-2df4-4566-a76a-b10acaadb3c6@suse.com>
Date: Fri, 6 Jun 2025 17:48:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: implement blk_holder_ops call backs
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1749188673.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1749188673.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/6 15:17, Qu Wenruo 写道:
> Although test case generic/730 is going to be skipped for btrfs due to
> the missing shutdown support, it still exposed a problem that btrfs has
> no implementation for blk_holder_ops, thus even if lower level driver
> wants to notify btrfs there is a device that is going to be removed,
> btrfs can do nothing but ignore such critical info.
> 
> This series will implement all 4 callbacks for blk_holder_ops, 3 of them
> are straightforward, just call the full-fs version of
> sync/freeze/unfreeze.
> 
> The trickier one is the mark_dead(), all other fses with shutdown
> support will shutdown the fs, making all operations to return error,
> even if there is a cached page.
> 
> For btrfs we do not yet have full shutdown support, but at least we can
> notify such problem through dmesg, then check if the fs can still
> maintain its RW operations.
> If not then mark the fs error, so no more new writes will happen,
> preventing further data loss.
> 
> Now btrfs will output something like this if the only device of a btrfs
> is removed, instead of aborting transaction later due to IO error:
> 
>   BTRFS info (device sda): devid 1 device sda path /dev/sda is going to be removed
>   BTRFS: error (device sda) in btrfs_dev_mark_dead:294: errno=-5 IO failure (btrfs can no longer maintain read-write due to missing device(s))
>   BTRFS info (device sda state E): forced readonly
> 
> Future full-fs shutdown will depend on this feature to properly pass
> generic/730.
> 
> Qu Wenruo (2):
>    btrfs: use fs_info as the block device holder
>    btrfs: add a simple dead device detection mechanism

The series is triggering crash at generic/085.

It looks like it may not be a good idea to use fs_info directly as the 
block device holder, under heavy mount/unmount and per-device 
freeze/unfreeze workload, this can lead to various use-after-free problems.

Will get this reworked.

Thanks,
Qu

> 
>   fs/btrfs/dev-replace.c |  2 +-
>   fs/btrfs/fs.h          |  2 -
>   fs/btrfs/super.c       |  7 ++--
>   fs/btrfs/super.h       |  2 +
>   fs/btrfs/volumes.c     | 90 ++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/volumes.h     |  6 +++
>   6 files changed, 99 insertions(+), 10 deletions(-)
> 


