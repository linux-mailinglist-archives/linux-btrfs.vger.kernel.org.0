Return-Path: <linux-btrfs+bounces-18328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A52C08E92
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3A644E6E45
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF092E7F1E;
	Sat, 25 Oct 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOQzZE4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984532E7F00
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761385788; cv=none; b=PAMx4Mj41619QX6uFDbvvt1Wc/UgwsaEeDQVOh197ty7GxeVqUiSv/MtMht9RZSrZEclyx8wOOtE1IyGXHU35DwLoysv/KTr6+AZj5+msMnO6KVyJCojHTl84mFojRUBRc4oVYn7tnd4+Ak2NgNGC0uax6trsVT2km2NkXxSekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761385788; c=relaxed/simple;
	bh=KYDbvM5SlKINN0ZRd2iObH++vvfW6rGNqCv0yERtWUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWT1X6IXiPp/EaivG3DylC5vJLUbvTmnUcd2yPtwEJdrWwwQ8nUYbcLFJ9hjCmCLHiiynyzgQTnXDzZd+sIgKPdylIoiyK62JHkJMMkx+JAN8y3VK7Hw7XhbzOdbWJv/M88T+bgBHshBw9QX0/oXeXQBgEBBrpgnbggh8JmDlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOQzZE4d; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f22b1e49so2647870e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761385785; x=1761990585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/PzYa41ebeg2IQuTqJ8Z3lhmQsqFYYMGmG2oqsguY=;
        b=fOQzZE4d2LTl05O5cPnuqhl4oHGKku677tzpUvcF/dHqAUZV7661CbbnZowd8k4n8m
         n8WEA/xMJRklXxpb3ob8MZ7V24mbvUNdEKh5cqumxwlQvPU1bdHbnkMNoGmuB49esT65
         PliqnD8mCKbIREAUh0RHU2uDhDRSsqOFqeMrL+BaB/I7G2uq1tLX8lkKvBZos684WshV
         +18cZEVEWj6Da/zpCLA39K/cp4tTbRe2c5YVGbYE/3psA8MtMRsoKNrS1sohDuSnnBdj
         PkFFYERC4hoCel/0zKP4pSkrVZUpE9x5UI3RRDZduECTBYniHDdIF301NOWLBdjVbQFx
         zZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761385785; x=1761990585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/PzYa41ebeg2IQuTqJ8Z3lhmQsqFYYMGmG2oqsguY=;
        b=Zbgyxi890Ek8mqSmW6raTNNApnBKcL9iNnXiPFnimuhobpLh0EeMwrxTWkp0N5LcuJ
         ksBJB8RNHZ4tJVs24gHL+Hj03VB49svBsZnMvC6gKrRP8pEixpTujyEyLg3tDDGLrAR0
         gglsYjMlWksi1CVOBfgDmQG70cPcX3T5jIg0Xr8own+tnAvhvPz2O/2U/A7+Y6vxOlMj
         18VSmIxhPVdrm/iig+8/ZodqNYoGLnF5MSlNGZSCGJ6dPa4jNSKbarU4UbvF9d8ymAuj
         Hv6ik87KThT7at+hbbepgChKoMbW0D3bVu534cni46EKxvf8VR3+XViuwbQqmjy9asW6
         tTrw==
X-Forwarded-Encrypted: i=1; AJvYcCVH7h3l9jqcUr7IH9fo+ExGIlPWjIEYOzf8NcTLWVKn2Hy6mjPlJaAdmRPjUqdILSuEWXz1m2dlMBN4sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPXels1qRn8Xv0EzVZtAdTF0D+YY5n0b+aF67OZ12Y+45vZ32
	i9IUBS1doYlzMn9JfgHwcdCFYthHTAmndnNSEeE0+qqFvvtVviQOdDTVp7KZK4OB
X-Gm-Gg: ASbGncs9+m0LqAT35cbzLtVHRdJvbRKkLK51G2TuH3GMcZlBa1ngZ7LjJEMgMG4m3N/
	QroUPS4xoWIb0zIQb0rKotVQ57I3LPoFYgvqY4g0EUSpIDqqWUBWVFvDHv6WIn17Mb78NcvNZ1z
	x1eHsTKuh2FutblMmsExSYwV7DmZfqfPdm2N/eEiN58fjckRY+5Alb9OUUpmZQs3h56qx4d4Apr
	ouP/rOhLK0eZJJr0fW0teilTNWY7pB/Ym7wGzUTaueg06jUdUvt+l+WXc9oduGhBX4R2NHCL8Dt
	WsxhlhjrJYzB2pumfJyd7tBcd/Ou7M4w7CzqYvh3cxDxgNSnJljvrYd7WUqYVXgZmwqE24WCm3v
	lTeKr/33zNd48Bit6LNIz/RcWP0KgOQnabHr+RZZkc+92Ojg3V4LCc3/yOo8TrvZeL3+ROPIvQi
	xU4JbEnfKmxHVAP+xjbeOrB5s=
X-Google-Smtp-Source: AGHT+IFz2eCZ1bYR4MTJHMLuCeHea8GqXuofX6wmBkcYcRIU8v8aPGRsyg+mqufS9R16ARsBnWvB5Q==
X-Received: by 2002:a05:6512:3da1:b0:585:3109:bb93 with SMTP id 2adb3069b0e04-591d8564b51mr10825324e87.55.1761385784413;
        Sat, 25 Oct 2025 02:49:44 -0700 (PDT)
Received: from [192.168.88.251] ([188.243.183.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f81c1asm521297e87.99.2025.10.25.02.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 02:49:43 -0700 (PDT)
Message-ID: <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
Date: Sat, 25 Oct 2025 12:49:42 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Directory is not persisted after writing to the file within
 directory if system crashes
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
 <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
In-Reply-To: <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2025 19:17, Filipe Manana wrote:
> I converted that to a test case for fstests and couldn't reproduce,
> "dir", "file1" and "dir/file2" exist after the power failure.
>
> The conversion for fstests:
>
> #! /bin/bash
> # SPDX-License-Identifier: GPL-2.0
> # Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> #
> # FS QA Test 780
> #
> # what am I here for?
> #
> . ./common/preamble
> _begin_fstest auto quick log
>
> _cleanup()
> {
> _cleanup_flakey
> cd /
> rm -r -f $tmp.*
> }
>
> . ./common/filter
> . ./common/dmflakey
>
> _require_scratch
> _require_dm_target flakey
>
> rm -f $seqres.full
> On 24/10/2025 19:17, Filipe Manana wrote:
> _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> _require_metadata_journaling $SCRATCH_DEV
> _init_flakey
> _mount_flakey
>
> touch $SCRATCH_MNT/file1
>
> _scratch_sync
>
> mkdir $SCRATCH_MNT/dir
> echo -n "hello world" > $SCRATCH_MNT/file1
> ln $SCRATCH_MNT/file1 $SCRATCH_MNT/dir/file2
>
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
>
> # Simulate a power failure and then mount again the filesystem to replay the
> # journal/log.
> _flakey_drop_and_remount
>
> ls -R $SCRATCH_MNT/ | _filter_scratch
>
> _unmount_flakey
>
> # success, all done
> _exit 0

I think the line with `echo` may not be the correct translation:
 > echo -n "hello world" > $SCRATCH_MNT/file1

In the original test, the file was opened with `O_SYNC` flag, if you 
remove it, the directory will be there when the system crashes. I also 
forgot to close the file after the `creat` call in the original test, 
may be important as well.

The test itself is quite weird (why would `dir` be gone after seemingly 
unrelated operation?), any detail can matter.

Please run the original test with a real system crash. I will also 
double check everything on my side.


