Return-Path: <linux-btrfs+bounces-1437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F382CF75
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 03:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD51F21C8B
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191E15C6;
	Sun, 14 Jan 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oftQXwZk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65178EC5
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705197856; x=1705802656; i=quwenruo.btrfs@gmx.com;
	bh=CpfgLEGG6pxKig0VDtLdNz0CkKf+jAp+PptmBvbHaRw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=oftQXwZkaMD3FNtec/H7dUGr2t97V9xEiQ0b5haYuvOPQXYXuqCNJ7VCyVYdFkCG
	 KxyY/nwDvQ9Lg68ykr9OdkmeNskZAWzbga0MDIv8d8hslAYAXbXI0YyxdgDCW7fuB
	 apBl0EDjH7A8PnaMPEJSjCbXbz9hOoZB9xYc4Fpek8Urj69GbYwWurNWDeAlON/p7
	 w8xil50U0AJ1NPOArd2G/heCqHG/+fok9juow+E71VSV481FsvgirYnyWGynaRtK3
	 NxtARyC/oe6+6gkTVcwxC3OC/UyschsEhfXXJ7OLyPRoIpZW7fjzULgNvxGLpIP+i
	 Yx73GzxEr3l6a8Jrew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1rO0mJ0QAl-000rUq; Sun, 14
 Jan 2024 03:04:16 +0100
Message-ID: <8a89a5cf-8d10-4737-bebf-f60f89dacf9b@gmx.com>
Date: Sun, 14 Jan 2024 12:34:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
To: Qu Wenruo <wqu@suse.com>, Rongrong <i@rong.moe>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
 <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
 <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
 <2e275902-dc1c-41b1-b1fb-998f7fd16de3@gmx.com>
 <0de1265ff914ff0fa772fad548c329c6d7f280b3.camel@rong.moe>
 <31a6c044-1540-4345-9504-2234f93aa150@suse.com>
 <3e0ba2b7-bbe6-448f-b4d2-2e7dde291735@gmx.com>
Content-Language: en-US
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
In-Reply-To: <3e0ba2b7-bbe6-448f-b4d2-2e7dde291735@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qfxFchcdzJu+h4NsT+04bXqd/M3cFt18sbeEKT3C4w/meMZBvQY
 GzCR5PEbY75IkbmDgOMSWFd1Ppn40g2ceTOoq/XrUGNj0vIciBzUWNwJUtckY5hgfxE4fgo
 xLAOU/A1fyiz67akVOJ8kFebyhbzy4s/e9BsyaYblOYQNxlX52FTp24+61l5YFhTvKxZnln
 DIBGEMxIio68DBj5de2LQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4mfYzaBn+xo=;jj3tjhqU6hT4Ybtx7KObmHDsvEA
 BRc/DrkDuP6W8os+rYydNknApG66QDDnAsXA7RDurg1ODtQoF6f12wpNPAkfFZOyaGmeJmrQ2
 ZmcAQAPUJDy2Q8nUHKQr8EEwTchFvwu8aGEoeJMFsAL8TnRBLH8oPZ2T06seG575EfOspZ3bD
 IcZVHkGpK3hy2gZcw5TpNjQsWmBNdyBzW+yRNZ4pM4AOO4kUPe8RdylrrV+EvQKUoQmL3raMU
 DAXz+z6QCrkPqhf6LaqzE2gK8LFXLKxOHHZYRZKhI0j0UbcdrWW/lqY7vbZZ1BrlRfF0C+xNw
 WQqc5UBw+GYaEamIvHxPvm1nYKmCDQLt8H69gQKBOZIB/n/NiER3AkM+8EbUNldto4LXUu3mM
 5s4vOpMd0PzI2xr2L60/+5+d+U4ytTOzyjAF3Uuj7Y4VtmubW9VhF7pDrKA0skjHB7u9DKKr3
 Btdm9i13mHnEGqXho9kyhew9NnqxHnHgdLiMDqhv58DpYOab8N7paqCF20bycznfeRUF0XO92
 QeYFz+wXcaxF6ZToWThN4W4p057T4On1OkTwIHltWFQmCYg7B3MWu8qauxq5G3qOgU3C6NvpY
 q7JZWM35jJEVumZ/6SkFaXkhb53LACYR3m73TfPnR7ZeXUW7ciVIYAEWb+XWuUhiQOwgOlfV6
 9TYhQCgBbjoRmlLbbix2Hb5Lr3tAHuOTO5CigUc9JSuhfcu4ivxnU2IeOTzZSND8C+UHfCgOd
 18dxJMUypgAN3fgQYeQzk4HqEbIQ+PNM+oAkHzhFR5MrVI4vJ7i4CaYtCYRgHy0d8ZXpEoYI0
 SxlQhaHD2vgiIQWhab3ylYzOK73Ho2xErgW5jKmz0bqCXhier8z0ax4Q1Kx+Qw/U9wT2aBwst
 ueh52n1zBGcwdv9j3cfa4/Y3yRs9QIXvSfhiVg/H5AiGFL3DgPofFtys+MqNjKtVR+3SZIPFK
 fgFIMuzV3xm54Y21wHmlsm6fPjI=

