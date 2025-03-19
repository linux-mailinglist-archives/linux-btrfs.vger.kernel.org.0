Return-Path: <linux-btrfs+bounces-12427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385CA69379
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E8D3B4BED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046F1CD1E0;
	Wed, 19 Mar 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BAlQhS7D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24211C5D79
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398061; cv=none; b=qBRxE5wl9S28c5tVvMmo3Flx7MVmv03sjXyxJNdi6Q4bRYBNFJxeU2NbWF7RPaek33Q7rTqDNntxbw9Vrx4YTIG6QHmeKoz8QdFU1y+OOmSQfLFzUFAxFmc4Dkpoocm7SaQj0rQJUIDSz0RsIdJLenJ+0+5mThYlXmgfCtN3JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398061; c=relaxed/simple;
	bh=ajFWxYn7pN6VZQbZWugpPVNdvdOMkJjRACF7eJSLLoc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LET/OX5SYF7lmrzWlIUgyq+JOTWU5QbU2l2wZveJfdV37O8ehQDkLh+4pBUWYK1u+/M7mmzYpdYQ602/LAXDztPQTOZdUgg4VOqtMz/cC43dTOVqFMYhJ7la5AiIn0L5EBypMe0Kq+QZkTXRXJPrE4MeONNYjpHa78rvgqMKNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BAlQhS7D; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b4277d0fbso248657339f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742398059; x=1743002859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z5XI8XP6pizbR2wnq7L2d99WOMcynVJcs75IPIYppQw=;
        b=BAlQhS7Dm6zPUORdWPqzZAXL4vAe7RWxABO+yL2EaBDL0JJ1KyEU97HN+xd3VYQq7q
         UUrTdBc2vI5g9hGbfrlD3oNi5fAvBBCTEt8S/h5a5/KtSsHLYoQYk0qZbzvBxfOQwH44
         vuREk4d0UvEEtqXO+ARRk55UwIfS3X2dBWq8AqzWUkEjKIs/9dDjhKniXVrc9uRzSyfk
         jlHoGi2w+bxJU3R6bpy75gVbfTppX3CzMfygwyFtAGMW5sAYrBv3X2DTQ8Aam7dKLgE8
         zUBv+UcTB19ZCG0p0ZC4A+N13Ioj9ze+4SOqRQ7m3FaJ31s2oYsVq3jTMbzPP91Y11F9
         Gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398059; x=1743002859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5XI8XP6pizbR2wnq7L2d99WOMcynVJcs75IPIYppQw=;
        b=je9XtIc5cIeYXwPzEQFRqDnqSD0zbvNAnlLQiY/ppDaY1hCx3PPePpONq4bFqk/Pgz
         y9akpXOm6KdsQAVy+jvh3rqFmnLdvSQ1vRDM7eeDdVQW3LkMPMYN0fI50/0afcqbFse5
         1PxjtNjc3U5m963be5p7ZqxvfCbF+Ivy93KIKJPQjPutsP8mScw2yeNNbApOEw5mJMDB
         3or9n2x9amY5t2CFlqvuDCFZwJly2QYbuz7tlbv0glHkJnsFSbM5eQ4t9acY/4k1hvUJ
         SXOaY9gz+cSPZyfyECIewUs7xX2H1h0HTCHhgDI7azB3pZpXyf6VtlsacAsI50P67192
         PrBQ==
X-Gm-Message-State: AOJu0YzbtAbOmfWG4Em4CztCXn+3r7chSU6cq9LbMDMuiLxHMimKblQn
	vt9NwNakae/xqR18d9FrmEvSy0zAGRb3vqt7T4cy9cKEdToQMrfzBnV5ImHwbp4=
X-Gm-Gg: ASbGncvz8Gnsffy27wnm7eM+g13sxOGymkvTokJXjtmIoAJ8LNyFUBazPsKXSNA/UJY
	8S3OzZy16L5FAoUlSh0eCX1fUbu/mrXwFLkgXm3VHEzlvxjBX5nsS92trSUnFUrsXTHxLJu0Bkc
	GnXFHyaWZggjU39yA7s2IHB/VHqpC/pJP0OYuzmcw/WPwN7D7kxvU9jVkdGtG7qfEKVKpgeoTm2
	emWHwiFHUHCKuLJIOk2BllqMxtaH7EJNMw2Set5MKHAl9O1DJE2n4oN9paZ/jrpYlD8N8PfOwzN
	OFgXASKKfgAPJzfsjEeGd0KyfVI/S6/0WAq9HZkA
X-Google-Smtp-Source: AGHT+IFGYzlq+PPNSs3OrQmXqUnxT0HIdylQ9a9U94OGg+zbDXr0tA1fKwH39YYPMJPyqHijFNyP3Q==
X-Received: by 2002:a05:6602:3816:b0:85d:b26e:e194 with SMTP id ca18e2360f4ac-85e137e2951mr401062139f.7.1742398058991;
        Wed, 19 Mar 2025 08:27:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db87797dcsm309098739f.18.2025.03.19.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:27:38 -0700 (PDT)
Message-ID: <f78c156e-8712-4239-b17f-d917be03226a@kernel.dk>
Date: Wed, 19 Mar 2025 09:27:37 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Sidong Yang <sidong.yang@furiosa.ai>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:26 AM, Jens Axboe wrote:
> 
> On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
>> This patche series introduce io_uring_cmd_import_vec. With this function,
>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>> for new api for encoded read/write in btrfs by using uring cmd.
>>
>> There was approximately 10 percent of performance improvements through benchmark.
>> The benchmark code is in
>> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] io_uring: rename the data cmd cache
>       commit: 575e7b0629d4bd485517c40ff20676180476f5f9
> [2/5] io_uring/cmd: don't expose entire cmd async data
>       commit: 5f14404bfa245a156915ee44c827edc56655b067
> [3/5] io_uring/cmd: add iovec cache for commands
>       commit: fe549edab6c3b7995b58450e31232566b383a249
> [4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
>       commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d

1-4 look pretty straight forward to me - I'll be happy to queue the
btrfs one as well if the btrfs people are happy with it, just didn't
want to assume anything here.

-- 
Jens Axboe


