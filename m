Return-Path: <linux-btrfs+bounces-10087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DA9E653A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 04:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217E118843F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 03:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74648192D9C;
	Fri,  6 Dec 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0lF3l+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB16FBF
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457557; cv=none; b=epFmAtHffFEVcOEttfJ5V2OBRPcWPpMbpM8LwofNOidCx+vgtWLHdfoCfGLScGVwEtBWn96XFkTcsB4VwjIhjBut/jlrvvZ7sTUjCRBnOqvuln2i8Mi5zEjJZ4PVYkG92+NK+Z73nF9o9XylYXkRExf4q5/PKSnPEdXC4WBGGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457557; c=relaxed/simple;
	bh=m6P8pyODp4Ua8M2J2TmNtJqMHZ7K9WGm34un42oZFIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RRvKVOXzuJcnqNqQ/S1daP9OFEf3MYOVSjU/NA0xJTP4svFUZ5W3HEIv73c1U3DzjUDOoC3jdCZy0KW4fIG4c6st2J+PLIkz2oz8nNvwsS+esUPae4MbTvoQguZWaPYPzIGJdFGKlBHkOttNxZ8lGASw9RnwnjDRxpVs4zlKHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0lF3l+O; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so13923031fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 19:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457554; x=1734062354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCl1vWqDJufmyxV4V/+gCneIKEh1wDG7Pm4cvx4piW0=;
        b=i0lF3l+OWUuLaayZVK7F33J/yBNxMmc0Krolx9Yxvsw2jjzzcS6I0vX79ktsqGIKHB
         Etf2dz2EVJHTS/f65buShYCMKsW26TQm/BV1Ibr9rnptRyT9LwAT9fRb3fhDnyLyGQfw
         tjduEpRvir+sWark0IWeG5Mag4T9wGb/LhyPz/hDmsr3dfkL7OOyohMFzXc7eLYybvnP
         CxIO7DmkFdcD0CVEG0o3ouzyRRv25h3wInH5/Okjvx4BusrCqBnoOqgd4B00x55SmEmg
         V9ooZ/0bJdYzUdnnCaNM69Qajhm3hjS6FcI9Zdp13yGis1DAorxrI6DG7GT1GzZ5ALKB
         OGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457554; x=1734062354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCl1vWqDJufmyxV4V/+gCneIKEh1wDG7Pm4cvx4piW0=;
        b=cYzuWGsM0Aj28BspWyIFtYr/jNnC2MicFXLAPfEfuDeofZTnGx4YWeJrXPRWcxji1v
         iqkygYRlpHmntVEz5fR4rGmpcsOsRZ8GwG0UwoVofAEheGWKQWwjbR592eFngh+D2Mc5
         iP/JZXHDOcS7McffPBJdyjmUkB7TjYomaKk51qLIGdFK7RXdQX0o/GReg4ZFCnVpYMpg
         v138knXZC1BfG/fUtEXARtsvA4J96nn0C40j7/fx29QIJJgcJbKjK6vreyuhrQwrIi8j
         O+ojUWCKvOCGy8E7zHaFr+sEdKbaXOlUPhb8tis2Az8K8TWJUDslTpHi+OjI5CcYWgSO
         xapQ==
X-Forwarded-Encrypted: i=1; AJvYcCX55F6V13Z4uonngTyzdk2EiuZbWOiV7Jyf8ArABcN9rP5Wg3H2hN4tFwd75Cg9t8LFqWNrxcfZtR7y1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAScMDCKfWxv0uoCBqrDfuUi7QEevL+GENpo+fkGjgEAhWxfF8
	9Rru9fFd+B8rmxMHPr17DeKcwksgS/eZV0+T6VQOWlDeLIPRH5NcldpXDg==
X-Gm-Gg: ASbGnctho6zLx5ArjEeBqmJ6DmFrR8C+dqg7NBfF8uTMS7oerOD7LAOpky6Muv/AdSN
	JQ4OwmBkJH4dqaW7gsCU55HgwLDV5gZihoo1zXBm+aU9N+6EFQHsIFAREYZM+prTtuefU+WVDia
	qapDKshjsxgYkjRTgu0wG8kLy2SkAR7KjvDfY2M/fPrzE+KLbfpDS5mwXzZuUsfMhxsFnWBCGC1
	IfNAgTORCqWZ3XcbCNSMqxjte8MckQnXQcNGSQl7y9ZGcoRVA1U3rGz/kpzWJPVM66TOmYjOArQ
	AFL/cZFuhbTz75V+bAQmYkTE
X-Google-Smtp-Source: AGHT+IFOZ/znaC4Ah6MctPxJJjoflPgr6JMenVKEHmpnR+AgE18tEzHzJPAmpQ7QLIZlFWRdjj7VDw==
X-Received: by 2002:a05:651c:506:b0:300:28b4:163 with SMTP id 38308e7fff4ca-3002f8c3a34mr3296281fa.9.1733457553691;
        Thu, 05 Dec 2024 19:59:13 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:4da4:e5ff:50a2:b82d? ([2a00:1370:8180:3d9b:4da4:e5ff:50a2:b82d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e6f079sm3639101fa.115.2024.12.05.19.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 19:59:13 -0800 (PST)
Message-ID: <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
Date: Fri, 6 Dec 2024 06:59:11 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

05.12.2024 23:27, Qu Wenruo wrote:
> 
> 
> 在 2024/12/6 03:23, Andrei Borzenkov 写道:
>> 05.12.2024 01:34, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/12/5 05:47, Andrei Borzenkov 写道:
>>>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> 在 2024/12/4 14:04, Scoopta 写道:
>>>>>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>>>>>> posts here about doing so "successfully." I want to make sure I
>>>>>> understand the limitations correctly. I'm looking to replace an
>>>>>> md+ext4
>>>>>> setup. The data on these drives is replaceable but obviously ideally I
>>>>>> don't want to have to replace it.
>>>>>
>>>>> 0) Use kernel newer than 6.5 at least.
>>>>>
>>>>> That version introduced a more comprehensive check for any RAID56 RMW,
>>>>> so that it will always verify the checksum and rebuild when necessary.
>>>>>
>>>>> This should mostly solve the write hole problem, and we even have some
>>>>> test cases in the fstests already verifying the behavior.
>>>>>
>>>>
>>>> Write hole happens when data can *NOT* be rebuilt because data is
>>>> inconsistent between different strips of the same stripe. How btrfs
>>>> solves this problem?
>>>
>>> An example please.
>>
>> You start with stripe
>>
>> A1,B1,C1,D1,P1
>>
>> You overwrite A1 with A2
> 
> This already falls into NOCOW case.
> 
> No guarantee for data consistency.
> 
> For COW cases, the new data are always written into unused slot, and
> after crash we will only see the old data.
> 

Do you mean that btrfs only does full stripe write now? As I recall from 
the previous discussions, btrfs is using fixed size stripes and it can 
fill unused strips. Like

First write

A1,B1,...,...,P1

Second write

A1,B1,C2,D2,P2

I.e. A1 and B1 do not change, but C2 and D2 are added.

Now, if parity is not updated before crash and D gets lost we have

A1,B1,C2,miss,P1

with exactly the same problem.

It has been discussed multiple times, that to fix it either btrfs has to 
use variable stripe size (basically, always do full stripe write) or 
some form of journal for pending updates.

