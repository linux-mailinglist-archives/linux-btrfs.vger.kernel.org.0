Return-Path: <linux-btrfs+bounces-2602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678E85D3B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 10:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D70B24C96
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B023D0DB;
	Wed, 21 Feb 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Lqa0RA3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37933D0AF
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508019; cv=none; b=pVHwmI2B/fqYIc5oph2FgWGL17FjQ4brdPtfSFEl/QH8McS5PcfVsP+Ln4qt6uI7KINn/e1PJpzUnwNuZGoAgWjyub8bOYV+Xp/B97EiJqKE4NsCa5vE3tb/hvRSygM37LyU3qQzOIAvmURN10ALMRFztUc7IY8D7Eo/O8tUMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508019; c=relaxed/simple;
	bh=gQKdEl1SR+V/Yhn4oiSEsI3TYdOa3TfSnKpxndJJ5KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRnLOLZIcaOYn0WBeEMeRSc2XCm3EXLOAskFqMOTVl1a5gO5VRMXKxqhzGHY7MFeEBEyJ6b7G+/gzP07Va5mpzmGivdY7vd6JI13f9Cdr4reVxdggMO3P0dBYbkpYY2vh5FzVO+VFrvs9KJOCXU5hC69AwMuxIKXqF3N/ZNOI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Lqa0RA3E; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708508014; x=1709112814; i=quwenruo.btrfs@gmx.com;
	bh=gQKdEl1SR+V/Yhn4oiSEsI3TYdOa3TfSnKpxndJJ5KU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Lqa0RA3EXrTHHI5rH4oRt/kmJWqH9jJLiEUerr02PXn9z4JKJcMbJA1/qp6ZYSGh
	 PDKixcKVVN/GmMNJs9iW0nItCGByQXNQboe2kEg8M/do/Ow5Wvq4uISRzq+A0uzb7
	 euqujh0po7mGqdDb6kuoNFMZkYp1ryx9o/LPiPWnT6PgBv0iLINYUtYT1qCYTw3aN
	 38vrg2e7FOzBwylUGHb17sus9IPY84ns2pThHMvIh5n7jRfLgOsaP2StCcuwMKqt2
	 TnbkWSvyZy6F5mDVrFMTv0l/ykUg4K5UpDh9j1J2NEfCukVPg1DfkIL+1E8bmLFkt
	 yFE8hHs2/YyUHSdIEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1rFqmH13Q7-00Nz10; Wed, 21
 Feb 2024 10:33:34 +0100
Message-ID: <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
Date: Wed, 21 Feb 2024 20:03:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apply different compress/compress-force settings on different
 subvolumes ?
Content-Language: en-US
To: Roland <devzero@web.de>, linux-btrfs@vger.kernel.org
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
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
In-Reply-To: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lXuY+gXUuypKTpHyPYZnFGOXZPPD0pC6/7gkGOOztA1Jgain4+V
 NO6gNBkBWVfZSbbj5XZds5s42nnEEhUCK5bt852u9ymIR7/cu2+vdVGeMZdB+DkpHQzS9+s
 TlFhMDWAO0pin8OPpEKrYEYBMdda+V4iILnlj1xC3DxVFx57XDhemP/+YTo3J0XRCzNLGlv
 L30y6fOHNcaGtK0ILlW6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JUgYP6ajRmc=;x7WL9+XsZIBBpvkewKeHZ5VwRQL
 SZlY7hyVFtUY00Gi8P7ghCOfctkJ0sBZNzMxUTeqn+kAnTyQ7UH7Xyti9p7+vdOwY1CvByf6i
 ihTk6Zm9hQi5EOUcCmAb35K4e4TCp8WPuEqkPSyZHui++1K3uc9OjUzT4pnbU6fuBr3p/1e42
 m+Nsfz+cMjjez05Zbru6NahpOZfAOqz4z0R4ARPy1ovnOOL0pLQ17f4ow2rtxfXyokS8/iqaU
 FAZUbtwTed4T6WDJIhbP6E/u67p+47X+JdjwMVnDzmOxkntwJNUcmwB8BJGix4WzxGp+Ob8Uv
 b+39+RSgefZv02tr1xOzWveXK9ldB8fP+/n3ncBVTz+jYEHKotgg/330edG9jtziYlkC3lwnB
 GO3ybIYmKfacGT3WYVH+A2VUK/F1ZIzca904fmGgj34aMz7YgqUWAU8quXIfBuEYzZ+W0uTsk
 32yXSvnsQRbIYBHWhWWqSYLzru4fixLKtwmeR3Rv5eP7DqiY7V2XbFIce+xZgDfOgvkjgr8Ou
 Z5a0UVCwJ+WJ88lN7Rhk/ecxwMS+d7uN79TYTgps0HwyuwRWMYLvu7j0ntVWN8IulfNVzSQpP
 gugMxFOORomAaVlZqF1sTRENtQIxrXAGXnyoyoTDzQAb7JiT9Qyzu4TWBjpKckL6ECdFJ3r0n
 +EWlMDE1PKGrKw30o/piKaRrpMO8m9NaqmLoCRrSknKEZLjCDAybq/npVzAwD13mPhRNLzHZD
 DxKXBfgdpqLX3KaCgtbyEioPmy5XnSTvbuk/Zi7WbqQ9t7rjDky14oIZ/FY6yychbY3ufzvsk
 7uKjfiQh7hal/xq2EProXiu5957YU+hEh8OmKPsdOxZMw=



