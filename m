Return-Path: <linux-btrfs+bounces-10106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C49E7EB8
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04914188581D
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC713B7BC;
	Sat,  7 Dec 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx+9256o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE40137775
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557027; cv=none; b=nR7i7r5mTcwOv1PKUhu3rDjGF8ip0XHAJPX+y8O9cG8OvgYgknpttGAM3VhNvIon1O/mE1MdhhoyVjzvp+nHT73dJfFqCN3t65673NelWUtswXh51DlRj4O1mBnRI1yDKzbIQrYeKJxscAHgeYGDsrRMBpVDK/KH0YfSJypqIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557027; c=relaxed/simple;
	bh=uqv6UySy7SW8N/KBA2DRFPaJiTpryfOOTQDg1gcUavY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HdpBWx35njGmCFRbwxcLXDGRn2iUt53fqdDP3VnMxQ5kbro6Jp9tLTA0mFx658TJcN8+8JrLFZfhgT3psriCXLauCjxTWAEU6DNKMc6imEVRGIcrizcHw0VR1wxqFg0M64Qxsc6JIJJm70Xy8lsCqBCNIYOMIMjCN7lv6A26TO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx+9256o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso34959151fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2024 23:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733557023; x=1734161823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzfMxlAt5GNeeNCYaLumuVBfvOy6V2nfIHnriL3tfzo=;
        b=Tx+9256oW9CIWOFbE7mSuo6V+d/dtZpUhUbSBI3/II9RAORDLJvZ5b+A8Fim42hik+
         AxyPdE/epamPJDcyGQRJnPUR0qyEBsxYWbunys4F7on3hAmfONeArrbeAGm6xbkuZ3xV
         iZPJHy6V2lkPVP2V8Judp600w6OSYkQcfu38baOl7aBTAy5vnPy6qEt/a8emkttjQ/pj
         JsWLpbI2LodN8Ukh9uRWkToUJKZoO7JtypMrLDF402hkwj1Y8m9Cd/JKoGSZS9RL9XFl
         b15mOz13Ix4Vz1AeJ9+dsiv4ip/nlFKc2wcX8Ai2j0QSgsEUpbkLtlcvPv+T2inVX5YX
         w2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733557023; x=1734161823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzfMxlAt5GNeeNCYaLumuVBfvOy6V2nfIHnriL3tfzo=;
        b=UR+LbwzFKdlTzMFEtWP4jbWGZtLB4MIZOydYKtQWcCs1HOGMXbfs7gBI7auBhAdEp3
         KLUPV3UjVzcPDVBnJql1TBD2gRaW7DFt903+PqILHN+OUMYHg+qmfK/6RhQOyPR3jdMZ
         nU36xyypvgyVGq0ImNih1SbzIX1Y1t9QD4H+I1ryfxg3/pr7WaA09ety27SF9zG6mzEv
         +NZy+HcFuStKRpaGwWy/IoMDR0PnK2pgeFMAeMJXyoZhV1ysS5Uc7k9fEdRJQSRS4ckI
         fUg6WDdC0iJIYHg+mADLiCbY4aBICRZD1pEcjLsCcKrIsFHj2abRcmSC1eOL4Vbb0mM+
         O44w==
X-Forwarded-Encrypted: i=1; AJvYcCWJzcwOdV9Z8j6v+9kyhz8+vDL5JujUmP26zBts6Q2l+kDDYxa9d97lk7EUcq9IrQzyQ9C9OJzr97+o4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuuXuX+wMl7ZJsrJ+kG2TE0r/GrXyshvAebGChi5HeUNFjOf+
	y1yyD6ussGdJj+QcZR3xMw3+ciM30r30k4wRYs/cnQcuVe++6B8Y
X-Gm-Gg: ASbGncv7Fua9bDhVuCVUGHDUF9o+N52tdd4mibneVGJb/1M80GDZ5dM0xFMzrKfPNh7
	0hISuPOtuBaXavlfP6iryjKbi4QQwwHj8kuvLFhhVLP3J9bjWYyxx0YkZc+K603X5rn7q7qZ94T
	gxnOGIpX1wXpw/lrFTaibYY2PDAGvARzRSusZj1TH5B/RErAI8xHC2ltONCxwB5dldJPyc5Rb4U
	MsoZYL/vBtp861mFFfmWB3/GO5aAf6jQd4Dnq6nQ8j0FF1nqOfyz36WID0zj3z2iLIweBPfI7lN
	wTuIsyd7jlCm+GFK93kCcw==
X-Google-Smtp-Source: AGHT+IGnIAjpzv3520S8Ddci74BnesW/dOx3fRn6CzQrG6GGgO9zHDCfqwlhp7kh+ubb4tY1pTM/PA==
X-Received: by 2002:a2e:bcca:0:b0:300:17a3:7ae7 with SMTP id 38308e7fff4ca-3002fcc60e3mr34478861fa.36.1733557023142;
        Fri, 06 Dec 2024 23:37:03 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:445:57d8:1303:9afe? ([2a00:1370:8180:3d9b:445:57d8:1303:9afe])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3012d36b3c6sm317661fa.85.2024.12.06.23.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 23:37:02 -0800 (PST)
Message-ID: <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
Date: Sat, 7 Dec 2024 10:37:01 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

