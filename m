Return-Path: <linux-btrfs+bounces-16091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F2B2889E
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA22D562787
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170A2D062B;
	Fri, 15 Aug 2025 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gCgjuwVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A71922FB
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299228; cv=none; b=FANlRx+v+NcIr5cpH4wtCRVz0r0DDCvaNIZHf+KjzrYlWnKOJfSYrJndSN5U1c3fdAPeVhi2k49Ckfri3c8MFml91TnlFULUrr3O0egO8m9Ig4Hxix9Chz3IZXu9Z1lR7enXrdRucxqIldYD2prw5WixFaahogtNDVEaNChXtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299228; c=relaxed/simple;
	bh=1oaXLWeICurgt6W23WOcDJh/eANdTeQETAXeFq+T59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAZpTWQXPpsHVOiE0BNeDWkmbG2wQ2aq7ztNMuQUC9sdBmxyHimjgo0JwhVMgFKSdltGkH9NXuGqsZ/0YXHHuCbEPKWV0lotpzh26GVG0XaF+512dgjxJQDiO7vTXDkRzC4GDvPv/RzTxVBZb0rv8V3FVhL7pWWTymU3WSIR8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gCgjuwVn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso1495080f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755299224; x=1755904024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+0Vf7CsguGq1gRxiY1VxERsQgL9Io9h2rvxto331uA=;
        b=gCgjuwVnwsRZ+AN/ClzYJPjjrDPTwqGpmgWmMbhfuKehqQDL/aPXIG/ps9pCueuLfy
         Cj2YwmnGv22lwVPNdPJu7+MrGUgCVs23QOULWFrIA5n3Rhie4B+ArVwuRSNmyannkzji
         mSfoZz35djAogFX6lDkNokSw4TgUr+1btA6PCgDklyhrEjClLuui/TPeuofhVPFgsGwe
         qxsAOyqygzzbQpuePMb4vckaTitPX5XJ2Pkbe7Bb+7cCBM7QnSYMBLYsBNYoujUh/GsS
         +WjnBmKmAuF/4+3CH7XJn3kOXzeBbtoo4m04G49xTE5w9xkEBOuNRC60t8+mRW9flLfY
         6snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755299224; x=1755904024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+0Vf7CsguGq1gRxiY1VxERsQgL9Io9h2rvxto331uA=;
        b=P+hnhD2RVkuOlKfrVTlzsvlCHgrK7thXIcFjdoCwlL40e7klzI2pt7TDZm7hQP03u2
         +XGgaXqxt4dEhPeU3DRAd0GI/8ZH9FIVEVc/u/idrqedE+iabMmYY6GxSjdggcFv6AjU
         0F9A03qp95LW2n2Vqo3DdAG/4DMLYLjyyssOL+dnIWtIqfQZUKKloOBLiPsBLOuItRP6
         J2ZJeqFiWLtvDvx+Cf+x4Z6hg/UmLDHjFyUm5pGTtwP+vQXQSZ9zUvqQDBb0TZWinBHH
         hM1PEoth9GZAM9EjL4SxLN5vhvz88RnqDNbLKIGoDXJ7LC2cRW8/QzeaRhtinp4Mqrj2
         1How==
X-Gm-Message-State: AOJu0YyzQ8hkpZXigo3JsN7gdZVk7OA1QDI+UortfT48DMbpGQ00PU3r
	IGR3AVH/zLUziaANSLuzfe7SQa8hp69hQlmOJ0ObfjH3bJtD20bkpQNRthGi0qN68VE=
