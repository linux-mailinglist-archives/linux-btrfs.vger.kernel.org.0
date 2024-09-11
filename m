Return-Path: <linux-btrfs+bounces-7937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB38974EA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE391C20C12
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBC4190675;
	Wed, 11 Sep 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WxFux9yO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421141865EE
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047184; cv=none; b=rX1FzZKrZLKjwem/zH0IVShfhZrlC4jnBK+5eXO7IZTygwDyznwR2V5J4pa3tanfQGk49/rLWSf/FwRpFj18gf64NtB8z7VmwWg9emJ5z11o2IEw/gOwS1oI/qIWse7A4lRb7PxdlLYQJyHzsZHryjoSPiUYkSb5tknhVKh1veU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047184; c=relaxed/simple;
	bh=eEcaAMQbTXBgoOhjT3RZO1YuBIZQMLUEtfQMKFwp/fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boA4FA6U5ZWKu1k86KGesYCZM86+YpeNAnJoKgBeOZbt+mUrSLnfNONy+oqJ1p505oBPnu368ZfyNRR8n5WOcntXgMfutFZKeU2t/OYoExXJHbr7+FbgsfdZ1bFc15fQhdBVekyxEHMuRXzrhgnjddePdFK8b5EvKZRf9c2eF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WxFux9yO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-536584f6c84so6777946e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726047179; x=1726651979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ljjg2cci7wmIckP2fo0OdZRIbxCZkYUC+v9ylPC9lAY=;
        b=WxFux9yOevxfxM+VGQn9bXcNm3MpVKBnX1V8R9X3AkJ2qUtFwn71TbiATn2fx5uHLn
         XjtMmUgxl99oDO6H53K+uiQhqixnut9oY+1DWx+pR3fnhW2lFAMYLMgb+52SNhbzaxiQ
         gDFLqhTnByASZhLesu19fN5THKbBNDB5yAr4ybgm3MY242ZBI8dITBAOWDuxhNCRsJ7M
         JQHf66tyVyYSkwqFhGU5rZmF+mRQCSErVsxk0lyJGwe6c8vQ4qxT3lN53cmsAaYDJqft
         zjUF7WaOBg8MUbBwoc1la3Yp5vo8DQtMhbENCr1cYOM+Z8QQCmymzCpARh/Pa3thTtYa
         nWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047179; x=1726651979;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljjg2cci7wmIckP2fo0OdZRIbxCZkYUC+v9ylPC9lAY=;
        b=RV56AtIx43sa2mCiiD3FMihfhxWjpe7shK9/8/HhVzhG35jNz8AotjOA/cveHDx69p
         gjNnjhhuBQ0sZh5KnL8AewnFlOLdCpH9cC2CiL5CKiMlGr5sLCJ4EaJGgbzG/TFX+8Ac
         6iYR0C2a7m5pJlF0ETQImu90VmeAfgUeI7WFGA7aIigppCH1U05KUfGXAab0U5i6YCEJ
         vYlMez3PKzQDz3GM3b19CNFmMQsRsliVniYC8BgBU7gInS/uOZNFh71TkKQe9LrrWh0h
         Lm2oMGHcwyUydKWPFrkxrkTDjgcaZKx9CfCzvpL8ZPFeJh8cyle7bTBlst40hO8R4dg7
         oQ/g==
X-Gm-Message-State: AOJu0YwFfJZpNLzZn+AWBZcb9TQvYqnIEwXzm6elcOE4A4LGHdDao+EB
	ZUHNnnYeq9xbJuuBAIQS9/QNjzen8q7iLrsH2BTw6wbq1LoWEThwZoyKYrJvFbs=
X-Google-Smtp-Source: AGHT+IEXVleqjxbBFio8n9tOuB6EqDBu16zYcwOnhzk+LfioWSKasOhJ9D3xQdpTNlVPsRPRunLwWw==
X-Received: by 2002:a05:6512:e98:b0:535:69ee:9717 with SMTP id 2adb3069b0e04-536587a40e8mr10314439e87.3.1726047178703;
        Wed, 11 Sep 2024 02:32:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241bf4cdsm7031952a12.50.2024.09.11.02.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:32:58 -0700 (PDT)
Message-ID: <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
Date: Wed, 11 Sep 2024 19:02:53 +0930
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
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
 <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
 <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
 <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/11 18:59, Neil Parton 写道:
> dmesg | grep BTRFS
> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
> [    6.064021] BTRFS info (device sdc): first mount of filesystem
> 75c9efec-6867-4c02-be5c-8d106b352286
> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
> checksum algorithm
> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
> [    6.064079] BTRFS info (device sdc): enabling auto defrag
> [    6.064092] BTRFS info (device sdc): using free space tree
> [   76.647420] BTRFS error (device sdc): level verify failed on
> logical 313163105075200 mirror 2 wanted 0 found 1
> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105075200 (dev /dev/sdc sector 1145047360)
> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105079296 (dev /dev/sdc sector 1145047368)
> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105083392 (dev /dev/sdc sector 1145047376)
> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105087488 (dev /dev/sdc sector 1145047384)
> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
> [  260.968635] BTRFS error (device sdc): parent transid verify failed
> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116052480 (dev /dev/sdc sector 1145068800)
> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116056576 (dev /dev/sdc sector 1145068808)
> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116060672 (dev /dev/sdc sector 1145068816)
> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116064768 (dev /dev/sdc sector 1145068824)

