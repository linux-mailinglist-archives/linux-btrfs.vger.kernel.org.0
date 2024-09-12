Return-Path: <linux-btrfs+bounces-7958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD55976322
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405471F22184
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359218C033;
	Thu, 12 Sep 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NZWxUr78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA012D20D
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126920; cv=none; b=Z01IFVqOu3jDbubd401wlT7BbglDNUGAAohU07gyITFyTBmf2+N/Zpixi707AAUHUw09U0vFtUYPcm4OvcexYGcqki7Z5VUDeGX91dASkKGiWDQdoS1p5my4LJW53dwo72yivi5zkogGa5i5ocZ0gitwlT2B5gk3Z3E5Dzt5O4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126920; c=relaxed/simple;
	bh=kvnsdIOAcGUDkPr+Odrf+tG3NxUDbXl6IFQxbZX2Iyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3Dc2IsZB9RvtawBb6zC+x1a1cwLyq63+NNRbymwigGGhCHHm3ulTXFdwanNMSm3VOEdeUvdS6WDmaHhBTjb1UmY5xRi9oig9CWsrTvmDRgMaBBcLKNPq9FV7QsZGOS9g6ucStgcNzAYBByglakapD9MZz75EtdonFcKqVs72e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NZWxUr78; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371ba7e46easo551050f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726126916; x=1726731716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AdFdZYVolg+LgyBri9QXHruQCtTBNAFtdTb9Yr/fC0w=;
        b=NZWxUr78khzrvN48uHBh8BONOJr18SPcf4/szFhPt/R+XZcsUxjNWmjgy1b3ncZLLr
         lDuUG/E7voR2U8BbI1mAmDkHyoWGZQwzXmJsPg1aJe7xE8Zi7CslmcHtkGoMtm2vo+sB
         BFUX2/OzZIv4Lr2q6cbdMy2YGIlgVdglZJ50yhcnCLWLdYmKBZ7uzo8jJGldWYbEhXSm
         qv/QGAHroz3YhRNwneBsFoTZolyXvM3Ul2iQx70exuHJXTfXf8hs1A8EKMtcKygiibdW
         0W7lQilYxxjHrQtTJCGY2Y9BfLeyiAKAxHJJePiNhxs7pvk8T7w8h+PRSoQGEoS5YDkD
         sV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126916; x=1726731716;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdFdZYVolg+LgyBri9QXHruQCtTBNAFtdTb9Yr/fC0w=;
        b=cICc0EWjGb6WdK1E8vPvX89mqd4eKx342blqgyV4OTgYip6W/jpbafzDtXyO+mbNXa
         pkAG3LxmIuxH/SkR5q0dIsu9j95XlJhSJd4rJg/yChCeDVKJsYw6eSSzILBZDoOQ/m7+
         uX397ElVfcJ4rk7mlwqSMyc/mwczdHsMsg+EMa6n+aldS1xlAXqWhjrLVdrK65ntw6yT
         vWITNo+Q93tnkNR40To1tlFCHi9C/egoruQfzGa977b9sRbQxXNYiWUJ/GWs5GVGMAni
         RZcM0UXSkxh4JWrz9JZd90dy41c7EkIaIwbz1iqN32TNvUyYHG4uWpGxL2f/xP/RYGJk
         xefQ==
X-Gm-Message-State: AOJu0YwqYaPVUIH/9XTajdsgcFpgMJoRlJ9A14fABxejXg81V5cFN8e1
	+gltrcOD9crHitGn7IgSulIwVmINvxDulZY5zDhvqTm/dqsnwGvcyD1cLuyHHDs=
X-Google-Smtp-Source: AGHT+IEek2qiCvwVTVB1o5gfB4j7OW7UWO7sdnIyg8vFE6XYu+j17N45z2Ql3qwwwOqu9z+jRNma+w==
X-Received: by 2002:a05:6000:50c:b0:371:a8a3:f9a1 with SMTP id ffacd0b85a97d-378c2cd3e4bmr1062307f8f.11.1726126915386;
        Thu, 12 Sep 2024 00:41:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04136bc9sm9832517a91.1.2024.09.12.00.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:41:54 -0700 (PDT)
