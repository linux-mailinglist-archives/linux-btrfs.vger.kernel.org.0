Return-Path: <linux-btrfs+bounces-1255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC4824CF2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3359E286D4E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 02:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30328210F;
	Fri,  5 Jan 2024 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lGfzayTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDD20E4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704421933; x=1705026733; i=quwenruo.btrfs@gmx.com;
	bh=qAkJ+MIBozM3nceJH+zB0YpEkAD9PNrfm/aBbT4F980=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=lGfzayTMv5ylOkBnII2xs2f22YDl5Sdns1U8W/TuvgQxeoZjpEewJLLfNPPo46S7
	 r7Nc+V2Yaov5GkEiwYDkBrVngOR4PY+T4hP4mmvEs6kJortVbznv/+/Mmjmymf9gv
	 EeO+FDSY410tqGfmDYKKa8dbJKkwIlFRhFyYKJChO8/EhiqOyrt0HMdC4W3jqjQxy
	 hYmeuXSa8FJL5Ct2zRbi6OoKMNspHt9+J5x0yrEhKbnMI4Jwt9IpgRKugzuDLsB+M
	 ae5EYdp72KuU85C/RaIJk4JYoPzd2CptYILw9MP84KFOQj4ka+aZSa7V+HEhMdUDx
	 FqrBM7eK9bz4cUTViA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzFx-1rcpuH2Hw1-00HxJG; Fri, 05
 Jan 2024 03:32:13 +0100
Message-ID: <008c8c46-3940-4635-9a6a-155ad4c5370d@gmx.com>
Date: Fri, 5 Jan 2024 13:02:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS Broken, Help
Content-Language: en-US
To: Isaac Chang <isaacchang673@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAO0vF5EHAiLsVvi=tvERS4gS+AeGSDWHmZxcf-mBQtDaQ+UDBg@mail.gmail.com>
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
In-Reply-To: <CAO0vF5EHAiLsVvi=tvERS4gS+AeGSDWHmZxcf-mBQtDaQ+UDBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHhfuasDf40tpTnoq7sBpCQOm7ii1wf77mLWire4ABVLJU4zpb3
 4hIvV7po3YT3PxRQeIeIpB5IvtfNdDMZoRrFmTrcuvPLDKAvWL2H9GvQw242/4mQUTgGpxT
 3b8TFAkIJ2yuYCVSC58vM/8LOmz50AZbq18UvRV2YHJEmM5N7jYDcuCPlAaoC0Pvhxd+gsy
 NEy0h9Lg+7DyCSAOfU65w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1X77fE8w4f8=;KN3fvrgK5WiMNPBuUcj4xUi010F
 5hU3VqkSg+fBwdo2lYRKmjNrmfvMnfGT1UEe/dmqnryt8BQ9zW9caPfbLb3a7mKSDVySxa6fT
 hCBzvHPEWZjSeaDqnz1ZZCTk9cdaAzA32z+64oy3iaCWT0vPsvdL11MfWp7IhBezrmOXEFtAD
 Gixymik2j1w22p/jObAtpq05j0fbWcNhvSlNHdiBJSOvZxeHGJNVzagXeHYH7SaCc6z40XZfU
 FUrd26BULtOVDGgzGPGFgL7l6Ty1WFnCWQAjCeNGrUMOi9qxFHuiCiGtJURDLT4D3Cv1uq9fK
 KijNOnGi6THCbt0Ua8lv4JVcLDcZGaN44ApNxZWZLMith1Q3s4i3FKRjl/Vxqzg20KPogGK8N
 1ftC8RA+ZCFzK4eaCmff2+o3bETpATlJcpthcupEaBc4ajyAVBiKN+zfApmip0VDvD6q+S25M
 /WDPbfUmS+a+IMWXLl81L4PQu3DaK4Ssfrz2spZDxFYTdzHlO7Gtnd09PikGqiPsaTnIQqXzj
 bfog2XRGgM2Bve+jWiAebWFpYJ99z7HL/xPXyK41ik1FjfZ3QuH+Ks6+Ote4b82Epqo3hgydY
 lcvgcI7PKoIgi0SmiGHVxLzJfg0XALhqz4RKtdbQDO1JIFEu/Z0rdUbRuxJgGklsmu2Ed43BS
 oRpvk+BV7wBFqpmmoAClJFbj+f6KvRYx1Mjc9k6p5WWFf9683sR+j9hQ8nZIro6N6FZeL+MZm
 CKvUy9poirg1g6VCHLl4c02do566vQaYYyJkJsqOvsl2SkQZSsLD1jGs/MUSM35HBsHyWkfrq
 8SPu4jw0b6TiA0MEVtoXnnxOTl+iKCS2ztnXCgb0qA48DyrT8TLDUDd2JODBYuv7HPttw53sF
 nbJoQbELi1ZcaQD6113LND4lqfjrInb8N9xiHU1eXQ5R38BUAQxi3bS+UeOdInwcQuTxBzkZE
 G6cmyQ==