All happen on mirror 2.

You can locate the device by:

# btrfs-map-logical -l 313163116052480 /dev/sdc

Which gives the device path.

I would recommend to check the device's smart log and cables just in case.

Thanks,
Qu
> 
> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/9/11 18:31, Neil Parton 写道:
>>> Many thanks Qu, I appear to be back up and running but I also had to
>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
>>> super-recover said the superblock was fine.
>>
>> This is not expected. I believe btrfs-rescue should check log trees
>> before doing the operation.
>>
>>>
>>> On reboot and remount (as normal) I have a couple of residual transid
>>> errors and I'm currently running a full scrub to try and clean things
>>> up.
>>
>> Transid is also not expected, if the transid error persists, it's a huge
>> problem.
>>
>> Does the transid only shows on certain mirrors?
>>
>> Anyway a full dmesg from the first transid mismsatch will help a lot to
>> find out what's really going wrong.
>>
>> I hope it's really just the bad log trees.
>>
>> Thanks,
>> Qu
>>>
>>> Hopefully though I'm back up and running, this is the longest the FS
>>> has been mounted in 48 hours without it reverting to ro!
>>>
>>> Can't thank you enough for your help. I hope I'm not premature in
>>> thanking you / will report back with any more errors.
>>>
>>> Regards
>>>
>>> Neil
>>>
>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2024/9/11 17:43, Neil Parton 写道:
>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
>>>>> the array?
>>>>
>>>> Run it on any device of the fs.
>>>>
>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>>>
>>>> And you must run the command with the fs unmounted.
>>>>
>>>>>    Reason I ask is when this first occurred it was one
>>>>> particular drive reporting errors and now after switching out cables
>>>>> and to a different hard drive controller it's a different drive
>>>>> reporting errors.
>>>>>
>>>>> It's also worth noting that this array was originally created on a
>>>>> Debian system some 6-8 years ago and I've gradually upgraded the
>>>>> drives over time to increase capacity, I'm up to drive ID 16 now to
>>>>> give you an idea.  Does that mean there are other gremlins potentially
>>>>> lurking behind the scenes?
>>>>
>>>> Nope, this is really limited to that inode_cache mount option.
>>>> I guess you mounted it once with inode_cache, but kernel never cleans
>>>> that up, and until that feature is fully deprecated, and newer
>>>> tree-checker consider it invalid, and trigger the problem.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> 在 2024/9/11 17:24, Neil Parton 写道:
>>>>>>> btrfs check --readonly /dev/sda gives the following, I will run a
>>>>>>> lowmem command next and report back once finished (takes a while)
>>>>>>>
>>>>>>> Opening filesystem to check...
>>>>>>> Checking filesystem on /dev/sda
>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>> [1/7] checking root items
>>>>>>> [2/7] checking extents
>>>>>>> [3/7] checking free space tree
>>>>>>> [4/7] checking fs roots
>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>> [6/7] checking root refs
>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>> found 24251238731776 bytes used, no error found
>>>>>>> total csum bytes: 23630850888
>>>>>>> total tree bytes: 25387204608
>>>>>>> total fs tree bytes: 586088448
>>>>>>> total extent tree bytes: 446742528
>>>>>>> btree space waste bytes: 751229234
>>>>>>> file data blocks allocated: 132265579855872
>>>>>>>      referenced 23958365622272
>>>>>>>
>>>>>>> When the error first occurred I didn't manage to capture what was in
>>>>>>> dmesg, but far more info seemed to be printed to the screen when I
>>>>>>> check on subsequent tries, I have some photos of these messages but no
>>>>>>> text output, but can try again with some mount commands after the
>>>>>>> check has completed.
>>>>>>>
>>>>>>> dump as requested:
>>>>>>>
>>>>>> [...]
>>>>>>>                     refs 1 gen 12567531 flags DATA
>>>>>>>                     (178 0x674d52ffce820576) extent data backref root 2543
>>>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>>>
>>>>>> This is the cause of the tree-checker.
>>>>>>
>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.
>>>>>>
>>>>>> Unfortunately that feature is no longer supported, thus being rejected.
>>>>>>
>>>>>> I'm very surprised that someone has even used that feature.
>>>>>>
>>>>>> For now, it can be cleared by the following command:
>>>>>>
>>>>>>      # btrfs rescue clear-ino-cache /dev/sda
>>>>>>
>>>>>> Then kernel will no longer rejects it anymore.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>

