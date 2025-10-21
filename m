Return-Path: <linux-btrfs+bounces-18085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B734BF4377
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 03:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC51B4F36FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF32264C4;
	Tue, 21 Oct 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQMqGCm/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765071DF75C
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008535; cv=none; b=c3Sk+RLhvgLFs6FAKInqnH/kKl5rCnrASOm5qqoruRyMg9OMnU9YtnsL9NbHpfhjVz3gO4BZeSqCoL578rmwyK36N1uHiyapbh08csNMmBccvEYUTGpei1ktzk8iJg3yvLg/60FR/W5+wJe7TU3E0d1E87EgmdS4wwVuQ8rO53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008535; c=relaxed/simple;
	bh=3Lpyqal9yYfLKFuSpOsF5HPNU6lI2iSP3D7lKo+xLWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BcxM0wVzpN0XSVP/mzFmcL0l03fowutxZKO2CE8oT2ck54c4ZD8DGHFjFqaR3t+VSUOqlXcU0xmol03TDW9FdUW1+AgDem1LwcThbRz1faQ/kJfvD+m6Je5Phk6XEZIE1H7N7Qo4HwW//2MLL3vlym39OOqPtQWXcS8IUEZofOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQMqGCm/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4562893b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 18:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008534; x=1761613334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsCFeoBv/CAN+NRKgeOpiVvFNnHYHdfxEO2vyJphOXQ=;
        b=CQMqGCm/GuoY0GhRXgAla92vLsS2B5HM1XEeVRJajFTtD8rb/azeHRdeOV9p+FQfTI
         yitWtH5+1cG2/Xw0vbZq03OHp9yqEFWjL+BM0DfM9SOQCKzIhFdwUY656uHtp8LNgAqk
         H3RB7Qd22aOlMRWTOBvW8jrLpCgZoJ8v23XWvrJnUOxyPHwznpvlucj6GoAT6r9HcifU
         U7Izqqkyo2DGBEmUS7NaI+mXnhFqEJ7Ox3ssSA4KdK/Ig33Mbql0dviYaCGHtIha4yIP
         43GN8CP1MHa8X497voQ5RvR/aGfJ8lk1BXM7luneBCN4QrTdXaIA+EhDZ+XS3c5jQzA0
         W7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008534; x=1761613334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsCFeoBv/CAN+NRKgeOpiVvFNnHYHdfxEO2vyJphOXQ=;
        b=cBiy513ZAGBK8UASNpE2tkDyNl6eZ7xwUW0mXOxIedMki/p1dQvHBLxpuV+9QcoMaz
         JvBUsbcKmIgI9ycHrExkUL2pGAu/XMjSmiYAceVfx/kGAuS5vMh18XkyCL3U5WyNnsKT
         dItoMRN3fe9dIFaIAIBrzBYza/Q34j1E0dya4Ld0huUCBaX5jsNRQIyXhNQV2NQFc1Tx
         8ciojijxXxoC464xyq08svPY2f4wygvXRYl0ta2YmZghtD6Zg6r8ua9V2FOsoh5QwSVV
         6+Rhdi1FEwK87IqESZ1smXUln8CIdPNkVgB2P29plJdi3C0v/3h4S71Jj4spFm6eAW/m
         tP3A==
X-Forwarded-Encrypted: i=1; AJvYcCWuLb6Nm1hvFld9COpEdhqet2d2MZEaBIICT8J7kmDaHd0KlhsMSpGroa9O42lyqojd7OJjF4PS+AWtXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmFDatREJRoAf8aaklt2TOuX2Gx20Kv/xftxzrcmUj3d54AhC
	hl6NViz+0FGN54HLtYVPqh/KTUCFqoFapjW1q638ptjY1jt66/lzD7gMcjmcXA==
X-Gm-Gg: ASbGnctCJb2HJG3beF9yOTAWUdhYmvN72jFVKb8iFMSmVm8Weoy8HKZU6brFG/n50+p
	Oa+8gQYP891O8OpwfYpHq2ceAVcEWoHJCS6kXaxyqUQEa0Fc/oVKi3IyLAUuRmDC0EA4jHhphbz
	zxJJ6YDo1w9AePP9GVhqMWdn0fgaDrGtgT3c6ioLBq1K9byQfESFtd/BSy3p4GSVQo5KY7dA381
	dDzWXDNE9kzRrfBl08DBbgH6SJUwQfUDAZdFEqbtiJdKrs0cnsIR488jycIEaC0Cx1UVJLFy5Bg
	0WZPKIRYxoZI3uSEg1jRzZ17XTv5sENRgXHnin5AQCqNOYwTrDu1XXy3Eq5G2P071Z1274YK/gA
	lEJo0LAIHwJtXtcscLezflUJjUl/TWheD8gdfdPfYJTIcQ35CMr7F5oJe4zKfopfKuzMXUbuFZM
	u5I3KL3mk2m3K1XL+OKumizrQqJMajsTKj34AnhonuEAbfKdoAm0agJE0w3t5UT3JK/WYWzi6K
X-Google-Smtp-Source: AGHT+IFNCGVYDxKpjLhOCTnCvtLYeF/YfSqoipdGKu2vUo0vPckAlElqBftV1bFLDMCBbkMtWp0Piw==
X-Received: by 2002:a05:6a21:3290:b0:32d:a6d1:22b2 with SMTP id adf61e73a8af0-334a85047a0mr21087854637.10.1761008533572;
        Mon, 20 Oct 2025 18:02:13 -0700 (PDT)
Received: from [192.168.188.28] (210-5-38-62.ip4.superloop.au. [210.5.38.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm8778223a12.29.2025.10.20.18.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 18:02:13 -0700 (PDT)
Message-ID: <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
Date: Tue, 21 Oct 2025 12:02:09 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
Content-Language: en-US
From: DanglingPointer <danglingpointerexception@gmail.com>
In-Reply-To: <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Are there any plans to work on either of the proposed solutions 
mentioned here to once and for all fix RAID56?

On 22/9/25 17:41, Qu Wenruo wrote:
>
>
> 在 2025/9/22 16:39, Ulli Horlacher 写道:
>>
>> I have 4 x 4 TB SAS SSD (from a deactivated Netapp system) which I 
>> want to
>> recycle in my workstation PC (Ubuntu 24 with kernel 6.14).
>>
>> Is btrfs RAID5 ready for production usage or shall I use non-RAID 
>> btrfs on
>> top of a md RAID5?
>
> Neither is perfect.
>
> Btrfs RAID56 has no journal to protect against write hole. But has the 
> ability to properly detect and rebuild corrupted data using data 
> checksum.
>
> Meanwhile MD raid56 has journal to protect against wirte hole, but has 
> no checksum to know which data is correct or not.
>
>>
>> What is the current status?
>>
>
> No extra work is done for btrfs RAID56 write hole for a while.
>
> The experimental raid-stripe-tree has some potential to address the 
> problem, but that feature doesn't support RAID56 yet.
>
>
> Another solution is something like RAIDZ, which requires block size > 
> page size support, and extra RAID56 changes (mostly much smaller 
> stripe length, 4K instead of the current 64K).
>
> The bs > ps support is not even merged, and submitted patchset lacks 
> certain features (RAID56 ironically).
> And no formal RAIDZ support is even considered.
>
> So you either run RAID5 for data only and ran full scrub after every 
> unexpected power loss (slow, and no further writes until scrub is 
> done, which is further maintanance burden).
> Or just don't use RAID5 at all.
>
> Thanks,
> Qu
>

