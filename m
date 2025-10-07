Return-Path: <linux-btrfs+bounces-17511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B1BC135A
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A1D1886B89
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BBB2D97BF;
	Tue,  7 Oct 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apXHoL6A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BC2D7DE1
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836467; cv=none; b=fsw3HJuUBMHPTvQRcuZd8Umezw0AB6GNsLVImBcHqGqh2hQrWHikm/NHH/L3l5fAz5mWzHzmdR75ZVeZuq8PFS604ws+wpktmVtXKIxqaAFk/KF6KnmnGjg2q/mL4rR7V0kZUNYKhIPM8NTT8n+sbvWGMf/6kQYNF7gDWbbdNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836467; c=relaxed/simple;
	bh=wqJDEKVLzUu+bmE8T0CknAlItSCHQK3tCurqt/NOTvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBKUYSAC18MKxXFd7ggRmyWH2Lzi1GsIJvaF/Q95hMxynsD6g2pwAwvzUItbnH+pKKINf7uRYGKLcSl4sQl8umUqiMnzSV6QD2XX1DLWhZU5HOGnpnx50JNBi0eYPdiejX2IYgMCuiraWasVVzd1PxcKteiqnQhEB2bD1Wo+m+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apXHoL6A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e8c5d64d8so59298025ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759836466; x=1760441266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yifwvUfd6EQg5oEIHcFKDrABwZnWbH+QRIqrQ5iFLao=;
        b=apXHoL6Ahl0Qs1Nd0sG2k85jlItPBMgp6ThysTRfqHLSST6AffzXTNSGoMesJ8tD6O
         KsRCntWLpFu3sgI7kpUoMcgOk4TzmV/SgfRivUQ/MxSOxDM+C2M3H46OGT+vvrOR/Ks1
         5p/9QB0lzZtj20d20h1ymH8lwfhg3FClKrisx8bIn+crrd2oEUu59SBMAGQVg8kCFvMv
         Z+IJGfo7eBvD/1PvVWpP+SudCWDgBzNY+a/KxVL0yLHaGKTf3DxGuuveYIw133/6c60R
         apqJrFU5QLd96MOl9KxDaO9VKJrFlY2qoiJSCGUV4zSV/UYaKg2DGe/RoMjDpVkcaznC
         me/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836466; x=1760441266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yifwvUfd6EQg5oEIHcFKDrABwZnWbH+QRIqrQ5iFLao=;
        b=fWhcYHX1u0jdSPIvaxicU/5ojTcKLzsmecsXYEr6peXvYZ8h8xX7IilPNuWgNf0IB9
         lJ00GgJvJ61FlSVT0dEMwogBwA/9soUnUeMzS/hw5xbcj9SqEUAPQQyuRORILvBDGFmB
         au4uR/4mF3qhVrk5fqzoHETH4MVS8weeJCBzoTlie7HHuiV3740TU4dhBLokY9hCfQWu
         CT2VONprGk3yXxqaV3aixDX78ja17GtxZc/rhGhgLZ33/pk4w364BP6Dj1/idHwfibTI
         B8jCRDumtqZPGihcIYmYPdihTSqeV/820N2G29SdT5ooGCAURjqdr2+5igY8IBbk177Q
         G73A==
X-Forwarded-Encrypted: i=1; AJvYcCVwBIU6Rt0n4s5VgFo+cR9aYKd0lf+vP7tTycMa36JHM7p0WoupwyrA5VzHC+zjD9yKdRF8YMt08zkO2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvqXg1BVJb2lLGHX+f6359P+XQ6D5Mz4ftYFihmfwXwKTz6ad
	w+EnXnYOAMx1Mq28stqkC9EBOIisdkHlkolrCgqgF5qmWNbz3WN4Yugx
X-Gm-Gg: ASbGncuEK+q7u7gve9U1o60uBtsFQ1aYqEkwMfwylUfpVm2sE45r9JB1taUqzFcVz7I
	udCybLEAuyueQrqeeZ86IHOaZMdXVf8X2LC+vwDxa3s/vfzzs5J5a6FVujtL8R2cyrYleFPjvsC
	5Vx75RFQqL1cKCIsk9ldGKltxfBmPDlweggcd1U4/UpBJBRzxQHD5L3XQ5Su+l0r8B/KSAM4IMJ
	8iYbuPLOk3+YZO1CF8Z8enSDsu29n6+RqdMGW768Z2W+ChtQtt1VAffWCrCx6kXdASqAy5dw+F7
	NzbYGeL/PKZC4ahhoa5lfRZwThEX9jcIqcBOBcphfYaeuy2UYu3yoxtMmynM7xykkzIYmzWuwfI
	GA517S2YypzhwrdiQmNZtG0I33STpXZ/0IcAwRZ0xmHbWC1n35W6728TBdkdtooFgIMy2k+g8At
	Sh8JqfxWe4FC97ET5OhjVyvaBJtHSF
