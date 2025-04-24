Return-Path: <linux-btrfs+bounces-13404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A6A9B9C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C379188DAB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5461FDA9B;
	Thu, 24 Apr 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdOPfiJq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7392221FA6
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529406; cv=none; b=fYxoq/EnQVU/+3ZfGNkGTcGfXbvbuE8ip2Q497feT6RmY4U2Iqg37RmwhyzfiC3yQoWt+DngTCsWnyQiLKL1gJtE6YMiLri0FkujRvi294wTwVrGFP/315yMwL3dij6GLQAdk0fdqA0jrnT450umcOUoSX68iGwVR29jPDIG26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529406; c=relaxed/simple;
	bh=bnt5nO4SdpVehjJxRT5bbjTTDnK+IEwuqee1jXoLlVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tg7hfkrPegwzwUIqbFIMLSE09JYz0DCQm9Sd0aZ2XGotwDAh5uFpexM/gcQxCm0QVQZ7KcBYuRGcfddVPgvzN5teU6Gh/43gSCtGeuQ82lupqqcpaNovw91mCPQ6PV6xSZvD0TBemEEfP+pcmAu/dlWVuiEXf4baBWIT1XdNqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdOPfiJq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aca99fc253bso236744066b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745529403; x=1746134203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qNbY4kvUlrhcrOJmuhtWFAK9+W1SuydVUvxDgtcGDZo=;
        b=cdOPfiJqxeX4MkAq6pQNDjIUUCLfgMyf7LDzFHmpgTDRBTNsZGFM+rfEiGxqTw1DCY
         LeRvVLer23V0baPERpRTB2ULMf5g9wN6osThtcDiRHHznJhKAuZZPt2DZHOwcBtl983v
         PwYMFk4NfZVrzgGUF2/RExhSxFCpR/stdyBXIAWWB9Ad3HfAuvqcY068+VfEw6VlwxW1
         0fG7LQBgNvDCLfpc1eVYHUseJVvL/jCeYcRWtVYyxt4fJSAkcJrkvrM1qTOYzuQE8ap/
         60GVW3XMLUHHZhLSQPV5zmEU1IEu/kUdpyrI+EL9bgrQO39rzGkTBvfpcAd5TNEjMqBd
         9EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745529403; x=1746134203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNbY4kvUlrhcrOJmuhtWFAK9+W1SuydVUvxDgtcGDZo=;
        b=LMKmla/OjowGik0h7Q3LnaeCgIW2XCc8m7+v/LMSGiSgNeqEkmwUVpu+qjxpPH8dy+
         B/V9hpFIeKZn5trUCgQBqDJnW6Rl7Nsz0asab5hlK/Kqyqlc/pLjqtmJ+oYaTU2aScwv
         zjUUvMZDfndqwPoMHKf+CBitMROjEGzksb0zEc3Z/gLDAmxT1T5JZoBE4pSmzGPojPtf
         l3aMoTtNo/kmKPeUzhUO+Po7OHb3HY2x0A3/cUVlZKsIvmwVbv7Fq+vDgoC11Aq8buvT
         Fqp3U6z9qlM8oV06QsVGJqr8JHa6cfsfouJGlxrVZwBpQWk6iJkWitdi/KZN0P5nNXsX
         8GIg==
X-Forwarded-Encrypted: i=1; AJvYcCW/5KqT2Rerte/l2ThAwAQi0q2YRDjex2p61RXJEOQSpkM0FMJ+SVGOMKfth7+KfG5rYZ9b8ivJ+vh7WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynq6jTuoxu0H0GOT+wnfP1YwGUq9wTPPmG33laXHtFWpJ/iIf0
	OF+zaBQ1b3yWYJBS3CYbVy714W0KobQy4vcqqNslHvU1LRQbpDKH