Message-ID: <1054d33d-1395-448b-8d7e-f8eeb1f8345d@suse.com>
Date: Thu, 12 Sep 2024 17:11:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
 <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
 <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
 <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
 <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
 <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
 <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
 <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
 <30da9047-87a2-4d1f-b132-3153c74279d5@gmx.com>
 <CAAYHqBa2hD7UparX2mHo4jmt96Kpmb6TbYXiZpWdiE53ikzE2w@mail.gmail.com>
 <5949cd07-59c8-4012-9865-0fdd3e9bcc6e@gmx.com>
 <CAAYHqBb=PeWNF3dHJzNGH3sn8pAo5wPN4T_DOQjZwakaTFmNkA@mail.gmail.com>
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
In-Reply-To: <CAAYHqBb=PeWNF3dHJzNGH3sn8pAo5wPN4T_DOQjZwakaTFmNkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/12 16:58, Neil Parton 写道:
> OK thanks, will that make it into an upcoming btrfs-progs release?

I hope it will be included into v6.11 release.

> This is starting to get beyond my routine abilities!

Unfortunately my distro doesn't provide static libs, so I can not build 
a static version for you.

Meanwhile it is not that hard to follow the README of btrfs-progs to 
build one by yourself.

Thanks,
Qu

> 
> On Thu, 12 Sept 2024 at 07:54, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/9/12 16:13, Neil Parton 写道:
>>> I left a scrub running overnight and woke up this morning to find that
>>> the scrub is still running but the fs has become ro again.
>>>
>>> I have a new hdd waiting to be swapped in for sdc, how can I run a
>>> btrfs replace if the filesystem won't stay in rw?  dmesg output below
>>>
>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
>>> 75c9efec-6867-4c02-be5c-8d106b352286
>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
>>> checksum algorithm
>>> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
>>> [    6.064092] BTRFS info (device sdc): using free space tree
>>> [   76.647420] BTRFS error (device sdc): level verify failed on
>>> logical 313163105075200 mirror 2 wanted 0 found 1
>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
>>> [  260.968635] BTRFS error (device sdc): parent transid verify failed
>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
>>> [ 2803.367836] BTRFS warning (device sdc): tree block 313163165237248
>>> mirror 2 has bad generation, has 12746888 want 12746900
>>> [ 2803.470703] BTRFS error (device sdc): fixed up error at logical
>>> 313163165204480 on dev /dev/sdc physical 586324377600
>>> [ 2803.470787] BTRFS error (device sdc): fixed up error at logical
>>> 313163165204480 on dev /dev/sdc physical 586324377600
>>> [ 2803.470847] BTRFS error (device sdc): fixed up error at logical
>>> 313163165204480 on dev /dev/sdc physical 586324377600
>>> [ 2803.470904] BTRFS error (device sdc): fixed up error at logical
>>> 313163165204480 on dev /dev/sdc physical 586324377600
>>> [40675.013231] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [40675.013337] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 1
>>> [40675.165371] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [40675.165477] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 2
>>> [40675.303196] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [40675.303301] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 3
>>> [40675.304132] BTRFS info (device sdc): scrub: not finished on devid
>>> 12 with status: -5
>>> [49340.321632] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [49340.321780] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 1
>>> [49340.424554] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [49340.424698] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 2
>>> [49340.498068] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [49340.498213] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 3
>>> [49340.505620] BTRFS info (device sdc): scrub: not finished on devid
>>> 15 with status: -5
>>> [65972.755968] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [65972.756043] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 2
>>> [65972.765683] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>> [65972.765759] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 1
>>> [65972.802812] BTRFS critical (device sdc): corrupt leaf:
>>> block=334871673176064 slot=24 extent bytenr=333252139892736 len=36864
>>> invalid data ref objectid value 65241
>>
>> This is the same problem as the old inode cache.
>>
>> It looks like the existing bug in "btrfs rescue clear-ino-cache" is not
>> fully deleting all ino cache.
>>
>> You can go with this btrfs-progs branch:
>>
>> https://github.com/adam900710/btrfs-progs/tree/ino_clear_fix
>>
>> Which should fix the bug in "btrfs rescue clear-ino-cache", and clear
>> all ino caches.
>>
>> Thanks,
>> Qu
>>
>>> [65972.802887] BTRFS error (device sdc): read time tree block
>>> corruption detected on logical 334871673176064 mirror 3
>>> [65972.802977] BTRFS error (device sdc): failed to run delayed ref for
>>> logical 333252141424640 num_bytes 49152 type 178 action 1 ref_mod 1:
>>> -5
>>> [65972.803040] BTRFS error (device sdc: state A): Transaction aborted (error -5)
>>> [65972.803073] BTRFS: error (device sdc: state A) in
>>> btrfs_run_delayed_refs:2168: errno=-5 IO failure
>>> [65972.803110] BTRFS info (device sdc: state EA): forced readonly
>>>
>>> On Wed, 11 Sept 2024 at 11:31, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2024/9/11 19:37, Neil Parton 写道:
>>>>> SMART looks ok on all 4 drives
>>>>>
>>>>> btrfs-map-logical -l 313163116052480 /dev/sdc
>>>>> parent transid verify failed on 332196885348352 wanted 12747065 found 12747069
>>>>> parent transid verify failed on 332196885348352 wanted 12747065 found 12747069
>>>>> parent transid verify failed on 332196885348352 wanted 12747065 found 12747069
>>>>> ERROR: failed to read block groups: Input/output error
>>>>> ERROR: open ctree failed
>>>>>
>>>>> /dev/sdc is the drive that originally started giving tree and leaf
>>>>> errors 2 days ago so definitely looking to replace that with the new
>>>>> drive tomorrow once the scrub has completed.
>>>>>
>>>>> However the above map command for sda returns nothing, but for sdb and sdd:
>>>>>
>>>>> btrfs-map-logical -l 313163116052480 /dev/sdb
>>>>> parent transid verify failed on 332196960649216 wanted 12747071 found 12747073
>>>>> parent transid verify failed on 332196960649216 wanted 12747071 found 12747073
>>>>> parent transid verify failed on 332196960649216 wanted 12747071 found 12747073
>>>>> ERROR: failed to read block groups: Input/output error
>>>>> ERROR: open ctree failed
>>>>>
>>>>> btrfs-map-logical -l 313163116052480 /dev/sdd
>>>>> parent transid verify failed on 332197012652032 wanted 12747073 found 12747075
>>>>> parent transid verify failed on 332197012652032 wanted 12747073 found 12747075
>>>>> parent transid verify failed on 332197012652032 wanted 12747073 found 12747075
>>>>> ERROR: failed to read block groups: Input/output error
>>>>> ERROR: open ctree failed
>>>>>
>>>>> I'm guessing this is due to raid1c3 on the metadata?
>>>>
>>>> Is the fs mounted? Or it means the fs is fully corrupted.
>>>>
>>>> I'm not aware of any way to do the same chunk mapping with a mounted fs.
>>>>
>>>> But since you're sure the problem is from sdc, then it should be fine.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> On Wed, 11 Sept 2024 at 10:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> 在 2024/9/11 19:08, Neil Parton 写道:
>>>>>>> OK I have a new drive on the way which I was going to use to copy data
>>>>>>> on to, but will now replace /dev/sdc to be on the safe side.  SMART
>>>>>>> looks ok but don't want to go through this again!
>>>>>>>
>>>>>>> Maybe it was a bit flip?
>>>>>>
>>>>>> Nope, bitflip should not lead to a single mirror corruption, but all
>>>>>> mirrors corrupted.
>>>>>>
>>>>>> This looks more like that specific disk (mirror 2 of that logical
>>>>>> bytenr) is not fully following the FLUSH command.
>>>>>>
>>>>>> Thus some writes doesn't really reach disk but it still reports the
>>>>>> FLUSH is finished.
>>>>>>
>>>>>> Furthermore only two tree blocks are affected, which may just mean the
>>>>>> disk is only dropping part of the writes.
>>>>>> Or you should have at least 4 tree blocks (root, subvolume(s), extent,
>>>>>> free space trees) affected.
>>>>>>
>>>>>> This behavior will eventually leads to transid mismatch on a power loss.
>>>>>> It's the other mirror(s) saving the day.
>>>>>>
>>>>>> And before replacing the disk, please really making sure that
>>>>>> "btrfs-map-logical" is really reporting the mirror 2 is sdc, or you can
>>>>>> still keep a bad disk in the array.
>>>>>>
>>>>>>
>>>>>> Just keep running RAID1* for metadata, that's really a good practice.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 在 2024/9/11 18:59, Neil Parton 写道:
>>>>>>>>> dmesg | grep BTRFS
>>>>>>>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
>>>>>>>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
>>>>>>>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
>>>>>>>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
>>>>>>>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
>>>>>>>>> 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
>>>>>>>>> checksum algorithm
>>>>>>>>> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
>>>>>>>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
>>>>>>>>> [    6.064092] BTRFS info (device sdc): using free space tree
>>>>>>>>> [   76.647420] BTRFS error (device sdc): level verify failed on
>>>>>>>>> logical 313163105075200 mirror 2 wanted 0 found 1
>>>>>>>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
>>>>>>>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
>>>>>>>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
>>>>>>>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
>>>>>>>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
>>>>>>>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
>>>>>>>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
>>>>>>>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
>>>>>>>>> [  260.968635] BTRFS error (device sdc): parent transid verify failed
>>>>>>>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
>>>>>>>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
>>>>>>>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
>>>>>>>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
>>>>>>>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
>>>>>>>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
>>>>>>>>
>>>>>>>> All happen on mirror 2.
>>>>>>>>
>>>>>>>> You can locate the device by:
>>>>>>>>
>>>>>>>> # btrfs-map-logical -l 313163116052480 /dev/sdc
>>>>>>>>
>>>>>>>> Which gives the device path.
>>>>>>>>
>>>>>>>> I would recommend to check the device's smart log and cables just in case.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 在 2024/9/11 18:31, Neil Parton 写道:
>>>>>>>>>>> Many thanks Qu, I appear to be back up and running but I also had to
>>>>>>>>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
>>>>>>>>>>> super-recover said the superblock was fine.
>>>>>>>>>>
>>>>>>>>>> This is not expected. I believe btrfs-rescue should check log trees
>>>>>>>>>> before doing the operation.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On reboot and remount (as normal) I have a couple of residual transid
>>>>>>>>>>> errors and I'm currently running a full scrub to try and clean things
>>>>>>>>>>> up.
>>>>>>>>>>
>>>>>>>>>> Transid is also not expected, if the transid error persists, it's a huge
>>>>>>>>>> problem.
>>>>>>>>>>
>>>>>>>>>> Does the transid only shows on certain mirrors?
>>>>>>>>>>
>>>>>>>>>> Anyway a full dmesg from the first transid mismsatch will help a lot to
>>>>>>>>>> find out what's really going wrong.
>>>>>>>>>>
>>>>>>>>>> I hope it's really just the bad log trees.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>>
>>>>>>>>>>> Hopefully though I'm back up and running, this is the longest the FS
>>>>>>>>>>> has been mounted in 48 hours without it reverting to ro!
>>>>>>>>>>>
>>>>>>>>>>> Can't thank you enough for your help. I hope I'm not premature in
>>>>>>>>>>> thanking you / will report back with any more errors.
>>>>>>>>>>>
>>>>>>>>>>> Regards
>>>>>>>>>>>
>>>>>>>>>>> Neil
>>>>>>>>>>>
>>>>>>>>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 在 2024/9/11 17:43, Neil Parton 写道:
>>>>>>>>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
>>>>>>>>>>>>> the array?
>>>>>>>>>>>>
>>>>>>>>>>>> Run it on any device of the fs.
>>>>>>>>>>>>
>>>>>>>>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>>>>>>>>>>>
>>>>>>>>>>>> And you must run the command with the fs unmounted.
>>>>>>>>>>>>
>>>>>>>>>>>>>        Reason I ask is when this first occurred it was one
>>>>>>>>>>>>> particular drive reporting errors and now after switching out cables
>>>>>>>>>>>>> and to a different hard drive controller it's a different drive
>>>>>>>>>>>>> reporting errors.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's also worth noting that this array was originally created on a
>>>>>>>>>>>>> Debian system some 6-8 years ago and I've gradually upgraded the
>>>>>>>>>>>>> drives over time to increase capacity, I'm up to drive ID 16 now to
>>>>>>>>>>>>> give you an idea.  Does that mean there are other gremlins potentially
>>>>>>>>>>>>> lurking behind the scenes?
>>>>>>>>>>>>
>>>>>>>>>>>> Nope, this is really limited to that inode_cache mount option.
>>>>>>>>>>>> I guess you mounted it once with inode_cache, but kernel never cleans
>>>>>>>>>>>> that up, and until that feature is fully deprecated, and newer
>>>>>>>>>>>> tree-checker consider it invalid, and trigger the problem.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 在 2024/9/11 17:24, Neil Parton 写道:
>>>>>>>>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will run a
>>>>>>>>>>>>>>> lowmem command next and report back once finished (takes a while)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>> Checking filesystem on /dev/sda
>>>>>>>>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>>>>>>>> [1/7] checking root items
>>>>>>>>>>>>>>> [2/7] checking extents
>>>>>>>>>>>>>>> [3/7] checking free space tree
>>>>>>>>>>>>>>> [4/7] checking fs roots
>>>>>>>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>>>>>>> [6/7] checking root refs
>>>>>>>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>>>>>>>> found 24251238731776 bytes used, no error found
>>>>>>>>>>>>>>> total csum bytes: 23630850888
>>>>>>>>>>>>>>> total tree bytes: 25387204608
>>>>>>>>>>>>>>> total fs tree bytes: 586088448
>>>>>>>>>>>>>>> total extent tree bytes: 446742528
>>>>>>>>>>>>>>> btree space waste bytes: 751229234
>>>>>>>>>>>>>>> file data blocks allocated: 132265579855872
>>>>>>>>>>>>>>>          referenced 23958365622272
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> When the error first occurred I didn't manage to capture what was in
>>>>>>>>>>>>>>> dmesg, but far more info seemed to be printed to the screen when I
>>>>>>>>>>>>>>> check on subsequent tries, I have some photos of these messages but no
>>>>>>>>>>>>>>> text output, but can try again with some mount commands after the
>>>>>>>>>>>>>>> check has completed.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> dump as requested:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>>>                         refs 1 gen 12567531 flags DATA
>>>>>>>>>>>>>>>                         (178 0x674d52ffce820576) extent data backref root 2543
>>>>>>>>>>>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is the cause of the tree-checker.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Unfortunately that feature is no longer supported, thus being rejected.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm very surprised that someone has even used that feature.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For now, it can be cleared by the following command:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>          # btrfs rescue clear-ino-cache /dev/sda
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Then kernel will no longer rejects it anymore.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>
>>>>>>>
>>>>>