06.12.2024 07:16, Qu Wenruo wrote:
> 
> 
> 在 2024/12/6 14:29, Andrei Borzenkov 写道:
>> 05.12.2024 23:27, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/12/6 03:23, Andrei Borzenkov 写道:
>>>> 05.12.2024 01:34, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> 在 2024/12/5 05:47, Andrei Borzenkov 写道:
>>>>>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2024/12/4 14:04, Scoopta 写道:
>>>>>>>> I'm looking to deploy btfs raid5/6 and have read some of the
>>>>>>>> previous
>>>>>>>> posts here about doing so "successfully." I want to make sure I
>>>>>>>> understand the limitations correctly. I'm looking to replace an
>>>>>>>> md+ext4
>>>>>>>> setup. The data on these drives is replaceable but obviously
>>>>>>>> ideally I
>>>>>>>> don't want to have to replace it.
>>>>>>>
>>>>>>> 0) Use kernel newer than 6.5 at least.
>>>>>>>
>>>>>>> That version introduced a more comprehensive check for any RAID56
>>>>>>> RMW,
>>>>>>> so that it will always verify the checksum and rebuild when
>>>>>>> necessary.
>>>>>>>
>>>>>>> This should mostly solve the write hole problem, and we even have
>>>>>>> some
>>>>>>> test cases in the fstests already verifying the behavior.
>>>>>>>
>>>>>>
>>>>>> Write hole happens when data can *NOT* be rebuilt because data is
>>>>>> inconsistent between different strips of the same stripe. How btrfs
>>>>>> solves this problem?
>>>>>
>>>>> An example please.
>>>>
>>>> You start with stripe
>>>>
>>>> A1,B1,C1,D1,P1
>>>>
>>>> You overwrite A1 with A2
>>>
>>> This already falls into NOCOW case.
>>>
>>> No guarantee for data consistency.
>>>
>>> For COW cases, the new data are always written into unused slot, and
>>> after crash we will only see the old data.
>>>
>>
>> Do you mean that btrfs only does full stripe write now? As I recall from
>> the previous discussions, btrfs is using fixed size stripes and it can
>> fill unused strips. Like
>>
>> First write
>>
>> A1,B1,...,...,P1
>>
>> Second write
>>
>> A1,B1,C2,D2,P2
>>
>> I.e. A1 and B1 do not change, but C2 and D2 are added.
>>
>> Now, if parity is not updated before crash and D gets lost we have
> 
> After crash, C2/D2 is not referenced by anyone.
> So we won't need to read C2/D2/P2 because it's just unallocated space.
> 

You do need to read C2/D2 to build parity and to reconstruct any missing 
block. Parity no more matches C2/D2. Whether C2/D2 are actually 
referenced by upper layers is irrelevant for RAID5/6.

> So still wrong example.
> 

It is the right example, you just prefer to ignore this problem.

> Remember we should discuss on the RMW case, meanwhile your case doesn't
> even involve RMW, just a full stripe write.
> 
>>
>> A1,B1,C2,miss,P1
>>
>> with exactly the same problem.
>>
>> It has been discussed multiple times, that to fix it either btrfs has to
>> use variable stripe size (basically, always do full stripe write) or
>> some form of journal for pending updates.
> 
> If taking a correct example, it would be some like this:
> 
> Existing D1 data, unused D2 , P(D1+D2).
> Write D2 and update P(D1+D2), then power loss.
> 
> Case 0): Power loss after all data and metadata reached disk
> Nothing to bother, metadata already updated to see both D1 and D2,
> everything is fine.
> 
> Case 1): Power loss before metadata reached disk
> 
> This means we will only see D1 as the old data, have no idea there is
> any D2.
> 
> Case 1.0): both D2 and P(D1+D2) reached disk
> Nothing to bother, again.
> 
> Case 1.1): D2 reached disk, P(D1+D2) doesn't
> We still do not need to bother anything (if all devices are still
> there), because D1 is still correct.
> 
> But if the device of D1 is missing, we can not recover D1, because D2
> and P(D1+D2) is out of sync.
> 
> However I can argue this is not a simple corruption/power loss, it's two
> problems (power loss + missing device), this should count as 2
> missing/corrupted sectors in the same vertical stripe.
> 

This is the very definition of the write hole. You are entitled to have 
your opinion, but at least do not confuse others by claiming that btrfs 
protects against write hole.

It need not be the whole device - it is enough to have a single 
unreadable sector which happens more often (at least, with HDD).

And as already mentioned it need not happen at the same (or close) time. 
The data corruption may happen days and months after lost write. Sure, 
you can still wave it off as a double fault - but if in case of failed 
disk (or even unreadable sector) administrator at least gets notified in 
logs, here it is absolutely silent without administrator even being 
aware that this stripe is no more redundant and so administrator cannot 
do anything to fix it.

> As least btrfs won't do any writeback to the same vertical stripe at all.
> 
> Case 1.2): P(D1+D2) reached disk, D2 doesn't
> The same as case 1.1).
> 
> Case 1.3): Neither D2 nor P(D1+D2) reached disk
> 
> It's the same as case 1.0, even missing D1 is fine to recover.
> 
> 
> So if you believe powerloss + missing device counts as a single device
> missing, and it doesn't break the tolerance of RAID5, then you can count
> this as a "write-hole".
> 
> But to me, this is not a single error, but two error (write failure +
> missing device), beyond the tolerance of RAID5.
> 
> Thanks,
> Qu