X-Gm-Gg: ASbGncu5cF3VGUh7uDY00FiuH9MyQS0oYUwvBbQ48SjJCo4yphkgmxx/cciivxnVb9e
	pkMJo7p3J2ULWy0d0oNGK6Li4wcsPRkB3WuCUKusPe1MUcEn3b+9+vlXcDmNcOArPC5UtV6uUda
	rMDdBwJ/5sFZBsxCXMb9fneKL2fFFqo5vVjRODwQzYmifQT1DTPV/CzK7GR1sQKXDSd/5TFJpvG
	aEy/4gWn0aEQblj3kQ29Ud8En4H3cx1p7SnyJ2uaFP9oW+5JCjDdHtw8tSEr/hQiNp9YyJo7loa
	2x57tYhnomyH6l81esqTG7njfy2DvUyx3sKJHtlHZcIJURUg355sDh6ItDRCRtSdrUAQKb7Kepe
	gPtRDmuF1CyJPkzyhpuTEvYYOiHfOHuyBO5fcm+LgeiUClX7iUw==
X-Google-Smtp-Source: AGHT+IEA8HYceRbR1C9znuv5jGLl7p524OU80HR4HRYu0UeLLitdcJZ0YW9lzh9f4il+gz7nZkFxRQ==
X-Received: by 2002:a05:6000:420f:b0:3b5:def6:4f7 with SMTP id ffacd0b85a97d-3bb68a17722mr2749552f8f.30.1755299224272;
        Fri, 15 Aug 2025 16:07:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm2701917a91.0.2025.08.15.16.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 16:07:03 -0700 (PDT)
