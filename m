Return-Path: <linux-btrfs+bounces-18524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568BC2A15A
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 06:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1993ADF45
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221022868B5;
	Mon,  3 Nov 2025 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fYKi1gQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12ED27F16A
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762148490; cv=none; b=dkT/H5znZI+uhiJ06psafyS3aHRq7XQHJWR1O6bmPLN4qeUel4Wc+cnn7oSQarHbM/QRp0COI2ti6IYjN6DrCocZMMNCa0KTG3Bjf4XhPdwIlXlIxVlBQ+A1heq3mbj7UsOh7VVvb1M9BE5PSDuTtT+lN72NwH6o9UyxtSIqDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762148490; c=relaxed/simple;
	bh=JFxIDqQGlVlcNn/0WibTDbRH6sNjtAJCHe7rToFLhmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GwLe/6W4m/uuDNjoPYorlytX37DYVq3pgzIJU28KyIjAoR3rEf8r+rgOffHWoeQtwdFhvZ0OPMS5m2aXOjNM1ekcEcslus23DdmnsFIORJANU+btlUKdSbzra+h6ICVKt4OD5nsmt+wYUnByCYo7+GLH86U2RBDjqn2/9AKdBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fYKi1gQU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7869704so1817494f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 21:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762148486; x=1762753286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEuECXP3CBWSlNLxOMZTZOLZSWX4njIbOUzTbqVTWgw=;
        b=fYKi1gQUk2f/WGivC+2ZPukbtzzAc70LsaJoleLx1htxgGE9UZMqDcH9NHxym+sLd9
         PfAoDdNEpkvyrbUKRbCUh/RMQB6BAUsztKNFqnHSH5PkrOb73XpxYhdeHza3joW1QQDW
         Dvzh77rY2M2/ByICJbWzxhTIvV0nrtm1nMnB1VFMMCVziGkiSftopM1y++rlZlpv3r02
         thzE7/w9hopxpTQzgchmlkPDAFJdUNDoKYqUUXPNyC4vvmNRsj6YvmMHcKVwolrxQqIJ
         4KHvyvmG24WoWUEAD7pFLLSTG1RHARegrAB4/8gz8zAasKzcg2eWt8Q5JVG7HBTSIUwN
         RbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762148486; x=1762753286;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEuECXP3CBWSlNLxOMZTZOLZSWX4njIbOUzTbqVTWgw=;
        b=VEzQt3aGS1iEftMAB2AJ1CLSbtoACRnm+6ytuenZCSJDotpf+L/KkP1g2CDR9LknX1
         3au12aqcMKbNzYBCnZ3CYe5zyOYbTrTz2IB8i8qJ8O/zWRaRoxEG7lwG0INDX0BIJyaU
         6K82WwhcmkX/l/bB7KEvLRIT421h8bsBfIIksPCpZnpz1mqqXjLHHvZTzMVVRPhQQFte
         F8wfNESmVwoFw0tsAgM6kI7z7uC+qDVJueTZlwYWY07KCFufMC6kN5K9cEGGie/sc3Lp
         TIKd5gK5x8PjrI9C9Ceuvdc8CMJ4aDovwYn0ZMwlap3BFQgw7j6fURyEzvKAc8b0Bz9V
         Ce3w==
X-Forwarded-Encrypted: i=1; AJvYcCV64PtQv6saFeDr9oDPxn4Pw363RpnuCPuOpzEFqczidAQ0mIVRnzmlPsCebKKxF0Tql+Jh1Web3LMrKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SJU6yQZexRH8UeX/MHGzdvLB3XFHArGYxeGPxdey9y7b7MyE
	Q8hHjBrxZc3ncIAxwGXOM07IdnHZedJ/9WJWm5lx5eHvQe9hRE9DwoGvWH9GLYzDoJ0dwl0ZVEO
	j6HyL
X-Gm-Gg: ASbGnctxRTR3pwF85kurbiKGuAsIcEgAzpprlzhfyMwmOObkQ6Ioy8qsdVoiQ67ouyr
	dwhgYY/34JDEKYxxdU0pta9miyfA93MViVoch/xrGJ2El6TKOHoZa1PyM+mJ36rPounmcn/nLj0
	UTUuqGLHjQh6ZnWHHJw54yMlpVnjZDgUhUFg2qgdtOY8gQUjJ7Dex+gwZqS5xIjnhBQoHbMqYVS
	sWKW7pb5ZlTOv/JK/X0lTDe1YuMMHhr8g5+ekIcHoBihT6ObC8a+b4m4I5aU998ihwQzlfYnYY4
	vb3jyfJc2qwnvWC9Ol5+vji6gDJW7Kl9vecUzDvtWQkLfDEhN1hLDIjlv17iiUlHhnGQ/svbQZq
	GDVi8KGuaSWF/a+4Xntm9QEgObjVvGurDy5vZBPgPb+z94ttL3ywwDEwevtdOyMSaitq2VK/Dw3
	mc9qIlrlBTlWNKlXLmOddlg/c2yec4
