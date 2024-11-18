Return-Path: <linux-btrfs+bounces-9749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F40319D13FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E86B27F76
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154841A9B51;
	Mon, 18 Nov 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k0Is1buZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DDF1A9B26
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941403; cv=none; b=HfV/lA0gRD867sNjKsMPmIjdefr/10phKLT9PTWa/mKtzGvkHIEi8hAAEHLB9QF5Or9Kaezalc3iUZnMMXBsJz6gKIySScoIA03NS4OabP5oMf0TPn/fPawUXMUNYyi2BbCita1XxllBrY3BjHDGqXHW5XDbVZT7OjF8MdQmhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941403; c=relaxed/simple;
	bh=jabCupIh1FJFAKWSdaG7M5rrT0Y7L0LAPYbB0FE65Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMfxShSI8/UZ6xvRFr20FwgSU6mU0L+aJKyoOTAxwEDhRypNBvkReG1kUaH82bblL4qce2dB242Jd6T4JSNmhlaGCzjS3YjR0h6fQK3NSQPhCZhgVHJfhVNj+dRVMZsfNt8SgeGsDdEFd6UhcD3qR2SZvIg6Bsc43CMPDx5VUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k0Is1buZ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso1683421fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731941400; x=1732546200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=k0Is1buZhEVRX8aA2YpNv8xH51kd3XdbQCdU6sjFm6apcmft7wlkZzhH7Mb9GK/+2G
         1ych5iZYYRNoEgNf/GkM0axLJb9fKsMg61umrjWEmu90EW9mrMb1789SRAbRJEhfjo6y
         Xmccgf3Vb9OQ5OYpKxWee2AxCS87/bX4pAKbglFrVIXGqo2Tj9/DNJukkN8cSrx9Vw6d
         GL5P2MEa+d1yuxxcKeDri93rmq7rjaGcTCBL87Ks5NGABsRSD9DPWYcfdy6Uhy0xWtZ5
         +SU85X3/ub2mgUOCY6QgZVRoxVXkkmtf+jTTNLtdabubJEcV5dBnSLlNhBBJk/jCdviS
         RnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941400; x=1732546200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=aqU3l5I+3W8D33YUa2f1QQDbXYT6ePzYtlKGqD3sS9maFVXDJg15ZZTiCJMS1eoxbu
         w14loi+7JCiY8w9HQwpiCVhblD2v8vROmv/ai2N61qZaepZ50vkogcMBqUsDdO3sZ9UY
         dXKEWykEvZb8m61ICBM70ipLkwQzyxoOSrfAt10XfNGiDL4Tz3aCWg0Ze3RGBJ3Qd9VL
         w8rkAAKSKaoVOZieDRAlfcDhcibVykhccR5bLLVq99zEDAW+Cjc675+WEYKLHupId8gZ
         B+arIy2lL99qAYKNYf63S/ZR5xRvhfB7dQEEBciDesUIxGvbUXVpmCOaEwLEy5nJDCgb
         967w==
X-Forwarded-Encrypted: i=1; AJvYcCVz/IyUB2XMPc1FOOrEpiUQDoY4vSHXafTH+ti2RzGNnDPjX/2peh6szKfxkaIkLnrE34SVDI3GqAd9jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy76VPbUmX+O1Dig2chSKOrfqmVoDEiPGxzXSEC4xGqojXDuLA
	5FOyi18W2H3KZIh7ml/OmvrJzeRayue8aLMf/sH50/6LDBUjX2plzw9cJLMJpuA=
X-Google-Smtp-Source: AGHT+IF4SYJY9kdWkwrKjlAiH5Z+Bn8SZkqEPmKpcyMndgMPRn4H9T8dbqU6Hyt3/gFfCCmMTdbpdA==
X-Received: by 2002:a05:6870:ab0b:b0:287:1b05:297d with SMTP id 586e51a60fabf-2962e01ad0dmr10557378fac.33.1731941400385;
        Mon, 18 Nov 2024 06:50:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm2626597fac.2.2024.11.18.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 06:49:59 -0800 (PST)
Message-ID: <c54063db-5f82-46d6-ba7b-5e4a0073ebf9@kernel.dk>
Date: Mon, 18 Nov 2024 07:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, bfoster@redhat.com,
 Yang Erkun <yangerkun@huawei.com>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-12-axboe@kernel.dk>
 <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 1:42 AM, Baokun Li wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 45510d0b8de0..122ae821989f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2877,6 +2877,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>>                   (iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>>           if (ret)
>>               return ret;
>> +    } else if (iocb->ki_flags & IOCB_UNCACHED) {
>> +        struct address_space *mapping = iocb->ki_filp->f_mapping;
>> +
>> +        filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
>> +                          iocb->ki_pos + count);
>>       }
>>   
> 
> Hi Jens,
> 
> The filemap_fdatawrite_range_kick() helper function is not added until
> the next patch, so you should swap the order of patch 10 and patch 11.

Ah thanks, not sure how I missed that. I'll swap them for the next
posting, and also do a basic bisection test just to ensure I did't do
more of those...

-- 
Jens Axboe

