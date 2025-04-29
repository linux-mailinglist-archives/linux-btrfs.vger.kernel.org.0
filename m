Return-Path: <linux-btrfs+bounces-13483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80425AA01EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CDD463ED5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 05:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC625E819;
	Tue, 29 Apr 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KwqBdyWB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5113BC3F
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905501; cv=none; b=EZpXt881rgBBObhT90TNOjrXsb+Z4jbJ/QngYThAtgdyaQ64hf9WB3w4dsDyWrOF9+5tZ6GYzbSQVzljze11WUpujI4QYhVN0iMEKa1fbNppCzQ5NmTgigkh7zCxbru0BC+Zu4ZVSa9agrPevRzPGPPz4lCyo9q1NqyalAwVStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905501; c=relaxed/simple;
	bh=k8NwJRTSyPPnjpk2rFMl4UfbwyCKJJalhscQ+YppoVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PRUPZjthcrGZEmjJDHpohPYZ4Yn5vupDm0UgmjJ2Jwjr63V47JMOoKqqsJ0zcZ4cCBSyYUO9dxTQCCrkvi0cWY89ArUgcdRXD9Tc6IfIizJurfKSE1h8Ht2b6J+RcT9kmT5BPIk+sXye8uvXNsuui4xAfW1zGeNwapPjsycYAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KwqBdyWB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aca99fc253bso836617066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745905496; x=1746510296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGjt7F1WduX/BGhDinXG6djB1M0wTNX4yiXy0EC945c=;
        b=KwqBdyWB5cBCIWfkVrgb4FvXIBXPViJSKC6rIDq2lYNUZiU4iut5/GKf2CCdolYrRN
         RO1dOUJE3IxQG2shuY9XDXEuHuf43n4H3Am+uoHqJu2NIdlXHkpMTYDLb943WgP43mv7
         QwZvsnVYWvIpMnJfxW3QmVE1E/jxntkH5Ozi5dK9359NjtGWS0W/vROeaTBTgXb0KDrc
         E3kxK7dWwyL+m31kCwEvVKDWPQvwHFh0R8+S6wEvjSKo2VhCDBZ0M4yagNPE8QVejX4x
         ugxNd0bTSR3BjfmLjII5LN0ERVLmqGOV5XkN3MM8aQL/Jd+JkUrjGgHXJHjVoUQDaGdj
         +nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745905496; x=1746510296;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGjt7F1WduX/BGhDinXG6djB1M0wTNX4yiXy0EC945c=;
        b=wYP+FuN4vG7EvfeLjAruRFHNyZjahum9FeIoIr7QHqsq+OIHEkgWXWrqhbao8FLnHh
         eBvOBaX7muKKHoPOuUmqSg1hwvC1Ex79zu/pECmCPNbCARTCKwWjv9QGIOHuHVKiWP8J
         CfZ5MfsllQLsalaBSVoD1SK42g+hsJlWl7v1Sglm612h/jUt7QHenixBGedCGus7H7ry
         zfygC8XZuLB6fiDlAVp7eipiPeFsaYtrSmH9C4a3g2XG1F/JqHJ8KMD/0oLoHJ4iD8/i
         A/e1+Eb9p2cqOlDciutramUh3wgTmT+TBDERNxjAllwkScz/knn6Il8SFuAAu2zm369B
         oFEw==
X-Forwarded-Encrypted: i=1; AJvYcCWMP8z+BiFQXdEQpS7WLEu3dMvCw6qpTD5IIbHoqMkXt6S4IxpUSTp4PqXwAiAjkC9ogbYPOTtd9gGDzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxavucmVtkeVhnPGJMS7ftBVJUobEyvqA9fvgS4n0R1YT/IDEk
	R3Pc9ZCVN1N35XEa7ZmuKjwUSo7nxaVO/bPy1OYKNohvb6+WUDb+/DPeudgBD2Y=
X-Gm-Gg: ASbGnctHQ6FJhrfbvhsEnxeJVdCALUdsU1DfBV5kkJ6w8VebKW/Ga+vl1DWk1lJsa2x
	RBN2nphYL9HlNec7V2hAtFsqIM80XLZXbW/ozhSLj3gGt2zuwVcUbJHgOMCBAqsIpdaQcaMdcAr
	yGZhW6Arh17TPYVqFxTYxeNCjT3E/fXjf0l36JtmwEwQ2w2xzKkonq4UB7hr9akdmBzeYKlE4X5
	kXjlwl+ga/clz5mdBTY7yDmsTJDP84SJbN72vQEh5P88w4hf6g1GiFjtvzmvjcjEar/8nXqVxHh
	FMwWfyJMMMyfjELh7K2TLkHmAHlytl7W10k4W6JGIpn5d1BKa/8h/47AZIz9wghXWaEM
X-Google-Smtp-Source: AGHT+IEc7jplmYpDc1nJIgBsT4+Xko9sHxlsc5DO8NxoBQwpGxe7n2WVgr9PjEmNKPLwyhRIgy6OOA==
X-Received: by 2002:a17:907:3f9a:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-ace848f78cfmr1073746266b.16.1745905496310;
        Mon, 28 Apr 2025 22:44:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f784a78csm8374954a91.44.2025.04.28.22.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:44:55 -0700 (PDT)
