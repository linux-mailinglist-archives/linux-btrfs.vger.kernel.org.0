Return-Path: <linux-btrfs+bounces-20037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C4ACE87C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 02:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3411A300E7FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A41B0F19;
	Tue, 30 Dec 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+h+3iDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E375231832
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058204; cv=none; b=rv8EwVH0oaTxxyAlvC33WIZfjXufqbDO3Aq8TsqwNVJlGgdW4zrc9sJbmthLAwoDOH3RwxZvyW4eVW/56dXWeIKjiAq9U1j7fWAn+STyLL/DWz600yQM3SWr9nyKSFlLrtLKqQTbjRlobcaCtAPrdFDOpYxDMBGjVnmN0hYEiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058204; c=relaxed/simple;
	bh=/grC1EAByxACj97CSCu4GMykmktEULfMjB5cAgTCFXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNV+/aFAAlwNIa+7HdCeIEAitiaNWulz9bLtwimDRoHPm4GmQw7L3oiqfxTJwhDW9mIwgoR+kgYorlN7A146Bfa7IT1FqxnNd6/dTI2xclCNFq2U6plhwElp/KftasTPsXawsAVS3MQdoej5DkgTsSMi5V8fW9ThCm/Uo95yAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+h+3iDi; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7f6282195a9so624509b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767058202; x=1767663002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FM3iUtVLYhuc6CnAKbHnjnjeheiDgrqCgwEIJFIe69U=;
        b=X+h+3iDipVZZgWQhHHvPkDxKlarGDBWZ26tKKXZPsfvwAZTt5oYKFgRuSpy0umqIQP
         NWwJu/B8z9Has73g7AYL+UXU0Hr6F0nitfZD2aHdnDyeLyN7qmCqO38WGxwQsMdoSA8P
         za2pDYN5uq7AgUwSnGKVnwqReNkDjd4b08SOUHwOFyTZFDXdnXlnKlrqRLy93lfp/Zml
         XiiQ6RVMp/KJ3dAvjqyfoSIodZFpQXoSuzuYlKtFn98ByWhRN6eg2zi1llCDUWoArdBO
         UQYEA+nEJmKbTDmDuMb1h5ait8gP0UUQGSasHQAnzOot7ICPi1RCFYgYhqi1s71UBPIm
         6S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767058202; x=1767663002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM3iUtVLYhuc6CnAKbHnjnjeheiDgrqCgwEIJFIe69U=;
        b=gOkgoHTi11fAtgDb8yuZgLQRcfWf2WCusXfR8UEGABR3lTzlhZ2f0aedOxUXvcDCQs
         fJQo0xsfrzBjaJptObhRUM5rynbNXBhK7zZU3q7AABqopJ4qkUxfbKFf4uVNicnI5QnS
         bvFK9Z1D1DYCs5StgvfaqbHRYRJnv7wJvxM40Oe0Z9MQNomayKovvCrLI9Kz3QzYiUHw
         b0lSFULcM7BhFVWtVpEn+sFQDzMw5MPdRzXVzZ3vnzqozR6jx1zHKgEkzDAOuWCNnc4/
         Qy8E32QYoDKqaRNyfZW8o6tz4zw5YWpA6fhhntw/HRle9DtC9JIxrrS0bUN5OVErjK0s
         /e4g==
X-Forwarded-Encrypted: i=1; AJvYcCU5Uo9crCW53K9tntYI7u/RQUmFVH+NvkHFlYPc2jUQuKMm93O5b2fzPeLJTYuK7McdNUqF/vwdGj/YHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoyC5vWU1ufGU6ZRKvMGmdumXe8sFb5Vo3f92zQclQFYjDrMOl
	JNKP6Hq3Yjh5Z9+sM+VvBlIIYrrSIuBUJnCzrgfSYUh+i1Uo1aQgT1up
X-Gm-Gg: AY/fxX5DTkoZxsKHQywLxb3vJ65ORndWgp/f2gxX8kaeV+oapKnqRaAhVrW6kZnOsfG
	bsUL2o8z3+lUjFgqCrxKuwGiwUMyB1+6Gfq9T5P9qwhdI3TlJJAOSpgWzusAHkfl2Qztlro2Ujx
	I8m8snI62gJ4MD+eb+189VGiza4Gpjlh9IVb4PyqEEuIcEYd56++C8y0GxVXoB0girGn1o/KWiL
	kECuYNUxa3EXE7MSIvM+PFnzE8BTEzGz+krNV05nVBoeeWMkSecrh+AYNmKHOJ9BFd7sIwn7Q3E
	daBPfHQ10GH/nJ+PvY/4wW351ZkFb8YW+pfo61Dzd5yQwR21V3Qu1ulyCDYkQIjrj74gAyMIZjC
	fNLtz04QZVNi464ZBs7oG0KsJKSn7AYJBIFf6CLCYZeJ/jx9cjgmYsgJv27PmBciPeprSkhtkDt
	2QfB4vkgu0O/PEaT/lblqpnGZrYum/B0U0kcU=
