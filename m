Return-Path: <linux-btrfs+bounces-20084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CCCEFE81
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259953019343
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062723BD02;
	Sat,  3 Jan 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Ga78jg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BE126F0A
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767439033; cv=none; b=OpzRyI7A0VqWKVCXn89YzoGvJ+67NuMEpyM6Fv2PB7L+8b7I3QGjf62m6q+hJAnUVqa8yM4UjyfQa8kUOd9KHkhJ8T028MvO4b9GKyNZxoptJ81cvxf/AZ1szPUVSuhQ0Mxfe29xVDXlri40UEl18bJ40rJ4ZtFnxBp6Ncmy8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767439033; c=relaxed/simple;
	bh=pj6SLHQ07ZxJ9c0FFI/aXUkQCSSd+FsZcHREs1mYfIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arc50QrVtogtJm+VvCHnyZLmqhlcv0AGEfNHMqXUClpFLrnGbhr38y5GVbsANeGDE6UQk5XuHCWwERp/W8+SA4DubaVbd5YmAR1hXpSnKhFItQHOhRYQVwv2pk5OqhQg66KwZebqcWSqP4Vw7CeoruJrFSVVl0bxrPMMxIHOLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5Ga78jg; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a08c65fceeso25301195ad.2
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767439031; x=1768043831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBUbPxUOw1b5iaZrsHX1Wz1F2kFP9sc4mjSYBrbSsZk=;
        b=e5Ga78jgWtZar1rxsF5/3nfTTtR5KDb8rFAkWKylMri5mCQDUnmsyi/O40nQUhq7Zv
         wUGgO4NBUmm8z+5Zx0n2cj2uiMp5F2y+SLQ4N967/QUGIy2f2vz2BdObb0Hw1z9AFqvJ
         vqde6nToHuZLYTm6ytToxGfP5mjaO7SM+VPGDRgOtqUfvc9WZD3/mL1m3zVvw8sZbTrj
         JNyaPtAFTy6GrBtCx5XO9XkG+3ESWI4TQkGfd0ChgoUu1ihLBDxTW9KmE9NktZBNu7ld
         yOnSdXTNpjV08+YVUaIhtu2twp/Vd7sYFJbo6g4dcfClR5Vyascz9N96Vkf7KfJmxzXp
         o1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767439031; x=1768043831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBUbPxUOw1b5iaZrsHX1Wz1F2kFP9sc4mjSYBrbSsZk=;
        b=WhAu0LPGeTt3EOnEj9Ww8XAc5JkS256zoxZJARhtJAVtT3ysVWW88SKLZ36CCB25Qm
         7Kn3xKuLMaL95+r2werL9m8cpRIZvwC++z8RhyZ0YNxsFbpKi7iKTe62MoiDqAo/o6Wl
         kHOczZm/Qc7JtOqMY+yId0GREYyBjjRtcNaBjcK/mt1s2wVTbgO5aV1fOHxXoyHIc/hi
         O7ZXr8NnzENoltMAFgVHJkbDa1+wOsWTvs48SAx+ed4Qmlll02jZlkL+PEFfZksZcWEv
         pQarlSvk9ppI+BzUFf6QObyYebkrAYDdrwmVzsZHfnLo5+8KNLZdsQM9Txwtxpny8Kfk
         KYrw==
X-Forwarded-Encrypted: i=1; AJvYcCVSsl2wppr6KOhV+DtHmLjF0lZbvtzmX8a15YfaqU0ggGvrS1+3TEIRFZKVIuADTaCpQl/w1lVe18z18Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6rU98/eYNkk7yVPXV+c7L5F11os246rVWFPqWFIx41QIJYFg
	2VPAgCV2k2wElRV5sC9yPo5I3hDXFJ9g6ugCU3M3WIokGKk85bFPEwrE
