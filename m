Return-Path: <linux-btrfs+bounces-11396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD9A31EA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 07:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4929918849B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAB21F0E55;
	Wed, 12 Feb 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWUQHWei"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BE1DF751
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341386; cv=none; b=e5avAdbx1HRS6oqMt8Wk1LugXFOy884tKiVfpUIQhH7+mU/H7uin/glOnzNZxZ4wjeFFA2QR+VUMMS5nZhhbUnPyngQ/kbDxDcG5dYq9jPh2SpP3Di2KjSJudlGshD7KoixVjjddjvkHfgUsQaD3YsR2H1dgw++0pB5gPutbgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341386; c=relaxed/simple;
	bh=W0NpBZMTTWFSesZiZbSwN5iKUIg3upK6dxKS6wSnDx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZcVA+CT60gE43ipB5S6YUvokxyKI1EB2uQoRhK/OrUJDUJer0cYQJDOnwNJdR4dS4L1P6e6yrUemf2r0HqEPmTloVzMzF1FZURu/VfbP48iTENn64kONlQssEAqZaeBK7Uyw10bbXVQ1Fx8ZKiGajjbj4Tb6MvWZWmrHDNxFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWUQHWei; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4395a917f33so1056905e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 22:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739341382; x=1739946182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZl+Lm+eNF5vV/lYzaAH8+uqzZkVXJRZUaZFAcWr+M=;
        b=YWUQHWeiYRUzLNMppG5IIcoNClxg86aRhvWb+usd6+/ve5wdONTQMYqgJraYrsml2R
         Yom1+d+FDb1kARyXCJSb4OCszfgaWLuK/JBEy4s8xNDMBblNKp1S1sDeX5EUWhlSlbwe
         6mtvfymJvfl7xyZGou+uCTkKgYhmAp5f0zunQbmNFEzPBX6Mlu44kWgVI6NulBFe0f+s
         vSn8D07I6pxKf5MmH+KRCf5y1mSbaGWuRALHVFVnUwu+M1ZnhgR3wIylD7oN9ly+AUFj
         tbn8BFh/s91fHgm7R/iw+cwzgAyIQl/Bn5vJlQtPtld7kLQyDZFEEoyQyMQtTKE9T9Ix
         0RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341382; x=1739946182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eZl+Lm+eNF5vV/lYzaAH8+uqzZkVXJRZUaZFAcWr+M=;
        b=Lwdx63uUmxi+m7qrVMOPLcVlywYy4mBW9emLcRPguCHmIrMa8CR/zXzP4fYvB3JF+d
         NrigCxgVnusy5f7IMs9j3wxbIxgvM57p+lHosvmXFROckWODhv3U20PZxy3hF0kToMjj
         7+hJGzyJBwHjxhshRSxQZYf+UoMpCceqBMOjdkPsuvmw1nw7SmyPnQcp/oSOaoH1puto
         /45m7rzt8pz+Itsn38hXf0PnlIhB+xmN1TvzOFBVB9pUZrunqDTDvvCDcCDjsRM5SoQ7
         MfPp0ggPMUBWUoEdro8IfYfW3fvmO0LRs1iyi7u1XnXlr7ogJfMizAA8XvynOoE0Bfr0
         n8dg==
X-Forwarded-Encrypted: i=1; AJvYcCXQCzyk9v6f0A+piATxxlkvQaBAqrm029S4l0y4TmKDmDLJvj/cov9jg1TismK8e0RlLleGvt3RynVhww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMl++cfvAsoGFSKvLuWivyGYTFtlF+M+CG7X4vm2wJU7eEbTmd
	mZI5m0I0QWjW1v70QckWV3QcLxEQsovP0kRGgH2/4V1rxV50ycQFM5aYQrRlo5U=
