Return-Path: <linux-btrfs+bounces-3345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC387E588
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBADB20C9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB128E34;
	Mon, 18 Mar 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G+Uhb1NI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAC28DCA
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753549; cv=none; b=o84mDnLrAtoe3hNPdJkjBm1P8JeBt8u+JNFEeyR8fqbFQqC3KTv2kz/Cf9P4X8CefUOWldRaUTsklxikkyRVmQ02/8zndGaIDNORAj4NcUMaZ4gde3U5YnFDY4/+t61AAg70jBOezOUb+dYiPR786/bOaGAoLibh+92AI5sgboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753549; c=relaxed/simple;
	bh=dgnhDMyZnqP9NYyl9TftdWZEiEN6GzzfMDN71NvxHhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JpFrzPBMToNbUm38bvR2uMpgMMQuU1cwLEQkvrk+hq1pkzVFs1hEhiYmGet+ERQRhNoZHlymvfDRR09OFO07h0Uy/i6r3R11GUVSadbigJNGduo4oO6oY8qbgwhjig1hqxtXEgT4bP78TVaf5w7DKPQBD2eVc/am7o0sK4Fh5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G+Uhb1NI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710753544; x=1711358344; i=quwenruo.btrfs@gmx.com;
	bh=dgnhDMyZnqP9NYyl9TftdWZEiEN6GzzfMDN71NvxHhE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=G+Uhb1NIBBcOE16+JqJVtrWqUM2b+5UF+HVJMfMgy9VDCQsP8T3u5qkyVRO5EK86
	 HoV6ijFNoWEo+HQ+WXgq8OCoVvm4jrUW9LrPuLRkS3uQijagpsFJKVC4qrcBLOk0Z
	 cx4GLeESYvE0CNKCHPp0GEms6OvjWwh6W6ZPOBhCjkTwaLMk+1bm0TJKtOKAVtv4E
	 cZ5fNv/v35kCr4g5li0EaHmAL6itpNCLZ3UtfDiIRPYejdM61s1ySxESoDZAmv5Dm
	 mYWa4juI2Llo92qwcKEs5/xoB9RKNPrQBoU9XlPUKozsuOurajYB/4qD9DoZ1qtGw
	 fUfICx9ATiaXdewX8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1qoA4z0xb3-011Elr; Mon, 18
 Mar 2024 10:19:04 +0100
Message-ID: <89d0cad2-64b2-4699-b6de-6727398d50d6@gmx.com>
Date: Mon, 18 Mar 2024 19:49:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: compression silently skipped with O_DIRECT & checksum/corruption
 issue with qemu live migration ?
