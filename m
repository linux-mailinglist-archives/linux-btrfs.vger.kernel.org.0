Return-Path: <linux-btrfs+bounces-18512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB2C287F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 22:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839783AC670
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314526F2AE;
	Sat,  1 Nov 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xf3Aj8En"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016372288F7
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762031575; cv=none; b=rXHplQ4N6DaUOX1Uhd/OTz+3mxFL5PuL9dfPv0bzcTsA/oEp66kDlDIe67fQJT6AfcjkdUoTwxYS5OxjzYRqlJPcE9GhrH8p0H3uBCEdacFV9arB87galklG/hE8vSH11nh0BEdufcMSFB8ickc2Y82xWhTNgf01ERIC/jtZwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762031575; c=relaxed/simple;
	bh=fbGmhHnv6wEcIdds+Xy05mRcgz+xjR38/5N39YOS2FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf9Ch0F7IFbgeqTv+wMVG/J1fEpFkj2B3dnupIO9BWahnmZFVKScAZb/imqS+gE9oCGEbxI6hRmfiA0LvD8NKH0WkjFL2bqlKqthTNW8J+FRpC/dVbFiXKF2EbDI/M3EYam5LR5+v1c+fnjVyLr0rG30VA9ISqr2Vhkl7jHsvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xf3Aj8En; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c4c65485so1601088f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Nov 2025 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762031570; x=1762636370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibq1shUNg+NIdzqd2F/4ZjECQosDPOU2w4p83AxO4Wo=;
        b=Xf3Aj8En0qKrQXODLLPLQdQpGXMn8awQJPP7/MMCJO7F7SsIeBuCbKlfXnaR75FFGy
         XTE2Byto+XvQ14E4eeOzRN/+yzupuiLULG+Y5+HaP+Zn3iK3/uL/czTunLc5ty4dEnHj
         hYkYLwnVsgFk8pZPaXZgoQndTH9h0wx/qOBPuXoc4bF4qFB/zWr7Mw0OXIJExH3wKNqw
         SlBIaw4l7BM70KEo8pHfwXTTRcfpSOeRmeypBbVQD3tUhEGKijiZXAen475kbE+6dYdv
         4lvsJlmCoGSiZGuCwXJEt10HIiIPYDbqDwn39iR+shxBn6MOCrIzLnY1MBG/dV9wpoPD
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762031570; x=1762636370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibq1shUNg+NIdzqd2F/4ZjECQosDPOU2w4p83AxO4Wo=;
        b=rdoCIMdYZjJdQh3JDkjZbs/qCqt3Kgn8lfZmArPQMhmbpyqbAJX46Cs990OkzzkYJT
         8mXtkizld+YbG6+kPVJF7skN47FilrwrULPZ4ObcjifkFCStsclipSFbHpqP7l1T8xog
         r9knFed3jDK4MkSRPuGA3i42OnK5SGhU+Cs4nsn3w+GNJbpbMPOm0vSV4V6KV6zUo3wX
         VvyJ6SYJ+1X+DrOQodcHJ99ukUiNFFGt7XNA5L93eGnVIPMxQ8yHI+NzaSjDBsT5/CBF
         eSmS+kXqQSZfd3sZ4tO027twy4wSEIQjqsQoGQjNeGFUrMRmgQ1D3qdVOOad98Fngg6c
         9cag==
X-Gm-Message-State: AOJu0Yz+F5hsidWQ99uc/fpxJ/anPKanInK+qnID5Pv7RZclnDw0WGHx
	E9uob0Xavgx5UGTebtLDuHGIHESecAM2lLJxm7zBwz6WVQaslH13/1Klwql4Dx21qK8=