X-Google-Smtp-Source: AGHT+IE9t88U+YbG30+3sAtH3TwQfdcfJjdGTXfHXsj1cVp+GivJXuDolUUy+jYGYJG4VW843HKwJg==
X-Received: by 2002:a17:903:2c03:b0:248:ff5a:b768 with SMTP id d9443c01a7336-28e9a5134c1mr188374095ad.10.1759836465680;
        Tue, 07 Oct 2025 04:27:45 -0700 (PDT)
Received: from ?IPV6:2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5? ([2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm19736806a91.23.2025.10.07.04.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:27:45 -0700 (PDT)
Message-ID: <a8c7cfa2-136c-4af3-9345-c547ccdab7ba@gmail.com>
Date: Tue, 7 Oct 2025 16:57:41 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs/290: Make the test compatible with all
 supported block sizes
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <8081c6bcdc56ca2018e51e98e7d3086068f026b9.1758036285.git.nirjhar.roy.lists@gmail.com>
 <CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0ExZ8K0A@mail.gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0ExZ8K0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/7/25 16:52, Filipe Manana wrote:
> On Tue, Sep 16, 2025 at 4:31 PM Nirjhar Roy (IBM)
> <nirjhar.roy.lists@gmail.com> wrote:
>> This test fails with 64k block size with the following error:
>>
>>       punch
>>       pread: Input/output error
>>       pread: Input/output error
>>      +ERROR: couldn't find extent 4096 for inode 261
>>       plug
>>      -pread: Input/output error
>>      -pread: Input/output error
>>      ...
>>
>> The reason is that, some of the subtests are written with 4k blocksize
>> in mind. Fix the test by making the offsets and sizes to 64k so
> "... offsets and sizes to 64k..." -> "... offsets and sizes multiples of 64K..."
Noted.
>
>> that it becomes compatible/aligned with all supported block sizes.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/btrfs/290 | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/btrfs/290 b/tests/btrfs/290
>> index 04563dfe..fecec473 100755
>> --- a/tests/btrfs/290
>> +++ b/tests/btrfs/290
>> @@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
>>   # corrupt a file by punching a hole
>>   corrupt_punch_hole() {
>>          local f=$SCRATCH_MNT/punch
>> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
>> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
> Can you please make this more readable and type 192K instead of 196608?
>
>>          local ino=$(get_ino $f)
>>          # make a new extent in the middle, sync so the writes don't coalesce
>>          $XFS_IO_PROG -c sync $SCRATCH_MNT
>> -       $XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
>> +       $XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f
> Here you use 64k instead of 65536, which is more readable.
>
>>          _fsv_enable $f
>>          _scratch_unmount
>>          # change disk_bytenr to 0, representing a hole
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value 0 \
>>                                                                      $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>> @@ -123,14 +123,14 @@ corrupt_punch_hole() {
>>   # plug hole
>>   corrupt_plug_hole() {
>>          local f=$SCRATCH_MNT/plug
>> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
>> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
> Same here, 192K.
>
>>          local ino=$(get_ino $f)
>> -       $XFS_IO_PROG -fc "falloc 4k 4k" $f
>> +       $XFS_IO_PROG -fc "falloc 64k 64k" $f
>>          _fsv_enable $f
>>          _scratch_unmount
>>          # change disk_bytenr to some value, plugging the hole
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
>> -                                                  --value 13639680 $SCRATCH_DEV
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
>> +                                                  --value 218234880 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -166,7 +166,7 @@ corrupt_root_hash() {
>>   # corrupt the Merkle tree data itself
>>   corrupt_merkle_tree() {
>>          local f=$SCRATCH_MNT/merkle
>> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
>> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
> Same here, 192K.
>
> Also please always cc the btrfs mailing list for changes to btrfs tests.

Sure. I will change all the 196608 to 192k and send an updated version.

--NR

>
>
>>          local ino=$(get_ino $f)
>>          _fsv_enable $f
>>          _scratch_unmount
>> --
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


