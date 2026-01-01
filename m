Return-Path: <linux-btrfs+bounces-20063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FDCECFDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0557C3004F0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B15296BB7;
	Thu,  1 Jan 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyKW8s4o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3273C0C
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767268484; cv=none; b=SgSCV5rYHSEZcWOnEmbdXSf+j7FnEXRZNaW7KADEJnW+l/FYugUV1WIRmlu5JxW9IIXoNhmLn2MMRsgUUue93mal1+xu/VwLLvlfkSsju6g3V6mgJMvYy0mBqtLCDCMgTXjziD7brW02sKTqPS4LERVUfsY4aPpqamLO9YfF27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767268484; c=relaxed/simple;
	bh=ybMANM8gbOxwaCPuBB8RsijIfIoFQr9IJ8EsnMwzyus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlpYY22Laot3g7ngig/S2hl2LDRHV2x29FTerBONesdOYPIO4bjY6McKL3HXq7P+nhsfk/8HPmPVTlJKgjeDpj8rG2UArZXJkUSmiXMFo78Gyy4dH66FcZDsGU1I/bpryDQDdvOnz27GfRCNlAaTGPF1zwCfC3Gyv33n4PkE7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyKW8s4o; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34abca71f9cso1277556a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 03:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767268483; x=1767873283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tbd13O9fjw2yRzLWAIARol6yij23tgpu2gS47XsITQ=;
        b=KyKW8s4oBEwsqJcisnux3gM7yW2oBGMc/MF40v/5RMPCvhBfrI9YdQMlYQ955JtP9l
         xBxjVGk9L7CgK+RGU6EDwQOuVPb8rBYxNFobL7F5EAz8nhmyPFugEssvOI+vzGpz0sOx
         O4xq+0jmnLZQd6pIVwCH4V/UuGnh4Yk+DbCQf9rNQa6bkGyfl7HKr8rOKE2nvnu/Yf55
         2A8EH7j5Vw83DY0R3Qc+cRA6PKy+jkImG4+eRMWx5ogyLsUvDRsbJCWGJ0cPVhB+bXzO
         R6Qwi46AGpJ04OHE+9kCpCofIa4Ps/l/0rKEc2Pi4C6hXmncHQ/WJ9A2DpPb+lFReyu+
         UuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767268483; x=1767873283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tbd13O9fjw2yRzLWAIARol6yij23tgpu2gS47XsITQ=;
        b=fvghJ/+Z9VVhccj3csyZ/ENR5aA9idyoAiANeejCwN8Xpgy0rDuSO1r0WKrqNqx+Ej
         ukhX8SM5s+W3YZSvUY0hB55WyFhdqnXdIyr40nyayHeMiiZFuc7GVIp+4Xb/hMDvyw4c
         DPA7MxfmLzQWXSjOvS3lQF0zdkLRbwPkRTNBEjECf9hTpoP2nxsbeCU/IyIAdoN5CqV5
         Kb1HH+zbpn798yIUU8QrBnxhoFT/9RJ0vPCFSo2gJ6e7u11PF4z4BppQXi725vo+qyLP
         1sNJOnul4YXls/uYLreYArzstOv8Ff0hQ/zwIrdzCIjBLjbiYQpG/lWPhz0gyRy47TBX
         sDTg==
X-Forwarded-Encrypted: i=1; AJvYcCW4mSL2RmIWqywnw7rIjMZ87afE276uxfM8ZDMgxi8VhYO1u5oJO6UpUFuJkKANvzsG/YJINQ7ttbps7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/Usy4I/N1fczJ/AdFiagRK8/2Ug3W6vgtmiwHwwzJgDmlRZN
	YUcQtEcXdRMFvHFufKsNQN6FkqNKFGnYJWddSo06mLwc9HNF4owCxk9abynm2LzBXbparg==
