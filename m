Return-Path: <linux-btrfs+bounces-11682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231BA3ED89
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 08:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33B03A898D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9251FF608;
	Fri, 21 Feb 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CV/UIAwd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E51FC7E1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123941; cv=none; b=W9ZnPY1hkDMJy6ndHSbk9R5fmFhH8iLy+kAV877fObvVUBTnnKJw/0zil0RPtfYe/x+3clTLcBK8mQV1cECoE+PVK6Vh/guTOPnxXuBIIeBKMshIfE8YISZfWCUrwCi9yUjSR3qXmh2VHQzNaYCyME1QeyleSOq+vO87sdxHL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123941; c=relaxed/simple;
	bh=34pImCL+5E3gNICqNpVCVHOsV2IR7Fddg6o+QexGwpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKJRXWUAruAAPeu+1pqQfPK1A+BdJ0UmHYWrNSIQVM8O0fpiOaHYeT7X1BTS09LS1924FSc/1LjneWOevBiEFHV62IBZSMBSJnXLCT4AWQVF2FhWWVUjpzKMJ1CJiKa5D8p0jei9nwc+rUFFdcByk9PGOu17xuLBlVf3tI0Y1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CV/UIAwd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so925982f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 23:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740123938; x=1740728738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EFu6fZQwIe9fowgPHoc7rPjVd3zS/+wgbQu3QKS3WZs=;
        b=CV/UIAwdkthghZYi4B0uO/G5ZSiKbbDhXpy1jJ8S+TU6jAm9Or9NZO8Iro1DVTYneL
         pMVwXpcbUPNO17rTEC4uI4hD7WPVqtbnhg4aM/hPxAzqcKR0ZSZzIATohC2SG6IuU2UU
         1D7DT8EEGyGgzTu358wa2Q9PL0cmOmVKOjwhkHxQSK/K/FHshdx9dB7viHzi8SBudqPO
         j7p9iQplMlC5tCnTzwhhkEUFUHKu2lXA6akE6US6EWX3NNXBDLrgLkDN+Ez7wOwie9WC
         RibPUHVnJsP44TaFa/H4ZjGGipBxYJyyMdmZgeSAI44oeis5dfwZi39gSHwn2HK6PXCx
         Hl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123938; x=1740728738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFu6fZQwIe9fowgPHoc7rPjVd3zS/+wgbQu3QKS3WZs=;
        b=Qp3bSWx59aZ+oLd4+XoqhZWNG3Q2t5u9Nt0qK0msOhnyFbBHxjFp+CVyPs7LJYZ2TM
         btIL0excKAq2occ1ZaQE/8jkx8m9MIu+hbtPsGQzXTRyJRgjf1Pgm0cqbqaGfVVx9ufi
         aaR13iCxkTKTyjw9OHmNMrr+OE46vzfdGQnkRbUCbp3U9axDS6WBjVfZ9L4MjaKofI0y
         eq51uyRgFeonP9ebD5fiWoE+K/5J7pGkUTIeovFq2MKXSgcO+HJjjrLIeRr5TU3vLXGp
         o1678BtDce/hfK+oGChflbRvHw6UAwezDiRDKnaD0RkMl4tQxnkuKQTfMWO5P31g7Eck
         Ft9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt/cHN99UJ6EMYSpBA6u0qRiE7ZgLXfBOZEMYYS/sBAi+C3Pn1AsFDlKKh9B+1ECQF5sNeA2dV/7h/Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6zNYPP99srhjTKlzOExaUdFtpfbvVvokoabzAvrhm7U8Mq34D
	ymjRrm0Wx/no783RupvBYg7sEUxgkToRNg59axwOYkz7sRjyRMWfjifRtLIhQESuK3J83VmfFmP
	C
X-Gm-Gg: ASbGncsTOcvu7EddXGl/ftkEmKdglIZa3wnHUxfBatjWe6zK1tXw0L6rimVCx0HliIj
	j43KVx9QzVv9mCSSE+tjkewSrULJ2fgyAhcJG9FX3ZTkrtjNCGMdqpDrcAQ39Uue3HUrT87l/wl
	Z7BmK6kjicPt7k7UXNZENQ2G+121VF02uvwrPZ2A1wAq2HvTNir2/7isc/aPotmQ9lmf4Fti1hV
	8B2v2QFfKH0Cl5ZtVz6RR4c4gzzvmDF+6MjLD8wmC564DKqpLCUdQks5BIVnhRTL6Z0TkNZ0nXL
	wJd7Ekva5o0zJ31QXnEcewd55bCN7n8khoFp3Frfzct3Kfml4eZA/A==
