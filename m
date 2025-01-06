Return-Path: <linux-btrfs+bounces-10748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA91A02870
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D811886584
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92C1DEFFE;
	Mon,  6 Jan 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CIQqeIkc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226DD1DF277
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174781; cv=none; b=HcicI43BhqLmvJaAwcR+HEQQ5RS0yzwwVMeippSCEAA1fEaX0klPl1fuRZ0Tw1dLkpTLDR2aRRywKirppv/XnkZEihFhr9h/AtCxW2hqf1b3VImo+QARv0YxGyDfFNPYFjqIi8WxTeHzaKDiRXqYDxHX5QBVkQ+Ns/CfX3FlFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174781; c=relaxed/simple;
	bh=fI6q8J3o5JaswHTvLY9YJ3sKyyUvEy2uQ3VI6pQNS9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkJXCyk1YBiwEY4p9/5B7FCYsiTsjKth5EWa9qLGV9hSSvL8VDwu7b7Bmx/1NT0arJJwdJWolcbKp6T/eYR9OLYqb5UBRri9wH5FHxe0EnQKmQGCiD3ymPEqbGmhAPFAPX4OwJ0b6AYm9Eaw8G7qaxkeGWngumXGLkBFgwaOtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CIQqeIkc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso1235078739f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736174773; x=1736779573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVgilT65vfqrcUMZ0DhwA8Ndt2ESjpsIJjgmGlx8op0=;
        b=CIQqeIkcF4v/XTOI1dGIrMK5JjnFNewWbu3GgI6wboF0QjrKDwc8cWoE6ZAPffnNSF
         MwoHOr7B30fJE7D4MKrVwEBZFL8ewkWFNsw3JWo9x2u5oFpi/ZUO2eATMCml27uUVxq0
         +tanGPoWKdaP1Ij8DoX5cGEFoprrEAc87h9xAENp7J3V7stF/emgbg1ZjhiSUyr16LdI
         PNNnuPSq4mAuobWtrjiZrVAVqtfkpbyrPn99bLnmUd0ZU5plllsFd2UEHCjCbX6TYTJl
         L6jkEXalcrAJxO2LAH4MFgp68aCx3xCT/64Vr/q5e9VXMzUkh+sGAFttyQC50YBPXS8H
         Z5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174773; x=1736779573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVgilT65vfqrcUMZ0DhwA8Ndt2ESjpsIJjgmGlx8op0=;
        b=PX5u4iAy4F2AJesJDUx2b9ry/bHgECV2GJ6MyYSBrcopcx+oIx5bLXZBxEAJMVZ553
         5G3dA3OBH1rmHICmGEvp39SjMMUgfI90fgRbHJfhHL7fBHR/Idp2CQDNT+5CsqS5Wk5H
         8zcWQFMWOJhISR+r2hFlw34Pt2zQSeOyIH5f3VRk5ChNQaHzSMFZZZM4Aoh2vuhqqZvM
         7HqsU6SG0ctSf/Zt3sQoAn58swIz8ehDKxsyym4iteGaToo6q6FZfWZelDgGeAwIG6tP
         hW14LgOKdCWrrL1eYvx1uiytBjTkQvIXWJq3GZ0yfkhIqagYSZ7Jm4ofHUzEO8msOgCO
         dy6g==
X-Gm-Message-State: AOJu0YyR84nVUgcsVyglJXgRA5ygdzEImT7b6L2jBRhLGRjXXTWI1p7C
	QT7vQ3vRo06wpGq9FEh3qKjUPrZQaLXQVYkFX1FDWbDR2so2gvRtH5XHyEA5EYw=
X-Gm-Gg: ASbGncs/evRSSH7wZBBqNcKiD50Y5aDzmYbveE/cuu5AL0N3vX+mvdjLiIogmdjqQcR
	/HqYTby1HR7dIylpzNmlQS3yWcWUj7NDbXa7E8At8gGo624ftT5By1ROO8a6OoQBVniuZePRap/
	/XE2wmgc0AC7uUi2pHWwJ6qONeCs4tC0p7ms03qaWnb8swn84+K8w9fNRTxGG6l0Jpe8GYfj4pn
	+NO+XvMrYU2qE2ws1Z529u4VumK98sJ9qKqWArfm0mc7GY60H7m
X-Google-Smtp-Source: AGHT+IGi8d8jE557Qg+wQsb7isNA0citi6JnuJMLFdV0VvarYPCeZnNnZoK7/w6GlL38PUXiC5uSsA==
X-Received: by 2002:a92:cda6:0:b0:3a7:8720:9e9f with SMTP id e9e14a558f8ab-3c2d14d1c30mr438784285ab.2.1736174773305;
        Mon, 06 Jan 2025 06:46:13 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1de6e0sm9494948173.127.2025.01.06.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:46:12 -0800 (PST)
Message-ID: <01b838d9-485f-47a5-9ee6-f2d79f71ae32@kernel.dk>
Date: Mon, 6 Jan 2025 07:46:12 -0700
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
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <974022e6b52a4ae39f10ea4410dd8e25@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 5:47 AM, lizetao wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Mark Harmstone <maharmstone@fb.com>
>> Sent: Friday, January 3, 2025 11:02 PM
>> To: linux-btrfs@vger.kernel.org; io-uring@vger.kernel.org
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Subject: [PATCH 2/4] io_uring/cmd: add per-op data to struct
>> io_uring_cmd_data
>>
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> In case an op handler for ->uring_cmd() needs stable storage for user data, it
>> can allocate io_uring_cmd_data->op_data and use it for the duration of the
>> request. When the request gets cleaned up, uring_cmd will free it
>> automatically.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  include/linux/io_uring/cmd.h |  1 +
>>  io_uring/uring_cmd.c         | 13 +++++++++++--
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h index
>> 61f97a398e9d..a65c7043078f 100644
>> --- a/include/linux/io_uring/cmd.h
>> +++ b/include/linux/io_uring/cmd.h
>> @@ -20,6 +20,7 @@ struct io_uring_cmd {
>>
>>  struct io_uring_cmd_data {
>>  	struct io_uring_sqe	sqes[2];
>> +	void			*op_data;
>>  };
>>
>>  static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe) diff
>> --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c index
>> 629cb4266da6..ce7726a04883 100644
>> --- a/io_uring/uring_cmd.c
>> +++ b/io_uring/uring_cmd.c
>> @@ -23,12 +23,16 @@ static struct io_uring_cmd_data
>> *io_uring_async_get(struct io_kiocb *req)
>>
>>  	cache = io_alloc_cache_get(&ctx->uring_cache);
>>  	if (cache) {
>> +		cache->op_data = NULL;
> 
> Why is op_data set to NULL here? If you are worried about some
> omissions, would it be better to use WARN_ON to assert that op_data is
> a null pointer? This will also make it easier to analyze the cause of
> the problem.

Clearing the per-op data is prudent when allocating getting this struct,
to avoid previous garbage. The alternative would be clearing it when
it's freed, either way is fine imho. A WARN_ON would not make sense, as
it can validly be non-NULL already.

-- 
Jens Axboe

