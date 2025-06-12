Return-Path: <linux-btrfs+bounces-14631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605DAD793B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40AA3A746F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA329B8CE;
	Thu, 12 Jun 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1EjKmCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC34C85
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750196; cv=none; b=NP9xKTSaAEcTAR/mU8bFl8MXE5pxBdTK3BU1KdFjwitt4FI3W4llma9XbKazmaNmyngn+Swj9C0qJ+knjPo+QHnuchEDup9LJbh10KvLSZO4qs8obI1kdFrLspyeTiRCwGxhrcrpMu8Ai2MfbLa+gevSJFOdIxzpCGqn3S4THT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750196; c=relaxed/simple;
	bh=mKHho2mFgPdm8x+CzhTwYDf7RZo0YkhLCIkkTGT5y6s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PceuJY0HxClO+xxEfTmQBvhSg3iFRatA8SUT3eLGvcuqkCt1pxALO1y6X00eSRaK2qtsBzj73HWi2yMCZdOd86NHeSvk9UY+LIXPNcxYfysAwhLIXJOmEMoHhrbebG++H9877cM71bjYYKwfQR1JrVPU6IXyX6FtcdRh1K9RwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1EjKmCQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so1970150a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749750193; x=1750354993; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fA2uymrUs+uWUrCA7iFGZ6JZJrx6dkVEm8IGNGfE+c=;
        b=Y1EjKmCQrT3DLVwADnT2VuxgoA7uJrIDeq7vvPtLhz7edanz2VjQdar1IGhnyP6FDJ
         8HF7Xe2GIDK0G7vz5oB+j7IfFAh1vkY6+0z9U4Oba8gZERyRIM2CXZ9SMyx0LmNdYVD3
         yeAYr2jmjbeUfuZxg97ZIDAyjpcm66cxFOtaciOD6m2r2nkOpvgcppfxRhAu0Fe5iXch
         xLNfKPFR0OWyQdLUbpx4jgu8HSjcsArYYthPboWpgR6HAo310vUQxODd1KbidSAz6F1M
         GK+/64RqYRT8y0NeqWbUEIaKZSrMsvQdPD4UBo5hGq2z7u+UoaL7LKOVAtLATcUi636a
         g7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749750193; x=1750354993;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7fA2uymrUs+uWUrCA7iFGZ6JZJrx6dkVEm8IGNGfE+c=;
        b=Ew9nP59BxxVLsnoz92TvTrVSuokke3lpS/bQ9qFvHsf7ROFbRhObfGfN6vwvr1srLm
         InM/8ngUwJZ9XzDosQRr+RbjnV/cx96ijamfpbb73YHr1/8jCz91AxDOzwfa1e9dEWUR
         bBv/F4Fralx5mqHmWSdyx9eCEowhItnJ+zfGX/I6mk6TRgtSpspan/wRqrci6BwWoHpU
         d/OwVjMjicIN2Z1Lxfh/HtVGakOkjR2aDp9RqJ169Yn2/lNHaaCOwM65SHTEEF+pcSlO
         8tRegpaABLSYeDQma63jZz3GecQioe01YQ4F3G8PsXzpBQB4rD57xGXaUr0dnjfL+kY1
         YlwQ==
X-Gm-Message-State: AOJu0YwqrzB+7GX4hlmFQYOELZkTVIjntJPzsfpqG+Bkjqu7G4L9IuU7
	zEpzmjY5W/vF9ZIw2aNuPCecagl2t13p9/2Nt1+Nqv7ZhESQxqVK/WmnuKZts09C
X-Gm-Gg: ASbGncsHPBRICw639g1zy7iF8NvrRJsmaXemefEW+g1pKmxXl/4JN2R/Po0OTldb3Ow
	UTyfHAU31/8152PPmJshHivmIvFB0W5hynFzwQ64IMBW5IAC/rekgB0GRqcXnmnJ79W28Tc2Rcl
	54eBfXxlY0262uuT3hLFuuZinSTWce1mSqSOc11XfuLLgyJupGBpLRbYDP/dlYh7NQVsjSfqpnN
	ud+CL63KwFPtNNzAGzKtCzkArGd+F6h7RPsoyq8QxiLyZrORRlS/NUL298tlUP3u9Vw/EN80gbm
	vr+KI+dzkmcI/DFQsrTiv+VjLw4Rk0TI/5c8zLr+0xRz25G0Ozz+/MR8963Z35RZcy8bw/KEl0d
	ydV3r8Gq8M8ODnPZH8/xxV/rHjW86+xTVHUxMVociQA==
X-Google-Smtp-Source: AGHT+IEiAGc9kLYC8Mvwt6YNnXj6a/8OGcswzf/1I/uLwdrrg+Y/De5udGag57jmCk29uaK8l2axqg==
X-Received: by 2002:a05:6402:2554:b0:606:c5f9:8b0f with SMTP id 4fb4d7f45d1cf-60863aca3f1mr4599792a12.22.1749750192812;
        Thu, 12 Jun 2025 10:43:12 -0700 (PDT)
Received: from [192.168.88.169] (91-246-244-193.dynamic.t-2.net. [91.246.244.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086a551246sm1505629a12.8.2025.06.12.10.43.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:43:12 -0700 (PDT)
Message-ID: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
Date: Thu, 12 Jun 2025 19:43:11 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Tine Mezgec <tine.mezgec@gmail.com>
Subject: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I have a Btrfs filesystem mounted at /media/storage with the following 
setup, that took minutes to mount:

Label: 'data'  uuid: 7e1efcb0-96c7-4e8f-861c-ee3edba3e028
Total devices 11  FS bytes used 40.33TiB

devid    2 size 10.91TiB used  3.79TiB path /dev/sdd
devid    3 size  7.28TiB used     0.00B path /dev/sdc
devid    4 size  7.28TiB used     0.00B path /dev/sdg
devid    5 size  7.28TiB used   215.00GiB path /dev/sda
devid    8 size 16.37TiB used  8.93TiB path /dev/sdk
devid    9 size 16.37TiB used  9.50TiB path /dev/sdh
devid   12 size 14.55TiB used  7.41TiB path /dev/sdi
devid   13 size 14.55TiB used  7.71TiB path /dev/sdj
devid   15 size 18.19TiB used 10.74TiB path /dev/sdf
devid   16 size 23.65TiB used 16.20TiB path /dev/sdb
devid   17 size 23.65TiB used 16.20TiB path /dev/sde

I ran (after unmounting):

btrfstune --convert-to-block-group-tree /dev/sdd
(using btrfs-progs 6.6.3-1.1build2 from Ubuntu 24.04), but the system 
lost power during the conversion.

After reboot, rerunning the command gives:

ERROR: failed to find block group for bytenr 186297726533632
ERROR: failed to convert the filesystem to block group tree feature
ERROR: btrfstune failed

extent buffer leak: start 185256860958720 len 16384

Trying with kernel 6.15.2 and btrfs-progs 6.14 gives the same result.

The superblock flags now show:

0x4000000001 (WRITTEN | CHANGING_BG_TREE)

Attempting to revert:

btrfstune --convert-from-block-group-tree /dev/sdd
fails with:
ERROR: filesystem doesn't have block-group-tree feature
ERROR: btrfstune failed

So I'm stuck with a filesystem in a half-converted state — not fully 
converted, but marked as changing.

What’s the best way to either complete the conversion or revert/abort it 
cleanly?

Thanks,
-Tine

