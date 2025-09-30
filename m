Return-Path: <linux-btrfs+bounces-17288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB260BAC44B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A0192206B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F302F362F;
	Tue, 30 Sep 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHGvXsXk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9806217736
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224420; cv=none; b=Hms+G6YquYAFemkcGfmegxgzRt+MViyKAN/j6gSst7KNVcSd5EtX8/bHQ5bRrZz1Yc/iVWJK4T8B5ioHhF1exSC5vgVYa5fmOxtnaxAXAtRKLVG8LTNdYj0VxECITErvrQsSTLjnhlpceEREIr+HHYxjUsIPxIJFXgQDoumJ43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224420; c=relaxed/simple;
	bh=j6aKpZja6IJO9Sv+6v0U/bfOyaEulbLfHw8yBTY5Ssk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXbW2ANoaJg2OvQbqKINOedLq8vPpph8ycP03b8Yr6YeLEpymWlFSFxKoX7vtaswWCepBjadY2EpDITd1lpao5rcQMm9ddv8kEoOni20KOzW8o34AL8tKQ6u0Gkj9RErbCkrDbSleXE/lpPdvf8WS0Rg24VXAaO96XI+amnFtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHGvXsXk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3e16d7fbso8049435e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759224417; x=1759829217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmD1H8OwmHh9iQxosxV+vKhL8WnHs3OeYyoNA3LHXXs=;
        b=SHGvXsXk6pttbqDVQdRVpWt9ncrfYMns1+OZd7BjSvfD/Ze7BhDf2xRKvTD9L+6pgU
         v1znPNGs98csbW/2r/Hm9AloILYEov0RQhPriSRu4SV9NxKyRszpoqs345NO/pgSRu7O
         XmuDnbjlhp6wUcahEYjd7Nd7TUpcYwxHlpO2GBUAg/0Szat8JbNG/rqvgDSb985/VUv1
         At7wMRxTpOU4D9yB2OyRP588AYrQDU1MkxUEfuNtXDBVzvhSLP7aJOFJbZPYsrmmpQQI
         pme8GUy5JNO8O3nbWK+9jQfjXlOiYoFhbNrkC92kcCmXSJ7FKdwTtkfuusaRNMx/Ko4Q
         GPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224417; x=1759829217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmD1H8OwmHh9iQxosxV+vKhL8WnHs3OeYyoNA3LHXXs=;
        b=Z4sxOAt3OoLdrb0pd/hSkw2PMvDSjPd/h/+Fkvc1BwXGG0EXRzF1wvOlglm1qE/dOw
         N6rppsNMKIZLGg1mMZ6p+XwJzdG7vPtQZKdNTc+MWlnruG5fvkNlZ9da/Q3lC657y+KU
         3ntNoUB7YvC1xghNsQNBYqzlmVC7oXQyyZW1Nf1R4sULTJFC77rE8XM90S6FTyd9Dph8
         RZ4UgrwQ6IyCaTrqHjvVV+w9Becz+QJSxyPTdP9A28ruAKcJcwk74S29dpzIPSPhx3S4
         tnVPrpmw6Q2J0O/j9b250h1kNrzVECpM8aAZWV/Hsjl+PUve0AIcL4JFIpNSJTX/IuWI
         DRlw==
X-Gm-Message-State: AOJu0Yw02d6q76tyP53ROs645ek7ay3bpirHFhy+1zmTtf6VtSpDfHvx
	gFW8detryoU7y7IUFBDlqtIIO6hzpldA/JVkd9zogdd3GpBxVmk94yd4
X-Gm-Gg: ASbGncuxGssV2qP2yw4AopVdB9AJdhakEXz3vjK4xIYTw+iYrTvhKqlfLJZItg5980f
	pRPI/iZDUe31TzFDUokFkwjWZ1KiM8R2pACsjln+D0hVdMs2CGQJ7KjFPLoZR3iRhfi7g/ZGU28
	N5Kc6oq8A61XHpl6ZYoz8XMK7pd7Mjdrpf3lSVeJS6x0/ic+x344xbS+xBSyA9AHwIQOpLQugQC
	GhDzQFvlCGgCvodFvcZEpiQw1mzoaWQtIY2k0zpGjXNwUyieBZs4c6aSSZeq/oVOeBJDmzn6z3/
	9QmA/gusYD0yRy5bAQxgwrd5FgNI4LkdrSXs8rVzOtlO4hO0cIP0bYZLA/00eqrvgvDQ2EvLHWn
	fHIa2OIQbhUUiOVeCfTk+eIfzQ4jMCbFkAJyh4VAdIUSFbGxxrIgATpham2GR4E3zCY1kZQd4N/
	OFIlGt+61R
X-Google-Smtp-Source: AGHT+IFGYtwA1qyoebtVQ++gcwEdKaTx5QP4eRZN8yRpJyR7zx0cvodJhiLzw+/VafZl0LWNohao6w==
X-Received: by 2002:a05:600c:3b0c:b0:46e:5cb5:8ca8 with SMTP id 5b1f17b1804b1-46e5cb5a045mr6783365e9.0.1759224416900;
        Tue, 30 Sep 2025 02:26:56 -0700 (PDT)
Received: from [192.168.100.179] ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm21820638f8f.27.2025.09.30.02.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:26:56 -0700 (PDT)
Message-ID: <342929a3-ac5f-4953-a763-b81c60e66554@gmail.com>
Date: Tue, 30 Sep 2025 10:27:06 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Refactor allocation size calculation in kzalloc()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20250930091440.25078-1-mehdi.benhadjkhelifa@gmail.com>
 <76fa5e79-c7e8-4637-bf51-c0e6f4e04f51@gmx.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <76fa5e79-c7e8-4637-bf51-c0e6f4e04f51@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/25 10:19 AM, Qu Wenruo wrote:
> 
> 
> 在 2025/9/30 18:44, Mehdi Ben Hadj Khelifa 写道:
>> Wrap allocation size calculation in size_add() and size_mul() to avoid
>> any potential overflow.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   fs/btrfs/volumes.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c6e3efd6f602..3f1f19b28aac 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6076,12 +6076,11 @@ struct btrfs_io_context 
>> *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
>>   {
>>       struct btrfs_io_context *bioc;
>> -    bioc = kzalloc(
>> -         /* The size of btrfs_io_context */
>> -        sizeof(struct btrfs_io_context) +
>> -        /* Plus the variable array for the stripes */
>> -        sizeof(struct btrfs_io_stripe) * (total_stripes),
>> -        GFP_NOFS);
>> +    /* The size of btrfs_io_context */
>> +    /* Plus the variable array for the stripes */
>> +    bioc = kzalloc(size_add(sizeof(struct btrfs_io_context),
> 
> Please use struct_size() instead.
> 
> And if you're using struct_size() there iwll be no need for any comments.

Understood, I will get v2 on the way with your recommendation.
Thank you for the suggestion.
Regards,
Mehdi

>> +                size_mul(sizeof(struct btrfs_io_stripe),
>> +                        total_stripes)), GFP_NOFS);
>>       if (!bioc)
>>           return NULL;
> 


