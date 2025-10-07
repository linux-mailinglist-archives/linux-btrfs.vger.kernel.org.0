Return-Path: <linux-btrfs+bounces-17509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3BBC132D
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CA03E097D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E92D979B;
	Tue,  7 Oct 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBiEx0np"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862428467C
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836154; cv=none; b=Ampj/cpzaCKO4o0PKWU4kRGRT/YalP/qBK6P4uRI9+ySQphFZEvbwZo3skmkvbYGoYKwJtOpRpkSa3yx4KI/8CQvT1rzozcKzjwIO1CpG+mQAkLMhI8t77KrL4n3cRKm040GzYpt068uia4O43cZ6Rne0LCwIq59hjclICgq2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836154; c=relaxed/simple;
	bh=AAg2VE8iB7bPuEfQ9ClmPTedk3fq8VIVUeYtzbjamMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiGJ1l52Q8ud079cFpoOVMIx9PlolGJRi3a8pYxPaada+Lck954OmfoRPbopleEpX69Uz2sgz1uuoFGALg9Vl4JduK6l+MI/3dVFX4yA4disRI6MbNl4I9D13Glnd102rYUx9jE1pYq35fqubtuA0dCDiInpWjlq5v+JI91vaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBiEx0np; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77e6495c999so6142873b3a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759836152; x=1760440952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYl+85PcERWz3SWqGL0mL4/Mx4Yt41r+iR2lKSkEuok=;
        b=LBiEx0np4XFjJ48ikBjaiVyGIY9HiTA9KoeuoteAnhMB3LrVrtsvhGktiieDq01URI
         jQY8fCFLXFL/LTBWRhunjiamUEfj4MRS8MoJ5FlQruXxmp3Nh74hRa+wTdnwKUz/vpey
         /9X/rQGLjN4M+xd8nrxClqQXE/VcFhXoS/3QSGurmzPCrtmPUDT1eV+BY2gs7EtbOhw8
         NVN/hoTAD89B9wV8xQh1CNv4kDVriMIpez3Ek6K0QEG58+vXUd98tpnKQGqkWrqI+zyC
         iVTqQR2gchJNQk73F+BzUGZmcvyILw1fLpLvOrvPpQAFGGV+X/FKH5TilWowOu4/h7wN
         Ec/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836152; x=1760440952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYl+85PcERWz3SWqGL0mL4/Mx4Yt41r+iR2lKSkEuok=;
        b=GLPN03blBgh6Yg1JUqfFBIXjyyvPWv0ni3Ph6XKRTfZ44dnR2w2fQlX4g8f7xcx9jq
         MjYJJSR8x0IgynfsM5bzJm9fVgL4JhF/VKHsVRyxAcb+JaGY7+TxZ6BuFqEKFfk4xeG8
         SO+dDuZ+X6pD9G9kOBQM8e12t85sMNFN+uEYVV37vrpTHILnavEMsyiynRv8CsHEphtw
         BpseUXh49szers+jwLqcq4g59VLfWbxT2KRby2fu+6o6YtFc0C+dFo1eO+Ppc0yuB2+W
         JcWnxlWfN8BJaeHtMWHf59vtwsu+/sOP+lL78H+oZv/Cp7CEGD/eRU9K2P9pHSq04fJl
         6dkA==
X-Forwarded-Encrypted: i=1; AJvYcCUP54zaVZ6Acck+Prc9b8dhDLtquY5l/JBKJNX2wG+9a+/QSgrtJgZXLslWdVh/rH4h5m7Z5ahQUx7F9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeZzcK2Xx8GDTBRaKDd2CY7WRS4g9tQSEGrimDZfKFCNaTJF0
	T/VNi/z5pTAsDaxQIDWXh9lKgMd77p3YFDXPr/PhgGxMUDOGsSjwNSVW
X-Gm-Gg: ASbGnctUTGfqhh9FLOXaUJvkiDrYCznnVHNcEU4S5P47xbFxIfug8a+ysguxZCncW/+
	7XOU5RKep0GESh5Jrf92bxu0HQU8eI6ho5nAnVzdvjMeKlGI40iZC7zs6dMN2JUAkIkOYk1L/x8
	h934bt7fUX8hDMjGVPZ0Vq+VZGxiur4L4m8hkgoBvivxa4YLwifsMnbDSX+mBSQwoyWbl+bMUF6
	Mr9n2d4Ame/l91rBcPIO3jAnCQbfV+HB4JkSXSYAu0vZQ0ZmKs2G1EHgaZdIPqw3ouadT3pePB0
	aQ8VVOFsRsFOb/mD7RA/LNJSmW5e51JoQWSKONMR/Hlkhq3wZPuGyeTBJMjxuJZ9q4/8+v90meo
	rDY9U0W+chhUsNlcMOxQChL0lAOvF1GVNrTVlfplKercF2CGyu+pCMbrWwwO3KZsUG7M1nRY4q3
	jQXQ+t0ACypfn1kNdzIjIXU52Y+yS5FE+V09JwIo8=
