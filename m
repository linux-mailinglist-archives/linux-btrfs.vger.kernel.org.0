Return-Path: <linux-btrfs+bounces-11674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E1A3E708
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DDD4214FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267F2139D4;
	Thu, 20 Feb 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cCh6J+Vk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F91EF0B6
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088454; cv=none; b=V4eD+waSEsu5tDJa4KOPkfuFsbYGUErFunATiXudd1s6BhrvukGL16DBZt7N+V90wp/uoY27+enNZI05JrIxATFwst4y7cYan0qkuo9zjv5VZP+5QAALGn5ub+ELdbNQUt2SqQ6wQW527gDEaBmvl1IfI7mF5bXHOZq2WmLMBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088454; c=relaxed/simple;
	bh=+a9jnm6Bk3QearMH0dFHIyxkzdL2W1GEcseYUZ2Qfko=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V1lYVqD96k40pv7YoMCpeLRuhVrShqYdbhzxck+5VhZgNd36wX8C/O/BaMumebdbAc6hIYQ1I7NnAwsrc5bF+TWfMy4JjwzrFPC7UfSyERqumiNi7QD/pNRJwzo4ulesCKfHhwLF7AVMZou3Cs6lAsMhqsK2MHEcmmBm/v+2c6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cCh6J+Vk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so791221f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740088449; x=1740693249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zIHdq6Gg8R4VPNIYbrs0yySk0RWRd/0wuGcsje5S6xI=;
        b=cCh6J+Vklg8qkmsmlSZ5C6m/Pz5fhFXEV+xG9URS1dEoKLMVEM+C8kXv1F439wpitL
         bXI0oMZN/zfV+0nonLvjjr/22a/EH2nVqWOTzzW3fEG+z5H9+ZSYXHEuV8cocU151Tf+
         Ob3gJwAjeKuTPrs1fvpP0qiMvl0PgDg2X2lVuGYlCejkf4IcUuQ2qF79oq8koj49mgfb
         cVFp70SdP9rwqlW5ETdcZqt1LLgfFxb1kQktHhhpOlU8k3HgLz7a6IlS7aeIBQSuiHJq
         QG/BqLwuawlZmFvBjbyzGo9veWssSB560arnOQ5mfMLkYgLYaKI07uXtokdgQrozR6R+
         L7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088449; x=1740693249;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIHdq6Gg8R4VPNIYbrs0yySk0RWRd/0wuGcsje5S6xI=;
        b=eTYhn+Zi36p15vwV+rTmVsVhSAARzTKxOVV0QCFSaTDxve15rXw2kriMxTME4mGqf8
         tlG9MuFupTU9ioV0rJEZTRZwjwpDQzUIWBBYzykMZuvob5dDlPYvr4nn/5d7e1d1fTui
         TbHYdWYju3SjOYlb1ZEu2KCgtJBvlVJPOoWqSjq4xUgu/Fdgz4t7sAwI8s056EvXQeT/
         /T5ODnGF5P5zQkpXRARk3/VQS5UFV3+ySX/lqLE3Vwde4n/I7x/XuyJuwwpmiW8zsUnu
         /rx8vxmJLiXmH1UfZfCVXx6vXws3BdTAnIiNERTyjjKf5UatWtXiU5VVEDXNySSBRZ4F
         HDTA==
X-Gm-Message-State: AOJu0Yyd7+ynp+WbkPDfAvOrC7sZ9vsbgFuvGvqmg3MSqjIT+r3QytUu
	BzLm4JZLvT2KADbQiJNh9O+49o+Fn8RsBw13eDV2AYBiNUCcL7kJJNX7z3r5kHY=
