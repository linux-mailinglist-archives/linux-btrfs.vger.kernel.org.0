Return-Path: <linux-btrfs+bounces-16614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D7B41907
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854761B28063
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D52E8B69;
	Wed,  3 Sep 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V47aNZD6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312A1F948
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Sep 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889290; cv=none; b=rY7y36Fnnuzvu1DMpFMgEIrEEqEEE9Vrn92GJLg3uHGbkG1iujAK4IShJn3T0nAxVgRICMWXOYQDCKZx7XbeKmwnELwYzasdb/1dLsuX05/uirVBQNP1aZDKeeBMY6K79FFd6USMYWPMR8mvJJA6an0PdKnORQUodfXEmGXp6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889290; c=relaxed/simple;
	bh=G/HQAICVyosrIp4ApXauWvFtOuVnGI7B86rhG1fg2Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si/iaoTE8ebvZEFV82QzBJqQFmdAencqxaPmVaUEnfgmE7e/wAaufBSyQjSbLFQIHShxTYlzUPfeQeJGlta0B/sIPyYaWJv/AVzi3oEfdEDNoPL4+thgKuvOkhJnP1fKByYgCBVjJbc/qW4fQMqI/p72Ppt+V/tOawaWmzcJOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V47aNZD6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d2564399a5so1422486f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Sep 2025 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756889287; x=1757494087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+dFhyhyqJr75WwSaOHE7BII74yZAHk+nCpXZ3qcIN8=;
        b=V47aNZD6+myt7DbmGWumvxzyD+cLIcqxll0B65u4OQjbimxzstF2xnFKAeVIhgIhQB
         d2YFdES5eVT9+MXuZXqsU59EvYDJXfamY3CMUzo4xFtaYAQWz+HX/urF+HBeQAZqhuCx
         4wVnsOIB9Ah32PisqILE+KmpeM3bS5mqR/pXUO7loShsTKTnJRjJpGeELRZ8oCpgY00h
         +RpBwYYc3H5xQAuV/DYdcuqDnoObkpZfzkEtf5sdDPLlqrqjylSuEf8pFSKsmeKEABVc
         1QiuSfS/4UlLesV7q4HXWwhPHfa9z7DOf43kEZYzxrIZk+zd5z0dOGAtEsBcuyCiHtSk
         HDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889287; x=1757494087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+dFhyhyqJr75WwSaOHE7BII74yZAHk+nCpXZ3qcIN8=;
        b=SeDFfk4Wn5yr8uxPSG1ay9+8Ymk1WAILb5sfl+ZCfGXtQMWpE23StuUcZdRoDmcT7F
         8/FutanDOAFXi9KBLzubHSjw38cLPuQRvpNn5zb/0G7pDSa7cOuuB+wt8rl/vnrD9EEh
         BdG+fx8NY7/poK4xvIY4j9hY9xCPfW/vMcci5h7OWwaE1i2N4ekna5kS7D71DhK6TVMj
         YCH4WVJoXTC+dNbpJPbgITucaIY2xRGzRpEHVlO4uSI8LEN163E6IFAPY1a578t9i6TM
         waLHwWlO40fBgxS6qqYPifTqRaYQH8yV0i6Qyu6EAlm7JWCaiADebfB84BRgxlQYF8Wm
         1K+A==
X-Forwarded-Encrypted: i=1; AJvYcCUTGkRsv4vBcGiq796CfDGy2kPg/6KvxZgG2ADVqcOo/c66TqwAIvvlJgfOs02aZFuMxz24nDkve9nVcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5yeriu5si1dIziVURpwIReoez+zEOWdHs47a2SeE+WMMrHLO
	80JxzQZ0dTPKYCL877FxdzWzqfw3iYb0URdpcD9xfXYziG06327fFVsr6SUoXRq9BxIYLqDsQVs
	+UTv3
X-Gm-Gg: ASbGncv4Qwu+WazSSMyXfCgemgm/6/pdppUkCRXxWhipUvPqdPfuw15Cohhq99tMtrf
	8N4WXIT04a+qCMvymo6OjLlLeZb+pwdTrAmFn4NOhqPx/V+OgpvClgYeiv5sgp7vxnWS8HfKmKo
	wh1uwAmcufGTlA/xNEvkpbS8O7naPxbWBX9eETo7MNwlIz4TSkl+8CFVSvP+niZNloDL7mTG7K5
	PQkTCWTGegKXLxAqvu5xz33KB9si5IpdL8wLodss+RZ8quzr1w3JwmZZuq1dxWaaIf/UMhpGShK
	l+L0VgLUtaQWygoID0Vi3B5GyveeRJugbRwlgd4wfb23ltH9F9zL8Cza/ZeZrw71v/WcJl0+PF3
	eAwes1R5+5HH+H1rfdki0+OfuNechUBE3ZqCDiABpbkoziWrmi9Y7ozOpY+YjBQ==
