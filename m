Return-Path: <linux-btrfs+bounces-12301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E035AA62677
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 06:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BE27AA6BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524E190664;
	Sat, 15 Mar 2025 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftZTzT0b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971718DB2C
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742015977; cv=none; b=nZHlj2y+FllD+jqxF4FWdVHyVfZMHpL0skGnkCVwCjXE6IBVLwM34TVJKXRQmQXIP0pLS+ylUYTgWYw9HETFIXWCMTCoOihTr4TehuuBolEEo/1CELxBdDM0TsCyDlhJb+xeURoBo+StC+bPNhmGf+LkrdvLOQ75H3aEDPN48OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742015977; c=relaxed/simple;
	bh=Os/oZfMglxSYJ8jPYqL7JXsa6v/yNI9sPgRI4VH/w+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePLWqdcw/uAshFd+4tcpdXygMCt0OB17FMZm6ckG7pHIdUMUbzcFc4n89HEzmU57gOiHV1tSL/Rce7LQMwKvZr9OfyqsLhvyL0Fr210YbOHoWQV0HpF9QLr8JMPiqf2tbD7uQ2H1XwsRFqet3FUkps7fcVvOoJXP/fP8neK9uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftZTzT0b; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30c0517142bso24629031fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 22:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742015974; x=1742620774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJleiuMAepqiaGTbiL4ztZejmYyVxX1hCtttVvtovcM=;
        b=ftZTzT0bHIO26QDNchxH5nmhKR52BGTMzasMwLkku92Kkv8We7x/qhyBy4MScFihxA
         MshnpgiKH9i/q4/6FOlbZYNMjeCWYBtkXW+NEKvMyzKUuP9+7IUSfBnJrkj0jApms66O
         ejsU3Fed2uYpgWR6AF4zs78rrU5JO8AgIYVsJPJdAzyy/zhYbCnvUdOROnedFZi6rbOx
         X9pT/2iY7vGmo5bVls7/iG3wBIyRBWfS95EsRk43VLd5Sp9/ZxJZfBWDsq4rM/rf8uVT
         BfgY76ZOtw8od6yUsc1bLn54rjnBtHFl8AOjpFCKBL6yNHlH3y3/tr0My+SjQarCfGXN
         uCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742015974; x=1742620774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJleiuMAepqiaGTbiL4ztZejmYyVxX1hCtttVvtovcM=;
        b=jBoez+wqFWs58gwH9uJzbkg73pF7kKdczlg+dgt5FztJDP6su8Q6BNWLKCkXsdIJsh
         cS1QF4DfLBIB8fJABb0H/VMdrd0tv8CmKq5lgcw4rpd5RrFBovZiUWTIsrHPTQayAWSu
         AVB1CXwahOBZVO7DJA5zcOrrAaAqJ8cD072IOfScPZC0uDI6iW+M0ZRrNHj2xF1SjYYa
         e7U94gOrPAgXuH8hiA8pETJPwzGWSoumXxuQFS+uCXw7qFGXBinlaH8Zd4M/vgE4bK/W
         23K5dLrgUFNfG2/wDqmi+ghuQ+F0FMZhk+Qo2n2uq2eW5l4qDIdv5FU4G1tSifCQOh89
         lzaQ==
X-Gm-Message-State: AOJu0Yy/erXARLh1FB9rchOAtj90f99xzDZjLh4R7cYMKmDqxA7/XJ6j
	Yk0DaeEYe3j8eOiy8a8rMfIN2ffeHhWqxktjnFnUeS+I68QpD76gmR50OA==
X-Gm-Gg: ASbGncscCGpWgUHvk0kdXfoygUwi1UzNJkdLDeBdzbyG9Y6k9U5WXoCvVxojtNdYCAf
	CNh+A0uYHjgAgcKaN1hbCdYR5o4OIXK/CEuibNyJro2lcbVmgkAIIB3XNzNTLpIL9M2PLv+OB10
	9cb9B6HwpviGNSBuye6AGse+Ssx7x53xPv/Yonc7D2pStedLUhpb6h40xCISRoNgFa/UTB1DWce
	UacBpea5ebmyMr+7+kQYKqnG49LsSunyfnOEkMfGBmD/VWiH2mO0Jfekrb7v/GjK/uXu1jI9Z1U
	5v2vaUrvadLdsruzLYr4NZtqvEfgN1nbuVfDAs0s92Uh/LMiJjZsvn7zAwYy44gtZvpU4eDfK3o
	JuYAadTb12qzWgMVJSA==