X-Google-Smtp-Source: AGHT+IEOfO+shJRk8mlgNI63ly0IkYAurYlBMqG+ND6IXzSd6ad3wvsaCb+uJ8CbXU90YUZuCYHQqg==
X-Received: by 2002:a05:6a00:238d:b0:781:1771:c12c with SMTP id d2e1a72fcca58-78c984c060cmr20253531b3a.0.1759836151961;
        Tue, 07 Oct 2025 04:22:31 -0700 (PDT)
Received: from ?IPV6:2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5? ([2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e6ccsm15393234b3a.63.2025.10.07.04.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:22:31 -0700 (PDT)
Message-ID: <9d9fd202-2f54-4aff-9cf0-a0ef0d0b609b@gmail.com>
Date: Tue, 7 Oct 2025 16:52:27 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] generic/562: Make test compatible with block sizes
 till 64k
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926165421.k7n3m6o2nuscarkq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <86b3c5c5-82ec-4083-9f1c-ac3fc11b0d57@gmail.com>
 <CAL3q7H5keL6SJt0PpsV7wtDrf8sg0xgVy5piOv5WycCynbmrgg@mail.gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <CAL3q7H5keL6SJt0PpsV7wtDrf8sg0xgVy5piOv5WycCynbmrgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/7/25 16:48, Filipe Manana wrote:
> On Tue, Oct 7, 2025 at 9:29 AM Nirjhar Roy (IBM)
> <nirjhar.roy.lists@gmail.com> wrote:
>>
>> On 9/26/25 22:24, Zorro Lang wrote:
>>> On Tue, Sep 16, 2025 at 03:30:10PM +0000, Nirjhar Roy (IBM) wrote:
>>>> This test fails with 64k sector size in btrfs. The reason for
>>>> this is the need for additional space because of COW. When
>>>> the reflink/clone of file bar into file foo is done, there
>>>> is no additional space left for COW - the reason is that the
>>>> metadata space usage is much higher with 64k node size.
>>>> In order to verify this, I instrumented the test script and
>>>> disabled COW for file foo and bar and the test passes in 64k
>>>> (and runs faster too).
>>>>
>>>> With 64k sector and node size (COW enabled)
>>>> After pwriting foo and bar and before filling up the fs
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
>>>> After filling up the fs
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop1      512M  441M  3.0M 100% /mnt1/scratch
>>>>
>>>> With 64k sector and node size (COW disabled)
>>>> After pwriting foo and bar and before filling up the fs
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop1      512M  224M  231M  50% /mnt1/scratch
>>>> After filling up the fs
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop1      512M  424M   31M  94% /mnt1/scratch
>>>>
>>>> As we can see, with COW, the fs is completely full after
>>>> filling up the fs but with COW disabled, we have some
>>>> space left.
>>>>
>>>> Fix this by increasing the fs size to 590M so that even with
>>>> 64k node size and COW enabled, reflink has enough space to
>>>> continue.
>>>>
>>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    tests/generic/562 | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/562 b/tests/generic/562
>>>> index 03a66ff2..b9562730 100755
>>>> --- a/tests/generic/562
>>>> +++ b/tests/generic/562
>>>> @@ -22,7 +22,7 @@ _require_scratch_reflink
>>>>    _require_test_program "punch-alternating"
>>>>    _require_xfs_io_command "fpunch"
>>>>
>>>> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
>>>> +_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1
>>> Filipe is the author of this test case, if he can help to make sure
>>> the 512MiB fs size isn't the necessary condition to reproduce the
>>> original bug he tried to uncover, I'm good to have this change, even
>>> change to bigger size :)
>> Okay, I will wait for Filipe's comment on this change. Thank you.
> This is probably ok.
> This test was to exercise a bug fixed in 2019, commit 690a5dbfc513
> ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when
> cloning extents").
> It's hard to confirm nowadays since the fix landed in kernel 5.4,
> trying a revert of that commit is not practical since there are tons
> of changes done on top of it, the alternative would be to test a 5.3
> kernel or older.
>
> The while loop below should ensure we try to fill all metadata space
> with files that have only inline extents, so in theory it should be ok
> for any fs size.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Btw, when you do a patchset that modifies btrfs tests, or even generic
> tests that were motivated by btrfs bugs, please cc the btrfs mailing
> list... I haven't noticed this before because the list was not cc'ed.

Yes, I usually cc the btrfs mailing list but I missed it this time, 
sorry about that.

--NR

>
>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>>    _scratch_mount
>>>>
>>>>    file_size=$(( 200 * 1024 * 1024 )) # 200Mb
>>>> --
>>>> 2.34.1
>>>>
>>>>
>> --
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


