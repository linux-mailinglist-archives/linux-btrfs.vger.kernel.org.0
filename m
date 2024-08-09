Return-Path: <linux-btrfs+bounces-7059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3494C90A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 06:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A29285CCA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 04:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA318199B9;
	Fri,  9 Aug 2024 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk4DCkoc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000B4C8E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723176214; cv=none; b=kdbMKfLMKN5abMW30ieb/n6raislTn510LwJsn3ImETl5WjDxADbQ98V/5Wu4Dq3RB8roMfy5yjr14Tq20nPhvOIEW805c/vVjYsHa0a30TCloo9l6AfETkXEKMzl6ef9cFG58UzX6wDFdJ/ysNZsl911CmrDPLVhueTnisoJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723176214; c=relaxed/simple;
	bh=sJB6JNykIvEL4Mxzl1IAtgXcGNxI0UFyBPN20xqYHXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BO7RKm6C4eaRHokooAMSf3e6QS64PnmBVOxK+CoDc9OdQYnx9pDJvbC1kLsxS5a+7jJIn+7Fm88/847+W0QQQvsLnLOKSEOJQWq3NvtVuuSfyBZxqQuhnCGl8WBGlDN6/R1hYHk9n4eZGXtcZPWjNxpPS2RLuNeXrZz+4bv33jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk4DCkoc; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef260c4467so3308381fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 21:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723176211; x=1723781011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzaL6/KC1WCCJ0rChrD20/zaG//nH67Dicj0YvXRRyQ=;
        b=Nk4DCkocO+/GfefZElTX4HLebSmMuqZw3OqejALufSlriPO1owhws5sWkgFjcuibC3
         9lJGyw5jOcWLf37PxRcQ1FOViKSGOyl4KwWa6Wv3rn8J/rVIobNeTI1kUzp8O0Fmo9ky
         EXHORDhgiVtHtRXn2S8vpMEitTS8ylg6pgnfRkPJMCDcQMcz00EN+w/XlDltAmqBzBE7
         gto1PvYuq8YI3AZVYaJnYeDhy8NbBulvxkcBHxwDdv/2BpuJMat7/rRMHciQSKaEBTxD
         f1oBKh6CWYFrKlKhwev3Y4lI9X3m226bPrTm5iF3Cc+SpBjUwa5LM59pwJT4RBlz+mTG
         JC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723176211; x=1723781011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzaL6/KC1WCCJ0rChrD20/zaG//nH67Dicj0YvXRRyQ=;
        b=U8ywe1ty9VREVmkEbF2zVhpH2ukN3/O3jV7ja2giWvT7vCu7URHh1sgFM06hZFs+jy
         JLz1lBDwzM8gSzggtrNnvlHxlvTEdeI+uoM0AFDgHql9X0zcS2DeXI/rp7nEy0kzW6Ck
         BqdcObhoz2kTX5KAyjTphW+kxloRjcKl/3pty0M6ZNSO0u7RFbbTn7dQgO9CSqsfwbJ1
         HY3++UZahGg6p7NTjEmVcLelaOQr9bse40SxmxjxlILRdsiMAf/QumTWuHm8zh7aIZeU
         W7EAxhker9TDKxDbTIIg3WI/JGBdm2dw3EGmnA70e9wRx8L/93HO9rRbtxmOclfnXNSl
         ys9w==
X-Forwarded-Encrypted: i=1; AJvYcCXVGp1JIjGUeVLW5dJNfYdDySfequgjuVorw9zNWzmmzjOmsjc6Z2lQZXZjbQjAbO7o3sZ4bWtEue9d/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxthIyPgcbLL9iLYctDukjFR9Bf3l9R0chx1IfP18OQXBW0vQmO
	rLU99Sl6e4aaNKpovphlNIeflIbhMCQUAhUvuxyC2AGZCbKd90SnYQbbeg==
X-Google-Smtp-Source: AGHT+IHy8v3wKjoE9aT/xshp+RmDETOmMuP1L+I8K0kp2yMKt8GkCfoN3jMrZEgXmT+8spK6aq5SAQ==
X-Received: by 2002:a05:6512:3d1d:b0:52e:93d9:8f39 with SMTP id 2adb3069b0e04-530ee98cb3emr96278e87.3.1723176210067;
        Thu, 08 Aug 2024 21:03:30 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:371b:82a3:c1e1:fbaf:e6e8? ([2a00:1370:8180:371b:82a3:c1e1:fbaf:e6e8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e3a4csm826663e87.46.2024.08.08.21.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 21:03:29 -0700 (PDT)
Message-ID: <6c0cad97-2082-4209-8d30-05c4b0eecd0c@gmail.com>
Date: Fri, 9 Aug 2024 07:03:28 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 =?UTF-8?Q?Andr=C3=A9_KALOUGUINE?= <andre.kalouguine@ensta-paris.fr>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.08.2024 01:28, Qu Wenruo wrote:
> 
> 
> 在 2024/8/9 05:48, André KALOUGUINE 写道:
>> Hi,
>> I have a system running Arch Linux, kernel 6.10, with the system installed on a btrfs partition (with a @home subvolume). I had a kernel panic today and after hard rebooting, the disk can't be mounted. Under a live USB, mounting gives:
>>
>> BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want 211658031104 have 0
>> BTRFS error (device nvme1n1p3): bad tree block start, mirror 2 want 211658031104 have 0
> 
> This means some tree blocks are just wiped out from the disk.
> 
> Either it's the async discard (which is now enabled by default as long
> as the device supports, and I doubt it's the case) or the hardware is
> not properly doing flush.
> 

But it apparently has redundant profile (I assume, dup in this case, as 
it is the same device). What are chances to lose both copies of the data 
at the same time?


