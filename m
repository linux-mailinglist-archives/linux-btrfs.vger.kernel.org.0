Return-Path: <linux-btrfs+bounces-3508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0B88678F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2F21C23A44
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE449134A3;
	Fri, 22 Mar 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fmU/ADGx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFDF9D9
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093051; cv=none; b=Yey239yZ7PuFA7uJzhCz9tm9aMcpym6oMDF1Z4PH81TbDWAfkgggECB5oo+/4SAOyqF6QOEHQZDwd0ODfir2oim847QZp1rqfykyl8YfbXVxxmeqV2UO7ovNGopRww5z18TPJKbH+VdsGC1Duwj+bzRfSM/OkGmsk3RrxnqJ0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093051; c=relaxed/simple;
	bh=g6ydOpWYaFOm4HL9MQi40HExzgD9iQF/8lhX1SJAtj0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=A9fYPExc3OOluAo1S2RcVIy00/UZznh43/w2t3pDTjc1eiDtZzjG+vdqwsl+rmrRFx+BEV+CHIk8gPcqN5LWfVE1Z3m8iD9UE8Np++LZjH9fGJTzOCE/Z+aZd955hL2LWciL9VyujAzW+/98IZXfAyRO9YTMxMvqsOL81V2BxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fmU/ADGx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so23923161fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711093046; x=1711697846; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wt9PMApW2C77ZH8hZxPDwki54fE/um4oo2cKXxTTRc=;
        b=fmU/ADGxS+H6DVPOpllXOHgoVtbn06Dgw0XYVk8EXKJEeha2t/oS+C4I4dMlpJLVAd
         hDiXOax5yOuDJWhAoPCb2mtXKdqosUMXs5EDmBGzQKYOdjbwLYZXsiUjVAsCMTVsNKiz
         jZOGrgk3l4KRCCZFs8vNt7uUyXu1Uqit8QIAnqMuyGJ3n+ZzcONdFUa+YPnTQcI/ZHli
         wTqkD54drgVmEhEqL1aZdtDAjlGSwJ5Fu2uSc5tYHZtMqktBDhs8AfD5orSi1RLbtIMt
         FFimqmiqyJMQ35BxPqiM+BJDipR1aqs3fXpijrQlcVizeqvFW0udBr+em6mmFL3lsSHD
         kGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093046; x=1711697846;
        h=in-reply-to:autocrypt:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wt9PMApW2C77ZH8hZxPDwki54fE/um4oo2cKXxTTRc=;
        b=ilA9nSh9QgFJcXmgqBRS25gAFioYz60tZYq2UgVYqe0h0CYmIixfdPTT7JK8uzUZnI
         Eke2KoepVbKQauED3g8XQRKbLM6qko8X5JGQKdl+yhJvO8CGMcE2+5N8fQ99RcF9ARGG
         FaVawgnWUl4i1uHrqGm30tgt8lc0U+zAPdGCegx6pYd9jJE4NTy33K7LeBviDwsh2Xqs
         9+PQUHkqeQ4WmIfNRr4rlEb8/TgPttqOivWtUo4SUtuNKkhX4oTCIOV9wiSYnFfEmj22
         SlQqh+fpUf9RvGi+3exvKWzWNOX3XhjyrRcI/y6xu6ZzirjNT/IRIxWYrw5FuJARdmRI
         vDLg==
X-Forwarded-Encrypted: i=1; AJvYcCWI+sG0ogxNvsL2crOn5y/8+VD0ryMBJEduS6yylNmbnYCO7HBWjkep3rFQc22Lw915UjJnGI6CrGEeLqUW56fj3su3bYdvaDYue5I=
X-Gm-Message-State: AOJu0YzvrZCyzreYYq2IEwjQPC7beyPKITUQa9Dpclq96DqcX0rQUCM5
	sI/EVmpSTlx7RrBg5yNHnodbu7zYFbDqMAJe6wz3O75Tc7MEgC2PH9u23cYkJ/o=