X-Gm-Gg: ASbGncsJcVWOWXzLc0oj2Z2XynuWMrPVe9OANsJv14GwGLpRXOnRrIQ5jaH+gCuQmzF
	7SZpQemR0x9YI6XbGsO9CeW1u+66uVvNf13KxVE0dv7SN4iSIMxuSi4jDG+MfELEfmHOnganHkH
	jnqIKX8jflR2S2oV/2TjJDHUL+lJNBz34LOCUt4HV+JH39NzJEUAZjP1OB/k36E/RMe0+TmjJFw
	0y57klL4Wscay9DNrcO43pjBICIKr7QJ7bjo4EA8OsXWgUwclBH/ypcPXbAlva+nIHsCDJgbOoX
	eoEtgz2l7kGnK0ngUIaCrbodbk8VtL50mmHWR0XxEAM=
X-Google-Smtp-Source: AGHT+IHd7OnBz9rL9BHeHdo/Mst5qnn7f+9o3cI42rTtr4TWyhTPdb/DVjGuOAgYIUETIaWzH/B5QQ==
X-Received: by 2002:a05:6000:402c:b0:38e:d4b3:9454 with SMTP id ffacd0b85a97d-38f6f0974aemr622712f8f.34.1740088448379;
        Thu, 20 Feb 2025 13:54:08 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73414be6fa4sm2044499b3a.36.2025.02.20.13.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:54:07 -0800 (PST)
Message-ID: <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
Date: Fri, 21 Feb 2025 08:24:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
From: Qu Wenruo <wqu@suse.com>
To: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
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
In-Reply-To: <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/21 08:06, Qu Wenruo 写道:
> 
> 
> 在 2025/2/21 01:27, Daniel Vacek 写道:
>> When SELinux is enabled this test fails unable to receive a file with
>> security label attribute:
>>
>>      --- tests/btrfs/314.out
>>      +++ results//btrfs/314.out.bad
>>      @@ -17,5 +17,6 @@
>>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>       Receive SCRATCH_MNT
>>       At subvol snap1
>>      +ERROR: lsetxattr foo 
>> security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: 
>> Operation not supported
>>       Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/ 
>> tempfsid_mnt/foo
>>      -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>>      +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>>      ...
>>
>> Setting the security label file attribute fails due to the default mount
>> option implied by fstests:
>>
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/ 
>> scratch
>>
>> See commit 3839d299 ("xfstests: mount xfs with a context when selinux 
>> is on")
>>
>> fstests by default mount test and scratch devices with forced SELinux
>> context to get rid of the additional file attributes when SELinux is
>> enabled. When a test mounts additional devices from the pool, it may need
>> to honor this option to keep on par. Otherwise failures may be expected.
>>
>> Moreover this test is perfectly fine labeling the files so let's just
>> disable the forced context for this one.
>>
>> Signed-off-by: Daniel Vacek <neelx@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> 
>> ---
>>   tests/btrfs/314 | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index 76dccc41..cc1a2264 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -21,6 +21,10 @@ _cleanup()
>>   . ./common/filter.btrfs
>> +# Disable the forced SELinux context. We are fine testing the
>> +# security labels with this test when SELinux is enabled.
>> +SELINUX_MOUNT_OPTIONS=

Wait for a minute, this means you're disabling SELINUX mount options 
completely.

I'm not sure if this is really needed.
>> +
>>   _require_scratch_dev_pool 2
>>   _require_btrfs_fs_feature temp_fsid
>> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>>       # Use first 2 devices from the SCRATCH_DEV_POOL
>>       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>       _scratch_mount
>> -    _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +    _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} 
>> ${tempfsid_mnt}

The problem of the old code is it doesn't have any SELinux related mount 
option, thus later receive will fail to set SELinux context.

But since you have already added SELINUX_MOUNT_OPTIONS, I think you do 
not need to disable the SELINUX_MOUNT_OPTIONS.

Have you tested with only this change, without resetting 
SELINUX_MOUNT_OPTIONS?

Thanks,
Qu
>>       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | 
>> _filter_xfs_io
>>       _btrfs subvolume snapshot -r ${src} ${src}/snap1
> 
> 


