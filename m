Return-Path: <linux-btrfs+bounces-12381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E9A674D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931C51886639
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09720D503;
	Tue, 18 Mar 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nATSPoQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4075206F22
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303976; cv=none; b=r+yaX6gXFW3qz/A7EuK19sOTeyvs6prbHjXN6t/2BTiGWnMO3+WLeH46C9X9t/2q2fv9TSnf19I2JsyeDJchUEK0yyL1dddB1PMKgpzm3iInetAhA6ZaXXW4zHvcAxbLIMHzblD7F3fMnrrZqBKz6DnyCOoEqPMWLFiucNerNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303976; c=relaxed/simple;
	bh=xtVjxeR57GowxzypB8yIQa1TkgnQW6NgiPkaxFWelL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3iXpMaqK0mpTTFV6mPGf1FhI0cleLLM/0rl58Z7eHeF1Vxnl+3vt1F4865UOCzp51GxN4VoAds9wiE015Vx2zYSfua7uhNI9+fGfH4FbphKVAdcOLbam/VBmmc7Wjr+sHaeiosjNR14STh+5EePqA6pqo6rWd1qDWk2a6bvjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nATSPoQP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso103675845ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742303974; x=1742908774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciKBTMhrTNIAwAunPC9pvKe2rqwBVkggfAdVsShdNfw=;
        b=nATSPoQPoJCVuT9r+2PYZ2xWBfqCHjFBcrSjoIjkqBw7j7ghhNj70YxpN9jfYuWCr3
         /7c6loPN/CgRPfT8frJrge0vyTytpKmfs/Q5QfKLq2tz2uTSYUBhgWMa1WKdViT2EfFf
         efxFxqURb7A6ihacqxgvepyL/6eQGwH3TaUBfVUtkHHIdMJB8pcpaXjN0EiIXs40cTOY
         +oQhmJo5pq9ARHxWSU9xO3SbyrjlqpCPO7IB3MOPQrUqnhWimZJmdbDILka85NcshkB3
         Wnht3HH/Zj0o/z8793USFRyfy7FSo2vkoy/Owa6M4u7qKTux33LeWi4lJXNSzQ7aBIY9
         ep2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303974; x=1742908774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciKBTMhrTNIAwAunPC9pvKe2rqwBVkggfAdVsShdNfw=;
        b=hqr7b3TV4zbKES/qchYKQ9pyzjzwj3g4Bis7SiwF9y/qG+mlChm3ra4mzG+p1qn3rv
         roFgRSFhPy/UH0KP+Azmxr5X2kEhe3gd60nOV7eie6mu30kD71dC+v0UIaD2wCn+B/jx
         xMJDVgmBBrezU0Y51oYB7jureH1H8Rn5erboRSy11BPuQGm3d7ISNIUyoxCnb/LrdjMr
         naQCtQWPpbpVdtP9DyHGzntrXvItVKng6vR29Sm29XsXT/sOjjPEuya9vS1EREM4l9RW
         JxQL9jftd2q452yV7I5jHBXiMZ7p9OFBLz+zXyfQXVnB78iWrkh/lBV4lr9Al5e0HQiE
         P9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9GrcI/4XvKdyoNR+EEcnww/Idus6SlGn6bA4wc9qRYMk29xg90QkgLi1IYk7XFV6QRSprPbhvWK28A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxntML/reCBx4bZ8606D4kGn7oeruFoMbIOmXVNRZnItzPvxTg6
	AkLvmPu9poEz84iE3QFO3IYfLhEcYiNjXV0h6JvNpt0XKQFTVEl5uYQIjm3m3TppCy/ffBaPWzn
	C
X-Gm-Gg: ASbGncvOnyv89c8dMJc4hnuA7FKfBTm91/3PE093vOt0Ve4bb/wgaJX5g9d1PLrz7uL
	nYMixS0zBkb9dB+rG4jzJOA3WeBkI0eTPOQAZ83HoRTe40phgEV4G6z+atr59zAHvAFFjJty+Gv
	dGu0cK3GA6KlGGTdMw3YUzQ1altjz2dMxE1tkgIis67o4X+mzgDkznNtPWbAxIT4h3Gz0fUZn4a
	HrJrBW9RIkyN02mvol/zmaaoY17AGHrkpwZCurWdhpYKpP9kiDG0Kczxm5oqOPqewiZ8ofh28K1
	6ff+c2ftdPV8++onDaoNBWdtzNRdXJRKS4jT2g7w9g==
X-Google-Smtp-Source: AGHT+IEGhoTxzsJdPHXpMJwhvk5arIo+nzvTx/l2ZiSw07Z2Knppa9h9oRSci/7G9rCpzmb+KAK03Q==
X-Received: by 2002:a17:902:e801:b0:224:c46:d167 with SMTP id d9443c01a7336-2262c539b94mr53342395ad.16.1742303974447;
        Tue, 18 Mar 2025 06:19:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688d9eesm93737005ad.35.2025.03.18.06.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:19:33 -0700 (PDT)
Message-ID: <17154add-faf8-4150-bc07-57e07b5c9ea7@kernel.dk>
Date: Tue, 18 Mar 2025 07:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] introduce io_uring_cmd_import_fixed_vec
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>
 <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 1:41 AM, Sidong Yang wrote:
> On Tue, Mar 18, 2025 at 07:30:51AM +0000, Pavel Begunkov wrote:
>> On 3/17/25 13:57, Sidong Yang wrote:
>>> This patche series introduce io_uring_cmd_import_vec. With this function,
>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>>> for new api for encoded read/write in btrfs by using uring cmd.
>>
>> You're vigorously ignoring the previous comment, you can't stick
>> your name to my patches and send them as your own, that's not
>> going to work. git format-patch and other tools allow to send
>> other's patches in the same patch set without mutilating them.
> 
> I'm just not familiar with this. That wasn't my intention. Sorry, Your
> patches will be included without modification.

Assuming these are from a git branch you have, just ensure they are
committed with Pavel as the author, and git send-email will do the right
thing when sending out the patch.

-- 
Jens Axboe

