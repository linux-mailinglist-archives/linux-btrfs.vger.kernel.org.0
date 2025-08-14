Return-Path: <linux-btrfs+bounces-16071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A103BB25AB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956011C85181
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194321CA10;
	Thu, 14 Aug 2025 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqLwS+E+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370E1D5151
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148445; cv=none; b=ZljGeJTuBwt5gjw7KuenOg49+1gZyjhKrziZ4gco2ckt2cLEkfac3T2X4xQMk5Poq5/Rr2lBrY/sxzkYLL8Sks3Rk8kPlyC8huIB7puzHOLbmzQJ2aDqr/VrmQqzkUB1ZiW9k1ZxUTnJVFiBbrpRwA9e3zEXqkWbZjVuiQDIvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148445; c=relaxed/simple;
	bh=IGPyDSC6VTUlaMnKvrrkx6a6v7k96xreqT4/ampUVp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/USv0oYvWkvgakujy6s6gm16wCf9OEhLqOcoCR9SiZb3anwZf8tz+eLwFCmFE6tQejeUHl5UD4AOYJB/TPnc4b4a0VN8+LIE7gLcPFuRcBYHO60BKLEBjbMNWNSeO1frgR6oY+GKrowc13TEm+LRg8qEhBRq0INDfe+EU59J4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqLwS+E+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e4106460so376871f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 22:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755148441; x=1755753241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tqPH77lAu/PrgKxgR0MNsdu3Swj4pUi2fa/ZuVBwpX8=;
        b=gqLwS+E+f53BUX5sZftnd1PWtepQp5c0tCzNgEeDqHwtTEB3tng+NEJttmerW1a7F0
         5QL9j40fOJFifjGD8jhhK+twCDKbrICpczTxCmLZpBnZqCLuFY6oMdFHIuYPQngjD4oA
         AlLz2dYGu+mFYdra7JTJSGZDVtCN/MtbH879C3mDnqjJp5Wi4BjYT/KRs7Nhhp9vputb
         V+cUAcMCVQVeQj1PZ+acjBOECElEQ1/lmb6VAnKJzRMFYxl5YYXN6hji6Hy+pVDd2Cdm
         2Td8QJuZjz+h8tl/eOwBdOnzgUjy6mK3wz+yCsaytgR0hA3/Gr/QREw0oQshwY8a+qLC
         MR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148441; x=1755753241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqPH77lAu/PrgKxgR0MNsdu3Swj4pUi2fa/ZuVBwpX8=;
        b=N6mTOfXos8Du461u+67aEWY1TfamLSCHpDbVhzs6M2UVQiMrFBZrCV/qXynWBT3QB8
         PbU1ovY/V5yupjjercrHFCVrNigrEsYNBmhNBW+5/8lWH1MqtVlScHufyq/ghP3Ix2Vm
         Y8fBYxqg+gIstusFLNmVc8HgscncLWEP6k8CW4l9uOpAc415ESOQ0LTVf+zceHDXjJOy
         fMkaq6DyYXj8WRpTRz6SwLo3RStPg3Z+5eu2rhCSxWb+D+wwavugS+DjyxtEdSmh81Y1
         pf0jLIbi7IC6z730WjmarHw2vSIgGECyxKpE12KowkoOYwRhCGCczHKm8nDqLJ5GSlsw
         Avog==
X-Forwarded-Encrypted: i=1; AJvYcCWonY8WZl6GjJuxrAHzr3+HPaVEG72sIoAbvtodIA/bm/kefthSPT2kJzVHDhOp3kDQHbcUYQgSshTa7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7JNujn8OJVxjcJ2dFQvIRwnS9HAx7OarVX19k8fibAhTRyON
	chLRdYcCVNRnq8+Horwshv5OwKUvU6slk4OWgHJFG2JXlFHMyWRQpqNvlhPsIqdMnz0=
X-Gm-Gg: ASbGncsHzYPcBKmHTQs5yOqMT6vIiWoVvzN0cDms6eM5gdQUn2HMsZ8r3JADJdafOl6
	dJlHjweB4wOmsxSgqUYBQ2SyZeX9iHaynPJTT1mNm3wZHR88pIXzEqQj3tUc5xt0JNflelQj/T1
	ypGhiEV7xl6dpod4XKpAyHQ5L04R6J1+DHmqs1r/kZf6HwAPFQDjm59syH1c/OqdjJhdP+f408w
	g7cMB9+LaXOuvd4SmR5f+BsloPOA2XdcDidyrsPMSU9DIRGbG8Km+VtEmG74bPUkzn6gS4TZNdP
	mm1H3yfAv93NldHkYvLFNy/0S2ICoY0HA3ES4I3T4R9NHNKRRRH6/iAWm2nsr65fqcgpT99NdiO
	XSQQB7DdtJNVhu0kMshNECUC6JCAM5rq4eu4Z2zdcz2z7i92NE1bgpVdih2FG
X-Google-Smtp-Source: AGHT+IG7v6hgvFmPXtxLFNnbV3B5nWKJg3qlNWDkbdlOmMRnE7mjpDZv7nFOUUhRYYyk7JFCKMS54g==
X-Received: by 2002:a05:6000:2381:b0:3b7:9546:a0e8 with SMTP id ffacd0b85a97d-3b9edf648eemr1241882f8f.41.1755148441184;
        Wed, 13 Aug 2025 22:14:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm21445673b3a.117.2025.08.13.22.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 22:14:00 -0700 (PDT)
Message-ID: <bf1aae38-7f88-4ab2-b375-0a3c3864ac70@suse.com>
Date: Thu, 14 Aug 2025 14:43:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken BTRFS Partition
To: AccSwtch50 <accswtch50@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHR-kGg0K71gJsYkWK-0hpbEH3NZObxXHc3CJ=R-g79iP=99Cw@mail.gmail.com>
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
In-Reply-To: <CAHR-kGg0K71gJsYkWK-0hpbEH3NZObxXHc3CJ=R-g79iP=99Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/14 12:51, AccSwtch50 写道:
> Hi, How do I fix my broken btrfs partition?

History please.

This is a pretty serious failure of COW.

Unless you were using nobarrier mount option and a sudden power loss 
happened, it may indicate your storage doesn't properly handle FUA/FLUSH 
commands.

> 
> This is the dmesg log when I tried to mount it:
> [22709.506970] BTRFS info (device sda21): first mount of filesystem
> 853da0a7-a25b-423a-8b42-4ef0cec712fe
> [22709.506989] BTRFS info (device sda21): using crc32c (crc32c-x86)
> checksum algorithm
> [22709.506997] BTRFS info (device sda21): using free-space-tree
> [22709.809320] BTRFS error (device sda21): level verify failed on logical
> 205872398336 mirror 1 wanted 1 found 0
> [22709.809395] BTRFS error (device sda21): failed to load root free space
> [22709.810018] BTRFS error (device sda21): open_ctree failed: -5

You can try "ro,rescue=all", which will make btrfs to ignore the 
corrupted free space tree.

If lucky enough, you can still salvage your data.

> 
> And here's the output of btrfs check:
> Opening filesystem to check...
> ERROR: root [10 0] level 0 does not match 1

Repair will not help much in this case.

Thanks,
Qu

> 
> ERROR: could not setup free space tree
> ERROR: cannot open file system
> 