X-Google-Smtp-Source: AGHT+IHJvVOZAwXXxkzNFg+ajMwd5OPzrqjKdywl7qJpOq64qQVa9Ezx/Ge+I+wCIYwxjbHyr4zHnA==
X-Received: by 2002:a05:6000:4010:b0:38f:31b5:b33e with SMTP id ffacd0b85a97d-38f70827a09mr1561118f8f.35.1740123937418;
        Thu, 20 Feb 2025 23:45:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e324sm15060613b3a.88.2025.02.20.23.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 23:45:36 -0800 (PST)
Message-ID: <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com>
Date: Fri, 21 Feb 2025 18:15:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Anand Jain <anand.jain@oracle.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
 <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
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
In-Reply-To: <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/21 18:10, Daniel Vacek 写道:
> On Thu, 20 Feb 2025 at 22:54, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2025/2/21 08:06, Qu Wenruo 写道:
>>>
>>>
>>> 在 2025/2/21 01:27, Daniel Vacek 写道:
>>>> When SELinux is enabled this test fails unable to receive a file with
>>>> security label attribute:
>>>>
>>>>       --- tests/btrfs/314.out
>>>>       +++ results//btrfs/314.out.bad
>>>>       @@ -17,5 +17,6 @@
>>>>        At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>>>        Receive SCRATCH_MNT
>>>>        At subvol snap1
>>>>       +ERROR: lsetxattr foo
>>>> security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed:
>>>> Operation not supported
>>>>        Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/
>>>> tempfsid_mnt/foo
>>>>       -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>>>>       +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>>>>       ...
>>>>
>>>> Setting the security label file attribute fails due to the default mount
>>>> option implied by fstests:
>>>>
>>>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/
>>>> scratch
>>>>
>>>> See commit 3839d299 ("xfstests: mount xfs with a context when selinux
>>>> is on")
>>>>
>>>> fstests by default mount test and scratch devices with forced SELinux
>>>> context to get rid of the additional file attributes when SELinux is
>>>> enabled. When a test mounts additional devices from the pool, it may need
>>>> to honor this option to keep on par. Otherwise failures may be expected.
>>>>
>>>> Moreover this test is perfectly fine labeling the files so let's just
>>>> disable the forced context for this one.
>>>>
>>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Thanks,
>>> Qu
>>>
>>>> ---
>>>>    tests/btrfs/314 | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>>>> index 76dccc41..cc1a2264 100755
>>>> --- a/tests/btrfs/314
>>>> +++ b/tests/btrfs/314
>>>> @@ -21,6 +21,10 @@ _cleanup()
>>>>    . ./common/filter.btrfs
>>>> +# Disable the forced SELinux context. We are fine testing the
>>>> +# security labels with this test when SELinux is enabled.
>>>> +SELINUX_MOUNT_OPTIONS=
>>
>> Wait for a minute, this means you're disabling SELINUX mount options
>> completely.
>>
>> I'm not sure if this is really needed.
>>>> +
>>>>    _require_scratch_dev_pool 2
>>>>    _require_btrfs_fs_feature temp_fsid
>>>> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>>>>        # Use first 2 devices from the SCRATCH_DEV_POOL
>>>>        mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>>>        _scratch_mount
>>>> -    _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>>>> +    _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]}
>>>> ${tempfsid_mnt}
>>
>> The problem of the old code is it doesn't have any SELinux related mount
>> option, thus later receive will fail to set SELinux context.
>>
>> But since you have already added SELINUX_MOUNT_OPTIONS, I think you do
>> not need to disable the SELINUX_MOUNT_OPTIONS.
>>
>> Have you tested with only this change, without resetting
>> SELINUX_MOUNT_OPTIONS?
> 
> Yes, I tested both. Actually resetting this option was the first fix I
> came up with, that's why I kept it. This option breaks the test case
> when SELinux is enabled.
> But then I figured the other way around (using the option consistently
> with all the mounts) also works. So I added it for consistency.
> At that point, resetting the option is not really strictly needed
> anymore (as you correctly suspect).
> 
> So there are two possible solutions. Each one makes the testcase 314
> pass. But they can as well be combined.

Resetting the SELINUX one is not a good solution, that just means we 
reduce the coverage (No more SELINUX coverage for this test case anymore).

So please only fix the mount command (with the extra selinux mount 
option), without overriding the existing SElinux config.

Thanks,
Qu
> 
> Anyways, this test is fine without forcing the default mount context,
> which is more a bandaid for other fstests, IIUC. There's no need for
> this option in this case, at least with my testing. Hence I disabled
> it. Does it fail for you?
> 
>> Thanks,
>> Qu
>>>>        $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
>>>> _filter_xfs_io
>>>>        _btrfs subvolume snapshot -r ${src} ${src}/snap1
>>>
>>>
>>


