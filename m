Return-Path: <linux-btrfs+bounces-12264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7CA5F729
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 15:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A7A19C24F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11261266B69;
	Thu, 13 Mar 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p+TXWiZM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AD70809
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874480; cv=none; b=TVPp2/Oq7+N48O1oVqB1E4o0dbfNKysB378dZrDk+23+/ZNCOOj2U+nvBW9NWlnywicqLMwNj2X4UadEjPIcfefAwF3yvaqHa5d8Lph682Z+4RDIiLnsvxoCkryanPeL/Jbg8tBWQPTLb/1wCmDtHy5OLbmi4f1QEsY/RejlCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874480; c=relaxed/simple;
	bh=oKH7Elamr+t/LNBhDFaCjq8k3Yhh1qOu2+6iErHVUsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sV9H2w+oV0wiKA8sURtQBuFGv/dkbTLctl1uxWmeBE2Q4khFK5z4rNnXN4DTqYA26ZSnMZLFlwI+6bC0tlLdz3EUg5bOjmfur3fhUZvBC6PWePoUG+1Fq7ipyo+9SVroe1tKAFB+0mW2QTUIEHDxFG+8VsCCHv7CqsWyUwcJSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p+TXWiZM; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85db872dc75so53887539f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741874477; x=1742479277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDdThx9JUgAoiyQ7U+14OO8Q3xFSMds/LhAjusQXTgE=;
        b=p+TXWiZMTo1ccrCIfpXiRSLOKVeuqEjQzc2yy5y3GKljD2dbKVZHiLRVJE94abI9XX
         rjMnCmu6TXd1LRA+2jlnyDzkLvj8vric9AL9a9RhVMHE5lL9i6T3ZJt/HupHFdz6P2qE
         MyOFszdLRy2wilPtY7rBgJjGdvZv13VOQK45YML8Tcqu8H1ByIttR3mSY5lF0HQRbXoc
         Qscc5STMQP7Yz7E+VJKc7XGOXa8zOJva29dBjIrWD8KKMAO/z5u7GU39uSw06vSFhKc7
         yOXZuq+yh2ICuptKYK0CnRKtWAHqz/WqZZ4Uei+qEDHGlZg6NnfxXaT25qTK+07ACvyw
         YN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874477; x=1742479277;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDdThx9JUgAoiyQ7U+14OO8Q3xFSMds/LhAjusQXTgE=;
        b=boekQIfCTuKc2RxE35/rdri7S7UmDTIuEjslBX4z2VqKLxvGcfHy5TLvh3UzomoOYk
         HCdtXJb0+WuwxyB+aX92ht/DVUucLZ0iJDtR+03IORn27agYR/MxlMmEoIK5Bj8Pky0I
         fuVltcrf/CgJpiwRTu3VQ338L0CEikpzIZH3C/qH/QVbIe6H5Cd1PL7kqjPsYHwmTVgP
         F7jLWRTfoITONYlVZe939PXSn6+zS0lBaTkBz3QWhtgC66oS6ShEhDEABPSLiEIoAwC7
         mKiUXk+NclskJTIG9FeWM1t2rkixOcUsuhrDb1POu6lNWL9R176DtPS4GaqwGRZ1D16s
         cQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGr3VTjZoZwgbX1qwwzo3y5HCLd2/QQfxqoY/9yQm3X+lxVcIFLNpEYhXfT1pLocz2PYLYjW7j8jZiCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfWbJGFbp/whppHaHeGUvL2/+qxvtnZNVIzvIPBOvt7UX9Taa
	wGxcZmbg0f0Tq7S6jk8wBzQU50CLRIHXr8KXXr+ZBQTfkcZNYUqn7X31j4VQp/Q=
X-Gm-Gg: ASbGncsBby+/BWdiQJOxJsTL5iWgBG14wONz4MWERTc4x7ttkNluL3/wjpJcxb9tf9F
	oYJUxeYn0gDLU9BSryaorH1MSR9vn/MCFjRRc+P6lUepPwRuK018cjqqePd+ovn/Upg700BP9pr
	eS6Gfe3LDPy6Z11XMlQRwF4hiS8wNd8LIVMJLmo+bYD5rWOlvda6x/kJILsUglPhxvdZeb0lmzX
	C0xZT/PWSWaP0uo45PWilbTaU0xiUOGK8sTeNDctNTYTPySwA0t74oIa4ADzyEpfRRyWxZNf+NZ
	tUf5kO/+x6s0z4V6jBJAT+x9nPK1yW6R/7d50PLi
X-Google-Smtp-Source: AGHT+IH8vt8kGcYmo8u1W+6aiVlKe9rMFhsAav1CA7QhsLQdsuy10Ep5nNiDNFdUkL+dAak9/7QM2A==
X-Received: by 2002:a05:6e02:1a24:b0:3d2:b72d:a507 with SMTP id e9e14a558f8ab-3d46899ef10mr119104955ab.19.1741874476689;
        Thu, 13 Mar 2025 07:01:16 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a67f5d5sm4164385ab.41.2025.03.13.07.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:01:15 -0700 (PDT)
Message-ID: <ab277f0b-fdf6-4f20-9fe0-0e0a1ebcc906@kernel.dk>
Date: Thu, 13 Mar 2025 08:01:15 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
 <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
 <95529e8f-ac4d-4530-94fa-488372489100@gmail.com>
 <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>
 <Z9Lj8s-pTTEJhMOn@sidongui-MacBookPro.local>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z9Lj8s-pTTEJhMOn@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 7:56 AM, Sidong Yang wrote:
> On Thu, Mar 13, 2025 at 01:17:44PM +0000, Pavel Begunkov wrote:
>> On 3/13/25 13:15, Pavel Begunkov wrote:
>>> On 3/13/25 10:44, Sidong Yang wrote:
>>>> On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
>>>>> On 3/12/25 14:23, Sidong Yang wrote:
>>>>>> This patche series introduce io_uring_cmd_import_vec. With this function,
>>>>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>>>>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>>>>>> for new api for encoded read in btrfs by using uring cmd.
>>>>>
>>>>> Pretty much same thing, we're still left with 2 allocations in the
>>>>> hot path. What I think we can do here is to add caching on the
>>>>> io_uring side as we do with rw / net, but that would be invisible
>>>>> for cmd drivers. And that cache can be reused for normal iovec imports.
>>>>>
>>>>> https://github.com/isilence/linux.git regvec-import-cmd
>>>>> (link for convenience)
>>>>> https://github.com/isilence/linux/tree/regvec-import-cmd
>>>>>
>>>>> Not really target tested, no btrfs, not any other user, just an idea.
>>>>> There are 4 patches, but the top 3 are of interest.
>>>>
>>>> Thanks, I justed checked the commits now. I think cache is good to resolve
>>>> this without allocation if cache hit. Let me reimpl this idea and test it
>>>> for btrfs.
>>>
>>> Sure, you can just base on top of that branch, hashes might be
>>> different but it's identical to the base it should be on. Your
>>> v2 didn't have some more recent merged patches.
>>
>> Jens' for-6.15/io_uring-reg-vec specifically, but for-next likely
>> has it merged.
> 
> Yes, there is commits about io_uring-reg-vec in Jens' for-next. I'll
> make v3 based on the branch.

Basing patches on that is fine, just never base branches on it. My
for-next branch is just a merge point for _everything_ that's queued for
the next release, io_uring and block related. The right branch to base
on for this case would be for-6.15/io_uring-reg-vec, which is also in my
for-next branch.

This is more of a FYI than anything, as you're not doing a pull request.
Using for-next for patches is fine.

-- 
Jens Axboe