Hi Rongrong,

Mind to test this branch against your image dump?
https://github.com/adam900710/linux/tree/scrub_beyond_chunk_fixes

For this branch, you do not need to apply to patch to disable blk plug.
As the crash is caused by bad scrub read endio (which can not handle any
unexpected bio split, thus leads to use-after-free).

Thanks,
Qu

On 2024/1/14 08:10, Qu Wenruo wrote:
>
>
> On 2024/1/14 07:38, Qu Wenruo wrote:
>>
>>
>> On 2024/1/14 05:52, Rongrong wrote:
>>> On Fri, 2024-01-12 at 20:23 +1030, Qu Wenruo wrote:
>>>>
>>>> On 2024/1/12 18:08, Rongrong wrote:
>>>>> Hmm, let me recall...
>>>>> Seeing the mtime of files above, I just remembered that:
>>>>> The fs was converted from ext4 using btrfs-convert.
>>>>
>>>> This explains why the chunk bytenr are not aligned to 64K.
>>>>
>>>> If you dump the chunk tree (`btrfs ins dump-tree -t chunk`), you can
>>>> see
>>>> all the chunks and their bytenr.
>>>>
>>>> I believe there are quite some chunks not aligned to 64K boundary.
>>>> Mind to provide the chunk tree dump of the fs (before the full
>>>> balance).
>>>
>>> Sure, in attachment.
>>
>> Thanks a lot, the chunk dump explains why the problem happens.
>>
>> With the initial KASAN backtrace:
>>
>> [=C2=A0 171.700526] BTRFS critical (device vdb): unable to find chunk m=
ap for
>> logical 2214744064 length 4096
>> [=C2=A0 171.700738] BTRFS critical (device vdb): unable to find chunk m=
ap for
>> logical 2214744064 length 45056
>> [=C2=A0 171.700951]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [=C2=A0 171.700962] BUG: KASAN: slab-use-after-free in
>> __blk_rq_map_sg+0x18f/0x7c0
>>
>> The first bytenr which hit not chunk map is 2214744064.
>>
>> And checking the chunk map, it is out of the boundary of the data chunk=
:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2=
214658048) itemoff 16025
>> itemsize 80
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length 86016 owner 2 s=
tripe_len 65536 type DATA|single
>>
>> This data chunk ends at bytenr 2214744064 (exclusive).
>>
>> My believe is, the use-after-free is caused by the fact that
>> btrfs_map_bio() code is doing extra split, and by somehow the error
>> cleanup is not properly done.
>>
>> Thus the direct cause is some bad error handling in btrfs bio layer, bu=
t
>> the root cause is the new scrub code is not handling the unaligned part
>> of the chunk.
>>
>> The fix would come in 3 parts:
>>
>> - Fix the btrfs bio layer error handling if part of the bio crossed
>> =C2=A0=C2=A0 chunk boundary
>>
>> - Fix the scrub code to make sure the tailing part won't go beyond chun=
k
>> =C2=A0=C2=A0 boundary
>
> This would be merged into one patch.
>
> It turns out that btrfs bio layer is doing its work correctly, it's our
> endio function causing the problem.
>
> Thus only one thing to fix, and the fix can be crafted pretty simply.
>
> Thanks,
> Qu
>
>>
>> - Fix btrfs-convert to create 64K aligned chunks
>> =C2=A0=C2=A0 It looks like the existing btrfs-convert is only creating =
chunks that
>> =C2=A0=C2=A0 starts at 64K aligned address, but the end can still be un=
aligned.
>>
>> Meanwhile please keep a disk image, as we may need your help again in
>> verify the fixes.
>>
>> Thanks for all the detailed report!
>> Qu
>