X-Gm-Gg: ASbGncvZ+hbZzWWmUlSAbDTPnosYEhwpfos//h8XoLWcrPdKoGMy4jZCPkKdHr4+CfO
	9BYnBdWh7AZRRO+viJrDwMCLcTRvne8SuShRHO63Mvx4E9zSkK5dkptbS/Uykh4PvyFoZYHRdaz
	gTjb4in9x5XCSygqVJZ9seW5d30LHpnOWFRmmXvBuIb1Rg/THKgG8GbwfaegtUMlqv8hXyGwIt/
	9w0zYPThvo9R7niVc534aahGXvqH+rBSyGEMeBu2elOm+QliNLk/Dx2V+AEPQ9179AvTi/FPHFt
	+qEba0Fymml6WulzVaA197yBaON/HXaX+z56MwQUS74=
X-Google-Smtp-Source: AGHT+IGvyDbwTuL65YPFFznO2ohKRnsCuHBRtsqpeHy0jfeaMB3HhKxjeUQ1Ff5of74r5fodNtMwLg==
X-Received: by 2002:a05:6000:4009:b0:38d:db2c:26be with SMTP id ffacd0b85a97d-38de43a5c98mr4631504f8f.14.1739341381819;
        Tue, 11 Feb 2025 22:23:01 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7322d4c2f56sm572302b3a.118.2025.02.11.22.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:23:01 -0800 (PST)
Message-ID: <d9720346-bf14-440c-9a57-8e8c25864059@suse.com>
Date: Wed, 12 Feb 2025 16:52:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [btrfs] 92a6e5b713: xfstests.btrfs.226.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, David Sterba <dsterba@suse.com>,
 "hch@infradead.org" <hch@infradead.org>, Filipe Manana <fdmanana@suse.com>,
 linux-btrfs@vger.kernel.org
References: <202502121035.e70df273-lkp@intel.com>
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
In-Reply-To: <202502121035.e70df273-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 15:14, kernel test robot 写道:
> 
> 
> Hello,
> 
> kernel test robot noticed "xfstests.btrfs.226.fail" on:
> 
> commit: 92a6e5b7138df60388f43065b22d0fd846ab8802 ("btrfs: always fallback to buffered write if the inode requires checksum")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]

This is a known one, please update the test case, see this fstests patch:

https://lore.kernel.org/linux-btrfs/6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com/


> 
> in testcase: xfstests
> version: xfstests-x86_64-8467552f-1_20241215
> with following parameters:
> 
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-226
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202502121035.e70df273-lkp@intel.com
> 
> 2025-02-11 13:28:35 export TEST_DIR=/fs/sdb1
> 2025-02-11 13:28:35 export TEST_DEV=/dev/sdb1
> 2025-02-11 13:28:35 export FSTYP=btrfs
> 2025-02-11 13:28:35 export SCRATCH_MNT=/fs/scratch
> 2025-02-11 13:28:35 mkdir /fs/scratch -p
> 2025-02-11 13:28:35 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
> 2025-02-11 13:28:35 echo btrfs/226
> 2025-02-11 13:28:35 ./check btrfs/226
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.14.0-rc1-00040-g92a6e5b7138d #1 SMP PREEMPT_DYNAMIC Tue Feb 11 21:13:29 CST 2025
> MKFS_OPTIONS  -- /dev/sdb2
> MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
> 
> btrfs/226       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/226.out.bad)
>      --- tests/btrfs/226.out	2024-12-15 06:14:52.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//btrfs/226.out.bad	2025-02-11 13:28:41.437083025 +0000
>      @@ -39,14 +39,11 @@
>       Testing write against prealloc extent at eof
>       wrote 65536/65536 bytes at offset 0
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      -wrote 65536/65536 bytes at offset 65536
>      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      +pwrite: Resource temporarily unavailable
>       File after write:
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/226.out /lkp/benchmarks/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
> Ran: btrfs/226
> Failures: btrfs/226
> Failed 1 of 1 tests
> 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250212/202502121035.e70df273-lkp@intel.com
> 
> 
> 