Content-Language: en-US
To: Roland <devzero@web.de>, linux-btrfs@vger.kernel.org
References: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
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
In-Reply-To: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:obKEjpgUcxX36Y9/z2+w6QM9n7SW8gdH0ThhFbyzVDTzkNSKCCA
 7jIYIdVNDkMF/hp8aTAUH7lF7mfdLqHHPCUaAeOmkCXlidMFalvRt5xHjWIHut8SEBKUsaV
 iS3X6r7gDJVv7Jk+YkfSSrG4hs/QJPQhuy4HlDLjVXV0+0iZ4aFzJHw9ZAAGYYtDvNy23c7
 PuCM9Y+dregYzSpN/cRng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+MKpK556RLM=;mjohq+0fvMsSLy652Qh7oGP+/jm
 xRBWg4vF2+qBD4EChUD+05IIt99eniNyndyWA6KiCFGE5xEgz7IDTtIJfj8jbWTksv2gy/fgU
 th5K4bJWCYiHsoHgux1eHjmyBU4yvhR+PSgU2OJY8+Gnh7aqtBf7f8KxV1vDrmqaso2rV6VZD
 z9Ba1f2xr2HecWtbH97ErqoiQM6zCv+uVQRScIJ6sVbAhn3axYf/H/UyRiS9CFsdm0l+o9OwZ
 qjm+dcUn8fprCH+T13qvCW3Gqr+fZbeyi+Wt2Gg3iw42zn3EAzKS2BJ2VQH24y96ddZjhgUgd
 Y66ET9e+tKDjZKYy1CLBH2imWFLwybxnk//XXRjrqN6hR1DaqdJ5kovOLp6UzwjOuwjOGb4fS
 tUjhRgSfdjpQ016JjL1kD69TsXuhp5ttb5+FXaIL0n+OIC28O8uIiVoSWF9mu0mTicE4/pZ4C
 Vi2gFW9zINdHG2qU6evEo1FF8X7J5mQhCB3gRS+7YfctGWqp3D3HI/fRSYBQmgds1RVoZT5CZ
 anCrP52Kjcv+SywSD1eUen8hY8GCBzNnm+IGpsU4MtySAMZO2C9B6SoNQr8W1JsWoMOAT+lYB
 DqhkK6snwooO7IuvS6u3SB4RmWfSe87JxYb4YCS77BfmgvZJE7jCByCRUyapp71DBgGQlXiOd
 HZA8xXmgzB9hOc6gARSdhemz9Hk7rFhcg5d5gPiSN65JbfFOal68Y0nbnK0tRAhqU59cgcgzT
 ZZrX3FKmL1Odm3xIuqnk2f+dSHQEVTKkPNUOiN1rOap3fyh06Al4Al5pm22ORA6wm9O9ZFU67
 rttrlE43Uwd7Ma3wP5wB1OPpVqJF5n7ODZu9vdse98K4U=



=E5=9C=A8 2024/3/16 06:09, Roland =E5=86=99=E9=81=93:
> Hello,
>
> can someone explain why compression is skipped when writing with
> direct-i/o ?

Because compression only happen with buffered write.

For direct IO we either go NOCOW or regular COW, no compression support.

The current compression code is always using page cache, just check the
different algo implementations of btrfs_compress_pages(), which all
fetch their data from page cache.

E.g. in zstd_compress_pages(), we go find_get_page() to grab the page
from page cache as compression source.

This is incompatible with the direct IO scheme, which is designed to
avoid page cache completely (unless fall back to buffered write).

Maybe it's possible to make all those *_compress_pages() to support
direct IO, but that doesn't looks sane to me.

As the idea of direct IO is to fully avoid page cache, and allow the
user space program to take full control of its own cache, doing
compression would introduce extra latency and make the performance
characteristic much complex to user space.

Thanks,
Qu