X-Gm-Gg: ASbGncs6jQLp4ymRG0m+42GwkACMIywkVX4SyjSvPljCg9GgFURKTe3ylF22lKX7DQZ
	/GzEJ8jI3enOEpFi2+t+n6QridB6+K9t5eq+NfSoa6+Nm58erO6JNtpXz7J7H02+ugYdIV4Y5/x
	D/C6cbI7fwGkcZxHzpu2X/JgCYUbZEydBX/OULsjwrnkEpVgPchdE/ynThmEmhLoAUKIgVkaPf0
	lB6TnwcEvt4gEvItYkAqGfQTbZ0sosWtG716WOtAVsTonHDX3VeJQttyHx2pnKdjPoi46FfuLyA
	Td6PrV0DkJpMc0McZrBb7CHKAmBzNA60VhlW8N4j7s7Px4ochMn6PvXMiHln6Y7jPKMn445ZQy9
	Vqm0EkIy/sY0cwSFEtCBVBYR2o3hYEuN3dCqQGoe2pDaj6j9iJCd+kLwWD40nTtdFVQbH4NJl3M
	wfBOznywhm4Qr3Ldx7RWjFKh1ZCuVB7mRpStZyIOs=
X-Google-Smtp-Source: AGHT+IFBaCBjQtOsK+wp+P67r09OAedTop8js6mv0wrrzvjP55LcnIAkQAG6KpyVZuO1A8kS2j5jiw==
X-Received: by 2002:a05:6000:2887:b0:427:809:eff5 with SMTP id ffacd0b85a97d-429bd6c2cf2mr7232095f8f.53.1762031570157;
        Sat, 01 Nov 2025 14:12:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67aca2sm6092335b3a.59.2025.11.01.14.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 14:12:49 -0700 (PDT)
Message-ID: <9acb730d-6174-4ae6-a5d8-d1bca947462b@suse.com>
Date: Sun, 2 Nov 2025 07:42:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add a new generic test case to verify direct io
 read
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250926095013.136988-1-wqu@suse.com>
 <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/2 02:27, Zorro Lang 写道:
