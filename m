Return-Path: <linux-btrfs+bounces-3379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EF87F45C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 01:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C331C21786
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 00:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED826A34;
	Tue, 19 Mar 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aUcqXoPL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA087EB
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806821; cv=none; b=enZH6jyvmUWXdlFObhvdOwLZLiRk5b7QQwZFiG/O1dyCI/PdMqGJoj9dFPtbj/w6LurtMEUo7Oe0KqtEWkkcqN7J5cd0MqXzDLYefNUnbBDQGz2nVEODL1hA2y1ZLsmBjQMDvs1TjE7qBsSAdn9/fBWl0kBiG3uulCr6LiS5SGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806821; c=relaxed/simple;
	bh=Yuc3Ix7LoBQuP3nw1Y+CRbnO1zzGPKQtgcfbJGFODtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FLU+nMEQr1exoBH1SwXyCsRcLba22JHNdS7tnfkTV3Xo4PqgcoAdHFRY45NYVbwKwGqpZs/Ik2yhmDPY8kSYWZiVk17iZivkXv/JioaL3Z2VxFTeCjis3+jbdNwVaav+mtxciJFaUcCOfQio/rFkSEgT/kDLS9UQRYuSIIZkXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aUcqXoPL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710806813; x=1711411613; i=quwenruo.btrfs@gmx.com;
	bh=WSqfDV7Bq2AK/2zZvuABYuCc3kAN6tl/+GjhK3JXtOU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=aUcqXoPLQv4oKd5VVz6BbPctiVBEu9lUp7/yp6v4BjnNXoG9wxphFEJptVF9w0w1
	 NnO1j1N4lPDeWJSe26wLDdVNzaV+uCbmzBiarbDnottPr72mdJqxh10eMqZnLAMTX
	 wTXJrrCEeQdT/wPf0F9XnWC0zpFMV5LfXj0tP8MhkYpOAsqJFBkvLJNJXriOM/sQx
	 yiwIvtNjV6eNLnICG42rhCjfaLs0egQ9gqXUFeCSGBPL+T/x4SOWrsXWEVXhM8aTc
	 w09JoEVGAhf1QVg9iKiP3EbeTE5E5mQG2vzMOzgz+yYk3i4t5Hgm5X0RupheWO/jW
	 wv+Y/746E/kJxvF12g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOA3P-1rOMtg0zcn-00OXbv; Tue, 19
 Mar 2024 01:06:53 +0100
Message-ID: <e52a27e8-3b6f-4e33-bf0b-a225d7681454@gmx.com>
Date: Tue, 19 Mar 2024 10:36:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help requested: btrfs can't read superblock
Content-Language: en-US
To: kind.moon1862@fastmail.com, linux-btrfs@vger.kernel.org
References: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
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
In-Reply-To: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3RwLIPniQWy5LYf+9kg38H0AlypVAgvXyx5gIxq8x4+cO9NRamM
 y37VgOvNwCWnjakVry8ezx9LF59G189V9E4UMNkN8Ivvk1yfWaHuZAWUSAYxqWdNfJ+Xkae
 JhIympWl6GhkFYzNPgf5GJthw48dLjoEn6t5vdPo6ifeiyfilgHzavCAH5imHNF8/uKyZQH
 yeqH1lxnF5aeaZiyUFKTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dGFsWR8fBBM=;Lk1F4P4+NuvF01+o4BaW3TuZzYQ
 IdwF3DDB3amlErYaZW21yLTuJ0OecazuXvU1UUfXBd/jpjhhFZI66En3KsydLGuC68xaYWl8i
 /EQwP3fWeG+QPcJoziq8Udius+Rl/04aQJT94gKXbWRm5F/tLujmbRTxikFSvqDu0PVwIGPKx
 fLRE93CLhC5JjdLJLpCFeL1mkMq6vpB0xE0Kgb3uIfiN2lWV+YCXanZ2q+3oa+bnCNl/AgGNf
 ddntatAQDts6HLLTZYqhQKmBre38e2XCv1wg2ULIzaA6jEpPd2AyWK2YUbj9/t8qd8tNpqmnG
 YBVtJAu4z9+8Uz4VAU29ogIMHcJRHSlcZ1LxHcjcJREEMZghD7R1qNIfgfXeZ953iWS4C6cpw
 kTU22qEBMINwyxr9h+Hz+eeNfZe4C3NIjj8E3TuTGAYFGpPW8GhjxHADY0HZNLRB7MgbNKQ7K
 lTCmzqUozDfpSGSv8KczyQXxo8JCcEEIjdAnrEG4OEPzXZxWh4YkFC9eLHNnRuJYMnmPV0ZDF
 cjkueU+qG0ULfQDZ+UjTvnoprTJHFZEN/+QhbtVHz+afTpeixjHVeoUy5PViHLRHz1wdEEyU2
 8huUl78W5hTf469ojZv+FTwehEmrEIT4GiP8d6NIk9zce9IiReeSWWPrXcy5XU6VRvi7I/YkV
 JGyIzLznW9RyxFByXO19Qn/WZZb94Cf84kTL1qO6KaBCRUmwfgSKem3sSeLrmraXj+s2iKO5k
 k4FLRllWXczTHuXkxJxvhlHs7zZO5gf34cLK7GuaVYfATA+qpr/jiPoN6sRqfLpE8dma8M9Y4
 QJ1+KacxGYgE8L40plCARn/tHk+Dvaj8Z0O5uZggFW6uE=



