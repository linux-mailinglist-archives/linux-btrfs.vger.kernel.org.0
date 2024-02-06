Return-Path: <linux-btrfs+bounces-2172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C661C84BED0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F20B25558
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B61B81C;
	Tue,  6 Feb 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="W6zXAbIZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675841B80F
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252006; cv=none; b=OJ7YGsiTna41VrNSJINM8iXjVEdXBTuPIAnBG4rxW2CqvMz+zvfcNb4EB4lAP97q4oNj8bBwAR/t2cxjs9RyXv0NCfX5IlkNIUe5wlP+medOTlNSni84x/la3inbz6wacSJpntGsjgZud+xKZpb/V7FBOnnRmr14pwHvIuelrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252006; c=relaxed/simple;
	bh=9liBrmpvTIEVwRHE2J8VGLQXO7HdvXdFJKsSnXmw+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geotfNVKa5tQY+DC09yYTq3XlB+y/AtLS0mpubKUGE1QmZfwMaxpFvktpxdVFuR0wTICSsrZOT7KLAIu9muYxQzNRhUEuVVCmea3ZjU5lc0dZI03kfd8C9a006SXpjsDTaMVaIOQMQC0kJ+9VVZQXUaKYYJtVvk5zNCOucbrRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=W6zXAbIZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707251999; x=1707856799; i=quwenruo.btrfs@gmx.com;
	bh=9liBrmpvTIEVwRHE2J8VGLQXO7HdvXdFJKsSnXmw+u0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=W6zXAbIZowuw8UPw5oKwR38Fcjrgh6VQ+CGRkLnoQUk4Y6VaZqcxspIKvWk5WSii
	 b3J2aMhOZ/CGnGQTmliZSVUdC3wue9Nk6POAOuJ1JumxPULLRO41z5i1QlT2R4mBN
	 bAJlVq54G5iWgEi4sFuBJiYzXOpsnPvQC/v9GoiL/6/eoSWkHo+UD0Wawyso2VQLp
	 3vhbd1+tVjcRoaEnqRAPcQwaSjcPEgCCCL3V2BLrfDSciReN78yQq6n9Ps12SxaMG
	 b/pH0C1fTHydeKyyMUXhSmvFGej93LKM3J9x7dpV/HdXqO+GPIwOTQHbS9F4mlN04
	 zHVJRcWVfelvTO4eAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU4y-1qzDwY2Wfc-00aUB9; Tue, 06
 Feb 2024 21:39:59 +0100
Message-ID: <60724d87-293d-495f-92ed-80032dab5c47@gmx.com>
Date: Wed, 7 Feb 2024 07:09:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
 <20240206201247.4120-1-tavianator@tavianator.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240206201247.4120-1-tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVOl3gYI2sZMK+ONyyfBPpmlCen6OO/adPQG0b26a8bYyj5hk/P
 1C7KPDC8K8dblg8deO6C0CcpUSvoy57xhfGq29yl12ZDQqIxuFdLUxcbEMfvPdkmBkCBu2T
 3977lsklGp413RRNGBftT1+jUMbvNHdvKiAAggec1kR6CG8Se3KNKdhgkHrtCFlDcrq4K7m
 gJYd0vmnIdcEt1k5xQ5Aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7kcrPso698E=;ApLLylXTLmGtWG52r4JlrB2QMKa
 08JL9COfRQEQcMyLn7Uo8nFXLc53e5VR+mSPNdG57qh0BfDV6ooAWX2gbHIBqqteZZWVxS4k0
 FGPqJ/cUsD879+MuqFCtxDQ8n5OBogYW1EyF/tWjzm3YdMIC/Iot846kimh/31160HbrQraD+
 6I119ZBTj8K1rwAInwG9krsBRSc/YldIk9Mq5d0HUnadeekiQebE+ApYXIPS2iAzSXFDPgO3v
 OlvIPlMsPYG4bpA6pLYY1V7zdtgkkpa6eAXnr3hZED1ZBTAcwecRpAI4iWVuYUA5WaJLXKfRe
 5LPx8mZQ33hk2mIilBNc0eFpIQQdj0TD8gVA5/p7LUiCJyMSZxPVfbDZH6AsMFjvYfTWwkT3i
 Ohm5k08m+A/JFSGPTbvd1B0XIpYYLXPi0IWDih7B8WJuCphUUkiFAZWZO4uEgM4zPyhgXhu54
 bq6l/3jRrGC+zWdfHVmMcnyCwoSVo2AGNqgchMWPeV1VeLvZliExkMA2jT9TRQuEsql2wbQ5a
 haEKRvxOgVtrxiVcDmKaYigwqZ+EaKEHw9jkay0FY+NL1arZu1hcz01EZ5Rz5ixm8g4Jm8vdc
 ZXRadXJVQVwir+c1qQFpUoQP8uy2H9OkN6csGgpSriHjyynC17VwhdpPRljXcbKyS1J9lK0et
 lfy34GmeQ4tzOTYX3wZTCzhtQzIs7PSqg8cVdwvWm3PYSOAtDha9LvTa/hm9G5Q3YcEOx7tL7
 Hz0gdcQT6quUptrgyHyHN2jmTGObcXVA74LWbvgZlIXjAlkRdre91s0zkhWkcf6I07u8AkaNY
 5CeAz38onrq2mPvQ3HKhyonOx+5bvJGuuvPorYQ1bigHk=



