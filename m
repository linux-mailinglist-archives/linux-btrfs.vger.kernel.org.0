Return-Path: <linux-btrfs+bounces-10984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A399A13CF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9038518825A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74022A81F;
	Thu, 16 Jan 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IACgl/lW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499319ABD1
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039326; cv=none; b=HkC//kzyoutrE5skBccRwddB8p28uqEyK0QfwId8OKwQZMmerV2k6QoMkzEqSuBd6rEwZCjqqEcmHYNCUkymytySD/dHTY383BKulYSKVWWluyiGrwcy2IhEqqd+/akF15bUkyHQqTWImV5VOnw1erDm/3C/jJ2f34YxhQtf2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039326; c=relaxed/simple;
	bh=mCZKMq6IJGgI2QJgWZzdRqtpfpsSXI4IkAH98JfpnWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoJPG779CblHnoRU8QcVQ9ktKyy0lF0l+vBzdp+mG/zQfUwuwXj+89Ag96wJ1ZK9ZSVbg7qJ6CkIdJ11tMv6a7XsUHhKbTHBkIffI85SaWosH+mGok9mAfWu3VP+6hiIWk6fP4klm7nMXwal8FuLYbm0K7zkuhQOcQHwwJHrtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IACgl/lW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso1826875a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737039323; x=1737644123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCZKMq6IJGgI2QJgWZzdRqtpfpsSXI4IkAH98JfpnWs=;
        b=IACgl/lWoFlgpv8CkA8p7dwz4DnWrLy0W5hltkqzLGijzZ9sA4yXX8cezMT+Fp3RF9
         32tgyS+nVN7WKE5iJCFK2VkbrELwx6A+nfiV/upGjSIeYOt4U/Bm6RIFU0z8ovmDzuRg
         vRvGjEb6YIgL1tR4w0v5d11NH5BSrb8yg9GoUX8jwmjiGFxNg2fiGvtCso3U86VmM/Mf
         4UeyMNh8DvqRL10eWdPszaDMsNBuP/++2h5eTedsWDb1L+BB+cLsE59IyEMMdrQB5eIA
         ss+V/WugEL6mxO5Q4WrVVaO3AGD/zgi+clfqcMaZBbHWaVCdGQvrywrv3WKCa6lM4Q0p
         qVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737039323; x=1737644123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCZKMq6IJGgI2QJgWZzdRqtpfpsSXI4IkAH98JfpnWs=;
        b=JvbIpr+/RQuewSUD5Tn7h9KG2/xbWfJSgPpbx3CvapO/Y8C9NKfccRwDpETVKWSYrJ
         IxJqhqRggVOSdj/hhwuqQFiwdUCKMWemkTn6HlMKP1E9t4+L5P24w3QlY0/3giDOC9ft
         c7RNhX070RgSR5Ur0ADTnbwECI6JstzhtxbfeBLJDaQu1CQwe2eYG5fimksyx0q/kSX7
         z8rBQmcthhDXhT2q54Zq2eXF1BKXjnF/QytDNBZwS+Cir7slZh7zRJvH4f2UQxJZV0UR
         muI1ydlh+IbgzB4ShweavkcfFBL8gG2j6q8E+aIpZ8W9qazfylh/W6sFCmo/P7yp56/+
         Tb1Q==
X-Gm-Message-State: AOJu0Yw/FHOXeX+FH2rkc3h/4oG7OQzZ//2tKNjOI8UL4kt1IetSfRme
	dEkhgcNfPMeGoKVYY+E+awQXMTxWIWS8k2elOnCfZVtGTuxRcg+EcdOwmw==