=E5=9C=A8 2024/3/19 07:52, kind.moon1862@fastmail.com =E5=86=99=E9=81=93:
>
> Dear btrfs team,
>
> I've been asked to help someone with a btrfs problem.  They use CentOS 7=
.  I've been told the host was shut down cleanly, but it won't mount a btr=
fs filesystem when powering on.
>
> Below is what I've done so far.  Any guidance would be appreciated!
>
> I booted using SystemRescue 11.0.  Some info about the rescue OS:
>
> # uname -a
> Linux sysrescue 6.6.14-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 26 Jan 2024 11:=
54:58 +0000 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v6.6.3
>
> Here are the disks:
>
> # btrfs fi show
> Label: '<redacted>'  uuid: 834b4bfd-fbd4-40b9-8868-d1187c3c5a63
> 	Total devices 4 FS bytes used 17.44TiB
> 	devid    1 size 9.10TiB used 8.94TiB path /dev/sda
> 	devid    2 size 9.10TiB used 8.94TiB path /dev/sdb
> 	devid    3 size 9.10TiB used 8.94TiB path /dev/sdc
> 	devid    4 size 9.10TiB used 8.94TiB path /dev/sdd
>
> I tried mounting:
>
> # mount -t btrfs -o recovery,ro /dev/sda /mnt/data
> mount: /mnt/data: can't read superblock on /dev/sda.
>         dmesg(1) may have more information after failed mount system cal=
l.

Use "mount -o rescue=3Dall,ro" instead.

>
> dmesg shows this:
>
> [ 1940.962632] BTRFS info (device sda): first mount of filesystem 834b4b=
fd-fbd4-40b9-8868-d1187c3c5a63
> [ 1940.962665] BTRFS info (device sda): using crc32c (crc32c-intel) chec=
ksum algorithm
> [ 1940.962686] BTRFS warning (device sda): 'recovery' is deprecated, use=
 'rescue=3Dusebackuproot' instead
> [ 1940.962692] BTRFS info (device sda): trying to use backup root at mou=
nt time
> [ 1940.962698] BTRFS info (device sda): disk space caching is enabled
> [ 1942.115796] BTRFS critical (device sda): corrupt leaf: root=3D2 block=
=3D11438351450112 slot=3D170, invalid key objectid, have 5822947745796 exp=
ect to be aligned to 4096

Bad extent item start bytenr, 5822947745796 =3D 0x54bc2bb6004, the last
0x004 looks like a bitflip.

Please run memtest to make sure your hardware memory is fine, or such
problem would just happen again and again.

Thankfully extent tree corruption is not a big deal for "rescue=3Dall,ro"
mount.

Thanks,
Qu

> [ 1942.115819] BTRFS error (device sda): read time tree block corruption=
 detected on logical 11438351450112 mirror 2
> [ 1942.116170] BTRFS critical (device sda): corrupt leaf: root=3D2 block=
=3D11438351450112 slot=3D170, invalid key objectid, have 5822947745796 exp=
ect to be aligned to 4096
> [ 1942.116183] BTRFS error (device sda): read time tree block corruption=
 detected on logical 11438351450112 mirror 1
> [ 1942.116212] BTRFS error (device sda): failed to read block groups: -5
> [ 1942.140369] BTRFS error (device sda): open_ctree failed
>
> I tried to recover the superblock:
>
> # btrfs rescue super-recover -v /dev/sda
>
> All Devices:
> 	Device: id =3D 3, name =3D /dev/sdc
> 	Device: id =3D 2, name =3D /dev/sdb
> 	Device: id =3D 4, name =3D /dev/sdd
> 	Device: id =3D 1, name =3D /dev/sda
>
> Before Recovering:
> 	[All good supers]:
> 		device name =3D /dev/sdc
> 		superblock bytenr =3D 65536
>
> 		device name =3D /dev/sdc
> 		superblock bytenr =3D 67108864
>
> 		device name =3D /dev/sdc
> 		superblock bytenr =3D 274877906944
>
> 		device name =3D /dev/sdb
> 		superblock bytenr =3D 65536
>
> 		device name =3D /dev/sdb
> 		superblock bytenr =3D 67108864
>
> 		device name =3D /dev/sdb
> 		superblock bytenr =3D 274877906944
>
> 		device name =3D /dev/sdd
> 		superblock bytenr =3D 65536
>
> 		device name =3D /dev/sdd
> 		superblock bytenr =3D 67108864
>
> 		device name =3D /dev/sdd
> 		superblock bytenr =3D 274877906944
>
> 		device name =3D /dev/sda
> 		superblock bytenr =3D 65536
>
> 		device name =3D /dev/sda
> 		superblock bytenr =3D 67108864
>
> 		device name =3D /dev/sda
> 		superblock bytenr =3D 274877906944
>
> 	[All bad supers]:
>
> All supers are valid, no need to recover
>
> I checked the filesystem:
>
> # btrfs check --readonly /dev/sda
> Opening filesystem to check...
> corrupt leaf: root=3D2 block=3D62421692628992 slot=3D7, bad key order, p=
rev (7275590123520 168 11227136) current (7258421481472 168 10948608)
> corrupt leaf: root=3D2 block=3D62421692628992 slot=3D7, bad key order, p=
rev (7275590123520 168 11227136) current (7258421481472 168 10948608)
> corrupt leaf: root=3D2 block=3D62421692628992 slot=3D7, bad key order, p=
rev (7275590123520 168 11227136) current (7258421481472 168 10948608)
> corrupt leaf: root=3D2 block=3D62421692628992 slot=3D7, bad key order, p=
rev (7275590123520 168 11227136) current (7258421481472 168 10948608)
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>
>