On 2024/2/7 06:42, Tavian Barnes wrote:
> On Tue, 6 Feb 2024 16:24:32 +1030, Qu Wenruo wrote:
>> On 2024/2/6 14:08, tavianator@tavianator.com wrote:
>>> Here's the corresponding dmesg output:
>>>
>>>       page:00000000789c68b4 refcount:4 mapcount:0 mapping:00000000ce99=
bfc3 index:0x7df93c74 pfn:0x1269558
>>>       memcg:ffff9f20d10df000
>>>       aops:btree_aops [btrfs] ino:1
>>>       flags: 0x12ffff180000820c(referenced|uptodate|workingset|private=
|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>>>       page_type: 0xffffffff()
>>>       raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f11=
8586feb8
>>>       raw: 000000007df93c74 ffff9f2232376e80 00000004ffffffff ffff9f20=
d10df000
>>>       page dumped because: eb page dump
>>>       BTRFS critical (device dm-1): corrupted leaf, root=3D709 block=
=3D8656838410240 owner mismatch, have 2694891690930195334 expect [256, 184=
46744073709551360]
>>
>> The page index and eb->start matches page index, so that page attaching
>> part is correct.
>>
>> And the refcount is also 4, which matches the common case.
>>
>> Although I still need to check the extra flags for workingset.
>
> I did get some other splats with refcount:3, e.g.
>
>      page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8eb49f38 pfn:0x17e8520
>      page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8eb49f38 pfn:0x17e8520
>      memcg:ffff9f211ab95000
>      page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8eb49f38 pfn:0x17e8520
>      memcg:ffff9f211ab95000
>      page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8eb49f38 pfn:0x17e8520
>      memcg:ffff9f211ab95000
>      memcg:ffff9f211ab95000
>      page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc=
3 index:0x8eb49f38 pfn:0x17e8520
>      memcg:ffff9f211ab95000
>      BTRFS critical (device dm-1): inode mode mismatch with dir: inode m=
ode=3D042255 btrfs type=3D2 dir type=3D1
>      aops:btree_aops [btrfs] ino:1
>      aops:btree_aops [btrfs] ino:1
>      aops:btree_aops [btrfs] ino:1
>      aops:btree_aops [btrfs] ino:1
>      aops:btree_aops [btrfs] ino:1
>      flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|privat=
e|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>      flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|privat=
e|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      page_type: 0xffffffff()
>      raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f11858=
6feb8
>      raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f11858=
6feb8
>      raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab=
95000
>      raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab=
95000
>      flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|privat=
e|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page dumped because: eb page dump
>      page dumped because: eb page dump
>      page_type: 0xffffffff()
>      BTRFS critical (device dm-1): corrupted leaf, root=3D136202 block=
=3D9806651031552 owner mismatch, have 174692946400338119 expect [256, 1844=
6744073709551360]
>      BTRFS critical (device dm-1): corrupted leaf, root=3D136202 block=
=3D9806651031552 owner mismatch, have 174692946400338119 expect [256, 1844=
6744073709551360]
>      flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|privat=
e|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>      raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f11858=
6feb8
>      raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab=
95000
>      page_type: 0xffffffff()
>      page dumped because: eb page dump
>      raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f11858=
6feb8
>      BTRFS critical (device dm-1): corrupted leaf, root=3D136202 block=
=3D9806651031552 owner mismatch, have 174692946400338119 expect [256, 1844=
6744073709551360]
>      raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab=
95000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-1): corrupted leaf, root=3D136202 block=
=3D9806651031552 owner mismatch, have 174692946400338119 expect [256, 1844=
6744073709551360]
>      flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|privat=
e|node=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f11858=
6feb8
>      raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab=
95000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-1): corrupted leaf, root=3D136202 block=
=3D9806651031552 owner mismatch, have 174692946400338119 expect [256, 1844=
6744073709551360]
>
>>> Here's my reproducer if you want to try it yourself.  It uses bfs, a
>>> find(1) clone I wrote with multi-threading and io_uring support.  I'm
>>> in the process of adding multi-threaded stat(), which is what I assume
>>> triggers the bug.
>>>
>>>       $ git clone "https://github.com/tavianator/bfs"
>>>       $ cd bfs
>>>       $ git checkout euclean
>>>       $ make release
>>>
>>> Then repeat these steps until it triggers:
>>>
>>>       # sysctl vm.drop_caches=3D3
>>>       $ ./bin/bfs /mnt -links 100
>>>       bfs: error: /mnt/slash/@/var/lib/docker/btrfs/subvolumes/f07d37d=
1c148e9fcdbae166a3a4de36eec49009ce651174d0921fab18d55cee6/dev/ram0: Struct=
ure needs cleaning.
>>
>> It looks like the mount point /mnt/ is pretty large with a lot of thing=
s
>> pre-populated?
>
> Right, /mnt contains a few filesystems.  /mnt/slash is my root fs (the
> subvolume @ is mounted as /).  It's quite large, with over 41 million
> files and 640 subvolumes.  It's a BTRFS RAID0 array on 4 1TB NVMEs with
> LUKS encryption.
>
>> I tried to populate the btrfs with my linux git repo (which is around
>> 6.5G with some GC needed), but even 256 runs didn't hit the problem.
>>
>> The main part of the script looks like this:
>>
>> for (( i =3D 0; i < 256; i++ )); do
>> 	mount $dev1 $mnt
>> 	sysctl vm.drop_caches=3D3
>> 	/home/adam/bfs/bin/bfs $mnt -links 100
>> 	umount $mnt
>> done
>>
>> And the device looks like this:
>>
>> /dev/mapper/test-scratch1  10485760  6472292   3679260  64% /mnt/btrfs
>
> I also noticed that it seems easier to reproduce right after a reboot.
> I failed to reproduce it this morning, but after a reboot it triggered
> immediately.
>
>> Although the difference is, I'm using btrfs/for-next branch
>> (https://github.com/btrfs/linux/tree/for-next).
>>
>> Maybe it's missing some fixes not yet in upstream?
>> My current guess is related to my commit 09e6cef19c9f ("btrfs: refactor
>> alloc_extent_buffer() to allocate-then-attach method"), but since I can
>> not reproduce it, it's only a guess...
>
> That's possible!  I tried to follow the existing code in
> alloc_extent_buffer() but didn't see any obvious races.  I will try agai=
n
> with the for-next tree and report back.

The most obvious way to proof is, if you can reproduce it really
reliably, then just go back to that commit and verify (it can still
cause the problem).
Then go one commit before for, and verify it doesn't cause the problem
anymore.

Although without a way to reproduce locally, it's really hard to say or
debug from my end.

Thanks,
Qu
>
>> Thanks,
>> Qu
>
> --
>
> Tavian Barnes

