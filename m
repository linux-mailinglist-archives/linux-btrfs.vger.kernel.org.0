Return-Path: <linux-btrfs+bounces-16687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F4B46952
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 07:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0739C5C3A36
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151C261B65;
	Sat,  6 Sep 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDAR2wGN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4279F2
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Sep 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137226; cv=none; b=cQtELpi5XNeL0KIrkdxoAKjIEQvgJ/LzJ9S0hKyYHhtPpiYilU0iExbaEcaZDSotwEtWtOUwcXIlh8chxwO0VjHWBY29pWg8aajj5se5vArPQtoAA7iaRvtesR1rX0bud4ysz4IAYX/In2MGCYXmr2rGNZf24eJhihnoZqjqg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137226; c=relaxed/simple;
	bh=467p1oleKYXCUUzDcpZstDlD0xl4/8twxO0RF517rcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOyKctj/ry4gAYXDHGlN3PzREe/Vj+hryBPfYSC4oHbzv9/aD+7E80EEhAM8RdYoaalP4Q6ehMy5qg6fTO4JLyLq334lE6i3vUHqlyE7gcbP4+PsnbIxk7HZWdoSrB02LJQh3oScDLmp8GTa6mCTimyZHNDH8aCM5YxBs3oW/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDAR2wGN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df726ecff3so1243981f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 22:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757137222; x=1757742022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zfST+Y5MbaCxqySMCMrEvJt6lTVpLizNR3Gj9ztmCqk=;
        b=UDAR2wGNaPO/78qhRFU0qtyKBUqBtm8scfEOxeDX8b9b/IJlgNIKjM4KnAB3ohHYR1
         DqnEi4cRwuxHmbWISW68ixhpq90nnaD12bFsvfGKdYUxhfIlD9+T8WZoRZcwek/ogt6e
         dOkUjHSRnWY9MS/C/6PIf7w6fAGBz6rhcu43zj87Pa4lomAivQjv8/PQdpbjv2qTRa6i
         wFuseQFrlX+aHjGeMip2fDTXwtpu9vBn3yOWbxfe5//weoB3MAouY7RudkC85SwZBPuN
         0tlkBKyozKwcODQoMmkt4Z5ATBFP681/UMRC7XHWFQO1C+Pbri8DCUmPTRgrNNpC0Gx2
         4eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757137222; x=1757742022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfST+Y5MbaCxqySMCMrEvJt6lTVpLizNR3Gj9ztmCqk=;
        b=Uyrs6OKfBVzlNjbbSeja3WWrFz9drqXeTif4IFMZursLe8fxFeuL4C4XPuD0bxuxlX
         VGkLLK28mazDCv7Iau6+Mni09zEJF2d31tB1ssAj8/Pjt2MQztJWr9fr08Ul0X8WVtSh
         5gSlCz8FihwkNuCQvgUHOhXbm8CDki/3x5u3pipUNMhnATs9Nl/zYo5Q4X4S0ARPdtbK
         DYJW/W6jYwjz5D4Vv29gJT7hj/+vP13UV7naXLFUu8EykzPmGBOGh5hn/mTGS9SznFxA
         RUcGJaR5nIDOz7aXLc1ggFbl5zhr4wRhCM3zmoIzsL4iXE1KWPSPraPLg8GNgbXM7X4d
         cEfw==
X-Gm-Message-State: AOJu0YyueQ8nE/Qu7leO2ExhKwDr0MaWniQvGOe2g9i6uszuU1b1hKSW
	O1azCrC52HNijMFeYuJmbLGtAbx8FZiyVu0pJ6sAUXtyBJXaQdYxrV6h6XByrsy5mAE=
