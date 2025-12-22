Return-Path: <linux-btrfs+bounces-19952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB9CD679D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275693075733
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64078322522;
	Mon, 22 Dec 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOoHCwzG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427172DD5EF
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415808; cv=none; b=R71Xfc+UvMRCZI3gv3VnkXtHf6u4kPvOwA6J1wRCb6EX8CrpTRn8ZHFdXYXazdOxTzcCwbtSR1p8WIzJfwKpMmrJ7YAdqe0KE7zkjeNtlFX6xrXBoMTuENOVSOuwvKQRYGfKH+wG5vfNY4S1254u6RoxB43v1Yam+mXhyqkz33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415808; c=relaxed/simple;
	bh=t4rsFnGUzeD1KMwXT4iUUV1jriowknwgJrrHKVJFd1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf0Kf65PHVe6cv6Rz16igM0CM2Do0F14eSYfKyNN8OSR8IalK24zBJSbXcuo+RcNc6R7hHpG1HZFl+8SEnLiZ8p48fynAJ1Asu15zYc+ZToSTNG8dTHku0K3I1j0nQ6zgfuwyXEjYBpkBimdbE3oa3lNx5aHSCYNj6jHE7IhXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOoHCwzG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so40916285e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766415805; x=1767020605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/BovpYoyCqPQI6cHyERY9sM0XnG6cSj0PGe1+XI7CW4=;
        b=WOoHCwzGZ6bdrRKq4+mJbZErvy050GBq3ODQnyT2b98CYCFzmxsGtrerYm83L3vQ1h
         nb+ImkQODzhldr1p5CdHJYvqO8TzsbOHtQPfReqTsYSNqUmzO+jdBEt0f9ZURDM0Qe2S
         EaXHqCyM/q9wI+4z6NKWAe/f+AZ4SdZUdaKf18HFxX0zwKB+mqc3E8tLp8kVML9LVgXH
         qCX7wOop5DS+/BoiX3g4PtamFhrmHC3FYth8ncqjcq23baT9Qud42aZ0A251mbqBg4R6
         RKVPLfWLqCJDsd6Tign3NwSWwLVRDtPZltGSK0kNR7pWa/aOHVAURoKyJhCa6f2A9qNX
         fy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766415805; x=1767020605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BovpYoyCqPQI6cHyERY9sM0XnG6cSj0PGe1+XI7CW4=;
        b=I2sxrzP5ZhP3bLFVqmc2q9rdngJx70zx05gw9vlT1cd+NNFUkIWen3UoNUiGX9/ePm
         UN0CRRNatxdplssf8RVFbCgw90CtYFugUs1IM0vb4neFMOt6xJnBpQhiCpo3t2t1Sqqg
         aXlqpetM68RGt21PDdaNaZendejAhvkm0ENVnBwXhF+5oRo8HWHtpxoMKO39YCvqlUPa
         59wdRdi/UXMXUyJb8TOlvjqasX4ZWqHyGp80Z+yxWKJZWVfw2GWy7o5S84uLarzQw6zp
         OOyYqBHhTGK/1zLEovtFH5WYsxYIEsX+UUUVA4wJ5Y7GeUitaksoemMMWwJRJwfqj/Zs
         JmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5PeHw9bowfIr5uCo8M9amx66NnUKKugof8ie2kg+9aIzxQvrzLRt1hX0V26IZWc18WYyTiLb279zG9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9y5c88zn7uuNRjsIqekYKMx1kVFnGzB4gCZ2N5+rKp02SSzw5
	Fedn1Xe00E1xuwXz/GfgtLrKBXm+d8mr8TM913LrtmWgUB27kj0QfD2z
