Return-Path: <linux-btrfs+bounces-18125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A9EBF7EA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D4506D4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAA34C82A;
	Tue, 21 Oct 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxQLeJCc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD834C831
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067944; cv=none; b=IPOdzKm/aGzJXDf9QuiDVr8rZayiEI8EKwhLRfLmONFnKD12efpxgi44rdFidfWbIDJC1KsHXMqHN2FTPPGvvlK+3bg7C+ivMdqgDRAjjcBOV58prq4/0bEiOApmI+w6GjuwU3r6Yo0rwlC3RT+SuEmU5ogVk57IVfatOPz/hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067944; c=relaxed/simple;
	bh=q/n9LlPRh0IxStLCsSCDtmkY17tZQLjpOhtvBMsHumI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oS1yv518on1I72dbpExXBV8Mk8izVuVzx+ppt6J9GSqiVzLofJ2o6utQLkxEfCaVH2QJxEIKEs+N53mqqQeakQJLE8p94tTP1zhjeZVcBuS6KnRdwYxUg7VSc1EWk36VxQd1kfzskmwN3AVYUNO/mcJ0FrVVyZAMOjWf9dOVUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxQLeJCc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so7043765e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067940; x=1761672740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRZW6qRj1oODsgBUM5VOKFSOz0ToB3uCx6jmJlIc8xI=;
        b=fxQLeJCcVozKTsys3kg2Qv8myTAaNBn8rAeyGFXM5dAnX2+4I9oqLzQza76gAZmV1t
         blVTaHe2T7krmz6jcCU5o0g6BJqCT3gmD0ISWYgaB9NU15TuNfrfgYXfFpzxVg/E89QS
         Pq4VDBbzWOYQ+GU9EfMCOgpWAbbQNTfIqGXi2vHKJnkAQmT+gNYWf68ViYIR3+/dXxYs
         7DomGvH5Yk37Wr8yWztrUisOcV0SkBQCd5+glljlLe43FxmMLtUFTzXzTcUP0f7n9Upc
         OP4wtXf7sw8h9SrLBcyw7V+n5RvpERmRnQbQZdk0kMNVIgLPD4YIs12mkB+CKIWkLWrc
         5xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067940; x=1761672740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZW6qRj1oODsgBUM5VOKFSOz0ToB3uCx6jmJlIc8xI=;
        b=bTjvPKmqyFvJN847HjgcNKHFE0eEH0qhCoABZSEXxaDjC6S6Xh+S60xMKdh2X8RXxq
         1qXi0Czza3zoNwkU57xZdpoM4Yfd/dzd6bER9VVIX9W87frLHgHDzYXmM8ABFy1XQEZC
         ifvT+qIz9ELlKt6GIgZKhWb6BGi21Okw5OSDgsbHKDBlWAqfssT57DncXa/Xb4I2oLGF
         JqqDYa2Y4OZTAJqSQnuiZq203A7PVif8L6B8pODlcSFPgyIpeJGl8wi8K9l/Kz1azYpl
         eHmLSSqs085Ow7C2TDI9IGyH3AFGycNR0zkFbAe8Hpszgh5W5t5E8OYJ42CvQ4neLJ5o
         xQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEvny4f0jcHK+JleR/EQwondFd4tWFs4SeC56PNUJC18F19rPgqHe3TCRDD0LiLoTIdQqEJ5OOcTseQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYMn+9+Qg443CoTvSPKrA9mmPVN7ef03OtJ9W1QnwgURLGd0G
	gBwSVhviOOG3o12VOSOYytwk268AZhFZaACVt2ZbF17mfqfctUTTnSpYzvPzbw==
X-Gm-Gg: ASbGncvEWmyDrUrGhjLxGAUKRV3exExvQ+3395VARCA8pcHWFxCxAmAbouWV7HPPBP+
	/YIZHvDpBNunNK38c2kcRL+X12mR9thCdJYT890adWD5QvoEFOfMYx+gSW3qWvAIZnUBvD+UnXV
	6ik3ZYJFjY/LyO2nO/fvW2vYbsPlIpwXQHL+3JbeAVnWp4xsmK++2DSJzj7K4BvUcgXa6ntUjJI
	P9xy5bwS1ujc/YlKJUJoRYm5z5GP8gb7SRfGiDG8U07vL4PpBuXJxCxGaorSiowpvJnapL2YCZj
	cI/i4Gb15w8jLS+qZv3EzyN+Q3NQ824J3dImRzkcSK4COCDNpEIvWlthluTJ2FyDuaTT829n12+
	qAlSyVZXdXtJDwYZy7TWn2R1HOVuIXbcUx/v1I2bc6UseRboxUhnME8PX+7okWKEtm2AP5p9nsj
	tmAfKkI1cz7hs5wYFQRhvFePLxYFp/ajUGgeDp9PG2YL+ACRowy/rgTZk=
X-Google-Smtp-Source: AGHT+IGe4h/3Xyml/X/2abdrRuS207XJUzLOR9q1lL3BR6ISt5PxQp1Mlrp1awy+B3tKNCJpCFFq9g==
X-Received: by 2002:a05:6512:6c9:b0:591:c8a7:1000 with SMTP id 2adb3069b0e04-591d856eaf1mr5760176e87.46.1761067939728;
        Tue, 21 Oct 2025 10:32:19 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:3b0f:3f49:9668:b86:4af? ([2a00:1370:8180:3b0f:3f49:9668:b86:4af])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deea8c8dsm3839238e87.3.2025.10.21.10.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 10:32:18 -0700 (PDT)
Message-ID: <212e280e-475c-4259-a7e1-5e96b2713832@gmail.com>
Date: Tue, 21 Oct 2025 20:32:17 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: Mark Harmstone <mark@harmstone.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
 <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
 <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

21.10.2025 19:45, Mark Harmstone wrote:
> On 21/10/2025 4.53 pm, Christoph Anton Mitterer wrote:
>> On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
>>> The brutal truth is probably that RAID5/6 is an idea whose time has
>>> passed.
>>> Storage is cheap enough that it doesn't warrant the added latency,
>>> CPU time,
>>> and complexity.
>>
>> That doesn't seem to be generally the case. We have e.g. large storage
>> servers with 24x 22 TB HDDs.
>>
>> RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
>> RAID1 would loose half.
>>
>>
>> Cheers,
>> Chris.
> So for every sector you want to write, you actually need to write three
> and read 21. 

RAID5 needs to read 2 sectors and write 2 sectors. Independently of the 
number of disks in the array.

It is more difficult to make any generic statement about RAID6 because 
to my best knowledge there is no standard parity computation algorithm 
for it, each vendor does something different. But simply adding the 
second parity block means you need to read 3 and write 3 blocks.

> That seems a very quick way to wear out all those disks.
> And then one starts operating more slowly, which slows down every write...
> 
> I'd still use RAID1 in this case.
> 


