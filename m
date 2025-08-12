Return-Path: <linux-btrfs+bounces-16008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07EB21E34
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135037A2D6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9842D6E59;
	Tue, 12 Aug 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPgEVIym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542F2737F2;
	Tue, 12 Aug 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979802; cv=none; b=iX8iZJSDjoGXjFuxJKCpTuVB8PKugTqDyR+y9RMnS6aIwTl0eq1k6bkkVvqEbh//pHWpvUbP0bcT/tXQD6ITVqt6hu7koH8L5qbwtNTmTGUspeJWY+5TAaohFtzu24Da8KLewn1t8QmpiT/eB+Xxz7JQaauN6c0u62aUrfAKooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979802; c=relaxed/simple;
	bh=AA4wM86dNxuGOMKdOE/mMSFHN8AQml6lkAKZUwvDuZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To3TjNhe8mUR3apsEDwBHsN9DkT+ysbiHh+v0c/fRE2jze5gl8CIvXu+h40OM46wHikOsbi3hFZty8so7Ie67jQ5IKwEBKZL/CPqsB+BAhjN8jMrFGvpu9CxxMx8f2JduxLz45ZaXDHf13QdWXZQlNe1NLPmOmmUTCXwE/xoTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPgEVIym; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76c18568e5eso5687641b3a.1;
        Mon, 11 Aug 2025 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754979800; x=1755584600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoD09DThJb9Q5u+A2MUsDBLIVc85EnA+7W/GJnKo32I=;
        b=OPgEVIymJrv6J9AF0TqJvGkZeYyeA25teGefc7XuuBopPTcjiL9HlFzq/ihWlmWl4T
         f0Mss4iNYIdbnxH4zukaWa3zlfmR/leqEMXwvpE8yYor+Yg/OMQ/75T2Yl0WqBaKi8Gq
         +37sVbqJnnOBKDgjQDmFrbOSW2+vvxKzG6P6nUCAd6NE/3fROnhOoJFK/SdiAgXAUHVJ
         bVmAHyJxITaRcLj79Y4/3hWbYvmYtb1ISqrlriUeAdTGTq7A/z5vL5WopOukGwc6sxcW
         5Z2LaHvBRs8S1xv769oyw3WCLdQf3lDwFHDfUHP3e5fSwvl7/laLL8wQWzrHOggnsv04
         StfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979800; x=1755584600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoD09DThJb9Q5u+A2MUsDBLIVc85EnA+7W/GJnKo32I=;
        b=kRdfm8gjBvxNC5oSmU7M/Vrt/4LFzkPPhjanuZvXCfa0J27ERlwRIC9oI8lBcZ5yN5
         hwHvT15C/OsFbUGMb03z1gRqh0dNvcgnpGinxaU9X5Gn6x/bkTGp4s0A9jbzNip6qbCB
         8kUBCGxCifZM9NVI6qAn7VR0Nk3HYwrS9o+TO53LPyTbfdQnbIHZ49DAHztWY1SdFq+b
         vTnGPgmEivC1l0BB76zzFNAODkboeCsfDBRXDl46K9TYZW2sk9jXNtPEb7MaP2ZG1OCU
         sbWEpnS+S+hVu6NnzCozA7unb5yG/VE+Iqs2zpP9Yenntrk8vL9J7MXyZr6AO2moRzXw
         dXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tiQ5w2cNT+NElwgL6xlCQRmgS7s444zc6gewwXuwQpvPk2c0HmCdZwQ9wRFzc10CXH8Urv2bvwnCw+M=@vger.kernel.org, AJvYcCX7FKEBC6Jz+UYcnQQ1UbN2tW8e/Y8VZgJV/2qgNa6f6ZB+VcYgaCQkpsLITj5S0JtHkGJ7JeOW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25DadRB/JIxDuRqQ2A6j0T/rAZKLAjKHSBFrabM8Eymb/PxSb
	DDgpQhoY9j8Mvj5P7R5PnJVBUwLYjvNi0MOaOp1TbTLG2bL5OHBfs787
X-Gm-Gg: ASbGnctyxDkfUcl3vjRUW0ChHtG9PZmdeUxfQTTot7Wd1mctHsdznWpipKWxzv4BW1l
	UAqLRdStKfNm+G4oiqFMIjkM2VxXFscwjgCzFsOeZQLTrlRsr6FwS3TP8akbU+GUhcIxxgisxG2
	3I18oaSYYpyh+XiRF4KWxVhsMAHzYTHvzYIxA8WmpmdtyMMfKGhpwVTrl+Cz+eE2wABf3NRwvh+
	C8L7TlL53qIL1H2bSZtUh02KgkB0aYoq91b9xM8LIZ6uYwADJHomh20N92BZ794yvQYSwK3LHKk
	J7YVp32vEpXl2zB01VbtcbtZJk25AdQcNEorSSYcCUq/D0rg2B/4N65yH3+e0SDBNM40bLJICEx
	Ajun7WF+a/Z4yxQ9j26WByzP9UaEEvnM5
X-Google-Smtp-Source: AGHT+IEuM04MYB9detfU9nyKRUMBW0O+tULbCHyUR9r0hEC3vmL8FFGwv8b/2lvpFlrc/3as5VAeSA==
X-Received: by 2002:a05:6a00:bd92:b0:76b:d791:42e5 with SMTP id d2e1a72fcca58-76e0dfaf67bmr2789480b3a.17.1754979800171;
        Mon, 11 Aug 2025 23:23:20 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf067e310sm23616011b3a.25.2025.08.11.23.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:23:19 -0700 (PDT)
Message-ID: <b8a79590-237d-4a3d-a6e7-d9b8b15745de@gmail.com>
Date: Tue, 12 Aug 2025 11:53:15 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org,
 zlang@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
 <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <CAL3q7H6BoyZYkacZvMas8jCtrXykoj0G7s8rxaXjL2x6Z9OkGw@mail.gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <CAL3q7H6BoyZYkacZvMas8jCtrXykoj0G7s8rxaXjL2x6Z9OkGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/5/25 16:17, Filipe Manana wrote:
> On Tue, Aug 5, 2025 at 10:41 AM Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>> On Mon, Aug 04, 2025 at 01:28:24PM +0930, Qu Wenruo wrote:
>>>
>>> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
>>>> For large blocksizes like 64k on powerpc with 64k pagesize
>>>> it failed simply because this test was written with 4k
>>>> block size in mind.
>>>> The first few lines of the error logs are as follows:
>>>>
>>>>        d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
>>>>
>>>>        File snap1/foo fiemap results in the original filesystem:
>>>>       -0: [0..7]: data
>>>>       +0: [0..127]: data
>>>>
>>>>        File snap1/bar fiemap results in the original filesystem:
>>>>       ...
>>>>
>>>> Fix this by making the test choose offsets based on
>>>> the blocksize.
>>> I'm wondering, why not just use a fixed 64K block size?
>> Hi Qu,
>>
>> It will definitely be simpler to just use 64k io size but I feel it
>> might be better to not hard code it for future proofing the tests. I
>> know right now we don't have bs > ps in btrfs but maybe we get it in the
>> future and we might start seeing funky block sizes > 64k.
>>
>> Same goes for not hardcoding block mappings in the golden output.
> Please keep it simple and use fixed 64K aligned sizes and offsets.
> It's very unlikely we will support sector sizes larger than 64K, so
> keeping fixed sizes is a lot simpler to understand, maintain and debug
> tests.

Okay, noted.

--NR

>
> Thanks.
>
>> Regards,
>> ojaswin
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