X-Gm-Gg: ASbGncvEX0bgL9RDhxvIlc+UEKNGBKwNaYQaDddlASQnLT/+V4aPdDmE9K7AUt/Ll4+
	pZK+KOrcgiKC2QCozNLlErnc1sy0L+vJjHDGGIpbBNwUlwj4Ng/J9cPb0noZCkxys9pvTloceD7
	kcuub5D1F2310tf6GBMNuwvghWP5mcoOUFQU1gi5JOuU969gkyLsrRhQTDs9GwNBQqA8hsMus1M
	RgjJir82JcikhUdOlIL9UQfk8cm7LQYQil+BUDn+N84S0YO3J0=
X-Google-Smtp-Source: AGHT+IGnTNHlRKLFNYGlW2iQl8mVQHBtzQMVheKN9NgIEHGrxE0nkS4hMnGuW5LC0GjDd8lLfHPO3Q==
X-Received: by 2002:a05:6402:2815:b0:5d3:d8bb:3c5c with SMTP id 4fb4d7f45d1cf-5d972e095dfmr29427370a12.12.1737039323182;
        Thu, 16 Jan 2025 06:55:23 -0800 (PST)
Received: from [10.1.1.2] ([77.253.223.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb5c4asm28956a12.59.2025.01.16.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 06:55:21 -0800 (PST)
Message-ID: <bd5809c4-b88a-4c41-95c4-b1ad89bbb0b5@gmail.com>
Date: Thu, 16 Jan 2025 15:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 two chunks of the same data on the same physical disk, one
 file keeps being corrupted
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux fs Btrfs <linux-btrfs@vger.kernel.org>
References: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
 <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
 <a00a0c80-85fa-4484-9076-d4a2f50e177e@gmx.com>
 <501eb99a-dee6-4e84-93cb-ae49d48dcab6@gmail.com>
 <3749cb72-a99f-4f4e-9682-e2cbf7604227@gmx.com>
Content-Language: en-US
From: ein <ein.net@gmail.com>
In-Reply-To: <3749cb72-a99f-4f4e-9682-e2cbf7604227@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.01.2025 21:39, Qu Wenruo wrote:
> 在 2025/1/14 02:24, ein 写道:
>> On 29.07.2024 12:05, Qu Wenruo wrote:
>>> On 10.06.2024 16:56, ein wrote:
>>> In your case, I still do not believe it's hardware problem.
>>>
>>> > - it affects only one file, I have other much busier VMs, that one
>>> mostly stays idle,
>>>
>>> Due to btrfs' datacsum behavior, it's very sensitive to page content
>>> change during writeback.
>>>
>>> Normally this should not happen for buffered writes as btrfs has locked
>>> the page cache.
>>>
>>> But for Direct IO it's still very possible that one process submitted a
>>> direct IO, and when the IO was still under way, the user space changed
>>> the contents of that page.
>>>
>>> In that case, btrfs csum is calculated using that old contents, but the
>>> on-disk data is the new contents, causing the csum mismatch.
>>>
>>> So I'm wondering what's the workload inside the VM?
>>
>> As far as I know in such configuration there's no writeback:
>>
>> <disk type="file" device="disk">
>>    <driver name="qemu" type="qcow2" cache="none" discard="unmap"/>
>
> cache="none" means direct IO.
>
> Exactly the problem I mentioned, direct IO with data changed during
> writeback.
>
> You can change it to "cache=writeback" then it should resolve the false
> alert mismatch.
> (Or just simply change the disk image file to NODATASUM)
Hi Qu.
You were right, those errors still happened.
Switching to cache=writeback seemed to help for now.
Thank you.
>>    <source file="/var/lib/libvirt/images-red-btrfs/dell.qcow2" index="2"/>
>>    <backingStore/>
>>    <target dev="vda" bus="virtio"/>
>>    <alias name="virtio-disk0"/>
>>    <address type="pci" domain="0x0000" bus="0x00" slot="0x04"
>> function="0x0"/>
>> </disk>
>> [...]
>> <controller type="pci" index="0" model="pci-root">
>>    <alias name="pci.0"/>
>> </controller>
>>
>> This is mostly empty Win7 virtual machine with very small SQLite
>> database (100-500MiB) with some network monitoring tool.