X-Gm-Gg: ASbGncu2bvRYTs88EC5c0DgslX3a2ueOBWUK9pL9hAaAz2FZvLdqPvYXtlTlwtPrvnm
	KKau+aWHLn6tLqH0T6LR9Yq9G8fIVsPVMVHcaq/tmw8MHQykbrhSH7/bKIo7HxqoXO8BoVHjm+x
	OUPUX4WWP5WeZ27Qx/Y7w03lb0a9I7F6cbVMpwdvB1VoNwUQHaPB3BEV8VB4taLIuyJaX+OekHi
	/4TGWQOwJlgxJ8gol5OY4eyXgUHyOINKNW6MBMYuXNv5Cz6IbrCjnqJQMuaLboDzqKny69ndl+P
	qGAlDasr441jwRvva1i5xY10lgFFVygp+cwMZjVjIdb3trRaQ+HEOCANT60vdgUUH1t2aUm+kUu
	xPeZfgxMLKOt1mBpQHhx7xzx/h8b9yTqHiQtAZ9/S4kDJ1NvlwM2pMpHt+4pVXQ==
X-Google-Smtp-Source: AGHT+IFUdOwcf/+1M2i2qLc+RGz/+Rtoi8Mz+5FHK7Q9on6s+nsT3mZS8usFTR3g4C3HZqgx0P5WTQ==
X-Received: by 2002:adf:b317:0:b0:3db:dd47:b5e4 with SMTP id ffacd0b85a97d-3e63736f940mr374711f8f.2.1757137222065;
        Fri, 05 Sep 2025 22:40:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce9dd9373sm41557155ad.85.2025.09.05.22.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 22:40:21 -0700 (PDT)
Message-ID: <198b7846-539c-44cf-b746-c70fe2befa69@suse.com>
Date: Sat, 6 Sep 2025 15:10:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs RAID 1 mounting as R/O
To: jonas.timothy@proton.me, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
 <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
 <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me>
 <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com>
 <xrsGddBl1hq0FSjKaqFM8275iii6WNju5hyl2wU8I9J7f2q3C11Dhsqgn-ANIXJRP-NMf4jioFdthalcpZn7YjKb0KAE7YBYxiGSA6g41Z4=@proton.me>
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
In-Reply-To: <xrsGddBl1hq0FSjKaqFM8275iii6WNju5hyl2wU8I9J7f2q3C11Dhsqgn-ANIXJRP-NMf4jioFdthalcpZn7YjKb0KAE7YBYxiGSA6g41Z4=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/6 13:28, jonas.timothy@proton.me 写道:
> 
> 
> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Friday, September 5th, 2025 at 6:12 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
>>
>> 在 2025/9/5 19:34, jonas.timothy@proton.me 写道:
>> [...]
>>
>>> Hi Qu,
>>>
>>> I currently have 2 profiles because I have 2 sets of disks:
>>>
>>> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
>>> Data, RAID1: total=5.28TiB, used=5.16TiB
>>> System, RAID1: total=64.00MiB, used=800.00KiB
>>> Metadata, RAID1: total=7.00GiB, used=6.18GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>>
>> So this means this fs is more or less corrupted, recommended to salvage
>> the data first, then either re-format the fs or try `btrfs check --repair` (which may not always repair the fs).
>>
>>> $ sudo btrfs filesystem df /mnt/disks/disk-20TB
>>> Data, single: total=6.79TiB, used=6.75TiB
>>> Data, RAID1: total=6.74TiB, used=6.71TiB
>>> System, RAID1: total=32.00MiB, used=1.84MiB
>>> Metadata, RAID1: total=14.00GiB, used=13.85GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
>>> WARNING: Data: single, raid1
>>>
>>> the one that went R/O is the 12TB pair, but the 20TB currently is having trouble finishing setting up RAID 1.
>>
>>
>> `btrfs fi usage` output please for the 20T fs.
>>
>> My guess is, you're mixing different sized disks in that 20T array.
>> And you're using RAID1 with 2 disks, the usage won't balance that well
>> among just 2 disks.
> 
> I'm attaching both of them.  I don't know if I should've done this differently, but I originally "muscled" it through when both were just stopping on their own by removing the file they mentioned can't be fixed by cutting it out of the drive, then placing it back in the drive.
> 
> $ sudo btrfs filesystem usage /mnt/disks/disk-20TB
> Overall:
>      Device size:                  36.38TiB
>      Device allocated:             20.30TiB
>      Device unallocated:           16.08TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         20.20TiB
>      Free (estimated):             10.80TiB      (min: 8.10TiB)
>      Free (statfs, df):             4.68TiB
>      Data ratio:                       1.50
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                 yes      (data)
> 
> Data,single: Size:6.79TiB, Used:6.75TiB (99.51%)
>     /dev/sdc1       6.79TiB
> 
> Data,RAID1: Size:6.74TiB, Used:6.71TiB (99.53%)
>     /dev/sdc1       6.74TiB
>     /dev/sdd1       6.74TiB
> 
> Metadata,RAID1: Size:14.00GiB, Used:13.85GiB (98.95%)
>     /dev/sdc1      14.00GiB
>     /dev/sdd1      14.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:1.84MiB (5.76%)
>     /dev/sdc1      32.00MiB
>     /dev/sdd1      32.00MiB
> 
> Unallocated:
>     /dev/sdc1       4.65TiB
>     /dev/sdd1      11.43TiB

