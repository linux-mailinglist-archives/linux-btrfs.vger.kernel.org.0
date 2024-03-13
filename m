Return-Path: <linux-btrfs+bounces-3240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109E87A2F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 07:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AAC1F224A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 06:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63B13ADD;
	Wed, 13 Mar 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TS4edoqN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0B11738
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311186; cv=none; b=dKZ2kbcOO97/IHyQF7tam58yWytfhBv/6fDXx1LLesUdSTrK9eKfoi41OO0KIZaXNlV8+JKviInJhdJY8zSCgnnhMLxyBfhlOEGIgs57H5zOzgx+101dD1zYECDKn7MNf5SvKZdQqOfMYdfED867FxSUMyt9IH0prfJ0PwK8nx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311186; c=relaxed/simple;
	bh=TL3uzTyI4BTwEwjhZ9G/xkkfgwDgIOWY4Ph+gtHelIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g428Solfm4zBNDo/C6LpQNbEfHXdvwA9vILb5DAYkvPKA95OBuy2D6chS19Shuw5uOYQvTMhEhH+lP8qgFBewuD95/ffi0YAsT8Iu5p5WSwPoXOu/ukBhUL2+fSa4TOlE1SLe8yBvg40HmHi72ai66KDpzuQeU3PlezKwNKR9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TS4edoqN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1710311181; x=1710915981; i=quwenruo.btrfs@gmx.com;
	bh=TL3uzTyI4BTwEwjhZ9G/xkkfgwDgIOWY4Ph+gtHelIk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TS4edoqNiOucI7XBLSJVQomtSNgm+vsrFccPMdh3c8Y9Bo/R91UdeMikf2Qc1DGY
	 /0c5lE9LLYxgOHcF5EsZRXgJIfYIXI0Zeyww73Uum5jTKSwkrO08YrbvWvsPktV+p
	 8AKn7MhAIyyPAHn0nxnHOard5OwDDeT13yaFgptn7a0Gek25mC8pu26rdAGRCCH9r
	 WGVlqtumdQdcEwa02qJuFj2eWpjbEDLBZCi9Vb4L6atqqQ0OLVaNMD3JeRmXwomXd
	 MWMhtfwK6OB5pqvzrIYULbHp3dOdtZbbFyep+/AQtfaqKQ7LRjA9vlKyZ5CkihbY5
	 q/X/USuxluUCT3LDYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1rbnUV2kUt-009dBZ; Wed, 13
 Mar 2024 07:26:21 +0100
Message-ID: <9d66a2e0-96a5-4aea-acf3-732d6667e60e@gmx.com>
Date: Wed, 13 Mar 2024 16:56:17 +1030
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
In-Reply-To: <8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eCRN98hUq/WogCU2CBpFtiXFbtaN/Ja09b6X5HIw+dz23sZPmii
 HO0+1BB9WpRSbzmyi1HRh5RZsbTYB4+0fZdvwq5Li/k37rZuEIfFo19oGl5pQoZbgBzosoE
 eQx/ErLNSC0RWlkZ1vr/h11q93vUTVtLGlhOe4fmSwQuV5t8lql5mm7j4XO7QWt6mwlZYnB
 +J71xxf69bfHh9M5rky8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AvKchCFPSD4=;umBJmepfyS0W6rxu1WmNZif+8D5
 Dcy5eDpR8/znHUdIrvL+8+cZloQqkTWTr9SeTKxINlYVSs/frotMvIJ94LU6RAHhfnCBorsOo
 h0fctyNVi1eoEoelHDtsHOvj6RFPZsN394YBzpXSkuf5ewAGW2AF9kIMT03R38aUzuMysBrjr
 4/qWAXy/89Hbri5AC+oo5vjKbBrIhVoEp5miDtIY7HKnJLG/47N58oOHnKkfLhWq1j1B7CKam
 3LoQzjWxyZgsOH/u02Ae0odquk9MGia+BAtZg2YbxMfWOqQhxjZj2Gk8hvvx2zo81Ul4mkb/M
 E74gCRA9KdJPoJFHPeliouDi3W6gyVZFWzpS4sLBaUQZTIoOr0FH3g36MwJCNgCF0V5nc07Tw
 P233bS8eLl91gUpczYOfTG4WHM/IgvP02/eRDeWJSPRFnjwOTovSKn74QLNu4eYsgy38b9pIb
 HXr45TQvoQCbB2uFRYmnXm421kQSQZOkbU7q8W1fapGnd3XJr4LB9/PmyiMLjwU2jTlNS33xI
 JHVRfCsdg99X6bMgYg0t+v8Hq4Ic7oAwX1/XRcZ20YIYwtxf62eUhzxeE6Ktwymx9VS7dNjH2
 DgGpTjAEYdJ0boN1T5xf7oQ27Kf2WcrZ2MpXgo77Ss/4riQG+aG9baELXmUcK0T7m/3a4Qb8i
 Cpv0vAehTaMwKFgIDvxzmmsOgvQhVUgq3kwfL2lD9aIhKAwMymr26cHDwgeOa1YfSK+WAeJx6
 a+dViOuz6wjnoXxP4IMY2V9ogPiY17qhURyjk3uV4kYa2ldhwRVPsIICmW6FdHw4I7qzKlGm4
 CAZz2l/5giJZYSNno6kaZrxc91ILE32sOvNsvf6XeIgAE=



