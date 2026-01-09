Return-Path: <linux-btrfs+bounces-20358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4AD0C7AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9293031965
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1533287502;
	Fri,  9 Jan 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W2HDn4dX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15383A14
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998845; cv=none; b=H3fys7CbANwTvQWxD5ydHr3GQVNdrtlnwFm4jWLFpbJUgXb6/gXyTpscH0WW0Dq4etuqcr5dmu7H3hRyfYieRhhii3bnXCA3HmXAAP8TXMnx9WudqJ1I6b5AUuuPQPDMl1wkSQuM0hbEbnwxstrkTEJhbybV1888w6cUq/wFJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998845; c=relaxed/simple;
	bh=fFmx38+MtgVjZ9T2pW18vAdcB4HkQawInGJy0W4dxBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OeR31a+KdITO48WRFqqDj+LETh3+/6AE41vNXa8FENWN6s8zIUwM4bzz2s+QJZO43mm9acGUDeejbw3jgP+c/FUn0F8Lr9c/2DPwYjzrQGO7L/6SeHNOJhFc4NyJp9phV1FmwpLWPSP2XGz90BB0RcURaEUMaekNYewUYRmJ7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W2HDn4dX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477770019e4so36892805e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 14:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767998841; x=1768603641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxOWpTPuuyx1rRXoV/QYg7JYDZwCD2zlvagIrn1ono=;
        b=W2HDn4dXG9tvBa30ZEbWdlJLiH1aub1mlkSPDwpx5gTLEg28RmXvJwGetPVQ1QcSEf
         V6R3AfGuIBfJiOjhgikSwbkE7iqKJCqWrkLboY88I6Vva4inztgG6NdUemlCFQz05wYQ
         QFAur8g7ViHUn0Oy7+gWCffBPJn4Bpq7EFtBnpbH8AL6G8aS9eEgbg/AYJZBgkWmu6He
         a32Z7rRN9OWc88jrIssiDf0BWT5ab6mGFGnnYep0ob+mxHmlMhggOKduUE7U9GJYQLF3
         VwTheyyfn9Q2e3eAadheV79IgpAvQcsclccpYMR1DyMTEhQ6gxz2DV7XhyMZEd6ku1Vq
         n1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767998841; x=1768603641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLxOWpTPuuyx1rRXoV/QYg7JYDZwCD2zlvagIrn1ono=;
        b=LueyvTwiX7Ln4bn3liQzBC2UNS2q3tyT3EVoPExW1CrU5S4mt3eaYWp00t6u1tRB07
         6RMhBYCtwbMdFHpwzUXKdApHRwJAL7CKMLKb9TIRH+REdCyQdFM5NaR2IrfRIiheducL
         4sr/iPBnEGkXUcfbULGfli6lRqQ6oRotVTK7Zp9xAMZmwFZjoo/brlDOVL9BguQtHTFM
         mKW7PiqWgzFptxk4KQIBuVBW+x5j73sOQU5Urqg/IuVHc7rCjg9ebA/UZxnhAYHPqB6G
         T5POZads7pvH0JK7nNn7OjZsKxQ2rFBrP05BunjBnp4us6ECObqd9kV74/qGXG6g45OB
         zLCA==
X-Forwarded-Encrypted: i=1; AJvYcCXgJheSA14WQwH86V+BKeT4LToIuui4GOU0auMs2XqLqpt1xJ8T8JyIUwahZyuV60ACBgYMgqJ7Yl2TJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNpMBb2bwB42gIqNLe2d/xblW80jlzJZ4DdAFSBIcEmc/HYAh
	ZlsGckrXLdyMXTleuEXmR1wHQHPlQ3ToPYnA1cyyrA+oAZtjSVXsWfNSxcMMtzU/ga4=
X-Gm-Gg: AY/fxX68W+xAmG3YqJXHW1VkErtWLzuSQZSyvOFJTIT3CYc67gDOTd9P4LALkZ6gysJ
	zmOklWO4Bqy+AxUqEhm6/MnpS75fwNVK0RM/o/257M41ya5FZYMvb0jxCqAZO5RatVtG/ILYWhD
	qruL8lFLgrGqTnrbgvUcKNsb/4BiH1OYCwk9gEZsyzpu8unlG7p58KQF576NzhtD7M3Y3OaxGWh
	dDdt7QxVRk1H7aN3TSMcYErhe67PNrWzptyOeAuN32+4ZgfKcorHIMgLOAeV02y4w5pE9R1gHCo
	O95JyXr9h8lHu7qnW/gDjBly4n0bT0+B7PQzG7a4BKNcPDqUTgqrfb6ks7pVi2SZDCyENeIXjeI
	OgMZn6XCrM9bxzWJKqFt5MxVuLyKl5ivvt6uYbw555mBF+1jbU+utSuJOGFjeosOeyaT/8NgBpY
	SZjNEXJuHNG/aZZBe8eagTatxcAKG7jqRGKMM1pw4=