Your 20TiB system indeed have some unbalanced data.

But it should be mostly fine, as your single DATA is less than 7TiB on 
sdc1, with that combined with the unused 4.6TiB on sdc, you should be 
able to migrate the single to RAID1.

What is preventing you from converting the single to RAID1 using 
something like:

# btrfs balance start -dprofile=SINGLE,convert=raid1 <mnt>

Thanks,
Qu
> 
> 
> $ sudo btrfs filesystem usage /mnt/disks/disk-12TB
> Overall:
>      Device size:                  21.56TiB
>      Device allocated:             10.58TiB
>      Device unallocated:           10.98TiB
>      Device missing:                  0.00B
>      Device slack:                276.00GiB
>      Used:                         10.34TiB
>      Free (estimated):              5.61TiB      (min: 5.61TiB)
>      Free (statfs, df):             5.47TiB
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
> Data,RAID1: Size:5.28TiB, Used:5.17TiB (97.77%)
>     /dev/sdb1       5.28TiB
>     /dev/sda1       5.28TiB
> 
> Metadata,RAID1: Size:7.00GiB, Used:6.18GiB (88.36%)
>     /dev/sdb1       7.00GiB
>     /dev/sda1       7.00GiB
> 
> System,RAID1: Size:64.00MiB, Used:800.00KiB (1.22%)
>     /dev/sdb1      64.00MiB
>     /dev/sda1      64.00MiB
> 
> Unallocated:
>     /dev/sdb1       5.35TiB
>     /dev/sda1       5.62TiB
> 
> 
>>
>>> Would I have to redo this if COW is broken?
>>
>>
>> Mostly yes.
> 
> Bummer :-(
>>
>> Thanks,
>> Qu
>>
>>> P.S. resending because I accidentally used regular "reply". Sorry.
>>>
>>> It also just finished scrubbing my 12TB RAID 1 array, and it aborted :-(
>>>
>>> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 1 wanted 1250553 found 1250557
>>> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 2 wanted 1250553 found 1250557
>>>
>>> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
>>> Data, RAID1: total=5.28TiB, used=5.16TiB
>>> System, RAID1: total=64.00MiB, used=800.00KiB
>>> Metadata, RAID1: total=7.00GiB, used=6.18GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>
>>> $ sudo btrfs scrub status /dev/sda1
>>> UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
>>> Scrub resumed: Fri Sep 5 03:16:31 2025
>>> Status: aborted
>>> Duration: 5:33:42
>>> Total to scrub: 10.34TiB
>>> Rate: 182.62MiB/s
>>> Error summary: no errors found
>>>
>>> $ sudo btrfs scrub status /dev/sdb1
>>> UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
>>> Scrub resumed: Fri Sep 5 03:16:31 2025
>>> Status: aborted
>>> Duration: 6:05:48
>>> Total to scrub: 10.34TiB
>>> Rate: 200.25MiB/s
>>> Error summary: no errors found


