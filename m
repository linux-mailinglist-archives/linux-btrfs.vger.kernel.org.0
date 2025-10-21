Return-Path: <linux-btrfs+bounces-18086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA76BF43BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 03:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9841A189C03E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9E253958;
	Tue, 21 Oct 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROZaTbP1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D2231C9F
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009428; cv=none; b=IdMvF/7/XEanvjWT5GV9CqR6gniYYv2Ou8uY+/lcSQJ21zN643ANF/9bdt3mAli/Jz1uBgFZbxgurxS1rNw1QFFOR3QnEqluKJ7lN/mN9Ha/IqpcwuQ40E6MsTlYQ3H8LOqDfPR2h/ZocI9haDuzAuqj1Cw2dl0GymHZpKE1rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009428; c=relaxed/simple;
	bh=1zeq0Q49NwqRZRi1E4alBbjTRuUASN/N0O5LnU4lOx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRDOv8DsTXdUuwn3AvLZ2uExwlTwYDY0doKQiVSKNvfy1tHxAoBCW6qeAnB/7FbPhgbXHm2NGvbXHN1ot6JGwOgN9u3utIBheIZZcEOclhZaQFQoLAqfk6s1aa1r+m2rKFIeCwJEQklE+exTMLPAzVSjfF1xwD0midUYPn+5dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROZaTbP1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so6081828b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 18:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761009424; x=1761614224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+jF/m5GxGdkV4M8f/uDqVu8BkqXyzon9JTL3m8pZ6o=;
        b=ROZaTbP1pn6Y2KnIsOPHrzTyoA7Y5eZI6Srq1vdmuQNHzPJXBLHIwCTHESCjTpZRNe
         m/utNBS/cKhxxTn5R/ZcGCGXPiZoqCiMM6g6qt+LmA9/sjMjOGiGWIscgipTTZ/q1YEn
         2L3TsK3jI3C7iTBAaIgyUGkXzOvfSIhz31epbC0TSNFDuJQX4zGgPTbBt5nX4JzLAxVM
         Jp683rCVCzazya4SiDi2YoubHd4XL5hGTaM6wFBnW/8j/QmD5m08TEUfM2xtKbK/4Lzv
         PXWYcAkdMy9cHHk+pBc8TpX9dujskQnrZ7ZKNeRpvGuJf0GAfW86quQjpO52tx5ctS+B
         jgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761009424; x=1761614224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+jF/m5GxGdkV4M8f/uDqVu8BkqXyzon9JTL3m8pZ6o=;
        b=LzozF7lQXurHjPkjmcTcqL54kOKPPzBMscj5OhnkY9LbgoTJEZNne32iKpuBMW45Ef
         /6F7eNhUAR9B6vDkd4lxlIlgLGGGxoMHdNLnxKkylgUuZln2liK10lPjexQdItBos1mE
         9fOWNCcijIpCLDhwDVHnrBMf0CRnGfaxsjl4/QqA3UpUBaVqgVgfofaLNI/UYjgAOc2C
         U1SuIdF1jdJ+GGQ9N/ybcsAVT3B/eoHIijRlZnc3YQvNP894naKQcLGCWHS9Iz7VrZTl
         qrntArgWaTlNvzqqN/4i6IkT6bzZ3Ps0EoDXFCiASFFrfESjSOHPZXAyieJnKDHPPPIc
         sL+g==
X-Forwarded-Encrypted: i=1; AJvYcCURDsIipYn92N7Y1tDPjzypW8MZwyk2Mx+0d2OWkFb7BCO1bn1ZCdvKWyrP3sxMD4HxITUP9rWGZQwV9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIh77n2Spmh9o0RZwlvx8bHya5/WXoXpyKLYUemPJ8+wPH2NuW
	OwrxoAkr84kdJAmBGmzJlsIrW0l9V64z3XIptQ01RUEoKklWqtZGcPMA
