Return-Path: <linux-btrfs+bounces-9295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FC49B8DF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD51C22116
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E114A098;
	Fri,  1 Nov 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DzCcehMp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5241B95B
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Nov 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453803; cv=none; b=FOn/BfDzS6yJnVs9td1gPA7RteIETWJ5ESryKzEWCAi2zieSPzTfSSId+kwngQudVCOsQxnAFeSC5MhdUxukgOkQvsNS3arLV4Z+junzldpUOmL1YIbr/7OZ4Cq2yu11plpw9c0/UUwpJyLmBnueF9TDTvLW5bztPrOv4Y99bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453803; c=relaxed/simple;
	bh=2up2kAFOz+KdccERy8pa3239MZRIeMRVK+3UnGoN7RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN14d5cPdJRfc3ZuI2TSynKgidGczSsL1P7kdi5go8WvFQoDpKHy32szHE2lq5gzOtOLR955IXJtU4EWdd2ffAdMaCD5NXA5WmL9kgnQ0BUpQGNGLQDlXN/bflzLg12NLEVzjX0e1owW/M5m9Q3jGqsaoN021FjbgXPEPgMEgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DzCcehMp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a007743e7so2033749e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2024 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730453798; x=1731058598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr9voK/+LvZjOp7hVegrOO7u8VwacAHXvVHneXdyDH0=;
        b=DzCcehMpq4fFBKcoynY1xuNXegu83p7jecuEG0XnRRTnso2ttxVjMhO19rFrCHv0+h
         dCX83zdbP+BrZL+kG1uM4ttV+RQsIFodhE2QFdE0PfZxKBI81y1AtWZQu0p6D18piEeh
         TMbvmgMzKZyF78NqNiGkN8YatxtIQDuLzQsJUUZbd96m2UK0mariq9cNt6ObFq8gD4cv
         upU8u8XeIm1+maJbtODD/AQ2OGw1Wr3mSw1UH7f46LwldIzMefwy/0pAcBvNv8Vv7RcI
         fgiK9g7I4TCRKS2IFab+nCYkj5uLHIX8XnEhzv85xJPkibBZY4SxY0ffl1urjQSegBC3
         M5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730453798; x=1731058598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr9voK/+LvZjOp7hVegrOO7u8VwacAHXvVHneXdyDH0=;
        b=wSZOFvYQEPo2wQr77GMdevqAByS/Wom2vZR+ult8OQtlgDwPUjsIRV27WFP4l1UoSk
         42ZwEnu9lb5X13PCPLGCneAlq2kvfqbLKhVaAzS+xuC/8LApCRFSETJH5G9vkt9e96y8
         xiJeAcPCWx4Zf7yXB2BRixZ6w5UIPrlIdK6C/oqqJP6X71a+LADKxDljcL3gAmmRXnM/
         crlhCsPNEUniE9+17ASdpmWNMsXTsiZpUNJQIrcBq80rab+IZsT5fLnRhXVAgfZ6HG75
         s11Wp4RsEgmI1xocLmCOr7cK09EQvFQWhsYHDJ7OB76xHCwWCnHscNlzowEpxKpEUakd
         nbeg==
X-Gm-Message-State: AOJu0YzZoyGwpnWN6NvcaaMkG42ks4EIx3M51mLSXcCwUCjAwVXPOlcC
	yFZnBoVm2ooj1/HDaAW2AYptWaQkgF+1sY8vL+TXnyCMiUbsgsatDhSLoKZdphU=
X-Google-Smtp-Source: AGHT+IFYOVRRDe8vonNUzFfM98HE5McLj7USXZ1YztE+Uu6rQ1RGDmKWWuLFfegOr2VlYNfC1HPT9A==
X-Received: by 2002:a05:6512:ac3:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53c79e15746mr3467049e87.5.1730453797922;
        Fri, 01 Nov 2024 02:36:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93d97c737sm2367494a91.0.2024.11.01.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 02:36:37 -0700 (PDT)
Message-ID: <03b1b6c5-7af1-47c5-9282-a5c503c2b0f4@suse.com>
Date: Fri, 1 Nov 2024 20:06:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: a new test case to verify mount behavior with
 background remounting
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20241101050743.113687-1-wqu@suse.com>
 <CAL3q7H5rxudiGOee=7cVqX9vjiVsigkxmbV4hBL97Goy8pFVeA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5rxudiGOee=7cVqX9vjiVsigkxmbV4hBL97Goy8pFVeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/1 19:28, Filipe Manana 写道:
