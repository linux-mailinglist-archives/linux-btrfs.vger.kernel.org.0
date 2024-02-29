Return-Path: <linux-btrfs+bounces-2954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DD86D6EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B742878CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD90381AA;
	Thu, 29 Feb 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I/6LbYGK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10242200A6
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246600; cv=none; b=ItzUEBreTmY0+cYktj+e7aXzEI8X3CBWx9yjEHzs2Ux55ePoKfq+dEcw4RUPcxO/qjW7W8CaKV+wW7GdmqnlFXAU3u8xFCCn4reqZWT/6CCU4BXSnzAFKe9chdzE8UbWbTbp5CJ6hqVLmvicSFt2j4RWb1vf7WMBZuBAGRF3Ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246600; c=relaxed/simple;
	bh=YSAxvckeO4ZuhDRxZTLzWR7r6mpCOsNuLq9Nh6Irm3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dt3BwtYYma2hR5giZyWRyl1LA5Ix7OWSiaU/tJ6z0Hyfn/LV2BP0XEcmW0S34gfx9v2ESnecq4WkyLL/bfrNV2E+ffechVw5NRk3NMEPq9y6Q56QCIAnTBkXQfNSW4LTSWL+FTrYpZDBxCvW5V7lYXoeIyhRpQE3sD3lLG8LTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I/6LbYGK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bde3d197so1429734e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709246596; x=1709851396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSKOOAGk9osl6vJ5sno9k2xJRSG6CSocJGKejz2PBwg=;
        b=I/6LbYGKk+n3G03aa631+wplmu3343bMkWqyNXD5Y0pfbHoVgl6bjkqguhd7+HXAPe
         CR0EK0Xsi3TQ6QcXmhdQrZVZyJ1nyrWxDP2G2v03Pkv4Pbpb/9kfyYBTulAIkKMm6RK5
         PpwwCoo+9Yl9sOGinvB7/kdu5gowlYiVdPPyiotuqYjWcVjj/ZwoD8fJ3kyO2s1P/AQh
         CFVsP9gMOmvDaVP7auPrUPDljYk+Nj96V1th2AWUu5hJu8kC+uKLIu4sBe3zxLwu2Dmd
         2f+ZgG1C1Ix3hhR8pb3HRkk6eX4y7hVeJhZahPl4BM3yz30zkyZhPfSPCPhDQh8g14PX
         6YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246596; x=1709851396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSKOOAGk9osl6vJ5sno9k2xJRSG6CSocJGKejz2PBwg=;
        b=lU+KXYrMwW+gTZwLo9Tt7vcc50Ch3XOyTpvKv1g23fbNIsmEyoVIi03CEgC2H2HdM/
         O2ywyJjvfwZZ+rX6iGcmTtT+f+yMJZzReZhPUHmbifqjhIdwZVk9044IS5MnThHBP275
         4gkNjMqooB2lE3VpxyvZIcmoHI/7gqWEkG6O0SPKjWjTkHq8SPJ0ihV2rQA8oK/9zlxK
         BNoClSXJ6sYMY/fYIgzqzGll17X+y/zry4yrhkyZkJ0V0SAHT9JRb/frS9Hf4uB+2lc3
         OOLk2Z5pdoYxpaGuPoDcJjyLw723Ohs6gVHM7bw0pbukW8QFYtKUIq2kKc9u2Bu0d3dM
         qWfg==
X-Forwarded-Encrypted: i=1; AJvYcCVo7d5ck7gdatoi+df1uAJPN5DPbKPw/sKIbCEeVW1WTUAIsMMmqH+3td1JUpy5K8SGAiD49dg7xJSKmflTBm1zp3AiRotaudH/dqA=
X-Gm-Message-State: AOJu0YxPGJl9S3c0SBF/hoBW34ACrDFG5SMltPXvYRFwxWsStSvyACjM
	mX2E1WVjNTOns+N7cqRPUxL8KbZUURwsdEhJ1Jq56rPdSbNDYGSluWs2IVHVa3M=
X-Google-Smtp-Source: AGHT+IEwmww/spekHhZ7Br7FkL7H3YzUeXqf3m1My0mJtrthYjU2rzo4r+lR9+mWFI7IybN0CAb7kg==
X-Received: by 2002:ac2:5985:0:b0:512:fe3d:a991 with SMTP id w5-20020ac25985000000b00512fe3da991mr2185277lfn.61.1709246596128;
        Thu, 29 Feb 2024 14:43:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b006e58920c572sm1773140pfa.128.2024.02.29.14.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:43:15 -0800 (PST)