X-Google-Smtp-Source: AGHT+IFVqwRbjBfN7x1gGVDLrv2hX7v7gWsN7jZ8+/+HIwGo+fQ76PzKo2vmT2gK2DLSwbrUabDQbQ==
X-Received: by 2002:a2e:9195:0:b0:2d3:2a95:6f0b with SMTP id f21-20020a2e9195000000b002d32a956f0bmr1145791ljg.12.1711093046361;
        Fri, 22 Mar 2024 00:37:26 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d8a93fa5b1sm1180171plg.131.2024.03.22.00.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 00:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jyjBFaXCxLZ2Uc0Fhu3rrhno"
Message-ID: <d4955b70-f379-43b0-ab8f-7aaa8bafb41c@suse.com>
Date: Fri, 22 Mar 2024 18:07:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: slow performance due to frequent memalloc_retry_wait in
 btrfs_alloc_page_array
Content-Language: en-US
To: Julian Taylor <julian.taylor@1und1.de>, linux-btrfs@vger.kernel.org
References: <8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de>
 <9d66a2e0-96a5-4aea-acf3-732d6667e60e@gmx.com>
 <5f527804-9d52-4f96-b0a7-72d49e524e18@1und1.de>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <5f527804-9d52-4f96-b0a7-72d49e524e18@1und1.de>