X-Gm-Gg: ASbGncugx1QTfmkgvlggXjlaxjI5uG2b4mf5JJJgH8GMjX1sIjD/I0JkdD15FMLMzw2
	HfrnSfjuKiptbPgaOicPISGcjPFTAEnFPh9MMMrQ99rmxGcb7yQLcokiaNrF2Ndm59kdSd4Gn45
	+kj4WIXNI8zZf54I0SkAGWGB5P402kKzkz5fjjtNHlpFpyOkn/03ZHWBzUc/+6Xl3bJOqTuSZok
	hm+mr6xgtfrg7zaz65unZ8MfYsV8h0uK8s1GtdzFkENfjGY7Uhwi4eYJPSXYBsl9g2MBhTl8qHE
	LfWN5bGxYDy/MehNDl4Uxr7+k/os6rH6ovcdGZJbih7xKxQKmu9730ja2tXz3dadNHBVywejMr1
	3mD/UgaiSRRAJywpgd1Q084Onl/iyzcbMSp/vCYdVB8KG0J0cFgs+D8C4ju7N8OLeNUsYwGGQ4Y
	8BDF8nJD+gO2jkqLgTDxQTRVNx6sg5A82kd0pVOfTU52ChuAnvS6C/l7AI74nq4Uq8/Bfv
X-Google-Smtp-Source: AGHT+IFz7BMEyiUbDQVbe7h7z/q786244belk8+vOd3hqwr5CAeeHL/XEJmuhApsPJjkKQZ+v/uU9A==
X-Received: by 2002:a05:6a21:7914:b0:334:bec2:5b63 with SMTP id adf61e73a8af0-334bec25e36mr9995666637.24.1761009423608;
        Mon, 20 Oct 2025 18:17:03 -0700 (PDT)
Received: from [192.168.50.88] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34e72sm9658662b3a.24.2025.10.20.18.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 18:17:03 -0700 (PDT)
Message-ID: <195761a4-0251-4e9f-a896-018ff20e1643@gmail.com>
Date: Tue, 21 Oct 2025 09:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
 <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
 <aPas60j7AoyLLQK0@dread.disaster.area>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aPas60j7AoyLLQK0@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/10/25 05:43, Dave Chinner wrote:
> On Wed, Oct 15, 2025 at 07:46:34AM +0800, Anand Jain wrote:
>> On 14-Oct-25 12:39 PM, Christoph Hellwig wrote:
>>> On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
>>>> Some filesystem have non-persistent UUIDs, that can change
>>>> between mounting, even if the filesystem is not modified. To
>>>> prevent false-positives when mounting overlayfs with index
>>>> enabled, use the fsid reported from statfs that is persistent
>>>> across mounts.
>>>
>>> Please fix btrfs to not change uuids, as that completely defeats
>>> the point of uuids.
>>
>> We needed cloned device mount support for an A/B testing use case,
>> but changing the on-disk UUID defeats the purpose.
>>
>> Right now, ext4 and Btrfs can mount identical devices, but XFS
>> can't.
> 
> Absolutely not true.
> 
> XFS has been able to mount filesystems with duplicate UUIDs on Linux
> for almost 25 years. The "-o nouuid" mount option (introduced in
> 2001) to bypass the duplicate uuid checks done at mount time.
> 

Damn, I completely missed the nouuid XFS option. My bad!!
> XFS tracks all mounted filesystem UUIDs largely to prevent multiple
> mounts of the same filesystem due to multipath storage presenting it
> via multiple different block devices.
 > > The nouuid mount option was added back when enterprise storage
> arrays started supporting hardware level thinp and LUN
> clone/snapshot functionality. Adding "-o nouuid" allowed cloned LUNs
> to be mounted for for backup/recovery purposes whilst the main
> filesystem was still mounted and in active use.
> 

Agree. Also, in some SAN error situations, the same device may
disappear and reappear with a new maj:min.

>> How about extending this to the common
>> VFS layer and adding a parameter to tell apart a cloned
>> device from the same device accessed through multiple
>> paths?
> 
> Perhaps we should lift the XFS UUID tracking code to the VFS
> and intercept "-o nouuid" at the VFS to allow duplicates only when
> that mount option is set?
> 
> -Dave.

It looks like XFS (with -o nouuid) and ext4 allow duplicate
FSIDs to pass into VFS. We may be able to extend this to Btrfs,
though there could be conflicts with fanotify? I'm not sure yet.
we still need -o nouuid, to alert admins to handle cases where a
device reappears with a new devt. I'm digging more.

Thanks, Anand

