Return-Path: <linux-btrfs+bounces-18380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217BC13761
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 09:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63D68547C31
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADB2D739D;
	Tue, 28 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z1S9ASVE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4224E4A8
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638787; cv=none; b=CzA9mp8+Ny6/X/0VRi4buZ1OU8TQLdsNUF5ok69m6yGIYrBBYvcgVrLA4nWzj/jeGHjjPszsYrAp7S9Gf+FBlD+w95UM7p6SYVIlFFVDmM0i8AFqiPDr73jgMr8UnZ3KMZL2ZDTjzvP089Q4QoGeCPwaTggyV0WKdxeyc0HlXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638787; c=relaxed/simple;
	bh=g1P6cQpGTmAt7T00edJcViaF3mXzPxMRR754WeoryXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPbftcYi7Gxg89JTOz43MLQbl7K7c2e2HwCPuoDPo84b5S7y/MT4p13wyfPiZpP7S9UhFFQFVa9tJ3wIQJjZNL7t56qrWK7RB67m0CdA2VsNw8NENDTWQeQ5emE+mvcE+eR0igVe+jk8LM2iKlydN5qUGFeCwOIfYKLHUImZRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z1S9ASVE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42421b1514fso3959813f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761638784; x=1762243584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d49qfBTvJpDphrP827FIf1FZ7LzD+w6W6hgcnykOGzk=;
        b=Z1S9ASVElw7nZCvUr5NaVLkEsoZUFSZvLmhxKZpAy0Q5lmik9GE8ZSOA7PvaNCzi2z
         WfLJKn/7UhQ+hUU0A+kmipRKY7hUhUJ4m3VtTelZgLAvHR6Iy19XRHtm1MLgRcYzasj/
         /sCToCx6gViXmyGjLlwdqyEHSbTHJr8Jjaphm0KZ15FkATUPCoC6B46g2MDBPIwgQZZN
         fvwHfkXnM24QjWmvmVzaMgPIOGC0MJUHm8o7yr+4RO2yeEJRtfm+mQP0JXZDyQ7r7hq6
         PKdHyaT3Zhy5A8yvPebS7LC1zha2WjNGmgYnsXOu5BWI36ArqmcFa3oKCrhFlV8acdvB
         +7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638784; x=1762243584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d49qfBTvJpDphrP827FIf1FZ7LzD+w6W6hgcnykOGzk=;
        b=qbqaqDpAUbHm01lmzcn9C6ni8LQcm6teYCTrUnKhGU/Upz2Quqns/t/dGMLrXmP0vz
         NdB1ps2vheCysXn8gkl+f6Ji/GJUgaQE013RYNW4/hPRpSyjZiTQtTJEBzdP0v4OVnuo
         HvqXZo2/fv4TdPDI+Wkd8NCPZa8kkH9emBfV6ajcO/nFF57fxro03KfjE30iSxbYuoln
         2kAddxAuUEn2UJ30j6Mv41ALIQ119H8vNWah2f2pCzZJdkSfDCXFLdD/Yt8owUMgCXXf
         qUl0aYSLKZ5h/whIhLY31B8egs8YKIx3Z8ZwEzPzXIVhEvqSxQ7xIp7H5URjXKEKNVLZ
         Rwbw==
X-Forwarded-Encrypted: i=1; AJvYcCVD3vQSazOkRRvUDPVcIIarzMwWltyXRCnWHgYon0SJw4MoWwNG0l5kwIsb60v45iMte5cgLyLH7eCsRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13mcP/4IpaWyHWBzjn+6J+V3Q2uwlALhkz55XjpFUNqT8hlV7
	NXz1qTbGcGHA2b+OO4U3UK0y/dJ3P1euUwmKru3CVRZEnkx3YsiM20j7jxQAF+yPn8I=
X-Gm-Gg: ASbGnctrIk8foIIWgenvY/btHYsjIbxVtn6MWCh9WSfmGswAPOqNL5RkxQh3l/jw7rJ
	7Wc6Xqfbdr9IUFw4AYisnnZQs7WxNsinENJ71UTA2Hk4Ak6zbLzyLTibBiwxUGhFOGInOxCuY4i
	CcZUrMfV3UQe3luX3TygDdG1KOhAM5Edn4pkfbQFDKdcjzOkcnLnqfo1o/wynrVbT8rpfeBR+48
	ff+KjG/mGaoEgliwND2v8CCVXnyUUyO4s3Ch4UawuMBb7EkGnzvt70YlP4oyImkBSgF6H+R+7Yb
	UjgeUX/3OZk+Va0R6EQVq2JSrWY3+B15VjU23tNs4LSDKeU8IoMNDcNAzMQ9nTcFPfdE98VuUFd
	QLqASZzzmsHdtCHFz4RVEO3IwujgUNlDcLAsPsRSVreu3epHugET1pJw3ZCfZIGg+ub3rsMm1iB
	ODDDf0kAlwBgBAWiEGohbThukdxWTeV13B8ld13GnvG15+85PnkLQsdf9vDX7xlDQHyxD+wLov2
	V0LLHTtXgP/SrSA7w4msizK