X-Google-Smtp-Source: AGHT+IHbXlAmsIr5mQsBVFTxh9EzMGiTHl5fiPrZ9WFCdZ67HAZOog5Phq9OBFDDnIrmcC3cSLTumg==
X-Received: by 2002:a05:6000:288b:b0:3cd:2328:898b with SMTP id ffacd0b85a97d-3d1e05b5c25mr10817288f8f.47.1756889286519;
        Wed, 03 Sep 2025 01:48:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm153203545ad.151.2025.09.03.01.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:48:06 -0700 (PDT)
Message-ID: <9d6db7e9-318f-4242-9883-9eee8ee20f5e@suse.com>
Date: Wed, 3 Sep 2025 18:18:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [btrfs] bddf57a707:
 stress-ng.sync-file.ops_per_sec 44.2% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <202509031643.303d114c-lkp@intel.com>
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
In-Reply-To: <202509031643.303d114c-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/3 18:14, kernel test robot 写道:
> 
> Hello,
> 
> kernel test robot noticed a 44.2% regression of stress-ng.sync-file.ops_per_sec on:
> 
> 
> commit: bddf57a70781ef8821d415200bdbcb71f443993a ("btrfs: delay btrfs_open_devices() until super block is created")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [still regression on      linus/master fb679c832b6497f19fffb8274c419783909c0912]
> [still regression on linux-next/master 3cace99d63192a7250461b058279a42d91075d0c]
> 
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: btrfs
> 	test: sync-file
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509031643.303d114c-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250903/202509031643.303d114c-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>    gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sync-file/stress-ng/60s
> 
> commit:
>    de339cbfb4 ("btrfs: call bdev_fput() to reclaim the blk_holder immediately")
>    bddf57a707 ("btrfs: delay btrfs_open_devices() until super block is created")

This doesn't sound sane to me.

The two commits are only affecting btrfs mounting/unmounting, I can not 
make any sense on why they would affect performance.

Or does stress-ng doing a lot of mounting/unmounting?

Thanks,
Qu