X-Google-Smtp-Source: AGHT+IHySY9hgzm/qdyQlLrR+pU7AydcMQZr4ikZK6cZ7Is9DiO/B8LNDFWnssm5GFvH8jVy77KCpQ==
X-Received: by 2002:a05:600c:1d19:b0:47d:5089:a476 with SMTP id 5b1f17b1804b1-47d84b386fdmr148981215e9.31.1767998841419;
        Fri, 09 Jan 2026 14:47:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f84ef1dsm11575484a91.0.2026.01.09.14.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 14:47:20 -0800 (PST)
Message-ID: <81d852f0-80a5-423a-8882-c7553f0b4820@suse.com>
Date: Sat, 10 Jan 2026 09:17:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: After BTRFS replace, array can no longer be mounted even in
 degraded mode
To: Neil Parton <njparton@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAYHqBbwwFUD5C7SyRYmrXKYtZfx=_=hQpXrSfk=oi5Dp=QUAA@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbwwFUD5C7SyRYmrXKYtZfx=_=hQpXrSfk=oi5Dp=QUAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 21:22, Neil Parton 写道:
> Running Arch 6.12.63-1-lts, btrfs-progs v6.17.1.  RAID10c3 array of
> 4x20TB disks.
> 
> Ran a replace command to replace a drive with errors with a new drive
> of equal size.  Replace appeared to finish after ~24 hours with zero
> errors but new array won't mount even with -o degraded and complains
> that it can't find devid 4 (the old drive which has been replaced but
> is still plugged in and recognised).

This looks like the replace is not finished.

As there is still a dev replace item.

Have you tried to run "btrfs dev scan" so that btrfs can still see the 
old device, then try mount it again with dmesg pasted?


Also it would be better to dump the dev tree so that we can check the 
replace item:

  # btrfs ins dump-tree -t dev /dev/sda

Thanks,
Qu

> 
> I've tried 'btrfs device scan --forget /dev/sdc' on the old drive
> which runs very quickly and doesn't return anything.
> 
> mount -o degraded /dev/sda /mnt/btrfs_raid2
> mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs cleaning.
>         dmesg(1) may have more information after failed mount system call.
> 
> dmesg | grep BTRFS
> [    2.677754] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> devid 5 transid 1394395 /dev/sda (8:0) scanned by btrfs (261)
> [    2.677875] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> devid 6 transid 1394395 /dev/sde (8:64) scanned by btrfs (261)
> [    2.678016] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> devid 0 transid 1394395 /dev/sdd (8:48) scanned by btrfs (261)
> [    2.678129] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> devid 3 transid 1394395 /dev/sdf (8:80) scanned by btrfs (261)
> [  118.096364] BTRFS info (device sdd): first mount of filesystem
> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> [  118.096400] BTRFS info (device sdd): using crc32c (crc32c-intel)
> checksum algorithm
> [  118.160901] BTRFS warning (device sdd): devid 4 uuid
> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
> [  119.280530] BTRFS info (device sdd): bdev <missing disk> errs: wr
> 84994544, rd 15567, flush 65872, corrupt 0, gen 0
> [  119.280549] BTRFS info (device sdd): bdev /dev/sdd errs: wr
> 71489901, rd 0, flush 30001, corrupt 0, gen 0
> [  119.280562] BTRFS error (device sdd): replace without active item,
> run 'device scan --forget' on the target device
> [  119.280574] BTRFS error (device sdd): failed to init dev_replace: -117
> [  119.289808] BTRFS error (device sdd): open_ctree failed: -117
> 
> btrfs filesystem show
> Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>          Total devices 4 FS bytes used 14.80TiB
>          devid    0 size 18.19TiB used 7.54TiB path /dev/sdd
>          devid    3 size 18.19TiB used 7.53TiB path /dev/sdf
>          devid    5 size 18.19TiB used 7.53TiB path /dev/sda
>          devid    6 size 18.19TiB used 7.53TiB path /dev/sde
> 
> I've also tried btrfs check and btrfs check --repair on one of the
> disks still in the array but that's not helped and I still cannot
> mount the array.
> 
> Please can you help as although backed up I need to save this array.
> 
> Many thanks
> 
> Neil
> 