Message-ID: <ccafcbe4-dc05-4b49-8be0-651c08d9171d@suse.com>
Date: Fri, 1 Mar 2024 09:13:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zero sized file that should have 512KB size with 6.6
Content-Language: en-US
To: Martin Raiber <martin@urbackup.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102018df1b2a3a2-9359bfe7-9155-4af6-a0d1-7cee1faf77e4-000000@eu-west-1.amazonses.com>
 <103dacd5-d97c-42e2-8a13-39d1800a85bf@gmx.com>
 <0102018df692cd2a-d4b9b332-cd3e-4cf1-b1e3-469381c2dd5f-000000@eu-west-1.amazonses.com>
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
In-Reply-To: <0102018df692cd2a-d4b9b332-cd3e-4cf1-b1e3-469381c2dd5f-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/1 07:03, Martin Raiber 写道:
> On 29.02.2024 04:02 Qu Wenruo wrote:
>>
>>
>> 在 2024/2/29 08:20, Martin Raiber 写道:
>>> Hi,
>>>
>>> when upgrading to kernel 6.6 I have a zero sized file after a few days
>>> of running. I'm pretty sure the app has written 512KB into this file
>>> (using normal write()). Yet stat etc. return zero. But fiemap has some
>>> extents!
>>
>> Have you found a reliable way to reproduce such files manually?
>> Or that application is required to create such files?
> 
> Thanks. No, I'll try to think of a way to make this more reproducable. I 
> think as a next step I'll disable compression.
> 
> One unusal thing might be that shortly after creating the file with a 
> few pwrite() calls it writes into the file using io_uring splice. But 
> idk from logs if it then had size zero afterwards or if that came later.
> 
>>
>> If you have a reproducer that would be a perfect case for us to fix (and
>> add a test case for it).
>>
>>>
>>> The machine is not power cycled or restarted between the writing and the
>>> zero size issue.
>>>
>>> Kernel 6.6.17 mounted with
>>> rw,noatime,compress=lzo,ssd,discard=async,nospace_cache,skip_balance,metadata_ratio=8,subvolid=5,subvol=/
>>> Running with ECC RAM (but data=single on one device).
>>>
>>> $ filefrag -v ./73c0138c00
>>> Filesystem type is: 9123683e
>>> File size of ./73c0138c00 is 0 (0 blocks of 4096 bytes)
>>>   ext:     logical_offset:        physical_offset: length: expected: 
>>> flags:
>>>     0:       32..      63:  229943374.. 229943405:     32: 32: 
>>> encoded,eof
>>>     1:       64..      95:  231710261.. 231710292:     32: 229943406:
>>> encoded,eof
>>>     2:       96..     127:  231741406.. 231741437:     32: 231710293:
>>> last,encoded,eof
>>> ./73c0138c00: 3 extents found
>>>
>>> $ stat ./73c0138c00
>>>    File: ./73c0138c00
>>>    Size: 0               Blocks: 768        IO Block: 4096 regular empty
>>> file
>>> Device: 34h/52d Inode: 424931256   Links: 1
>>> Access: (0750/-rwxr-x---)  Uid: (    0/    root)   Gid: (    0/ root)
>>> Access: 2024-02-28 10:52:08.421899782 +0100
>>> Modify: 2024-02-28 10:52:10.809908158 +0100
>>> Change: 2024-02-28 10:52:10.809908158 +0100
>>>   Birth: 2024-02-28 10:52:08.421899782 +0100
>>
>> Could you please dump the contents of the inode?
>>
>> # btrfs ins dump-tree -t 5 <device> | grep -A7 'item .* key (424931256 '
> 
> $ btrfs ins dump-tree -t 6945 /dev/mapper/dev| grep -A7 'item .* key 
> (424931256'
>          item 114 key (424931256 INODE_ITEM 0) itemoff 9161 itemsize 160
>                  generation 2775889 transid 2775890 size 0 nbytes 393216
>                  block group 0 mode 100750 links 1 uid 0 gid 0 rdev 0
>                  sequence 36 flags 0x800(COMPRESS)
>                  atime 1709113928.421899782 (2024-02-28 10:52:08)
>                  ctime 1709113930.809908158 (2024-02-28 10:52:10)
>                  mtime 1709113930.809908158 (2024-02-28 10:52:10)
>                  otime 1709113928.421899782 (2024-02-28 10:52:08)
>          item 115 key (424931256 INODE_REF 480) itemoff 9141 itemsize 20
>                  index 1597091 namelen 10 name: 73c0138c00
>          item 116 key (424931256 XATTR_ITEM 550297449) itemoff 9091 
> itemsize 50
>                  location key (0 UNKNOWN.0 0) type XATTR
>                  transid 2775889 data_len 3 name_len 17
>                  name: btrfs.compression
>                  data lzo
>          item 117 key (424931256 EXTENT_DATA 131072) itemoff 9038 
> itemsize 53
>                  generation 2775890 type 1 (regular)
>                  extent data disk byte 941848059904 nr 73728
>                  extent data offset 0 nr 131072 ram 131072
>                  extent compression 2 (lzo)
>          item 118 key (424931256 EXTENT_DATA 262144) itemoff 8985 
> itemsize 53
>                  generation 2775890 type 1 (regular)
>                  extent data disk byte 949085229056 nr 81920
>                  extent data offset 0 nr 131072 ram 131072
>                  extent compression 2 (lzo)
>          item 119 key (424931256 EXTENT_DATA 393216) itemoff 8932 
> itemsize 53
>                  generation 2775890 type 1 (regular)
>                  extent data disk byte 949212798976 nr 65536
>                  extent data offset 0 nr 131072 ram 131072
>                  extent compression 2 (lzo)

Thanks for the dump, really nothing especially wrong, except the file size.

This looks like an ordinary file got truncated to zero size.

It shouldn't be a big problem (except the extra wasted space) for now.

But I still believe we need to check why this is happening.

Thanks,
Qu

>          item 120 key (424931257 INODE_ITEM 0) itemoff 8772 itemsize 160
>                  generation 2775889 transid 2775890 size 524288 nbytes 
> 524288
>                  block group 0 mode 100750 links 1 uid 0 gid 0 rdev 0
> 
>>
>> Thanks,
>> Qu
>>>
>>> * Nothing in dmesg
>>> * Btrfs scrub has no errors
>>> * Rebooting does not fix size
>>> * Btrfs check has no errors
>>>
>>> Let me know if there is anything else I can provide. Will leave this
>>> as-is till the end of this week.
>>>
>>> Regards,
>>> Martin Raiber
>>>
>>>
> 
> 