X-Gm-Gg: AY/fxX4rREh4XCJ4+oOR15WH58INFHY+ySQBEE30opb+u/irKm9nr+6weXibCZyxDIJ
	p0ItFr8xc1cPKIkztOXdRNIXOszds5GA00w+liROSAH/tLxgkn+Z/y2qe8RY0IYMPsWt9e+nK38
	S8cN6PBROK1VI4iZaziOtCb0PD7pWGyiCo11CaA+iwGQpclYZcHJ8TyxtMc1dmrLi3NS7TIEGzC
	5DzPrVMqNxUCAL+qzFSsWr8AaDCVnpqR9e6DPOlQttsWu8JS84KVeHBl4IYzsIP0R1yVSimkOoA
	TuiImc8hK2GQ02K7a4Tyx+Dvlyc7ry6QnTZ25CLrS0evB9c4yt8iuSvdZ20OY60DAR7z9U5apa6
	TcPNaMNjtiJK7u9AGqI/sSqwl/YxO3D5bdDZddLNvNJIXxJLHDSk3OdTJIJ7NgSbbDzU5/XaUZq
	Oku0ZbJHAmJlq3o9hDGUBaaNLL/Q==
X-Google-Smtp-Source: AGHT+IFlY0Y01pADI6TSaBtsc7Hg8noPdrBVFnRDW9vp/o2Yzja4R1Bzr0qhckySD1smjCAaKL+7Hg==
X-Received: by 2002:a17:90b:580e:b0:340:dd41:df7d with SMTP id 98e67ed59e1d1-34e921aaad0mr24735611a91.3.1767268482636;
        Thu, 01 Jan 2026 03:54:42 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c2e20a646e8sm18012999a12.11.2026.01.01.03.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 03:54:42 -0800 (PST)
Message-ID: <634cb945-973d-4e4d-8498-df596a46618e@gmail.com>
Date: Thu, 1 Jan 2026 19:54:36 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: fix periodic reclaim condition with some
 cleanup
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
References: <20251231111623.30136-1-sunk67188@gmail.com>
 <380cafc2-1460-474e-b793-ea7813103dda@gmx.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <380cafc2-1460-474e-b793-ea7813103dda@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/1 08:13, Qu Wenruo 写道:
> 
> 
> 在 2025/12/31 21:09, Sun YangKai 写道:
>> This series eliminates wasteful periodic reclaim operations that were occurring
>> when already failed to reclaim any new space, and includes several preparatory
>> cleanups.
>>
>> Patch 1-6 are non-functional changes.
>>
>> Patch 7 fixes the core issue, details are in the commit message.
> 
> Fix first then cleanup please, this will make backport much easier.
> 
> Thanks,
> Qu

Sorry for bothering. I have no experience with backport things so I need some
more guidance here.

The fix patch needs two of the cleanup patches applied. I currently have no idea
what I could do to make backport easier. Should I also add "Fixes:" tag to the
two cleanup patch? Or should I squash the two cleanup and one fix together to
make a patch just for backport?

>>
>> Thanks.
>>
>> CC: Boris Burkov <boris@bur.io>
>>
>> Sun YangKai (7):
>>    btrfs: change block group reclaim_mark to bool
>>    btrfs: reorder btrfs_block_group members to reduce struct size
>>    btrfs: use proper types for btrfs_block_group fields
>>    btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
>>    btrfs: use u8 for reclaim threshold type
>>    btrfs: clarify reclaim sweep control flow
>>    btrfs: fix periodic reclaim condition
>>
>>   fs/btrfs/block-group.c | 29 ++++++++++-----------
>>   fs/btrfs/block-group.h | 22 ++++++++++------
>>   fs/btrfs/space-info.c  | 58 ++++++++++++++++++++----------------------
>>   fs/btrfs/space-info.h  | 38 +++++++++++++++++----------
>>   fs/btrfs/sysfs.c       |  3 ++-
>>   5 files changed, 81 insertions(+), 69 deletions(-)
>>
> 


