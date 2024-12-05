Return-Path: <linux-btrfs+bounces-10081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E29E5C41
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDFF1882C3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CB224B19;
	Thu,  5 Dec 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXTkbW9o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62E224AE7
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417595; cv=none; b=SDoB5Q/k4/Rs30fChqe8AiveuhziWhCZPN2VsQoDEaLLzWp1FTTlbeAkhgkJ27O+DeDVuZ7X5K6fKOUhJ71RcpPVlqFLskITpt38ATw2cg8RYDLwAcUqy0VwGu6fi2sqjbVP1r9BRyeqhHMQH6RR8nWJ2+0Op0otv4Pv0N1/7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417595; c=relaxed/simple;
	bh=RtQleKJslflWW99PZt98xY6RlFPM3hPXONyuXrT2zUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D6mjqNDy6mGf4bVFHTfgRhP8bI7Ku4wErSdpY5Igzr6IloT5bYsUfLRn/mkP8br1J7FC7ftQv0efZoycNNq3PHCt3RvhQIqZSkOTdxBqXeYCCM+qq60zbb4b286YCAY0BiJ1x5L2SH4g7IpdZm8q2Hz45S1rHEixtDnqlo1MN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXTkbW9o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3001490ba93so13942121fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733417591; x=1734022391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bibSLRAtL+PQNbhsVirZdU2QJ5adyhqEgQw7JVe0XC8=;
        b=jXTkbW9oJlemXdTjgetpW8nDMDwJo/1NebtMRLWsEN7E3um6CJHfMWkihX4sUPlGSF
         6KDaywr0ffW6lCkH5KsvsqrY68WB8K8k6tr4KQUlQ9fy8zyAlTXZClRY5Kj6upzB8qXJ
         8hAX7yvKeL8vMSqmnic24attAK/KWUBwzyKM5xW4oI6s5hnUkYuyH2iuNfhiouzSxl73
         My0ajgzs8ASyxTZZiwuOk5Vel90jyCq2krUe3wr8mPYv2zYsnS8RNMZF3MJZ/f49JrhL
         2u7okn5PjKxPF9wTKyUCtt9b3os01rysoYUV1zEpgKhbycoymryEAJn96y3/heY1kExV
         T3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417591; x=1734022391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bibSLRAtL+PQNbhsVirZdU2QJ5adyhqEgQw7JVe0XC8=;
        b=uXaDj+nQpOwKnIaxu5WIvhKofE0NgsEoNOULXFasElUG27BvNoD8Q6N/qVUVjMLRfc
         Cb7fLMxHuyKL8RXPLfnULw/IKZa3WEvg9O90Ekz3Iat2IA9giYeoAA7Hcvu0acXHGbR1
         VgfXRvWN611kpXqv6vVRrWIP3DURrIUJKmMCeSNKumAqypHi32f0X7PMk43mfDMCjQHa
         4DG44t/oWUZjgN9Zpg/JMMuSzXcWO6x4tz3EjlrxzeYm6Qy+bE9A/CDREFrmzfqOYjY7
         b2mwr363cJb9YEhdJGjAaYQw+f1SUSYJvjnoVw1KaZVGbh/KaOpONqiQuEue2Ej08jvZ
         Rqow==
X-Forwarded-Encrypted: i=1; AJvYcCXt15xlV4x0hhdHxsAS1DdMXiqFr8sUINs8tn1y7c5706ufqOhNMwoThOo3D2DnlfKVek8/hgSEDowmCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rZKmSSuRTvqtCfRQGdNhglmrYBtNhYrIQ47HEe9nXrkqaKFS
	+AQvz1tZpBh6PeoveO3pXkgIpTyTvbbHJJDgTn7uXf5p9m7t8xKm5eXEZg==
X-Gm-Gg: ASbGncsq/CoPtAO8/32xARCRWx5qLrYtqyl0QCIdTcrd0Lq7GJvEhLp0HsnwLVcwHPB
	qWfweD6BPU88CTM1dybEBl+RnyJHSSlZTUBUweXqU8/d3GbtZ5iD8jmBtt8j83FzZ5kN884CQ+o
	wHrxPZL/KcxYGrwHpJx3qMWTDM80FAGQzTuiKucsMZWABGwY4D0ZvxU/Tqi2dgK6/3KK+YUsPc3
	mM4mwe4tQ1yYgDaWD0DJ/29O8ENEzGgoOTEfKoSgqOfTHdv62AcKsZkq1IV1mmp/4JAewF0w3gs
	SeB5mIbjPg75fkjnz+kH7w==
X-Google-Smtp-Source: AGHT+IEcv8V/1iVi6ciVPWxF3CLV2JIpfEOGCztXGeFq3v5851k4azsez5NJgjB8OBWAXa8jRi6nPA==
X-Received: by 2002:a2e:8e84:0:b0:300:18fc:8e55 with SMTP id 38308e7fff4ca-30018fc906cmr30001641fa.2.1733417591145;
        Thu, 05 Dec 2024 08:53:11 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:5fef:e07:1971:d824? ([2a00:1370:8180:3d9b:5fef:e07:1971:d824])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85923sm2516201fa.8.2024.12.05.08.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:53:10 -0800 (PST)
Message-ID: <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
Date: Thu, 5 Dec 2024 19:53:08 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

05.12.2024 01:34, Qu Wenruo wrote:
> 
> 
> 在 2024/12/5 05:47, Andrei Borzenkov 写道:
>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/12/4 14:04, Scoopta 写道:
>>>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>>>> posts here about doing so "successfully." I want to make sure I
>>>> understand the limitations correctly. I'm looking to replace an md+ext4
>>>> setup. The data on these drives is replaceable but obviously ideally I
>>>> don't want to have to replace it.
>>>
>>> 0) Use kernel newer than 6.5 at least.
>>>
>>> That version introduced a more comprehensive check for any RAID56 RMW,
>>> so that it will always verify the checksum and rebuild when necessary.
>>>
>>> This should mostly solve the write hole problem, and we even have some
>>> test cases in the fstests already verifying the behavior.
>>>
>>
>> Write hole happens when data can *NOT* be rebuilt because data is
>> inconsistent between different strips of the same stripe. How btrfs
>> solves this problem?
> 
> An example please.

You start with stripe

A1,B1,C1,D1,P1

You overwrite A1 with A2

Before you can write P2, system crashes

After reboot D goes missing, so you now have

A2,B1,C1,miss,P1

You cannot reconstruct "miss" because P1 does not match A2. You can 
detect that it is corrupted using checksum, but not infer the correct data.

MD solves it by either computing the extra parity or by buffering full 
stripe before writing it out. In both cases it is something out of band.

> 
>>
>> It probably can protect against data corruption (by verifying checksum),
>> but how can it recover the correct content?
>>
> 


