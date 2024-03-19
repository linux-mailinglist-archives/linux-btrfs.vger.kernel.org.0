Return-Path: <linux-btrfs+bounces-3454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6088075D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200482842DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5B40BF2;
	Tue, 19 Mar 2024 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="YznyxPkA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A86364D4
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888553; cv=none; b=P5EERT5rVrvrAjQDYpPieEEl52CJLis4SnE5652+VNPjqjie5dfGvBpyJSRG0Ym63NX+z+s7R0I9HKuPwayfscMuoNzNQ4RgSLc9h1vhgoiEANLcsAVGzFMMjvw9JU9Czin70oHkK5k+jl9rjk9gPY6qSI3QRsighfgIAyDogEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888553; c=relaxed/simple;
	bh=lvw0kzdUqkE5XJGIOVLLJwggITiiUYRepcGKUix6CHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ulR0P1XyTbUdz9pq5oJOWKqTknN9omgeWrcwnXRfQVfgH0NGFRmZXj1zm+DuNyu6Du5NV+AuhbrXOmTbHvoOBhskqDtafWvYNt0ynnVTD0IAY3jA+fxP+1QGtavb+S/7pITozK+ZcOd4fg6UGty7gXEDtT8yRY4gHcEE0xoY2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=YznyxPkA; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710888544; x=1711493344; i=devzero@web.de;
	bh=lvw0kzdUqkE5XJGIOVLLJwggITiiUYRepcGKUix6CHc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=YznyxPkAqEC+hGzbqL2mT//dDvj17GexKfFKP2h6O3qIEvaixrb5oZnk8hVIZ5Ag
	 me65dXjdQXwZ+sKSyK7vaScmxCbiRtdiElgeTkRqGHl7YO6RXFKlk2y+t2bUIpu0h
	 QtJB9nEdpIshmgpkMcchlovIb5FEq8KTswL1dMDm5v1bpuTgd7kPGi5bY2bm2yMzq
	 J2KBmU/2gbG6VHQk4IbL2pKvW66m3cPQwtHeJnlbBi59IG49pML7aVhrcy8mdNfE0
	 weWqKaeGyUNKeYG06bfPNf4Q/zqCiECAWY/kadzzNqYkqpESTmq1rSHr06EDifSJh
	 Mxv8zSYLQVs5nTwUjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.103] ([213.196.208.136]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGyK-1rVj540CbW-00JkV3; Tue, 19
 Mar 2024 23:49:04 +0100
Message-ID: <581c951a-f120-460f-8e7f-415d07bc1faa@web.de>
Date: Tue, 19 Mar 2024 23:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: compression silently skipped with O_DIRECT & checksum/corruption
 issue with qemu live migration ?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, HAN Yuwei <hrx@bupt.moe>,
 linux-btrfs@vger.kernel.org
References: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
 <89d0cad2-64b2-4699-b6de-6727398d50d6@gmx.com>
 <B9AE3A7AE8BC6048+54d80a89-2099-4378-a615-ce05899ecf40@bupt.moe>
 <6ccab6fe-b6b7-4c04-b631-6b450a05b021@gmx.com>
From: Roland <devzero@web.de>
In-Reply-To: <6ccab6fe-b6b7-4c04-b631-6b450a05b021@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2mlGV5Nn4Lh1npgKxjTysV0wG3A9U0hTIu6qJgdFK/pdUqvUH7
 svCGmzYg80xy17zUfYzCKL4JLerT/Uuko1EFB9rpSuH/LkHA2i4BaUGZmokqv478uygviau
 c44G77vElik/9vRulqygfb8cLKCtqn11bjL6ddt5m/+94P5jX+tq4zrSGt+LWxk50lbJQgB
 BMkgvTm5KASVhg3VEorxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i8+Zjc7JG0o=;bsZyZxA26QoYC0Og1ZPVp7voh8U
 3tvoIyWpCmhG6d2yRog9ouP+jtFQoSMBlPArsHbde3a1+mTzYEfh2iGmj+ITFdW1WZQ3wjk0M
 V3FxuR/YBEWA+6x+EjfZDNygW+Uq2e401c4iYC13MLy5MnIcZ72JiKBgNOprRDcN4jD+Lj90/
 YXozvi48G5aTv024EMGYtXwiDvWFbOvl/MvAFGKP94hvjzqYYvD5/dTddjTuup3r9WGMkgdPz
 9jpM8IzNaeLp449RygYMXro6qQLnRRxduU2LknIPMZ+Pr46QFBf0wRaP9OQt/MCp256vhv473
 SHWlObpQCibcsCP7xnJr+zpfsxRrTGtCRWPVUIufMaH5BrxEVMMpyTKd6oz+8vwQikhUfUuiW
 b8BafSPzZ5h4Ca3jfD2z9qAmCxRsxGVKkLRSiBtV4u6/PKnVHrJqB7f9L5HU4qf7aYnXeE0jr
 R/7RDA2nb/SvbyJYGb1n5x1Q/kbODeJBqgMm+6X0R0SQsvNo1npRXQD8IeVXpTRCjCnLmDRgM
 /uNdglc/rU4HxLReMhxCOsFi5Ee4gieqB+70LQg8+v0kNuUAscMimAGge5JwNI8EIN9vSSjP2
 NohX1L/VnRkB3qtzPDrku3/Fz0Hnm79QPxTNMwkEIjllcGBceyBU6C06WbYR0i2jvZ4nWRFrq
 tHoZyqueLY11+O2I4NMxS2ubxANpQDBIp+3+mh6njujZQhsnmbLK13g2rlXZDI+vPdrjafX5B
 AGY47iWWu7suRv9P1VRIp+acn+MIDYsP0hqxfTuoQEki2jbhjaggMt4587HaMUPuSlCBIh2iO
 3tBKq+RO08y2mlAgE7UatwQS+jrSfXeYqF/u9K7tONTvA=

thanks for all your feedback

Am 19.03.24 um 05:18 schrieb Qu Wenruo:
>
>
> =E5=9C=A8 2024/3/19 14:46, HAN Yuwei =E5=86=99=E9=81=93:
>>
>> =E5=9C=A8 2024/3/18 17:19, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2024/3/16 06:09, Roland =E5=86=99=E9=81=93:
>>>> Hello,
>>>>
>>>> can someone explain why compression is skipped when writing with
>>>> direct-i/o ?
>>>
>>> Because compression only happen with buffered write.
>>>
>>> For direct IO we either go NOCOW or regular COW, no compression
>>> support.
>>>
>> Should we mention this (no compression in O_DIRECT) in doc? I haven't
>> impression that doc said this.
>
> I'd say yes, since there is already some confusion, feel free to submit
> a patch for the doc.
>
> Thanks,
> Qu
>
>>> The current compression code is always using page cache, just check th=
e
>>> different algo implementations of btrfs_compress_pages(), which all
>>> fetch their data from page cache.
>>>
>>> E.g. in zstd_compress_pages(), we go find_get_page() to grab the page
>>> from page cache as compression source.
>>>
>>> This is incompatible with the direct IO scheme, which is designed to
>>> avoid page cache completely (unless fall back to buffered write).
>>>
>>> Maybe it's possible to make all those *_compress_pages() to support
>>> direct IO, but that doesn't looks sane to me.
>>>
>>> As the idea of direct IO is to fully avoid page cache, and allow the
>>> user space program to take full control of its own cache, doing
>>> compression would introduce extra latency and make the performance
>>> characteristic much complex to user space.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> is this to be expected ?
>>>>
>>>> i wondered why i got uncompressed raw disk images in proxmox after
>>>> disk
>>>> migration to btrfs fs with compress-force=3Dzstd, so i tried with dd
>>>> if i
>>>> can reproduce - and i can.
>>>>
>>>> the problem is, that i cannot seem to disable direct I/O for differen=
t
>>>> proxmox gui actions, will discuss in proxmox community what can be
>>>> done,
>>>> but i need more infos on this behaviour.
>>>>
>>>> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
>>>> if=3Ddisk.raw of=3Dtest.dat bs=3D1024k
>>>> 20480+0 Datens=C3=A4tze ein
>>>> 20480+0 Datens=C3=A4tze aus
>>>> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 46,411 s, 463 MB/s
>>>>
>>>> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
>>>> compsize test.dat
>>>> Processed 1 file, 161844 regular extents (161844 refs), 0 inline,
>>>> 85412
>>>> fragments.
>>>> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0=
 Disk Usage=C2=A0=C2=A0 Uncompressed Referenced
>>>> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7%=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.5G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=
G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
>>>> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 339M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M
>>>> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6%=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 1.2G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 19G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19G
>>>>
>>>> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
>>>> if=3Ddisk.raw of=3Dtest.dat oflag=3Ddirect bs=3D1024k
>>>> 20480+0 Datens=C3=A4tze ein
>>>> 20480+0 Datens=C3=A4tze aus
>>>> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 161,319 s, 133 MB/s
>>>>
>>>> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
>>>> compsize test.dat
>>>> Processed 1 file, 20480 regular extents (20480 refs), 0 inline, 1035
>>>> fragments.
>>>> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0=
 Disk Usage=C2=A0=C2=A0 Uncompressed Referenced
>>>> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
>>>> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
>>>>
>>>> furthermore,=C2=A0 with qemu/proxmox virtual disk live migration, i'm
>>>> getting
>>>> reproducible checksum error with btrfs/compress-force=3Dzstd when liv=
e
>>>> migrating virtual disk within same harddisk , whereas copying the sam=
e
>>>> disk/file with dd (cached and direct) does not trigger that.
>>>>
>>>> happens on hdd and also on hdd, so this seems not to be disk related
>>>>
>>>> # uname -a
>>>> Linux pve-test1 6.5.13-1-pve #1 SMP PREEMPT_DYNAMIC PMX 6.5.13-1
>>>> (2024-02-05T13:50Z) x86_64 GNU/Linux
>>>>
>>>> regards
>>>> Roland
>>>>
>>>>
>>>> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): csum fail=
ed
>>>> root
>>>> 260 ino 257 off 6655332352 csum 0x5517115a expected csum 0x6b2af31e
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS error (device sda1): bdev /dev/s=
da1
>>>> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>>> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): direct IO
>>>> failed
>>>> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>>>> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): csum fail=
ed
>>>> root
>>>> 260 ino 257 off 6655332352 csum 0xd1d1c892 expected csum 0x0c24b5cd
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS error (device sda1): bdev /dev/s=
da1
>>>> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>>> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): direct IO
>>>> failed
>>>> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>>>> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): csum fail=
ed
>>>> root
>>>> 260 ino 257 off 6655332352 csum 0x809096c2 expected csum 0x56b58dc6
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS error (device sda1): bdev /dev/s=
da1
>>>> errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>>> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): direct IO
>>>> failed
>>>> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>>>> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): csum fail=
ed
>>>> root
>>>> 260 ino 257 off 6655332352 csum 0xc8a6977d expected csum 0xdfc1f678
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS error (device sda1): bdev /dev/s=
da1
>>>> errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): direct IO
>>>> failed
>>>> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>>>>
>>>> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): csum fail=
ed
>>>> root
>>>> 260 ino 257 off 6655332352 csum 0x20ff0887 expected csum 0x08ed0bce
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS error (device sdc1): bdev /dev/s=
dc1
>>>> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>>> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): direct IO
>>>> failed
>>>> ino 257 op 0x0 offset 0x18cb02000 len 16384 err no 10
>>>> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): csum fail=
ed
>>>> root
>>>> 256 ino 290 off 6655332352 csum 0xb023863a expected csum 0x4f8e355d
>>>> mirror 1
>>>> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS error (device sdc1): bdev /dev/s=
dc1
>>>> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>>> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): direct IO
>>>> failed
>>>> ino 290 op 0x0 offset 0x18cb05000 len 4096 err no 10
>>>>
>>>> create full clone of drive scsi0
>>>> (btrfs-ssd-zstd-qcow2:106/vm-106-disk-0.raw)
>>>> drive mirror is starting for drive-scsi0
>>>> drive-scsi0: transferred 34.2 MiB of 20.0 GiB (0.17%) in 0s
>>>> drive-scsi0: transferred 301.6 MiB of 20.0 GiB (1.47%) in 1s
>>>> drive-scsi0: transferred 489.1 MiB of 20.0 GiB (2.39%) in 2s
>>>> drive-scsi0: transferred 679.9 MiB of 20.0 GiB (3.32%) in 3s
>>>> drive-scsi0: transferred 1.1 GiB of 20.0 GiB (5.70%) in 4s
>>>> drive-scsi0: transferred 1.4 GiB of 20.0 GiB (6.89%) in 5s
>>>> drive-scsi0: transferred 1.7 GiB of 20.0 GiB (8.55%) in 6s
>>>> drive-scsi0: transferred 1.9 GiB of 20.0 GiB (9.53%) in 7s
>>>> drive-scsi0: transferred 2.2 GiB of 20.0 GiB (10.97%) in 8s
>>>> drive-scsi0: transferred 2.4 GiB of 20.0 GiB (11.84%) in 9s
>>>> drive-scsi0: transferred 2.8 GiB of 20.0 GiB (13.89%) in 10s
>>>> drive-scsi0: transferred 2.9 GiB of 20.0 GiB (14.74%) in 11s
>>>> drive-scsi0: transferred 6.2 GiB of 20.0 GiB (31.14%) in 12s
>>>> drive-scsi0: transferred 8.2 GiB of 20.0 GiB (41.17%) in 13s
>>>> drive-scsi0: transferred 10.3 GiB of 20.0 GiB (51.27%) in 14s
>>>> drive-scsi0: transferred 10.5 GiB of 20.0 GiB (52.75%) in 15s
>>>> drive-scsi0: transferred 19.2 GiB of 20.0 GiB (95.86%) in 16s
>>>> drive-scsi0: transferred 19.3 GiB of 20.0 GiB (96.66%) in 17s
>>>> drive-scsi0: transferred 19.5 GiB of 20.0 GiB (97.46%) in 18s
>>>> drive-scsi0: transferred 19.7 GiB of 20.0 GiB (98.27%) in 19s
>>>> drive-scsi0: transferred 19.8 GiB of 20.0 GiB (99.08%) in 20s
>>>> drive-scsi0: Cancelling block job
>>>> drive-scsi0: Done.
>>>> TASK ERROR: storage migration failed: block job (mirror) error:
>>>> drive-scsi0: 'mirror' has been cancelled
>>>>
>>>>
>>>