=E5=9C=A8 2024/2/21 19:19, Roland =E5=86=99=E9=81=93:
> hello,
>
> what can be the reason , that multiple compress mount option do not work
> on subvolume level , i.e. it's always the first that wins ?

In that case, you may want to use "btrfs prop" subcommand to setup
compression for each subvolume.

The mount option one is really affecting the whole filesystem.

>
> and why is compress-force silently ignored? (see below)

Compress-force has no coresponding per-inode prop option though.

But I don't think compress-force would cause much difference against
regular compress.

>
> regarding compress mount option, it seems that this can be overriden via
> subvolume property, which can work around the problem and have multiple
> compression settings.
>
> but how to fix compress-force in the same way, i.e. how can we have
> differenty compress-force settings with one btrfs fs ?
>
> wouldn't it make sense to introduce compress-force property for this ?
>
> what about replacing compress with compress-force (i.e. make it the
> default), as there is not much overhead with modern/fast cpu ?
>
> i think compress-force / compress is VERY confusing from and end user
> perspective - and even worse, i have set "compress" on a subvolume used
> for virtual machines and they do not get compressed at all (not a single
> bit) . so i think, compress option is pretty short-sighted and not, what
> an average user would expect (
> https://marc.info/?l=3Dlinux-btrfs&m=3D154523409314147&w=3D2 )

IIRC compress prop needs to be set to all inodes.
If you set it on a directory, only new inodes would inherit the prop,
the existing ones won't get the new prop.

Thanks,
Qu
>
> i'd be happy on some feedback. not subscribed to this list, so please CC=
.
>
> roland
>
>
> zstd compression applied to all subvolumes, though specified otherwise:
>
> cat /etc/fstab|grep btrfs
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
> subvol=3Dnone,compress=3Dnone,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>
> mount|grep btrfs
> /dev/sdb1 on /btrfs/zstd type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D259,subvol=3D/zstd)
> /dev/sdb1 on /btrfs/lzo type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D257,subvol=3D/lzo)
> /dev/sdb1 on /btrfs/none type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D258,subvol=3D/none)
> /dev/sdb1 on /btrfs/zstd-force type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D260,subvol=3D/zstd-force)
>
>
> different order in fstab has different result - first wins:
>
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
> subvol=3Dnone,compress=3Dnone,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>
> /dev/sdb1 on /btrfs/lzo type btrfs
> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D257,subvol=3D/lzo)
> /dev/sdb1 on /btrfs/zstd type btrfs
> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D259,subvol=3D/zstd)
> /dev/sdb1 on /btrfs/none type btrfs
> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D258,subvol=3D/none)
> /dev/sdb1 on /btrfs/zstd-force type btrfs
> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D260,subvol=3D/zstd-force)
>
>
> compress-force silently ignored:
>
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
> subvol=3Dnone,compress=3Dnone,defaults 0 1
> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>
> /dev/sdb1 on /btrfs/zstd type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D259,subvol=3D/zstd)
> /dev/sdb1 on /btrfs/lzo type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D257,subvol=3D/lzo)
> /dev/sdb1 on /btrfs/none type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D258,subvol=3D/none)
> /dev/sdb1 on /btrfs/zstd-force type btrfs
> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subv=
olid=3D260,subvol=3D/zstd-force)
>
>
>
> this is the write speed i get with compress-force=3Dzstd on i7-7700
>
> # dd if=3D/dev/zero of=3Dtest.dat bs=3D1024k count=3D10240 ;time sync
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB, 10 GiB) copied, 3.76111 s, 2.9 GB/s
>
> real=C2=A0=C2=A0=C2=A0 0m0.224s
> user=C2=A0=C2=A0=C2=A0 0m0.000s
> sys=C2=A0=C2=A0=C2=A0 0m0.081s
>
>
>