X-Gm-Gg: AY/fxX74YY4mRhHmNGC7r+tMZZfLZ/tqpPFSCREpPQUd26BWsPNAFlIDH31mJMQ8xqQ
	KocCqsrUGWutTPMToQ8Vs1I/xe/iQ5/+q2f4xrx4VcC0T709SUIpCkPjK2XnUIUO2QG3ez8Pm0z
	P9tGrpolMtnq3nLbsOBg6WpZNb9F6ZrDMpdnCJ1MnzZzkP9a0e/9TkD95kxeQiKogDssh4YfUf0
	pSfoD7feQ/NUkqAqc6dL/H/uF63ZKkcD64Yux615vGAfte3edLS9wRBT2P8mFXlbVgM1OX7l35T
	vj6mDUfjrpNmBHZl3ZFAHAhgX0PmzPh59lG9ewmTybDvpdoEtdET4gnsxMBlDqnWyb8p0ulsYT7
	cgAyQIo4slwfDbHRL8Z4RgMDZTPzvL/bNhJokkDDkGL+N0OxXJG8LxeaUu193EVH6ByZrHCKa+Q
	/OC5EZ3NeYbJaP/ho=
X-Google-Smtp-Source: AGHT+IFJuusyQ+1Mz3/8tYi1eqLylmqECFtDDXhQgv1q9fY01NTCrKY3AspjaGJTpIOiZ62UGg1d9Q==
X-Received: by 2002:a05:600c:4fce:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-47d194c659emr102417425e9.0.1766415804486;
        Mon, 22 Dec 2025 07:03:24 -0800 (PST)
Received: from [192.168.1.27] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325dbc522esm11740249f8f.11.2025.12.22.07.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 07:03:24 -0800 (PST)
Message-ID: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Date: Mon, 22 Dec 2025 16:03:22 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device
 mapper devices
To: Askar Safin <safinaskar@gmail.com>, mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
 lvm-devel@lists.linux.dev, pavel@ucw.cz, rafael@kernel.org
References: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
 <20251217231837.157443-1-safinaskar@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20251217231837.157443-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 12:18 AM, Askar Safin wrote:
> Mikulas Patocka <mpatocka@redhat.com>:
>> Askar Safin requires swap and hibernation on the dm-integrity device mapper
>> target because he needs to protect his data.
> 
> Hi, Mikulas, Milan and others.
> 
> I'm running swap on dm-integrity for 40 days.
> 
> It runs mostly without problems.
> 
> But yesterday my screen freezed for 4 minutes. And then continued to work
> normally.
> 
> So, may I ask again a question: is swap on dm-integrity supposed to work
> at all? (I. e. swap partition on top of dm-integrity partition on top of
> actual disk partition.) (I'm talking about swap here, not about hibernation.)

Hi,

I am not sure if Mikulas is available; maybe it's better to try again
in January...

Anyway, my understanding is that all device-mapper targets use mempools,
which should ensure that they can process even under memory pressure.

AFAIK, swap over a device-mapper target (any target!) with a real block device
should be ok. The problematic part is stacking over a filesystem (through a loop)
as Mikulas mentioned.

If I interpret Mikulas' answer correctly, it is the filesystem that could
allocate memory here, and it deadlocks because of it (as it is swap itself).
So I believe it can happen with other DM targets too.
(If I am mistaken, please correct me.)

I wish it could work, but I do not understand kernel details anymore here.
It seems we are still in "a little walled gardens" communication issues
among various kernel subsystems, as one of the former maintainers said :-)

But you asked about a real block device, so it should work.
I guess it is just another bug you see...

Milan
> 
> Mikulas Patocka said here https://lore.kernel.org/all/3f3d871a-6a86-354f-f83d-a871793a4a47@redhat.com/ :
> 
>> Encrypted swap file is not supposed to work. It uses the loop device that
>> routes the requests to a filesystem and the filesystem needs to allocate
>> memory to process requests.
> 
>> So, this is what happened to you - the machine runs out of memory, it
>> needs to swap out some pages, dm-crypt encrypts the pages and generates
>> write bios, the write bios are directed to the loop device, the loop
>> device directs them to the filesystem, the filesystem attempts to allocate
>> more memory => deadlock.
> 
> Does the same apply to dm-integrity?
> 
> I. e. is it possible that write to dm-integrity will lead to allocation?
> 


