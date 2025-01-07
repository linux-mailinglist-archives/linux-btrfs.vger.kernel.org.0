Return-Path: <linux-btrfs+bounces-10759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E86A034FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 03:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5816716440A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543286321;
	Tue,  7 Jan 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KzG//src"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25C2594AC
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216265; cv=none; b=EKZU40zPTrtgHtL1+lVWp69GhrYUeJ09mEmMLLcQAYFJ6qGrdwCXfopCKjDfZ/HBxOXoB9TNhOEpYHBMAuSgQoEQrCm774p8wQ+JtdKkK1pnxTvRrpoP/IRu66pJ3nTbUt5lt8KU6rRwXXWMQGMGYg32tVGExcDYWcL439TV1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216265; c=relaxed/simple;
	bh=h4KyeIx/1I2PTmM4mENZb7zjGTWH935/w25CwO7qc1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWjw/ZA4m5tewo5S3k6NgoQ+uemXFrTqQj6CwJibLwO05tSr/35AIHGGUvEzlHYKw/Dq7SQTZ1wryTHCiEBgHgkHJa7+3WdrQoCug8pPA5MjI8aCuMYBwNWCLWByTxO/xPOywN+kOqoe4M0JfOqFw/HDYDLJ8bBGzvFYRalrr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KzG//src; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so116008005ab.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 18:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736216261; x=1736821061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92MtV43/q/VStM5ltOEmavD/9Z5kJUjPvTOj5sLJlLM=;
        b=KzG//srcpvVhKLpq2QL2q8RVCMQNGyEvPV9JU+QEaDN8z0/DJqKpdHPrbAnuLwV76T
         KY+9x1pZIKB9u5aMF024MewPk3XZwGFUlBDah6mK+231qllKbk7VrhbMqalMnz5GFb49
         VqTRjJ1V+WpQcTSMmY5ZRaU7CraJSwb4eho4zOL3X92cQe20+epwteUuHb+3Hk8YE0Ql
         dH1dRQrj2J3j/swMy9bgg0qAYmq1SN+j2kzRGWDUEJ8kN103ohldZnR2C5+Rz3yfROfI
         9UOrELe4FAZ5CnlZN+LOcvy0ql2sEiI+ujlfptQlq2biDV2UhUKhmC3bgU7RNR2G7+Fh
         QOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736216261; x=1736821061;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92MtV43/q/VStM5ltOEmavD/9Z5kJUjPvTOj5sLJlLM=;
        b=hjrY3nY/LhM1sOBHLu793n7gJVRwsKvD+jpTWY4WIqCCzQjbMuM6AZIkLkeeKjo4Y6
         3+qGlEfQDgBCW7s3OIikr/kJH9/4w18hCUXs2aDhcIsaP8X/TaM7EElhhM9rVbGdn85W
         JNobfrjtZE51g2drWtpQ5t9dhSJe1/dAvHtgJINxaYc6uqVdwRaFIZvkUmzqKSpeBusP
         zHSh570dYnS2JGXLTPdQQ/igbVu+lBnloNoyA/eF2ThtkO0lAbFJMD5blYTENFdptUQ+
         qW5/KuBT0oD2vdxQuomBxzzmBR3EsNgZ8rZExXetISzF28jCJe1hV8+h/M/as7jeK/UN
         lXdA==
X-Gm-Message-State: AOJu0YyyWMWVqCwNARohx3Wy3Q5rU14hfovKRnSt/Lp1c9O/ZYcTbER/
	qirdqCosjGloaCzOuwKgllq8aJZn3znfMFhtKXwUjZ9nsTXlbawZs1FrocTIG1kSdzBQw4XrBZl
	Y
X-Gm-Gg: ASbGncuk/jbfCgjfF3wtkUBD1TU4YKt2FLO0C9oZQ80MFq8xaWoysxTCnpob6cfp0TX
	VLjUzYUGYlxikfv33j31QwSVOEpWAgj/Azds5p76lSoQZ58RiSjlQeHNnAbX+gSaOzpNGy4mwR5
	sK3FNjirhlhWXZCsNynNHVwVHlz/xLvpxBn6wXWs3L3BaTcsc3vjU26vTdPZqVgcvBMjfZe32t5
	i5HHUDs95mhbohlsGiwcS31EBBERh49c4QzTc/1xsfc54pcEcD85w==