X-Google-Smtp-Source: AGHT+IHoowJuTBpfSysASm4oFLHeIHRvrJ61oXEYk/H7PXC3y4mTB/FrNtADkEPWLOVUSHSSdXLEVw==
X-Received: by 2002:a05:651c:221e:b0:30b:ecd6:b9d1 with SMTP id 38308e7fff4ca-30c4a8c5773mr18993371fa.25.1742015973824;
        Fri, 14 Mar 2025 22:19:33 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:5524:32fd:8024:b971:d31a? ([2a00:1370:8180:5524:32fd:8024:b971:d31a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c2e91sm7940121fa.67.2025.03.14.22.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 22:19:33 -0700 (PDT)
Message-ID: <ecb6c1d1-ba76-4c4d-8417-1f71614a7a0f@gmail.com>
Date: Sat, 15 Mar 2025 08:19:32 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strangely uncorrectable errors with RAID-5
To: Thiago Ramon <thiagoramon@gmail.com>, russell@coker.com.au
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <23840777.EfDdHjke4D@xev>
 <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com> <1924801.tdWV9SEqCh@xev>
 <3349775.aeNJFYEL58@xev>
 <CAO1Y9wpT=gZgWD0=69TUefB-+qOSEY+9+zypo89PMQdgdO_P9w@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAO1Y9wpT=gZgWD0=69TUefB-+qOSEY+9+zypo89PMQdgdO_P9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.03.2025 22:32, Thiago Ramon wrote:
> On Fri, Mar 14, 2025 at 1:54 PM Russell Coker <russell@coker.com.au> wrote:
>>
>> On Friday, 14 March 2025 23:27:51 AEDT Russell Coker wrote:
>>> Just to see if anything had changed I ran the same tests with RAID-5 data
>>> and metadata again with the Debian kernel 6.12.17-amd64 and this time got
>>> properly uncorrectable errors in less than a minute.  I don't know if the
>>> error happened faster and worse than before because of some kernel
>>> difference, luck, or some timing difference when running on different
>>> hardware.
>>
>> I did it again but with RAID-5 data and RAID-1 metadata and it took a few
>> hours this time but again got to an uncorrectable state.
>>
>> [15653.298999] BTRFS warning (device vdc): checksum error at logical
>> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in
>> tree 5
>> [15653.299001] BTRFS error (device vdc): unable to fixup (regular) error at
>> logical 5157748736 on dev /dev/vdc physical 1673199616
>> [15653.299002] BTRFS warning (device vdc): checksum error at logical
>> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in
>> tree 5
>> [15653.299003] BTRFS error (device vdc): unable to fixup (regular) error at
>> logical 5157748736 on dev /dev/vdc physical 1673199616
>> [15653.299005] BTRFS warning (device vdc): checksum error at logical
>> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in
>> tree 5
>> [15653.299006] BTRFS error (device vdc): unable to fixup (regular) error at
>> logical 5157748736 on dev /dev/vdc physical 1673199616
>> [15653.299007] BTRFS warning (device vdc): checksum error at logical
>> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in
>> tree 5
>> [15653.299009] BTRFS error (device vdc): unable to fixup (regular) error at
>> logical 5157748736 on dev /dev/vdc physical 1673199616
>> [15653.299010] BTRFS warning (device vdc): checksum error at logical
>> 5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in
>> tree 5
>>
>> Below is the script that broke it.
>>
>> #!/bin/bash
>> set -e
>> while true ; do
>>    for DEV in c d e f ; do
>>      dd if=/dev/zero of=/dev/vd$DEV oseek=$((20+$RANDOM%3*1000)) bs=1024k
>> count=1000
>>      sync
>>      btrfs scrub start -B /mnt
>>      sync
>>    done
>>    date
>> done
> Your script is writing randomly to ALL your disks. You just need to

btrfs scrub start -B is supposed to work synchronously. At each 
iteration only one disk gets overwritten and then scrub runs to completion.

> get lucky for them to overwrite the same sector in 2 different disks
> to ruin RAID5 and RAID1. If you want to stress test the filesystem you
> need to pay more attention to what you're doing.
>>
>> --
>> My Main Blog         http://etbe.coker.com.au/
>> My Documents Blog    http://doc.coker.com.au/
>>
>>
>>
>>
> 