X-Google-Smtp-Source: AGHT+IEZeb5K/wNFOst15sMqVX5NjO8WdtQ0MPwYYPcjOZiy+Zn9drb1J/s6UUuP77ispLtRkH1jLA==
X-Received: by 2002:a5d:5849:0:b0:429:8c4e:b0c8 with SMTP id ffacd0b85a97d-429a7e577a1mr2535564f8f.27.1761638783464;
        Tue, 28 Oct 2025 01:06:23 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a86fsm11202740a91.1.2025.10.28.01.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 01:06:22 -0700 (PDT)
Message-ID: <124eef27-79d1-40ec-9f54-f94509f904fb@suse.com>
Date: Tue, 28 Oct 2025 18:36:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <202510281522.d23994ae-lkp@intel.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <202510281522.d23994ae-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/28 17:49, kernel test robot 写道:
> 
> 
> Hello,
> 
> kernel test robot noticed "xfstests.btrfs.026.fail" on:
> 
> commit: d72352d1c3a3a201dcd3684b05987f281b1d66aa ("[PATCH 4/4] btrfs: introduce btrfs_bio::async_csum")
> url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-sure-all-btrfs_bio-end_io-is-called-in-task-context/20251024-185435
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> patch link: https://lore.kernel.org/all/44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com/
> patch subject: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
> 
> in testcase: xfstests
> version: xfstests-x86_64-2cba4b54-1_20251020
> with following parameters:
> 
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-026
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-14
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202510281522.d23994ae-lkp@intel.com

Unfortunately I'm unable to reproduce the failure here.
100+ runs no reproduce.

Thus I guess it may be some incompatibility with the series and the base 
(which is for-next branch, not the btrfs for-next branch).

Just to rule out the possibility, mind to re-test using my branch directly?

https://github.com/adam900710/linux/tree/async_csum


 From the assets, the dmesg shows that all data checksum are zeros:

[   62.192305][  T269] BTRFS warning (device sdb2): csum failed root 5 
ino 258 off 275644416 csum 0xa54e4c94 expected csum 0x00000000 mirror 1
[   62.192397][   T12] BTRFS warning (device sdb2): csum failed root 5 
ino 258 off 275775488 csum 0xa54e4c94 expected csum 0x00000000 mirror 1
[   62.192470][ T5037] BTRFS warning (device sdb2): csum failed root 5 
ino 258 off 275906560 csum 0xa54e4c94 expected csum 0x00000000 mirror 1

This means we're running the end_io() functions before the csum is fully 
calculated.

If that's the case, it will eventually hits some use-after-free at other 
tests, which I hit too many times during development due to incorrect 
wait timing.

But I'm only seeing this single report, which is pretty weird.

I hope it's just some bad code base.

Thanks,
Qu
> 
> 2025-10-27 23:06:41 cd /lkp/benchmarks/xfstests
> 2025-10-27 23:06:42 export TEST_DIR=/fs/sda1
> 2025-10-27 23:06:42 export TEST_DEV=/dev/sda1
> 2025-10-27 23:06:42 export FSTYP=btrfs
> 2025-10-27 23:06:42 export SCRATCH_MNT=/fs/scratch
> 2025-10-27 23:06:42 mkdir /fs/scratch -p
> 2025-10-27 23:06:42 export SCRATCH_DEV_POOL="/dev/sda2 /dev/sda3 /dev/sda4 /dev/sda5 /dev/sda6"
> 2025-10-27 23:06:42 echo btrfs/026
> 2025-10-27 23:06:42 ./check btrfs/026
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.18.0-rc1-00265-gd72352d1c3a3 #1 SMP PREEMPT_DYNAMIC Tue Oct 28 06:52:50 CST 2025
> MKFS_OPTIONS  -- /dev/sda2
> MOUNT_OPTIONS -- /dev/sda2 /fs/scratch
> 
> btrfs/026       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/026.out.bad)
>      --- tests/btrfs/026.out	2025-10-20 16:48:15.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//btrfs/026.out.bad	2025-10-27 23:06:53.540513519 +0000
>      @@ -12,4 +12,4 @@
>       5876dba1217b4c2915cda86f4c67640e  SCRATCH_MNT/bar
>       File digests after remounting the file system:
>       647d815906324ccdf288c7681f900ec0  SCRATCH_MNT/foo
>      -5876dba1217b4c2915cda86f4c67640e  SCRATCH_MNT/bar
>      +md5sum: /fs/scratch/bar: Input/output error
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/026.out /lkp/benchmarks/xfstests/results//btrfs/026.out.bad'  to see the entire diff)
> Ran: btrfs/026
> Failures: btrfs/026
> Failed 1 of 1 tests
> 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251028/202510281522.d23994ae-lkp@intel.com
> 
> 
> 