Message-ID: <43dc4c77-cc8c-4c16-9fab-76833e2fc4dd@suse.com>
Date: Tue, 29 Apr 2025 15:14:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: HTML message rejected: btrfs checksum error
From: Qu Wenruo <wqu@suse.com>
To: Przemek Klosowski <przemek.klosowski@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <1745893230-14268-mlmmj-729fb3af@vger.kernel.org>
 <CAC=1GgGRobZ7sMN6iBExMuYCRzNyei_mngkyRd=kvOX9rj90Lg@mail.gmail.com>
 <1be5f421-a36e-4a27-8c4b-73140f94a217@suse.com>
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
In-Reply-To: <1be5f421-a36e-4a27-8c4b-73140f94a217@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/29 15:02, Qu Wenruo 写道:
> 
> 
> 在 2025/4/29 11:55, Przemek Klosowski 写道:
>> I have a RAID1 btrfs root/home on Fedora 42 that developed what
>> appears to be a single data checksum error. RAM tests fine, but it's a
>> DELL system that had memory problems early on (years ago), that were
>> fixed by Dell BIOS memory tests  (which changed the mem controller
>> settings).
>>
>> The errors seem to have started right after a scrub (see btrfs
>> messages from journal below)
>>
>> btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2
>>
>> shows a cascade of errors (which seem to be increasing in number)
>> ..
>> [4/7] checking fs roots                        (0:00:04 elapsed, 60923
>> items checked)
>> mirror 1 bytenr 299511672832 csum 0x125beb3c expected csum
>> 0xc8374bb569 items checked)
>> mirror 1 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
>> mirror 2 bytenr 299511672832 csum 0x125beb3c expected csum 0xc8374bb5
>> mirror 2 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
>> mirror 1 bytenr 306513821696 csum 0x8941f998 expected csum
>> 0xa5fe1bfd94 items checked)
>> mirror 1 bytenr 306513825792 csum 0x8941f998 expected csum 0x77c755d4
>> .. and many more
>>
>> I can recover the file with only 1 4kB block zeroed out.
>>
>> Is there a way to read the bad sector? I thought that
>> mount -o ro,degraded,rescue=ignoredatacsums/dev/sda5 /mnt
>> would read data ignoring the bad checksum? as it is, it replicates the
>> I/O error that is raised when reading the original file.
> 
> It turns out to be a bug in the implementation, we expect to ignore bad 
> data csum error and return the data directly, but it's not implemented 
> if the csum tree is still valid...
> 
> I'll send out a patch for that, but that will also mean with 
> rescue=idatacsums mount option, the data will only be the first one 
> btrfs read out.

It is not a bug, it is already handled properly by completely ignoring 
the data csum tree.

I guess the problem is you're still trying to scrub with that 
rescue=idatacsums mount option?

That mount option is to be used with regular read, which will not do any 
verification now.

Please verify if regular read on those files work.

Thanks,
Qu

> 
> It'll be fine for your case, as both mirrors have the same csum.
> 
>>
>> Do you think that deleting the file with the bad checksum will solve
>> this?
> 
> Yes.
> 
>> or should I move to rebuilding and restoring from backups?
> 
> No need, "btrfs check --check-data-csum" is the most comprehensive check 
> we have and it only reports error of data checksum so far (better than 
> scrub because of the comprehensive metadata checks).
> 
> Although you will need to find out all involved files, scrub is doing a 
> good job resolving the path, but the output may be ratelimited.
> 
> I'd recommend to craft a small script, parsing all involved unique 
> bytenr into `btrfs ins logical` to get a full path to the affected files.
> 
> Thanks,
> Qu
> 
>>
>>
>> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> started on devid 1
>> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> started on devid 2
>> Apr 26 22:41:36 fedora kernel: BTRFS error (device nvme0n1p2): unable
>> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
>> physical 74303995904
>> Apr 26 22:41:36 fedora kernel: BTRFS warning (device nvme0n1p2):
>> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
>> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>> Apr 26 22:42:52 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> finished on devid 1 with status: 0
>> Apr 26 22:45:46 fedora kernel: BTRFS error (device nvme0n1p2): unable
>> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
>> physical 147297468416
>> Apr 26 22:45:46 fedora kernel: BTRFS warning (device nvme0n1p2):
>> checksum error at logical 452965761024 on dev /dev/sda5, physical
>> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>> Apr 26 22:48:45 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> finished on devid 2 with status: 0
>> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> started on devid 2
>> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> started on devid 1
>> Apr 26 22:53:52 fedora kernel: BTRFS error (device nvme0n1p2): unable
>> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
>> physical 74303995904
>> Apr 26 22:53:52 fedora kernel: BTRFS warning (device nvme0n1p2):
>> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
>> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>> Apr 26 22:55:07 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> finished on devid 1 with status: 0
>> Apr 26 22:58:04 fedora kernel: BTRFS error (device nvme0n1p2): unable
>> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
>> physical 147297468416
>> Apr 26 22:58:04 fedora kernel: BTRFS warning (device nvme0n1p2):
>> checksum error at logical 452965761024 on dev /dev/sda5, physical
>> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>> Apr 26 23:01:01 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>> finished on devid 2 with status: 0
>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>> Apr 27 07:35:55 fedora kernel: btrfs_print_data_csum_error: 2
>> callbacks suppressed
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:55 fedora kernel: btrfs_dev_stat_inc_and_print: 2
>> callbacks suppressed
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>> 0xcf4a5572 mirror 2
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>> 0xcf4a5572 mirror 1
>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
>>
> 
> 