> 
> de339cbfb4027957 bddf57a70781ef8821d415200bd
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     1885182 ±  2%     -35.0%    1226241        cpuidle..usage
>        1.35 ±  3%     +26.8%       1.71 ± 31%  iostat.cpu.iowait
>      114330           -10.0%     102922        meminfo.Shmem
>       17680 ±  2%     -39.7%      10656 ±  2%  vmstat.system.cs
>       32084 ±  3%     -33.6%      21290 ±  2%  vmstat.system.in
>        0.08 ±  2%      -0.0        0.05 ±  2%  mpstat.cpu.all.irq%
>        0.03 ±  6%      -0.0        0.02 ±  5%  mpstat.cpu.all.soft%
>        0.66 ±  3%      -0.2        0.45 ±  2%  mpstat.cpu.all.sys%
>      311692 ±  9%     -17.9%     255869 ± 12%  numa-numastat.node0.numa_hit
>      304181 ±  8%     -24.2%     230456 ± 20%  numa-numastat.node1.local_node
>      331109 ±  6%     -19.3%     267048 ± 11%  numa-numastat.node1.numa_hit
>      311531 ±  9%     -17.9%     255766 ± 13%  numa-vmstat.node0.numa_hit
>      330584 ±  6%     -19.3%     266623 ± 10%  numa-vmstat.node1.numa_hit
>      303656 ±  8%     -24.2%     230030 ± 20%  numa-vmstat.node1.numa_local
>       59.00 ± 13%     -41.5%      34.50 ± 10%  perf-c2c.DRAM.local
>        1139 ±  4%     -46.1%     613.67 ±  5%  perf-c2c.DRAM.remote
>        1254 ±  5%     -45.3%     686.50 ±  2%  perf-c2c.HITM.local
>      681.33 ±  3%     -45.8%     369.50 ±  6%  perf-c2c.HITM.remote
>        1.33 ± 41%     -93.8%       0.08 ±223%  sched_debug.cfs_rq:/.runnable_avg.min
>        1.33 ± 41%     -93.8%       0.08 ±223%  sched_debug.cfs_rq:/.util_avg.min
>       10502           -34.4%       6886        sched_debug.cpu.nr_switches.avg
>        8094 ±  2%     -41.8%       4710 ±  2%  sched_debug.cpu.nr_switches.min
>       21146 ±  2%     -44.2%      11809        stress-ng.sync-file.ops
>      352.20 ±  2%     -44.2%     196.65        stress-ng.sync-file.ops_per_sec
>       34.00 ±  2%     -43.6%      19.17        stress-ng.time.percent_of_cpu_this_job_got
>       20.20 ±  2%     -43.6%      11.38        stress-ng.time.system_time
>      513054 ±  2%     -45.5%     279629        stress-ng.time.voluntary_context_switches
>       28437           -10.3%      25522        proc-vmstat.nr_shmem
>       25303            -1.0%      25040        proc-vmstat.nr_slab_reclaimable
>      644388           -18.6%     524319        proc-vmstat.numa_hit
>      578153           -20.8%     458095        proc-vmstat.numa_local
>      682807           -18.2%     558809        proc-vmstat.pgalloc_normal
>      675599           -18.3%     551960 ±  2%  proc-vmstat.pgfree
>        1.61            -5.0%       1.53        perf-stat.i.MPKI
>   6.692e+08 ±  3%      -8.2%  6.144e+08 ±  6%  perf-stat.i.branch-instructions
>       23.54            -2.2       21.29        perf-stat.i.cache-miss-rate%
>     2665211 ±  3%     -27.0%    1946091 ±  4%  perf-stat.i.cache-misses
>    12037045 ±  3%     -18.2%    9840696 ±  3%  perf-stat.i.cache-references
>       18418 ±  3%     -40.1%      11025        perf-stat.i.context-switches
>        2.13            -5.4%       2.01        perf-stat.i.cpi
>   3.964e+09 ±  3%     -19.8%  3.177e+09 ±  4%  perf-stat.i.cpu-cycles
>      181.54 ±  3%     -23.8%     138.31 ±  4%  perf-stat.i.cpu-migrations
>        1472            +7.4%       1581        perf-stat.i.cycles-between-cache-misses
>   3.216e+09 ±  3%      -7.6%  2.972e+09 ±  6%  perf-stat.i.instructions
>        0.65            +8.4%       0.71 ±  2%  perf-stat.i.ipc
>        0.83           -20.9%       0.66 ±  2%  perf-stat.overall.MPKI
>        4.24            +0.3        4.58 ±  2%  perf-stat.overall.branch-miss-rate%
>       22.13            -2.4       19.76        perf-stat.overall.cache-miss-rate%
>        1.23           -13.1%       1.07 ±  2%  perf-stat.overall.cpi
>        1488            +9.8%       1634        perf-stat.overall.cycles-between-cache-misses
>        0.81           +15.1%       0.93 ±  2%  perf-stat.overall.ipc
>   6.587e+08 ±  3%      -8.2%  6.047e+08 ±  6%  perf-stat.ps.branch-instructions
>     2623092 ±  3%     -27.0%    1915109 ±  4%  perf-stat.ps.cache-misses
>    11851537 ±  3%     -18.3%    9688099 ±  3%  perf-stat.ps.cache-references
>       18125 ±  3%     -40.2%      10847        perf-stat.ps.context-switches
>   3.903e+09 ±  3%     -19.8%  3.129e+09 ±  4%  perf-stat.ps.cpu-cycles
>      178.73 ±  3%     -23.8%     136.12 ±  4%  perf-stat.ps.cpu-migrations
>   3.166e+09 ±  3%      -7.6%  2.925e+09 ±  6%  perf-stat.ps.instructions
>   2.004e+11            -9.3%  1.818e+11 ±  5%  perf-stat.total.instructions
>        0.00 ±223%   +4160.0%       0.04 ± 35%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_create_pending_block_groups
>        0.01          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
>        0.01 ± 15%    +246.8%       0.03 ± 96%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_sync_log
>        0.00 ±223%   +4180.0%       0.04 ± 35%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_create_pending_block_groups
>        0.02 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
>        0.16 ±106%     -77.8%       0.04 ± 39%  perf-sched.sch_delay.max.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>       27.42 ±  3%     +53.9%      42.21 ±  4%  perf-sched.total_wait_and_delay.average.ms
>       40831 ±  3%     -36.6%      25906 ±  4%  perf-sched.total_wait_and_delay.count.ms
>       27.41 ±  3%     +54.0%      42.21 ±  4%  perf-sched.total_wait_time.average.ms
>      229.23 ±  2%     +51.7%     347.78 ± 15%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       12.64 ±  3%     +56.9%      19.84 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
>        2.33 ± 11%     +63.7%       3.81 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
>        6.94 ±  2%     +29.6%       9.00 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        0.31 ±  5%    +421.7%       1.64 ± 25%  perf-sched.wait_and_delay.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>       18.67 ±  5%     -35.7%      12.00 ± 16%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       22342 ±  4%     -40.1%      13375 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
>        9405 ±  4%     -40.8%       5564 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
>      666.83 ±  2%     -22.5%     516.50 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        4582 ±  4%     -37.4%       2866 ±  5%  perf-sched.wait_and_delay.count.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>        5.34 ± 21%    +756.6%      45.72 ±  4%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>       22.83 ±  2%     +15.9%      26.46 ±  8%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
>      229.23 ±  2%     +51.6%     347.59 ± 15%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       12.63 ±  3%     +57.1%      19.83 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
>        2.32 ± 12%     +64.0%       3.81 ± 18%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
>        8.58 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
>        6.94 ±  2%     +29.6%       8.99 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        0.31 ±  5%    +427.4%       1.63 ± 25%  perf-sched.wait_time.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>      101.57 ± 20%     +56.6%     159.06 ± 22%  perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>      116.41 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 


