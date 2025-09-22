Return-Path: <linux-btrfs+bounces-17047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA406B8FB1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A03ACAC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2B27C145;
	Mon, 22 Sep 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HuVMuIp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D427703D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531971; cv=none; b=ishM+0zNMpZ4TJ+CvMsan8otX2t2bxAp92Mq3VNNHv8KVr7dTCfTQrW4PiWn/WX5h2tMEzM/qPPJt0eaGGragTArqWwCePVNcRQmj7v7Tv5CVvNEPXqH3NLpIUhmmW2U/EMdaC32D8MiMqciFM4zCgQvRTNzyM62PZbuyqmX3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531971; c=relaxed/simple;
	bh=HlbWlc8v+0ShbhNx3OLmsfPdnFYfnFzlTfiL6sVxEZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IfW2oabaXHJ8+VOBiWprdtV3oCx7Me6P0QiCYlihusgs1xlC1aTTC5BEyiv/3t5yl0NcWgm7Ks3Db4nw9YEUKYdX+vGZcg3/YXUB97pIWDzcerRAiZ3O40sRxsLaCs5eB/is/mxaZoV5678tIzerfveFk3I1cKy3rZVMgyK9j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HuVMuIp6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so24158685e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758531968; x=1759136768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vH6p1hn0JY1fGaYhdgC7QkECD/fsGtupX78MRYe5Tr0=;
        b=HuVMuIp6dH5aE6Vx07Cy5sh0vF3rUQeR6ZECcHsM38HDn0Jnhz88HaGXMvNOEnnCto
         oJTeh/bsT8ouEweEAWCeDtxz3IU/hrLSlWn0tMF/SIjKLrq8z3XEhA/TmhEV5Kra6YxE
         EI0pfeuug/LN/VnhhEvp4eCeCxaaj5tZM6jghkxnvJSSrelEAYoz5l7mdzaS87BqSWLo
         0zfySt0j+wKLuicIOx6nhRe+gQ3vPxSkvz3BWBC9uGZU64XxHmh+af0jbsnQ67cijhjt
         C+DBz/n+pUfd0LhfxM8B3vPIkoJ5r92EBF9hgQwPOBvkyifGT0jQ10THK0v0B/gjRy7d
         E1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531968; x=1759136768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH6p1hn0JY1fGaYhdgC7QkECD/fsGtupX78MRYe5Tr0=;
        b=UDs9Y6IguVfFpGuG42G5KJOJVqPx50bf5nnrvXyZYgEF8v44g8SbQwGPhRLDIpPu/X
         MJBrbFNk+vE62bFvLL11AZAFivtJDlsO/OscbCHH77jos6MjhiNDi1XUL3HVi4Cu/1ZS
         HF4ZrQesHH5d3uxmyFK1tT9s6NUYMRHMwQ754jbiM1v1+Sm/SSaCr2ZbMhKd3Jw94iYX
         JidsfzdbVzm+zvLSUw9W6drZ8LYrxzUvmMJjnxsZu9j9lilN0jctu5dsqawgbvxIWmk0
         lLl4fdu1n+uw8acVi/npYzNs33leA/kRZfilOt53gCrcNgAgbFrz38koIbMGBWqqA/nm
         xyJg==
X-Gm-Message-State: AOJu0YxnVODqNhYNd+m+D9KCo62QjUauozZYtGAkDznKfKVDtCCMgHEB
	cWXlziTvTyo7KoGi0R58+OdN4IQTHtEMWuapZLvEqHRt8irLB62WrdfaSg4aqaep3Auarp4Iig2
	u+owX
X-Gm-Gg: ASbGnctwtIMQEvdhn+hMMeoQyg38iSMl0IXNmQmVRERLu4enDeqLq7/Nv624x/cv2A9
	A73t/n9PTOkey3N5fhK+h3g1U/63IWtRtZt57qHxTV6NZvgrZ+GRo9wr15b8fTvB/LQLsVr1ALI
	zQW9gfNSak1YokUPYDjAZBs9mCeqndAvvKaIv3817+nj5bYObHrnsxo3iJIeNpOrLpCio7cMlua
	oTmXy3sHyBTKf2BTJqBC3uTR1GQ7LxeC0VSlTAcL+MZKjGeLASAUIWp3s9lQ0l8r5ZLOjr2cx5R
	v/c48uJbBpRifpGmseWvwuipOmZwkamPZCf0eCwKJJwW1TYRfbZA7z14b1pUTlpQCPwk/feKn8d
	rSOvk2DCSSQmxKqYvJxPtTY/cu/UNrx4SxpSB+bQhGeSX53Vy1vc=
X-Google-Smtp-Source: AGHT+IGf0G0/jyxKC1WCOYtUDO4OrEok7QFsTLAmOHzsoEFPmldEKyjC7ZFtOmSp01DIe+wB2NYARg==
X-Received: by 2002:a05:6000:2209:b0:3eb:4e88:55e with SMTP id ffacd0b85a97d-3ee84afd2f2mr8818896f8f.41.1758531967701;
        Mon, 22 Sep 2025 02:06:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803169bcsm123688455ad.114.2025.09.22.02.06.06
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:06:07 -0700 (PDT)
Message-ID: <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>
Date: Mon, 22 Sep 2025 18:36:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <20250922082854.GD2624931@tik.uni-stuttgart.de>
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
In-Reply-To: <20250922082854.GD2624931@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 17:58, Ulli Horlacher 写道:
> On Mon 2025-09-22 (17:11), Qu Wenruo wrote:
> 
>>> Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs on
>>> top of a md RAID5?
>>
>> Neither is perfect.
> 
> We live in a non-perfect world :-}
> 
> 
>> Btrfs RAID56 has no journal to protect against write hole.
> 
> What does this mean?
> What is a write hole and want is the danger with it?

Write-hole means during a partial stripe update, a power loss happened, 
the parity may be out-of-sync.

This means that stripe will not get the full protection of RAID5.

E.g. after that power loss one device is lost, then btrfs may not be 
able to rebuild the correct data.

> 
> 
>> So you either run RAID5 for data only
> 
> This is a mkfs.btrfs option?
> Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?

For RAID5, RAID1 is preferred for data.

> 
> 
>> and ran full scrub after every unexpected power loss (slow, and no
>> further writes until scrub is done, which is further maintanance burden).
> 
> Ubuntu has (like most Linux distributions) systemd.
> How can I detect a previous power loss and force full scrub on booting?

Not sure. You may dig into systemd docs to find that out.

> 
> 
>> Or just don't use RAID5 at all.
> 
> You suggest btrfs RAID0?

I'd suggest RAID10. But that means you're "wasting" half of your capacity.

Thanks,
Qu

> As I wrote: I have 4 x 4 TB SAS SSD (enterprise hardware, very reliable).
> 
> Another disk layout option for me could be:
> 
> 64 GB / filesystem RAID1
> 32 GB swap RAID1
> 3.9 TB /home
> 3.9 TB /data
> 3.9 TB /VM
> 3.9 TB /backup
> 
> In case of a SSD damage failure I have to recover from (external) backup.
> 


