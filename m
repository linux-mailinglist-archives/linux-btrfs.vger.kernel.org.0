Return-Path: <linux-btrfs+bounces-12483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA4A6B9B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9466188F44D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9C1F09A8;
	Fri, 21 Mar 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yMIVhXf5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EC1F03C1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555839; cv=none; b=NuBf8RaXKa1+Y9m8n6FrUQOuHgnxIS449PjaxdaQPTTM8r8UEpi3QAA0fK/rMVXiT3FwySNIid1ddQgsTSAsoLF0vAAG8KoLbDH2EtEmtFHUInUdN+0jLW7nx91PWGtxwq22dH8cSJvtF87S+3SF3NVud8sXq02dTNzz2TTwGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555839; c=relaxed/simple;
	bh=m2vc6ZJ6JSH7alaxCXpXJz+S+m3RfjPoDbd/zOWr3bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBJFUd1yIB1LeVj6mIyYGeRGv0FRYh9mru4BmSnMlZOaUB5knd7wZ0ISAvgQTcHERvIM3AJXWq701fuhVtdakeXNf9wvDoV/8NoPDOXzZfONvTdl/W8IuDEuBVcAqxZYOhy38BGsw8OwV+lGuf//ieaJ3XCnYm0llvYN13tTgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yMIVhXf5; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so93553739f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555837; x=1743160637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59LLzW7ToEBWUOpkdwZSTFFdcnkJr66vbvUK+dy5Qmk=;
        b=yMIVhXf5Mqo0ShzlMSrLXH6x1Nw8VmuZ9KYMVOt2NxSaRM0Gxn1aIxizXWYQoDV9zN
         PGxZqsAYKFXHUkas/DChYcxMgMLKYV8kvbJZZZqA0+yhTFhFxzG11ipFt+q+nogS7ON4
         Qa4/Jfc9bdNyGCsMHNYzle4Kl6vbKm6il2Mo4Qg8h0mu2ZetP2I8lWM4ybBqQIxy1uRI
         wme/cqL3NANjczAY0ejYgJNj+3ro5tD4vIeKpw/x1L2ope5wirAimi4/e++xYOfwEsJ8
         1I35Af6oBXry9iOgHAmzr/UrOwSS3mu8Yu44lphJUF2dYr0uOFhYVLBbzn9bqW3SA+IP
         wlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555837; x=1743160637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59LLzW7ToEBWUOpkdwZSTFFdcnkJr66vbvUK+dy5Qmk=;
        b=ATxbkxGloteKNBvMXCfbnzCZulL4ekF71VZnYKTOd7tkqRJVC3gQon/aro63gNNg93
         hgl2m7ZC0nH84/39HNHAETCoVCUiaSq5T7u+oAGLXZIMrrsVOUJDFLUNtL/FnuJO6Vec
         URrHxDPwKKt4hnM9hC1tW3IuOy/DL8F2kcsM4PtqLqeTktkfLeaMT22y1Pao9wnkaB/u
         TVnqLSWFh9xhT45Js2EnmQhC+m/h9F1oDfB4fbvq/C/33u3CvUAnD6nKb0L0ZtIEISZU
         3lR1AB7hV52cyXaoi88Okr+3l45HRWombowMsKAp0O2H3v9MKrMrH+9EaKCsNvLLK6Q1
         bBRg==
X-Forwarded-Encrypted: i=1; AJvYcCWliBXiAvSWFyp4H/sbxNjJ1LzZBJctXIj5mtaht7nxP6jP3FqCxw2YaRbcs7ao9HFd7909SQQsDvC44g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYsPCDK2hzqKiidNnObtLjPDXdBmgY432dYnA/rFCe3KukF0T
	5A469NIkUxr7AZEbKYhCmmSgFl9NuSPn6ajc49CJB32qx7XB2/bLeFud2joU6rg=
X-Gm-Gg: ASbGncvvjmMBCn0lGV6EFXyHpbjBnh/nieydGmZF5qEAiwJvc+nNeLVvxTZteDFYhQI
	SrvjK0dR8aNXV7qYUgjrwSq46HIauNGFcNqPyVcGmZRk1dSzgMisxSIqQASTQ6KyLmuZSn3X7gA
	KSxYZ+JwjmkXa8Ovq4ijcMCL6M13lOAhLUMdZfXG9DUbJykPGrwuLeqeF8HvW713eVTiiwq9VPO
	NqqTZeKLw6rtlDRP2ECGL0EnpNQSJMiTCW8G+4VqlUMIhPBnd5FtkbPeH1hmsLzm5Yars8lm2VP
	7OGvjbxG1RGSD6UxYG7A6kfKcPKkP6h8ygdfVJ9fQA==
X-Google-Smtp-Source: AGHT+IFjSZ3fb43kry5hTLE5e6mSs3SJ1Pz758OOHDAPWAP28kapByaxuk0gb0pJL8JPkKgr4JClUA==
X-Received: by 2002:a05:6602:1356:b0:85d:b7a3:b850 with SMTP id ca18e2360f4ac-85e2ca55c90mr318446239f.5.1742555836923;
        Fri, 21 Mar 2025 04:17:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3ae2sm382359173.5.2025.03.21.04.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:17:16 -0700 (PDT)
Message-ID: <812ae44c-28e9-40a8-a6f0-b9517c55e513@kernel.dk>
Date: Fri, 21 Mar 2025 05:17:15 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 5/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
To: Pavel Begunkov <asml.silence@gmail.com>,
 Sidong Yang <sidong.yang@furiosa.ai>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <20250319061251.21452-6-sidong.yang@furiosa.ai>
 <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>
 <Z9xAFpS-9CNF3Jiv@sidongui-MacBookPro.local>
 <c9a3c5bb-06ca-48ee-9c04-d4de07eb5860@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c9a3c5bb-06ca-48ee-9c04-d4de07eb5860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 4:28 AM, Pavel Begunkov wrote:
> On 3/20/25 16:19, Sidong Yang wrote:
>> On Thu, Mar 20, 2025 at 12:01:42PM +0000, Pavel Begunkov wrote:
>>> On 3/19/25 06:12, Sidong Yang wrote:
>>>> This patch introduces btrfs_uring_import_iovec(). In encoded read/write
>>>> with uring cmd, it uses import_iovec without supporting fixed buffer.
>>>> btrfs_using_import_iovec() could use fixed buffer if cmd flags has
>>>> IORING_URING_CMD_FIXED.
>>>
>>> Looks fine to me. The only comment, it appears btrfs silently ignored
>>> IORING_URING_CMD_FIXED before, so theoretically it changes the uapi.
>>> It should be fine, but maybe we should sneak in and backport a patch
>>> refusing the flag for older kernels?
>>
>> I think it's okay to leave the old version as it is. Making it to refuse
>> the flag could break user application.
> 
> Just as this patch breaks it. The cmd is new and quite specific, likely
> nobody would notice the change. As it currently stands, the fixed buffer
> version of the cmd is going to succeed in 99% of cases on older kernels
> because we're still passing an iovec in, but that's only until someone
> plays remapping games after a registration and gets bizarre results.
> 
> It's up to btrfs folks how they want to handle that, either try to fix
> it now, or have a chance someone will be surprised in the future. My
> recommendation would be the former one.

I'd strongly recommend that the btrfs side check for valid flags and
error it. It's a new enough addition that this should not be a concern,
and silently ignoring (currently) unsupported flags rather than erroring
them is a mistake.

Sidong, please do send a patch for that so it can go into 6.13 stable
and 6.14 to avoid any confusion in this area in the future.

-- 
Jens Axboe