This is a multi-part message in MIME format.
--------------jyjBFaXCxLZ2Uc0Fhu3rrhno
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/13 20:06, Julian Taylor 写道:
> 
> On 13.03.24 07:26, Qu Wenruo wrote:
>>
>>
>> 在 2024/3/13 00:05, Julian Taylor 写道:
>>> Hello,
>>>
>>> After upgrading a machine using btrfs to a 6.1 kernel from 5.10 we are
>>> experiencing very low read performance on some (compressed) files when
>>> most of the nodes memory is in use by applications and the filesystem
>>> cache. Reading some files does not exceed 5MiB/second while the
>>> underlying disks can sustain ~800MiB/s. The load on the machine while
>>> reading the files slowly is basically zero
>>>
>>> The filesystem is mounted with
>>>
>>>   btrfs (rw,relatime,compress=zstd:3,space_cache=v2,subvolid=5,subvol=/)
>>>
>>> The filesystem contains several snapshot volumes.
>>>
>>> Checking with blktrace we noticed a lot of queue unplug events which
>>> when traced showed that the cause is most likely io_schedule_timeout
>>> being called extremely frequent from btrfs_alloc_page_array which since
>>> 5.19 (91d6ac1d62c3dc0f102986318f4027ccfa22c638) uses bulk page
>>> allocations with a memalloc_retry_wait on failure:
>>>
>>> $ perf record -e block:block_unplug -g
>>>
>>> $ perf script
>>>
>>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>>> ([kernel.kallsyms])
>>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>>> ([kernel.kallsyms])
>>>          ffffffffa3bb1205 __blk_flush_plug+0xf5 ([kernel.kallsyms])
>>>          ffffffffa4213f15 io_schedule_timeout+0x45 ([kernel.kallsyms])
>>>          ffffffffc0c74d42 btrfs_alloc_page_array+0x42 
>>> ([kernel.kallsyms])
>>
>> Btrfs needs to allocate all the pages for the compressed extents, which
>> can be very large (as large as 128K, even if the read may only be 4K).
>>
>> Furthermore, since your system have very high memory pressure, it also
>> means the page cache doesn't have much chance to cache the decompressed
>> contents.
>>
>> Thus I'm afraid for your high memory pressure cases, it is not really
>> not a good use case with compression.
>> (Both compressed read and write would need extra pages other than the
>> inode page cache).
>>
>> And considering your storage is very fast (800+MiB/s), there is really
>> little benefit for compression (other than saving disk usages).
> 
> The machine does not have high memory pressure it has 380Gi of memory 
> and the applications on it only use a small fraction of it, it is just a 
> machine handling backups most of the time.
> 
> The memory is all just used by the page cache and is reclaimable. The 
> bulk page allocation functions just do not do that without falling back 
> to single page allocations.
> 
> 
>>
>>>
>>>
>>> Further checking why the bulk page allocations only return a single page
>>> we noticed this is only happening when all memory of the node is tied up
>>> even if still reclaimable.
>>>
>>> It can be reliably reproduced on the machine when filling the page cache
>>> with data from the disk (just via cat * >/dev/null) until we are have
>>> following memory situation on the node with two sockets:
>>>
>>> $numactl --hardware
>>>
>>> available: 2 nodes (0-1)
>>>
>>> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40
>>> 42 44 46 48 50 52 54 56 58 60 62
>>> node 0 size: 192048 MB
>>> node 0 free: 170340 MB
>>> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41
>>> 43 45 47 49 51 53 55 57 59 61 63
>>> node 1 size: 193524 MB
>>> node 1 free: 224 MB        <<< nothing free due to cache
>>
>> This is interesting, such unbalanced free memory is indeed going to
>> cause problems.
>>
>>>
>>> $ top
>>>
>>> MiB Mem : 385573.2 total, 170093.0 free,  19379.1 used, 201077.9 
>>> buff/cache
>>> MiB Swap:   3812.0 total,   3812.0 free,      0.0 used. 366194.1 
>>> avail Mem
>>>
>>>
>>> When now reading a file with a process bound to a cpu on node 1 (taskset
>>> -c cat $file) we see the high io_schedule_timeout rate and very low read
>>> performance.
>>>
>>> This is seen with linux 6.1.76 (debian 12 stable) and linux 6.7.9
>>> (debian unstable).
>>>
>>>
>>> It appears the bulk page allocations used by btrfs_alloc_page_array will
>>> have a high failure rate when the per cpu page lists are empty and they
>>> do not appear to attempt to reclaim memory from the page cache but
>>> instead return a single page via the normal page allocations. But this
>>> combined with memalloc_retry_wait called on each iteration causes very
>>> slow performance.
>>
>> Not an expert on NUMA, but I guess there should be some way to balance
>> the free memory between different numa nodes?
>>
>> Can it be done automatically/periodically as a workaround?
> 
> Dropping data from the page cache is the workaround we are using, via 
> fadvice(DONTNEED) on the data.
> 
> Balancing the memory between numa nodes will not help. At some point 
> both nodes memory is in the caches and the same situation will occur on 
> both nodes.
> 
> I have verified this loading the caches on both nodes:
> 
> # numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 
> 42 44 46 48 50 52 54 56 58 60 62
> node 0 size: 192048 MB
> node 0 free: 2316 MB
> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 
> 43 45 47 49 51 53 55 57 59 61 63
> node 1 size: 193524 MB
> node 1 free: 327 MB
> 
> and now loading files with processes bound to either node is affected by 
> this. ]
> 
> 
>>
>>>
>>> Increasing sysctl vm.percpu_pagelist_high_fraction did not yield any
>>> improvement for the situation, the only workaround seems to be to free
>>> the page cache on the nodes before reading the data.
>>>
>>> Assuming the bulk page allocations functions are intended to not reclaim
>>> memory when the per core lists are empty probably the way
>>> btrfs_alloc_page_array handles failure of bulk allocation should be
>>> revised.
>>
>> Any suggestion for improvement?
>>
>> In our usage, we can not afford to reclaim page cache, as that may
>> trigger page writeback, meanwhile we may also in the page writeback path
>> and can lead to deadlock.
>>
>> On the other hand, if we allocate pages for compressed read/write from
>> other NUMA nodes, wouldn't that cause different performance problems?
>> E.g. we still need to do compression using the page from the remote numa
>> nodes, wouldn't that also greatly reduce the compression speed?
> 
> The problem we see is not the page allocation itself but the looping on 
> memalloc_retry_wait when the bulk allocation falls back to single page 
> allocations due to empty per cpu page lists.
> 
> My naive suggestion would be to revert the bulk allocation 
> (91d6ac1d62c3dc0f102986318f4027ccfa22c638) and do single page 
> allocations again. As far as I can tell the bulk allocation was done for 
> performance reasons not to avoid deadlocks due to writeback.
> 
> If the performance gain by the bulk allocation is very significant maybe 
> the looping on memalloc_retry_wait can be done in some better way but I 
> am unfamiliar with the details here on why the single page allocation 
> did not need to do a retry-wait loop and the bulk page allocation does.

I believe you're right.

The common scheme for bulk allocation should be try the bulk/optimized 
version, if failed fallback to the single allocation one.