X-Google-Smtp-Source: AGHT+IHmnGCUUshvzjHQeuqswxB8rbutUI8Kl2ImwYXkMiyxDAQKLnZTe6a08hQz567k4iiXro5NQw==
X-Received: by 2002:a92:8748:0:b0:3cc:b7e4:6264 with SMTP id e9e14a558f8ab-3ccb7e464b3mr192134895ab.0.1736216261181;
        Mon, 06 Jan 2025 18:17:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c199afesm9760858173.94.2025.01.06.18.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:17:40 -0800 (PST)
Message-ID: <aa9a7b74-a9c6-4333-bb25-490655eadb45@kernel.dk>
Date: Mon, 6 Jan 2025 19:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] io_uring/cmd: add per-op data to struct
 io_uring_cmd_data
To: lizetao <lizetao1@huawei.com>, Mark Harmstone <maharmstone@fb.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20250103150233.2340306-1-maharmstone@fb.com>
 <20250103150233.2340306-3-maharmstone@fb.com>
 <974022e6b52a4ae39f10ea4410dd8e25@huawei.com>
 <01b838d9-485f-47a5-9ee6-f2d79f71ae32@kernel.dk>
 <3e2e277ed6bf40ae87890b41133f5314@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <3e2e277ed6bf40ae87890b41133f5314@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 7:04 PM, lizetao wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Monday, January 6, 2025 10:46 PM
>> To: lizetao <lizetao1@huawei.com>; Mark Harmstone <maharmstone@fb.com>
>> Cc: linux-btrfs@vger.kernel.org; io-uring@vger.kernel.org
>> Subject: Re: [PATCH 2/4] io_uring/cmd: add per-op data to struct
>> io_uring_cmd_data
>>
>> On 1/6/25 5:47 AM, lizetao wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Mark Harmstone <maharmstone@fb.com>
>>>> Sent: Friday, January 3, 2025 11:02 PM
>>>> To: linux-btrfs@vger.kernel.org; io-uring@vger.kernel.org
>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>> Subject: [PATCH 2/4] io_uring/cmd: add per-op data to struct
>>>> io_uring_cmd_data
>>>>
>>>> From: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> In case an op handler for ->uring_cmd() needs stable storage for user
>>>> data, it can allocate io_uring_cmd_data->op_data and use it for the
>>>> duration of the request. When the request gets cleaned up, uring_cmd
>>>> will free it automatically.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  include/linux/io_uring/cmd.h |  1 +
>>>>  io_uring/uring_cmd.c         | 13 +++++++++++--
>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/io_uring/cmd.h
>>>> b/include/linux/io_uring/cmd.h index 61f97a398e9d..a65c7043078f
>>>> 100644
>>>> --- a/include/linux/io_uring/cmd.h
>>>> +++ b/include/linux/io_uring/cmd.h
>>>> @@ -20,6 +20,7 @@ struct io_uring_cmd {
>>>>
>>>>  struct io_uring_cmd_data {
>>>>  	struct io_uring_sqe	sqes[2];
>>>> +	void			*op_data;
>>>>  };
>>>>
>>>>  static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe
>>>> *sqe) diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c index
>>>> 629cb4266da6..ce7726a04883 100644
>>>> --- a/io_uring/uring_cmd.c
>>>> +++ b/io_uring/uring_cmd.c
>>>> @@ -23,12 +23,16 @@ static struct io_uring_cmd_data
>>>> *io_uring_async_get(struct io_kiocb *req)
>>>>
>>>>  	cache = io_alloc_cache_get(&ctx->uring_cache);
>>>>  	if (cache) {
>>>> +		cache->op_data = NULL;
>>>
>>> Why is op_data set to NULL here? If you are worried about some
>>> omissions, would it be better to use WARN_ON to assert that op_data is
>>> a null pointer? This will also make it easier to analyze the cause of
>>> the problem.
>>
>> Clearing the per-op data is prudent when allocating getting this struct, to avoid
>> previous garbage. The alternative would be clearing it when it's freed, either
>> way is fine imho. A WARN_ON would not make sense, as it can validly be non-
>> NULL already.
> 
> I still can't fully understand, the usage logic of op_data should be
> as follows: When applying for and initializing the cache, op_data has
> been set to NULL. In io_req_uring_cleanup, the op_data memory will be
> released and set to NULL. So if the cache in uring_cache, its op_data
> should be NULL? If it is non-NULL, is there a risk of memory leak if
> it is directly set to null?

Ah forgot I did clear it for freeing. So yes, this NULL setting on the
alloc side is redundant. But let's just leave it for now, once this gets
merged with the alloc cache cleanups that are pending for 6.14, it'll go
away anyway.

-- 
Jens Axboe