X-Gm-Gg: ASbGncvxr9t3rPxQBvORNxe4dQu9s7vdvUObswz7RoMKAEF9vyV7GXRbBH8ktnKDHLh
	Ix7HR5gOSLKus0by7etKyL0ffDCi9RQ3bvb3RCL3dMVO0eebo/Ep8suuVZMxRXq68k60kQHxB7k
	rpIqxSm0s7EzKADLpShJoo1pBE/UB67gMu6sjKSycPLB+SIvu+zk3QkAL1ywSDYqoPN1S+dePxy
	DpbofViyFMgOWtlwsjcQDHqW/Q5olsJs/UF1XDrndL6JnYZ7RUKYSxzA/2ogOOVLRaG83gJh2Jy
	tWB1ESWYeKdWVpGNePYu0KDJPtgsan9fnWUv6uPBK37tZ3uqcghAzc7hSYk1TjKeno+1boeFXqh
	tzygIdhyBIgZ+kGDb4qhJHG3DQZ5n9Rfw7vQE0j7AAyTY+4x/vwkPDsx4p9afww==
X-Google-Smtp-Source: AGHT+IGcoHsjiPxE83r3e1tXr2skjdd1ZR2QRbnCEk1bFtQcNRDY6YBl/WC59SdzPi55O1O0B6dwBA==
X-Received: by 2002:a17:907:781:b0:aca:cad6:458e with SMTP id a640c23a62f3a-ace713c2584mr2440366b.43.1745529402766;
        Thu, 24 Apr 2025 14:16:42 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:e82f:dba5:732c:3d0a? (2a02-a466-68ed-1-e82f-dba5-732c-3d0a.fixed6.kpn.net. [2a02:a466:68ed:1:e82f:dba5:732c:3d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c491sm22667466b.34.2025.04.24.14.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 14:16:42 -0700 (PDT)
Message-ID: <a0c57ce5-84f0-4534-9d34-d2bd0d305882@gmail.com>
Date: Thu, 24 Apr 2025 23:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
 <3309589.KRxA6XjA2N@ferry-quad>
 <d98ffb69-195b-4c07-ac56-8ae1f811af32@gmail.com>
 <f32bd559-71c7-4d45-9af4-47a913eca63d@gmx.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <f32bd559-71c7-4d45-9af4-47a913eca63d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 24-04-2025 om 22:49 schreef Qu Wenruo:
> 
> 
> 在 2025/4/25 05:41, Ferry Toth 写道:
>> Hi
>>
> [...]
>>>
>>>
>>> Except with newer mkfs.btrfs (I tested using 6.13) the files are 
>>> owned by the unprivileged user.
>>>
>>>
>>> The result is, the image will not boot correctly.
>>>
>>>
>> I found more about this issue here
>>
>> https://lore.kernel.org/yocto/ 
>> tRtu.1740682678597454399.5171@lists.yoctoproject.org/T/ 
>> #m5de0afa17d2c0f640e86ffe67e0d74aea467fd5b
>>
> Thanks for the report.
> 
> Just want to be sure, with pseudo emulating root environment, how does 
> it handle the file uid/gid?
> 
> Mkfs.btrfs uses the uid/gid reported from stat() system calls, thus if 
> pseudo doesn't change uid/gid reported from stat(), mkfs.btrfs will just 
> follow the result.

The change in mkfs.btrfs is reportedly:
"The important change is that previously mkfs.btrfs was
using lstat syscall to get file stats, but then it switched to nftw libc
function to do the same. Pseudo[3] however doesn't support this call -
it "knows" that it exists (at least nftw64), but there seems to be no
implementation."

So, as I understand, pseudo would hook into stats call, lookup in 
database and change uid/gid accordingly. But now there is only a stub.

Right now I am trying a patch for pseudo that implements nftw64. It 
triggers a rebuild for half my image, so that will takes another hour or 
so. I'll let you know how that goes.

This particular problem does seem to be more pseudo related.

> I guess it's possible for us to implement an idmap-like solution, but 
> I'd like to know how pseudo works first.
> 
> Thanks,
> Qu