X-Google-Smtp-Source: AGHT+IEL6tfuUaV64bmvu3kdoE/42VY2n+9Tozu6caJDCPMk9Gamcr6ab92tSB+SijVZWRvxquJzlw==
X-Received: by 2002:a05:6a00:cc5:b0:807:fef2:b2f6 with SMTP id d2e1a72fcca58-807fef2b43amr10340553b3a.0.1767058201797;
        Mon, 29 Dec 2025 17:30:01 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm31214773b3a.45.2025.12.29.17.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 17:30:01 -0800 (PST)
Message-ID: <b23c8a4c-7945-4d49-8f1a-2687e2d7aea4@gmail.com>
Date: Tue, 30 Dec 2025 09:29:57 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
To: Boris Burkov <boris@bur.io>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
 <18e6a584-b6fb-47f9-b526-4e97798052a2@gmail.com>
 <aVMWI7bVCZX4RAAa@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <aVMWI7bVCZX4RAAa@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/30 08:00, Boris Burkov 写道:
> On Fri, Dec 26, 2025 at 11:07:28AM +0800, Sun Yangkai wrote:
>> Hi Boris,
> 
> First off, sorry for not replying promptly. I've been in and out of the
> office around the holidays.
> 
>>
>> Thank you for bring such a feature for btrfs. I love it a lot and try to enable
>> it on my machine.
> 
> I really appreciate your kind words and your interest in the feature.
> Thank you!
> 
>>
>> But I've get into some unexpected behavior when periodic dynamic reclaim is
>> enabled and the filesystem is nearly full.
> 
> Oops! Let's debug it :)
> 
>>
>> [12月26 10:41] [T20373] BTRFS info (device sda): relocating block group
>> 5214541578240 flags data
>> [  +0.012446] [T20373] BTRFS error (device sda): error relocating chunk
>> 5214541578240
>> [  +0.000033] [T20373] BTRFS info (device sda): relocating block group
>> 4540021997568 flags data
>> [  +0.008927] [T20373] BTRFS error (device sda): error relocating chunk
>> 4540021997568
>> [  +0.000025] [T20373] BTRFS info (device sda): relocating block group
>> 5606746750976 flags data
>> [12月26 10:42] [T20373] BTRFS error (device sda): error relocating chunk
>> 5606746750976
>> [12月26 10:47] [T12072] BTRFS info (device sda): relocating block group
>> 5606746750976 flags data
>> [  +3.960400] [T12072] BTRFS error (device sda): error relocating chunk
>> 5606746750976
>> [12月26 10:52] [ T7643] BTRFS info (device sda): relocating block group
>> 5606746750976 flags data
>> [  +3.960314] [ T7643] BTRFS error (device sda): error relocating chunk
>> 5606746750976
>> [12月26 10:57] [T20373] BTRFS info (device sda): relocating block group
>> 5606746750976 flags data
>> [  +3.954485] [T20373] BTRFS error (device sda): error relocating chunk
>> 5606746750976
>> [12月26 11:02] [ T7701] BTRFS info (device sda): relocating block group
>> 5606746750976 flags data
>> [  +4.561796] [ T7701] BTRFS error (device sda): error relocating chunk
>> 5606746750976
>>
>> I guess the condition of when the periodic reclaim should happen is unpolished.
> 
> Yeah, it looks like it is triggering too frequently in conditions where
> it isn't likely to succeed. Hopefully we can tune up the heuristics (or
> just fix the bug you found) and it works better.
> 
> It seems to be triggering every 5 minutes or so, right? Is that the
> interval of the cleaner thread running on your system? Or am I
> misinterpreting the time stamps? I would normally expect the default of
> 30s.

Yes, my system has commit=300. It was set years ago when I knew almost nothing
about btrfs and not changed since then.

>>
>> I'm still digging further into it.
> 
> Were you able to confirm whether that negative reclaimable_bytes bug was
> the root cause here?

Yes. After changing chunk_sz to s64, this will not triggered anymore. However,
periodic also does not work properly.

> If you aren't able to reproduce but it is still happening on one of your
> systems, we can try to instrument the periodic reclaim lifecycle with
> bpftrace to catch calls to the various important functions setting it
> reclaimable, etc.

Thank you for your advice. That's what I've done and how I find the unexpected
behavior. It's really a good tool to know what's happening in kernel.

> Please let me know if I can assist you with that, or if you do have a
> reproducer I could also look at.

I've redesigned the logic and iterated some versions. I'll cleanup my code and
send the patches later. Maybe later today or tomorrow. It's not perfect, but I
hope it will be better than what we have now.

Thanks,
Sun YangKai