>
> is this to be expected ?
>
> i wondered why i got uncompressed raw disk images in proxmox after disk
> migration to btrfs fs with compress-force=3Dzstd, so i tried with dd if =
i
> can reproduce - and i can.
>
> the problem is, that i cannot seem to disable direct I/O for different
> proxmox gui actions, will discuss in proxmox community what can be done,
> but i need more infos on this behaviour.
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
> if=3Ddisk.raw of=3Dtest.dat bs=3D1024k
> 20480+0 Datens=C3=A4tze ein
> 20480+0 Datens=C3=A4tze aus
> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 46,411 s, 463 MB/s
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
> compsize test.dat
> Processed 1 file, 161844 regular extents (161844 refs), 0 inline, 85412
> fragments.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7%=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1.5G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 339M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M
> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6%=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.2G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 19G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19G
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
> if=3Ddisk.raw of=3Dtest.dat oflag=3Ddirect bs=3D1024k
> 20480+0 Datens=C3=A4tze ein
> 20480+0 Datens=C3=A4tze aus
> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 161,319 s, 133 MB/s
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
> compsize test.dat
> Processed 1 file, 20480 regular extents (20480 refs), 0 inline, 1035
> fragments.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
>
> furthermore,=C2=A0 with qemu/proxmox virtual disk live migration, i'm ge=
tting
> reproducible checksum error with btrfs/compress-force=3Dzstd when live
> migrating virtual disk within same harddisk , whereas copying the same
> disk/file with dd (cached and direct) does not trigger that.
>
> happens on hdd and also on hdd, so this seems not to be disk related
>
> # uname -a
> Linux pve-test1 6.5.13-1-pve #1 SMP PREEMPT_DYNAMIC PMX 6.5.13-1
> (2024-02-05T13:50Z) x86_64 GNU/Linux
>
> regards
> Roland
>
>
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): csum failed =
root
> 260 ino 257 off 6655332352 csum 0x5517115a expected csum 0x6b2af31e
> mirror 1
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): direct IO fa=
iled
> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): csum failed =
root
> 260 ino 257 off 6655332352 csum 0xd1d1c892 expected csum 0x0c24b5cd
> mirror 1
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): direct IO fa=
iled
> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): csum failed =
root
> 260 ino 257 off 6655332352 csum 0x809096c2 expected csum 0x56b58dc6
> mirror 1
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): direct IO fa=
iled
> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): csum failed =
root
> 260 ino 257 off 6655332352 csum 0xc8a6977d expected csum 0xdfc1f678
> mirror 1
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): direct IO fa=
iled
> ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): csum failed =
root
> 260 ino 257 off 6655332352 csum 0x20ff0887 expected csum 0x08ed0bce
> mirror 1
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS error (device sdc1): bdev /dev/sdc1
> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): direct IO fa=
iled
> ino 257 op 0x0 offset 0x18cb02000 len 16384 err no 10
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): csum failed =
root
> 256 ino 290 off 6655332352 csum 0xb023863a expected csum 0x4f8e355d
> mirror 1
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS error (device sdc1): bdev /dev/sdc1
> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): direct IO fa=
iled
> ino 290 op 0x0 offset 0x18cb05000 len 4096 err no 10
>
> create full clone of drive scsi0
> (btrfs-ssd-zstd-qcow2:106/vm-106-disk-0.raw)
> drive mirror is starting for drive-scsi0
> drive-scsi0: transferred 34.2 MiB of 20.0 GiB (0.17%) in 0s
> drive-scsi0: transferred 301.6 MiB of 20.0 GiB (1.47%) in 1s
> drive-scsi0: transferred 489.1 MiB of 20.0 GiB (2.39%) in 2s
> drive-scsi0: transferred 679.9 MiB of 20.0 GiB (3.32%) in 3s
> drive-scsi0: transferred 1.1 GiB of 20.0 GiB (5.70%) in 4s
> drive-scsi0: transferred 1.4 GiB of 20.0 GiB (6.89%) in 5s
> drive-scsi0: transferred 1.7 GiB of 20.0 GiB (8.55%) in 6s
> drive-scsi0: transferred 1.9 GiB of 20.0 GiB (9.53%) in 7s
> drive-scsi0: transferred 2.2 GiB of 20.0 GiB (10.97%) in 8s
> drive-scsi0: transferred 2.4 GiB of 20.0 GiB (11.84%) in 9s
> drive-scsi0: transferred 2.8 GiB of 20.0 GiB (13.89%) in 10s
> drive-scsi0: transferred 2.9 GiB of 20.0 GiB (14.74%) in 11s
> drive-scsi0: transferred 6.2 GiB of 20.0 GiB (31.14%) in 12s
> drive-scsi0: transferred 8.2 GiB of 20.0 GiB (41.17%) in 13s
> drive-scsi0: transferred 10.3 GiB of 20.0 GiB (51.27%) in 14s
> drive-scsi0: transferred 10.5 GiB of 20.0 GiB (52.75%) in 15s
> drive-scsi0: transferred 19.2 GiB of 20.0 GiB (95.86%) in 16s
> drive-scsi0: transferred 19.3 GiB of 20.0 GiB (96.66%) in 17s
> drive-scsi0: transferred 19.5 GiB of 20.0 GiB (97.46%) in 18s
> drive-scsi0: transferred 19.7 GiB of 20.0 GiB (98.27%) in 19s
> drive-scsi0: transferred 19.8 GiB of 20.0 GiB (99.08%) in 20s
> drive-scsi0: Cancelling block job
> drive-scsi0: Done.
> TASK ERROR: storage migration failed: block job (mirror) error:
> drive-scsi0: 'mirror' has been cancelled
>
>

