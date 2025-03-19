Return-Path: <linux-btrfs+bounces-12430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0CA69601
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D3946584E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E611EF391;
	Wed, 19 Mar 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cy15NsXG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D111E231A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404212; cv=none; b=XH1qb7yZu9S09+J+MsKLl/1+phmXHJIhjL8eG9d0+9dEC9f4s1mo6aZdnpkUxNfkdOTJma4dIIMbK8AptIIvRk2EXvMrrvQP8czlHmKSrrX/uVnsU5PGzaKzZFX/FPqIw3LNWaaRrMDOVlOC5ro1TkKcM+9XHQKyKb0gqQV+p98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404212; c=relaxed/simple;
	bh=5d7upz7B/l6U5x0NMnEBfrZij8ioogDhdiOywgYsZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smVWjkWEQU0q0SST3mfEsNe3D0fTzP9Y1K1m8jk5IzO/22L8JaJ5argawfXooSAxgZnQfJKU96eZoYfvxifVxRgZdsWVhJRb3ySgZAR12em3d4gHmZlZDCu9SUpMeGW8shVSiwXJsKBvx/2ck1gqc9z8zgLEpo3tJrFJu04xxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cy15NsXG; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d57143ee39so26074235ab.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742404209; x=1743009009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvKPIfaaqvxeP2gFs1lsUm/HPuI7R2LP+xgOJBg1ojE=;
        b=cy15NsXGNj5lfba15RiqSl6+7Aj8QajiGwtvKmLTVdFUfi4RqJHrRknjXdvlSIglBq
         E7FSZygjeypE5VVRjqZenj5ozOmRz230PqFKD1fsDkQF8A45qDvzzblB2k7+bt0/NsGa
         uVIoPgjh+I58CZ9ysGGSNeDrwTP9VpNaK5yK/SqfcB09nQsNDj8H2OhDoyTOi7B9esMe
         OEFCtY4WHtzXs0BZVBe5owm3053ckMyS/NOWMrb4mVJMJzfJi06o2CqP/JCdoHZdcUrp
         pCCQs4jl+berbgYY0DH5Bv7RHrZl9YyqdesuSWoMdOpSeXt90apZbKaAn3+SASZGIga/
         9m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404209; x=1743009009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvKPIfaaqvxeP2gFs1lsUm/HPuI7R2LP+xgOJBg1ojE=;
        b=F4nP/k5reEKZ08IKl96/w6Iw1vub9wiaw8vgOR/xkLm6NHtBCuDQ/6GgasNXeudujh
         gwIYCu425OZfn5YocTNGerHxsbtrUUaSuf/Br09Evi8FdU+6Xt9YOyf24W0CDyRNAhH4
         ZZeQSJgUIAlA3jGHBJm/KR1jUCOWj00n0wFhii4Z+AvSgyPKs5PhCbYkJKEvT0JW+p/G
         HNpuyYuFPsmJQNPDC4/fH8Ncj0FNSX0XgZrIf23T30tuUe9ILKf/7Ay0tLz0lkrcowG4
         4QoxvdEhtk+jD2gpZZ8Vvx3cUbytWCV4ySDK2v6tHmKyv2mQcuoCi97Ve+grO9EBwakG
         admA==
X-Forwarded-Encrypted: i=1; AJvYcCVGKwpj3n+mu8IU4Px+liYo4wfbzV9Kb6XPNuUPqXVz+pq/OKZI1gQZpeMRu5ZkF6F4s0iO4bxErXyk3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwID2TINOxeP8YS7I0+dw94SMfqANRvqZoH8oCyq91tZdr7a68R
	gYXZlSAGxL9I01TbOvQtKMLMU2AFwGp9AYa8xNDIyxIAB9QYY79CsLrCxhec2Bo=
X-Gm-Gg: ASbGncsTzfAZtx9LVqr+6KtzluSnZb94vWGNlY7ZJWlBI7ypGHO5GLO2e2eqjzOi39F
	2bLb7mzELBFsVOFpk+0pczGgjzHCg1axLFETtmXHFwrbYkqa0lqY5mrm8Y1116fzDZSQ7zs31JG
	wIn8csxgGMDtwQ5zw7RyBKzaaTKFLENVvcpJpej5TC+KdzlXdscJX+o0kiiEXwfx1a8rPa/1G79
	zpx1Vu2msv4pRIBThJ/CDEeg+c9ywDlzn1pdh/bXuhT39VgDJDzslUED9f0pdXx2l5+UoHV85AX
	yUBNkoISEnrzC10W2f/QmjaTFgYoIDu8a1vM/plF
X-Google-Smtp-Source: AGHT+IGWl2I1xOgcxt/qEPpyHQ8BUlc3Uem9MmYeYl7m1Gz6G3S8Ky41p9F2HGEzpxK/50SXU7PFVA==
X-Received: by 2002:a05:6e02:1549:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d586b1b246mr35475725ab.1.1742404208874;
        Wed, 19 Mar 2025 10:10:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72e015sm37657205ab.56.2025.03.19.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:10:08 -0700 (PDT)
Message-ID: <4ba22ceb-d910-4d2c-addb-dc8bcb6dfd91@kernel.dk>
Date: Wed, 19 Mar 2025 11:10:07 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Sidong Yang
 <sidong.yang@furiosa.ai>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
 <f78c156e-8712-4239-b17f-d917be03226a@kernel.dk>
 <20250319170710.GK32661@suse.cz>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250319170710.GK32661@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:07 AM, David Sterba wrote:
> On Wed, Mar 19, 2025 at 09:27:37AM -0600, Jens Axboe wrote:
>> On 3/19/25 9:26 AM, Jens Axboe wrote:
>>>
>>> On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
>>>> This patche series introduce io_uring_cmd_import_vec. With this function,
>>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>>>> for new api for encoded read/write in btrfs by using uring cmd.
>>>>
>>>> There was approximately 10 percent of performance improvements through benchmark.
>>>> The benchmark code is in
>>>> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/5] io_uring: rename the data cmd cache
>>>       commit: 575e7b0629d4bd485517c40ff20676180476f5f9
>>> [2/5] io_uring/cmd: don't expose entire cmd async data
>>>       commit: 5f14404bfa245a156915ee44c827edc56655b067
>>> [3/5] io_uring/cmd: add iovec cache for commands
>>>       commit: fe549edab6c3b7995b58450e31232566b383a249
>>> [4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
>>>       commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d
>>
>> 1-4 look pretty straight forward to me - I'll be happy to queue the
>> btrfs one as well if the btrfs people are happy with it, just didn't
>> want to assume anything here.
> 
> For 6.15 is too late so it makes more sense to take it through the btrfs
> patches targetting 6.16.

No problem - Sidong, guessing you probably want to resend patch 5/5 once
btrfs has a next branch based on 6.15-rc1 or later.

-- 
Jens Axboe