In fact, that's exactly what's I'm trying to do for larger folio support 
for btrfs metadata.
In that case, we try larger folio first, then fallback to regular 
btrfs_alloc_page_array().

So mind to test the attached patch to see if it solves the problem for you?
The patch would exactly do what I said above, try bulk allocation first, 
then go single page allocation for the remaining ones, since this 
version no longer do any way, the behavior should be more or less the 
same, meanwhile still keep the bulk attempt to benefit from it.

Thanks,
Qu

> 
> 
> Cheers,
> 
> Julian Taylor
> 
> 
--------------jyjBFaXCxLZ2Uc0Fhu3rrhno
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-fallback-to-single-page-allocation-to-avoid-bu.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-fallback-to-single-page-allocation-to-avoid-bu.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMGJkYmRjZDkxZmFhOGVlYmMxN2ZmN2FhNDkzOGQ2ZDFiZWY5Y2JiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ZDBiZGJkY2Q5MWZhYThlZWJjMTdmZjdh
YTQ5MzhkNmQxYmVmOWNiYi4xNzExMDkyOTk0LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBGcmksIDIyIE1hciAyMDI0IDE3OjU2OjQy
ICsxMDMwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGZhbGxiYWNrIHRvIHNpbmdsZSBwYWdl
IGFsbG9jYXRpb24gdG8gYXZvaWQgYnVsawogYWxsb2NhdGlvbiBsYXRlbmN5CgpbQlVHXQpU
aGVyZSBpcyBhIHJlY2VudCByZXBvcnQgdGhhdCBjb21wcmVzc2lvbiBpcyB0YWtpbmcgYSBs
b3Qgb2YgdGltZQp3YWl0aW5nIGZvciBtZW1vcnkgYWxsb2NhdGlvbi4KCltDQVVTRV0KRm9y
IGJ0cmZzX2FsbG9jX3BhZ2VfYXJyYXkoKSB3ZSBhbHdheXMgZ28gYWxsb2NfcGFnZXNfYnVs
a19hcnJheSgpLCBhbmQKZXZlbiBpZiB0aGUgYnVsayBhbGxvY2F0aW9uIGZhaWxlZCB3ZSBz
dGlsbCByZXRyeSBidXQgd2l0aCBleHRyYQptZW1hbGxvY19yZXRyeV93YWl0KCkuCgpJZiB0
aGUgYnVsayBhbGxvYyBvbmx5IHJldHVybmVkIG9uZSBwYWdlIGEgdGltZSwgd2Ugd291bGQg
c3BlbmQgYSBsb3Qgb2YKdGltZSBvbiB0aGUgcmV0cnkgd2FpdC4KCltGSVhdCkluc3RlYWQg
b2YgYWx3YXlzIHRyeWluZyB0aGUgc2FtZSBidWxrIGFsbG9jYXRpb24sIGZhbGxiYWNrIHRv
IHNpbmdsZQpwYWdlIGFsbG9jYXRpb24gaWYgdGhlIGluaXRpYWwgYnVsayBhbGxvY2F0aW9u
IGF0dGVtcHQgZG9lc24ndCBmaWxsIHRoZQp3aG9sZSByZXF1ZXN0LgoKUmVwb3J0ZWQtYnk6
IEp1bGlhbiBUYXlsb3IgPGp1bGlhbi50YXlsb3JAMXVuZDEuZGU+Ckxpbms6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC84OTY2YzA5NS1jYmU3LTRkMjItOTc4NC1hNjQ3ZDFiZjI3
YzNAMXVuZDEuZGUvClNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPgot
LS0KIGZzL2J0cmZzL2V4dGVudF9pby5jIHwgMzUgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnRfaW8uYyBiL2ZzL2J0cmZz
L2V4dGVudF9pby5jCmluZGV4IDc0NDEyNDViMWNlYi4uZDQ5ZTdmMDM4NGVkIDEwMDY0NAot
LS0gYS9mcy9idHJmcy9leHRlbnRfaW8uYworKysgYi9mcy9idHJmcy9leHRlbnRfaW8uYwpA
QCAtNjgxLDMzICs2ODEsMjIgQEAgc3RhdGljIHZvaWQgZW5kX2JiaW9fZGF0YV9yZWFkKHN0
cnVjdCBidHJmc19iaW8gKmJiaW8pCiBpbnQgYnRyZnNfYWxsb2NfcGFnZV9hcnJheSh1bnNp
Z25lZCBpbnQgbnJfcGFnZXMsIHN0cnVjdCBwYWdlICoqcGFnZV9hcnJheSwKIAkJCSAgIGdm
cF90IGV4dHJhX2dmcCkKIHsKKwljb25zdCBnZnBfdCBnZnAgPSBHRlBfTk9GUyB8IGV4dHJh
X2dmcDsKIAl1bnNpZ25lZCBpbnQgYWxsb2NhdGVkOwogCi0JZm9yIChhbGxvY2F0ZWQgPSAw
OyBhbGxvY2F0ZWQgPCBucl9wYWdlczspIHsKLQkJdW5zaWduZWQgaW50IGxhc3QgPSBhbGxv
Y2F0ZWQ7Ci0KLQkJYWxsb2NhdGVkID0gYWxsb2NfcGFnZXNfYnVsa19hcnJheShHRlBfTk9G
UyB8IGV4dHJhX2dmcCwKLQkJCQkJCSAgIG5yX3BhZ2VzLCBwYWdlX2FycmF5KTsKLQotCQlp
ZiAoYWxsb2NhdGVkID09IG5yX3BhZ2VzKQotCQkJcmV0dXJuIDA7Ci0KLQkJLyoKLQkJICog
RHVyaW5nIHRoaXMgaXRlcmF0aW9uLCBubyBwYWdlIGNvdWxkIGJlIGFsbG9jYXRlZCwgZXZl
bgotCQkgKiB0aG91Z2ggYWxsb2NfcGFnZXNfYnVsa19hcnJheSgpIGZhbGxzIGJhY2sgdG8g
YWxsb2NfcGFnZSgpCi0JCSAqIGlmICBpdCBjb3VsZCBub3QgYnVsay1hbGxvY2F0ZS4gU28g
d2UgbXVzdCBiZSBvdXQgb2YgbWVtb3J5LgotCQkgKi8KLQkJaWYgKGFsbG9jYXRlZCA9PSBs
YXN0KSB7Ci0JCQlmb3IgKGludCBpID0gMDsgaSA8IGFsbG9jYXRlZDsgaSsrKSB7Ci0JCQkJ
X19mcmVlX3BhZ2UocGFnZV9hcnJheVtpXSk7Ci0JCQkJcGFnZV9hcnJheVtpXSA9IE5VTEw7
Ci0JCQl9Ci0JCQlyZXR1cm4gLUVOT01FTTsKLQkJfQotCi0JCW1lbWFsbG9jX3JldHJ5X3dh
aXQoR0ZQX05PRlMpOworCWFsbG9jYXRlZCA9IGFsbG9jX3BhZ2VzX2J1bGtfYXJyYXkoR0ZQ
X05PRlMgfCBnZnAsIG5yX3BhZ2VzLCBwYWdlX2FycmF5KTsKKwlmb3IgKDsgYWxsb2NhdGVk
IDwgbnJfcGFnZXM7IGFsbG9jYXRlZCsrKSB7CisJCXBhZ2VfYXJyYXlbYWxsb2NhdGVkXSA9
IGFsbG9jX3BhZ2UoZ2ZwKTsKKwkJaWYgKHVubGlrZWx5KCFwYWdlX2FycmF5W2FsbG9jYXRl
ZF0pKQorCQkJZ290byBlbm9tZW07CiAJfQogCXJldHVybiAwOworZW5vbWVtOgorCWZvciAo
aW50IGkgPSAwOyBpIDwgYWxsb2NhdGVkOyBpKyspIHsKKwkJX19mcmVlX3BhZ2UocGFnZV9h
cnJheVtpXSk7CisJCXBhZ2VfYXJyYXlbaV0gPSBOVUxMOworCX0KKwlyZXR1cm4gLUVOT01F
TTsKIH0KIAogLyoKLS0gCjIuNDQuMAoK

--------------jyjBFaXCxLZ2Uc0Fhu3rrhno--