X-Google-Smtp-Source: AGHT+IFoMaeXpDPNrgyKd5cnKOpjVZaLuTtnm/52EOKzH60NQk7EkvfqZDsePme6SGKp5aPbtghSyw==
X-Received: by 2002:a05:6000:4305:b0:429:cacf:1082 with SMTP id ffacd0b85a97d-429cacf1303mr4123219f8f.57.1762148485769;
        Sun, 02 Nov 2025 21:41:25 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm9626161b3a.15.2025.11.02.21.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 21:41:25 -0800 (PST)
Message-ID: <f6cf1f07-d3dc-4117-82f0-47ea27dbc1c2@suse.com>
Date: Mon, 3 Nov 2025 16:11:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs bug: SysRq-S SysRq-U don't sync btrfs
From: Qu Wenruo <wqu@suse.com>
To: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org
References: <20251101150429.321537-1-safinaskar@gmail.com>
 <1c419b6e-61eb-44fb-aa32-c31afd901497@suse.com>
 <8bf2de18-3e2d-4f8a-a0c9-ea7a1313c6cb@suse.com>
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
In-Reply-To: <8bf2de18-3e2d-4f8a-a0c9-ea7a1313c6cb@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/3 13:36, Qu Wenruo 写道:
> 
> 
> 在 2025/11/3 13:08, Qu Wenruo 写道:
>>
>>
>> 在 2025/11/2 01:34, Askar Safin 写道:
>>> "Press SysRq-S, wait 5 seconds, press SysRq-U, wait 5 seconds, press 
>>> SysRq-O"
>>> doesn't sync btrfs.
>>>
>>> Here is script to reproduce this in Qemu:
>>> https://zerobin.net/? 
>>> 677f7ff6c348d96f#Ka5RFMytXRmyvrwPVp1wuMAgWzaunkJ1+A+/5ahVn2A=
>>
>> Confirmed the sync_fs() callback of btrfs is not executed for the 
>> global sync.
>>
>> Will take a look at it.
> 
> The emergency_sync() is responsible for this sysrq-s handling, and it 
> will sync all filesystems.
> 
> However there are several problems:
> 
> - sync_inodes_one_sb() will only work for single device fses
>    Where s_bdi is some real devices.
> 
>    Unfortunately btrfs uses a dummy block device for s_bdi, thus it will
>    skip the writeback of dirty inode pages for btrfs completely.

      The above part is incorrect, btrfs will still writeback all
      dirty pages including data and metadata, just no transaction
      commit.
> 
> - do_sync_work() pass @nowait instead of the common @wait
>    Which is the opposite of all the fses I checked (xfs/ext4/btrfs).
> 
>    Not sure if this is designed or not, will dig into the history to be
>    sure.

      This is just a way to indicate if it's doing waiting or not.
      This indeed looks pretty weird, but I guess that's the code style
      that VFS follows.
> 
> - sync_fs_one_sb() is called with @wait == 0.
>    For btrfs this is critical, with @wait == 0 passed in, btrfs only
>    flush the btree inode, and nothing more.
> 
>    This means no super block update, thus really no thing is committed.
> 
>    Although this is more or less the same as xfs/ext4, the problem is the
>    previous sync_inodes_one_sb() won't do anything for btrfs.

      The difference is the superblock writeback, not
      sync_inodes_one_sb().

      sync_bdevs() will writeback any super block that's dirty but not
      yet submitted in the bdev's page cache.

      But btrfs doesn't go that path, we only dirty and immediately
      submit the super block during transaction commit.

      So sync_bdevs() won't sync our super blocks, thus as long as
      sync_fs() is called with wait == 0, btrfs won't commit the
      transaction thus still the old data.

Thanks,
Qu


>    Thus the wait == 0 call will screw btrfs completely.
> 
> I guess the only way to solve it is to handle the @nowait properly for 
> btrfs.
> 
> Will try to send out a patch for that. reverting the @nowait bit.
> 
> Thanks,
> Qu
> 
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> - The bug is reproducible on current master (e53642b87a4f)
>>> - The bug is reproducible with btrfs, but is not reproducible with ext4
>>> - The bug is reproducible both in Qemu and on real hardware
>>> - If I replace SysRq with "sync" or "mount -o remount,ro /disk" command,
>>> the bug disappeares
>>>
>>
>>
> 
> 