> On Fri, Nov 1, 2024 at 5:08 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When there is a process in the background remounting a btrfs, switching
>> between RO/RW, then another process try to mount another subvolume of
>> the same btrfs read-only, we can hit a race causing the RW mount to fail
>> with -EBUSY:
>>
>> [CAUSE]
>> During the btrfs mount, to support mounting different subvolumes with
>> different RO/RW flags, we have a small hack during the mount:
>>
>>    Retry with matching RO flags if the initial mount fail with -EBUSY.
>>
>> The problem is, during that retry we do not hold any super block lock
>> (s_umount), this meanings there can be a remount process changing the RO
>> flags of the original fs super block.
>>
>> If so, we can have an EBUSY error during retry.
>> And this time we treat any failure as an error, without any retry and
>> cause the above EBUSY mount failure.
>>
>> [FIX]
>> The fix is already sent to the mailing list.
>> The fix is to allow btrfs to have different RO flag between super block
>> and mount point during mount, and if the RO flag mismatch, reconfigure
>> the fs to RW with s_umount hold, so that there will be no race.
>>
>> [TEST CASE]
>> The test case will create two processes:
>>
>> - Remounting an existing subvolume mount point
>>    Switching between RO and RW
>>
>> - Mounting another subvolume RW
>>    After a successful mount, unmount and retry.
>>
>> This is enough to trigger the -EBUSY error in less than 5 seconds.
>> To be extra safe, the test case will run for 10 seconds at least, and
>> follow TIME_FACTOR for extra loads.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/325.out |  2 ++
>>   2 files changed, 82 insertions(+)
>>   create mode 100755 tests/btrfs/325
>>   create mode 100644 tests/btrfs/325.out
>>
>> diff --git a/tests/btrfs/325 b/tests/btrfs/325
>> new file mode 100755
>> index 00000000..d0713b39
>> --- /dev/null
>> +++ b/tests/btrfs/325
>> @@ -0,0 +1,80 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 325
>> +#
>> +# Test that mounting a subvolume read-write will success, with another
>> +# subvolume being remounted RO/RW at background
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick mount remount
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +       "btrfs: fix mount failure due to remount races"
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       umount "$subv1_mount" &> /dev/null
>> +       umount "$subv2_mount" &> /dev/null
> 
> $UMOUNT_PROG

Well, I went direct "umount" because I did a quick search for "umount" 
and hits twice inside common/rc.

I guess it's time to do a cleanup inside common/rc too.

> 
>> +       rm -rf -- "$subv1_mount" &> /dev/null
>> +       rm -rf -- "$subv2_mount" &> /dev/null
>> +}
>> +
>> +# For the extra mount points
>> +_require_test
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
>> +_scratch_unmount
>> +
>> +subv1_mount="$TEST_DIR/subvol1_mount"
>> +subv2_mount="$TEST_DIR/subvol2_mount"
>> +mkdir -p "$subv1_mount"
>> +mkdir -p "$subv2_mount"
>> +
>> +# Subv1 remount workload, mount the subv1 and switching it between
>> +# RO and RW.
>> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=subvol1
>> +while _mount -o remount,ro "$subv1_mount"; do
>> +       mount -o remount,rw "$subv1_mount"
> 
> _mount here too.
> 
>> +done &
>> +subv1_pid=$!
>> +
>> +# Subv2 rw mount workload
>> +# For unpatched kernel, this will fail with -EBUSY.
>> +#
>> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
>> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
>> +# then reconfigure the fs to RW.
>> +#
>> +# But such retry has no super blocl lock hold, thus if another remount
> 
> blocl -> block
> 
>> +# process has already remounted the fs RW, the attempt will fail and
>> +# return -EBUSY.
>> +#
>> +# Patched kernel will allow the superblock and mount point RO flags
>> +# to differ, and then hold the s_umount to reconfigure the superblock
>> +# to RW, preventing any possible race.
>> +while _mount "$SCRATCH_DEV" "$subv2_mount "-o subvol=subvol2; do
>> +       umount "$subv2_mount";
> 
> $UMOUNT_PROG
> 
>> +done &
>> +subv2_pid=$!
> 
> We should have the _cleanup function kill and wait for $subv1_pid and
> $subv2_pid in case the test is interrupted, something like:
> 
> kill $subv1_pid $subv2_pid &> /dev/null
> wait $subv1_pid $subv2_pid &> /dev/null

Forgot the wait part. Thanks a lot pointing this out.

Thanks,
Qu
> 
>> +
>> +sleep $(( 10 * $TIME_FACTOR ))
>> +
>> +kill $subv1_pid
>> +kill $subv2_pid
> 
> Add a 'wait' here, to make sure the umounts below don't fail in case
> the subvolumes are mounted.
> 
>> +umount "$subv1_mount" &> /dev/null
>> +umount "$subv2_mount" &> /dev/null
> 
> $UMOUNT_PROG
> 
>> +rm -rf -- "$subv1_mount" &> /dev/null
>> +rm -rf -- "$subv2_mount" &> /dev/null
> 
> 
> Also, why these "&> /dev/null" redirections?
> If we have the 'wait', the umounts should succeed and the rm -fr
> shouldn't fail - in fact it's useful to test that they don't fail,
> that the umounts were successful in case the subvolumes were mounted.
> 
> Thanks.
> 
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
>> new file mode 100644
>> index 00000000..cf13795c
>> --- /dev/null
>> +++ b/tests/btrfs/325.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 325
>> +Silence is golden
>> --
>> 2.46.0
>>
>>