=E5=9C=A8 2024/3/13 00:05, Julian Taylor =E5=86=99=E9=81=93:
> Hello,
>
> After upgrading a machine using btrfs to a 6.1 kernel from 5.10 we are
> experiencing very low read performance on some (compressed) files when
> most of the nodes memory is in use by applications and the filesystem
> cache. Reading some files does not exceed 5MiB/second while the
> underlying disks can sustain ~800MiB/s. The load on the machine while
> reading the files slowly is basically zero
>
> The filesystem is mounted with
>
>  =C2=A0btrfs (rw,relatime,compress=3Dzstd:3,space_cache=3Dv2,subvolid=3D=
5,subvol=3D/)
>
> The filesystem contains several snapshot volumes.
>
> Checking with blktrace we noticed a lot of queue unplug events which
> when traced showed that the cause is most likely io_schedule_timeout
> being called extremely frequent from btrfs_alloc_page_array which since
> 5.19 (91d6ac1d62c3dc0f102986318f4027ccfa22c638) uses bulk page
> allocations with a memalloc_retry_wait on failure:
>
> $ perf record -e block:block_unplug -g
>
> $ perf script
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffa3bbff86 blk_mq_flus=
h_plug_list.part.0+0x246
> ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffa3bbff86 blk_mq_flus=
h_plug_list.part.0+0x246
> ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffa3bb1205 __blk_flush=
_plug+0xf5 ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffa4213f15 io_schedule=
_timeout+0x45 ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffc0c74d42 btrfs_alloc=
_page_array+0x42 ([kernel.kallsyms])

Btrfs needs to allocate all the pages for the compressed extents, which
can be very large (as large as 128K, even if the read may only be 4K).

Furthermore, since your system have very high memory pressure, it also
means the page cache doesn't have much chance to cache the decompressed
contents.

Thus I'm afraid for your high memory pressure cases, it is not really
not a good use case with compression.
(Both compressed read and write would need extra pages other than the
inode page cache).

And considering your storage is very fast (800+MiB/s), there is really
little benefit for compression (other than saving disk usages).

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffc0ca8c2e btrfs_submi=
t_compressed_read+0x16e
> ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffc0c724f8 submit_one_=
bio+0x48 ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffc0c75295 btrfs_do_re=
adpage+0x415 ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffc0c766d1 extent_read=
ahead+0x2e1 ([kernel.kallsyms])
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffffa3904bf2 read_pages+=
0x82 ([kernel.kallsyms])
>
> When bottlenecked in this code the allocations of less than 10 pages
> only receives a single page per loop so it runs into the
> io_schedule_timeout every time.
>
> Tracing the arguments while reading on slow performance shows:
>
> # bpftrace -e "kfunc:btrfs_alloc_page_array {@pages =3D
> lhist(args->nr_pages, 0, 20, 1)} kretfunc:__alloc_pages_bulk {@allocret
> =3D lhist(retval, 0, 20, 1)}"
> Attaching 2 probes...
>
>
> @allocret:
> [1, 2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 298
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
> [2, 3)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 295
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
> [3, 4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 295
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
> [4, 5)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 300
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
> @pages:
> [4, 5)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 295
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
>
> Further checking why the bulk page allocations only return a single page
> we noticed this is only happening when all memory of the node is tied up
> even if still reclaimable.
>
> It can be reliably reproduced on the machine when filling the page cache
> with data from the disk (just via cat * >/dev/null) until we are have
> following memory situation on the node with two sockets:
>
> $numactl --hardware
>
> available: 2 nodes (0-1)
>
> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40
> 42 44 46 48 50 52 54 56 58 60 62
> node 0 size: 192048 MB
> node 0 free: 170340 MB
> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41
> 43 45 47 49 51 53 55 57 59 61 63
> node 1 size: 193524 MB
> node 1 free: 224 MB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <<< nothin=
g free due to cache

This is interesting, such unbalanced free memory is indeed going to
cause problems.

>
> $ top
>
> MiB Mem : 385573.2 total, 170093.0 free,=C2=A0 19379.1 used, 201077.9 bu=
ff/cache
> MiB Swap:=C2=A0=C2=A0 3812.0 total,=C2=A0=C2=A0 3812.0 free,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.0 used. 366194.1 avail Mem
>
>
> When now reading a file with a process bound to a cpu on node 1 (taskset
> -c cat $file) we see the high io_schedule_timeout rate and very low read
> performance.
>
> This is seen with linux 6.1.76 (debian 12 stable) and linux 6.7.9
> (debian unstable).
>
>
> It appears the bulk page allocations used by btrfs_alloc_page_array will
> have a high failure rate when the per cpu page lists are empty and they
> do not appear to attempt to reclaim memory from the page cache but
> instead return a single page via the normal page allocations. But this
> combined with memalloc_retry_wait called on each iteration causes very
> slow performance.

Not an expert on NUMA, but I guess there should be some way to balance
the free memory between different numa nodes?

Can it be done automatically/periodically as a workaround?

>
> Increasing sysctl vm.percpu_pagelist_high_fraction did not yield any
> improvement for the situation, the only workaround seems to be to free
> the page cache on the nodes before reading the data.
>
> Assuming the bulk page allocations functions are intended to not reclaim
> memory when the per core lists are empty probably the way
> btrfs_alloc_page_array handles failure of bulk allocation should be
> revised.

Any suggestion for improvement?

In our usage, we can not afford to reclaim page cache, as that may
trigger page writeback, meanwhile we may also in the page writeback path
and can lead to deadlock.

On the other hand, if we allocate pages for compressed read/write from
other NUMA nodes, wouldn't that cause different performance problems?
E.g. we still need to do compression using the page from the remote numa
nodes, wouldn't that also greatly reduce the compression speed?

Thanks,
Qu
>
>
> Cheers,
>
> Julian Taylor
>
>