Message-ID: <f05dc011-5fcd-4d84-a85b-2eebdbbf741a@suse.com>
Date: Sat, 16 Aug 2025 08:36:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent device path updating during mount
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <46498bbf2891a2c9539b33d17155ad9cd5f9401a.1754897590.git.wqu@suse.com>
 <20250815204441.GA2973697@zen.localdomain>
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
In-Reply-To: <20250815204441.GA2973697@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/16 06:15, Boris Burkov 写道:
> On Mon, Aug 11, 2025 at 05:03:15PM +0930, Qu Wenruo wrote:
>> [REGRESSION]
>> After commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until
>> super block is created"), test case btrfs/315 can fail like this
>> randomly:
>>
>> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/315.out.bad)
>>      --- tests/btrfs/315.out	2025-08-11 16:40:36.496000000 +0930
>>      +++ /home/adam/xfstests/results//btrfs/315.out.bad	2025-08-11 16:41:04.304000000 +0930
>>      @@ -1,7 +1,7 @@
>>       QA output created by 315
>>       ---- seed_device_must_fail ----
>>       mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>>      -mount: File exists
>>      +mount: /mnt/test/315/tempfsid_mnt: WARNING: source write-protected, mounted read-only
>>       ---- device_add_must_fail ----
>>       wrote 9000/9000 bytes at offset 0
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/315.out /home/adam/xfstests/results//btrfs/315.out.bad'  to see the entire diff)
>> Ran: btrfs/315
>> Failures: btrfs/315
>> Failed 1 of 1 tests
>>
>> [CAUSE]
>> The failure is that the second seed device (with a duplicated fsid and
>> dev uuid) is mounted successfully, which is unexpected.
>>
>> In my environment, the following 2 devices involved in the
>> "seed_device_must_fail" run are:
>>
>>   lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch1 -> ../dm-2
>>   lrwxrwxrwx 1 root root 7 Aug 11 09:03 /dev/test/scratch2 -> ../dm-4
>>
>> Note the kernel dmesg of that run, when mounting the first seed device
>> (scratch1), the real device got mounted is the second seed device
>> (scratch2):
>>
>>   BTRFS: device fsid 7c8a5017-0c44-456f-8acf-57663f954e53 devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount (3343974)
>>   BTRFS info (device dm-4): first mount of filesystem 7c8a5017-0c44-456f-8acf-57663f954e53
>>   BTRFS info (device dm-4): using crc32c (crc32c-generic) checksum algorithm
>>   BTRFS info (device dm-4): using free-space-tre
>>
>> Note that "(device dm-4)" line, this means /dev/test/scratch2 is
>> mounted when running "mount /dev/test/scratch1 /mnt/scratch".
>>
>> Then when trying to mount /dev/test/scratch2, since the same device is
>> already mounted, it returns the same super block and do not fail.
>>
>> The root cause is, when setting seed device flags for both devices,
>> a btrfs device scan is triggered, that scan is delayed and can happen at
>> any time.
>>
>> So there is a race window between scanning the second device and
>> mounting the first device, where the device path can be replaced
>> halfway:
>>
>>       Mount scratch1                |          Scanning scratch2
>> -----------------------------------+-------------------------------------
>> btrfs_get_tree_super()             |
>> |- btrfs_scan_one_device()         |
>> |  We're mounting "scratch1"       |
>> |                                  |
>> |- btrfs_fs_devices_inc_holding()  |
>> |- mutex_unlock(&uuid_mutex);      |
>> |                                  | btrfs_scan_one_device()
>> |                                  | |- device_list_add()
>> |                                  |    |- rcu_assign_pointer()
>> |                                  |       This changes the device->name
>> |                                  |       to "scratch2"
>> |- sget_fc()                       |
>> |  This creates a new super block  |
>> |- mutex_lock(&uuid_mutex)         |
>> |- btrfs_fs_devices_dec_holding()  |
>> |- btrfs_open_devices()            |
>>     |- btrfs_open_one_device()      |
>>        "scratch2" is opened as that |
>>        is recorded in device->name   |
>>
>> Commit bddf57a70781 ("btrfs: delay btrfs_open_devices() until super
>> block is created") introduced fs_devices holding mechanism to allow
>> devices to be opened after super block is created.
>>
>> But that holding period doesn't keep device->name untouched, allowing
>> a duplicated device to replace the path, thus mounting the incorrect
>> device.
>>
>> [FIX]
>> Also check fs_devices->holding value before replacing the device->name.
>> If fs_devices->holding is not zero, meaning someone is trying to mount
>> the fs, then do not allow device->name to be updated.
>>
>> Although this situation is rare, require certain race window and
>> two devices with duplicated fsid/dev uuid (which is already very cursed),
>> still output a warning message so that end users can be informed about
>> such cursed situation.
> 
> Thanks for working on this, the last time I worked in this code it made
> my head hurt, so I appreciate this is annoying to fix.
> 
> With that said, I have one concern: do you know if there are existing
> tests exercising the legit name change behaviors outlined in the big
> comment starting with "When FS is already mounted"?

No, I can not find such tests nor I experienced any failure with this 
patch applied.

Furthermore the cases mentioned in the original comment only applies for 
fs already mounted, for fses during mount I think those cases should 
directly cause failure.


Although I understand there are cases like devices disappear and 
re-appear, personally I doubt if we should even just re-add the device 
automatically.

There are more problems, especially related to the recently introduced 
block device holder.
We relies on the block device holder to reach a super block, but during 
scan we don't provide any device holder.

Thus if we really go into the branch that calls "device->devt = 
path_devt;", it will screw up future bdev freeze/thaw/sync/remove_bdev 
callbacks.

Thanks,
Qu

> I have a feeling
> that this check will prevent those as well, but I am not sufficiently
> familiar with the new holding delayed open logic to be sure.
> 
> Thanks,
> Boris
> 
>>
>> Fixes: bddf57a70781 ("btrfs: delay btrfs_open_devices() until super block is created")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fa7a929a0461..4fdd84e0bff9 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -934,6 +934,20 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   				  path, found_transid, device->generation);
>>   			return ERR_PTR(-EEXIST);
>>   		}
>> +		if (fs_devices->holding) {
>> +			/*
>> +			 * The fs_devices are already hold by an ongoing mount.
>> +			 *
>> +			 * We can not update the device path, or a duplicated
>> +			 * fsid/dev-uuid can replace the original path, causing
>> +			 * another device to be mounted.
>> +			 */
>> +			btrfs_warn(NULL,
>> +				   "device %s is trying to update path for a device being mounted",
>> +				   path);
>> +			mutex_unlock(&fs_devices->device_list_mutex);
>> +			return ERR_PTR(-EEXIST);
>> +		}
>>   
>>   		/*
>>   		 * We are going to replace the device path for a given devid,
>> -- 
>> 2.50.1
>>


