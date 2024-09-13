Return-Path: <linux-btrfs+bounces-7991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831999778EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 08:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CD5B25187
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDE186E46;
	Fri, 13 Sep 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I9QQUm6a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48518BC20
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209671; cv=none; b=BHO0qVIgPBlFXaQPdpCqolIpfiW2QkfVsHNfnpy2c/Yo0LUIfEiUTml484UWexbr9ZQKRcXuosV8PXhLqrsZP4aBx4t0Z660LQd8q9f5KmXrBUNA0FmQyDUjlxefA1dFwBbRkbLSPOwIDiXPETsaUav0K/N2L08mUOTbzgJaAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209671; c=relaxed/simple;
	bh=L2wyIGgedpTJCbHcAgpuIAhV9V7N0kd02PPghvhjUIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JjaohKYM2gX/L/6vJBeycVZH8Mls90pWeY1rYZMg/zEqmlsbulD7zt2v80+1JXI+QJHozwow0rZ4Wm4TzpgbXa11pFmxf2TCbZEFTwa/dP/hIy4BKe1y9k9tQUkiYLqzZAqJI3pKLgffLyru1f0UsT9rgVVaEhHVrLHE0LwPxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I9QQUm6a; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b25263a3so398707f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726209667; x=1726814467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iRc9fckf2OjVWeB2nRXRDBRcjqYzCFGcXkB26HnfC88=;
        b=I9QQUm6aL9FmURDUNiJv9WqltPc5VtJwE0SFq5mJayJZ4P8gnixNWmKMAcqeUG5yo3
         UfItcr0NcUTUucb5lIOL9bXjLsgV9oJAi+63oxWYdrh9qFUuCwacYlAD3mIXKRZ0njcr
         qbkO3mNR7zIPdmpCih5XIBLX41GvnJjT/nbpBJp6k1wIlQskVYpbaT3M4WjiLEY2ZtVv
         zpN25iJQl9RpLJPqGDeaWOANPXw3jCjgoaI/KF2kLXAAimMzWHoTfbc7FtHYGLrTLQUz
         XBxQSd/GnwUG/KulWBWO01dGZ3ONKQPb7q+Jism7qu4LixUgUhL6uvOP+2BlGXG1Fs0x
         68Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726209667; x=1726814467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRc9fckf2OjVWeB2nRXRDBRcjqYzCFGcXkB26HnfC88=;
        b=mi7aeONgl4B7uunhGoXKlugwhVGtUmqTkkUlpWBeMyz3K8btjuQrRPKmRHWO73paqp
         bht7ta7GwrCAA8YfTQJ+JDZYgEWeYv+J2MXtmzA7j/J66uTnVd6mCbsuTFxx0oUNvG/d
         5haaOFL1cJ+P77lsYaWAsCtI93LEu4LwBYoBPXgWMeTVV89fz1T0k/cahEW00CtDmd92
         ztse0S20547mhrDshso5jB6FRLIgMZ5SkOM8TrIMxip6wMTeaAeLzLGBTs4iWAqJK4hv
         1b6LtvAZdY+Rjy83g/gXalafsOLmiX5cFomor7wh0d1sVPC3P1oVBklRCth/LqX8c5FE
         P7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMQByJHnYqDUU5bSQV7CLstDQFtUPiRh3mmdHn3ro+v6QXB31T5WfLN3WdP4BIpXJ0vEtftEO/q6sGjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyduwJzJM9jecIp2ds0xcpP6vDo3jy6E9/H861EFGXUko4SeLNK
	ge9dJv1t+67OIq3AZwsr8LhSe537V8zbmsXst9yPN5LDEhg0zXLhxbuQ89dy+0wqo9vCUQixwWK
	8
X-Google-Smtp-Source: AGHT+IHve6pMPKd2vgJPkwLCithY+nEpQOmxQFKAHmHs65sb7kVpspt7UKQ1dGYdcUDQKJMpJ5geSg==
X-Received: by 2002:a05:6000:ecf:b0:374:c35a:7335 with SMTP id ffacd0b85a97d-378d61e284fmr743373f8f.18.1726209666159;
        Thu, 12 Sep 2024 23:41:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe5434sm5512205b3a.52.2024.09.12.23.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 23:41:05 -0700 (PDT)
Message-ID: <395d5a08-ba15-443c-bdeb-d1506600662e@suse.com>
Date: Fri, 13 Sep 2024 16:11:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
 <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
 <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
 <c275d2c9-20d9-46ce-82ab-3f86c091a5d3@archlinux.org>
 <84938a9c-97ba-4f90-8e66-bdfabf455146@gmx.com>
 <0c9fe0ac-9a98-4f72-bb87-361070c32772@archlinux.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <0c9fe0ac-9a98-4f72-bb87-361070c32772@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/13 15:24, Archange 写道:
> Le 13/09/2024 à 09:29, Qu Wenruo a écrit :
>> 在 2024/9/13 14:55, Archange 写道:
>> [...]
>>>> And it's indeed a false alert.
>>>>
>>>> In that case, as long as you still have unallocated space, you can
>>>> just relocate the system chunks:
>>>>
>>>> # btrfs balacne start -s <mnt>
>>>>
>>>> Which should move the system chunks to new locations and will not
>>>> utilize the first 1MiB reserved space.
>>>
>>> # btrfs balance start -s /
>>> ERROR: Refusing to explicitly operate on system chunks.
>>> Pass --force if you really want to do that.
>>>
>>> According to https://btrfs.readthedocs.io/en/latest/btrfs-balance.html,
>>> -s requires -f, so I guess I should continue with that?
>>
>> Yes.
> 
> Hum, no success:
> 
> # btrfs balance start -s --force /
> ERROR: error during balancing '/': No space left on device
> There may be more info in syslog - try dmesg | tail
> 
> # dmesg
> [ 2919.917607] BTRFS info (device dm-0): balance: start -f -s
> [ 2919.918105] BTRFS info (device dm-0): 1 enospc errors during balance
> [ 2919.918108] BTRFS info (device dm-0): balance: ended with status: -28
> 
> Indeed,
> 
> # btrfs filesystem show /dev/mapper/root
> Label: 'root'  uuid: e6614f01-6f56-4776-8b0a-c260089c35e7
>      Total devices 1 FS bytes used 439.69GiB
>      devid    1 size 476.87GiB used 476.87GiB path /dev/mapper/root
> 
> There is unused space though, but not sure how to reclaim it.
> 
> $ btrfs filesystem df /
> Data, single: total=472.87GiB, used=438.21GiB
> System, single: total=4.00MiB, used=80.00KiB
> Metadata, single: total=4.00GiB, used=1.48GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

This means most of the "free" space is inside data chunks.

You will need to free up some continuous data space, or use different 
"usage=" filters for data and metadata, or both.

Thankfully your metadata has enough free space, so not an urgent situation.

Thanks,
Qu
> 
> As advised on the balance page, I’ve tried to run with `usage=0` as 
> filter (for both m, s and d), but the result is always:
> 
> Done, had to relocate 0 out of 480 chunks
> 
>> And I also recommend to convert your metadata and system chunks to DUP,
>> if there are enough unallocated space.
>> (If have more devices then RAID1).
>>
>> It looks like the old mkfs defaults to SINGLE for SSDs, but nowadays we
>> keep DUP no matter if it's SSD or not.
> 
> Alright, but I guess I need to solve -ENOSPC first…
> 
> Thanks,
> Archange
> 

