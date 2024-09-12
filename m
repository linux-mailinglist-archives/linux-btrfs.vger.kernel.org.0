Return-Path: <linux-btrfs+bounces-7967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929697663A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADDA1C23270
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3919E96F;
	Thu, 12 Sep 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ClFLOa2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332418E043
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135320; cv=none; b=RHqOqJrJWGjcKa6PJ5hbWPAT7z6iVc/BTT4A38bkJX/Pe8kp2rtMQNkKDpJYczXAMAf/bmWAbsVUFtWfmS35ZjfEYttypWapD0pLQ8+VtEwjpJnZhN5C24q8mYNKTQZgT5g4aTeY3E9z8LUbAlffXeMMHFR4wkNjhtq4CzhBWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135320; c=relaxed/simple;
	bh=o9ibao0bP1cW6MZdvlK84ZZ3Hx4TOI3llNjc2Oy58GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N8b/VIuhSEzJafH73AOVAQE9d9NXz//r2qc6CzOcEUiTLejQg7z1CbmYICUR3gylK9DsEkzdiVeueElNllbb9nvc6CERXWY9Ec22uQ5jRpDVyPBCFAHEzhjVdB5GTToxqc+OlabdscImZf3N0a99i5xVH4vZROyB2N5EiMRnF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ClFLOa2L; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365b6bd901so833500e87.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726135317; x=1726740117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn0h35RbgU/c8XVA2LdxU745AV/nO/K5ZZv29Mc5hvE=;
        b=ClFLOa2LX0cJ4K8pNaQhfTfjmXIgQdhCTKYPOIBPL5dnQ5vSBrmQJjV7Tffrk/VR14
         SYlo6U5jqtD3LCXvkWzDoZlGlSsbGhgEZAns8bS9D2tDwfsgSsFEl1YiMIgOSMIGavGb
         LdzJJEByaiU1P6rIV+F/QJMeIHIccU3SqPeAa1oOgrhQ8/XH6zLyVGdgEZlD81eiNgyu
         C1uXW09QDMb42tUMTjKiOH/DYlrvFY9xVpwnjqopCUPEJeHQAsM4efLAtzPoViiQ83IF
         FsnMD1AjSIi2TfDXP3WXa4hZHPUC+rKh367CrOh3zz3gsqbNgplq++XQ5la0gcYPLYju
         eblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135317; x=1726740117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn0h35RbgU/c8XVA2LdxU745AV/nO/K5ZZv29Mc5hvE=;
        b=jptArhLkKPTFnhUqHg/UVwcgQeksix1UpdmNBG1z/jZr4CfQgxT1BlXvAOfFJqbzAP
         EnOZIHKR4tLrV1g/J+GIwFqk3kEupD7waylWa+utn84J58u978XaPcDM26JVQLANpuKh
         HHWPS4nRmb3/9fZ1RZK/60RRMD11B2scl2G4dQBlU/KI+zx3tQ7HAxVGcyWX6I5WiwPQ
         Lzh7tkku/DfBr9VoOhei1sg7374xqY4m1eej90qsZLF9AGGQDdGyL0rqSD8JbNsfWVE9
         44JPVeYWitvpfN6f9Frrlq7VKUJD5qDpj6m2ZK3DUXLLLtEWaJWY8drMxxEtLZrqgDR4
         RnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaA9Gu9vLDezOZMpSNM4tySrDlvJFWxR0BvBkNDQR3kxUjtlJ/oroKEBQoZ/IDna6KP+tRWrh/n4cGwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKyEQroX2rGBrtG+ktDCovw0NBNkdJG2j83xHWm0kmsp5k5fGe
	6iDLO+5wcwrrAdXWeuy7GX7WkIrs/JgZbwuQf+dGN0R/2gEeLNWSDMvoYWV5bJg=
X-Google-Smtp-Source: AGHT+IFM2z3ztL7CElyUWn5RU591kryTfQQkqQkQ6eTl8sU/RO377gl61sfr/Orn6A9TdN+PKYrxCQ==
X-Received: by 2002:a05:6512:1153:b0:533:466d:698c with SMTP id 2adb3069b0e04-53678feb525mr1223578e87.39.1726135315944;
        Thu, 12 Sep 2024 03:01:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddd501sm1391971a12.71.2024.09.12.03.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:01:55 -0700 (PDT)
Message-ID: <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
Date: Thu, 12 Sep 2024 19:31:51 +0930
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
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
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
In-Reply-To: <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/12 19:27, Archange 写道:
> Le 12/09/2024 à 12:25, Qu Wenruo a écrit :
>> 在 2024/9/12 17:51, Archange 写道:
>>> Le 12/09/2024 à 02:34, Qu Wenruo a écrit :
>>>> 在 2024/9/12 07:35, Archange 写道:
>>>>>
>>>>> Le 12/09/2024 à 01:23, Qu Wenruo a écrit :
>>>> [...]
>>>>>
>>>>> While the previous one (see my second message in this thread) had no
>>>>> error, there is now one:
>>>>>
>>>>> # btrfs check /dev/mapper/rootext
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/mapper/rootext
>>>>> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> wanted bytes 688128, found 720896 for off 676326604800
>>>>> cache appears valid but isn't 676326604800
>>>>
>>>> Minor problem, still I'd recommend to run
>>>>  `btrfs rescue clear-space-cache v1 <dev>` to clear the v1 cache first.
>>>
>>> I indeed did that as explained in the second part of my message.
>>>
>>>> Then you can mount with v2 space cache or keep going with the v1 cache
>>>> (not recommended, will be deprecated soon)
>>>
>>> Done too.
>>>
>>>> And if your fs only have subvolumes 5 (the top level one), 257 and 258,
>>>> then you're totally fine to continue.
>>>> I guess that's the case?
>>>
>>> Indeed!
>>
>> Just in case, you can run "btrfs check --mode=lowmem" to check if there
>> is no more inode cache left.
>>
>> If there is any left, lowmem mode can detect it with errors like:
>>
>> ERROR: root 5 INODE[18446744073709551604] nlink(1) not equal to
>> inode_refs(0)
>> ERROR: invalid imode mode bits: 00
>> ERROR: invalid inode generation 18446744073709551604 or transid 1 for
>> ino 18446744073709551605, expect [0, 72)
>> ERROR: root 5 INODE[18446744073709551605] is orphan item
>>
>> And I'm already adding the ability to the original mode check to detect
>> such problem.
> 
> No such thing appeared during the lowmem check. Only the
> 
> [3/7] checking free space tree
> there is no free space entry for 0-65536
> cache appears valid but isn't 0

Then it's totally fine.

For the 0-65536 problem, mind to provide the following dump?

# btrfs ins dump-tree -t fst <device>

I'm afraid since the fs is somewhat old, there may be some corner case 
btrfs-check is not handling properly.

Thanks,
Qu

> 
> is still there.
> 
> Archange
> 
> 