X-Gm-Gg: AY/fxX7oDZvQ4UTEzmparLsplI7MvBymTmArKurEOZGQcqEw62IOJL5xPok5AdGnkrG
	LH9En9TbP4e51AuOJLCM2ySP2XciPLaX6CkeDG9xohSjkpILgwpWgYbUx0nCgvo3Q68fZ/JzmF/
	Tkf+w2a9yigMWY6JVHJuDzggygfKbWTfl64GGlz7wW9LAodl5K7vHW1eGSjt4wLmpEiHFBHGy1t
	Co0dIRkCyb8nzhSsZlfmkuFELwRVEGo1+/3lZyKpyuMFf+7mbxish9qUXVgO+7Mntcmop4k4cLl
	vxiaEDEa/w98QVFLB0ZT7g1VdSJRise4G+OBY3LROWAHWvmiZOkSsaceXKmdSQmHlgh/qmTPdpp
	pBWnY2RNSQKmSyqD5vvMujtUX6CIBWVkQIGzqxsg9MW+xq/ndG0XasmA/vRfjBeBbNKWeK7HHX4
	s7/qUVS3IA3ppL1LVyeKpo5E7l
X-Google-Smtp-Source: AGHT+IFK8yRyV+5a9boLll0KAbcUUALYkL/L+/gKSROAGXKWjamaGSRdOKJBsw7VJpRiZI2c6uzMkw==
X-Received: by 2002:a17:90b:50:b0:341:88c1:6a89 with SMTP id 98e67ed59e1d1-34e9210cc15mr29071975a91.2.1767439031106;
        Sat, 03 Jan 2026 03:17:11 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm42953226b3a.32.2026.01.03.03.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 03:17:10 -0800 (PST)
Message-ID: <bf00ae7a-94ba-484e-9592-7eeab885f51a@gmail.com>
Date: Sat, 3 Jan 2026 19:17:06 +0800
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
 <634cb945-973d-4e4d-8498-df596a46618e@gmail.com>
 <27f36ff0-690f-4412-bc45-5ab6c55a68c7@gmx.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <27f36ff0-690f-4412-bc45-5ab6c55a68c7@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/2 05:14, Qu Wenruo 写道:
> 
> 
> 在 2026/1/1 22:24, Sun Yangkai 写道:
>>
>>
>> 在 2026/1/1 08:13, Qu Wenruo 写道:
>>>
>>>
>>> 在 2025/12/31 21:09, Sun YangKai 写道:
>>>> This series eliminates wasteful periodic reclaim operations that were occurring
>>>> when already failed to reclaim any new space, and includes several preparatory
>>>> cleanups.
>>>>
>>>> Patch 1-6 are non-functional changes.
>>>>
>>>> Patch 7 fixes the core issue, details are in the commit message.
>>>
>>> Fix first then cleanup please, this will make backport much easier.
>>>
>>> Thanks,
>>> Qu
>>
>> Sorry for bothering. I have no experience with backport things so I need some
>> more guidance here.
>>
>> The fix patch needs two of the cleanup patches applied.
> 
> I didn't see anything in the cleanup that are significantly changing the behavior.
> 
> Maybe some minor structure member or type change, but that's all.
> 
> Your fix should still work use the older types/members, and that will make
> backport much easier, without the need to backport the cleanup as dependency.
> 
>> I currently have no idea
>> what I could do to make backport easier. Should I also add "Fixes:" tag to the
>> two cleanup patch?
> 
> Definitely no, and those cleanup should only be done after a fix.
> 
> Cleanup is not a fix, thus they should not have such fixes tags.
> 
>> Or should I squash the two cleanup and one fix together to
>> make a patch just for backport?
> 
> No either.
> 
> I did a quick simple reorder, and only minor changes needed to pass compile (not
> tested). The reordered fix is attached.

I've seen the patch. It will not work correctly but I've got the idea. I'll move
the fix patch in v2 patch set.

> Keep in mind that, during development you should focus on the fix first,
> ignoring all the unrelated minor problems, which should make your fix small and
> that's making it easier to backport.

Got it.

Thanks a lot :)
Sun YangKai