> On Fri, Sep 26, 2025 at 07:20:13PM +0930, Qu Wenruo wrote:
>> [POSSIBLE PROBLEM]
>> For filesystems with data checksum, a user space program can provide a
>> block of aligned memory as read buffer, and modify the buffer during the
>> read.
>>
>> Btrfs used to utilize such memory directly during checksum
>> verification, and since the content can be modified by user space, the
>> checksum verification can fail easily when such modification happened.
>>
>> This will cause a false checksum mismatch alert, and if there is no more
>> mirror, the read will fail.
>> And even if there is an extra mirror, checksum verification can still
>> fail due to user space interference.
>>
>> [NEW TEST CASE]
>> The new test case is pretty much the same as the existing generic/761,
>> utilizing a user space multi-thread program to do a direct read,
>> meanwhile modifying the buffer at the same time.
>>
>> The new program, dio-read-race, is almost the same, with some changes:
>>
>> - O_RDRW flag to open the file
>> - Populate the contents of the file
>> - Do read and modify
>>    Instead of write and modify
>>
>> [EXPECTED RESULTS]
>> For unpatched kernels, the new test case fails like this:
>>
>>   generic/772       - output mismatch (see /home/adam/xfstests/results//generic/772.out.bad)
>>       --- tests/generic/772.out	2025-09-26 19:07:37.319000000 +0930
>>       +++ /home/adam/xfstests/results//generic/772.out.bad	2025-09-26 19:08:33.873401495 +0930
>>       @@ -1,2 +1,3 @@
>>        QA output created by 772
>>       +io thread failed
>>        Silence is golden
>>       ...
>>       (Run 'diff -u /home/adam/xfstests/tests/generic/772.out /home/adam/xfstests/results//generic/772.out.bad'  to see the entire diff)
>>
>>   HINT: You _MAY_ be missing kernel fix:
>>         xxxxxxxxxxxx btrfs: fallback to buffered read if the inode has data checksum
>>
>> With dmesg recording some checksum mismatch:
>>
>>   BTRFS warning (device dm-3): csum failed root 5 ino 257 off 241664 csum 0x13fec125 expected csum 0x8941f998 mirror 1
>>   BTRFS error (device dm-3): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>   BTRFS warning (device dm-3): direct IO failed ino 257 op 0x8800 offset 0x3b000 len 4096 err no 10
>>
>> For patched kernels, the new test case passes, without any error in
>> dmesg:
>>
>>   generic/772 6s ...  6s
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
> 
> This patch has been there more than 1 month. It works on my side, and
> didn't bring in any regressions. I'd like to merge this patch,
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks for the review, I guess the reason the patch and test case didn't 
get reviewed is the performance drop.

When we enables buffered fallback for direct writes, it indeed caused 
performance drop, and end users noticed (mostly by benchmark tools).

But thankfully it's only affecting those benchmark tools, and those 
tools are adapting to btrfs by using NOCOW flags, so no real world 
performance regression (yet).

I'll keep pushing the fix so that the test case can be merged with an 
upstream fix.

Thanks,
Qu

> 
>>   .gitignore            |   1 +
>>   src/Makefile          |   2 +-
>>   src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/772     |  41 +++++++++++
>>   tests/generic/772.out |   2 +
>>   5 files changed, 212 insertions(+), 1 deletion(-)
>>   create mode 100644 src/dio-read-race.c
>>   create mode 100755 tests/generic/772
>>   create mode 100644 tests/generic/772.out
>>
>> diff --git a/.gitignore b/.gitignore
>> index 82c57f41..3e950079 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -210,6 +210,7 @@ tags
>>   /src/fiemap-fault
>>   /src/min_dio_alignment
>>   /src/dio-writeback-race
>> +/src/dio-read-race
>>   /src/unlink-fsync
>>   /src/file_attr
>>   
>> diff --git a/src/Makefile b/src/Makefile
>> index 711dbb91..e7dd4db5 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>>   	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>>   	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
>>   	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
>> -	dio-writeback-race unlink-fsync
>> +	dio-writeback-race dio-read-race unlink-fsync
>>   
>>   LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>> diff --git a/src/dio-read-race.c b/src/dio-read-race.c
>> new file mode 100644
>> index 00000000..7c6389e0
>> --- /dev/null
>> +++ b/src/dio-read-race.c
>> @@ -0,0 +1,167 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dio-read-race -- test direct IO read with the contents of
>> + * the buffer changed during the read, which should not cause any read error.
>> + *
>> + * Copyright (C) 2025 SUSE Linux Products GmbH.
>> + */
>> +
>> +/*
>> + * dio-read-race
>> + *
>> + * Compile:
>> + *
>> + *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
>> + *
>> + * Make sure filesystems with explicit data checksum can handle direct IO
>> + * reads correctly, so that even the contents of the direct IO buffer changes
>> + * during read, the fs should still work fine without data checksum mismatch.
>> + * (Normally by falling back to buffer IO to keep the checksum and contents
>> + *  consistent)
>> + *
>> + * Usage:
>> + *
>> + *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
>> + *
>> + * Where:
>> + *
>> + *   <filename> is the name of the test file to create, if the file exists
>> + *   it will be overwritten.
>> + *
>> + *   <buffersize> is the buffer size for direct IO. Users are responsible to
>> + *   probe the correct direct IO size and alignment requirement.
>> + *   If not specified, the default value will be 4096.
>> + *
>> + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
>> + *   the result file size will be rounded up to <blocksize>.
>> + *   If not specified, the default value will be 64MiB.
>> + */
>> +
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <pthread.h>
>> +#include <unistd.h>
>> +#include <getopt.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <sys/stat.h>
>> +
>> +static int fd = -1;
>> +static void *buf = NULL;
>> +static unsigned long long filesize = 64 * 1024 * 1024;
>> +static int blocksize = 4096;
>> +
>> +const int orig_pattern = 0x00;
>> +const int modify_pattern = 0xff;
>> +
>> +static void *do_io(void *arg)
>> +{
>> +	ssize_t ret;
>> +
>> +	ret = read(fd, buf, blocksize);
>> +	pthread_exit((void *)ret);
>> +}
>> +
>> +static void *do_modify(void *arg)
>> +{
>> +	memset(buf, modify_pattern, blocksize);
>> +	pthread_exit(NULL);
>> +}
>> +
>> +int main (int argc, char *argv[])
>> +{
>> +	pthread_t io_thread;
>> +	pthread_t modify_thread;
>> +	unsigned long long filepos;
>> +	int opt;
>> +	int ret = -EINVAL;
>> +
>> +	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
>> +		switch (opt) {
>> +		case 'b':
>> +			blocksize = atoi(optarg);
>> +			if (blocksize == 0) {
>> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
>> +				goto error;
>> +			}
>> +			break;
>> +		case 's':
>> +			filesize = atoll(optarg);
>> +			if (filesize == 0) {
>> +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
>> +				goto error;
>> +			}
>> +			break;
>> +		default:
>> +			fprintf(stderr, "unknown option '%c'\n", opt);
>> +			goto error;
>> +		}
>> +	}
>> +	if (optind >= argc) {
>> +		fprintf(stderr, "missing argument\n");
>> +		goto error;
>> +	}
>> +	ret = posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
>> +	if (!buf) {
>> +		fprintf(stderr, "failed to allocate aligned memory\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	fd = open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
>> +		goto error;
>> +	}
>> +
>> +	memset(buf, orig_pattern, blocksize);
>> +	/* Create the original file. */
>> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
>> +
>> +		ret = write(fd, buf, blocksize);
>> +		if (ret < 0) {
>> +			ret = -errno;
>> +			fprintf(stderr, "failed to write the initial content: %m");
>> +			goto error;
>> +		}
>> +	}
>> +	ret = lseek(fd, 0, SEEK_SET);
>> +	if (ret < 0) {
>> +		ret = -errno;
>> +		fprintf(stderr, "failed to set file offset to 0: %m");
>> +		goto error;
>> +	}
>> +
>> +	/* Do the read race. */
>> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
>> +		void *retval = NULL;
>> +
>> +		memset(buf, orig_pattern, blocksize);
>> +		pthread_create(&io_thread, NULL, do_io, NULL);
>> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
>> +		ret = pthread_join(io_thread, &retval);
>> +		if (ret) {
>> +			errno = ret;
>> +			ret = -ret;
>> +			fprintf(stderr, "failed to join io thread: %m\n");
>> +			goto error;
>> +		}
>> +		if ((ssize_t )retval < blocksize) {
>> +			ret = -EIO;
>> +			fprintf(stderr, "io thread failed\n");
>> +			goto error;
>> +		}
>> +		ret = pthread_join(modify_thread, NULL);
>> +		if (ret) {
>> +			errno = ret;
>> +			ret = -ret;
>> +			fprintf(stderr, "failed to join modify thread: %m\n");
>> +			goto error;
>> +		}
>> +	}
>> +error:
>> +	close(fd);
>> +	free(buf);
>> +	if (ret < 0)
>> +		return EXIT_FAILURE;
>> +	return EXIT_SUCCESS;
>> +}
>> diff --git a/tests/generic/772 b/tests/generic/772
>> new file mode 100755
>> index 00000000..46593536
>> --- /dev/null
>> +++ b/tests/generic/772
>> @@ -0,0 +1,41 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 772
>> +#
>> +# Making sure direct IO (O_DIRECT) reads won't cause any data checksum mismatch,
>> +# even if the contents of the buffer changes during read.
>> +#
>> +# This is mostly for filesystems with data checksum support, as the content can
>> +# be modified by user space during checksum verification.
>> +#
>> +# To avoid such false alerts, such filesystems should fallback to buffer IO to
>> +# avoid inconsistency, and never trust user space memory when checksum is involved.
>> +# For filesystems without data checksum support, nothing needs to be bothered.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_require_scratch
>> +_require_odirect
>> +_require_test_program dio-read-race
>> +
>> +
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: fallback to buffered read if the inode has data checksum"
>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
>> +filesize=$(( 64 * 1024 * 1024))
>> +
>> +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
>> +
>> +$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +_exit 0
>> diff --git a/tests/generic/772.out b/tests/generic/772.out
>> new file mode 100644
>> index 00000000..98c13968
>> --- /dev/null
>> +++ b/tests/generic/772.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 772
>> +Silence is golden
>> -- 
>> 2.51.0
>>
>>
> 