On 2024/1/5 02:14, Isaac Chang wrote:
> My Server blipped and upon reboot, the=C2=A0Cache Drives (pool of 2 devi=
ces
> RAID 0) are now unmountable. I can mount the lead disk in CLI and peruse
> the files but if I use MV or CP or rsync, I get Input/Output errors.
> BTRFS restore also yields Input/Output errors.
> Using the instructions here as this is an UNRAID server:
> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/#comment-=
543490 <https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/#co=
mment-543490>
>
>  =C2=A0root@Tower:/# uname -a
> Linux Tower 6.1.64-Unraid #1 SMP PREEMPT_DYNAMIC Wed Nov 29 12:48:16 PST
> 2023 x86_64 Intel(R) Xeon(R) CPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 L563=
8 =C2=A0@ 2.00GHz GenuineIntel
> GNU/Linux
> root@Tower:/# btrfs --version
> btrfs-progs v6.3.3
> root@Tower:/# btrfs fi df /temp
> Data, RAID0: total=3D887.40GiB, used=3D606.95GiB
> System, RAID1: total=3D32.00MiB, used=3D96.00KiB
> Metadata, RAID1: total=3D3.00GiB, used=3D1.05GiB
> GlobalReserve, single: total=3D117.83MiB, used=3D0.00B
> root@Tower:/# btrfs fi show
> Label: none =C2=A0uuid: 15b03357-29bc-43b0-bfbb-b306a3611d8f
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 408.00KiB
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 1.00GiB used 126.=
38MiB path /dev/loop2
>
> Label: none =C2=A0uuid: b53ef962-5a9b-4c35-98a3-33ff77ebaac5
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 2 FS bytes used 608.00GiB
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 465.76GiB used 44=
6.73GiB path /dev/sdg1
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A02 size 0 used 0 path =C2=
=A0MISSING

One of your disk is missing.

In fact that disk (ata5) is dead:

[ 7517.440956] ata5.00: exception Emask 0x0 SAct 0x40000fff SErr 0x0
action 0x0
[ 7517.440967] ata5.00: irq_stat 0x40000001
[ 7517.440972] ata5.00: failed command: READ FPDMA QUEUED
[ 7517.440975] ata5.00: cmd 60/08:00:50:3f:61/04:00:38:00:00/40 tag 0
ncq dma 528384 in
                         res 41/04:b8:f9:3d:61/00:01:38:00:00/00 Emask
0x1 (device error)
[ 7517.440985] ata5.00: status: { DRDY ERR }
[ 7517.440988] ata5.00: error: { ABRT }

Which failed to do a basic read.

You can try mount with "ro,rescue=3Dall,degraded" to salvage whatever you
still have.

Thanks,
Qu
>
> ERROR: superblock checksum mismatch
> ERROR: cannot scan /dev/sdf1: Input/output error
>
>
> Attached is the dmesg output.
> Please let me know what I can do.
>
> Thank you!
>
> Isaac Chang

